local var_0_0 = class("ChallengeRogueTeamShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeTreasureshopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.treasureItemList_ = {}
	arg_3_0.relicItemList_ = {}
	arg_3_0.onBuyItemSuccessHandler_ = handler(arg_3_0, arg_3_0.OnBuyItemSuccess)
	arg_3_0.updateOperateHandler_ = handler(arg_3_0, arg_3_0.OnUpdateOperate)
	arg_3_0.onWindowUpdateHandler_ = handler(arg_3_0, arg_3_0.OnWindowUpdate)
	arg_3_0.onSelectedItemHandler_ = handler(arg_3_0, arg_3_0.OnSelectedItem)
	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureBtnGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.itemPopView_ = ChallengeRogueTeamShopPopItemView.New(arg_3_0.shopPopItemGo_)
	arg_3_0.popControllerEx_ = arg_3_0.controllerEx_:GetController("pop")
	arg_3_0.camcelControllerEx_ = arg_3_0.controllerEx_:GetController("cancel")
	arg_3_0.refreshControllerEx_ = arg_3_0.controllerEx_:GetController("flushed")
	arg_3_0.expressionController_ = arg_3_0.expressionControllerEx_:GetController("face")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick(function()
		if arg_4_0.popFlag_ then
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED)

			return false
		end

		return true
	end)
	ChallengeRogueTeamTools.ShowBarList()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_BUY_SUCCESS, arg_4_0.onBuyItemSuccessHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, arg_4_0.updateOperateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, arg_4_0.onWindowUpdateHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED, arg_4_0.onSelectedItemHandler_)

	arg_4_0.refreshConut_ = 1

	arg_4_0:RefreshUI()
	arg_4_0:RefreshItemList()

	if arg_4_0.params_.isBack ~= true then
		arg_4_0:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.WELCOM)
	end

	arg_4_0.confirmExitFlag_ = false
	arg_4_0.selectItemData_ = nil
	arg_4_0.popFlag_ = false

	arg_4_0:RefreshPopWindow()
	arg_4_0:RefreshBGM()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.refreshConut_ = 1

	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_BUY_SUCCESS, arg_6_0.onBuyItemSuccessHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_OPERATE_WINDOW, arg_6_0.updateOperateHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW, arg_6_0.onWindowUpdateHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED, arg_6_0.onSelectedItemHandler_)
end

function var_0_0.OnTop(arg_7_0)
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.treasureItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.treasureItemList_ = nil

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.relicItemList_) do
		iter_8_3:Dispose()
	end

	arg_8_0.relicItemList_ = nil

	arg_8_0.rogueTeamSureBtnView_:Dispose()

	arg_8_0.rogueTeamSureBtnView_ = nil

	arg_8_0.itemPopView_:Dispose()

	arg_8_0.itemPopView_ = nil
	arg_8_0.onBuyItemSuccessHandler_ = nil
	arg_8_0.updateOperateHandler_ = nil
	arg_8_0.onWindowUpdateHandler_ = nil
	arg_8_0.onSelectedItemHandler_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.npcBtn_, nil, function()
		arg_9_0:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.CLICK_MERCHANT, 1)
	end)
	arg_9_0:AddBtnListener(arg_9_0.cancelBtn_, nil, function()
		arg_9_0.confirmExitFlag_ = false

		arg_9_0:RefreshPopWindow()
	end)
	arg_9_0:AddBtnListener(arg_9_0.refreshBtn_, nil, function()
		if not arg_9_0.isCanRefresh_ then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetTips("ROGUE_TEAM_GOLD")))

			return
		end

		ChallengeRogueTeamAction.RefreshShopItem()
	end)
end

function var_0_0.OnClickBtn(arg_13_0)
	if arg_13_0.selectItemData_ then
		local var_13_0 = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD)
		local var_13_1 = arg_13_0.selectItemData_

		if var_13_0 < math.ceil(ChallengeRogueTeamTools.GetShopItemDefaultPrice(var_13_1.id, var_13_1.rare) * var_13_1.discount / 100) then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetTips("ROGUE_TEAM_GOLD")))

			return
		end

		local var_13_2 = var_13_1.discount

		ChallengeRogueTeamAction.ShopBuyItem(var_13_1.index, function()
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED)
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_BUY_SUCCESS, var_13_2)
		end)
	else
		if arg_13_0.confirmExitFlag_ ~= true then
			arg_13_0.confirmExitFlag_ = true

			arg_13_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.CONFIRM_EXIT, ChallengeRogueTeamButton.BUTTON_TEXT.CONFIRM_EXIT)
			arg_13_0.camcelControllerEx_:SetSelectedState("true")

			return
		end

		ChallengeRogueTeamAction.ShopBuyItem(0, function()
			arg_13_0:Back()
		end)
	end
end

