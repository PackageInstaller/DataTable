local ActivityOathDrawGameView = class("ActivityOathDrawGameView", ReduxView)

function ActivityOathDrawGameView:UIName()
	return OathDrawTools.GetDrawGameUIName(self.params_.activityID)
end

function ActivityOathDrawGameView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityOathDrawGameView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityOathDrawGameView:InitUI()
	self:BindCfgUI()

	self.btnOneKeyController_ = self.controller_:GetController("btnOneKey")
	self.rewardTypeController_ = self.controller_:GetController("rewardType")
	self.couponController_ = self.controller_:GetController("coupon")
	self.rewardStateController_ = self.controller_:GetController("rewardState")
	self.drawList_ = {}

	for iter_4_0 = 1, self.drawContent_.childCount do
		local var_4_0 = ActivityOathDrawItem.New(self.drawContent_:GetChild(iter_4_0 - 1).gameObject, iter_4_0)

		var_4_0:SetDrawCallBack(handler(self, self.OnClickDrawItem))
		table.insert(self.drawList_, var_4_0)
	end

	self.sceneReward_ = ActivitySkinDrawItem.New(self.sceneRewardGo_)
	self.skinGiftReward_ = ActivityOathGiftItem.New(self.giftRewardObj_)
	self.updateDrawCallback = handler(self, self.OnSkinDrawUpdate)
end

function ActivityOathDrawGameView:GetCardListData()
	local var_5_0 = false
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(self.drawList_) do
		if not iter_5_1.isOpen and iter_5_1.isShow then
			var_5_1 = var_5_1 + 1
		end

		if iter_5_1.isOpen and iter_5_1:GetIsBestReward() then
			var_5_0 = true
		end
	end

	return var_5_1, var_5_0
end

function ActivityOathDrawGameView:CheckIsMeetCostNum()
	if ItemTools.getItemNum(ActivityLimitedDrawPoolListCfg[self.curPoolID_].cost_once[1]) > 0 then
		return true
	else
		return false
	end
end

function ActivityOathDrawGameView:OpenCostShopPop(arg_7_1)
	ShowTips(GetTipsF("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH", (GetI18NText(ItemCfg[ActivityLimitedDrawPoolListCfg[self.curPoolID_].cost_once[1]].name))))
	self:OpenBuyPop(arg_7_1)
end

function ActivityOathDrawGameView:OpenBuyPop(arg_8_1)
	local var_8_0 = getShopCfg(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])
	local var_8_1 = cnt or 1
	local var_8_2 = getShopCfg(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])
	local var_8_3 = {}
	local var_8_4 = {}

	table.insert(var_8_3, ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])
	table.insert(var_8_4, var_8_2.discount)

	local var_8_5 = ShopData.GetShop(var_8_2.shop_id)[ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1]].buy_times or 0
	local var_8_6 = false

	for iter_8_0, iter_8_1 in ipairs(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment) do
		local var_8_7 = getShopCfg(iter_8_1)
		local var_8_8 = ShopData.GetShop(var_8_7.shop_id)[iter_8_1]

		if var_8_8 then
			if var_8_1 <= var_8_7.limit_num - (var_8_8.buy_times or 0) and var_8_1 <= var_8_2.limit_num - var_8_5 then
				table.insert(var_8_3, iter_8_1)
				table.insert(var_8_4, var_8_7.discount)
				JumpTools.OpenPageByJump("activityOathSkinDrawPop", {
					mainActivity = self.activityID_,
					poolActivityID = self.curPoolActivityId_,
					poolID = self.curPoolID_,
					cnt = var_8_1,
					defaultBuyCnt = arg_8_1 or -1,
					goods = var_8_3,
					discount = var_8_4
				})

				var_8_6 = true

				break
			end
		end
	end

	if var_8_6 then
		return
	end

	JumpTools.OpenPageByJump("activityOathSkinDrawPop", {
		mainActivity = self.activityID_,
		poolActivityID = self.curPoolActivityId_,
		poolID = self.curPoolID_,
		cnt = var_8_1,
		defaultBuyCnt = arg_8_1 or -1,
		goods = var_8_3,
		discount = var_8_4
	})
