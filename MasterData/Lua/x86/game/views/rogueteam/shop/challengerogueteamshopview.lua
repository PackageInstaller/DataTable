local ChallengeRogueTeamShopView = class("ChallengeRogueTeamShopView", ReduxView)

function ChallengeRogueTeamShopView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeTreasureshopUI"
end

function ChallengeRogueTeamShopView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamShopView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.treasureItemList_ = {}
	self.relicItemList_ = {}
	self.onBuyItemSuccessHandler_ = handler(self, self.OnBuyItemSuccess)
	self.updateOperateHandler_ = handler(self, self.OnUpdateOperate)
	self.onWindowUpdateHandler_ = handler(self, self.OnWindowUpdate)
	self.onSelectedItemHandler_ = handler(self, self.OnSelectedItem)
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureBtnGo_, handler(self, self.OnClickBtn))
	self.itemPopView_ = ChallengeRogueTeamShopPopItemView.New(self.shopPopItemGo_)
	self.popControllerEx_ = self.controllerEx_:GetController("pop")
	self.camcelControllerEx_ = self.controllerEx_:GetController("cancel")
	self.refreshControllerEx_ = self.controllerEx_:GetController("flushed")
	self.expressionController_ = self.expressionControllerEx_:GetController("face")
end

function ChallengeRogueTeamShopView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick(function()
		if self.popFlag_ then
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED)

			return false
		end

		return true
	end)
	ChallengeRogueTeamTools.ShowBarList()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_BUY_SUCCESS, self.onBuyItemSuccessHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, self.updateOperateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, self.onWindowUpdateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED, self.onSelectedItemHandler_)

	self.refreshConut_ = 1

	self:RefreshUI()
	self:RefreshItemList()

	if self.params_.isBack ~= true then
		self:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.WELCOM)
	end

	self.confirmExitFlag_ = false
	self.selectItemData_ = nil
	self.popFlag_ = false

	self:RefreshPopWindow()
	self:RefreshBGM()
end

function ChallengeRogueTeamShopView:OnExit()
	self.refreshConut_ = 1

	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_BUY_SUCCESS, self.onBuyItemSuccessHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, self.updateOperateHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, self.onWindowUpdateHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED, self.onSelectedItemHandler_)
end

function ChallengeRogueTeamShopView:OnTop()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
end

function ChallengeRogueTeamShopView:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.treasureItemList_) do
		iter_8_1:Dispose()
	end

	self.treasureItemList_ = nil

	for iter_8_2, iter_8_3 in ipairs(self.relicItemList_) do
		iter_8_3:Dispose()
	end

	self.relicItemList_ = nil

	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil

	self.itemPopView_:Dispose()

	self.itemPopView_ = nil
	self.onBuyItemSuccessHandler_ = nil
	self.updateOperateHandler_ = nil
	self.onWindowUpdateHandler_ = nil
	self.onSelectedItemHandler_ = nil

	ChallengeRogueTeamShopView.super.Dispose(self)
end

function ChallengeRogueTeamShopView:AddListeners()
	self:AddBtnListener(self.npcBtn_, nil, function()
		self:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.CLICK_MERCHANT, 1)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self.confirmExitFlag_ = false

		self:RefreshPopWindow()
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		if not self.isCanRefresh_ then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetTips("ROGUE_TEAM_GOLD")))

			return
		end

		ChallengeRogueTeamAction.RefreshShopItem()
	end)
end

function ChallengeRogueTeamShopView:OnClickBtn()
	if self.selectItemData_ then
		if ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD) < math.ceil(ChallengeRogueTeamTools.GetShopItemDefaultPrice(self.selectItemData_.id, self.selectItemData_.rare) * self.selectItemData_.discount / 100) then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetTips("ROGUE_TEAM_GOLD")))

			return
		end

		local var_13_0 = self.selectItemData_.discount

		ChallengeRogueTeamAction.ShopBuyItem(self.selectItemData_.index, function()
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED)
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_BUY_SUCCESS, var_13_0)
		end)
	else
		if self.confirmExitFlag_ ~= true then
			self.confirmExitFlag_ = true

			self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.CONFIRM_EXIT, ChallengeRogueTeamButton.BUTTON_TEXT.CONFIRM_EXIT)
			self.camcelControllerEx_:SetSelectedState("true")

			return
		end

		ChallengeRogueTeamAction.ShopBuyItem(0, function()
			self:Back()
		end)
	end
end

function ChallengeRogueTeamShopView:RefrshShopText(arg_16_1, arg_16_2)
	local var_16_0 = ChallengeRogueTeamTools.GetShopVoiceID(arg_16_1, arg_16_2, self.lastVoiceID_)

	self.lastVoiceID_ = var_16_0
	self.npcText_.text = RogueTeamShopVoiceCfg[var_16_0].desc

	self.expressionController_:SetSelectedState(RogueTeamShopVoiceCfg[var_16_0].expression_name)
