-- @FileName:   FieldExplorationPlayerThing.lua
-- @Description:   玩家类
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.thing.FieldExplorationPlayerThing', Class.impl(fieldExploration.FieldExplorationBaseThing))

function resetData(self)
    super.resetData(self)

    self.audioDataDic = {}

    self.m_rotateSpeed = 50 -- 旋转速度
    self.m_gravity = 9.8 --重力加速度

    self.id = self.mData.config.id
    --属性
    self.infoAttr =
    {
        life = self.mData.config.life,
        maxLife = self.mData.config.life,
        energy = self.mData.config.energy,
        maxEnergy = self.mData.config.energy,
        score = 0,
        speed = self.mData.config.normal_speed,
        money_gold = 0, --金币
        money_silver = 0, --银币
        move_dir = 1,
    }

    self.mMoveMode = FieldExplorationConst.PlayerMoveType.Free_Mode

    --无敌结束的时间搓
    self.mInvincibleStateEndTimeDt = 0

    self.mSkillDic = {}

    --身上携带的buff
    self.buffDic = {}
    self.mCurActionState = nil --当前状态
    self.mCurStandState = nil --当前待机状态
end

function createModel(self)
    self:setupModel()
    self:addEventListener()
end

--重构函数
function setupModel(self)
    if self.mModel then
        return
    end

    local prefabPath = self:getPrefabPath()
    if string.NullOrEmpty(prefabPath) then
        return
    end

    self.mModel = self:getModel()
    self.mModel.m_rootGo.layer = gs.LayerMask.NameToLayer("Role")
    self.mModel:setupPrefab(prefabPath, false, function ()
        self:onModelLoadFinish()
        if self.mLoadFinishCall then
            self.mLoadFinishCall(self)
        end
    end)
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    if self.mData.config.heroTid == 9999 then
        self:cameraFollow()
    end

    --是否配置了抓取技能，如果配置了抓取技能的话需要使用缸体碰撞移动
    self.mHaveGrabSkill = false
    --创建技能
    for i = 1, #self.mData.config.skill do
        local skillTid = self.mData.config.skill[i]

        local skill = nil
        local heroSkillConfigVo = fieldExploration.FieldExplorationManager:getHeroSkillConfigVo(skillTid)
        if heroSkillConfigVo.type == FieldExplorationConst.HERO_SKILL_DODGE then
            skill = fieldExploration.FieldExplorationPlayerDodgeSkill.new()
        elseif heroSkillConfigVo.type == FieldExplorationConst.HERO_SKILL_INVINCIBLE then
            skill = fieldExploration.FieldExplorationPlayerInvincibleSkill.new()
        elseif heroSkillConfigVo.type == FieldExplorationConst.HERO_SKILL_GRAB then
            skill = fieldExploration.FieldExplorationPlayerGrabSkill.new()
            self.mHaveGrabSkill = true
        elseif heroSkillConfigVo.type == FieldExplorationConst.HERO_SKILL_FLASH then
            skill = fieldExploration.FieldExplorationPlayerFlashSkill.new()
        elseif heroSkillConfigVo.type == FieldExplorationConst.HERO_SKILL_LIFT then
            skill = fieldExploration.FieldExplorationPlayerLiftSkill.new()
        else
            skill = fieldExploration.FieldExplorationPlayerBaseSkill.new()
        end

        skill:setData(heroSkillConfigVo, self)

        self.mSkillDic[skillTid] = skill
    end

    --添加刚体/角色控制器
    if self.mHaveGrabSkill then
        local characterController = self.mModel.m_rootGo:AddComponent(ty.CapsuleCollider)
        gs.UnityEngineUtil.InitCapsuleCollider(characterController, self.mData.config.agent_radius, self.mData.config.agent_height, 1, gs.Vector3(0, self.mData.config.agent_height * 0.5, 0))

        self.m_Rigidbody = self.mModel.m_rootGo:AddComponent(ty.Rigidbody)
        gs.UnityEngineUtil.InitRigidbody(self.m_Rigidbody, true, true, 20)
    else
        self.m_CharacterController = self.mModel.m_rootGo:AddComponent(ty.CharacterController)
        gs.UnityEngineUtil.InitCharacterController(self.m_CharacterController, 30, 0.2, self.mData.config.agent_radius, self.mData.config.agent_height, gs.Vector3(0, self.mData.config.agent_height * 0.5, 0))
        -- self.m_CharacterController.skinWidth = 0.001
    end

    --单单只是为了让场景中的事件碰撞发现而已
    if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall = self.mModel.m_rootGo:GetComponent(ty.ColliderCall)
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mModel.m_rootGo:AddComponent(ty.ColliderCall)
        end

        self.mColliderCall:InitSelfCollider()
        self.mColliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.Player
        self.mColliderCall.ColliderTagID = self.id
    end

    self:addEffect("fx_wild_prop_dingwei.prefab")

    self:setActionState(FieldExplorationConst.HERO_ACTION_STATE.STAND)
    self:setStandState(FieldExplorationConst.HERO_ACTION_STATE.STAND)
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onControlMove, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onControlMove, self)
end

