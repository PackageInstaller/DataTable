module("fight.SceneManager", Class.impl(Manager))
--事件
EVENT_ADD_THING = 'EVENT_ADD_THING';
EVENT_REMOVE_THING = 'EVENT_REMOVE_THING';
EVENT_BUILD_COMPLETE = 'EVENT_BUILD_COMPLETE';
EVENT_PLAY_RATE_CHANGE = 'EVENT_PLAY_RATE_CHANGE';

--构造函数
function ctor(self)
    super.ctor(self)
    -- 当前加载的场景ID
    self.m_curMapID = nil
    self.m_thingDic = {}
    self.m_suspendOrder = {}

    self.m_isInFightScene = false

    self.m_sceneMusicID = 0
    self.m_sceneDict = nil

    self.m_dupData = nil

    self.isStopLoad = false
    self:_parseSceneData()
end

--获取当前的关卡数据
function getCusDupData(self)
    return self.m_dupData
end

-- 初始化配置表
function _parseSceneData(self)
    self.m_sceneDict = {}
    local baseData = RefMgr:getData('scene_data')
    for refID, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.SceneDataRo)
        ro:parseData(refID, data)
        self.m_sceneDict[refID] = ro
    end
end

function getSceneData(self, refID)
    if refID then
        return self.m_sceneDict[refID]
    end
end

--析构函数
function dtor(self)
    fight.FightCamera:setCameraGeneralCtrl(nil)
end

function reset(self)
    if self.m_startFightSn then
        RateLooper:clearTimeout(self.m_startFightSn)
        self.m_startFightSn = nil
    end
    for liveID, v in pairs(self.m_thingDic) do
        self:dispatchEvent(EVENT_REMOVE_THING, liveID)
        Class.delete(v)
    end
    self.m_thingDic = {}
    self.m_suspendOrder = {}
    self.m_isInFightScene = false
end

function clearMap(self)
    self:reset()
    -- 退出战斗场景允许GC
    GCUtil.restartCSharpGC()
    GCUtil.restartLuaGC()
    gs.ApplicationUtil.SetLoadingPriority(gs.ThreadPriority.BelowNormal)
    gs.PopPanelManager.SetPauseDestroyPanel(false)

    gs.LoopBehaviour.Instance:AddLoopIns(gs.ResMgr)
    gs.LoopBehaviour.Instance:AddLoopIns(gs.GOPoolMgr)
    gs.LoopBehaviour.Instance:AddLoopIns(gs.DynamicAnimation)
    gs.ResMgr:CheckUnLoad()
    if not fight.FightDef.TEMP_SETTING_BEABLE(5) then
        gs.ApplicationUtil.BlendWeights(gs.SkinWeights.FourBones)
    else
        local idx = fight.FightDef.TEMP_SETTING_BEABLEIdx(5)
        if idx == 2 then
            gs.ApplicationUtil.BlendWeights(gs.SkinWeights.FourBones)
        end
    end

    -- 恢复阴影质量
    systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.shadow)
end

-- 是否在战斗场景中
function isInFightScene(self)
    return self.m_isInFightScene
end

-- 后处理总开关设置
function SetCameraPostprocessEnable(self, enable)
    -- body
    local camera = gs.GameObject.Find("[SCamera]")
    local postProcess = camera:GetComponent("PostProcessing")
    postProcess.PostProcessToggle = enable
end

-- 场景所有物体的shader换成UnlitDiff开关
function SetOpenLowShader(self, enable)
    -- body
    local cameraNode = gs.GameObject.Find("[SCamera]")
    if cameraNode == nil then
        cameraNode = gs.GameObject.Find("[SCENE_CAMERA]")
    end
    local camera = cameraNode:GetComponent("Camera")
    if enable then
        local shader = gs.Shader.Find("LeiyanFX/Scene/UnlitDiff");
        camera:SetReplacementShader(shader, "")
    else
        camera:ResetReplacementShader()
    end
end

