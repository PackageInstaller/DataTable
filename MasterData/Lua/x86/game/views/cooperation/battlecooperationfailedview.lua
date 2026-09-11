local BattleCooperationFailedView = class("BattleCooperationFailedView", BattleFailedView)

function BattleCooperationFailedView:OnEnter()
	BattleInstance.hideBattlePanel()
	self:RecordThreeStar()

	self.startTime = Time.realtimeSinceStartup
	self.isEnd = false

	if self.params_.data_math_error then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_DATA_ERROR"),
			OkCallback = function()
				self:Quit()
			end
		})
	else
		self:RemoveTimer()

		self.timer_ = Timer.New(function()
			self:Quit()
		end, self.stayTime, 1)

		self.timer_:Start()
	end

	self.battleTimeText_.text = self:GetBattleTime()

	self.animator_:Play("battleFailed")
end

function BattleCooperationFailedView:QuitUI()
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	if CooperationData:GetRoomData() then
		CooperationTools.GotoCooperation()
	else
		CooperationTools.GotoCooperationEntry(self.params_.stageData:GetType(), self.params_.stageData:GetDest(), self.params_.stageData:GetActivityID())
	end
end

function BattleCooperationFailedView:RecordThreeStar()
	return
end

return BattleCooperationFailedView
