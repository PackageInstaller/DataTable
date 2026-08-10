local var_0_0 = class("RestaurantMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenMainUI"
end

function var_0_0.UIParent(arg_2_0)
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
	var_0_0:UnUsualExitManualMode()
	var_0_1(arg_4_0)
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
	arg_5_0:InitAwardBubble()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
	arg_6_0:InitController()
	arg_6_0:InitAnimation()
	arg_6_0:InitAutoAward()

	arg_6_0.signFoodListScroll_ = LuaList.New(handler(arg_6_0, arg_6_0.indexSignFoodList), arg_6_0.signfoodlistUilist_, NeedCookFoodItem)
	arg_6_0.autoScrollTime = GameDisplayCfg.canteen_roller_speed.value[1]
	arg_6_0.quickView = BackHomeQuickJumpView.New(arg_6_0.tempquickGo_)
end

function var_0_0.InitController(arg_7_0)
	arg_7_0.stateController = ControllerUtil.GetController(arg_7_0.statusGo_.transform, "state")
	arg_7_0.manualViewController = ControllerUtil.GetController(arg_7_0.transform_, "mode")
	arg_7_0.switchBtnController = ControllerUtil.GetController(arg_7_0.switchTrs_, "state")
	arg_7_0.hideButtonController = ControllerUtil.GetController(arg_7_0.transform_, "hide")
end

function var_0_0.InitAnimation(arg_8_0)
	arg_8_0.moneyAnimator = arg_8_0:FindCom(typeof(Animator), "", arg_8_0.emptydreamcanteenitemTrs_)
	arg_8_0.leableAnimator = arg_8_0:FindCom(typeof(Animator), "", arg_8_0.labelTrs_)
	arg_8_0.tipsAnimation = arg_8_0.deficiencytipsGo_:GetComponent("Animation")
end

function var_0_0.InitAutoAward(arg_9_0)
	arg_9_0.offset = 200
	arg_9_0.currencyiconImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_DORM_GOLD.item_id)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:BindRedPoint()
	arg_10_0:RegisterEvents()
	arg_10_0:UpdateView()

	arg_10_0.canJump = true

	arg_10_0.moneyAnimator:Update(0)
	arg_10_0.quickView:OnEnter()
	arg_10_0:StartAwardBubble()
	arg_10_0.tempquickGo_.transform:SetAsLastSibling()
	arg_10_0.quickView:ShowView(false)
	arg_10_0:StartRefreshEntrust()
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_DORM_GOLD, true)

	local var_12_0 = GameSetting.canteen_festival_info_describe.value

	if #var_12_0 > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = var_12_0
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