function getColliderCall(self)
    return self.mColliderCall
end

--控制移动
function onControlMove(self, args)
    if not self.mModel then
        return
    end

    if self.mMoveMode == FieldExplorationConst.PlayerMoveType.None then
        return
    else
        self.mJoystickDir = args
    end

    -- if self.mMoveMode == FieldExplorationConst.PlayerMoveType.None then
    --     self.mJoystickDir = {deltaRatioY = 0, deltaRatioX = 0}
    -- else
    --     self.mJoystickDir = args
    -- end

    if self.mMoveMode == FieldExplorationConst.PlayerMoveType.Horizontal_Mode then
        self.mJoystickDir.deltaRatioY = 0
    elseif self.mMoveMode == FieldExplorationConst.PlayerMoveType.Vertical_Mode then
        self.mJoystickDir.deltaRatioX = 0
    end

    --开始移动
    if self.mJoystickDir.deltaRatioX == 0 and self.mJoystickDir.deltaRatioY == 0 then
        self:stateRevert(FieldExplorationConst.HERO_ACTION_STATE.MOVE)
    else
        self:setActionState(FieldExplorationConst.HERO_ACTION_STATE.MOVE)
    end

    if not self.mHaveGrabSkill then
        local ve3 = gs.Vector3.down * (gs.Time.deltaTime * 10) * self.m_gravity
        gs.UnityEngineUtil.CharacterControllerMove(self.m_CharacterController, ve3)
    end
end

--状态恢复(状态来源)
function stateRevert(self, stateSource)
    if self.mCurActionState == FieldExplorationConst.HERO_ACTION_STATE.IDLE then --死亡
        return
    end

    --如果当前状态还是与输入的状态一样，再判断是不是可以允许恢复的状态
    if stateSource ~= self.mCurActionState then
        return
    end

    for _, state in pairs(FieldExplorationConst.AllowForceStandState) do
        if state == stateSource then
            if self.mCurStandState == FieldExplorationConst.HERO_ACTION_STATE.STAND then
                self:forceActionState(FieldExplorationConst.HERO_ACTION_STATE.STAND)
                break
            elseif self.mCurStandState == FieldExplorationConst.HERO_ACTION_STATE.GRAB then
                self:forceActionState(FieldExplorationConst.HERO_ACTION_STATE.GRAB)
                break
            elseif self.mCurStandState == FieldExplorationConst.HERO_ACTION_STATE.LIFT then
                self:forceActionState(FieldExplorationConst.HERO_ACTION_STATE.LIFT)
                break
            end
        end
    end
end

--设置当前待机状态
function setStandState(self, state)
    if self.mCurStandState == state then return end

    self.mCurStandState = state
    self:setActionState(self.mCurStandState)
end

--设置战员当前的动作状态
function setActionState(self, actionState)
    if actionState ~= FieldExplorationConst.HERO_ACTION_STATE.MOVE then
        if self.mCurActionState == actionState then
            return
        end
    end

    for _, state in pairs(FieldExplorationConst.NoAllowForceActionState) do
        if self.mCurActionState == state then
            return
        end
    end

    self:forceActionState(actionState)
end

