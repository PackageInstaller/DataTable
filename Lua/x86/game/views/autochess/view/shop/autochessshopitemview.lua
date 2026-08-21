local var_0_0 = class("AutoChessShopItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.prepareView_ = arg_1_2
	arg_1_0.gameType_ = AutoChessConst.GAME_TYPE.PVE
	arg_1_0.shopItemDic_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:InitShopItemContainer()

	arg_2_0.rewardController_ = arg_2_0.transCon_:GetController("rewardPanel")
	arg_2_0.statusController_ = arg_2_0.transCon_:GetController("status")
	arg_2_0.btnStatusController_ = arg_2_0.transCon_:GetController("btnStatus")
	arg_2_0.berhmaBgController_ = arg_2_0.transCon_:GetController("berhmaBg")
	arg_2_0.oneClickController_ = arg_2_0.oneClickCon_:GetController("oneClick")
	arg_2_0.lockController_ = arg_2_0.lockCon_:GetController("status")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.shopRefreshBtn_, nil, function()
		if not AutoChessTools.GetNowMoneyEnough(arg_3_0.gameType_, arg_3_0.refreshCost_) then
			ShowTips("AUTO_CHESS_GOLG_INSUFFICIENT")

			return
		end

		if arg_3_0.prepareView_:GetIsBeginDrag() or AutoChessData:GetIsInUseProp() or AutoChessData:GetIsInBuyChess() or AutoChessData:GetIsInPrepareEnd() then
			return
		end

		AutoChessTools.RefreshShop(arg_3_0.gameType_)
		arg_3_0.prepareView_:RefreshCurrencyAnim()
	end)
	arg_3_0:AddBtnListener(arg_3_0.shopOnClickBtn_, nil, function()
		AutoChessAction.BuyChessOneKey(arg_3_0.gameType_)
	end)
	arg_3_0:AddBtnListener(arg_3_0.lockBtn_, nil, function()
		if not arg_3_0.selectShopItem_ then
			return
		end

		local var_6_0 = arg_3_0.selectShopItem_.isLock == 0 and 1 or 0

		AutoChessTools.LockShop(arg_3_0.gameType_, var_6_0, {
			{
				shop_type = arg_3_0.selectShopItem_.shopType,
				uid_list = {
					arg_3_0.selectShopItem_.uniqueId
				}
			}
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.unlockBtn_, nil, function()
		if not arg_3_0.selectShopItem_ then
			return
		end

		if arg_3_0.selectShopItem_.isLock == 0 then
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_lock01", "")
		else
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_lock02", "")
		end

		local var_7_0 = arg_3_0.selectShopItem_.isLock == 0 and 1 or 0

		AutoChessTools.LockShop(arg_3_0.gameType_, var_7_0, {
			{
				shop_type = arg_3_0.selectShopItem_.shopType,
				uid_list = {
					arg_3_0.selectShopItem_.uniqueId
				}
			}
		})
	end)
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.SellPointerEnter)))
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.SellPointerExit)))
end

function var_0_0.InitShopItemContainer(arg_8_0)
	arg_8_0.shopItemList = {}

	for iter_8_0 = 1, 5 do
		arg_8_0:InitChessItem(iter_8_0, arg_8_0.shopTrans_, arg_8_0.shopItemList)
	end

	arg_8_0.rewardItemList = {}

	for iter_8_1 = 1, 2 do
		arg_8_0:InitChessItem(iter_8_1, arg_8_0.rewardTrans_, arg_8_0.rewardItemList)
	end

	arg_8_0.propItemList = {}

	for iter_8_2 = 1, 2 do
		arg_8_0:InitChessItem(iter_8_2, arg_8_0.propTrans_, arg_8_0.propItemList)
	end
end

function var_0_0.SetGameType(arg_9_0, arg_9_1)
	arg_9_0.gameType_ = arg_9_1
end

function var_0_0.InitChessItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = AutoChessShopItem.New(arg_10_2:GetChild(arg_10_1 - 1).gameObject, arg_10_0.gameType_)

	var_10_0:RegisterEvent("PointerClick", handler(arg_10_0.prepareView_, arg_10_0.prepareView_.OnPointerClick))
	var_10_0:RegisterEvent("BeginDrag", handler(arg_10_0.prepareView_, arg_10_0.prepareView_.OnBeginDrag))
	var_10_0:RegisterEvent("Drag", handler(arg_10_0.prepareView_, arg_10_0.prepareView_.OnDrag))
	var_10_0:RegisterEvent("EndDrag", handler(arg_10_0.prepareView_, arg_10_0.prepareView_.OnEndDrag))
	table.insert(arg_10_3, var_10_0)