function enterMap(self)
    -- Audio:stopMusic()
    local tmpObj = gs.GameObject.Find("[TEMP_GO]")
    if tmpObj then gs.GameObject.Destroy(tmpObj) end

    tmpObj = gs.GameObject.Find("[OGRIN_GO]")
    if tmpObj then
        fight.SceneGrid:setGridPos00(tmpObj.transform.position)
    else
        fight.SceneGrid:setGridPos00(gs.VEC3_ZERO)
    end

    local voList = {}
    local _dic = self:getAllThing()
    for _, vo in pairs(_dic) do
        table.insert(voList, vo)
    end
    -- loginLoad.LoginLoadController:showLoading()
    GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
    local curPross = 10
    local step = 80 / #voList
    -- loginLoad.LoginLoadController:setLoadingPro(curPross, nil, "加载模型")
    local function _loadStep()
        if self.isStopLoad then return end
        self.mAsynLoadCameraSn = nil

        curPross = curPross + step
        -- loginLoad.LoginLoadController:setLoadingPro(curPross, nil, "加载模型")
        local liveVo = voList[1]
        if liveVo then
            table.remove(voList, 1)
            fight.FightLoader:loadLiveModel(liveVo, false, _loadStep)
        else
            local function loadFinish()
                if self.isStopLoad then return end

                fight.FightCamera:setCameraGeneralCtrl(fight.SceneGrid)
                local function _timeoutCall()
                    if self.isStopLoad then
                        return
                    end
                    local function _startFightCall()
                        if self.isStopLoad then
                            return
                        end
                        if self.m_startFightSn == nil then
                            return
                        end
                        self:_delayStartFight()
                    end
                    self.m_startFightSn = RateLooper:setTimeout(15, self, _startFightCall) --容错处理
                    fight.FightLoader:loadEnterSceneAll(_startFightCall)
                    GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_VS_VIEW) -- 关闭综合对抗赛vs
                    UIFactory:closeForcibly()

                    self:preloadEffects()

                    if fight.SceneManager and fight.SceneManager.m_sceneMusicID and fight.SceneManager.m_sceneMusicID > 0 then
                        AudioManager:playMusicById(fight.SceneManager.m_sceneMusicID)
                    else
                        self:playSceneMusic()
                    end

                    note.NoteManager:addEnableByFight(false)
                end
                RateLooper:setTimeout(0.2, self, _timeoutCall)
            end
            local extraHeros = FightResultProxy:getExtraHeros(fight.FightManager:getBattleType(), fight.FightManager:getBattleFieldID())
            fight.FightLoader:loadExtraHeroModelList(extraHeros, function()
                if self.isStopLoad then return end
                fight.FightLoader:loadSceneCommonResource(loadFinish)
            end)
        end
    end

    -- 进入战斗场景禁止GC
    GCUtil.stopCSharpGC()
    GCUtil.stopLuaGC()
    gs.ApplicationUtil.SetLoadingPriority(gs.ThreadPriority.Low)
    gs.PopPanelManager.SetPauseDestroyPanel(true)
    -- _loadStep()
    self.mAsynLoadCameraSn = gs.ResMgr:PreLoadAsyn(UrlManager:getFightCameraAniPath("goin.anim"), _loadStep)

    if self:getMapID() ~= 304 then
        -- 进战斗场景默认阴影质量最低 304场景除外
        systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.shadow, 1)
    end

    -- unity2021版本设置此项，ios进战斗会直接锁30帧，故屏蔽该处理
    -- local value = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.frameCount)
    -- local quality = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.quality)
    -- if value == 2 and quality >= 4 and not gs.ApplicationUtil.IsPC() then
    --     --1080p 60帧模式下，非pc端战斗场景限制55帧，退出场景自动恢复默认
    --     systemSetting.SystemSettingManager:setFrameCount(55)
    -- end
end

