-- @FileName:   FieldExplorationPlayerLiftSkill.lua
-- @Description:   玩家举箱子技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.player.FieldExplorationPlayerLiftSkill', Class.impl(fieldExploration.FieldExplorationPlayerBaseSkill))

function setData(self, skillConfig, playerTing)
    super.setData(self, skillConfig, playerTing)

    self:onDisableSkill()
    self:initColliderUtil()
end

function resetData(self)
    super.resetData(self)

    --抓取状态
    self.isShowSkillEffect = false

    --播放动作中
    self.isPlayAnima = false
    --当前禁用状态
    self.mCurDisable = true
end

--提示器碰撞触发
function onTriggerStayCall(self, tag, colliderTagID)
    if self.isShowSkillEffect then
        return
    end

    if self.mTargetThing then
        return
    end

    local eventID = colliderTagID
    local targetThing = fieldExploration.FieldExplorationSceneController:getSceneEvent(eventID)
    if not targetThing then
        return
    end

    local eventData = targetThing:getData()
    for _, activeEvent_id in pairs(self.config.effect) do
        if eventData.tid == activeEvent_id then
            self.mTargetThing = targetThing
            self:onActiveSkill()
            self:onRefreshUIEffect(true)
            return
        end
    end

end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)
    if self.isShowSkillEffect then
        return
    end

    if not self.mTargetThing then
        return
    end

    local eventID = colliderTagID
    local eventThing = fieldExploration.FieldExplorationSceneController:getSceneEvent(eventID)
    if not eventThing then
        return
    end

    local eventData = self.mTargetThing:getData()
    for _, activeEvent_id in pairs(self.config.effect) do
        if eventData.tid == activeEvent_id and eventData.id == self.mTargetThing:getData().id then
            self:onDisableSkill()
            return
        end
    end
end

--实现技能效果
function onExecuteEffect(self)
    if not self.mTargetThing then
        return
    end

    if self.isPlayAnima then
        return
    end

    if not self.isShowSkillEffect then
        self:onGrabThing()
    else
        self:onReleaseThing()
    end

    self.mLastExecuteTime = self.mCurMSTime
end

function onGrabThing(self)
    self.mPlayerTing:setMoveMode(FieldExplorationConst.PlayerMoveType.None)
    self.mPlayerTing:setStandState(FieldExplorationConst.HERO_ACTION_STATE.LIFT)

    local box_node = self.mPlayerTing:FindNameInChilds("Hit_node")
    gs.TransQuick:SetParentOrg(self.mTargetThing:getTrans(), box_node)

    local startCall = function ()
        self.isPlayAnima = true
    end

    local endCall = function ()
        self.isPlayAnima = false

        self.mPlayerTing:resetMoveMode()
        self.mPlayerTing:setMoveMode(FieldExplorationConst.PlayerMoveType.Lift_Mode)
        self.mPlayerTing:setStandState(FieldExplorationConst.HERO_ACTION_STATE.LIFT)

        -- self.mTargetThing:recoverColliderGo()
        self.mTargetThing:enabledCollider(false)
    end
    self.mPlayerTing:playAction(FieldExplorationConst.ACT_BOXUP, startCall, endCall)

    self.isShowSkillEffect = true
    self:addBuff()
    self:addSkillEffect()
end

function onReleaseThing(self)
    self.mPlayerTing:resetMoveMode()
    self.mPlayerTing:setMoveMode(FieldExplorationConst.PlayerMoveType.None)

    local startCall = function ()
        self.isPlayAnima = true
    end

    local endCall = function ()
        self.isPlayAnima = false

        self:onFinishSkill()
        self:onDisableSkill()
    end
    self.mPlayerTing:playAction(FieldExplorationConst.ACT_BOXDOWN, startCall, endCall)
end

--技能效果结束
function onFinishSkill(self)
    super.onFinishSkill(self)
    if self.mTargetThing then
        self.mTargetThing:setParent(nil)
        -- self.mTargetThing:addCollider()
        self.mTargetThing:enabledCollider(true)
    end

    self.mPlayerTing:resetMoveMode()
    self.mPlayerTing:setStandState(FieldExplorationConst.HERO_ACTION_STATE.STAND)
end

function onDisableSkill(self)
    super.onDisableSkill(self)

    self:onRefreshUIEffect(false)
    self.mTargetThing = nil
end

--是否可以执行技能
function isCanExecute(self)
    if self.mPlayerTing:isIdle() then
        return false
    end

    if self.mCurMSTime - self.mLastExecuteTime < self.config.cd_time then
        return false
    end

    if self.mCurDisable then
        return false
    end

    local skilList = self.mPlayerTing:getAllSkill()
    for skillTid, skill in pairs(skilList) do
        if skillTid ~= self.skill_Tid then
            if skill:getIsShowSkillEffect() then
                return false
            end
        end
    end

    return true
end

-- -- 回收
-- function recover(self)
--     super.recover(self)

--     self:clearTimeOutSn()
-- end

return _M
