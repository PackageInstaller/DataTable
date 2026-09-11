local PassportMainView = class("PassportMainView", ReduxView)
local var_0_1 = {
	pay = 201,
	free = 0,
	vip = 202
}

function PassportMainView:UIName()
	return "Widget/System/Passport/PassportMainUI"
end

function PassportMainView:UIParent()
	return manager.ui.uiMain.transform
end

function PassportMainView:OnCtor()
	return
end

function PassportMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportMainView:InitUI()
	self:BindCfgUI()

	self.controller = Object.Instantiate(Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path), self.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	self.controller:SetSelectedState("PassportMainUI")

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, PassportRewardItemView)
	self.nextCommonItem1_ = CommonItemView.New(self.rightCommonItem1_)
	self.nextCommonItem2_ = CommonItemView.New(self.rightCommonItem2_)
	self.CommonData1 = clone(ItemTemplateData)
	self.CommonData2 = clone(ItemTemplateData)
	self.bpNewController_ = self.controllerEx_:GetController("isNewPBRecharge")
end

function PassportMainView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.rewardIdList_[arg_6_1])
end

function PassportMainView:AddUIListener()
	self.list_:SetHeadTailChangeHandler(handler(self, self.HeadTailChangeHandler))
	self:AddBtnListener(self.buyLevelBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", {
			notRemainLevel = true
		}, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/passportTask")
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("bp_shop")
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.PASSPORT_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	self:AddBtnListener(self.oneKeyGetBtn_, nil, function()
		local var_12_0 = PassportData:GetCanGetBonusList()

		if #var_12_0 > 0 then
			if PassportData:GetPayLevel() > 0 then
				PassportAction.OneKeyGet(var_12_0)
			else
				local var_12_1 = PassportData:GetLevel()
				local var_12_2 = PassportData:GetReceiveInfo()
				local var_12_3 = false

				for iter_12_0, iter_12_1 in ipairs(GameSetting.battlepass_level_noti.value) do
					if PassportData:GetReceiveInfo(self.rewardIdList_[iter_12_1]) or var_12_1 < iter_12_1 then
						var_12_3 = false
					else
						var_12_3 = true

						break
					end
				end

				if var_12_3 then
					JumpTools.OpenPageByJump("passportBuyPopView")
				else
					PassportAction.OneKeyGet(var_12_0)
				end
			end
		end
	end)
	self:AddBtnListener(self.viewBtn_, nil, function()
		local var_13_0 = BattlePassListCfg[PassportData:GetId()]

		if var_13_0.battlepass_type >= 17 then
			JumpTools.OpenPageByJump("/weaponServant", {
				customServant = var_13_0.servant_list
			})
		end
	end)
	self:AddBtnListener(self.commonItem2_, nil, function()
		JumpTools.OpenPageByJump("passportShow", {
			type = 2
		})
	end)
	self:AddBtnListener(self.commonItem1_, nil, function()
		JumpTools.OpenPageByJump("passportShow", {
			type = 1
		})
	end)

	function self.CommonData1:clickFun()
		local var_16_0 = BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]]
		local var_16_1 = PassportData:GetRewardStatus(self.nearestBonusIndex_, BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]].id)

		if var_16_1 ~= "freeCanGet" and var_16_1 ~= "payCanGet" then
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})

			return
		end

		PassportAction.RequestGetBonus(var_16_0.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end

	function self.CommonData2:clickFun()
		local var_17_0 = BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]]
		local var_17_1 = PassportData:GetRewardStatus(self.nearestBonusIndex_, BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]].id)

		if var_17_1 ~= "payCanGet" and var_17_1 ~= "payHalfCanGet" then
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})

			return
		end

		PassportAction.RequestGetBonus(var_17_0.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end
end

function PassportMainView:HeadTailChangeHandler(arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 + 1
	arg_18_2 = math.max(1, arg_18_2)
	self.minEndIndex_ = self.minEndIndex_ or arg_18_2
	self.nearestBonusIndex_ = self:GetNextBonusIndex(arg_18_2)

	self:UpdateNextBonus()
end

function PassportMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "passportNote",
		type = "jump",
		params = {}
	})
end

function PassportMainView:UpdateView()
	self.levelLabel_.text = PassportData:GetLevel()

	local var_20_0 = PassportData:GetCurrentExp()
	local var_20_1 = PassportData:GetUpgradeNeedExp()
	local var_20_2 = math.min((PassportData:GetLevel() >= PassportData:GetMaxLevel() or nil) and var_20_1, var_20_1)

	self.expProgress_.value = var_20_2 / var_20_1
	self.expLabel_.text = string.format("%d/%d", var_20_2, var_20_1)
	self.expLimitLabel_.text = string.format("%d/%d", PassportData:GetExpWeekly(), GameSetting.battlepass_exp_limit_weekly.value[1])

	SetActive(self.buyLevelBtn_.gameObject, PassportData:GetLevel() < PassportData:GetMaxLevel())

	local var_20_3 = BattlePassListCfg[PassportData:GetId()].battlepass_type

	if var_20_3 >= 17 then
		self.rewardTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_MAIN")
	end

	SetActive(self.viewBtn_.gameObject, var_20_3 >= 17)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bglvTransform_)
	ActivityNewbieTools.RefreshNewBPRecharge(self.bpNewController_)
	SetActive(self.discountHighlight_, (PassportData:HasDiscount()))
end

