local AutoChessSkinDlcView = class("AutoChessSkinDlcView", ReduxView)

function AutoChessSkinDlcView:UIName()
	return "Widget/Version/V4_5_Horus/V4_5_Horus_SkinDLCUI/V4_5_Horus_SkinDLCPopUI"
end

function AutoChessSkinDlcView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessSkinDlcView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessSkinDlcView:InitUI()
	self:BindCfgUI()

	self.taskList = {}

	for iter_4_0 = 1, 2 do
		self.taskList[iter_4_0] = CommonActivityTaskItem.New(self[string.format("item%s_", iter_4_0)])
	end
end

function AutoChessSkinDlcView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function AutoChessSkinDlcView:OnEnter()
	self.activityID_ = ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	self.descText_.text = GetTips("AUTO_CHESS_SKIN_POP_DESC")

	self:RefreshUI()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshUI()
	end)
end

function AutoChessSkinDlcView:RefreshUI()
	local var_9_0 = AssignmentCfg.get_id_list_by_activity_id[self.activityID_] or {}

	for iter_9_0, iter_9_1 in ipairs(self.taskList) do
		if var_9_0[iter_9_0] then
			iter_9_1:RefreshTaskItem(var_9_0[iter_9_0])
		end
	end
end

function AutoChessSkinDlcView:OnExit()
	self:RemoveAllEventListener()
end

function AutoChessSkinDlcView:Dispose()
	self:RemoveAllEventListener()

	for iter_11_0, iter_11_1 in pairs(self.taskList or {}) do
		iter_11_1:Dispose()

		iter_11_1 = nil
	end

	AutoChessSkinDlcView.super.Dispose(self)
end

return AutoChessSkinDlcView