function var_0_0.BindRedPoint(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:bindUIandKey(arg_19_0.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:bindUIandKey(arg_19_0.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	manager.redPoint:bindUIandKey(arg_19_0.recipebtnBtn_.transform, RedPointConst.CANTEEN_UNLOCK_FOOD)
	manager.redPoint:bindUIandKey(arg_19_0.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	manager.redPoint:bindUIandKey(arg_19_0.emptydreamcanteenitemTrs_, RedPointConst.CANTEEN_MAX)
end

function var_0_0.UpdateView(arg_20_0)
	arg_20_0:UpdataPopularity()
	arg_20_0:UpdataSignFoodList()
	CanteenData:ChooseCanteenAutoState()
end

function var_0_0.UpdataPopularity(arg_21_0)
	arg_21_0.popnumText_.text = CanteenData:GetPopularityNum()
end

function var_0_0.UpdataSignFoodList(arg_22_0)
	arg_22_0.signFoodList = {}

	local var_22_0 = 1
	local var_22_1 = CanteenFoodData:GetChooseFoodList()

	if #var_22_1 > 2 then
		while var_22_0 <= 2 do
			for iter_22_0, iter_22_1 in ipairs(var_22_1) do
				table.insert(arg_22_0.signFoodList, iter_22_1)
			end

			var_22_0 = var_22_0 + 1
		end
	else
		for iter_22_2, iter_22_3 in ipairs(var_22_1) do
			table.insert(arg_22_0.signFoodList, iter_22_3)
		end
	end

	arg_22_0.signFoodListScroll_:StartScroll(#arg_22_0.signFoodList)
	arg_22_0:UpdateFoodScroll()
end

function var_0_0.indexSignFoodList(arg_23_0, arg_23_1, arg_23_2)
	arg_23_2:RefreshUI(arg_23_0.signFoodList[arg_23_1])
end

function var_0_0.UpdateFoodScroll(arg_24_0)
	arg_24_0.index = 1

	if #arg_24_0.signFoodList >= 6 then
		arg_24_0:StartAutoScroll()

		if not arg_24_0.AutoScrollTimer then
			arg_24_0.AutoScrollTimer = Timer.New(handler(arg_24_0, arg_24_0.StartAutoScroll), arg_24_0.autoScrollTime, -1)

			arg_24_0.AutoScrollTimer:Start()
		end
	end
end

function var_0_0.StartAutoScroll(arg_25_0)
	local var_25_0 = #arg_25_0.signFoodList

	arg_25_0.index = arg_25_0.index + 1

	if var_25_0 - 1 == arg_25_0.index then
		arg_25_0.index = var_25_0 / 2 - 2

		arg_25_0.signFoodListScroll_:ScrollToIndex(arg_25_0.index, false, false)

		arg_25_0.index = arg_25_0.index + 1

		arg_25_0.signFoodListScroll_:ScrollToIndex(arg_25_0.index, false, true, arg_25_0.autoScrollTime)
	else
		arg_25_0.signFoodListScroll_:ScrollToIndex(arg_25_0.index, false, true, arg_25_0.autoScrollTime)
	end

	arg_25_0.signfoodlistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function var_0_0.EndAutoScroll(arg_26_0)
	if arg_26_0.AutoScrollTimer then
		arg_26_0.AutoScrollTimer:Stop()

		arg_26_0.AutoScrollTimer = nil

		arg_26_0.signFoodListScroll_:RemoveTween()
	end
end

function var_0_0.InitAwardBubble(arg_27_0)
	arg_27_0:UpdataAwardBubble()
	arg_27_0:StartAwardBubble()
end

function var_0_0.StopAwardBubble(arg_28_0)
	if arg_28_0.atuoAwardTrsTimer then
		arg_28_0.atuoAwardTrsTimer:Stop()

		arg_28_0.atuoAwardTrsTimer = nil
	end
end

function var_0_0.StartAwardBubble(arg_29_0)
	arg_29_0:StopAwardBubble()

	arg_29_0.atuoAwardTrsTimer = FrameTimer.New(function()
		arg_29_0:UpdataAwardBubbleTrs()
		arg_29_0:UpdataAwardBubble()
	end, 0.03333333333333333, -1)

	arg_29_0.atuoAwardTrsTimer:Start()
end

function var_0_0.StartRefreshEntrust(arg_31_0)
	arg_31_0.cacheEntrustNum_ = 0

	if not arg_31_0.refreshTimer then
		arg_31_0.refreshTimer = Timer.New(function()
			local var_32_0 = CanteenEntrustData:CheckTimeOverEntrustNum()

			if arg_31_0.cacheEntrustNum_ ~= var_32_0 then
				arg_31_0.cacheEntrustNum_ = var_32_0

				DormRedPointTools:UpdateCanteenNotify()
			end
		end, 1, -1)
	end

	arg_31_0.refreshTimer:Start()
end

function var_0_0.AddUIListener(arg_33_0)
	arg_33_0:AddBtnListenerScale(arg_33_0.navigationBtn_, nil, function()
		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = false
		})
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.startautomoduleBtn_, nil, function()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)

			return
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.manualbtnBtn_, nil, function()
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
	arg_33_0:AddBtnListenerScale(arg_33_0.shopbtnBtn_, nil, function()
		if arg_33_0.canJump then
			JumpTools.GoToSystem("/activityShop", {
				hideHomeBtn = 1,
				shopId = ShopConst.SHOP_ID.CANTEEN_SHOP,
				showShops = {
					ShopConst.SHOP_ID.CANTEEN_SHOP
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.taskbtnBtn_, nil, function()
		if arg_33_0.canJump then
			DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_NONE)
			saveData("DormTaskRedpoint", "lastClickTime", manager.time:GetServerTime())
			JumpTools.OpenPageByJump("/dormTaskDispatchView")
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.signfoodBtn_, nil, function()
		if arg_33_0.canJump then
			if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
				return
			end

			JumpTools.OpenPageByJump("/chooseSignFoodView")
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.recipebtnBtn_, nil, function()
		if arg_33_0.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.foodMenu
			})
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.warehousebtnBtn_, nil, function()
		if arg_33_0.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.bag
			})
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.hidebtnBtn_, nil, function()
		if arg_33_0.hideButtonController:GetSelectedState() == "false" then
			arg_33_0.hideButtonController:SetSelectedState("true")
		else
			arg_33_0.hideButtonController:SetSelectedState("false")
			arg_33_0.leableAnimator:SetFloat("speed", 1)
			arg_33_0.leableAnimator:Play("ShowLabel")
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.autoAwardBtn_, nil, function()
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

			arg_33_0.moneyAnimator:Play("GetMoney", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_coin", "")

			arg_33_0.canJump = false

			if arg_33_0.canJumpTimer then
				arg_33_0.canJumpTimer:Stop()

				arg_33_0.canJumpTimer = nil
			end

			arg_33_0.canJumpTimer = Timer.New(function()
				arg_33_0.canJump = true
			end, 0.3, 1)

			arg_33_0.canJumpTimer:Start()
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.jobSetBtn_, nil, function()
		if arg_33_0.canJump then
			JumpTools.OpenPageByJump("/restaurantJobSetView")
			DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_JOB_AVAILABLE, DormRedPointTools.RedPointType.Session)
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.cookBtn_, nil, function()
		if arg_33_0.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView")
		end
	end)
	arg_33_0:AddBtnListenerScale(arg_33_0.lackBtn_, nil, function()
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
	arg_33_0:AddBtnListenerScale(arg_33_0.canteenInfoBtn_, nil, function()
		if arg_33_0.canJump then
			JumpTools.OpenPageByJump("/canteenAutoInfoView")
		end
	end)
	arg_33_0.quickView:AddClickCallBack(function()
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DORM_GOLD
		})
	end)
	arg_33_0.quickView:CloseCallBack(function()
		arg_33_0:RefreshBar()
	end)
