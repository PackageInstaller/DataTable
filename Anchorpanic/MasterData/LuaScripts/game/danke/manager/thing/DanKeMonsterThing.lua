-- @FileName:   DanKeMonsterThing.lua
-- @Description:  沙盒实体基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.danke.thing.DanKeMonsterThing', Class.impl(danke.DanKeBaseThing))

function resetData(self)
    super.resetData(self)
    self.m_attr =
    {
        max_hp = self.m_data.config.hp,
        hp = self.m_data.config.hp,
        damage = self.m_data.config.damage,
    }

    self.m_selfColliderTag = DanKeConst.ColliderTag.Normal_Monster

    self.m_deltaTime = 0

    self.m_isCanPursuit = true --是否可以追击
    self.m_isExecuteSkill = false ---是否正在执行技能
    self.m_canAttack = true --是否可以攻击玩家
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    -- local trans = self:getTrans()
    -- trans.gameObject.layer = gs.LayerMask.NameToLayer("Monster")

    self:setPosition(self.m_data.bron_pos)

    self.m_playerThing = danke.DanKeSceneController:getPlayerThing()
    self:lookAtPlayerThing()

    self:addColliderGo()
    self:createSkill()

    self:clearFrame()
    self.mFrameSn = LoopManager:addFrame(1, -1, self, self.onFrame)

    GameDispatcher:dispatchEvent(EventName.DANKE_MONSTER_REFRESH_HP, self.m_snId)
end

function initCharacterControllerSize(self)
    gs.UnityEngineUtil.InitCharacterController(self.m_CharacterController, 0, 0, self.m_data.config.agent_radius, self.m_data.config.agent_radius, gs.VEC3_ZERO)
end

--添加碰撞检测
function addColliderGo(self)
    self.m_ColliderGo = gs.GameObject()
    self.m_ColliderGo.name = "collider_Go"
    gs.TransQuick:SetParentOrg(self.m_ColliderGo.transform, self.m_spriteModel.m_trans)

    self.m_ColliderCall = self.m_ColliderGo:AddComponent(ty.ColliderCall)
    self.m_ColliderCall:InitCapsuleCollider(self.m_data.config.agent_radius + 0.05, self.m_data.config.agent_radius + 0.05)
    local colliderTags = {DanKeConst.ColliderTag.Player_Bullet, DanKeConst.ColliderTag.Player}
    self.m_ColliderCall:AddColliderTags(colliderTags)
    self.m_ColliderCall:OpenColliderCheck()
    self.m_ColliderCall.IsTrigger = true

    self.m_ColliderCall.SelfColliderTag = self.m_selfColliderTag
    self.m_ColliderCall.ColliderTagID = self.m_snId

    self.m_ColliderCall.onTriggerEnterCall = function (tag, colliderTagID)
        if tag == DanKeConst.ColliderTag.Player_Bullet then
            local data = {attack_id = colliderTagID, hit_id = self.m_snId, attack_tag = tag, hit_tag = self.m_selfColliderTag}
            GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_ENTER, data)
        elseif tag == DanKeConst.ColliderTag.Player then
            local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = self.m_selfColliderTag, hit_tag = tag}
            GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_ENTER, data)
        end
    end

    self.m_ColliderCall.onTriggerStayCall = function (tag, colliderTagID)
        if tag == DanKeConst.ColliderTag.Player_Bullet then
            local data = {attack_id = colliderTagID, hit_id = self.m_snId, attack_tag = tag, hit_tag = self.m_selfColliderTag}
            GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_STAY, data)
        elseif tag == DanKeConst.ColliderTag.Player then
            local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = self.m_selfColliderTag, hit_tag = tag}
            GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_STAY, data)
        end
    end

    self.m_ColliderCall.onTriggerExitCall = function (tag, colliderTagID)
        local data = {}
        if tag == DanKeConst.ColliderTag.Player_Bullet then
            data = {attack_id = colliderTagID, hit_id = self.m_snId, attack_tag = tag, hit_tag = self.m_selfColliderTag}
        elseif tag == DanKeConst.ColliderTag.Player then
            data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = self.m_selfColliderTag, hit_tag = tag}
        end

        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_EIXT, data)
    end
end

function onFrame(self)
    self.m_deltaTime = self.m_deltaTime + LoopManager:getDeltaTime()

    if self.m_data.config.find_type == 1 then
        if self.m_isCanPursuit then
            if self.m_playerThing then
                local followPos = self.m_playerThing:getPosition()
                local selfPos = self:getPosition()
                local targetPos = followPos - selfPos
                local normalized = gs.Vector3(targetPos.normalized.x, targetPos.normalized.y, 0)
                self:setTranForward(gs.Time.deltaTime * self.m_data.config.move_speed, normalized)
            end
            self:lookAtPlayerThing()
        end
    end
end