end

function ActivityOathDrawGameView:OnClickDrawItem(arg_9_1)
	if not self:CheckIsCanClick() then
		return
	end

	if not self:CheckIsMeetCostNum() then
		self:OpenCostShopPop(1)

		return
	end

	self:StartOneDraw(arg_9_1)
end

function ActivityOathDrawGameView:StartDrawCard(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2[arg_10_1].openIndex
	local var_10_1 = arg_10_2[arg_10_1].dropID

	self.isStartOpenCard = true

	local var_10_2 = arg_10_1 == #arg_10_2

	table.insert(self.OnClickDropList, var_10_1)
	self:OpenTargetIndex(var_10_0, var_10_1, var_10_2, function()
		if var_10_2 then
			if arg_10_3 or self:GetCardListData() == 0 then
				self:ShowRewardPopup(self.OnClickDropList, self.updateDrawCallback)
			else
				self.isStartOpenCard = false

				self:ShowRewardPopup(self.OnClickDropList)
			end
		else
			self:StartDrawCard(arg_10_1 + 1, arg_10_2, arg_10_3)
		end
	end)
end

function ActivityOathDrawGameView:StartOneDraw(arg_12_1)
	ActivityOathDrawAction.StartOneDraw(self.curPoolActivityId_, self.curPoolID_, arg_12_1)
end

function ActivityOathDrawGameView:OpenTargetIndex(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if self.drawList_[arg_13_1] then
		self.drawList_[arg_13_1]:PlayOpenAni({
			isOpen = true,
			dropID = arg_13_2,
			poolID = self.curPoolID_
		})
		self:AddCheckOpenAniTimer(self.drawList_[arg_13_1], arg_13_3, arg_13_4)
	end
end

function ActivityOathDrawGameView:DelCheckOpenAniTimer()
	if self.checkOpenAniTimer_ then
		self.checkOpenAniTimer_:Stop()

		self.checkOpenAniTimer_ = nil
	end
end

function ActivityOathDrawGameView:AddCheckOpenAniTimer(arg_15_1, arg_15_2, arg_15_3)
	self:DelCheckOpenAniTimer()

	self.checkOpenAniTimer_ = Timer.New(function()
		if arg_15_2 and arg_15_1:IsFinishOpenAni() or arg_15_1:IsCanOpenNext() then
			self:DelCheckOpenAniTimer()

			if arg_15_3 then
				arg_15_3()
			end
		end
	end, 0.1, -1)

	self.checkOpenAniTimer_:Start()
end

function ActivityOathDrawGameView:ExitOtherView()
	if not self:IsTop() then
		gameContext:Back()
	end
end

function ActivityOathDrawGameView:GetBestRewardDropID()
	local var_18_0

	if ActivityLimitedDrawPoolListCfg[self.curPoolID_].pool_type == 1 then
		_, var_18_0 = ActivityOathDrawData:GetGiftID()
	elseif ActivityLimitedDrawPoolListCfg[self.curPoolID_].pool_type == 2 then
		var_18_0 = ActivityOathDrawData:GetSceneDropID(self.curPoolActivityId_)
	end

	return var_18_0
end

function ActivityOathDrawGameView:CheckIsNeedExchange(arg_19_1, arg_19_2)
	if not self.isEarlyGetBestReward_ then
		return false
	end

	if arg_19_2 ~= self:GetBestRewardDropID() then
		return false
	end

	local var_19_0 = ItemCfg[arg_19_1]

	if not ItemCfg[arg_19_1] then
		return false
	end

	if not var_19_0.num_exchange_item then
		return false
	end

	return true
end

function ActivityOathDrawGameView:ShowRewardPopup(arg_20_1, arg_20_2)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		for iter_20_2, iter_20_3 in ipairs(ActivityLimitedDrawPoolCfg[iter_20_1].reward) do
			if ItemCfg[iter_20_3[1]].type == ItemConst.ITEM_TYPE.GIFT then
				local var_20_1 = false

				for iter_20_4, iter_20_5 in pairs(ItemCfg[iter_20_3[1]].param) do
					if self:CheckIsNeedExchange(iter_20_5[1], iter_20_1) then
						for iter_20_6, iter_20_7 in pairs(ItemCfg[iter_20_5[1]].num_exchange_item) do
							table.insert(var_20_0, {
								id = iter_20_7[1],
								num = iter_20_7[2]
							})

							var_20_1 = true
						end
					end
				end

				if not var_20_1 then
					for iter_20_8, iter_20_9 in pairs(ItemCfg[iter_20_3[1]].param) do
						table.insert(var_20_0, {
							id = iter_20_9[1],
							num = iter_20_9[2] * iter_20_3[2]
						})
					end
				end
			elseif self:CheckIsNeedExchange(iter_20_3[1], iter_20_1) then
				for iter_20_10, iter_20_11 in pairs(ItemCfg[iter_20_3[1]].num_exchange_item) do
					table.insert(var_20_0, {
						id = iter_20_11[1],
						num = iter_20_11[2] * iter_20_3[2]
					})
				end
			else
				table.insert(var_20_0, {
					id = iter_20_3[1],
					num = iter_20_3[2]
				})
			end
		end
	end

	self:ExitOtherView()
	getReward(mergeReward(var_20_0), nil, arg_20_2)
	self:UpdateRemainCountShow()
end

function ActivityOathDrawGameView:ExecuteOnClick()
	ActivityOathDrawAction.OnClickStartDraw(self.curPoolActivityId_, self.curPoolID_)
end

function ActivityOathDrawGameView:AddUIListeners()
	self:AddBtnListener(self.btnInfo_, nil, function()
		if not self:CheckIsCanClick() then
			return
		end

		JumpTools.OpenPageByJump("skinDrawInfo", {
			isOath = true,
			poolID = self.curPoolID_,
			mainActivity = self.activityID_,
			poolActivityID = self.curPoolActivityId_
		})
	end)
	self:AddBtnListener(self.oneBtn_, nil, function()
		if not self:CheckIsCanClick() then
			return
		end

		self:OnClickOneKeyBtn()
	end)
end

function ActivityOathDrawGameView:CheckIsCanClick()
	if self.isStartOpenCard then
		return false
	end

	local var_25_0 = self.drawCardAni_:GetCurrentAnimatorStateInfo(0)

	if var_25_0:IsName("UI_Oath_coupo") and var_25_0.normalizedTime < 1 then
		return false
	else
		return true
	end

	return true
end

function ActivityOathDrawGameView:OnClickOneKeyBtn()
	if not self:CheckIsMeetCostNum() then
		self:OpenCostShopPop()

		return
	end

	if not _G.SkipTip.SkipActivityOathSkinDrawTip_ then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips(string.format(GetTips("WEDDING_AUTO_DRAW_TIPS1"), ItemTools.getItemName(self.costID))),
			OkCallback = function()
				self:ExecuteOnClick()
			end,
			CancelCallback = function()
				return
			end,
			ToggleCallback = function(arg_29_0)
				_G.SkipTip.SkipActivityOathSkinDrawTip_ = arg_29_0
			end
		})
	else
		self:ExecuteOnClick()
	end
