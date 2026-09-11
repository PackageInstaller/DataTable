local DrawServantSelectView = class("DrawServantSelectView", ReduxView)

function DrawServantSelectView:UIName()
	return "Widget/System/Pool/TreasurePop"
end

function DrawServantSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function DrawServantSelectView:Init()
	self.selectID_ = nil

	self:InitUI()
	self:AddUIListener()
end

function DrawServantSelectView:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DrawServantSelectItem)
	self.btnController = self.controller_:GetController("btn")
end

function DrawServantSelectView:AddUIListener()
	self:AddBtnListener(self.btnrenewalBtn_, nil, function()
		if DrawData:GetPollUpID(self.poolID_) == self.selectID_ then
			ShowTips("DRAW_NOT_SELECT_WEAPON_TIPS")

			return
		end

		DrawAction.SetPollUpID(self.poolID_, self.selectID_)
	end)
end

function DrawServantSelectView:OnSetPollUpID(arg_7_1, arg_7_2)
	self:Back()

	self.selectID_ = nil
end

function DrawServantSelectView:indexItem(arg_8_1, arg_8_2)
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

function DrawServantSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function DrawServantSelectView:UpdateData()
	self.itemList_ = {}
	self.itemList_ = deepClone(DrawPoolCfg[self.poolID_].optional_lists_poolId)
end

function DrawServantSelectView:OnEnter()
	self.poolID_ = 10002
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

function DrawServantSelectView:RefreshTitle(arg_13_1)
	local var_13_0 = DrawPoolCfg[self.poolID_]
	local var_13_1 = table.indexof(DrawPoolCfg[self.poolID_].optional_lists_poolId, arg_13_1)

	self.btnController:SetSelectedState(DrawData:GetPollUpID(self.poolID_) ~= self.selectID_ and "true" or "current")

	if var_13_1 and var_13_0.optional_detail[var_13_1] then
		self.titleText_.text = string.format(GetTips("CHOOSE_SERVANT_COMBINATION"), GetI18NText(RaceEffectCfg[WeaponServantCfg[var_13_0.optional_detail[var_13_1]].race].name))
	end
end

function DrawServantSelectView:Dispose()
	self.scrollHelper:Dispose()
	DrawServantSelectView.super.Dispose(self)
end

return DrawServantSelectView