end

function var_0_0.RegisterEvents(arg_53_0)
	arg_53_0:RegistEventListener(DORM_REFRESH_RESTAURANT_STATUS_EVENT, function(arg_54_0)
		arg_53_0:UpdataCanteenState()
	end)
	arg_53_0:RegistEventListener(CANTEEN_UPDATE_STATE, function()
		arg_53_0:UpdateView()
	end)
	arg_53_0:RegistEventListener(CANTEEN_SIGN_FOOD_NUM_CHANGE, function()
		arg_53_0.signFoodListScroll_:Refresh()
	end)
	arg_53_0:RegistEventListener(CANTEEN_MANUAL_REWARD_CALLBACK, function()
		JumpTools.OpenPageByJump("/canteenManualRewardView")
	end)
	arg_53_0:RegistEventListener(DORM_LOGIC_TICK, handler(arg_53_0, arg_53_0.UpdataTimeBar))
	arg_53_0:RegistEventListener(DORM_REFRESH_POPULAR_EVENT, function()
		arg_53_0:UpdataPopularity()
	end)
	arg_53_0:RegistEventListener(CANTEEN_FUR_LEVEL, function(arg_59_0)
		if arg_53_0.canJump then
			local var_59_0 = BackHomeCanteenFurnitureIDCfg[arg_59_0].type_id

			JumpTools.OpenPageByJump("/restaurantCookUpView", {
				type = BackHomeCanteenFurnitureCfg[var_59_0].type,
				furEID = arg_59_0
			})
		end
	end)
end

function var_0_0.UpdataCanteenState(arg_60_0)
	if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
		arg_60_0.manualViewController:SetSelectedState("auto")

		if BackHomeNpcData:CheckNpsIsWorkInCanteen() then
			arg_60_0.stateController:SetSelectedState("npcmode")

			arg_60_0.closeText_.text = GetTips("CANTEEN_NPC_IS_WORK")
		else
			arg_60_0.stateController:SetSelectedState("business")
		end

		arg_60_0.switchBtnController:SetSelectedState("automatic")
		SetActive(arg_60_0.emptydreamcanteenitemGo_1, true)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
		arg_60_0.stateController:SetSelectedState("ManualOperating")
		arg_60_0.manualViewController:SetSelectedState("manual")
		arg_60_0.switchBtnController:SetSelectedState("manual")
		SetActive(arg_60_0.emptydreamcanteenitemGo_1, false)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
		arg_60_0.stateController:SetSelectedState("closed")
		arg_60_0.tipsAnimation:Play()

		if not CanteenTools:CheckSignFoodNumCanOpen() then
			arg_60_0.closeText_.text = GetTips("CANTEEN_FOOD_NOT_SUFFICIENT")
		elseif not CanteenTools:CheckCanteenJobCanOpen() then
			arg_60_0.closeText_.text = GetTips("CANTEEN_JOB_NOT_FIT")
		end
	end
