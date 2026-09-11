local ActivityAttributeArenaRankSwitchItem = class("ActivityAttributeArenaRankSwitchItem", ReduxView)

function ActivityAttributeArenaRankSwitchItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityAttributeArenaRankSwitchItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaRankSwitchItem:InitUI()
	self:BindCfgUI()

	self.selectedController = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityAttributeArenaRankSwitchItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function ActivityAttributeArenaRankSwitchItem:SetData(arg_6_1, arg_6_2)
	self.index = arg_6_1

	self.selectedController:SetSelectedState(arg_6_1 == arg_6_2 and "true" or "false")

	local var_6_0 = GetTips("ACTIVITY_ATTRIBUTE_RANK_" .. arg_6_1)

	self.labText_1.text = var_6_0
	self.labText_2.text = var_6_0
end

function ActivityAttributeArenaRankSwitchItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function ActivityAttributeArenaRankSwitchItem:Dispose()
	ActivityAttributeArenaRankSwitchItem.super.Dispose(self)
end

return ActivityAttributeArenaRankSwitchItem
