local SPHeroChallengeScheduleStartItem = class("SPHeroChallengeScheduleStartItem", ReduxView)

function SPHeroChallengeScheduleStartItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SPHeroChallengeScheduleStartItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeScheduleStartItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
end

function SPHeroChallengeScheduleStartItem:RefreshUI(arg_4_1)
	self.scheduleID = arg_4_1.scheduleID

	if not self.scheduleID then
		self.state = "empty"
		self.index = arg_4_1.index

		self.stateController:SetSelectedState("empty")
	else
		self.stateController:SetSelectedState("start")

		self.index = arg_4_1.index
		self.iconImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(self.scheduleID)
		self.nameText_.text = ActivityHeroChallengeScheduleCfg[self.scheduleID].name
		self.descText_.text = ActivityHeroChallengeScheduleCfg[self.scheduleID].linkgame_des

		if arg_4_1.isFinish then
			self.stateController:SetSelectedState("grey")
		else
			self.stateController:SetSelectedState("start")
		end
	end
end

function SPHeroChallengeScheduleStartItem:AddUIListener()
	self:AddBtnListener(self.reduceBtn_, nil, function()
		local var_6_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_6_0 and self.scheduleID then
			var_6_0:RemoveScheduleInDailyList(self.scheduleID, self.index)
		end

		if self.cancelFunc then
			self.cancelFunc()
		end
	end)
end

function SPHeroChallengeScheduleStartItem:RegisterCancelCallBack(arg_7_1)
	if arg_7_1 then
		self.cancelFunc = arg_7_1
	end
end

function SPHeroChallengeScheduleStartItem:Dispose()
	SPHeroChallengeScheduleStartItem.super.Dispose(self)
end

return SPHeroChallengeScheduleStartItem
