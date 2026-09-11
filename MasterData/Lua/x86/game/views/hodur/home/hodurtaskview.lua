local HodurTaskView = class("HodurTaskView", (import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")))

function HodurTaskView:UIName()
	return "Widget/System/Activity_Hodur/Com/Activity_Hodur_RewardTrustUI"
end

function HodurTaskView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_HODUR_MAIN
end

function HodurTaskView:UpdateView()
	self:SetLevelText()

	self.receiveList_ = {}
	self.showIdList_ = {}

	local var_3_0 = 1
	local var_3_1 = true

	for iter_3_0, iter_3_1 in ipairs(self.idList_) do
		local var_3_2 = TaskData2:GetTask(iter_3_1)
		local var_3_3 = "lock"

		if var_3_2.progress >= AssignmentCfg[iter_3_1].need then
			if var_3_2.complete_flag < 1 then
				table.insert(self.receiveList_, iter_3_1)

				var_3_3 = "receive"
				var_3_1 = false
			else
				var_3_3 = "complete"

				if var_3_1 then
					var_3_0 = iter_3_0 + 1
				end
			end
		end

		table.insert(self.showIdList_, {
			id = iter_3_1,
			ind = iter_3_0,
			state = var_3_3
		})
	end

	if var_3_0 > #self.showIdList_ then
		var_3_0 = 1
	end

	self.levelLuaList_:StartScroll(#self.showIdList_, var_3_0)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function HodurTaskView:SetLevelText()
	self.curLv_ = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_HODUR_MAIN)
	self.maxLv_ = #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]
	self.levelText_.text = self.curLv_ .. "/" .. self.maxLv_
	self.progressImg_.fillAmount = self.curLv_ / self.maxLv_
end

return HodurTaskView
