local var_0_0 = class("ActivityOathDrawGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return OathDrawTools.GetDrawGameUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnOneKeyController_ = arg_4_0.controller_:GetController("btnOneKey")
	arg_4_0.rewardTypeController_ = arg_4_0.controller_:GetController("rewardType")
	arg_4_0.couponController_ = arg_4_0.controller_:GetController("coupon")
	arg_4_0.rewardStateController_ = arg_4_0.controller_:GetController("rewardState")
	arg_4_0.drawList_ = {}

	for iter_4_0 = 1, arg_4_0.drawContent_.childCount do
		local var_4_0 = arg_4_0.drawContent_:GetChild(iter_4_0 - 1).gameObject
		local var_4_1 = ActivityOathDrawItem.New(var_4_0, iter_4_0)

		var_4_1:SetDrawCallBack(handler(arg_4_0, arg_4_0.OnClickDrawItem))
		table.insert(arg_4_0.drawList_, var_4_1)
	end

	arg_4_0.sceneReward_ = ActivitySkinDrawItem.New(arg_4_0.sceneRewardGo_)
	arg_4_0.skinGiftReward_ = ActivityOathGiftItem.New(arg_4_0.giftRewardObj_)
	arg_4_0.updateDrawCallback = handler(arg_4_0, arg_4_0.OnSkinDrawUpdate)
end

function var_0_0.GetCardListData(arg_5_0)
	local var_5_0 = false
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_0.drawList_) do
		if not iter_5_1.isOpen and iter_5_1.isShow then
			var_5_1 = var_5_1 + 1
		end

		if iter_5_1.isOpen and iter_5_1:GetIsBestReward() then
			var_5_0 = true
		end
	end

	return var_5_1, var_5_0
end

function var_0_0.CheckIsMeetCostNum(arg_6_0)
	local var_6_0 = ActivityLimitedDrawPoolListCfg[arg_6_0.curPoolID_].cost_once[1]

	if ItemTools.getItemNum(var_6_0) > 0 then
		return true
	else
		return false
	end
end

function var_0_0.OpenCostShopPop(arg_7_0, arg_7_1)
	local var_7_0 = ActivityLimitedDrawPoolListCfg[arg_7_0.curPoolID_].cost_once[1]
	local var_7_1 = GetI18NText(ItemCfg[var_7_0].name)

	ShowTips(GetTipsF("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH", var_7_1))
	arg_7_0:OpenBuyPop(arg_7_1)
end

function var_0_0.OpenBuyPop(arg_8_0, arg_8_1)
	local var_8_0 = ActivityLimitedDrawPoolListCfg[arg_8_0.curPoolID_]
	local var_8_1 = getShopCfg(var_8_0.payment_free[1])
	local var_8_2 = cnt or 1
	local var_8_3 = getShopCfg(var_8_0.payment_free[1])
	local var_8_4 = {}
	local var_8_5 = {}

	table.insert(var_8_4, var_8_0.payment_free[1])
	table.insert(var_8_5, var_8_3.discount)

	local var_8_6 = var_8_3.shop_id
	local var_8_7 = ShopData.GetShop(var_8_6)[var_8_0.payment_free[1]]
	local var_8_8 = var_8_3.limit_num - (var_8_7.buy_times or 0)
	local var_8_9 = var_8_0.payment
	local var_8_10 = false

	for iter_8_0, iter_8_1 in ipairs(var_8_9) do
		local var_8_11 = getShopCfg(iter_8_1)
		local var_8_12 = var_8_11.shop_id
		local var_8_13 = ShopData.GetShop(var_8_12)[iter_8_1]

		if var_8_13 and var_8_2 <= var_8_11.limit_num - (var_8_13.buy_times or 0) and var_8_2 <= var_8_8 then
			table.insert(var_8_4, iter_8_1)
			table.insert(var_8_5, var_8_11.discount)
			JumpTools.OpenPageByJump("activityOathSkinDrawPop", {
				mainActivity = arg_8_0.activityID_,
				poolActivityID = arg_8_0.curPoolActivityId_,
				poolID = arg_8_0.curPoolID_,
				cnt = var_8_2,
				defaultBuyCnt = arg_8_1 or -1,
				goods = var_8_4,
				discount = var_8_5
			})

			var_8_10 = true

			break
		end
	end

	if var_8_10 then
		return
	end

	JumpTools.OpenPageByJump("activityOathSkinDrawPop", {
		mainActivity = arg_8_0.activityID_,
		poolActivityID = arg_8_0.curPoolActivityId_,
		poolID = arg_8_0.curPoolID_,
		cnt = var_8_2,
		defaultBuyCnt = arg_8_1 or -1,
		goods = var_8_4,
		discount = var_8_5
	})
