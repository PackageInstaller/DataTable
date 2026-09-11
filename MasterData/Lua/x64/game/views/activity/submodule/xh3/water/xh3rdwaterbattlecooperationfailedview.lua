BattleFailedView = import("game.views.battleFailed.BattleFailedView")

local XH3rdWaterBattleCooperationFailedView = class("XH3rdWaterBattleCooperationFailedView", BattleFailedView)

function XH3rdWaterBattleCooperationFailedView:OnEnter()
	XH3rdWaterBattleCooperationFailedView.super.OnEnter(self)

	local var_1_0, var_1_1 = self.params_.stageData:GetIsCooperation()

	if var_1_0 then
		SetActive(self.btnBattleCount_.gameObject, false)
	else
		SetActive(self.btnBattleCount_.gameObject, true)
	end
end

function XH3rdWaterBattleCooperationFailedView:OnExit()
	XH3rdWaterBattleCooperationFailedView.super.OnExit(self)
end

function XH3rdWaterBattleCooperationFailedView:GoToBattleStatistics()
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

function XH3rdWaterBattleCooperationFailedView:Quit()
	self.isEnd = true

	self:RemoveTimer()

	self.timer_ = Timer.New(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationTools.GotoCooperationEntry(self.params_.stageData:GetType(), self.params_.stageData:GetDest(), self.params_.stageData:GetActivityID())
		end
	end, 1, 1)

	self.timer_:Start()
	self.animator_:Play("battleFailed_out")
end

function XH3rdWaterBattleCooperationFailedView:RecordThreeStar()
	return
end

return XH3rdWaterBattleCooperationFailedView
