BattleFailedView = import("game.views.battleFailed.BattleFailedView")

local XH3rdWaterBattleFailedView = class("XH3rdWaterBattleFailedView", BattleFailedView)

function XH3rdWaterBattleFailedView:OnEnter()
	XH3rdWaterBattleFailedView.super.OnEnter(self)

	local var_1_0, var_1_1 = self.stageData_:GetIsCooperation()

	if var_1_0 then
		SetActive(self.btnBattleCount_.gameObject, false)
	else
		SetActive(self.btnBattleCount_.gameObject, true)
	end
end

function XH3rdWaterBattleFailedView:OnExit()
	XH3rdWaterBattleFailedView.super.OnExit(self)
end

function XH3rdWaterBattleFailedView:GoToBattleStatistics()
	if self.isEnd then
		return
	end

	self.toStat_ = true

	self:RemoveTimer()
	JumpTools.OpenPageByJump("xH3rdWaterBattleStatistics", {
		stageData = self.stageData,
		battleTime = self:GetBattleTime()
	})
end

return XH3rdWaterBattleFailedView