-- 提前关闭加载界面，战斗开始前进行特效加载
function preloadEffects(self)
    local voList = {}
    local roleIDList = fight.FightManager:getCurRoleList()
    if not table.empty(roleIDList) then
        for i = 1, #roleIDList do
            local liveVo = fight.SceneManager:getThing(roleIDList[i])
            if liveVo then
                table.insert(voList, liveVo)
            end
        end
    end

    local function loadStep()
        local liveVo = voList[1]
        if liveVo then
            table.remove(voList, 1)
            fight.FightLoader:_loadLiveEffRes(liveVo, loadStep)
        end
    end
    loadStep()
end

--中断场景加载
function stopLoadScene(self)
    print("===============stopLoadScene 连接异常，主动中断加载")
    self.isStopLoad = true
    if self.mAsynLoadCameraSn then
        gs.ResMgr:CancelLoadAsync(self.mAsynLoadCameraSn)
        self.mAsynLoadCameraSn = nil
    end

    if self.m_startFightSn then
        RateLooper:clearTimeout(self.m_startFightSn)
        self.m_startFightSn = nil
    end
end

function onStartLoad(self)
    self.isStopLoad = false
end

function _delayStartFight(self)
    RateLooper:clearTimeout(self.m_startFightSn)
    self.m_startFightSn = nil
    -- print("_delayStartFight==============")
    local function _timeoutCall()
        GameDispatcher:dispatchEvent(EventName.FIGHT_SCENE_COMPLETE)
        -- fight.FightLoader:inFightingLoad()
        -- Audio:startMusic()
        fight.FightLoader:inFightingLoad()
    end
    RateLooper:setTimeout(0.1, self, _timeoutCall)
end

-- 播放场景音乐
function playSceneMusic(self)
    local sceneRo = fight.SceneManager:getSceneData(self:getMapID())
    if sceneRo then
        -- 场景音乐
        -- AudioManager:playMusicListByIds(sceneRo:getVoiceList(), sceneRo:getPlayType())
        AudioManager:playMusicById(sceneRo:getMusicId())
    end
end

function setupMap(self, mapID)
    self.m_curMapID = tonumber(mapID)
end

function getGridPos00(self, type, gridID)
    return fight.SceneGrid:getPos(type, gridID)
end
function getGridPos01(self, liveVo)
    return fight.SceneGrid:getPos(liveVo.isAtt, liveVo:getGridID())
end

function getCenterPos(self)
    return fight.SceneGrid:getCenterPos()
end

-- 判断live是否在原点
function isInRestorePos(self, liveVo)
    local pos = self:getGridPos01(liveVo)
    if pos then
        return pos:equals(liveVo:getCurPos())
    end
    return false
end

function getPosFront00(self, type, gridID, len)
    return fight.SceneGrid:getPosFront(type, gridID, len)
end

function getPosFront01(self, liveVo, len)
    return fight.SceneGrid:getPosFront(liveVo.isAtt, liveVo:getGridID(), len)
end

function getMapID(self)
    return self.m_curMapID
end

function addThing(self, cusData)
    self.m_thingDic[cusData.id] = cusData
    self:dispatchEvent(EVENT_ADD_THING);
end

function removeThing(self, cusId)
    local vo = self.m_thingDic[cusId]
    if vo then
        vo:clearLiveData()
        self.m_thingDic[cusId] = nil
        self:dispatchEvent(EVENT_REMOVE_THING, cusId);
        Class.delete(vo)
    end
end

function removeSideThing(self, side, isDead)
    for k, v in pairs(self.m_thingDic) do
        if v:isAttacker() == side and (isDead == nil or v:isDead() == isDead) then
            self:removeThing(k)
        end
    end
end

-- 获取战场上的某个战员vo，cusId战员的战场唯一id
function getThing(self, cusId)
    return self.m_thingDic[cusId]
end

-- 获取战场上所有生命物体数据
function getAllThing(self)
    return self.m_thingDic
end

-- 获取某一方的战员数据
function getSideThingIDs(self, side)
    local ret = {}
    for k, v in pairs(self.m_thingDic) do
        if v:isAttacker() == side then
            table.insert(ret, k)
        end
    end
    return ret
