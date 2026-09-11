local RestaurantMainView = class("RestaurantMainView", ReduxView)

function RestaurantMainView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenMainUI"
end

function RestaurantMainView:UIParent()
	return manager.ui.uiMain.transform
end

local function var_0_1(arg_3_0)
	if arg_3_0 == "back" then
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	elseif arg_3_0 == "main" then
		BackHomeTools:BackHomeGotoMain()
	end
end

local function var_0_2(arg_4_0)
	RestaurantMainView:UnUsualExitManualMode()
	var_0_1(arg_4_0)
end

function RestaurantMainView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitAwardBubble()
end

function RestaurantMainView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitAnimation()
	self:InitAutoAward()

	self.signFoodListScroll_ = LuaList.New(handler(self, self.indexSignFoodList), self.signfoodlistUilist_, NeedCookFoodItem)
	self.autoScrollTime = GameDisplayCfg.canteen_roller_speed.value[1]
	self.quickView = BackHomeQuickJumpView.New(self.tempquickGo_)
end

function RestaurantMainView:InitController()
	self.stateController = ControllerUtil.GetController(self.statusGo_.transform, "state")
	self.manualViewController = ControllerUtil.GetController(self.transform_, "mode")
	self.switchBtnController = ControllerUtil.GetController(self.switchTrs_, "state")
	self.hideButtonController = ControllerUtil.GetController(self.transform_, "hide")
end

function RestaurantMainView:InitAnimation()
	self.moneyAnimator = self:FindCom(typeof(Animator), "", self.emptydreamcanteenitemTrs_)
	self.leableAnimator = self:FindCom(typeof(Animator), "", self.labelTrs_)
	self.tipsAnimation = self.deficiencytipsGo_:GetComponent("Animation")
end

function RestaurantMainView:InitAutoAward()
	self.offset = 200
	self.currencyiconImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_DORM_GOLD.item_id)
end

function RestaurantMainView:OnEnter()
	self:BindRedPoint()
	self:RegisterEvents()
	self:UpdateView()

	self.canJump = true

	self.moneyAnimator:Update(0)
	self.quickView:OnEnter()
	self:StartAwardBubble()
	self.tempquickGo_.transform:SetAsLastSibling()
	self.quickView:ShowView(false)
	self:StartRefreshEntrust()
end

function RestaurantMainView:OnTop()
	self:RefreshBar()
end

function RestaurantMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_DORM_GOLD, true)

	if #GameSetting.canteen_festival_info_describe.value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = GameSetting.canteen_festival_info_describe.value
			}
		})
	end

	manager.windowBar:RegistBackCallBack(function()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CANTEEN_QUIT_CONFIRM"),
				OkCallback = function()
					var_0_2("back")
				end,
				CancelCallback = function()
					return
				end
			})
		else
			var_0_1("back")
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CANTEEN_QUIT_CONFIRM"),
				OkCallback = function()
					var_0_2("main")
				end,
				CancelCallback = function()
					return
				end
			})
		else
			var_0_1("main")
		end
	end)
end

function RestaurantMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:bindUIandKey(self.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:bindUIandKey(self.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	manager.redPoint:bindUIandKey(self.recipebtnBtn_.transform, RedPointConst.CANTEEN_UNLOCK_FOOD)
	manager.redPoint:bindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	manager.redPoint:bindUIandKey(self.emptydreamcanteenitemTrs_, RedPointConst.CANTEEN_MAX)
end

function RestaurantMainView:UpdateView()
	self:UpdataPopularity()
	self:UpdataSignFoodList()
	CanteenData:ChooseCanteenAutoState()
end

function RestaurantMainView:UpdataPopularity()
	self.popnumText_.text = CanteenData:GetPopularityNum()
end

function RestaurantMainView:UpdataSignFoodList()
	self.signFoodList = {}

	local var_22_0 = CanteenFoodData:GetChooseFoodList()

	if #var_22_0 > 2 then
		while 1 <= 2 do
			for iter_22_0, iter_22_1 in ipairs(var_22_0) do
				table.insert(self.signFoodList, iter_22_1)
			end
		end
	else
		for iter_22_2, iter_22_3 in ipairs(var_22_0) do
			table.insert(self.signFoodList, iter_22_3)
		end
	end

	self.signFoodListScroll_:StartScroll(#self.signFoodList)
	self:UpdateFoodScroll()
end

function RestaurantMainView:indexSignFoodList(arg_23_1, arg_23_2)
	arg_23_2:RefreshUI(self.signFoodList[arg_23_1])
end

function RestaurantMainView:UpdateFoodScroll()
	self.index = 1

	if #self.signFoodList >= 6 then
		self:StartAutoScroll()

		if not self.AutoScrollTimer then
			self.AutoScrollTimer = Timer.New(handler(self, self.StartAutoScroll), self.autoScrollTime, -1)

			self.AutoScrollTimer:Start()
		end
	end
end

function RestaurantMainView:StartAutoScroll()
	self.index = self.index + 1

	if #self.signFoodList - 1 == self.index then
		self.index = #self.signFoodList / 2 - 2

		self.signFoodListScroll_:ScrollToIndex(self.index, false, false)

		self.index = self.index + 1

		self.signFoodListScroll_:ScrollToIndex(self.index, false, true, self.autoScrollTime)
	else
		self.signFoodListScroll_:ScrollToIndex(self.index, false, true, self.autoScrollTime)
	end

	self.signfoodlistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function RestaurantMainView:EndAutoScroll()
	if self.AutoScrollTimer then
		self.AutoScrollTimer:Stop()

		self.AutoScrollTimer = nil

		self.signFoodListScroll_:RemoveTween()
	end
end

function RestaurantMainView:InitAwardBubble()
	self:UpdataAwardBubble()
	self:StartAwardBubble()
end

function RestaurantMainView:StopAwardBubble()
	if self.atuoAwardTrsTimer then
		self.atuoAwardTrsTimer:Stop()

		self.atuoAwardTrsTimer = nil
	end
end

function RestaurantMainView:StartAwardBubble()
	self:StopAwardBubble()

	self.atuoAwardTrsTimer = FrameTimer.New(function()
		self:UpdataAwardBubbleTrs()
		self:UpdataAwardBubble()
	end, 0.03333333333333333, -1)

	self.atuoAwardTrsTimer:Start()
end

function RestaurantMainView:StartRefreshEntrust()
	self.cacheEntrustNum_ = 0
	self.refreshTimer = self.refreshTimer or Timer.New(function()
		local var_32_0 = CanteenEntrustData:CheckTimeOverEntrustNum()

		if self.cacheEntrustNum_ ~= var_32_0 then
			self.cacheEntrustNum_ = var_32_0

			DormRedPointTools:UpdateCanteenNotify()
		end
	end, 1, -1)

	self.refreshTimer:Start()
end

function RestaurantMainView:AddUIListener()
	self:AddBtnListenerScale(self.navigationBtn_, nil, function()
		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = false
		})
	end)
	self:AddBtnListenerScale(self.startautomoduleBtn_, nil, function()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)

			return
		end
	end)
	self:AddBtnListenerScale(self.manualbtnBtn_, nil, function()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			return
		end

		if not CanteenTools:AutoModeReadyForBusiness() then
			return
		end

		ShowMessageBox({
			isTop = true,
			content = GetTips("CANTEEN_MANNUALLY_OPT"),
			OkCallback = function()
				CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantManual)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListenerScale(self.shopbtnBtn_, nil, function()
		if self.canJump then
			JumpTools.GoToSystem("/activityShop", {
				hideHomeBtn = 1,
				shopId = ShopConst.SHOP_ID.CANTEEN_SHOP,
				showShops = {
					ShopConst.SHOP_ID.CANTEEN_SHOP
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	self:AddBtnListenerScale(self.taskbtnBtn_, nil, function()
		if self.canJump then
			DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_NONE)
			saveData("DormTaskRedpoint", "lastClickTime", manager.time:GetServerTime())
			JumpTools.OpenPageByJump("/dormTaskDispatchView")
		end
	end)
	self:AddBtnListenerScale(self.signfoodBtn_, nil, function()
		if self.canJump then
			if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
				return
			end

			JumpTools.OpenPageByJump("/chooseSignFoodView")
		end
	end)
	self:AddBtnListenerScale(self.recipebtnBtn_, nil, function()
		if self.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.foodMenu
			})
		end
	end)
	self:AddBtnListenerScale(self.warehousebtnBtn_, nil, function()
		if self.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.bag
			})
		end
	end)
	self:AddBtnListenerScale(self.hidebtnBtn_, nil, function()
		if self.hideButtonController:GetSelectedState() == "false" then
			self.hideButtonController:SetSelectedState("true")
		else
			self.hideButtonController:SetSelectedState("false")
			self.leableAnimator:SetFloat("speed", 1)
			self.leableAnimator:Play("ShowLabel")
		end
	end)
	self:AddBtnListenerScale(self.autoAwardBtn_, nil, function()
		local var_45_0, var_45_1 = CanteenData:GetAutoNextAwardTime()

		if var_45_0 < 0 and var_45_1 < 0 then
			if CanteenData:GetAutoAwardNum() == 0 then
				ShowTips("CANTEEN_ADMITTED_NULL")

				return
			end

			local var_45_2 = DormData:GetCurrectSceneID()

			if var_45_2 then
				CanteenAction:ReceiveCanteenAutoAward(var_45_2)
			end

			self.moneyAnimator:Play("GetMoney", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_coin", "")

			self.canJump = false

			if self.canJumpTimer then
				self.canJumpTimer:Stop()

				self.canJumpTimer = nil
			end

			self.canJumpTimer = Timer.New(function()
				self.canJump = true
			end, 0.3, 1)

			self.canJumpTimer:Start()
		end
	end)
	self:AddBtnListenerScale(self.jobSetBtn_, nil, function()
		if self.canJump then
			JumpTools.OpenPageByJump("/restaurantJobSetView")
			DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_JOB_AVAILABLE, DormRedPointTools.RedPointType.Session)
		end
	end)
	self:AddBtnListenerScale(self.cookBtn_, nil, function()
		if self.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView")
		end
	end)
	self:AddBtnListenerScale(self.lackBtn_, nil, function()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			if BackHomeNpcData:CheckNpsIsWorkInCanteen() then
				local var_49_0

				for iter_49_0, iter_49_1 in ipairs(DormNpcTools.BackHomeNpcType) do
					if DormNpcTools:CheckHasNpcWorkOnJob(iter_49_1) then
						var_49_0 = iter_49_1
					end
				end

				JumpTools.OpenPageByJump("/restaurantJobSetView", {
					jobType = var_49_0
				})
			end
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
			if not CanteenTools:CheckSignFoodNumCanOpen() then
				JumpTools.OpenPageByJump("/chooseSignFoodView", {
					type = DormEnum.FurnitureTypeNum.Pan1
				})
			elseif not CanteenTools:CheckCanteenJobCanOpen() then
				JumpTools.OpenPageByJump("/restaurantJobSetView")
				DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_JOB_AVAILABLE, DormRedPointTools.RedPointType.Session)
			end
		end
	end)
	self:AddBtnListenerScale(self.canteenInfoBtn_, nil, function()
		if self.canJump then
			JumpTools.OpenPageByJump("/canteenAutoInfoView")
		end
	end)
	self.quickView:AddClickCallBack(function()
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DORM_GOLD
		})
	end)
	self.quickView:CloseCallBack(function()
		self:RefreshBar()
	end)