end

function ChallengeRogueTeamShopView:OnBuyItemSuccess(arg_17_1)
	self:RefreshItemList()
	self:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.BUY_SUCCESS, (arg_17_1 >= 100 or nil) and (ChallengeRogueTeamConst.SHOP_BUY_ITEM_TYPE.BUY_ORIGIN or ChallengeRogueTeamConst.SHOP_BUY_ITEM_TYPE.BUY_DISCOUNT))
end

function ChallengeRogueTeamShopView:OnUpdateOperate()
	self:RefreshItemList()
	self:UpdateShopRefreshCost()
end

function ChallengeRogueTeamShopView:OnWindowUpdate()
	if not self:IsTop() then
		return
	end

	self:PopWindowProcess()
	self:RefreshItemList()
end

function ChallengeRogueTeamShopView:PopWindowProcess()
	if ChallengeRogueTeamAction.PopWindowProcessSystem() == false then
		ChallengeRogueTeamAction.PopOperateWindowProcessSystem()
	end
end

function ChallengeRogueTeamShopView:OnSelectedItem(arg_21_1)
	self.selectItemData_ = arg_21_1
	self.popFlag_ = arg_21_1 ~= nil

	self:RefreshPopWindow()
end

function ChallengeRogueTeamShopView:RefreshUI()
	self.isRefreshShop_ = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_REFRESH) > 0

	self.refreshControllerEx_:SetSelectedState(self.isRefreshShop_ and "on" or "off")
	self:UpdateShopRefreshCost()
end

function ChallengeRogueTeamShopView:UpdateShopRefreshCost()
	if not self.isRefreshShop_ then
		return
	end

	local var_23_0 = ChallengeRogueTeamConst.SHOP_REFRESH_COST * math.pow(2, ChallengeRogueTeamData:GetShopData().refreshTimes or 0)

	self.refreshCostText_.text = var_23_0
	self.isCanRefresh_ = var_23_0 <= ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD)

	if self.isCanRefresh_ then
		self.refreshControllerEx_:SetSelectedState("on")
	else
		self.refreshControllerEx_:SetSelectedState("red")
	end
end

function ChallengeRogueTeamShopView:RefreshItemList()
	local var_24_0 = ChallengeRogueTeamTools.GetShopItemList()

	for iter_24_0 = 1, 4 do
		self.treasureItemList_[iter_24_0] = self.treasureItemList_[iter_24_0] or ChallengeRogueTeamShopItem.New(self.item_, self.treasureParent_, ChallengeRogueTeamConst.ITEM_TYPE.TREASURE, iter_24_0)

		self.treasureItemList_[iter_24_0]:SetData(var_24_0[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE][iter_24_0])
	end

	for iter_24_1 = 1, 4 do
		self.relicItemList_[iter_24_1] = self.relicItemList_[iter_24_1] or ChallengeRogueTeamShopItem.New(self.item_, self.relicParent_, ChallengeRogueTeamConst.ITEM_TYPE.RELIC, iter_24_1)

		self.relicItemList_[iter_24_1]:SetData(var_24_0[ChallengeRogueTeamConst.ITEM_TYPE.RELIC][iter_24_1])
	end
end

function ChallengeRogueTeamShopView:RefreshPopWindow()
	if self.popFlag_ then
		self.confirmExitFlag_ = false

		self.itemPopView_:SetData(self.selectItemData_)
		self.popControllerEx_:SetSelectedState("state1")
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.GOLD_COLOR, ChallengeRogueTeamButton.BUTTON_TEXT.CONFIRM_ORDER)
		self:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.SELECT_ITEM, (self.selectItemData_.discount >= 100 or nil) and (ChallengeRogueTeamConst.SHOP_SELECT_ITEM_TYPE.SELECT_ORIGIN or ChallengeRogueTeamConst.SHOP_SELECT_ITEM_TYPE.SELECT_DISCOUNT))
	else
		self.popControllerEx_:SetSelectedState("state0")
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.CANCLE, ChallengeRogueTeamButton.BUTTON_TEXT.EXIT)
		self.camcelControllerEx_:SetSelectedState("false")
	end
end

function ChallengeRogueTeamShopView:RefreshBGM()
	local var_26_0 = RogueTeamRoomTypeCfg[RogueTeamRoomTypeCfg.get_id_list_by_temp_id_id[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].room_temp][ChallengeRogueTeamConst.NODE_TYPE.SHOP][1]]

	if var_26_0.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_26_0.cue_sheet, var_26_0.cue_name, var_26_0.awb)
	end
end

return ChallengeRogueTeamShopView