end

function ActivityOathDrawGameView:OnEnter()
	self.isStartOpenCard = false

	self:AddEventListeners()
	self:InitData()
	self:RefreshUI()
	self:AddEnterAnimimer()
end

function ActivityOathDrawGameView:DelEnterAnimTimer()
	if self.enterAnimTimer_ then
		self.enterAnimTimer_:Stop()

		self.enterAnimTimer_ = nil
	end
end

function ActivityOathDrawGameView:AddEnterAnimimer()
	self:DelEnterAnimTimer()

	local var_32_0 = false

	self.enterAnimTimer_ = Timer.New(function()
		if self:CheckEnterAniIsFinish() then
			self:RefreshBar()
			self:DelEnterAnimTimer()
		end

		if self:CheckIsRefreshCardAni() and not var_32_0 then
			for iter_33_0, iter_33_1 in ipairs(self.drawDataList_) do
				if self.drawList_[iter_33_1.index] and self.drawList_[iter_33_1.index].isOpen then
					self.drawList_[iter_33_1.index]:CheckRefreshAniState()
				end
			end

			var_32_0 = true
		end
	end, 0.1, -1)

	self.enterAnimTimer_:Start()
end

function ActivityOathDrawGameView:CheckEnterAniIsFinish()
	if self.anim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
		return true
	end

	return false