end
function getOtherSideThingIDs(self, side)
    local ret = {}
    for k, v in pairs(self.m_thingDic) do
        if v:isAttacker() ~= side then
            table.insert(ret, k)
        end
    end
    return ret
end

function getSideNoDead(self, side)
    local ret = {}
    for k, v in pairs(self.m_thingDic) do
        if v:isAttacker() == side and not v:isDead() then
            table.insert(ret, v)
        end
    end
    return ret
end

function _getDupData(self)
    local battleType = fight.FightManager:getBattleType()
    local battleFieldID = fight.FightManager:getBattleFieldID()
    if battleFieldID then
        battleFieldID = tonumber(battleFieldID)
    end
    -- 爬塔副本
    if PreFightBattleType.ClimbTowerDup == battleType then
        return dup.DupClimbTowerManager:getDupVo(battleFieldID)
        -- 主线普通推图关卡
    elseif PreFightBattleType.MainMapStage == battleType then
        return battleMap.MainMapManager:getStageVo(battleFieldID)
        -- 金币副本
    elseif PreFightBattleType.DupMoney == battleType then

        return dup.DupDailyMainManager:getDupData(battleFieldID)
        -- 经验副本
    elseif PreFightBattleType.DupExp == battleType then
        return dup.DupDailyMainManager:getDupData(battleFieldID)
        -- 装备副本（废弃）
    elseif PreFightBattleType.DupOldEquip == battleType then
        -- 芯片副本
    elseif PreFightBattleType.DupEquip_Low == battleType then
        return dup.DupDailyMainManager:getDupData(battleFieldID)
    elseif PreFightBattleType.DupEquip_Mid == battleType then
        return dup.DupDailyMainManager:getDupData(battleFieldID)
    elseif PreFightBattleType.DupEquip_High == battleType then
        return dup.DupDailyMainManager:getDupData(battleFieldID)
        -- elseif PreFightBattleType.DupEquip_4 == battleType then
        --     return dup.DupDailyMainManager:getDupData(battleFieldID)
        -- elseif PreFightBattleType.DupEquip_5 == battleType then
        --     return dup.DupDailyMainManager:getDupData(battleFieldID)
        -- 芯片突破副本
    elseif PreFightBattleType.DupEquipTupo == battleType then
        return dup.DupDailyMainManager:getDupData(battleFieldID)
        -- 竞技塔挑战
    elseif PreFightBattleType.ArenaChallenge == battleType then
        return arena.ArenaManager:getRobotData(battleFieldID)
        -- 英雄传记/回忆录挑战
    elseif PreFightBattleType.HeroBiography == battleType then
        return battleMap.BiographyManager:getDupConfigVo(battleFieldID)
        -- 模拟训练副本
    elseif PreFightBattleType.Training == battleType then
        return training.TrainingManager:getTrainingDupConfigVo(battleFieldID)
        -- 使徒之战2副本
    elseif PreFightBattleType.DupApostle2War == battleType then
        return dup.DupApostlesWarManager:getDupBaseVo(battleFieldID)
        -- 迷宫副本
    elseif PreFightBattleType.DupMaze == battleType then
        local mazeEventVo = maze.MazeSceneManager:getMazeEventVo(battleFieldID)
        local dupId = mazeEventVo:getEffecctList()[1]
        return maze.MazeManager:getDupConfigVo(dupId)
    elseif PreFightBattleType.MainExplore == battleType then
        return mainExplore.MainExploreSceneManager:getDupConfigVo(battleFieldID)
    elseif PreFightBattleType.ElementTower == battleType then
        return dup.DupClimbTowerManager:getDeepDupVo(battleFieldID)
        -- 元素塔副本
    elseif PreFightBattleType.Cycle == battleType then
        return cycle.CycleManager:getCycleDupData(battleFieldID)
    elseif PreFightBattleType.ActiveDup == battleType then
        --1.1活动
        return mainActivity.ActiveDupManager:getStageVoByDupId(battleFieldID)
    elseif PreFightBattleType.CodeHopeDup == battleType then
        --代号希望
        return dup.DupCodeHopeManager:getDupVo(battleFieldID)
    elseif battleType == PreFightBattleType.Guild_boss_war or battleType == PreFightBattleType.Guild_boss_imitate then
        return guild.GuildManager:getGuildBossDupIdConfig(nil, battleFieldID)
    elseif battleType == PreFightBattleType.SandPlay then
        return sandPlay.SandPlayManager:getStageConfigVo(battleFieldID)
    elseif battleType == PreFightBattleType.Doundless then
        return doundless.DoundlessManager:getDoundlessCityStageDataById(battleFieldID)
    elseif battleType == PreFightBattleType.Guild_Sweep then
        return guild.GuildManager:getSweepDupDataByDupId(battleFieldID)
    elseif battleType == PreFightBattleType.Disaster or battleType == PreFightBattleType.Disater_imitate then
        return disaster.DisasterManager:getDisasterDupDataByDupId(battleFieldID)
    elseif battleType == PreFightBattleType.HeroTrial then
        return mainActivity.MainActivityManager:getTrialConfigVo(battleFieldID)
    elseif battleType == PreFightBattleType.Seabed then
        return seabed.SeabedManager:getSeabedDupDataById(battleFieldID)
    end