--强切状态
function forceActionState(self, actionState)
    self.mCurActionState = actionState
    local aniHash = FieldExplorationConst.HERO_ACTIONSTATE_ACTHASH[actionState]

    if actionState == FieldExplorationConst.HERO_ACTION_STATE.MOVE then
        if self.mMoveMode == FieldExplorationConst.PlayerMoveType.Free_Mode then --自由移动
            local targetRotation = gs.Quaternion.LookRotation(gs.Vector3(self.mJoystickDir.deltaRatioX * self.infoAttr.move_dir, 0, self.mJoystickDir.deltaRatioY * self.infoAttr.move_dir))
            if gs.Quaternion.Angle(self:getTrans().rotation, targetRotation) > 1 then
                -- local rotation = gs.Quaternion.Slerp(self:getTrans().rotation, targetRotation, self.m_rotateSpeed * self.mJoystickDir.deltaTime)
                self:setAngle(targetRotation.eulerAngles.y, true)
            end
            self:setTranForward(self.infoAttr.speed * gs.Time.deltaTime)

            if actionState == FieldExplorationConst.HERO_ACTION_STATE.MOVE then
                if self.infoAttr.speed >= self.mData.config.normal_speed * 1.5 then
                    aniHash = FieldExplorationConst.ACT_RUN
                elseif self.infoAttr.speed <= self.mData.config.normal_speed * 0.5 then
                    aniHash = FieldExplorationConst.ACT_WALK
                end
            end

        elseif self.mMoveMode == FieldExplorationConst.PlayerMoveType.Vertical_Mode then -- 推箱子纵向
            local dir = 1
            local angle = self:getTrans().localEulerAngles.y - 180
            if math.abs(angle) <= 5 then
                dir = -1
            end

            local moveDir = self.mJoystickDir.deltaRatioY * dir
            if moveDir > 0 then
                aniHash = FieldExplorationConst.ACT_PUSH
            elseif moveDir < 0 then
                aniHash = FieldExplorationConst.ACT_PULL
            end

            self:setTranForward(self.infoAttr.speed * gs.Time.deltaTime * moveDir)

        elseif self.mMoveMode == FieldExplorationConst.PlayerMoveType.Horizontal_Mode then --推箱子横向
            local dir = 1
            local angle = self:getTrans().localEulerAngles.y - 270
            if math.abs(angle) <= 5 then
                dir = -1
            end

            local moveDir = self.mJoystickDir.deltaRatioX * dir
            if moveDir > 0 then
                aniHash = FieldExplorationConst.ACT_PUSH
            elseif moveDir < 0 then
                aniHash = FieldExplorationConst.ACT_PULL
            end

            self:setTranForward(self.infoAttr.speed * gs.Time.deltaTime * moveDir)
        elseif self.mMoveMode == FieldExplorationConst.PlayerMoveType.Lift_Mode then --举箱子自由移动
            local targetRotation = gs.Quaternion.LookRotation(gs.Vector3(self.mJoystickDir.deltaRatioX * self.infoAttr.move_dir, 0, self.mJoystickDir.deltaRatioY * self.infoAttr.move_dir))
            if gs.Quaternion.Angle(self:getTrans().rotation, targetRotation) > 1 then
                -- local rotation = gs.Quaternion.Slerp(self:getTrans().rotation, targetRotation, self.m_rotateSpeed * self.mJoystickDir.deltaTime)
                self:setAngle(targetRotation.eulerAngles.y, true)
            end
            self:setTranForward(self.infoAttr.speed * gs.Time.deltaTime)

            aniHash = FieldExplorationConst.ACT_BOXWALK
        end
    elseif actionState == FieldExplorationConst.HERO_ACTION_STATE.HIT then
        local animator = self.mModel.m_model:GetComponent(ty.Animator)
        self:clearTimeOutSn()
        self.mTimeOutSn = LoopManager:setTimeout(AnimatorUtil.getAnimatorClipTime(animator, FieldExplorationConst.NAME_HIT), nil, function ()
            self:stateRevert(FieldExplorationConst.HERO_ACTION_STATE.HIT)
        end)
    elseif actionState == FieldExplorationConst.HERO_ACTION_STATE.IDLE then
        GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_OVER)
    elseif actionState == FieldExplorationConst.HERO_ACTION_STATE.FLASH then
        -- local animator = self.mModel.m_model:GetComponent(ty.Animator)
        -- self:clearTimeOutSn()
        -- self.mTimeOutSn = LoopManager:setTimeout(AnimatorUtil.getAnimatorClipTime(animator, FieldExplorationConst.NAME_RDOWN), nil, function ()
        --     self:stateRevert(FieldExplorationConst.HERO_ACTION_STATE.FLASH)
        -- end)
    end

    if aniHash then
        self:playAction(aniHash)
    end
end

function playAction(self, aniHash, startCall, endCall, isForceEndCall)
    if not self.mModel then return end

    self.mModel:playAction(aniHash, startCall, endCall, isForceEndCall)
end

--收到伤害
function onHit(self, hit)
    if self.mCurActionState == FieldExplorationConst.HERO_ACTION_STATE.IDLE then
        return
    end

    if self:getInvincibleState() then
        return
    end

    self:addLife(hit)
    if self.infoAttr.life > 0 then
        self:setActionState(FieldExplorationConst.HERO_ACTION_STATE.HIT)
    end
end

--添加一个buff
function addBuff(self, buff_id, addThing)
    local buff = fieldExploration.FieldExplorationBuff:create(buff_id, self, addThing)
    self.buffDic[buff.m_snId] = buff
    return buff
end

--移除一个buff
function removeBuff(self, buff_snId)
    self.buffDic[buff_snId] = nil
end

-----------------------------------------------------属性
--血量
function addLife(self, life)
    self.infoAttr.life = self.infoAttr.life + life

    if self.infoAttr.life <= 0 then
        self.infoAttr.life = 0

        if self.mCurActionState ~= FieldExplorationConst.HERO_ACTION_STATE.IDLE then
            self:forceActionState(FieldExplorationConst.HERO_ACTION_STATE.IDLE)
        end
    elseif self.infoAttr.life > self.infoAttr.maxLife then
        self.infoAttr.life = self.infoAttr.maxLife
    end

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, {id = self.mData.id, attr = self.infoAttr})
end

