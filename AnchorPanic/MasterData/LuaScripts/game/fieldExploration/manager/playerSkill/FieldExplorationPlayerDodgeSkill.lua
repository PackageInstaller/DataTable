-- @FileName:   FieldExplorationPlayerDodgeSkill.lua
-- @Description:   站员闪避技能
-- @Author: ZDH
-- @Date:   2023-07-31 17:44:51
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.player.FieldExplorationPlayerDodgeSkill', Class.impl(fieldExploration.FieldExplorationPlayerBaseSkill))

function resetData(self)
    super.resetData(self)

    --闪避距离
    self.mDodge_Distance = self.config.effect[1] * 0.01
    --闪避最大速度
    self.mDodge_MaxSpeed = self.config.effect[2] * 0.01

    --是否展示技能效果
    self.isShowSkillEffect = false
end

--实现技能效果
function onExecuteEffect(self)
    super.onExecuteEffect(self)

    if self.mPlayerTing then
        self.mPlayerTing:setActionState(FieldExplorationConst.HERO_ACTION_STATE.DODGE)

        self.mDodgeSpeed = self.mDodge_MaxSpeed
        self.mCurForwardDistance = 0

        self:refreshUseCount(self.mCurUse_count - 1)
    end
end

function onFinishSkill(self)
    super.onFinishSkill(self)

    if self.mPlayerTing then
        self.mPlayerTing:stateRevert(FieldExplorationConst.HERO_ACTION_STATE.DODGE)
    end
end

--动画帧
function onFrame(self)
    super.onFrame(self)

    if self.isShowSkillEffect then
        self.mDodgeSpeed = gs.Mathf.Lerp(self.mDodgeSpeed, 0, gs.Time.deltaTime)
        self.mCurForwardDistance = self.mCurForwardDistance + self.mDodgeSpeed

        if self.mCurForwardDistance > self.mDodge_Distance then
            self:onFinishSkill()

            self.mDodgeSpeed = self.mDodge_Distance - self.mCurForwardDistance
        end

        self.mPlayerTing:setTranForward(self.mDodgeSpeed)
    end
end

function refreshUseCount(self, count)
    self.mCurUse_count = count
    self:onRefreshUseCount(self.mCurUse_count, self.mMaxUse_count)
end

return _M