function clearFrame(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function lookAtPlayerThing(self)
    if self.m_playerThing then
        local center_pos = self.m_playerThing:getPosition()
        if center_pos then
            local angle_y = 0
            if self:getPosition().x < center_pos.x then
                angle_y = 180
            end
            self:setAngle(angle_y)
        end
    end
end

---------------------------------------------技能
---创建技能
function createSkill(self)
    self.m_skillList = {}
    for _, skill_id in pairs(self.m_data.config.monster_skill) do
        local skillConfigVo = danke.DanKeManager:getMonsterSkillConfigVo(skill_id)
        if skillConfigVo == nil then
            logError("怪物技能配置为空，请检查danke_monster_skill_data 配置表 ,skill_id = "..skill_id)

        else
            local skill = nil
            if skillConfigVo.type == DanKeConst.MonsterSkillType.Shoot_2 then
                skill = danke.DankeMonsterShootSkill_2:create(self, skillConfigVo)
            elseif skillConfigVo.type == DanKeConst.MonsterSkillType.Shoot_3 then
                skill = danke.DankeMonsterShootSkill_3:create(self, skillConfigVo)
            elseif skillConfigVo.type == DanKeConst.MonsterSkillType.Shoot_4 then
                skill = danke.DankeMonsterShootSkill_4:create(self, skillConfigVo)
            elseif skillConfigVo.type == DanKeConst.MonsterSkillType.Dash1 then
                skill = danke.DankeMonsterShootSkill_Dash1:create(self, skillConfigVo)
            elseif skillConfigVo.type == DanKeConst.MonsterSkillType.Dash2 then
                skill = danke.DankeMonsterShootSkill_Dash2:create(self, skillConfigVo)
            end
            table.insert(self.m_skillList, skill)
        end
    end
end

function clearSkill(self)
    if self.m_skillList then
        for _, skill in pairs(self.m_skillList) do
            skill:recover()
        end

        self.m_skillList = nil
    end
end

function getRandomSkill(self)
    local isHave = false
    for _, skill in pairs(self.m_skillList) do
        if not skill:isOnCd() then
            isHave = true
            break
        end
    end
    if not isHave then
        return
    end

    local random_index = math.random(1, #self.m_skillList)
    local skill = self.m_skillList[random_index]
    if skill:isOnCd(self.m_deltaTime) then
        return self:getRandomSkill()
    end

    return skill
end

--执行技能
function onExecuteSkill(self)
    if self.m_isExecuteSkill then
        return
    end

    local skill = self:getRandomSkill()
    if skill then
        skill:onExecute(self.m_deltaTime)
        if skill:getDataVo().is_stand then
            self.m_isCanPursuit = false
        end

        self.m_isExecuteSkill = true
    end
end

--技能执行完成
function skillExecuteFinish(self)
    self.m_isExecuteSkill = false
    self.m_isCanPursuit = true

    self:onExecuteSkill()
end

function onAttack(self, thing, collider_args, isforce)
    if not self.m_canAttack then
        return
    end
    thing:onHit(self.m_attr.damage)
end

--受击
function onHit(self, damage)
    super.onHit(self, damage)

    GameDispatcher:dispatchEvent(EventName.DANKE_MONSTER_REFRESH_HP, self.m_snId)
end

--死亡
function onDie(self)
    local diePath = "arts/fx/3d/sceneModule/danke/fx_danke_die/fx_danke_die.prefab"
    local layer = danke.DanKeSceneController:getLayer(DanKeConst.LayerName.Monster_layer)
    local bullet_parent = layer.node
    danke.DanKeSceneController:addEffect(diePath, bullet_parent, self:getPosition())

    if self.m_playerThing then
        self.m_playerThing:addKillNum(1)
    end

    local drop_id = self.m_data.config:getDrop()
    if drop_id then
        local selfPos = self:getPosition()
        danke.DanKeSceneController:createDrop(drop_id, gs.Vector3(selfPos.x, selfPos.y, 0))
    end

    GameDispatcher:dispatchEvent(EventName.DANKE_MONSTER_REFRESH_HP, self.m_snId)
    self:poolRecover()

    GameDispatcher:dispatchEvent(EventName.DANKE_MONSTER_DIE, self.m_data.config.id)
end

function setCanAttack(self, value)
    self.m_canAttack = value
end

function getScale(self)
    return self.m_data.config:getScale()
end

function getPosition(self)
    if self.m_spriteModel and self.m_spriteModel.m_trans and not gs.GoUtil.IsTransNull(self.m_spriteModel.m_trans) then
        return self.m_spriteModel.m_trans.position
    else
        return self.m_data.bron_pos
    end
end

function getSpriteModel(self)
    return danke.DanKeBaseSpriteModel
end

function getPrefabPath(self)
    return "arts/character/scene_module/dake/" .. self.m_data.config.mon_model
end

--内部调用回收
function poolRecover(self)
    danke.DanKeSceneController:recoverThing(self.m_selfColliderTag, self.m_snId)
end

function clearData(self)
    super.clearData(self)
    self:clearFrame()
    self:clearSkill()

    self.m_playerThing = nil
    self.m_isExecuteSkill = nil

    if self.m_ColliderCall and not gs.GoUtil.IsCompNull(self.m_ColliderCall) then
        self.m_ColliderCall.onTriggerEnterCall = nil
        self.m_ColliderCall.onTriggerStayCall = nil
        self.m_ColliderCall.onTriggerExitCall = nil
    end

    if self.m_ColliderGo and not gs.GoUtil.IsGoNull(self.m_ColliderGo) then
        gs.GameObject.Destroy(self.m_ColliderGo)
        self.m_ColliderGo = nil
    end
end

return _M
