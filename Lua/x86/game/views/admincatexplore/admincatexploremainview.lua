local var_0_0 = class("AdminCatExploreMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExploreHome"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemViewList = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cultureBtn_, nil, function()
		JumpTools.GoToSystem("/adminCatExploreCatCultivate", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.GoToSystem("adminCatExploreReward", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.dispathBtn_, nil, function()
		local var_8_0 = {}
		local var_8_1 = {}
		local var_8_2 = {}

		AdminCatExploreData:CalculateMaxExploreHour()

		arg_5_0.maxExploreHour = AdminCatExploreData:GetDataByPara("maxExploreHour")
		arg_5_0.regionData = AdminCatExploreData:GetDataByPara("regionData")
		arg_5_0.regionUnlockLevel = AdminCatExploreData:GetDataByPara("regionUnlockLevel")

		for iter_8_0, iter_8_1 in ipairs(ExploreAreaCfg.all) do
			if arg_5_0.regionData[iter_8_1] == nil and (arg_5_0.regionUnlockLevel[iter_8_1] == nil or arg_5_0.level >= arg_5_0.regionUnlockLevel[iter_8_1]) then
				table.insert(var_8_2, iter_8_1)
			end
		end

		for iter_8_2, iter_8_3 in pairs(var_8_2) do
			local var_8_3 = AdminCatExploreData:SortAdminCatList(iter_8_3)

			if var_8_3[1].canUse and var_8_3[1].recommend then
				var_8_0[iter_8_3] = var_8_3[1].id
				var_8_1[var_8_3[1].id] = iter_8_3
			end
		end

		local var_8_4 = {}

		for iter_8_4, iter_8_5 in ipairs(var_8_2) do
			if var_8_0[iter_8_5] then
				table.insert(var_8_4, {
					area = var_8_0[iter_8_5],
					id = iter_8_5,
					hour = arg_5_0.maxExploreHour
				})
			else
				for iter_8_6, iter_8_7 in ipairs(AdminCatExploreData:SortAdminCatList(iter_8_5)) do
					if var_8_1[iter_8_7.id] == nil and iter_8_7.canUse then
						table.insert(var_8_4, {
							area = iter_8_5,
							id = iter_8_7.id,
							hour = arg_5_0.maxExploreHour
						})

						var_8_1[iter_8_7.id] = iter_8_5
					end
				end
			end
		end

		if #var_8_4 == 0 then
			return
		end

		SetActive(arg_5_0.dispathBtn_.gameObject, false)
		OperationRecorder.RecordButtonTouch("explore_meow_start_onekey")
		AdminCatExploreAction.AdminCatExploreAllExplore(var_8_4, 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		local var_9_0 = {}

		arg_5_0.regionData = AdminCatExploreData:GetDataByPara("regionData")

		for iter_9_0, iter_9_1 in pairs(arg_5_0.regionData) do
			if iter_9_1.stopTime <= manager.time:GetServerTime() then
				table.insert(var_9_0, iter_9_0)
			end
		end

		if #var_9_0 == 0 then
			return
		end

		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			return arg_10_0 < arg_10_1
		end)
		AdminCatExploreAction.AdminCatExploreAllFinish(var_9_0, 1)
		OperationRecorder.RecordButtonTouch("explore_meow_finish_onekey")
	end)
	arg_5_0:AddBtnListener(arg_5_0.storeBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.ADMIN_CAT_SHOP,
			showShops = {
				ShopConst.SHOP_ID.ADMIN_CAT_SHOP
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function var_0_0.UpdateBar(arg_12_0)
	return
end

function var_0_0.UpdateView(arg_13_0)
	if arg_13_0.updateTimer_ then
		arg_13_0.updateTimer_:Stop()

		arg_13_0.updateTimer_ = nil
	end

	SetActive(arg_13_0.getBtn_.gameObject, false)

	for iter_13_0 = 1, 5 do
		if arg_13_0.itemViewList[iter_13_0] == nil then
			arg_13_0.itemViewList[iter_13_0] = AdminCatExploreRegionItem:New(arg_13_0["regionItem" .. iter_13_0 .. "_"])
		end

		arg_13_0.itemViewList[iter_13_0]:SetData(arg_13_0.getBtn_.gameObject, iter_13_0)
		arg_13_0.itemViewList[iter_13_0]:OnEnter()
	end

	arg_13_0.level = AdminCatExploreData:GetDataByPara("level")
	arg_13_0.exploreLevelImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. arg_13_0.level)

	local var_13_0 = ExploreLevelCfg[arg_13_0.level]
	local var_13_1 = AdminCatExploreData:GetDataByPara("exp")
	local var_13_2 = AdminCatExploreData:GetDataByPara("maxLevel")
	local var_13_3 = AdminCatExploreData:GetDataByPara("exploringCount")

	arg_13_0.queueTxt_.text = var_13_3 .. "/" .. var_13_0.amount
	arg_13_0.expImage_.fillAmount = var_13_2 == arg_13_0.level and 1 or var_13_1 / var_13_0.exp
	arg_13_0.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	arg_13_0.exportFill_.fillAmount = arg_13_0.exploreDay / 7

	local var_13_4 = AdminCatExploreData:GetDataByPara("rate")

	arg_13_0.rateTxt_.text = "x" .. var_13_4[arg_13_0.exploreDay]
	arg_13_0.expTxt_.text = var_13_2 == arg_13_0.level and "0/0" or var_13_1 .. "/" .. var_13_0.exp
	arg_13_0.unlockAdminCat = AdminCatExploreData:GetDataByPara("unlockAdminCat")

	local var_13_5 = 0

	for iter_13_1, iter_13_2 in pairs(arg_13_0.unlockAdminCat) do
		var_13_5 = var_13_5 + 1
	end

	SetActive(arg_13_0.dispathBtn_.gameObject, var_13_3 ~= var_13_5)

	arg_13_0.updateTimer_ = Timer.New(function()
		AdminCatExploreData:UpdateRegionRedPoint()
	end, 1, -1, 1)

	arg_13_0.updateTimer_:Start()
end

function var_0_0.OnGetWeeklyReward(arg_15_0)
	arg_15_0:UpdateView()
end

function var_0_0.OnEnter(arg_16_0)
	if AdminCatExploreData:GetDataByPara("isFirstOpen") == 0 and GuideData:IsFinish(513) then
		JumpTools.OpenPageByJump("adminCatExploreFirstPop", {})
		AdminCatExploreAction.WeeklyFirstOpen()
	end

	manager.ui.cameraExtension.uiFov = 2

	arg_16_0:UpdateView()
	arg_16_0:BindRedPoint()
	AdminCatExploreData:UpdateQueueRedPoint()
end

function var_0_0.BindRedPoint(arg_17_0)
	manager.redPoint:bindUIandKey(arg_17_0.rewardBtn_.transform, RedPointConst.EXPLORE_REWARD, {
		x = 70,
		y = 70
	})
	manager.redPoint:bindUIandKey(arg_17_0.cultureBtn_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT, {
		x = 155,
		y = 60
	})
end

function var_0_0.UnbindRedPoint(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.rewardBtn_.transform, RedPointConst.EXPLORE_REWARD)
	manager.redPoint:unbindUIandKey(arg_18_0.cultureBtn_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT)
end

function var_0_0.OnExploreUpdate(arg_19_0)
	arg_19_0:UpdateView()
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:UnbindRedPoint()

	manager.ui.cameraExtension.uiFov = 30

	if arg_20_0.itemViewList then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.itemViewList) do
			iter_20_1:OnExit()
		end
	end

	if arg_20_0.updateTimer_ then
		arg_20_0.updateTimer_:Stop()

		arg_20_0.updateTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function var_0_0.Hide(arg_21_0)
	SetActive(arg_21_0.gameObject_, false)
end

function var_0_0.Show(arg_22_0)
	SetActive(arg_22_0.gameObject_, true)
end

function var_0_0.OnTop(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR,
		54,
		55,
		56
	})
	manager.windowBar:SetBarCanClick(54, true)
	manager.windowBar:SetBarCanClick(55, true)
	manager.windowBar:SetBarCanClick(56, true)
	manager.windowBar:SetGameHelpKey("EXPLORE_EXPLAIN")
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.itemViewList then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.itemViewList) do
			iter_24_1:Dispose()
		end

		arg_24_0.itemViewList = nil
	end

	var_0_0.super.Dispose(arg_24_0)
	Object.Destroy(arg_24_0.gameObject_)
end

return var_0_0
