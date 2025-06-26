-- @FileName:   FieldExplorationPlayerBaseSkill.lua
-- @Description:   站员技能基类
-- @Author: ZDH
-- @Date:   2023-07-31 14:38:48
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.player.FieldExplorationPlayerBaseSkill', Class.impl())

function setData(self, skillConfig, playerTing)
    self.skill_Tid = skillConfig.skillTid
    self.config = skillConfig
    self.mPlayerTing = playerTing

    self:resetData()
end

function initColliderUtil(self)
    if self.config.damage_type == FieldExplorationConst.Collider_Type.None then
        return
    end

    if not self.mGo or gs.GoUtil.IsGoNull(self.mGo) then
        self.mGo = gs.GameObject()
        self.mGo.name = "Collider_" .. self.skill_Tid

        self.mTran = self.mGo.transform
        self.mTran:SetParent(self.mPlayerTing:getTrans(), false)
        self.mTran.localPosition = gs.VEC3_ZERO
    end

    self.mColliderCall = self.mGo:GetComponent(ty.ColliderCall)
    if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall = self.mGo:AddComponent(ty.ColliderCall)

        if self.config.damage_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
            self.mColliderCall:InitCapsuleCollider(self.config.damage_range[1] * 0.01, 1)
        elseif self.config.damage_type == FieldExplorationConst.Collider_Type.BoxCollider then
            self.mColliderCall:InitBoxCollider(self.config.damage_range[1] * 0.01, 1, self.config.damage_range[2] * 0.01)
        elseif self.config.damage_type == FieldExplorationConst.Collider_Type.SelfCollider then
            self.mColliderCall:InitSelfCollider()
        elseif self.config.damage_type == FieldExplorationConst.Collider_Type.SectorCollider then
            self.mColliderCall:InitSectorCollider(self.config.damage_range[1] * 0.01, self.config.damage_range[2], 1)
        end

        self.mColliderCall:OpenColliderCheck()
        self.mColliderCall:AddColliderTags(self:getColliderTags())
        self.mColliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.PlayerSkill

        self.mColliderCall.IsTrigger = true

        self.mColliderCall.onTriggerEnterCall = function (tag, colliderTagID)
            if tag == "AirWall" then
                return
            end
            self:onTriggerEnterCall(tag, colliderTagID)
        end

        self.mColliderCall.onTriggerStayCall = function (tag, colliderTagID)
            if tag == "AirWall" then
                return
            end
            self:onTriggerStayCall(tag, colliderTagID)
        end

        self.mColliderCall.onTriggerExitCall = function (tag, colliderTagID)
            if tag == "AirWall" then
                return
            end
            self:onTriggerExitCall(tag, colliderTagID)
        end
    end
end

function resetData(self)
    --上一次执行技能时间(-1标识技能CD完成)
    self.mLastExecuteTime = 0
    --开始恢复使用次数的时间
    self.mStartReplyCountTime = 0

    --最大释放次数
    self.mMaxUse_count = self.config.max_useCount

    --当前可释放次数
    self.mCurUse_count = self.mMaxUse_count

    --当前的时间（毫秒）
    self.mCurMSTime = GameManager:getClientMSTime()

    --当前禁用状态
    self.mCurDisable = false

    --是否展示技能效果
    self.isShowSkillEffect = false

    -- if self.mMaxUse_count > 0 then
    if not self.mFrameSn then
        self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
    end
    -- end
end

--提示器碰撞触发
function onTriggerEnterCall(self, tag, colliderTagID)

end

function onTriggerStayCall(self, tag, colliderTagID)

end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)

end

--执行技能
function onExecute(self)
    if self:isCanExecute() then
        self:onExecuteEffect()
    end
end

--是否可以执行技能
function isCanExecute(self)
    if self.mPlayerTing:isIdle() then
        return false
    end

    local skillList = self.mPlayerTing:getAllSkill()
    for _, skill in pairs(skillList) do
        if skill:getIsShowSkillEffect() then
            return false
        end
    end

    if self.mMaxUse_count > 0 and self.mCurUse_count <= 0 then
        return false
    end

    if self.mCurMSTime - self.mLastExecuteTime < self.config.cd_time then
        return false
    end

    if self.mCurDisable then
        return false
    end

    return true
end

--实现技能效果
function onExecuteEffect(self)
    self.mLastExecuteTime = self.mCurMSTime
    self.isShowSkillEffect = true

    self:addBuff()
    self:addSkillEffect()
    self:addSoundEffct()
end

--技能效果结束
function onFinishSkill(self)
    self.isShowSkillEffect = false

    self:removeBuff()
    self:removeSkillEffect()
    self:removeSoundEffct()
