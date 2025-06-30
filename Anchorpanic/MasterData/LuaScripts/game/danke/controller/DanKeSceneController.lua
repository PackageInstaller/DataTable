-- @FileName:   DanKeSceneController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-24 20:37:52
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.controller.DanKeSceneController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.DANKE_GAME_START, self.onStartGame, self)
    GameDispatcher:addEventListener(EventName.DANKE_COLLIDER_EIXT, self.onColliderExit, self)
    GameDispatcher:addEventListener(EventName.DANKE_COLLIDER_STAY, self.onColliderStay, self)
    GameDispatcher:addEventListener(EventName.DANKE_COLLIDER_ENTER, self.onColliderEnter, self)
    GameDispatcher:addEventListener(EventName.DANKE_RANDOM_PLAYERSKILL, self.onSelectSkill, self)
    GameDispatcher:addEventListener(EventName.DANKE_GAME_AGIN, self.onPlayAgin, self)
    GameDispatcher:addEventListener(EventName.DANKE_GAME_OVER, self.onGameOver, self)

    GameDispatcher:addEventListener(EventName.DANKE_MONSTER_DIE, self.onMonsterDie, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()

end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)

    self:clearData()
    self:initScene()
end

function onPlayAgin(self)
    self:clearData()

    self:initScene()
end

function onGameOver(self)
    self.m_dupTime = 0

    self.m_curStageConfigVo = nil
    self.m_layers = nil

    self:clearThing()
    self:removeColliderManger()
    self:clearCamera()
    self:clearTimeSn()
    self:clearEffect()

    GameDispatcher:dispatchEvent(EventName.CLOSE_DANKE_SCENEUI)
end

function initScene(self)
    self.m_layers = {}

    for layerName, layerSortIndex in pairs(DanKeConst.SpriteSortingLayerIndex) do
        local node = gs.GameObject.Find(layerName)
        self.m_layers[layerName] = {node = node.transform, object = {}, sortIndex = layerSortIndex}
    end

    self.m_curStageConfigVo = danke.DanKeManager:getCurStageVo()
    if self.m_curStageConfigVo then
        local map_id = self.m_curStageConfigVo.map_id
        self.m_mapConfig = danke.DanKeManager:getSceneConfigVo(map_id)
    end

    if self.m_mapConfig then
        local gridSize = 5.12
        local start_PosX = self.m_mapConfig.max_row / 2 * gridSize * -1
        local start_PoxY = self.m_mapConfig.max_col / 2 * gridSize

        self.m_gridMapList = {}
        for row, col_gird in pairs(self.m_mapConfig.grid_list) do
            for col, _grid in pairs(col_gird) do
                local grid = gs.GameObject(row .. "_" .. col)

                if _grid.is_obstacle then
                    local boxCollider = grid:AddComponent(ty.BoxCollider)
                    boxCollider.size = gs.Vector3(5.12, 5.12, 0.1)
                end

                local sprite = grid:AddComponent(ty.SpriteRenderer)
                sprite.sprite = gs.ResMgr:LoadSprite(string.format("arts/sceneModule/danke/texture/%s", _grid.grid_res))

                gs.TransQuick:SetParentOrg(grid.transform, self.m_layers.scene_layer.node)
                gs.TransQuick:LPos(grid.transform, start_PosX + col * gridSize, start_PoxY - row * gridSize, 0)
                grid.layer = gs.LayerMask.NameToLayer("AirWall")

                table.insert(self.m_gridMapList, grid)
            end
        end
    end

    for k, colliderTag in pairs(DanKeConst.ColliderTag) do
        self.m_thingDic[colliderTag] = {}
    end

    self:addColliderManger()
    self:createPlayerThing()
    self:initCamera()
end

function selectSkill(self, skillConfigVo_list)
    local skillVo_list = {}
    for i = 1, #skillConfigVo_list do
        local skillVo = danke.DanKePlayerSkillVo:poolGet()
        skillVo:setData(skillConfigVo_list[i])

        local playerThing = self:getPlayerThing()
        if playerThing then
            local skill = playerThing:getSkill(skillConfigVo_list[i].tid)
            if skill then
                local dataVo = skill:getDataVo()
                if dataVo then
                    skillVo.level = dataVo:getLevel()
                    skillVo:addLevel()
                end
            end
        end

        table.insert(skillVo_list, skillVo)
    end

    if table.empty(skillVo_list) then
        return
    end

    local closeCall = function ()
        self.m_selectCount = self.m_selectCount - 1

        if self.m_selectCount <= 0 then
            return false
        end

        self:onSelectRandomSkill()
        return true
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_DANKE_SKILL_SELECTPANEL, {skill_list = skillVo_list, closeCall = closeCall})
end