end

function ActivityOathDrawGameView:CheckIsRefreshCardAni()
	if self.anim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.6 then
		return true
	end

	return false
end

function ActivityOathDrawGameView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_OATH_SKIN_DRAW_OPEN, handler(self, self.OnSkinStartDraw))
end

function ActivityOathDrawGameView:OnSkinDrawUpdate()
	self:PlayResetAni()
	self:UpdateBestRewardUI()
	self:UpdateOneKey()
end

function ActivityOathDrawGameView:OnSkinStartDraw(arg_38_1, arg_38_2)
	self.OnClickDropList = {}

	self:StartDrawCard(1, arg_38_1, arg_38_2)
end

function ActivityOathDrawGameView:DelCheckDrawListCompleteAni()
	if self.closeCompleteAniTimer_ then
		self.closeCompleteAniTimer_:Stop()

		self.closeCompleteAniTimer_ = nil
	end
end

function ActivityOathDrawGameView:PlayResetAni()
	local var_40_0, var_40_1 = self:GetCardListData()
	local var_40_2 = true

	if var_40_1 and var_40_0 > 0 then
		var_40_2 = false
	elseif var_40_0 >= ActivityOathDrawData:GetRemainCanDrawCnt(self.curPoolActivityId_) then
		var_40_2 = false
	end

	if not var_40_2 then
		self.isStartOpenCard = false

		return
	end

	self:DelCheckDrawListCompleteAni()

	local var_40_3

	for iter_40_0, iter_40_1 in pairs(self.drawList_) do
		if iter_40_1.isOpen then
			iter_40_1:PlayCloseAni()

			var_40_3 = var_40_3 or iter_40_1
		end
	end

	self.closeCompleteAniTimer_ = Timer.New(function()
		if var_40_3 and var_40_3:IsFinishCloseAni() then
			self:UpdateDrawList()
			self:DelCheckDrawListCompleteAni()
			self.drawCardAni_:Play("UI_Oath_coupo", 0, 0)

			self.isStartOpenCard = false
		end
	end, 0.1, -1)

	self.closeCompleteAniTimer_:Start()
end

function ActivityOathDrawGameView:InitData()
	self.curPoolID_ = self.params_.poolID
	self.activityID_ = self.params_.activityID
	self.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].activity_id[1]
	self.costID = OathDrawTools.GetDrawCost(self.curPoolID_)
	self.isEarlyGetBestReward_ = self.params_.isGetBestReward
end

function ActivityOathDrawGameView:RefreshUI()
	self:UpdateDrawList()
	self:UpdateOneKey()
	self:UpdateBestRewardUI()
	self:UpdateRemainCountShow()

	self.costImg_.sprite = ItemTools.getItemSprite(self.costID, nil, true)
end

function ActivityOathDrawGameView:UpdateRemainCountShow()
	local var_44_0 = OathDrawTools.GetDrawMaxDropCount(self.curPoolID_)

	self.drawText_.text = string.format(GetTips("SKIN_DRAE_DESC"), var_44_0, OathDrawTools.GetPoolBestRewardName(self.curPoolID_))
	self.remainCntText_.text = string.format("%s/%s", var_44_0 - ActivityOathDrawData:GetRemainCanDrawCnt(self.curPoolActivityId_), var_44_0)