--能量
function addEnergy(self, energy)
    self.infoAttr.energy = self.infoAttr.energy + energy

    if self.infoAttr.energy > self.infoAttr.maxEnergy then
        self.infoAttr.energy = self.infoAttr.maxEnergy
    elseif self.infoAttr.energy < 0 then
        self.infoAttr.energy = 0
    end

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, {id = self.mData.id, attr = self.infoAttr})
end

--积分
function addScore(self, score)
    self.infoAttr.score = self.infoAttr.score + score

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, {id = self.mData.id, attr = self.infoAttr})
end

--添加金币
function addMoney_Gold(self, money)
    self.infoAttr.money_gold = self.infoAttr.money_gold + money
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, {id = self.mData.id, attr = self.infoAttr})
end

--添加银币
function addMoney_Silver(self, money)
    self.infoAttr.money_silver = self.infoAttr.money_silver + money
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, {id = self.mData.id, attr = self.infoAttr})
end

function addMoveSpeed(self, speed)
    self.infoAttr.speed = self.infoAttr.speed + speed
end

function setMoveDir(self, dir)
    self.infoAttr.move_dir = dir
end

--是否死亡
function isIdle(self)
    return self.mCurActionState == FieldExplorationConst.HERO_ACTION_STATE.IDLE
end

-- ---获取属性
function getAttr(self)
    return self.infoAttr
end

--------------------------------------------------其他公共
--无敌状态
function getInvincibleState(self)
    return GameManager:getClientTime() < self.mInvincibleStateEndTimeDt
end

function updateInvincibleEndTimeDt(self, endTimeDt)
    endTimeDt = endTimeDt or 0
    if endTimeDt > self.mInvincibleStateEndTimeDt then
        self.mInvincibleStateEndTimeDt = endTimeDt
    end
end

function setMoveMode(self, moveType)
    self.mLastMoveMode = self.mMoveMode
    self.mMoveMode = moveType
end

function resetMoveMode(self)
    if not self.mLastMoveMode then
        return
    end

    self.mMoveMode = self.mLastMoveMode
    self.mLastMoveMode = nil
end

--前进
function setTranForward(self, speed, forward)
    forward = forward or self:getTrans().forward
    if self.mHaveGrabSkill then
        self.m_Rigidbody:MovePosition(self:getTrans().position + forward * speed)
    else
        gs.UnityEngineUtil.CharacterControllerMove(self.m_CharacterController, forward * speed)
    end

end

function cameraFollow(self)
    local go_left = gs.GameObject.Find("viewportPoint_left")
    local go_right = gs.GameObject.Find("viewportPoint_right")
    if go_left == nil or gs.GoUtil.IsGoNull(go_left) or go_right == nil or gs.GoUtil.IsGoNull(go_right) then
        return
    end

    local sceneCamera = gs.CameraMgr:GetSceneCamera()
    local IsInView = function (position)
        local viewPos = sceneCamera:WorldToViewportPoint(position)
        if viewPos.x > 0 and viewPos.x < 1 and viewPos.y > 0 and viewPos.y < 1 and viewPos.z > 0 then
            return true
        end

        return false
    end

    local doWhile = function ()
        if IsInView(go_left.transform.position) == false then
            return true
        end

        if IsInView(go_right.transform.position) == false then
            return true
        end

        return false
    end

    while (doWhile()) do
        sceneCamera.transform:Translate(gs.VEC3_FORWARD * -1, gs.Space.Self)
    end
end

function getAllSkill(self)
    return self.mSkillDic
end

function getSkill(self, skillTid)
    if self.mSkillDic then
        return self.mSkillDic[skillTid]
    end
end

function getModel(self)
    return fieldExploration.FieldExplorationPlayerModel.new()
end

function getPrefabPath(self)
    local heroTid = self.mData.tid

    local config = hero.HeroCuteManager:getHeroCuteConfigVo(heroTid)
    if config then
        return config.mModelPrefab
    end
end

function clearTimeOutSn(self)
    if self.mTimeOutSn then
        LoopManager:clearTimeout(self.mTimeOutSn)
        self.mTimeOutSn = nil
    end
end

function recover(self)
    super.recover(self)

    for _, skill in pairs(self.mSkillDic) do
        skill:recover()
    end

    if self.mColliderCall and not gs.GoUtil.IsCompNull(self.mColliderCall) then
        gs.GameObject.Destroy(self.mColliderCall)
        self.mColliderCall = nil
    end

    self:removeEventListener()
    self:clearTimeOutSn()
end

return _M