function onSelectRandomSkill(self)
    local skillConfig_list = self.m_curStageConfigVo:getRandomSkill()
    self:selectSkill(skillConfig_list)
end

function onSelectSkill(self)
    self.m_selectCount = self.m_selectCount + 1
    if self.m_selectCount > 1 then
        return
    end

    self:onSelectRandomSkill()
end

function onStartGame(self)
    --初始技能选择
    local skillConfig_list = self.m_curStageConfigVo:getInitSkill()

    self.m_selectCount = 1
    self:selectSkill(skillConfig_list)

    --游戏时间
    self.m_dupTime = 0
    self.m_checkNormalMonsterTime = -0.5 --检测普通怪
    self.m_checkEliteMonsterTime = -1--检测精英怪

    self:clearTimeSn()
    self:refreshDupTime()
    self.mFrameSn = LoopManager:addFrame(1, -1, self, self.refreshDupTime)
end

function refreshDupTime(self)
    self.m_dupTime = self.m_dupTime + LoopManager:getDeltaTime()

    GameDispatcher:dispatchEvent(EventName.DANKE_REFRESH_GAMETIME, self.m_dupTime)

    self:checkMonster()
end

function clearTimeSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function onMonsterDie(self, monster_id)
    if self.m_curStageConfigVo then
        local monster_configVo = danke.DanKeManager:getMonsterConfigVo(monster_id)
        if monster_configVo then
            if monster_configVo.type == DanKeConst.MonsterType.Elite then
                if self.m_curStageConfigVo.key_monster == monster_id then
                    GameDispatcher:dispatchEvent(EventName.DANKE_ONREQ_PASSSTAGE, monster_id)
                end
            end
        end
    end
end

------------------------------------碰撞管理器
function addColliderManger(self)
    self.m_colliderMgr = danke.DanKeColliderManager:new()

end

function removeColliderManger(self)
    if self.m_colliderMgr then
        self.m_colliderMgr:clearData()
        self.m_colliderMgr = nil
    end
end

function onColliderEnter(self, args)
    if self.m_colliderMgr then
        self.m_colliderMgr:addCollider(args)
    end
end

function onColliderStay(self, args)
    if self.m_colliderMgr then
        self.m_colliderMgr:addCollider(args, true)
    end
end

function onColliderExit(self, args)
    if self.m_colliderMgr then
        self.m_colliderMgr:removeCollider(args)
    end
end

---------------------------------------------------创建场景事件
------------------------------------主角
function createPlayerThing(self)
    if gs.Application.isEditor then
        danke.DanKePlayerThing = require("game/danke/manager/thing/DanKePlayerThing")
    end

    local map_id = self.m_curStageConfigVo.map_id
    local mapConfig = danke.DanKeManager:getSceneConfigVo(map_id)
    if mapConfig then
        local layer = self.m_layers.player_layer

        local hero_id = mapConfig.hero_id
        local heroConfig = danke.DanKeManager:getHeroConfigVo(hero_id)
        local playerThing = danke.DanKePlayerThing:create({parent = layer.node, config = heroConfig, id = hero_id}, function ()
            GameDispatcher:dispatchEvent(EventName.OPEN_DANKE_SCENEUI)

            UIFactory:closeForcibly()
        end)

        playerThing:setSortIndex(layer.sortIndex)

        self.m_thingDic[DanKeConst.ColliderTag.Player][playerThing.m_snId] = playerThing
    end
end

function getPlayerThing(self)
    for _, thing in pairs(self.m_thingDic[DanKeConst.ColliderTag.Player]) do
        return thing
    end
end

------------------------------------怪物
function checkMonster(self)
    --普通怪0.5秒检测一次、精英怪包括Boss一秒检测一次
    if self.m_dupTime - self.m_checkNormalMonsterTime >= 0.5 then
        local mon_list = self.m_mapConfig:getMonster_list(self.m_dupTime, 1)
        for _, mon in pairs(mon_list) do
            self:checkNormalMonster(mon.monster_id, mon.distance)
        end
        self.m_checkNormalMonsterTime = self.m_dupTime
    end

    if self.m_dupTime - self.m_checkEliteMonsterTime >= 1 then
        local mon_list = self.m_mapConfig:getMonster_list(self.m_dupTime)
        for _, mon in pairs(mon_list) do
            self:checkEliteMonster(mon.monster_id, mon.distance)
        end
        self.m_checkEliteMonsterTime = self.m_dupTime
    end
end