end

function build(self, cusData)
    self:reset();
    -- 通知资源下载模块更新相关处理
    GameDispatcher:dispatchEvent(EventName.UPDATE_FIGHT_BACKGROUND_DOWNLOAD, true)
    gs.LoopBehaviour.Instance:RemoveLoopIns(gs.ResMgr)
    gs.LoopBehaviour.Instance:RemoveLoopIns(gs.GOPoolMgr)
    gs.LoopBehaviour.Instance:RemoveLoopIns(gs.DynamicAnimation)
    gs.ResMgr:CheckUnLoad()
    self.m_isInFightScene = true
    gs.ApplicationUtil.BlendWeights(gs.SkinWeights.TwoBones)
    UIFactory:startForcibly()
    -- loginLoad.LoginLoadController:showLoading()
    -- loginLoad.LoginLoadController:setLoadingPro(10, nil, "开始加载场景...")
    self.m_sceneMusicID = 0
    -- 设置战斗场景参数
    -- self:setupMap(cusData.battle_scene)
    if fight.FightManager.m_gmScene then
        print("==============fight.FightManager.m_gmScene", fight.FightManager.m_gmScene)
        self:setupMap(fight.FightManager.m_gmScene)
    else
        local dupData = self:_getDupData()
        self.m_dupData = dupData
        if dupData and dupData.getSceneId then
            if dupData.getMusicId then
                self.m_sceneMusicID = dupData:getMusicId()
                -- else
                --     logError("===============该玩法configVo没有预设getMusicId() 方法，发给前端检查")
            end
            -- print("=================dupData:getSceneId()", dupData:getSceneId())
            self:setupMap(dupData:getSceneId())
        else
            if fight.FightManager:getBattleType() == PreFightBattleType.GuildWar then
                self:setupMap(112)
            end
            if dupData then
                logError("===============该玩法configVo没有预设getSceneId() 方法，发给前端检查" .. dupData.__cname)
            end
        end
        if not self.m_curMapID then
            -- elseif fight.FightManager:getBattleType()==PreFightBattleType.ArenaChallenge then
            -- self.m_sceneMusicID = sysParam.SysParamManager:getValue(SysParamType.ARENA_DEF_MUSIC_ID)
            self:setupMap(sysParam.SysParamManager:getValue(SysParamType.ARENA_DEF_SCENE_ID))
        end
        -- else
        --     local battleType = fight.FightManager:getBattleType()
        --     local battleFieldID = fight.FightManager:getBattleFieldID()
        --     logError(string.format("[%s], [%s], 没有配置对应场景 ", tostring(battleType), tostring(battleFieldID)))
        -- end
    end

    local heroDict = fight.FightManager:getAllHero()
    for k, v in pairs(heroDict) do
        local vo = fight.LivethingVo.new(k, v.side)
        vo:setTID(v.tid, v.type, v.body_fashion_id, v.body_fashion_color_id)
        -- vo:setModelID(1102)
        local gridID = v.pos.x * 100 + v.pos.y
        vo:setGridID00(gridID)
        -- local pos = fight.SceneGrid:getPos(v.side, gridID)
        -- vo:initPosition(pos);
        vo.evolutionLvl = v.evolution
        vo:setAtt(AttConst.LV, v.lv)
        vo:setAtt(AttConst.HP, v.hp)
        vo:setAtt(AttConst.HP_MAX, v.max_hp)
        vo:setAtt(AttConst.MP, v.rage)
        vo:setAtt(AttConst.MP_MAX, fight.FightManager:getMaxRage())
        vo:setAtt(AttConst.SKILL_SOUL, v.skill_soul)
        vo:setAtt(AttConst.STUN, v.hit_stun)
        vo:setAtt(AttConst.STUN_MAX, v.max_hit_stun)
        -- if (vo:isAttacker()==1) then
        --     print("loadHeroLive", v.rage)
        -- end
        -- if fight.FightManager.m_gmTurn and v.side~=1 then -- and vo:getRaceType()==0 then
        --     vo:setDirAngle(fight.FightManager.m_gmTurnAngle, true)
        -- end
        self:addThing(vo)
    end
    if fight.FightManager:getBattleType() == PreFightBattleType.Arena_Peak_Pvp then
        LoopManager:setTimeout(0.5, self, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_VS_VIEW)
        end)
    end

    self:dispatchEvent(EVENT_BUILD_COMPLETE)
