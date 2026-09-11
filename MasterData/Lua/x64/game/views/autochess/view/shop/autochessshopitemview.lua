local AutoChessShopItemView = class("AutoChessShopItemView", ReduxView)

function AutoChessShopItemView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.prepareView_ = arg_1_2
	self.gameType_ = AutoChessConst.GAME_TYPE.PVE
	self.shopItemDic_ = {}

	self:Init()
end

function AutoChessShopItemView:Init()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitShopItemContainer()

	self.rewardController_ = self.transCon_:GetController("rewardPanel")
	self.statusController_ = self.transCon_:GetController("status")
	self.btnStatusController_ = self.transCon_:GetController("btnStatus")
	self.berhmaBgController_ = self.transCon_:GetController("berhmaBg")
	self.oneClickController_ = self.oneClickCon_:GetController("oneClick")
	self.lockController_ = self.lockCon_:GetController("status")
end

function AutoChessShopItemView:AddUIListener()
	self:AddBtnListener(self.shopRefreshBtn_, nil, function()
		if not AutoChessTools.GetNowMoneyEnough(self.gameType_, self.refreshCost_) then
			ShowTips("AUTO_CHESS_GOLG_INSUFFICIENT")

			return
		end

		if self.prepareView_:GetIsBeginDrag() or AutoChessData:GetIsInUseProp() or AutoChessData:GetIsInBuyChess() or AutoChessData:GetIsInPrepareEnd() then
			return
		end

		AutoChessTools.RefreshShop(self.gameType_)
		self.prepareView_:RefreshCurrencyAnim()
	end)
	self:AddBtnListener(self.shopOnClickBtn_, nil, function()
		AutoChessAction.BuyChessOneKey(self.gameType_)
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		if not self.selectShopItem_ then
			return
		end

		AutoChessTools.LockShop(self.gameType_, self.selectShopItem_.isLock == 0 and 1 or 0, {
			{
				shop_type = self.selectShopItem_.shopType,
				uid_list = {
					self.selectShopItem_.uniqueId
				}
			}
		})
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		if not self.selectShopItem_ then
			return
		end

		if self.selectShopItem_.isLock == 0 then
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_lock01", "")
		else
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_lock02", "")
		end

		AutoChessTools.LockShop(self.gameType_, self.selectShopItem_.isLock == 0 and 1 or 0, {
			{
				shop_type = self.selectShopItem_.shopType,
				uid_list = {
					self.selectShopItem_.uniqueId
				}
			}
		})
	end)
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(self, self.SellPointerEnter)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(self, self.SellPointerExit)))
end

function AutoChessShopItemView:InitShopItemContainer()
	self.shopItemList = {}

	for iter_8_0 = 1, 5 do
		self:InitChessItem(iter_8_0, self.shopTrans_, self.shopItemList)
	end

	self.rewardItemList = {}

	for iter_8_1 = 1, 2 do
		self:InitChessItem(iter_8_1, self.rewardTrans_, self.rewardItemList)
	end

	self.propItemList = {}

	for iter_8_2 = 1, 2 do
		self:InitChessItem(iter_8_2, self.propTrans_, self.propItemList)
	end
end

function AutoChessShopItemView:SetGameType(arg_9_1)
	self.gameType_ = arg_9_1
end