end

function ActivityOathDrawGameView:UpdateDrawList()
	self.drawDataList_ = ActivityOathDrawData:GetDrawData(self.curPoolActivityId_)

	for iter_45_0, iter_45_1 in ipairs(self.drawList_) do
		iter_45_1:Show(false)
	end

	for iter_45_2, iter_45_3 in ipairs(self.drawDataList_) do
		if self.drawList_[iter_45_3.index] then
			self.drawList_[iter_45_3.index]:Show(true)
			self.drawList_[iter_45_3.index]:SetData(iter_45_3)
		end
	end
end

function ActivityOathDrawGameView:UpdateOneKey()
	self.drawDataList_ = ActivityOathDrawData:GetDrawData(self.curPoolActivityId_)

	local var_46_0 = false
	local var_46_1 = 0

	for iter_46_0, iter_46_1 in ipairs(self.drawDataList_) do
		if not iter_46_1.isOpen then
			var_46_1 = var_46_1 + 1

			if var_46_1 >= 1 then
				var_46_0 = true

				break
			end
		end
	end

	if var_46_0 then
		self.btnOneKeyController_:SetSelectedState("show")
	else
		self.btnOneKeyController_:SetSelectedState("hide")
	end
end

function ActivityOathDrawGameView:UpdateBestRewardUI()
	if ActivityLimitedDrawPoolListCfg[self.curPoolID_].pool_type == 1 then
		self.rewardTypeController_:SetSelectedState("skin")

		local var_47_0, var_47_1 = ActivityOathDrawData:GetGiftID()

		self:RefreshSkinReward(var_47_1)
	elseif ActivityLimitedDrawPoolListCfg[self.curPoolID_].pool_type == 2 then
		self.rewardTypeController_:SetSelectedState("normal")
		self:RefreshDLCReward()
	end
end

function ActivityOathDrawGameView:RefreshDLCReward()
	self.sceneReward_:RefreshData({
		itemId = ActivityOathDrawData:GetSceneID(self.curPoolActivityId_),
		count = ActivityOathDrawData:GetDrawInfo(self.curPoolActivityId_, (ActivityOathDrawData:GetSceneDropID(self.curPoolActivityId_))).num
	}, self.curPoolID_)
end

function ActivityOathDrawGameView:RefreshSkinReward(arg_49_1)
	self.skinGiftReward_:SetData(arg_49_1, self.curPoolActivityId_, nil, self.curPoolID_)
end

function ActivityOathDrawGameView:OnExit()
	self:DelCheckDrawListCompleteAni()
	self:DelCheckOpenAniTimer()
	self:DelEnterAnimTimer()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ActivityOathDrawGameView:OnTop()
	self:RefreshBar()
end

function ActivityOathDrawGameView:RefreshBar()
	if not self:CheckEnterAniIsFinish() then
		manager.windowBar:HideBar()

		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		self.costID,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function()
		if self.isStartOpenCard then
			return
		end

		self:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if self.isStartOpenCard then
			return
		end

		gameContext:Go("/home", nil, nil, true)
	end)
end

function ActivityOathDrawGameView:Dispose()
	for iter_55_0, iter_55_1 in ipairs(self.drawList_) do
		iter_55_1:Dispose()

		iter_55_1 = nil
	end

	self.drawList_ = nil

	if self.skinRewardItemList_ then
		for iter_55_2, iter_55_3 in ipairs(self.skinRewardItemList_) do
			iter_55_3:Dispose()
		end

		self.skinRewardItemList_ = {}
	end

	if self.skinGiftReward_ then
		self.skinGiftReward_:Dispose()

		self.skinGiftReward_ = nil
	end

	if self.sceneReward_ then
		self.sceneReward_:Dispose()

		self.sceneReward_ = nil
	end

	self.super.Dispose(self)
end

return ActivityOathDrawGameView