end

function var_0_0.UpdateShopInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.shopItemDataList = arg_11_1
	arg_11_0.chessRewardDataList = arg_11_2
	arg_11_0.propGoodDataList = arg_11_3
	arg_11_0.isBossBattle_ = arg_11_4
	arg_11_0.isTeaching_ = arg_11_5

	arg_11_0:ChangeBtnStatus()
	arg_11_0.berhmaBgController_:SetSelectedState(arg_11_4 and "show" or "hide")
	arg_11_0:RefreshRewardAreaActive(#arg_11_0.chessRewardDataList > 0)

	arg_11_0.shopItemDic_ = {}

	for iter_11_0 = 1, 5 do
		arg_11_0:RefreshItem(arg_11_0.shopItemDataList[iter_11_0], arg_11_0.shopItemList[iter_11_0])
	end

	for iter_11_1 = 1, 2 do
		arg_11_0:RefreshItem(arg_11_0.chessRewardDataList[iter_11_1], arg_11_0.rewardItemList[iter_11_1])
	end

	for iter_11_2 = 1, 2 do
		arg_11_0:RefreshItem(arg_11_0.propGoodDataList[iter_11_2], arg_11_0.propItemList[iter_11_2])
	end
end

function var_0_0.RefreshRewardAreaActive(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.rewardController_:SetSelectedState("on")
		arg_12_0:RemoveTween()
		arg_12_0:RemoveShopTween()
		arg_12_0:RefreshShopArea(1282, LeanTweenType.easeInOutSine, 0.5)
		arg_12_0:RefreshRewardArea(386, LeanTweenType.easeOutSine, 1, true)
	else
		for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardItemList) do
			iter_12_1:SetActive(false)
		end

		arg_12_0:RemoveTween()
		arg_12_0:RemoveShopTween()
		arg_12_0:RefreshRewardArea(50, LeanTweenType.easeInOutSine, 0.5, false)
		arg_12_0:RefreshShopArea(1706, LeanTweenType.easeOutSine, 1)
	end
end

function var_0_0.RefreshItem(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 then
		arg_13_0.shopItemDic_[arg_13_1.uniqueId] = arg_13_2
	end

	arg_13_2:SetGameType(arg_13_0.gameType_)
	arg_13_2:SetData(arg_13_1)

	if not arg_13_0.selectShopItem_ then
		arg_13_0.lockController_:SetSelectedState("unavailable")
	elseif arg_13_1 and arg_13_0.selectShopItem_.uniqueId == arg_13_1.uniqueId then
		arg_13_0.lockController_:SetSelectedState(arg_13_1.isLock == 1 and "lockoff" or "lockon")
	end
end

function var_0_0.GetShopItemByUniqueId(arg_14_0, arg_14_1)
	return arg_14_0.shopItemDic_[arg_14_1]
end

function var_0_0.UpdateLockShopAnim(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.info_list) do
		local var_15_0 = iter_15_1.shop_type
		local var_15_1 = iter_15_1.uid_list

		if var_15_0 == AutoChessConst.SHOP_TYPE.NORMAL then
			for iter_15_2, iter_15_3 in ipairs(var_15_1) do
				local var_15_2 = AutoChessData:GetShopChessDataByByUniqueId(arg_15_1.game_type, iter_15_3)

				arg_15_0:RefreshItemLock(arg_15_0.shopItemList[var_15_2.index])
			end
		end

		if var_15_0 == AutoChessConst.SHOP_TYPE.PROP then
			for iter_15_4, iter_15_5 in ipairs(var_15_1) do
				local var_15_3 = AutoChessData:GetShopChessDataByByUniqueId(arg_15_1.game_type, iter_15_5)

				arg_15_0:RefreshItemLock(arg_15_0.propItemList[var_15_3.index])
			end
		end
	end
end

function var_0_0.RefreshItemLock(arg_16_0, arg_16_1)
	arg_16_1:UpdateLock()
end

function var_0_0.RefreshShopAnim(arg_17_0)
	for iter_17_0 = 1, 5 do
		arg_17_0:RefreshItemAnim(arg_17_0.shopItemList[iter_17_0])
	end

	for iter_17_1 = 1, 2 do
		arg_17_0:RefreshItemAnim(arg_17_0.propItemList[iter_17_1])
	end
end

function var_0_0.RefreshItemAnim(arg_18_0, arg_18_1)
	arg_18_1:Refresh()
end

function var_0_0.SellPointerEnter(arg_19_0)
	if not arg_19_0.prepareView_:GetIsBeginDrag() or arg_19_0.isTeaching_ then
		return
	end

	arg_19_0.pointerData_ = arg_19_0.prepareView_:GetPointerChessData()

	if arg_19_0.pointerData_.shopType == AutoChessConst.SHOP_TYPE.REWARD and arg_19_0.gameType_ ~= AutoChessConst.GAME_TYPE.ONLINE and arg_19_0.gameType_ ~= AutoChessConst.GAME_TYPE.PVP_5_0 then
		return
	end

	local var_19_0 = AutoChessCfg[arg_19_0.pointerData_.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS
	local var_19_1 = AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN

	arg_19_0.isCanSell_ = not var_19_0 and arg_19_0.pointerData_ ~= nil and (arg_19_0.pointerData_.shopType == nil or arg_19_0.pointerData_.shopType == AutoChessConst.SHOP_TYPE.REWARD and not var_19_1)

	arg_19_0.prepareView_:SetSellState(arg_19_0.isCanSell_)
	arg_19_0:SetStatus(arg_19_0.isCanSell_ and 2 or 0)

	if arg_19_0.isCanSell_ then
		arg_19_0.prepareView_:ChangeCurrency(arg_19_0.pointerData_, true)
	end
end

function var_0_0.SellPointerExit(arg_20_0)
	if not arg_20_0.prepareView_:GetIsBeginDrag() or arg_20_0.isTeaching_ then
		return
	end

	if not arg_20_0.isCanSell_ then
		return
	end

	arg_20_0:SetStatus(arg_20_0.isCanSell_ and 1 or 0)
	arg_20_0.prepareView_:ResetCurrencyState()
	arg_20_0:ResetSellState()
end

function var_0_0.ResetSellState(arg_21_0)
	arg_21_0.pointerData_ = nil
	arg_21_0.isCanSell_ = false

	arg_21_0.prepareView_:SetSellState(false)
end

function var_0_0.PointerClickFunc(arg_22_0, arg_22_1)
	if arg_22_0.selectShopItem_ then
		arg_22_0:GetItemByType(arg_22_0.selectShopItem_.shopType, arg_22_0.selectShopItem_.index):SetSelect(false)
	end

	arg_22_0.selectShopItem_ = arg_22_1

	arg_22_0:PlayLockAnim(arg_22_1)
	arg_22_0:GetItemByType(arg_22_0.selectShopItem_.shopType, arg_22_0.selectShopItem_.index):SetSelect(true)
end

function var_0_0.BeginDragFunc(arg_23_0, arg_23_1)
	arg_23_0:PlayLockAnim(arg_23_1)
end

function var_0_0.PlayLockAnim(arg_24_0, arg_24_1)
	if arg_24_1.isLock == 1 then
		arg_24_0.lockController_:SetSelectedState("lockoff")
		arg_24_0.btnLockOnAnim_:Play("btnLockon")
	else
		arg_24_0.lockController_:SetSelectedState("lockon")
		arg_24_0.btnLockOnAnim_:Play("btnLockon")
	end
end

function var_0_0.GetItemByType(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == AutoChessConst.SHOP_TYPE.NORMAL then
		return arg_25_0.shopItemList[arg_25_2]
	end

	if arg_25_1 == AutoChessConst.SHOP_TYPE.PROP then
		return arg_25_0.propItemList[arg_25_2]
	end

	if arg_25_1 == AutoChessConst.SHOP_TYPE.REWARD then
		return arg_25_0.rewardItemList[arg_25_2]
	end
end

function var_0_0.ClearChess(arg_26_0, arg_26_1)
	if arg_26_1.shopType ~= nil then
		local var_26_0 = arg_26_0:GetItemByType(arg_26_1.shopType, arg_26_1.index)

		arg_26_0:RefreshItem(nil, var_26_0)

		local var_26_1 = AutoChessData:GetPrepareData()

		if var_26_1 then
			var_26_1:RemoveShopItemByUniqueId({
				arg_26_1.uniqueId
			})
		end
	end
end

function var_0_0.ResetShopItem(arg_27_0)
	if arg_27_0.selectShopItem_ then
		arg_27_0:GetItemByType(arg_27_0.selectShopItem_.shopType, arg_27_0.selectShopItem_.index):SetSelect(false)
	end

	arg_27_0.selectShopItem_ = nil

	arg_27_0.lockController_:SetSelectedState("unavailable")
	arg_27_0:SetDeleteStatus(nil, false)
end

function var_0_0.ChangeBtnStatus(arg_28_0, arg_28_1)
	if arg_28_1 then
		arg_28_0.btnStatusController_:SetSelectedState(arg_28_1)

		return
	end

	if arg_28_0.isBossBattle_ then
		arg_28_0.btnStatusController_:SetSelectedState("brahma")
		arg_28_0.oneClickController_:SetSelectedState(#arg_28_0.shopItemDataList > 0 and "off" or "on")
	elseif arg_28_0.isTeaching_ then
		arg_28_0.btnStatusController_:SetSelectedState("hide")
	else
		arg_28_0.btnStatusController_:SetSelectedState("refresh")
	end
end

function var_0_0.SetStatus(arg_29_0, arg_29_1)
	if arg_29_0.isTeaching_ then
		return
	end

	arg_29_0.statusController_:SetSelectedIndex(arg_29_1)
end

function var_0_0.SetSellText(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.isTeaching_ then
		return
	end

	arg_30_0.sellText_.text = "+" .. arg_30_1.sell_price[arg_30_2]
end

function var_0_0.SetRefreshCost(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_3 then
		arg_31_0.refreshCost_ = arg_31_2
		arg_31_0.brahmaRefreshText_.text = arg_31_2
	else
		arg_31_0.refreshCost_ = arg_31_1

		if arg_31_2 < arg_31_1 then
			arg_31_0.refreshText_.text = "<color=#FF000B>" .. arg_31_1 .. "</color>"
		else
			arg_31_0.refreshText_.text = arg_31_1
		end
	end
end

function var_0_0.RefreshShopChessLvAnim(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:GetItemByType(arg_32_3, arg_32_1):UpdateLvUp(arg_32_2)
end

function var_0_0.SetDeleteStatus(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.rewardItemList) do
		iter_33_1:SetDeleteState(arg_33_1, arg_33_2)
	end
end

function var_0_0.RefreshRewardArea(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	arg_34_0.rewardTween_ = LeanTween.value(arg_34_0.rewardPanelTrs_.gameObject, arg_34_0.rewardPanelTrs_.rect.width, arg_34_1, arg_34_3):setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
		arg_34_0.rewardPanelTrs_.sizeDelta = Vector2(arg_35_0, arg_34_0.rewardPanelTrs_.rect.height)
	end)):setOnComplete(System.Action(function()
		if arg_34_4 then
			arg_34_0.rewardController_:SetSelectedState("on")
		else
			arg_34_0.rewardController_:SetSelectedState("off")
		end

		arg_34_0:RemoveTween()
	end)):setEase(arg_34_2)
end

function var_0_0.RefreshShopArea(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0.shopTween_ = LeanTween.value(arg_37_0.shopPanelTrs_.gameObject, arg_37_0.shopPanelTrs_.rect.width, arg_37_1, arg_37_3):setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
		arg_37_0.shopPanelTrs_.sizeDelta = Vector2(arg_38_0, arg_37_0.shopPanelTrs_.rect.height)
	end)):setOnComplete(System.Action(function()
		arg_37_0:RemoveShopTween()
	end)):setEase(arg_37_2)
end

function var_0_0.RemoveTween(arg_40_0)
	if arg_40_0.rewardTween_ then
		arg_40_0.rewardTween_:setOnComplete(nil)
		LeanTween.cancel(arg_40_0.rewardTween_.id)

		arg_40_0.rewardTween_ = nil
	end
end

function var_0_0.RemoveShopTween(arg_41_0)
	if arg_41_0.shopTween_ then
		arg_41_0.shopTween_:setOnComplete(nil)
		LeanTween.cancel(arg_41_0.shopTween_.id)

		arg_41_0.shopTween_ = nil
	end
end

function var_0_0.Dispose(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.shopItemList) do
		iter_42_1:Dispose()
	end

	arg_42_0.shopItemList = nil

	for iter_42_2, iter_42_3 in pairs(arg_42_0.rewardItemList) do
		iter_42_3:Dispose()
	end

	arg_42_0.rewardItemList = nil

	for iter_42_4, iter_42_5 in pairs(arg_42_0.propItemList) do
		iter_42_5:Dispose()
	end

	arg_42_0.propItemList = nil

	var_0_0.super.Dispose(arg_42_0)
end

return var_0_0