function var_0_0.RefrshShopText(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ChallengeRogueTeamTools.GetShopVoiceID(arg_16_1, arg_16_2, arg_16_0.lastVoiceID_)

	arg_16_0.lastVoiceID_ = var_16_0

	local var_16_1 = RogueTeamShopVoiceCfg[var_16_0]

	arg_16_0.npcText_.text = var_16_1.desc

	arg_16_0.expressionController_:SetSelectedState(var_16_1.expression_name)
end

function var_0_0.OnBuyItemSuccess(arg_17_0, arg_17_1)
	arg_17_0:RefreshItemList()
	arg_17_0:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.BUY_SUCCESS, arg_17_1 >= 100 and ChallengeRogueTeamConst.SHOP_BUY_ITEM_TYPE.BUY_ORIGIN or ChallengeRogueTeamConst.SHOP_BUY_ITEM_TYPE.BUY_DISCOUNT)
end

function var_0_0.OnUpdateOperate(arg_18_0)
	arg_18_0:RefreshItemList()
	arg_18_0:UpdateShopRefreshCost()
end

function var_0_0.OnWindowUpdate(arg_19_0)
	if not arg_19_0:IsTop() then
		return
	end

	arg_19_0:PopWindowProcess()
	arg_19_0:RefreshItemList()
end

function var_0_0.PopWindowProcess(arg_20_0)
	if ChallengeRogueTeamAction.PopWindowProcessSystem() == false then
		ChallengeRogueTeamAction.PopOperateWindowProcessSystem()
	end
end

function var_0_0.OnSelectedItem(arg_21_0, arg_21_1)
	arg_21_0.selectItemData_ = arg_21_1
	arg_21_0.popFlag_ = arg_21_1 ~= nil

	arg_21_0:RefreshPopWindow()
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0.isRefreshShop_ = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_REFRESH) > 0

	arg_22_0.refreshControllerEx_:SetSelectedState(arg_22_0.isRefreshShop_ and "on" or "off")
	arg_22_0:UpdateShopRefreshCost()
end

function var_0_0.UpdateShopRefreshCost(arg_23_0)
	if not arg_23_0.isRefreshShop_ then
		return
	end

	local var_23_0 = ChallengeRogueTeamData:GetShopData().refreshTimes or 0
	local var_23_1 = ChallengeRogueTeamConst.SHOP_REFRESH_COST * math.pow(2, var_23_0)

	arg_23_0.refreshCostText_.text = var_23_1
	arg_23_0.isCanRefresh_ = var_23_1 <= ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD)

	if arg_23_0.isCanRefresh_ then
		arg_23_0.refreshControllerEx_:SetSelectedState("on")
	else
		arg_23_0.refreshControllerEx_:SetSelectedState("red")
	end
end

function var_0_0.RefreshItemList(arg_24_0)
	local var_24_0 = ChallengeRogueTeamTools.GetShopItemList()

	for iter_24_0 = 1, 4 do
		arg_24_0.treasureItemList_[iter_24_0] = arg_24_0.treasureItemList_[iter_24_0] or ChallengeRogueTeamShopItem.New(arg_24_0.item_, arg_24_0.treasureParent_, ChallengeRogueTeamConst.ITEM_TYPE.TREASURE, iter_24_0)

		arg_24_0.treasureItemList_[iter_24_0]:SetData(var_24_0[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE][iter_24_0])
	end

	for iter_24_1 = 1, 4 do
		arg_24_0.relicItemList_[iter_24_1] = arg_24_0.relicItemList_[iter_24_1] or ChallengeRogueTeamShopItem.New(arg_24_0.item_, arg_24_0.relicParent_, ChallengeRogueTeamConst.ITEM_TYPE.RELIC, iter_24_1)

		arg_24_0.relicItemList_[iter_24_1]:SetData(var_24_0[ChallengeRogueTeamConst.ITEM_TYPE.RELIC][iter_24_1])
	end
end

function var_0_0.RefreshPopWindow(arg_25_0)
	if arg_25_0.popFlag_ then
		arg_25_0.confirmExitFlag_ = false

		arg_25_0.itemPopView_:SetData(arg_25_0.selectItemData_)
		arg_25_0.popControllerEx_:SetSelectedState("state1")
		arg_25_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.GOLD_COLOR, ChallengeRogueTeamButton.BUTTON_TEXT.CONFIRM_ORDER)
		arg_25_0:RefrshShopText(ChallengeRogueTeamConst.SHOP_TEXT_TYPE.SELECT_ITEM, arg_25_0.selectItemData_.discount >= 100 and ChallengeRogueTeamConst.SHOP_SELECT_ITEM_TYPE.SELECT_ORIGIN or ChallengeRogueTeamConst.SHOP_SELECT_ITEM_TYPE.SELECT_DISCOUNT)
	else
		arg_25_0.popControllerEx_:SetSelectedState("state0")
		arg_25_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.CANCLE, ChallengeRogueTeamButton.BUTTON_TEXT.EXIT)
		arg_25_0.camcelControllerEx_:SetSelectedState("false")
	end
end

function var_0_0.RefreshBGM(arg_26_0)
	local var_26_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_26_1 = RogueTeamCfg[var_26_0].room_temp
	local var_26_2 = RogueTeamRoomTypeCfg.get_id_list_by_temp_id_id[var_26_1][ChallengeRogueTeamConst.NODE_TYPE.SHOP][1]
	local var_26_3 = RogueTeamRoomTypeCfg[var_26_2]

	if var_26_3.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_26_3.cue_sheet, var_26_3.cue_name, var_26_3.awb)
	end
end

return var_0_0