end

function var_0_0.OnClickDrawItem(arg_9_0, arg_9_1)
	if not arg_9_0:CheckIsCanClick() then
		return
	end

	if not arg_9_0:CheckIsMeetCostNum() then
		arg_9_0:OpenCostShopPop(1)

		return
	end

	arg_9_0:StartOneDraw(arg_9_1)
end

function var_0_0.StartDrawCard(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2[arg_10_1].openIndex
	local var_10_1 = arg_10_2[arg_10_1].dropID

	arg_10_0.isStartOpenCard = true

	local var_10_2 = arg_10_1 == #arg_10_2

	table.insert(arg_10_0.OnClickDropList, var_10_1)
	arg_10_0:OpenTargetIndex(var_10_0, var_10_1, var_10_2, function()
		if var_10_2 then
			local var_11_0 = arg_10_0:GetCardListData()

			if arg_10_3 or var_11_0 == 0 then
				arg_10_0:ShowRewardPopup(arg_10_0.OnClickDropList, arg_10_0.updateDrawCallback)
			else
				arg_10_0.isStartOpenCard = false

				arg_10_0:ShowRewardPopup(arg_10_0.OnClickDropList)
			end
		else
			arg_10_0:StartDrawCard(arg_10_1 + 1, arg_10_2, arg_10_3)
		end
	end)
end

function var_0_0.StartOneDraw(arg_12_0, arg_12_1)
	ActivityOathDrawAction.StartOneDraw(arg_12_0.curPoolActivityId_, arg_12_0.curPoolID_, arg_12_1)
end

function var_0_0.OpenTargetIndex(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_0.drawList_[arg_13_1]

	if var_13_0 then
		local var_13_1 = {
			isOpen = true,
			dropID = arg_13_2,
			poolID = arg_13_0.curPoolID_
		}

		var_13_0:PlayOpenAni(var_13_1)
		arg_13_0:AddCheckOpenAniTimer(var_13_0, arg_13_3, arg_13_4)
	end
end

function var_0_0.DelCheckOpenAniTimer(arg_14_0)
	if arg_14_0.checkOpenAniTimer_ then
		arg_14_0.checkOpenAniTimer_:Stop()

		arg_14_0.checkOpenAniTimer_ = nil
	end
end

function var_0_0.AddCheckOpenAniTimer(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:DelCheckOpenAniTimer()

	arg_15_0.checkOpenAniTimer_ = Timer.New(function()
		local var_16_0 = false

		if arg_15_2 then
			var_16_0 = arg_15_1:IsFinishOpenAni()
		else
			var_16_0 = arg_15_1:IsCanOpenNext()
		end

		if var_16_0 then
			arg_15_0:DelCheckOpenAniTimer()

			if arg_15_3 then
				arg_15_3()
			end
		end
	end, 0.1, -1)

	arg_15_0.checkOpenAniTimer_:Start()
end

function var_0_0.ExitOtherView(arg_17_0)
	if not arg_17_0:IsTop() then
		gameContext:Back()
	end
end

function var_0_0.GetBestRewardDropID(arg_18_0)
	local var_18_0 = ActivityLimitedDrawPoolListCfg[arg_18_0.curPoolID_]
	local var_18_1

	if var_18_0.pool_type == 1 then
		_, var_18_1 = ActivityOathDrawData:GetGiftID()
	elseif var_18_0.pool_type == 2 then
		var_18_1 = ActivityOathDrawData:GetSceneDropID(arg_18_0.curPoolActivityId_)
	end

	return var_18_1
end

function var_0_0.CheckIsNeedExchange(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0.isEarlyGetBestReward_ then
		return false
	end

	if not (arg_19_2 == arg_19_0:GetBestRewardDropID()) then
		return false
	end

	local var_19_0 = ItemCfg[arg_19_1]

	if not var_19_0 then
		return false
	end

	if not var_19_0.num_exchange_item then
		return false
	end

	return true
end

function var_0_0.ShowRewardPopup(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_1 = ActivityLimitedDrawPoolCfg[iter_20_1].reward

		for iter_20_2, iter_20_3 in ipairs(var_20_1) do
			local var_20_2 = iter_20_3[1]
			local var_20_3 = iter_20_3[2]

			if ItemCfg[var_20_2].type == ItemConst.ITEM_TYPE.GIFT then
				local var_20_4 = ItemCfg[var_20_2].param
				local var_20_5 = false

				for iter_20_4, iter_20_5 in pairs(var_20_4) do
					local var_20_6 = iter_20_5[1]
					local var_20_7 = iter_20_5[2]

					if arg_20_0:CheckIsNeedExchange(var_20_6, iter_20_1) then
						for iter_20_6, iter_20_7 in pairs(ItemCfg[var_20_6].num_exchange_item) do
							table.insert(var_20_0, {
								id = iter_20_7[1],
								num = iter_20_7[2]
							})

							var_20_5 = true
						end
					end
				end

				if not var_20_5 then
					for iter_20_8, iter_20_9 in pairs(var_20_4) do
						table.insert(var_20_0, {
							id = iter_20_9[1],
							num = iter_20_9[2] * var_20_3
						})
					end
				end
			elseif arg_20_0:CheckIsNeedExchange(var_20_2, iter_20_1) then
				for iter_20_10, iter_20_11 in pairs(ItemCfg[var_20_2].num_exchange_item) do
					table.insert(var_20_0, {
						id = iter_20_11[1],
						num = iter_20_11[2] * var_20_3
					})
				end
			else
				table.insert(var_20_0, {
					id = var_20_2,
					num = var_20_3
				})
			end
		end
	end

	arg_20_0:ExitOtherView()
	getReward(mergeReward(var_20_0), nil, arg_20_2)
	arg_20_0:UpdateRemainCountShow()
end

function var_0_0.ExecuteOnClick(arg_21_0)
	ActivityOathDrawAction.OnClickStartDraw(arg_21_0.curPoolActivityId_, arg_21_0.curPoolID_)
end

function var_0_0.AddUIListeners(arg_22_0)
	arg_22_0:AddBtnListener(arg_22_0.btnInfo_, nil, function()
		if not arg_22_0:CheckIsCanClick() then
			return
		end

		JumpTools.OpenPageByJump("skinDrawInfo", {
			isOath = true,
			poolID = arg_22_0.curPoolID_,
			mainActivity = arg_22_0.activityID_,
			poolActivityID = arg_22_0.curPoolActivityId_
		})
	end)
	arg_22_0:AddBtnListener(arg_22_0.oneBtn_, nil, function()
		if not arg_22_0:CheckIsCanClick() then
			return
		end

		arg_22_0:OnClickOneKeyBtn()
	end)
end

function var_0_0.CheckIsCanClick(arg_25_0)
	if arg_25_0.isStartOpenCard then
		return false
	end

	local var_25_0 = arg_25_0.drawCardAni_:GetCurrentAnimatorStateInfo(0)

	if var_25_0:IsName("UI_Oath_coupo") and var_25_0.normalizedTime < 1 then
		return false
	else
		return true
	end

	return true
end

function var_0_0.OnClickOneKeyBtn(arg_26_0)
	if not arg_26_0:CheckIsMeetCostNum() then
		arg_26_0:OpenCostShopPop()

		return
	end

	if not _G.SkipTip.SkipActivityOathSkinDrawTip_ then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips(string.format(GetTips("WEDDING_AUTO_DRAW_TIPS1"), ItemTools.getItemName(arg_26_0.costID))),
			OkCallback = function()
				arg_26_0:ExecuteOnClick()
			end,
			CancelCallback = function()
				return
			end,
			ToggleCallback = function(arg_29_0)
				_G.SkipTip.SkipActivityOathSkinDrawTip_ = arg_29_0
			end
		})
	else
		arg_26_0:ExecuteOnClick()
	end
end

function var_0_0.OnEnter(arg_30_0)
	arg_30_0.isStartOpenCard = false

	arg_30_0:AddEventListeners()
	arg_30_0:InitData()
	arg_30_0:RefreshUI()
	arg_30_0:AddEnterAnimimer()
end

function var_0_0.DelEnterAnimTimer(arg_31_0)
	if arg_31_0.enterAnimTimer_ then
		arg_31_0.enterAnimTimer_:Stop()

		arg_31_0.enterAnimTimer_ = nil
	end
end

function var_0_0.AddEnterAnimimer(arg_32_0)
	arg_32_0:DelEnterAnimTimer()

	local var_32_0 = false

	arg_32_0.enterAnimTimer_ = Timer.New(function()
		if arg_32_0:CheckEnterAniIsFinish() then
			arg_32_0:RefreshBar()
			arg_32_0:DelEnterAnimTimer()
		end

		if arg_32_0:CheckIsRefreshCardAni() and not var_32_0 then
			for iter_33_0, iter_33_1 in ipairs(arg_32_0.drawDataList_) do
				local var_33_0 = arg_32_0.drawList_[iter_33_1.index]

				if var_33_0 and var_33_0.isOpen then
					var_33_0:CheckRefreshAniState()
				end
			end

			var_32_0 = true
		end
	end, 0.1, -1)

	arg_32_0.enterAnimTimer_:Start()
end

function var_0_0.CheckEnterAniIsFinish(arg_34_0)
	if arg_34_0.anim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
		return true
	end

	return false
end

function var_0_0.CheckIsRefreshCardAni(arg_35_0)
	if arg_35_0.anim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.6 then
		return true
	end

	return false
end

function var_0_0.AddEventListeners(arg_36_0)
	arg_36_0:RegistEventListener(ACTIVITY_OATH_SKIN_DRAW_OPEN, handler(arg_36_0, arg_36_0.OnSkinStartDraw))
end

function var_0_0.OnSkinDrawUpdate(arg_37_0)
	arg_37_0:PlayResetAni()
	arg_37_0:UpdateBestRewardUI()
	arg_37_0:UpdateOneKey()
end

function var_0_0.OnSkinStartDraw(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0.OnClickDropList = {}

	arg_38_0:StartDrawCard(1, arg_38_1, arg_38_2)
end

function var_0_0.DelCheckDrawListCompleteAni(arg_39_0)
	if arg_39_0.closeCompleteAniTimer_ then
		arg_39_0.closeCompleteAniTimer_:Stop()

		arg_39_0.closeCompleteAniTimer_ = nil
	end
end

function var_0_0.PlayResetAni(arg_40_0)
	local var_40_0, var_40_1 = arg_40_0:GetCardListData()
	local var_40_2 = true

	if var_40_1 and var_40_0 > 0 then
		var_40_2 = false
	elseif var_40_0 >= ActivityOathDrawData:GetRemainCanDrawCnt(arg_40_0.curPoolActivityId_) then
		var_40_2 = false
	end

	if not var_40_2 then
		arg_40_0.isStartOpenCard = false

		return
	end

	arg_40_0:DelCheckDrawListCompleteAni()

	local var_40_3

	for iter_40_0, iter_40_1 in pairs(arg_40_0.drawList_) do
		if iter_40_1.isOpen then
			iter_40_1:PlayCloseAni()

			var_40_3 = var_40_3 or iter_40_1
		end
	end

	arg_40_0.closeCompleteAniTimer_ = Timer.New(function()
		if var_40_3 and var_40_3:IsFinishCloseAni() then
			arg_40_0:UpdateDrawList()
			arg_40_0:DelCheckDrawListCompleteAni()
			arg_40_0.drawCardAni_:Play("UI_Oath_coupo", 0, 0)

			arg_40_0.isStartOpenCard = false
		end
	end, 0.1, -1)

	arg_40_0.closeCompleteAniTimer_:Start()
end

function var_0_0.InitData(arg_42_0)
	arg_42_0.curPoolID_ = arg_42_0.params_.poolID
	arg_42_0.activityID_ = arg_42_0.params_.activityID
	arg_42_0.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[arg_42_0.curPoolID_].activity_id[1]
	arg_42_0.costID = OathDrawTools.GetDrawCost(arg_42_0.curPoolID_)
	arg_42_0.isEarlyGetBestReward_ = arg_42_0.params_.isGetBestReward
end

function var_0_0.RefreshUI(arg_43_0)
	arg_43_0:UpdateDrawList()
	arg_43_0:UpdateOneKey()
	arg_43_0:UpdateBestRewardUI()
	arg_43_0:UpdateRemainCountShow()

	arg_43_0.costImg_.sprite = ItemTools.getItemSprite(arg_43_0.costID, nil, true)
end

function var_0_0.UpdateRemainCountShow(arg_44_0)
	local var_44_0 = ActivityOathDrawData:GetRemainCanDrawCnt(arg_44_0.curPoolActivityId_)
	local var_44_1 = OathDrawTools.GetDrawMaxDropCount(arg_44_0.curPoolID_)

	arg_44_0.drawText_.text = string.format(GetTips("SKIN_DRAE_DESC"), var_44_1, OathDrawTools.GetPoolBestRewardName(arg_44_0.curPoolID_))
	arg_44_0.remainCntText_.text = string.format("%s/%s", var_44_1 - var_44_0, var_44_1)
end

function var_0_0.UpdateDrawList(arg_45_0)
	arg_45_0.drawDataList_ = ActivityOathDrawData:GetDrawData(arg_45_0.curPoolActivityId_)

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.drawList_) do
		iter_45_1:Show(false)
	end

	for iter_45_2, iter_45_3 in ipairs(arg_45_0.drawDataList_) do
		local var_45_0 = arg_45_0.drawList_[iter_45_3.index]

		if var_45_0 then
			var_45_0:Show(true)
			var_45_0:SetData(iter_45_3)
		end
	end
end

function var_0_0.UpdateOneKey(arg_46_0)
	arg_46_0.drawDataList_ = ActivityOathDrawData:GetDrawData(arg_46_0.curPoolActivityId_)

	local var_46_0 = false
	local var_46_1 = 0

	for iter_46_0, iter_46_1 in ipairs(arg_46_0.drawDataList_) do
		if not iter_46_1.isOpen then
			var_46_1 = var_46_1 + 1

			if var_46_1 >= 1 then
				var_46_0 = true

				break
			end
		end
	end

	if var_46_0 then
		arg_46_0.btnOneKeyController_:SetSelectedState("show")
	else
		arg_46_0.btnOneKeyController_:SetSelectedState("hide")
	end
end

function var_0_0.UpdateBestRewardUI(arg_47_0)
	local var_47_0 = ActivityLimitedDrawPoolListCfg[arg_47_0.curPoolID_]

	if var_47_0.pool_type == 1 then
		arg_47_0.rewardTypeController_:SetSelectedState("skin")

		local var_47_1, var_47_2 = ActivityOathDrawData:GetGiftID()

		arg_47_0:RefreshSkinReward(var_47_2)
	elseif var_47_0.pool_type == 2 then
		arg_47_0.rewardTypeController_:SetSelectedState("normal")
		arg_47_0:RefreshDLCReward()
	end
end

function var_0_0.RefreshDLCReward(arg_48_0)
	local var_48_0 = ActivityOathDrawData:GetSceneDropID(arg_48_0.curPoolActivityId_)
	local var_48_1 = ActivityOathDrawData:GetDrawInfo(arg_48_0.curPoolActivityId_, var_48_0)
	local var_48_2 = ActivityOathDrawData:GetSceneID(arg_48_0.curPoolActivityId_)

	arg_48_0.sceneReward_:RefreshData({
		itemId = var_48_2,
		count = var_48_1.num
	}, arg_48_0.curPoolID_)
end

function var_0_0.RefreshSkinReward(arg_49_0, arg_49_1)
	arg_49_0.skinGiftReward_:SetData(arg_49_1, arg_49_0.curPoolActivityId_, nil, arg_49_0.curPoolID_)
end

function var_0_0.OnExit(arg_50_0)
	arg_50_0:DelCheckDrawListCompleteAni()
	arg_50_0:DelCheckOpenAniTimer()
	arg_50_0:DelEnterAnimTimer()
	manager.windowBar:HideBar()
	arg_50_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_51_0)
	arg_51_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_52_0)
	if not arg_52_0:CheckEnterAniIsFinish() then
		manager.windowBar:HideBar()

		return
	end

	local var_52_0 = {
		BACK_BAR,
		HOME_BAR,
		arg_52_0.costID,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	}

	manager.windowBar:SwitchBar(var_52_0)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function()
		if arg_52_0.isStartOpenCard then
			return
		end

		arg_52_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if arg_52_0.isStartOpenCard then
			return
		end

		gameContext:Go("/home", nil, nil, true)
	end)
end

function var_0_0.Dispose(arg_55_0)
	for iter_55_0, iter_55_1 in ipairs(arg_55_0.drawList_) do
		iter_55_1:Dispose()

		iter_55_1 = nil
	end

	arg_55_0.drawList_ = nil

	if arg_55_0.skinRewardItemList_ then
		for iter_55_2, iter_55_3 in ipairs(arg_55_0.skinRewardItemList_) do
			iter_55_3:Dispose()
		end

		arg_55_0.skinRewardItemList_ = {}
	end

	if arg_55_0.skinGiftReward_ then
		arg_55_0.skinGiftReward_:Dispose()

		arg_55_0.skinGiftReward_ = nil
	end

	if arg_55_0.sceneReward_ then
		arg_55_0.sceneReward_:Dispose()

		arg_55_0.sceneReward_ = nil
	end

	arg_55_0.super.Dispose(arg_55_0)
end

return var_0_0
