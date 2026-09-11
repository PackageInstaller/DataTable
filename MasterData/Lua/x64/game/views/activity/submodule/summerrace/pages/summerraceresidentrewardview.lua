local SummerRaceResidentRewardView = class("SummerRaceResidentRewardView", (import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")))

local function var_0_1()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_NORMAL_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_2(arg_2_0)
	arg_2_0.windowBarBackHandler_ = arg_2_0.windowBarBackHandler_ or function()
		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_2_0.windowBarBackHandler_)
end

local function var_0_3(arg_4_0)
	if arg_4_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_4_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

local function var_0_5(arg_6_0)
	local var_6_0

	if AssignmentCfg and AssignmentCfg.get_id_list_by_activity_id then
		var_6_0 = AssignmentCfg.get_id_list_by_activity_id[arg_6_0] or {}
	end

	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if TaskData2:GetTaskComplete(iter_6_1) then
			var_6_1 = var_6_1 + 1
		elseif AssignmentCfg[iter_6_1] ~= nil and AssignmentCfg[iter_6_1].need <= TaskData2:GetTaskProgress(iter_6_1) then
			var_6_1 = var_6_1 + 1
		end
	end

	return var_6_1, #var_6_0
end

function SummerRaceResidentRewardView:UIName()
	return "Widget/System/Activity_SummerRace/com/Activity_SummerRace_Renwu"
end

function SummerRaceResidentRewardView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_SUMMER_RACE_MAIN
end

function SummerRaceResidentRewardView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.receiveBtn_.transform, var_0_1())
end

function SummerRaceResidentRewardView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.receiveBtn_.transform, var_0_1())
end

function SummerRaceResidentRewardView:OnEnter()
	self:SetActivityID()
	SummerRaceResidentRewardView.super.OnEnter(self)
	self:UpdateBar()
end

function SummerRaceResidentRewardView:OnTop()
	self:UpdateBar()
end

function SummerRaceResidentRewardView:UpdateBar()
	var_0_2(self)
end

function SummerRaceResidentRewardView:SetLevelText()
	self.curLv_, self.maxLv_ = var_0_5(self.activityPointRewardActivityID_)

	if self.levelText_ ~= nil then
		self.levelText_.text = "<size=90><color=\"#F4D179\">" .. tostring(self.curLv_) .. "</color></size><color=\"#93847D\">/" .. tostring(self.maxLv_) .. "</color>"
	end
end

function SummerRaceResidentRewardView:UpdateView()
	self:SetActivityID()

	self.idList_ = self:GetLevelIDList()

	self:SetLevelText()

	self.receiveList_ = {}
	self.showIdList_ = {}

	local var_15_0 = 1
	local var_15_1 = true

	for iter_15_0, iter_15_1 in ipairs(self.idList_ or {}) do
		local var_15_3 = "lock"

		if AssignmentCfg[iter_15_1] ~= nil and TaskData2:GetTaskProgress(iter_15_1) >= AssignmentCfg[iter_15_1].need then
			if not TaskData2:GetTaskComplete(iter_15_1) then
				table.insert(self.receiveList_, iter_15_1)

				var_15_3 = "receive"
				var_15_1 = false
			else
				var_15_3 = "complete"

				if var_15_1 then
					var_15_0 = iter_15_0 + 1
				end
			end
		end

		table.insert(self.showIdList_, {
			id = iter_15_1,
			ind = iter_15_0,
			state = var_15_3
		})
	end

	if var_15_0 > #self.showIdList_ then
		var_15_0 = 1
	end

	self.levelLuaList_:StartScroll(#self.showIdList_, var_15_0)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function SummerRaceResidentRewardView:OnExit()
	SummerRaceResidentRewardView.super.OnExit(self)
	var_0_3(self)
end

function SummerRaceResidentRewardView:Dispose()
	var_0_3(self)

	self.windowBarBackHandler_ = nil

	SummerRaceResidentRewardView.super.Dispose(self)
end

return SummerRaceResidentRewardView