function PassportMainView:UpdateNextBonus(arg_21_1)
	arg_21_1 = arg_21_1 or false

	local var_21_0 = BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]]

	self.nextBonusLevelLabel_.text = string.format("%d", self.nearestBonusIndex_)
	self.nextBonusBottomLabel_.text = string.format("%d", self.nearestBonusIndex_)

	if arg_21_1 == false then
		-- block empty
	end

	local var_21_3 = PassportData:GetRewardStatus(self.nearestBonusIndex_, var_21_0.id)
	local var_21_4 = {
		id = var_21_0.reward_free[1][1],
		number = var_21_0.reward_free[1][2]
	}
	local var_21_5 = {
		id = var_21_0.reward_pay[1][1],
		number = var_21_0.reward_pay[1][2]
	}

	var_21_4.highLight = false
	var_21_4.completedFlag = false
	var_21_5.highLight = false
	var_21_5.completedFlag = false
	var_21_5.locked = false

	if PassportData:GetPayLevel() <= 0 then
		var_21_5.locked = true
	end

	if var_21_3 == "payHaveGet" then
		var_21_5.completedFlag = true
		var_21_4.completedFlag = true
	elseif var_21_3 == "payCanGet" then
		var_21_5.highLight = true
		var_21_4.highLight = true
	elseif var_21_3 == "freeHaveGet" then
		var_21_4.completedFlag = true
	elseif var_21_3 == "freeCanGet" then
		var_21_4.highLight = true
	end

	CommonTools.SetCommonData(self.nextCommonItem1_, var_21_4, self.CommonData1)
	CommonTools.SetCommonData(self.nextCommonItem2_, var_21_5, self.CommonData2)
end

function PassportMainView:GetFirstIndex()
	local var_22_0, var_22_1 = PassportData:GetCurrentStatus()

	if var_22_0 > 0 then
		return var_22_0
	end

	if var_22_1 > 0 then
		return var_22_1
	end

	return 1
end

function PassportMainView:InitData()
	self.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	self.nearestBonusIndex_ = self:GetNextBonusIndex(self.minEndIndex_ or 1)
end

function PassportMainView:GetNextBonusIndex(arg_24_1)
	for iter_24_0 = arg_24_1, #self.rewardIdList_ do
		if not BattlePassCfg[self.rewardIdList_[iter_24_0]] then
			print("rewardData is null")
		end

		if BattlePassCfg[self.rewardIdList_[iter_24_0]].display == 1 then
			return iter_24_0
		end
	end

	return self.nearestBonusIndex_
end

function PassportMainView:UpdateRewardView()
	SetActive(self.unlockBtn_.gameObject, PassportData:GetPayLevel() ~= var_0_1.vip)
	SetActive(self.leftLockIconGo_, PassportData:GetPayLevel() <= 0)
	SetActive(self.oneKeyGetBtn_.gameObject, #PassportData:GetCanGetBonusList() > 0)
end

function PassportMainView:AddEventListeners()
	self:RegistEventListener(GET_BONUS_SUCCESS, handler(self, self.OnGetBonus))
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_27_0)
		if arg_27_0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			self:UpdateView()
			self:OnPassportBuyed()
		end
	end)
	self:RegistEventListener(PASSPORT_BUYED, handler(self, self.OnPassportBuyed))
end

function PassportMainView:OnGetBonus(arg_28_1)
	self:UpdateRewardView()

	if arg_28_1 == BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]].id or arg_28_1 == 0 then
		self:UpdateNextBonus()
	end
end

function PassportMainView:OnPassportBuyed()
	self.list_:Refresh()
	self:UpdateRewardView()
	self:UpdateNextBonus()
end

function PassportMainView:OnEnter()
	self.enteredPage_ = {}

	if self:CheckOutofDate() then
		return
	end

	self:InitData()
	self:UpdateView()
	self:UpdateRewardView()
	self:UpdateNextBonus(true)
	self.list_:StartScroll(#self.rewardIdList_, (self:GetFirstIndex()))

	self.timer_ = self.timer_ or Timer.New(function()
		self:UpdateTimer()
	end, 1, -1)

	self.timer_:Start()
	self:UpdateTimer()
	self:AddEventListeners()

	self.isPopPoster = false

	if getData("passport", "poster_" .. PassportData:GetId()) ~= "1" then
		saveData("passport", "poster_" .. PassportData:GetId(), "1")
		manager.redPoint:setTip(RedPointConst.PASSPORT_NEW_SEASON, 0, RedPointStyle.SHOW_NEW_TAG)
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("passportPoster")
		end, {})

		self.isPopPoster = true
	else
		self.isPopPoster = false
	end

	self:RegisterRedPoint()
end

function PassportMainView:CheckWeakGuide()
	return
end

function PassportMainView:UpdateTimer()
	self.duringLabel1_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp())) .. string.format("  %s-%s", manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S"), (manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S")))

	self:CheckOutofDate()
end

function PassportMainView:CheckOutofDate()
	if not PassportData:IsOpen() or manager.time:GetServerTime() >= PassportData:GetEndTimestamp() then
		TimeTools.StartAfterSeconds(0.1, function()
			self:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function PassportMainView:OnBuyPassportLevel()
	self:OnPassportBuyed()
end

function PassportMainView:OnExit()
	self:UnRegisterRedPoint()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PassportMainView:RegisterRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
	manager.redPoint:bindUIandKey(self.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function PassportMainView:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
	manager.redPoint:unbindUIandKey(self.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function PassportMainView:OnTop()
	self:UpdateBar()

	if not self.isPopPoster then
		self:RealCheckWeakGuide()
	else
		self.isPopPoster = false
	end
end

function PassportMainView:OnBehind()
	manager.windowBar:HideBar()
end

function PassportMainView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.CommonData1 = nil
	self.CommonData2 = nil

	PassportMainView.super.Dispose(self)
end

return PassportMainView