end

function RestaurantMainView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_RESTAURANT_STATUS_EVENT, function(arg_54_0)
		self:UpdataCanteenState()
	end)
	self:RegistEventListener(CANTEEN_UPDATE_STATE, function()
		self:UpdateView()
	end)
	self:RegistEventListener(CANTEEN_SIGN_FOOD_NUM_CHANGE, function()
		self.signFoodListScroll_:Refresh()
	end)
	self:RegistEventListener(CANTEEN_MANUAL_REWARD_CALLBACK, function()
		JumpTools.OpenPageByJump("/canteenManualRewardView")
	end)
	self:RegistEventListener(DORM_LOGIC_TICK, handler(self, self.UpdataTimeBar))
	self:RegistEventListener(DORM_REFRESH_POPULAR_EVENT, function()
		self:UpdataPopularity()
	end)
	self:RegistEventListener(CANTEEN_FUR_LEVEL, function(arg_59_0)
		if self.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView", {
				type = BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_59_0].type_id].type,
				furEID = arg_59_0
			})
		end
	end)
end

function RestaurantMainView:UpdataCanteenState()
	if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
		self.manualViewController:SetSelectedState("auto")

		if BackHomeNpcData:CheckNpsIsWorkInCanteen() then
			self.stateController:SetSelectedState("npcmode")

			self.closeText_.text = GetTips("CANTEEN_NPC_IS_WORK")
		else
			self.stateController:SetSelectedState("business")
		end

		self.switchBtnController:SetSelectedState("automatic")
		SetActive(self.emptydreamcanteenitemGo_1, true)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
		self.stateController:SetSelectedState("ManualOperating")
		self.manualViewController:SetSelectedState("manual")
		self.switchBtnController:SetSelectedState("manual")
		SetActive(self.emptydreamcanteenitemGo_1, false)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
		self.stateController:SetSelectedState("closed")
		self.tipsAnimation:Play()

		if not CanteenTools:CheckSignFoodNumCanOpen() then
			self.closeText_.text = GetTips("CANTEEN_FOOD_NOT_SUFFICIENT")
		elseif not CanteenTools:CheckCanteenJobCanOpen() then
			self.closeText_.text = GetTips("CANTEEN_JOB_NOT_FIT")
		end
	end