function checkEliteMonster(self, monster_list, radius)
    local layer = self.m_layers.boss_layer
    local angle = 0
    self.m_randomPosCount = 0

    for _, monster_id in pairs(monster_list) do
        local pos = self:getRandow_Pos(radius)
        --pos为空的话，代表没有空位可以放下怪物，等待下次生成
        if pos then
            local monsterConfigVo = danke.DanKeManager:getMonsterConfigVo(monster_id)

            if gs.Application.isEditor then
                danke.DanKeMonsterThing = require("game/danke/manager/thing/DanKeMonsterThing")
            end
            local monster = danke.DanKeMonsterEliteThing:create({parent = layer.node, config = monsterConfigVo, bron_pos = pos})

            local sortIndex = layer.sortIndex + 500
            monster:setSortIndex(sortIndex)

            self.m_thingDic[DanKeConst.ColliderTag.Elite_Monster][monster.m_snId] = monster

            GameDispatcher:dispatchEvent(EventName.DANKE_ELITEMONSTER_SHOW, monster.m_snId)
        end
    end
end

function checkNormalMonster(self, monster_list, radius)
    local createEnemyCount = self.m_mapConfig.max_enemyCount - table.nums(self.m_thingDic[DanKeConst.ColliderTag.Normal_Monster])
    if createEnemyCount > 0 then
        local layer = self.m_layers.monster_layer
        local angle = 0
        for i = 1, createEnemyCount do
            self.m_randomPosCount = 0

            local pos = self:getRandow_Pos(radius, true)
            --pos为空的话，代表没有空位可以放下怪物，等待下次生成
            if pos then
                local random = math.random(1, #monster_list)
                local monster_id = monster_list[random]
                local monsterConfigVo = danke.DanKeManager:getMonsterConfigVo(monster_id)

                if gs.Application.isEditor then
                    danke.DanKeMonsterThing = require("game/danke/manager/thing/DanKeMonsterThing")
                end

                local monster = danke.DanKeMonsterThing:create({parent = layer.node, config = monsterConfigVo, bron_pos = pos})

                local sortIndex = layer.sortIndex + i
                monster:setSortIndex(sortIndex)

                self.m_thingDic[DanKeConst.ColliderTag.Normal_Monster][monster.m_snId] = monster
            end
        end
    end
end

--获取一个圆弧上的随机位置
function getRandow_Pos(self, radius, check_overlap)
    self.m_randomPosCount = self.m_randomPosCount + 1

    local random_angle = math.random(0, 360) * gs.Mathf.Deg2Rad
    local pos = gs.Vector3(gs.Mathf.Cos(random_angle) * radius, gs.Mathf.Sin(random_angle) * radius, 0) + self:getPlayerThing():getPosition()
    if check_overlap then
        local overlap = self:checkMonsterPosIsOverlap(pos, id)
        if overlap then
            if self.m_randomPosCount >= self.m_mapConfig.max_enemyCount then
                return nil
            else
                return self:getRandow_Pos(radius)
            end
        end
    end
    pos.z = 0
    return pos
end

--是否有重叠
function checkMonsterPosIsOverlap(self, pos)
    for k, monster in pairs(self.m_thingDic[DanKeConst.ColliderTag.Normal_Monster]) do
        if math.abs(gs.Vector3.Distance(monster:getPosition(), pos)) <= 0.6 then
            return true
        end
    end

    return false
end

------------------------------------掉落物
function createDrop(self, drop_id, pos)
    local layer = self.m_layers.props_layer

    local dropConfigVo = danke.DanKeManager:getDropConfigVo(drop_id)
    if dropConfigVo.type == DanKeConst.Drop_type.Exp then
        local playerThing = danke.DanKeSceneController:getPlayerThing()
        if playerThing:isMaxLevel() then
            return
        end
    end

    local dropThing = danke.DanKeDropThing:create({config = dropConfigVo, parent = layer.node, bron_pos = pos})
    local sortIndex = layer.sortIndex + table.nums(self.m_thingDic[DanKeConst.ColliderTag.Drop])
    dropThing:setSortIndex(sortIndex)

    self.m_thingDic[DanKeConst.ColliderTag.Drop][dropThing.m_snId] = dropThing
end

------------------------------------主角子弹
function createPlayerBullet(self, skill_type, skill_subType, data)
    if skill_type == DanKeConst.PlayerSkill_Type.Initiative then
        local bullet = nil
        if skill_subType == DanKeConst.PlayerSkill_SubType.FlyKnife then
            bullet = danke.DankeBulletFlyKnife:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.Shield then
            bullet = danke.DankeBulletShield:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.Magnetic then
            bullet = danke.DankeBulletMagnetic:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.Whip then
            bullet = danke.DankeBulletWhip:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.Bumerang then
            bullet = danke.DankeBulletBumerang:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.FireBomb then
            if data.is_bullet then
                bullet = danke.DankeBulletFireBom:setupPrefab(data)
            else
                bullet = danke.DankeBulletFire:setupPrefab(data)
            end
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.Potshoot then
            bullet = danke.DankeBulletPotShoot:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.Parabolic then
            bullet = danke.DankeBulletParabolic:setupPrefab(data)
        elseif skill_subType == DanKeConst.PlayerSkill_SubType.FallMine then
            bullet = danke.DankeBulletFallMine:setupPrefab(data)
        end

        if bullet then
            self.m_thingDic[DanKeConst.ColliderTag.Player_Bullet][bullet.m_snId] = bullet
        end

        return bullet
    end
end

------------------------------------怪物子弹
function createMonterBullet(self, monsterThing, skill_type, data)
    local bullet = nil
    if skill_type == DanKeConst.MonsterSkillType.Shoot_2 then
        bullet = danke.DankeMonsterStraightBullet:setupPrefab(monsterThing, data)
    elseif skill_type == DanKeConst.MonsterSkillType.Shoot_3 then
        bullet = danke.DankeMonsterStraightBullet:setupPrefab(monsterThing, data)
    elseif skill_type == DanKeConst.MonsterSkillType.Shoot_4 then
        bullet = danke.DankeMonsterStraightBullet:setupPrefab(monsterThing, data)
    elseif skill_type == DanKeConst.MonsterSkillType.Dash then
        bullet = danke.DankeMonsterDashBullet:setupPrefab(monsterThing, data)
    end

    if bullet then
        self.m_thingDic[DanKeConst.ColliderTag.Enemy_Bullet][bullet.m_snId] = bullet
    end

    return bullet
end

function getThing(self, layer, snId)
    if not self.m_thingDic then
        return nil
    end

    if not self.m_thingDic[layer] then
        return nil
    end

    return self.m_thingDic[layer][snId]
end

function recoverThing(self, layer, snId)
    if self.m_thingDic and self.m_thingDic[layer] then
        local thing = self.m_thingDic[layer][snId]
        if thing then
            thing:recover()
            self.m_thingDic[layer][snId] = nil
        end
    end
end

function getLayerThingDic(self, layer)
    return self.m_thingDic[layer]
end

function clearThing(self)
    for layerName, thingDic in pairs(self.m_thingDic or {}) do
        for snId, thing in pairs(thingDic) do
            thing:recover()
        end
    end

    self.m_thingDic = {}
end

----------------------------------------相机
function initCamera(self)
    if gs.Application.isEditor then
        danke.DanKeCamera = require("game/danke/manager/DanKeCamera")
    end
    self.mCamera = danke.DanKeCamera.new()
    self.mCamera:initCamera()
end

function clearCamera(self)
    if self.mCamera then
        self.mCamera:destroy()
    end
end

----------------------------------------特效音效
function addEffect(self, effctName, layerParent, wpos)
    if string.NullOrEmpty(effctName) then return end

    local effct = danke.DanKeffect:create(effctName, layerParent, wpos)
    self.mEffectList[effct.m_snId] = effct
    return effct.m_snId
end

function removeEffect(self, sn)
    if not sn then return end

    local effct = self.mEffectList[sn]
    if effct then
        effct:recover()
    end
    self.mEffectList[sn] = nil
end

function clearEffect(self)
    if self.mEffectList then
        for _, effct in pairs(self.mEffectList) do
            effct:recover()
        end
    end
    self.mEffectList = {}
end

-- function addSoundEffct(self, soundName)
--     if string.NullOrEmpty(soundName) then return end

--     local sound = AudioManager:playFightSoundEffect(FieldExplorationConst.getFieldExplorationSoundPath(soundName))
--     if not sound then
--         return
--     end
--     self.mSoundList[sound.m_snId] = sound
--     return sound.m_snId
-- end

-- function removeSoundEffct(self, sn)
--     if not sn then return end

--     local sound = self.mSoundList[sn]
--     if sound then
--         AudioManager:stopAudioSound(sound)
--         self.mSoundList[sn] = nil
--     end
-- end

-- function clearSound(self)
--     for _, effct in pairs(self.mSoundList) do
--         AudioManager:stopAudioSound(sound)
--     end
--     self.mSoundList = {}
-- end

-----------------------------------------------------------------------
function getDupTime(self)
    return self.m_dupTime
end

function getLayer(self, layer)
    return self.m_layers[layer]
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)

    self:clearData()

    UIFactory:startForcibly()
end

function clearData(self)
    for _, grid in pairs(self.m_gridMapList or {}) do
        gs.GameObject.Destroy(grid)
    end
    self.m_gridMapList = nil

    self:onGameOver()
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.DANKE
end

-- 地图资源名
function getMapID(self)
    return 20001
end

return _M
