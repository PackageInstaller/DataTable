local SkuldSystemTrustView = class("SkuldSystemTrustView", ReduxView)

function SkuldSystemTrustView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_RewardTrustUI"
end

function SkuldSystemTrustView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldSystemTrustView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldSystemTrustView:InitUI()
	self:BindCfgUI()

	self.trustItem_ = SkuldSystemTrustItem.New(self.trustGo_)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SkuldSystemTrustViewItem)
	self.itemID_ = CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id
	self.updateHandler_ = handler(self, self.OnReceivePointReward)
	self.oneKeyController_ = self.controllerEx_:GetController("onekey")
end

function SkuldSystemTrustView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rewardIDList_[arg_5_1])
end

function SkuldSystemTrustView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(self.rewardIDList_) do
			if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_7_1].need and not SkuldSystemData:GetPointRewardIsGet(iter_7_1) then
				table.insert(var_7_1, iter_7_1)
			end
		end

		ActivityAction.ReceivePointReward(var_7_1)
	end)
end

function SkuldSystemTrustView:OnEnter()
	self.trustItem_:RefreshUI()

	self.rewardIDList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]

	local var_8_0 = false

	for iter_8_0, iter_8_1 in pairs(self.rewardIDList_) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_8_1].need and not SkuldSystemData:GetPointRewardIsGet(iter_8_1) then
			var_8_0 = true

			break
		end
	end

	local var_8_1 = 0

	for iter_8_2, iter_8_3 in pairs(self.rewardIDList_) do
		if not SkuldSystemData:GetPointRewardIsGet(iter_8_3) then
			var_8_1 = iter_8_2 == 1 and iter_8_2 or iter_8_2

			break
		end
	end

	if var_8_0 then
		self.oneKeyController_:SetSelectedState("true")
	else
		self.oneKeyController_:SetSelectedState("false")
	end

	self.list_:StartScroll(#self.rewardIDList_, var_8_1)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, self.updateHandler_)
end

function SkuldSystemTrustView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SkuldSystemData:UpdateSkuldPointRewardRedPoint()
end

function SkuldSystemTrustView:OnReceivePointReward(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		SkuldSystemData:GetPointReward(iter_10_1)
	end

	self.list_:Refresh()

	local var_10_0 = false

	for iter_10_2, iter_10_3 in pairs(self.rewardIDList_) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_10_3].need and not SkuldSystemData:GetPointRewardIsGet(iter_10_3) then
			var_10_0 = true

			break
		end
	end

	if var_10_0 then
		self.oneKeyController_:SetSelectedState("true")
	else
		self.oneKeyController_:SetSelectedState("false")
	end
end

function SkuldSystemTrustView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(RECEIVE_POINT_REWARD, self.updateHandler_)
end

function SkuldSystemTrustView:Dispose()
	self.super.Dispose(self)
	self.trustItem_:Dispose()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.updateHandler_ = nil
end

return SkuldSystemTrustView