end

function RestaurantMainView:UpdataAwardBubble()
	local var_61_0, var_61_1, var_61_2 = CanteenData:GetAutoNextAwardTime()
	local var_61_3 = CanteenData:GetAutoAwardNum() or 0
	local var_61_4 = DormSkillData:GetInComeStorageMax()

	if var_61_0 < 0 or var_61_1 < 0 then
		self.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS2")

		if var_61_3 == 0 then
			self.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS3")
		end
	else
		local var_61_5 = ""

		if var_61_0 > 0 then
			var_61_5 = string.format("%d", var_61_0) .. GetTips("HOUR") .. string.format("%d", var_61_1) .. GetTips("MINUTE")
		elseif var_61_0 == 0 and var_61_1 > 0 then
			var_61_5 = string.format("%d", var_61_1) .. GetTips("MINUTE")
		elseif var_61_1 == 0 and var_61_2 > 0 then
			var_61_5 = string.format("%d", var_61_2) .. GetTips("SECOND")
		end

		self.awardtimetextText_.text = string.format(GetTips("CANTEEN_MONEY_TIPS1"), var_61_5)
	end

	self.awardtotaltextText_.text = string.format("%d<size=26><color=#767878>/%d</color></size>", var_61_3, var_61_4)
end

function RestaurantMainView:UpdataAwardBubbleTrs()
	local var_62_0, var_62_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, (Dorm.DormEntityManager.QueryPosition(CanteenAIFunction:GetAllEIDNameSpace((CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.CashierTable)))[1]))), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	if var_62_1 == nil then
		print("未找到对应的视口坐标")

		return
	end

	var_62_1.y = var_62_1.y + self.offset
	self.emptydreamcanteenitemTrs_.localPosition = var_62_1
end

function RestaurantMainView:UpdataTimeBar()
	local var_63_0 = Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, "timer")

	self.timebarImg_.fillAmount = 1 - ((var_63_0 and var_63_0:IsRunning() or nil) and var_63_0:QueryTime() / var_63_0.duration)
end

function RestaurantMainView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:unbindUIandKey(self.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:unbindUIandKey(self.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	manager.redPoint:unbindUIandKey(self.recipebtnBtn_.transform, RedPointConst.CANTEEN_UNLOCK_FOOD)
	manager.redPoint:unbindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	manager.redPoint:unbindUIandKey(self.emptydreamcanteenitemTrs_, RedPointConst.CANTEEN_MAX)
	self:RemoveAllEventListener()
	self:EndAutoScroll()
	self:StopAwardBubble()
	self.quickView:OnExit()

	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	self.cacheEntrustNum_ = 0
end

function RestaurantMainView:UnUsualExitManualMode()
	CharacterBubbleManager:Dispose()
	CanteenAction:ChangeCanteenMode(CanteenData:GetCanteenState(), DormEnum.RestaurantMode.RestaurantAuto, true)
end

function RestaurantMainView:Dispose()
	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	self.cacheEntrustNum_ = 0

	if self.signFoodListScroll_ then
		self.signFoodListScroll_:Dispose()

		self.signFoodListScroll_ = nil
	end

	if self.atuoAwardTrsTimer then
		self.atuoAwardTrsTimer:Stop()

		self.atuoAwardTrsTimer = nil
	end

	if self.canJumpTimer then
		self.canJumpTimer:Stop()

		self.canJumpTimer = nil
	end

	self.moneyAnimator = nil

	self.quickView:Dispose()
	RestaurantMainView.super.Dispose(self)
end

return RestaurantMainView
