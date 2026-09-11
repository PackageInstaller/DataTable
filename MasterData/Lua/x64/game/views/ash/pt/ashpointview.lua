local AshPointView = class("AshPointView", ReduxView)

function AshPointView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_Com_RewardTrustUI"
end

function AshPointView:UIParent()
	return manager.ui.uiMain.transform
end

function AshPointView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AshPointView:InitUI()
	self:BindCfgUI()

	self.trustItem_ = AshSystemTrustItem.New(self.trustGo_)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, AshSystemTrustViewItem)
	self.itemID_ = CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id
	self.updateHandler_ = handler(self, self.OnReceivePointReward)
	self.oneKeyController_ = self.mainControllerEx_:GetController("onekey")
end

function AshPointView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rewardIDList_[arg_5_1], arg_5_1)
end

function AshPointView:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(self.rewardIDList_) do
			if AshSystemData:GetHomologyRate() >= ActivityPointRewardCfg[iter_7_1].need and not AshSystemData:GetPointRewardIsGet(iter_7_1) then
				table.insert(var_7_1, iter_7_1)
			end
		end

		ActivityPointAction.ReceivePointReward(var_7_1)
		AshSystemData:UpdateTaskRedPoint()
	end)
end

function AshPointView:OnEnter()
	self.list_:StartScroll(#self.rewardIDList_, (self:RefreshUI()))
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, self.updateHandler_)
end

function AshPointView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AshPointView:RefreshUI()
	self.trustItem_:RefreshUI()

	self.rewardIDList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_MAIN] or {}

	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(self.rewardIDList_) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id) >= ActivityPointRewardCfg[iter_10_1].need and not AshSystemData:GetPointRewardIsGet(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	local var_10_1 = 1

	for iter_10_2, iter_10_3 in pairs(self.rewardIDList_) do
		if not AshSystemData:GetPointRewardIsGet(iter_10_3) then
			var_10_1 = iter_10_2

			break
		end
	end

	if var_10_0 then
		self.oneKeyController_:SetSelectedState("true")
	else
		self.oneKeyController_:SetSelectedState("false")
	end

	return var_10_1
end

function AshPointView:OnReceivePointReward(arg_11_1)
	AshSystemData:UpdatePointRed()
	self.list_:StartScroll(#self.rewardIDList_, (self:RefreshUI()))
end

function AshPointView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(RECEIVE_POINT_REWARD, self.updateHandler_)
end

function AshPointView:Dispose()
	self.super.Dispose(self)
	self.trustItem_:Dispose()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.updateHandler_ = nil
end

return AshPointView