function AutoChessShopItemView:InitChessItem(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = AutoChessShopItem.New(arg_10_2:GetChild(arg_10_1 - 1).gameObject, self.gameType_)

	var_10_0:RegisterEvent("PointerClick", handler(self.prepareView_, self.prepareView_.OnPointerClick))
	var_10_0:RegisterEvent("BeginDrag", handler(self.prepareView_, self.prepareView_.OnBeginDrag))
	var_10_0:RegisterEvent("Drag", handler(self.prepareView_, self.prepareView_.OnDrag))
	var_10_0:RegisterEvent("EndDrag", handler(self.prepareView_, self.prepareView_.OnEndDrag))
	table.insert(arg_10_3, var_10_0)
end

function AutoChessShopItemView:UpdateShopInfo(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self.shopItemDataList = arg_11_1
	self.chessRewardDataList = arg_11_2
	self.propGoodDataList = arg_11_3
	self.isBossBattle_ = arg_11_4
	self.isTeaching_ = arg_11_5

	self:ChangeBtnStatus()
	self.berhmaBgController_:SetSelectedState(arg_11_4 and "show" or "hide")
	self:RefreshRewardAreaActive(#self.chessRewardDataList > 0)

	self.shopItemDic_ = {}

	for iter_11_0 = 1, 5 do
		self:RefreshItem(self.shopItemDataList[iter_11_0], self.shopItemList[iter_11_0])
	end

	for iter_11_1 = 1, 2 do
		self:RefreshItem(self.chessRewardDataList[iter_11_1], self.rewardItemList[iter_11_1])
	end

	for iter_11_2 = 1, 2 do
		self:RefreshItem(self.propGoodDataList[iter_11_2], self.propItemList[iter_11_2])
	end
end

function AutoChessShopItemView:RefreshRewardAreaActive(arg_12_1)
	if arg_12_1 then
		self.rewardController_:SetSelectedState("on")
		self:RemoveTween()
		self:RemoveShopTween()
		self:RefreshShopArea(1282, LeanTweenType.easeInOutSine, 0.5)
		self:RefreshRewardArea(386, LeanTweenType.easeOutSine, 1, true)
	else
		for iter_12_0, iter_12_1 in pairs(self.rewardItemList) do
			iter_12_1:SetActive(false)
		end

		self:RemoveTween()
		self:RemoveShopTween()
		self:RefreshRewardArea(50, LeanTweenType.easeInOutSine, 0.5, false)
		self:RefreshShopArea(1706, LeanTweenType.easeOutSine, 1)
	end
end

function AutoChessShopItemView:RefreshItem(arg_13_1, arg_13_2)
	if arg_13_1 then
		self.shopItemDic_[arg_13_1.uniqueId] = arg_13_2
	end

	arg_13_2:SetGameType(self.gameType_)
	arg_13_2:SetData(arg_13_1)

	if not self.selectShopItem_ then
		self.lockController_:SetSelectedState("unavailable")
	elseif arg_13_1 and self.selectShopItem_.uniqueId == arg_13_1.uniqueId then
		self.lockController_:SetSelectedState(arg_13_1.isLock == 1 and "lockoff" or "lockon")
	end
end

function AutoChessShopItemView:GetShopItemByUniqueId(arg_14_1)
	return self.shopItemDic_[arg_14_1]
end

function AutoChessShopItemView:UpdateLockShopAnim(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.info_list) do
		if iter_15_1.shop_type == AutoChessConst.SHOP_TYPE.NORMAL then
			for iter_15_2, iter_15_3 in ipairs(iter_15_1.uid_list) do
				self:RefreshItemLock(self.shopItemList[AutoChessData:GetShopChessDataByByUniqueId(arg_15_1.game_type, iter_15_3).index])
			end
		end

		if iter_15_1.shop_type == AutoChessConst.SHOP_TYPE.PROP then
			for iter_15_4, iter_15_5 in ipairs(iter_15_1.uid_list) do
				self:RefreshItemLock(self.propItemList[AutoChessData:GetShopChessDataByByUniqueId(arg_15_1.game_type, iter_15_5).index])
			end
		end
	end
end

function AutoChessShopItemView:RefreshItemLock(arg_16_1)
	arg_16_1:UpdateLock()
end

function AutoChessShopItemView:RefreshShopAnim()
	for iter_17_0 = 1, 5 do
		self:RefreshItemAnim(self.shopItemList[iter_17_0])
	end

	for iter_17_1 = 1, 2 do
		self:RefreshItemAnim(self.propItemList[iter_17_1])
	end
end

function AutoChessShopItemView:RefreshItemAnim(arg_18_1)
	arg_18_1:Refresh()
end

function AutoChessShopItemView:SellPointerEnter()
	if not self.prepareView_:GetIsBeginDrag() or self.isTeaching_ then
		return
	end

	self.pointerData_ = self.prepareView_:GetPointerChessData()

	local var_19_0

	if self.pointerData_.shopType == AutoChessConst.SHOP_TYPE.REWARD and self.gameType_ ~= AutoChessConst.GAME_TYPE.ONLINE and self.gameType_ ~= AutoChessConst.GAME_TYPE.PVP_5_0 then
		do return end

		var_19_0 = AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
	end

	self.isCanSell_ = AutoChessCfg[self.pointerData_.chessId].type ~= AutoChessConst.CHESS_TYPE.PLAYER_CHESS and self.pointerData_ ~= nil and (self.pointerData_.shopType == nil or self.pointerData_.shopType == AutoChessConst.SHOP_TYPE.REWARD and not var_19_0)

	self.prepareView_:SetSellState(self.isCanSell_)
	self:SetStatus(self.isCanSell_ and 2 or 0)

	if self.isCanSell_ then
		self.prepareView_:ChangeCurrency(self.pointerData_, true)
	end
end

function AutoChessShopItemView:SellPointerExit()
	if not self.prepareView_:GetIsBeginDrag() or self.isTeaching_ then
		return
	end

	if not self.isCanSell_ then
		return
	end

	self:SetStatus(self.isCanSell_ and 1 or 0)
	self.prepareView_:ResetCurrencyState()
	self:ResetSellState()
end

function AutoChessShopItemView:ResetSellState()
	self.pointerData_ = nil
	self.isCanSell_ = false

	self.prepareView_:SetSellState(false)
end

function AutoChessShopItemView:PointerClickFunc(arg_22_1)
	if self.selectShopItem_ then
		self:GetItemByType(self.selectShopItem_.shopType, self.selectShopItem_.index):SetSelect(false)
	end

	self.selectShopItem_ = arg_22_1

	self:PlayLockAnim(arg_22_1)
	self:GetItemByType(self.selectShopItem_.shopType, self.selectShopItem_.index):SetSelect(true)
end

function AutoChessShopItemView:BeginDragFunc(arg_23_1)
	self:PlayLockAnim(arg_23_1)
end

function AutoChessShopItemView:PlayLockAnim(arg_24_1)
	if arg_24_1.isLock == 1 then
		self.lockController_:SetSelectedState("lockoff")
		self.btnLockOnAnim_:Play("btnLockon")
	else
		self.lockController_:SetSelectedState("lockon")
		self.btnLockOnAnim_:Play("btnLockon")
	end
end

function AutoChessShopItemView:GetItemByType(arg_25_1, arg_25_2)
	if arg_25_1 == AutoChessConst.SHOP_TYPE.NORMAL then
		return self.shopItemList[arg_25_2]
	end

	if arg_25_1 == AutoChessConst.SHOP_TYPE.PROP then
		return self.propItemList[arg_25_2]
	end

	if arg_25_1 == AutoChessConst.SHOP_TYPE.REWARD then
		return self.rewardItemList[arg_25_2]
	end
end

function AutoChessShopItemView:ClearChess(arg_26_1)
	if arg_26_1.shopType ~= nil then
		self:RefreshItem(nil, (self:GetItemByType(arg_26_1.shopType, arg_26_1.index)))

		local var_26_0 = AutoChessData:GetPrepareData()

		if var_26_0 then
			var_26_0:RemoveShopItemByUniqueId({
				arg_26_1.uniqueId
			})
		end
	end
end

function AutoChessShopItemView:ResetShopItem()
	if self.selectShopItem_ then
		self:GetItemByType(self.selectShopItem_.shopType, self.selectShopItem_.index):SetSelect(false)
	end

	self.selectShopItem_ = nil

	self.lockController_:SetSelectedState("unavailable")
	self:SetDeleteStatus(nil, false)
end

function AutoChessShopItemView:ChangeBtnStatus(arg_28_1)
	if arg_28_1 then
		self.btnStatusController_:SetSelectedState(arg_28_1)

		return
	end

	if self.isBossBattle_ then
		self.btnStatusController_:SetSelectedState("brahma")
		self.oneClickController_:SetSelectedState(#self.shopItemDataList > 0 and "off" or "on")
	elseif self.isTeaching_ then
		self.btnStatusController_:SetSelectedState("hide")
	else
		self.btnStatusController_:SetSelectedState("refresh")
	end
end

function AutoChessShopItemView:SetStatus(arg_29_1)
	if self.isTeaching_ then
		return
	end

	self.statusController_:SetSelectedIndex(arg_29_1)
end

function AutoChessShopItemView:SetSellText(arg_30_1, arg_30_2)
	if self.isTeaching_ then
		return
	end

	self.sellText_.text = "+" .. arg_30_1.sell_price[arg_30_2]
end

function AutoChessShopItemView:SetRefreshCost(arg_31_1, arg_31_2, arg_31_3)
	if arg_31_3 then
		self.refreshCost_ = arg_31_2
		self.brahmaRefreshText_.text = arg_31_2
	else
		self.refreshCost_ = arg_31_1
		self.refreshText_.text = arg_31_2 < arg_31_1 and "<color=#FF000B>" .. arg_31_1 .. "</color>" or arg_31_1
	end
end

function AutoChessShopItemView:RefreshShopChessLvAnim(arg_32_1, arg_32_2, arg_32_3)
	self:GetItemByType(arg_32_3, arg_32_1):UpdateLvUp(arg_32_2)
end

function AutoChessShopItemView:SetDeleteStatus(arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in pairs(self.rewardItemList) do
		iter_33_1:SetDeleteState(arg_33_1, arg_33_2)
	end
end

function AutoChessShopItemView:RefreshRewardArea(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	self.rewardTween_ = LeanTween.value(self.rewardPanelTrs_.gameObject, self.rewardPanelTrs_.rect.width, arg_34_1, arg_34_3):setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
		self.rewardPanelTrs_.sizeDelta = Vector2(arg_35_0, self.rewardPanelTrs_.rect.height)
	end)):setOnComplete(System.Action(function()
		if arg_34_4 then
			self.rewardController_:SetSelectedState("on")
		else
			self.rewardController_:SetSelectedState("off")
		end

		self:RemoveTween()
	end)):setEase(arg_34_2)
end

function AutoChessShopItemView:RefreshShopArea(arg_37_1, arg_37_2, arg_37_3)
	self.shopTween_ = LeanTween.value(self.shopPanelTrs_.gameObject, self.shopPanelTrs_.rect.width, arg_37_1, arg_37_3):setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
		self.shopPanelTrs_.sizeDelta = Vector2(arg_38_0, self.shopPanelTrs_.rect.height)
	end)):setOnComplete(System.Action(function()
		self:RemoveShopTween()
	end)):setEase(arg_37_2)
end

function AutoChessShopItemView:RemoveTween()
	if self.rewardTween_ then
		self.rewardTween_:setOnComplete(nil)
		LeanTween.cancel(self.rewardTween_.id)

		self.rewardTween_ = nil
	end
end

function AutoChessShopItemView:RemoveShopTween()
	if self.shopTween_ then
		self.shopTween_:setOnComplete(nil)
		LeanTween.cancel(self.shopTween_.id)

		self.shopTween_ = nil
	end
end

function AutoChessShopItemView:Dispose()
	for iter_42_0, iter_42_1 in pairs(self.shopItemList) do
		iter_42_1:Dispose()
	end

	self.shopItemList = nil

	for iter_42_2, iter_42_3 in pairs(self.rewardItemList) do
		iter_42_3:Dispose()
	end

	self.rewardItemList = nil

	for iter_42_4, iter_42_5 in pairs(self.propItemList) do
		iter_42_5:Dispose()
	end

	self.propItemList = nil

	AutoChessShopItemView.super.Dispose(self)
end

return AutoChessShopItemView