end

-- 暂停播放
function suspend(self, cusObj)
    if self.m_suspendOrder[cusObj] == nil then
        self.m_suspendOrder[cusObj] = true
    end
    RateLooper:setStop(true)
    self.m_lastTimeScale = gs.Time.timeScale
    fight.FightManager:setupTimeScale(0)
end

-- 恢复播放
function restore(self, cusObj)
    if self.m_suspendOrder[cusObj] ~= nil then
        self.m_suspendOrder[cusObj] = nil
    end
    if table.nums(self.m_suspendOrder) == 0 then
        RateLooper:setStop(false)
    end
    fight.FightManager:setupTimeScale(self.m_lastTimeScale or 1)
end

function defJumpBack(self, liveIDs)
    for i, liveID in ipairs(liveIDs) do
        local v = self:getThing(liveID)
        if v.isDefJumpOut == true then
            v.isDefJumpOut = nil
            local liveObj = fight.SceneItemManager:getLivething(v:getLiveID())
            if liveObj then
                v:turnOrgDirAngle(false)
                local pos = fight.SceneGrid:getPos(v:isAttacker(), v:getGridID())
                if not v:isDead() then
                    v:updateAni(fight.FightDef.ACT_EXIT)
                    liveObj:getAniLenght(fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_EXIT], function(length)
                        v:moveTo(pos, length)
                    end)
                else
                    v:updatePosition(pos)
                end
            end
        end
    end
end

function defJumpOut(self, liveIDs, hitLiveID)
    local psLive = self:getThing(hitLiveID)
    if psLive then
        for i, liveID in ipairs(liveIDs) do
            local v = self:getThing(liveID)
            if not v:isDead() and not v.isDefJumpOut then
                v.isDefJumpOut = true
                local liveObj = fight.SceneItemManager:getLivething(v:getLiveID())
                if liveObj then
                    v:turnDirByVector(psLive:getCurPos(), false)
                    v:updateAni(fight.FightDef.ACT_EXIT)
                    liveObj:getAniLenght(fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_EXIT], function(length)
                        local dir = (v:getCurPos() - psLive:getCurPos())
                        dir = v:getCurPos() + dir:normalize()
                        v:moveTo(dir, aniLenght)
                    end)
                end
            end
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
