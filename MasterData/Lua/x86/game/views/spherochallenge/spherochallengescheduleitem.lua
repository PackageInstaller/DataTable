local SPHeroChallengeScheduleItem = class("SPHeroChallengeScheduleItem", ReduxView)

function SPHeroChallengeScheduleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SPHeroChallengeScheduleItem:Init()
	self:InitUI()
end

function SPHeroChallengeScheduleItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("State")
end

function SPHeroChallengeScheduleItem:RefreshUI(arg_4_1)
	local var_4_0 = SPHeroChallengeData:GetCurActivityInfo()

	if var_4_0 then
		local var_4_1 = var_4_0:GetStartListScheduleInfoByList(arg_4_1)

		if var_4_1 then
			self.imageImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(var_4_1.scheduleID)
			self.schedulenameText_.text = ActivityHeroChallengeScheduleCfg[var_4_1.scheduleID].name
			self.scheduledescText_.text = ActivityHeroChallengeScheduleCfg[var_4_1.scheduleID].linkgame_des

			if var_4_1.isFinish then
				self.stateController:SetSelectedState("Done")
			else
				self.stateController:SetSelectedState("Normal")
			end
		else
			self.stateController:SetSelectedState("add")
		end
	end
end

function SPHeroChallengeScheduleItem:AddUIListener()
	self:AddBtnListener(self.addBtn_, nil, function()
		if self.state == "empty" then
			JumpTools.OpenPageByJump("/spHeroChallengeScheduleView")
		end
	end)
end

function SPHeroChallengeScheduleItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	SPHeroChallengeScheduleItem.super.Dispose(self)
end

return SPHeroChallengeScheduleItem
