-- @FileName:   FieldExplorationPlayerGrabSkill.lua
-- @Description:   玩家推箱子抓取技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.player.FieldExplorationPlayerGrabSkill', Class.impl(fieldExploration.FieldExplorationPlayerBaseSkill))

function setData(self, skillConfig, playerTing)
    super.setData(self, skillConfig, playerTing)

    self:onDisableSkill()
    self:initColliderUtil()
end

function resetData(self)
    super.resetData(self)

    --抓取状态
    self.isShowSkillEffect = false
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
    self.mTargetThing = fieldExploration.FieldExplorationSceneController:getSceneEvent(eventID)
    if not self.mTargetThing then
        return
    end

    local eventData = self.mTargetThing:getData()
    local eventConfig = fieldExploration.FieldExplorationManager:getEventConfigVo(eventData.tid)
    for _, skill_id in pairs(eventConfig.skill_id) do
        for _, activeSkill_id in pairs(self.config.effect) do
            if skill_id == activeSkill_id then
                self:onActiveSkill()
                self:onRefreshUIEffect(true)
                return
            end
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
    local eventConfig = fieldExploration.FieldExplorationManager:getEventConfigVo(eventData.tid)
    for _, skill_id in pairs(eventConfig.skill_id) do
        for _, activeSkill_id in pairs(self.config.effect) do
            if skill_id == activeSkill_id and eventData.id == self.mTargetThing:getData().id then
                self:onDisableSkill()
                return
            end
        end
    end
end

--实现技能效果
function onExecuteEffect(self)
    if not self.mTargetThing then
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
    self.mPlayerTing:setStandState(FieldExplorationConst.HERO_ACTION_STATE.GRAB)

    self.mTargetThing:onSkillExecute(self.mPlayerTing)

    self.isShowSkillEffect = true
    self:addBuff()
    self:addSkillEffect()
end

function onReleaseThing(self)
    self.mPlayerTing:setStandState(FieldExplorationConst.HERO_ACTION_STATE.STAND)

    self.mTargetThing:onSkillCancel()
    self:onDisableSkill()

    self:onFinishSkill()
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

return _M
