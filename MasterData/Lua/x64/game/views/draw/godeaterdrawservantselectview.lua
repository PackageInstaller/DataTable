local GodEaterDrawServantSelectView = class("GodEaterDrawServantSelectView", ReduxView)

function GodEaterDrawServantSelectView:UIName()
	return "Widget/System/Pool/LinkageServantPoolSelectPopUI"
end

function GodEaterDrawServantSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function GodEaterDrawServantSelectView:Init()
	self.selectID_ = nil

	self:InitUI()
	self:AddUIListener()
end

function GodEaterDrawServantSelectView:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DrawServantSelectGodEaterItem)
	self.btnController = self.controller_:GetController("btn")
end

function GodEaterDrawServantSelectView:AddUIListener()
	self:AddBtnListener(self.btnrenewalBtn_, nil, function()
		if DrawData:GetPollUpID(self.poolID_) == self.selectID_ then
			ShowTips("DRAW_NOT_SELECT_WEAPON_TIPS")

			return
		end

		DrawAction.SetPollUpID(self.poolID_, self.selectID_)
	end)
end

function GodEaterDrawServantSelectView:OnSetPollUpID(arg_7_1, arg_7_2)
	self:Back()

	self.selectID_ = nil
end

function GodEaterDrawServantSelectView:indexItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_1, self.itemList_[arg_8_1], DrawPoolCfg[self.poolID_].optional_detail[arg_8_1])
	arg_8_2:ShowSelect(self.selectID_)
	arg_8_2:RegisterListener(function(arg_9_0)
		for iter_9_0, iter_9_1 in pairs((self.scrollHelper:GetItemList())) do
			iter_9_1:ShowSelect(arg_9_0)
		end

		self.selectID_ = arg_9_0

		self:RefreshTitle(self.selectID_)
	end)
end

function GodEaterDrawServantSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function GodEaterDrawServantSelectView:UpdateData()
	self.itemList_ = {}
	self.itemList_ = deepClone(DrawPoolCfg[self.poolID_].optional_lists_poolId)
end

function GodEaterDrawServantSelectView:OnEnter()
	self.poolID_ = self.params_.poolID
	self.selectID_ = nil or DrawData:GetPollUpID(self.poolID_)

	self:RefreshTitle(self.selectID_)

	if self.selectID_ ~= 0 then
		self.btnController:SetSelectedState("current")
	else
		self.titleText_.text = GetTips("DRAW_SELECT_WEAPON_TIPS")

		self.btnController:SetSelectedState("false")
	end

	self:UpdateData()
	self.scrollHelper:StartScroll(#self.itemList_)
end

function GodEaterDrawServantSelectView:RefreshTitle(arg_13_1)
	local var_13_0 = DrawPoolCfg[self.poolID_]
	local var_13_1 = table.indexof(DrawPoolCfg[self.poolID_].optional_lists_poolId, arg_13_1)

	self.btnController:SetSelectedState(DrawData:GetPollUpID(self.poolID_) ~= self.selectID_ and "true" or "current")

	if var_13_1 and var_13_0.optional_detail[var_13_1] then
		self.titleText_.text = string.format(GetTips("CHOOSE_SERVANT_COMBINATION"), ItemTools.getItemName(var_13_0.optional_detail[var_13_1]))
	end
end

function GodEaterDrawServantSelectView:Dispose()
	self.scrollHelper:Dispose()
	GodEaterDrawServantSelectView.super.Dispose(self)
end

return GodEaterDrawServantSelectView