end

function var_0_0.UpdataAwardBubble(arg_61_0)
	local var_61_0, var_61_1, var_61_2 = CanteenData:GetAutoNextAwardTime()
	local var_61_3 = CanteenData:GetAutoAwardNum() or 0
	local var_61_4 = DormSkillData:GetInComeStorageMax()

	if var_61_0 < 0 or var_61_1 < 0 then
		arg_61_0.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS2")

		if var_61_3 == 0 then
			arg_61_0.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS3")
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

		arg_61_0.awardtimetextText_.text = string.format(GetTips("CANTEEN_MONEY_TIPS1"), var_61_5)
	end

	arg_61_0.awardtotaltextText_.text = string.format("%d<size=26><color=#767878>/%d</color></size>", var_61_3, var_61_4)
end

function var_0_0.UpdataAwardBubbleTrs(arg_62_0)
	local var_62_0 = CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.CashierTable)
	local var_62_1 = CanteenAIFunction:GetAllEIDNameSpace(var_62_0)[1]
	local var_62_2 = manager.ui.mainCameraCom_
	local var_62_3 = Dorm.DormEntityManager.QueryPosition(var_62_1)
	local var_62_4 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_62_2, var_62_3)
	local var_62_5 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_62_6 = {}
	local var_62_7, var_62_8 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_62_0.transform_, var_62_4, var_62_5, var_62_6)

	if var_62_8 == nil then
		print("未找到对应的视口坐标")

		return
	end

	var_62_8.y = var_62_8.y + arg_62_0.offset
	arg_62_0.emptydreamcanteenitemTrs_.localPosition = var_62_8
end

function var_0_0.UpdataTimeBar(arg_63_0)
	local var_63_0 = Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, "timer")
	local var_63_1 = 1

	if var_63_0 and var_63_0:IsRunning() then
		var_63_1 = var_63_0:QueryTime() / var_63_0.duration
	end

	arg_63_0.timebarImg_.fillAmount = 1 - var_63_1
end

function var_0_0.OnExit(arg_64_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_64_0.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:unbindUIandKey(arg_64_0.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:unbindUIandKey(arg_64_0.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	manager.redPoint:unbindUIandKey(arg_64_0.recipebtnBtn_.transform, RedPointConst.CANTEEN_UNLOCK_FOOD)
	manager.redPoint:unbindUIandKey(arg_64_0.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	manager.redPoint:unbindUIandKey(arg_64_0.emptydreamcanteenitemTrs_, RedPointConst.CANTEEN_MAX)
	arg_64_0:RemoveAllEventListener()
	arg_64_0:EndAutoScroll()
	arg_64_0:StopAwardBubble()
	arg_64_0.quickView:OnExit()

	if arg_64_0.refreshTimer then
		arg_64_0.refreshTimer:Stop()

		arg_64_0.refreshTimer = nil
	end

	arg_64_0.cacheEntrustNum_ = 0
end

function var_0_0.UnUsualExitManualMode(arg_65_0)
	CharacterBubbleManager:Dispose()

	local var_65_0 = CanteenData:GetCanteenState()

	CanteenAction:ChangeCanteenMode(var_65_0, DormEnum.RestaurantMode.RestaurantAuto, true)
end

function var_0_0.Dispose(arg_66_0)
	if arg_66_0.refreshTimer then
		arg_66_0.refreshTimer:Stop()

		arg_66_0.refreshTimer = nil
	end

	arg_66_0.cacheEntrustNum_ = 0

	if arg_66_0.signFoodListScroll_ then
		arg_66_0.signFoodListScroll_:Dispose()

		arg_66_0.signFoodListScroll_ = nil
	end

	if arg_66_0.atuoAwardTrsTimer then
		arg_66_0.atuoAwardTrsTimer:Stop()

		arg_66_0.atuoAwardTrsTimer = nil
	end

	if arg_66_0.canJumpTimer then
		arg_66_0.canJumpTimer:Stop()

		arg_66_0.canJumpTimer = nil
	end

	arg_66_0.moneyAnimator = nil

	arg_66_0.quickView:Dispose()
	var_0_0.super.Dispose(arg_66_0)
end

return var_0_0