end

function onFrame(self)
    self.mCurMSTime = self.mCurMSTime + (gs.Time.deltaTime * 1000)

    if self.mLastExecuteTime >= 0 then
        if self.mCurMSTime - self.mLastExecuteTime >= self.config.cd_time then
            self.mLastExecuteTime = -1
        end

        self:onRefreshUseCdTime(self.mCurMSTime - self.mLastExecuteTime, self.config.cd_time)
    end

    --恢复使用次数
    if self.mCurUse_count < self.mMaxUse_count then
        if self.mStartReplyCountTime <= 0 then
            self.mStartReplyCountTime = self.mCurMSTime
        end

        local CdTime = self.mCurMSTime - self.mStartReplyCountTime
        if CdTime >= self.config.use_cd_time then
            self.mStartReplyCountTime = -1

            self:refreshUseCount(self.mCurUse_count + 1)
        end

        self:onRefreshCdTime(CdTime, self.config.use_cd_time)
    end
end

function addBuff(self)
    self.m_buffList = {}
    if not table.empty(self.config.buff_id) then
        for _, buff_id in pairs(self.config.buff_id) do
            local buff = self.mPlayerTing:addBuff(buff_id, self)
            self.m_buffList[buff.m_snId] = buff
        end
    end
end

function addSkillEffect(self)
    self.mTrigger_effct = self.mPlayerTing:addEffect(self.config.trigger_effct[1])
end

function addSoundEffct(self)
    self.mTrigger_sound = self.mPlayerTing:addSoundEffct(self.config.trigger_sound)
end

function removeBuff(self)
    if self.mTargetThing then
        if self.m_buffList then
            for snId, buff in pairs(self.m_buffList) do
                self.mPlayerTing:removeBuff(snId)
            end
        end
    end
end

function removeSkillEffect(self)
    self.mPlayerTing:removeEffect(self.mTrigger_effct)
    self.mTrigger_effct = nil
end

function removeSoundEffct(self)
    self.mPlayerTing:removeSoundEffct(self.mTrigger_sound)
    self.mTrigger_sound = nil
end

--更新技能可使用次数
function onRefreshUseCount(self, count, maxCount)
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SKILL_REFRSHCOUNT_UPDATE, {skill_Tid = self.skill_Tid, count = count, max_count = maxCount})
end

--更新技能使用次数恢复CD倒计时
function onRefreshCdTime(self, curTime, maxTime)
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SKILL_REFRSHCDTIME_UPDATE, {skill_Tid = self.skill_Tid, time = curTime, max_time = maxTime})
end

--更新技能CD倒计时
function onRefreshUseCdTime(self, curTime, maxTime)
    --如果有使用次数限制的话。同时使用次数为0，切恢复时才大于CD时长，不显示CD
    if self.mMaxUse_count > 0 and self.mCurUse_count <= 0 and self.config.use_cd_time > self.config.cd_time then
        return
    end
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SKILL_USECDTIME_UPDATE, {skill_Tid = self.skill_Tid, time = curTime, max_time = maxTime})
end

--更新技能UI的特效显示
function onRefreshUIEffect(self, isShow)
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SKILL_UIEFFECT_UPDATE, {skill_Tid = self.skill_Tid, value = isShow})
end

--更新技能的禁用状态
function onActiveSkill(self)
    self.mCurDisable = false
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SKILL_STATE_UPDATE, {value = self.mCurDisable, skill_Tid = self.skill_Tid})
end

--更新技能的禁用状态
function onDisableSkill(self)
    self.mCurDisable = true
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SKILL_STATE_UPDATE, {value = self.mCurDisable, skill_Tid = self.skill_Tid})
end

function getSkillDisableState(self)
    return self.mCurDisable
end

--获取最大释放次数跟当前剩余释放次数
function getUseCount(self)
    return self.mCurUse_count, self.mMaxUse_count
end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Event}
end

function getIsShowSkillEffect(self)
    return self.isShowSkillEffect
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

-- 回收
function recover(self)
    self.skill_Tid = nil
    self.config = nil

    self.mLastExecuteTime = nil

    self.mMaxUse_count = nil
    self.mCurUse_count = nil

    self:clearFrameSn()

    if self.mColliderCall and not gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall.onTriggerEnterCall = nil
        self.mColliderCall.onTriggerExitCall = nil
        gs.GameObject.Destroy(self.mColliderCall)
        self.mColliderCall = nil
    end

    if self.mGo then
        gs.GameObject.Destroy(self.mGo)
        self.mGo = nil
        self.mTran = nil
    end
end

return _M
