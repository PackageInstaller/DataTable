local var_0_0 = class("ActivitySkinDrawMainViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_4_0.skinPoolItem_ = {}
	arg_4_0.scenePoolItem_ = {}
	arg_4_0.typeCon_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
	arg_4_0.drawCon_ = ControllerUtil.GetController(arg_4_0.transform_, "draw")
	arg_4_0.skinCon_ = ControllerUtil.GetController(arg_4_0.transform_, "skin")
	arg_4_0.frameCon_ = ControllerUtil.GetController(arg_4_0.transform_, "frame")
	arg_4_0.sceneCon_ = ControllerUtil.GetController(arg_4_0.transform_, "scene")
	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.storyBtn_, nil, function()
		local var_6_0 = ActivitySkinDrawToolsOld.GetStoryID(arg_5_0.activityID_)

		manager.story:StartStoryById(var_6_0, function()
			return
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activitySkinDrawTaskOld", {
			activityID = arg_5_0.activityID_,
			taskActivityID = arg_5_0.taskActiivtyID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		local var_9_0 = ActivitySkinDrawToolsOld.GetActivityShopID(arg_5_0.activityID_)

		if not ShopTools.IsShopOpen(var_9_0) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.GoToSystem("/activityShop", {
			shopId = var_9_0,
			showShops = {
				var_9_0
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.pvBtn_, nil, function()
		local var_10_0 = SkinCfg[arg_5_0.skinID_].video_url[1]

		if not var_10_0 or var_10_0 == "" then
			return
		end

		Application.OpenURL(var_10_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.sceneTrailBtn_, nil, function()
		JumpTools.OpenPageByJump("/customCenter", {
			selectType = CustomCenterView.SELECT_SCENE,
			sceneID = arg_5_0.sceneID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoSkinBtn_, nil, function()
		JumpTools.OpenPageByJump("skinDrawInfoOld", {
			poolID = arg_5_0.skinPoolID_,
			mainActivity = arg_5_0.activityID_,
			poolActivityID = arg_5_0.skinDrawActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoSceneBtn_, nil, function()
		JumpTools.OpenPageByJump("skinDrawInfoOld", {
			poolID = arg_5_0.scenePoolID_,
			mainActivity = arg_5_0.activityID_,
			poolActivityID = arg_5_0.sceneDrawActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinSelectBtn_, nil, function()
		arg_5_0.curPoolID_ = arg_5_0.skinPoolID_

		arg_5_0:RefreshCurPool()
	end)
	arg_5_0:AddBtnListener(arg_5_0.sceneSelectBtn_, nil, function()
		arg_5_0.curPoolID_ = arg_5_0.scenePoolID_

		arg_5_0:RefreshCurPool()
	end)
	arg_5_0:AddBtnListener(arg_5_0.oneBtn_, nil, function()
		arg_5_0:DrawCheck(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tenBtn_, nil, function()
		arg_5_0:DrawCheck(10)
	end)
	arg_5_0:AddBtnListener(arg_5_0.frameBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			arg_5_0.frameID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinBtn, nil, function()
		ShowPopItem(POP_ITEM, {
			arg_5_0.skinID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.sceneBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			arg_5_0.sceneID_
		})
	end)
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0:InitData()
	arg_21_0:RefreshUI()
	arg_21_0:BindRedPoint()
	arg_21_0:CheckHadDrawed()
	arg_21_0:CheckSceneDrawed()
end

function var_0_0.InitData(arg_22_0)
	arg_22_0.activityID_ = arg_22_0.params_.activityID
	arg_22_0.activityData_ = ActivityData:GetActivityData(arg_22_0.activityID_)
	arg_22_0.startTime_ = arg_22_0.activityData_.startTime
	arg_22_0.stopTime_ = arg_22_0.activityData_.stopTime
	arg_22_0.taskActiivtyID_ = ActivitySkinDrawToolsOld.GetTaskActivityID(arg_22_0.activityID_)
	arg_22_0.skinDrawActivityID_ = ActivitySkinDrawToolsOld.GetSkinPoolActivityID(arg_22_0.activityID_)
	arg_22_0.sceneDrawActivityID_ = ActivitySkinDrawToolsOld.GetScenePoolActivityID(arg_22_0.activityID_)
	arg_22_0.skinPoolID_ = ActivitySkinDrawToolsOld.GetPoolID(arg_22_0.skinDrawActivityID_)
	arg_22_0.scenePoolID_ = ActivitySkinDrawToolsOld.GetPoolID(arg_22_0.sceneDrawActivityID_)
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0:RefreshMovie()
	arg_23_0:RefreshTime()
	arg_23_0:RefreshPool()
	arg_23_0:RefreshBar()

	if SDKTools.GetIsOverSea() then
		SetActive(arg_23_0.pvBtn_.gameObject, false)
	else
		SetActive(arg_23_0.pvBtn_.gameObject, true)
	end
end

function var_0_0.RefreshMovie(arg_24_0)
	arg_24_0.criMovie_:Stop()

	local var_24_0 = ObtainSkinBackgroundMovieCfg[arg_24_0.activityID_]
	local var_24_1 = deepClone(var_24_0.start_path)
	local var_24_2
	local var_24_3 = ActivitySkinDrawDataOld:GetLastFile(arg_24_0.activityID_)

	if var_24_3 then
		local var_24_4 = math.random(#var_24_1 - 1)

		if var_24_4 >= table.indexof(var_24_1, var_24_3) then
			var_24_4 = var_24_4 + 1
		end

		var_24_2 = var_24_1[var_24_4] or var_24_1[1]
	else
		var_24_2 = var_24_1[math.random(#var_24_1)] or var_24_1[1]
	end

	arg_24_0:StopFrameTimer()

	arg_24_0.frameTimer_ = FrameTimer.New(function()
		if tostring(arg_24_0.criplayer_.status) == "Stop" then
			arg_24_0.criplayer_:SetFile(nil, var_24_2, CriMana.Player.SetMode.New)
			ActivitySkinDrawDataOld:SetLastFile(arg_24_0.activityID_, var_24_2)
			arg_24_0.criMovie_:Play()
			arg_24_0:StopFrameTimer()
		end
	end, 1, -1)

	arg_24_0.frameTimer_:Start()
end

function var_0_0.StopFrameTimer(arg_26_0)
	if arg_26_0.frameTimer_ then
		arg_26_0.frameTimer_:Stop()

		arg_26_0.frameTimer_ = nil
	end
end

function var_0_0.RefreshTime(arg_27_0)
	local var_27_0
	local var_27_1 = manager.time:GetServerTime()

	arg_27_0:StopTimer()

	if var_27_1 < arg_27_0.stopTime_ then
		arg_27_0.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(arg_27_0.stopTime_))
		arg_27_0.timer_ = Timer.New(function()
			arg_27_0.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(arg_27_0.stopTime_))
			var_27_0 = arg_27_0.stopTime_ - manager.time:GetServerTime()

			if var_27_0 <= 0 then
				arg_27_0:StopTimer()
				arg_27_0:RefreshTime()
			end
		end, 1, -1)

		arg_27_0.timer_:Start()
	else
		arg_27_0.timeText_.text = GetI18NText(GetTips("TIME_OVER"))
	end
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()

		arg_29_0.timer_ = nil
	end
end

function var_0_0.RefreshPool(arg_30_0)
	arg_30_0:RefreshSkinPool()
	arg_30_0:RefreshScenePool()
	arg_30_0:GetCurPoolID()
	arg_30_0:RefreshCurPool()
end

function var_0_0.RefreshSkinPool(arg_31_0)
	arg_31_0.skinLastCnt_ = 0
	arg_31_0.skinTotalCnt_ = 0

	local var_31_0 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_31_0.skinPoolID_] or {}

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		local var_31_1 = ActivityLimitedDrawPoolCfg[iter_31_1]

		arg_31_0.skinTotalCnt_ = arg_31_0.skinTotalCnt_ + var_31_1.total

		local var_31_2 = ActivitySkinDrawDataOld:GetDrawInfo(arg_31_0.skinDrawActivityID_, iter_31_1)

		arg_31_0.skinLastCnt_ = var_31_2 and arg_31_0.skinLastCnt_ + var_31_2.num or arg_31_0.skinLastCnt_ + var_31_1.total
	end

	local var_31_3 = ActivityLimitedDrawPoolListCfg[arg_31_0.skinPoolID_].main_icon_info
	local var_31_4 = var_31_3[1][1]
	local var_31_5 = ActivityLimitedDrawPoolCfg[var_31_4]
	local var_31_6 = ActivitySkinDrawDataOld:GetDrawInfo(arg_31_0.skinDrawActivityID_, var_31_4)

	arg_31_0.frameCnt_ = var_31_6 and var_31_6.num or var_31_5.total

	arg_31_0.frameCon_:SetSelectedState(arg_31_0.frameCnt_ > 0 and "on" or "off")

	local var_31_7 = var_31_3[1][2]

	arg_31_0.frameSelectIcon_.sprite = ItemTools.getItemSprite(var_31_7)
	arg_31_0.frameUnselectIcon_.sprite = ItemTools.getItemSprite(var_31_7)

	local var_31_8 = var_31_3[2][1]
	local var_31_9 = ActivityLimitedDrawPoolCfg[var_31_8]
	local var_31_10 = ActivitySkinDrawDataOld:GetDrawInfo(arg_31_0.skinDrawActivityID_, var_31_8)

	arg_31_0.skinCnt_ = var_31_10 and var_31_10.num or var_31_9.total

	arg_31_0.skinCon_:SetSelectedState(arg_31_0.skinCnt_ > 0 and "on" or "off")

	local var_31_11 = var_31_3[2][2]

	arg_31_0.skinSelectIcon_.sprite = ItemTools.getItemSprite(var_31_11)
	arg_31_0.skinUnselectIcon_.sprite = ItemTools.getItemSprite(var_31_11)
	arg_31_0.frameID_ = var_31_5.reward[1][1]
	arg_31_0.skinID_ = var_31_9.reward[1][1]

	local var_31_12 = ActivityLimitedDrawPoolListCfg[arg_31_0.skinPoolID_].icon_info

	for iter_31_2, iter_31_3 in ipairs(var_31_12) do
		if not arg_31_0.skinPoolItem_[iter_31_2] then
			local var_31_13 = Object.Instantiate(arg_31_0.templateItem_, arg_31_0.skinRewardContent_)

			arg_31_0.skinPoolItem_[iter_31_2] = ActivitySkinDrawItemOld.New(var_31_13)
		end

		arg_31_0.skinPoolItem_[iter_31_2]:SetData(arg_31_0.skinDrawActivityID_, iter_31_3)
		arg_31_0.skinPoolItem_[iter_31_2]:SetValue(true)
	end

	for iter_31_4 = #var_31_12 + 1, #arg_31_0.skinPoolItem_ do
		arg_31_0.skinPoolItem_[iter_31_4]:SetValue(false)
	end
end

function var_0_0.RefreshScenePool(arg_32_0)
	arg_32_0.sceneLastCnt_ = 0
	arg_32_0.sceneTotalCnt_ = 0

	local var_32_0 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_32_0.scenePoolID_] or {}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1 = ActivityLimitedDrawPoolCfg[iter_32_1]

		arg_32_0.sceneTotalCnt_ = arg_32_0.sceneTotalCnt_ + var_32_1.total

		local var_32_2 = ActivitySkinDrawDataOld:GetDrawInfo(arg_32_0.sceneDrawActivityID_, iter_32_1)

		arg_32_0.sceneLastCnt_ = var_32_2 and arg_32_0.sceneLastCnt_ + var_32_2.num or arg_32_0.sceneLastCnt_ + var_32_1.total
	end

	local var_32_3 = ActivityLimitedDrawPoolListCfg[arg_32_0.scenePoolID_].main_icon_info[1][1]
	local var_32_4 = ActivityLimitedDrawPoolCfg[var_32_3]
	local var_32_5 = ActivitySkinDrawDataOld:GetDrawInfo(arg_32_0.sceneDrawActivityID_, var_32_3)

	arg_32_0.sceneCnt_ = var_32_5 and var_32_5.num or var_32_4.total

	arg_32_0.sceneCon_:SetSelectedState(arg_32_0.sceneCnt_ > 0 and "on" or "off")

	arg_32_0.sceneID_ = var_32_4.reward[1][1]

	local var_32_6 = ActivityLimitedDrawPoolListCfg[arg_32_0.scenePoolID_].icon_info

	for iter_32_2, iter_32_3 in ipairs(var_32_6) do
		if not arg_32_0.scenePoolItem_[iter_32_2] then
			local var_32_7 = Object.Instantiate(arg_32_0.templateItem_, arg_32_0.sceneRewardContent_)

			arg_32_0.scenePoolItem_[iter_32_2] = ActivitySkinDrawItemOld.New(var_32_7)
		end

		arg_32_0.scenePoolItem_[iter_32_2]:SetData(arg_32_0.sceneDrawActivityID_, iter_32_3)
		arg_32_0.scenePoolItem_[iter_32_2]:SetValue(true)
	end

	for iter_32_4 = #var_32_6 + 1, #arg_32_0.scenePoolItem_ do
		arg_32_0.scenePoolItem_[iter_32_4]:SetValue(false)
	end
end

function var_0_0.GetCurPoolID(arg_33_0)
	arg_33_0.curPoolID_ = ActivitySkinDrawDataOld:GetCurDrawPool(arg_33_0.activityID_)

	if not arg_33_0.curPoolID_ then
		arg_33_0.curPoolID_ = arg_33_0.skinPoolID_
	end
end

function var_0_0.RefreshCurPool(arg_34_0)
	local var_34_0 = 0

	if arg_34_0.curPoolID_ == arg_34_0.skinPoolID_ then
		arg_34_0.typeCon_:SetSelectedState("skin")

		var_34_0 = arg_34_0.skinLastCnt_
	else
		arg_34_0.typeCon_:SetSelectedState("scene")

		var_34_0 = arg_34_0.sceneLastCnt_
	end

	ActivitySkinDrawDataOld:SetCurDrawPool(arg_34_0.activityID_, arg_34_0.curPoolID_)

	if var_34_0 >= 10 then
		arg_34_0.drawCon_:SetSelectedState("ten")
	elseif var_34_0 > 0 then
		arg_34_0.drawCon_:SetSelectedState("one")
	else
		arg_34_0.drawCon_:SetSelectedState("none")
	end

	local var_34_1 = ActivityLimitedDrawPoolListCfg[arg_34_0.curPoolID_].cost_once[1]

	arg_34_0.drawIcon_1.sprite = ItemTools.getItemSprite(var_34_1)
	arg_34_0.drawIcon_2.sprite = ItemTools.getItemSprite(var_34_1)

	arg_34_0.btnAni_:Play("btn_show", -1, 0)
end

function var_0_0.CheckHadDrawed(arg_35_0)
	if not arg_35_0.params_.checkReward then
		return
	end

	if (getData("activity_check_had", "activity_" .. tostring(arg_35_0.activityID_)) or 0) == 0 then
		local var_35_0 = PlayerData:GetFrame(arg_35_0.frameID_)
		local var_35_1 = var_35_0 and var_35_0.unlock == 1 and var_35_0.lasted_time == 0 and arg_35_0.frameCnt_ > 0
		local var_35_2 = HeroTools.IsSkinUnlock(arg_35_0.skinID_) and arg_35_0.skinCnt_ > 0
		local var_35_3 = HomeSceneSettingData:IsUnlockScene(arg_35_0.sceneID_) and arg_35_0.sceneCnt_ > 0

		if var_35_1 or var_35_2 or var_35_3 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("GENGCHEN_SWIMWEAR_DES_1"),
				OkCallback = function()
					saveData("activity_check_had", "activity_" .. tostring(arg_35_0.activityID_), 1)
				end
			})
		end
	end
end

function var_0_0.CheckSceneDrawed(arg_37_0)
	if arg_37_0.params_.isSceneDrawed then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("GENGCHEN_SWIMWEAR_CHANGE_SCENE"), ItemTools.getItemName(arg_37_0.sceneID_)),
			OkCallback = function()
				JumpTools.OpenPageByJump("/customCenter", {
					selectType = CustomCenterView.SELECT_SCENE,
					sceneID = arg_37_0.sceneID_
				})
			end
		})
	end

	arg_37_0.params_.isSceneDrawed = false
end

function var_0_0.DrawCheck(arg_39_0, arg_39_1)
	if not arg_39_0.activityData_:IsActivitying() then
		ShowTips("TIME_OVER")

		return
	end

	if not _G.SkipTip.SkipActivitySkinDrawTip then
		local var_39_0
		local var_39_1 = true

		if arg_39_0.curPoolID_ == arg_39_0.skinPoolID_ then
			var_39_0 = arg_39_0.skinID_
			var_39_1 = HeroTools.IsSkinUnlock(arg_39_0.skinID_)

			if not var_39_1 then
				local var_39_2 = PlayerData:GetFrame(arg_39_0.frameID_)

				if var_39_2 and var_39_2.unlock == 1 and var_39_2.lasted_time == 0 then
					var_39_1 = true
					var_39_0 = arg_39_0.frameID_
				end
			end
		else
			var_39_0 = arg_39_0.sceneID_
			var_39_1 = HomeSceneSettingData:IsUnlockScene(arg_39_0.sceneID_)
		end

		if var_39_1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE"), ItemTools.getItemName(var_39_0)),
				OkCallback = function()
					_G.SkipTip.SkipActivitySkinDrawTip = arg_39_0.SkipActivitySkinDrawTip_

					arg_39_0:AfterCheck(arg_39_1)
				end,
				ToggleCallback = function(arg_41_0)
					arg_39_0.SkipActivitySkinDrawTip_ = arg_41_0
				end
			})
		else
			arg_39_0:AfterCheck(arg_39_1)
		end
	else
		arg_39_0:AfterCheck(arg_39_1)
	end
end

function var_0_0.AfterCheck(arg_42_0, arg_42_1)
	local var_42_0 = ActivityLimitedDrawPoolListCfg[arg_42_0.curPoolID_]
	local var_42_1 = var_42_0.cost_once[1]

	if arg_42_1 <= ItemTools.getItemNum(var_42_1) then
		arg_42_0:StartDraw(arg_42_1)
	else
		local var_42_2 = {}

		table.insert(var_42_2, var_42_0.payment_free[1])

		local var_42_3 = getShopCfg(var_42_0.payment_free[1])
		local var_42_4 = var_42_3.shop_id
		local var_42_5 = ShopData.GetShop(var_42_4)[var_42_0.payment_free[1]]
		local var_42_6 = var_42_3.limit_num - (var_42_5.buy_times or 0)
		local var_42_7 = var_42_0.payment

		for iter_42_0, iter_42_1 in ipairs(var_42_7) do
			local var_42_8 = getShopCfg(iter_42_1)
			local var_42_9 = var_42_8.shop_id
			local var_42_10 = ShopData.GetShop(var_42_9)[iter_42_1]

			if var_42_10 then
				local var_42_11 = var_42_8.limit_num - (var_42_10.buy_times or 0)

				if arg_42_1 <= var_42_11 and arg_42_1 <= var_42_6 then
					table.insert(var_42_2, iter_42_1)
					arg_42_0:GoPopView(arg_42_1, var_42_2)

					break
				elseif var_42_11 > 0 then
					arg_42_0:GoToShop(iter_42_1, var_42_9)

					break
				end
			end
		end
	end
end

function var_0_0.StartDraw(arg_43_0, arg_43_1)
	if arg_43_0.curPoolID_ == arg_43_0.skinPoolID_ then
		ActivitySkinDrawActionOld.StartDraw(arg_43_0.skinDrawActivityID_, arg_43_0.skinPoolID_, arg_43_1)
	elseif arg_43_0.curPoolID_ == arg_43_0.scenePoolID_ then
		ActivitySkinDrawActionOld.StartDraw(arg_43_0.sceneDrawActivityID_, arg_43_0.scenePoolID_, arg_43_1)
	end
end

function var_0_0.GoPopView(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.curPoolID_ == arg_44_0.skinPoolID_ and arg_44_0.skinDrawActivityID_ or arg_44_0.sceneDrawActivityID_

	JumpTools.OpenPageByJump("activitySkinDrawPopOld", {
		mainActivity = arg_44_0.activityID_,
		poolActivityID = var_44_0,
		poolID = arg_44_0.curPoolID_,
		cnt = arg_44_1,
		goods = arg_44_2
	})
end

function var_0_0.GoToShop(arg_45_0, arg_45_1, arg_45_2)
	JumpTools.GoToSystem("/activityShop", {
		goodId = arg_45_1,
		shopId = arg_45_2,
		showShops = {
			arg_45_2
		}
	}, ViewConst.SYSTEM_ID.SHOP)
end

function var_0_0.BindRedPoint(arg_46_0)
	manager.redPoint:bindUIandKey(arg_46_0.sceneTrailBtn_.transform, RedPointConst.SCENE .. "_" .. arg_46_0.sceneID_)
	manager.redPoint:bindUIandKey(arg_46_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. arg_46_0.taskActiivtyID_)
end

function var_0_0.UnbindRedPoint(arg_47_0)
	manager.redPoint:unbindUIandKey(arg_47_0.sceneTrailBtn_.transform, RedPointConst.SCENE .. "_" .. arg_47_0.sceneID_)
	manager.redPoint:unbindUIandKey(arg_47_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. arg_47_0.taskActiivtyID_)
end

function var_0_0.RefreshBar(arg_48_0)
	local var_48_0 = {
		BACK_BAR,
		HOME_BAR
	}
	local var_48_1 = ActivityLimitedDrawPoolListCfg[arg_48_0.skinPoolID_].cost_once[1]

	table.insert(var_48_0, var_48_1)

	local var_48_2 = ActivityLimitedDrawPoolListCfg[arg_48_0.scenePoolID_].cost_once[1]

	table.insert(var_48_0, var_48_2)
	table.insertto(var_48_0, {
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SwitchBar(var_48_0)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(var_48_1, true)
	manager.windowBar:SetBarCanAdd(var_48_2, true)
end

function var_0_0.OnTop(arg_49_0)
	if arg_49_0.skinPoolID_ and arg_49_0.scenePoolID_ then
		arg_49_0:RefreshBar()
	end
end

function var_0_0.OnExit(arg_50_0)
	arg_50_0:StopTimer()
	arg_50_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	arg_50_0:RemoveAllEventListener()

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.skinPoolItem_) do
		iter_50_1:OnExit()
	end

	for iter_50_2, iter_50_3 in ipairs(arg_50_0.scenePoolItem_) do
		iter_50_3:OnExit()
	end
end

function var_0_0.Dispose(arg_51_0)
	arg_51_0:RemoveAllListeners()

	for iter_51_0, iter_51_1 in ipairs(arg_51_0.skinPoolItem_) do
		iter_51_1:Dispose()
	end

	arg_51_0.skinPoolItem_ = {}

	for iter_51_2, iter_51_3 in ipairs(arg_51_0.scenePoolItem_) do
		iter_51_3:Dispose()
	end

	arg_51_0.scenePoolItem_ = {}

	arg_51_0.super.Dispose(arg_51_0)
end

return var_0_0
