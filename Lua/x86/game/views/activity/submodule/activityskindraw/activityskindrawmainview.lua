local var_0_0 = class("ActivitySkinDrawMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawTools.GetMainUIName(arg_1_0.params_.activityID)
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
	arg_4_0.drawCon_ = arg_4_0.controllerEx_:GetController("draw")
	arg_4_0.rewardCon_ = arg_4_0.controllerEx_:GetController("reward")
	arg_4_0.scenePreviewCon_ = arg_4_0.controllerEx_:GetController("scenePreview")
	arg_4_0.giftController_ = arg_4_0.controllerEx_:GetController("gift")
	arg_4_0.poolList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.poolListGo_, ActivitySkinDrawPoolItem)
	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
	arg_4_0.sceneReward_ = ActivitySkinDrawItem.New(arg_4_0.sceneReward_1)
	arg_4_0.dlcRewardList_ = {}

	for iter_4_0 = 1, 2 do
		if arg_4_0["dlcReward_" .. iter_4_0] then
			arg_4_0.dlcRewardList_[iter_4_0] = ActivitySkinDrawItem.New(arg_4_0["dlcReward_" .. iter_4_0])
		end
	end

	arg_4_0.skinRewardList_ = {}

	for iter_4_1 = 1, 2 do
		arg_4_0.skinRewardList_[iter_4_1] = ActivitySkinDrawItem.New(arg_4_0["skinReward_" .. iter_4_1])
	end

	if arg_4_0.giftRewardGo_ then
		arg_4_0.giftReward_ = ActivitySkinDrawGiftItem.New(arg_4_0.giftRewardGo_)
	end

	arg_4_0.storyList_ = {}

	for iter_4_2 = 1, 4 do
		arg_4_0.storyList_[iter_4_2] = {}

		ComponentBinder.GetInstance():BindCfgUI(arg_4_0.storyList_[iter_4_2], arg_4_0["storyGo_" .. iter_4_2])

		arg_4_0.storyList_[iter_4_2].lockController = arg_4_0.storyList_[iter_4_2].tranCon_:GetController("Story")
	end

	arg_4_0.storyIdList_ = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.storyList_) do
		arg_5_0:AddBtnListener(iter_5_1.btn_, nil, function()
			if iter_5_0 <= arg_5_0.openStoryIndex_ then
				gameContext:Go("/blank")

				local var_6_0 = ActivitySkinDrawData:GetStoryActivityId()

				manager.story:StartStoryById(arg_5_0.storyIdList_[iter_5_0], function()
					ActivitySkinDrawData:FinishedStory(arg_5_0.storyIdList_[iter_5_0])
					manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_DRAW, 0, RedPointStyle.SHOW_NEW_TAG)
					gameContext:Back()
				end)
			else
				ShowTips(GetTips("SKIN_DRAE_STORY_LOCK_TIPS"))
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activitySkinDrawTask", {
			activityID = arg_5_0.activityID_,
			taskActivityID = arg_5_0.taskActiivtyID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		local var_9_0 = ActivitySkinDrawTools.GetActivityShopID(arg_5_0.activityID_)

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
	arg_5_0:AddBtnListener(arg_5_0.btnAnim_1, nil, function()
		arg_5_0:JumpToVideo(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnAnim_2, nil, function()
		arg_5_0:JumpToVideo(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		local var_12_0 = arg_5_0.sceneIDList_[arg_5_0.curPoolID_]
		local var_12_1 = HomeSceneSettingData:SetPreviewScene(var_12_0, 1084)

		HomeSceneSettingData:SetPreviewSceneParams(var_12_1)

		arg_5_0.isPreview_ = true

		OpenPageUntilLoaded("/homePreview", var_12_1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnInfo_, nil, function()
		local var_13_0 = not arg_5_0.isSkinPool_ and #arg_5_0.poolStageCount_[arg_5_0.curPoolID_] > 1 and arg_5_0:GetPoolNowStage(arg_5_0.curPoolID_) == 1

		JumpTools.OpenPageByJump("skinDrawInfo", {
			poolID = arg_5_0.curPoolID_,
			mainActivity = arg_5_0.activityID_,
			poolActivityID = arg_5_0.curPoolActivityId_,
			checkPoolStage = var_13_0 and 1 or nil,
			isShowTips = var_13_0 and string.format(GetTips("T0_SKIN_DRAW_TIPS_1"), ItemCfg[arg_5_0.mainReward_[arg_5_0.curPoolID_][1].itemId].name) or "",
			tabText_1 = GetTips("T0_SKIN_DRAW_TIPS_2")
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.oneBtn_, nil, function()
		arg_5_0:DrawCheck(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tenBtn_, nil, function()
		arg_5_0:DrawCheck(10)
	end)

	if arg_5_0.dlcBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.dlcBtn_, nil, function()
			JumpTools.OpenPageByJump("activitySkinDrawDLCPopView", {
				sceneID = arg_5_0.sceneIDList_[arg_5_0.curPoolID_],
				activityID = arg_5_0.activityID_
			})
		end)
	end
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:InitData()
	arg_17_0:BindRedPoint()
	arg_17_0:RefreshUI()
	arg_17_0:CheckHadDrawed()
	arg_17_0:CheckSceneDrawed()
	ActivitySkinDrawData:ShowGetMemoryCoin(arg_17_0.skinID_)
	arg_17_0:RegistEventListener(ACTIVITY_SKIN_MEMORY_COIN_POP, handler(arg_17_0, arg_17_0.OnSkinMemoryCoinPop))
	arg_17_0:RegistEventListener(ACTIVITY_SKIN_DRAW_SELECT_POOL, handler(arg_17_0, arg_17_0.OnSelectPool))
end

function var_0_0.OnSkinMemoryCoinPop(arg_18_0)
	ActivitySkinDrawData:ShowGetMemoryCoin(arg_18_0.skinID_)
end

function var_0_0.InitData(arg_19_0)
	if arg_19_0.isPreview_ then
		manager.ui:SetMainCamera("home")

		arg_19_0.isPreview_ = false
	end

	arg_19_0.activityID_ = arg_19_0.params_.activityID
	arg_19_0.activityData_ = ActivityData:GetActivityData(arg_19_0.activityID_)
	arg_19_0.startTime_ = arg_19_0.activityData_.startTime
	arg_19_0.stopTime_ = arg_19_0.activityData_.stopTime
	arg_19_0.taskActiivtyID_ = ActivitySkinDrawTools.GetTaskActivityID(arg_19_0.activityID_)
	arg_19_0.poolIdList_ = ActivitySkinDrawTools.GetPoolIdList(arg_19_0.activityID_)
	arg_19_0.sceneIDList_ = {}
	arg_19_0.lastCount_ = {}
	arg_19_0.totalCount_ = {}
	arg_19_0.mainReward_ = {}
	arg_19_0.poolStageCount_ = {}

	arg_19_0:InitPoolData()
end

function var_0_0.InitPoolData(arg_20_0)
	arg_20_0.poolDataList_ = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.poolIdList_) do
		arg_20_0.poolDataList_[#arg_20_0.poolDataList_ + 1] = clone(ActivityLimitedDrawPoolListCfg[iter_20_1])
		arg_20_0.totalCount_[iter_20_1] = 0

		local var_20_0 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[iter_20_1] or {}

		arg_20_0.poolStageCount_[iter_20_1] = {}

		for iter_20_2, iter_20_3 in ipairs(var_20_0) do
			local var_20_1 = ActivityLimitedDrawPoolCfg[iter_20_3]

			if not arg_20_0.poolStageCount_[iter_20_1][var_20_1.pool_stage] then
				arg_20_0.poolStageCount_[iter_20_1][var_20_1.pool_stage] = arg_20_0.poolStageCount_[iter_20_1][var_20_1.pool_stage - 1] or 0
			end

			arg_20_0.poolStageCount_[iter_20_1][var_20_1.pool_stage] = arg_20_0.poolStageCount_[iter_20_1][var_20_1.pool_stage] + var_20_1.total
			arg_20_0.totalCount_[iter_20_1] = arg_20_0.totalCount_[iter_20_1] + var_20_1.total
		end
	end
end

function var_0_0.RefreshUI(arg_21_0)
	SetActive(arg_21_0.MovieBtnGo_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	arg_21_0:RefreshTime()
	arg_21_0:RefreshPool()
end

function var_0_0.RefreshTime(arg_22_0)
	local var_22_0
	local var_22_1 = manager.time:GetServerTime()

	arg_22_0:StopTimer()

	if var_22_1 < arg_22_0.stopTime_ then
		arg_22_0.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(arg_22_0.stopTime_))
		arg_22_0.timer_ = Timer.New(function()
			arg_22_0.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(arg_22_0.stopTime_))
			var_22_0 = arg_22_0.stopTime_ - manager.time:GetServerTime()

			if var_22_0 <= 0 then
				arg_22_0:StopTimer()
				arg_22_0:RefreshTime()
			end
		end, 1, -1)

		arg_22_0.timer_:Start()
	else
		arg_22_0.timeText_.text = GetI18NText(GetTips("TIME_OVER"))
	end
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.timer_ then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

function var_0_0.RefreshStroy(arg_25_0)
	local var_25_0 = ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[arg_25_0.activityID_]
	local var_25_1 = SkinCfg[arg_25_0.skinID_]
	local var_25_2 = ActivitySkinDrawData:GetFinishedStory()

	arg_25_0.openStoryIndex_ = #var_25_2 + 1

	for iter_25_0, iter_25_1 in ipairs(var_25_1.plot_title) do
		arg_25_0.storyList_[iter_25_0].titleText_.text = GetI18NText(iter_25_1)

		local var_25_3 = var_25_0 and ActivityLimitedSkinStoryCfg[var_25_0[iter_25_0]]

		arg_25_0.storyIdList_[iter_25_0] = var_25_3 and var_25_3.story_id

		local var_25_4 = iter_25_0 <= arg_25_0.openStoryIndex_

		arg_25_0.storyList_[iter_25_0].lockController:SetSelectedState(tostring(var_25_4))

		if var_25_4 and not table.indexof(var_25_2, arg_25_0.storyIdList_[iter_25_0]) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_DRAW .. iter_25_0, 1, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_DRAW .. iter_25_0, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.RefreshPool(arg_26_0)
	arg_26_0:RefreshPoolData(arg_26_0.poolIdList_)

	arg_26_0.curPoolID_ = ActivitySkinDrawData:GetCurDrawPool(arg_26_0.activityID_) or arg_26_0.poolIdList_[1]
	arg_26_0.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[arg_26_0.curPoolID_].activity_id[1]

	arg_26_0:RefreshCurPool()
	arg_26_0.poolList_:StartScroll(#arg_26_0.poolDataList_)
end

function var_0_0.RefreshPoolData(arg_27_0, arg_27_1)
	arg_27_0.mainReward_ = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		local var_27_0 = ActivityLimitedDrawPoolListCfg[iter_27_1]
		local var_27_1 = var_27_0.activity_id[1]

		arg_27_0.lastCount_[iter_27_1] = arg_27_0.lastCount_[iter_27_1] or {}
		arg_27_0.lastCount_[iter_27_1] = arg_27_0:CaculateCount(iter_27_1, var_27_1)

		local var_27_2 = var_27_0.main_icon_info

		arg_27_0.mainReward_[iter_27_1] = arg_27_0.mainReward_[iter_27_1] or {}

		for iter_27_2, iter_27_3 in ipairs(var_27_2) do
			local var_27_3 = iter_27_3[1]
			local var_27_4 = ActivityLimitedDrawPoolCfg[var_27_3]
			local var_27_5 = ActivitySkinDrawData:GetDrawInfo(var_27_1, var_27_3)
			local var_27_6 = var_27_4.reward[1][1]

			table.insert(arg_27_0.mainReward_[iter_27_1], {
				itemId = var_27_6,
				count = var_27_5 and var_27_5.num or var_27_4.total
			})

			local var_27_7 = ItemCfg[var_27_6]

			if var_27_7.type == ItemConst.ITEM_TYPE.FRAME then
				arg_27_0.frameID_ = var_27_6
			elseif var_27_7.type == ItemConst.ITEM_TYPE.HERO_SKIN then
				arg_27_0.skinID_ = var_27_6
			elseif ActivitySkinDrawTools.GetIsSkinGift(var_27_6) then
				arg_27_0.skinID_ = var_27_7.param[1][1]
			elseif var_27_7.type == ItemConst.ITEM_TYPE.SCENE then
				arg_27_0.sceneIDList_[iter_27_1] = var_27_6
			end
		end
	end

	local var_27_8 = PlayerData:GetFrame(arg_27_0.frameID_)

	arg_27_0.frameUnlock_ = var_27_8 and var_27_8.unlock == 1 and var_27_8.lasted_time == 0
	arg_27_0.skinUnlock_ = HeroTools.GetHasOwnedSkin(arg_27_0.skinID_)
	arg_27_0.sceneUnlock_ = arg_27_0:IsSceneHad()
end

function var_0_0.CaculateCount(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = 0
	local var_28_1 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_28_1] or {}

	for iter_28_0, iter_28_1 in ipairs(var_28_1) do
		local var_28_2 = ActivityLimitedDrawPoolCfg[iter_28_1]
		local var_28_3 = ActivitySkinDrawData:GetDrawInfo(arg_28_2, iter_28_1)

		var_28_0 = var_28_3 and var_28_0 + var_28_3.num or var_28_0 + var_28_2.total
	end

	return var_28_0
end

function var_0_0.RefreshCurPool(arg_29_0)
	ActivitySkinDrawData:SetCurDrawPool(arg_29_0.activityID_, arg_29_0.curPoolID_)

	local var_29_0 = ActivityLimitedDrawPoolListCfg[arg_29_0.curPoolID_]
	local var_29_1 = arg_29_0.lastCount_[arg_29_0.curPoolID_]

	if var_29_1 >= 10 then
		arg_29_0.drawCon_:SetSelectedState("ten")
	elseif var_29_1 > 0 then
		arg_29_0.drawCon_:SetSelectedState("one")
	else
		arg_29_0.drawCon_:SetSelectedState("none")
	end

	local var_29_2, var_29_3 = arg_29_0:GetPoolNowStage(arg_29_0.curPoolID_)
	local var_29_4 = var_29_2 == 1 and "SKIN_DRAE_DESC" or "SKIN_DRAE_DESC2"

	arg_29_0.textDrawDesc_.text = string.format(GetTips(var_29_4), var_29_3, GetI18NText(var_29_0.pool_name))
	arg_29_0.textDrawTimes_.text = string.format("%s/%s", arg_29_0.totalCount_[arg_29_0.curPoolID_] - var_29_1, var_29_3)
	arg_29_0.isSkinPool_ = var_29_0.pool_type == 1

	arg_29_0.scenePreviewCon_:SetSelectedState(arg_29_0.isSkinPool_ and "hide" or "show")

	local var_29_5 = var_29_0.cost_once[1]

	arg_29_0.drawIcon_1.sprite = ItemTools.getItemSprite(var_29_5)
	arg_29_0.drawIcon_2.sprite = ItemTools.getItemSprite(var_29_5)
	arg_29_0.curIndex_ = table.indexof(arg_29_0.poolIdList_, arg_29_0.curPoolID_) or 1

	arg_29_0.rewardCon_:SetSelectedIndex(arg_29_0.curIndex_ - 1)
	arg_29_0:RefreshMainReward()
	arg_29_0:RefreshDLC()
	arg_29_0:RefreshMovie()
end

function var_0_0.RefreshMovie(arg_30_0)
	arg_30_0.criMovie_:Stop()

	local var_30_0 = ObtainSkinBackgroundMovieCfg[arg_30_0.curPoolActivityId_]
	local var_30_1 = deepClone(var_30_0.start_path)
	local var_30_2
	local var_30_3 = ActivitySkinDrawData:GetLastFile(arg_30_0.activityID_)

	if var_30_3 then
		local var_30_4 = math.random(#var_30_1 - 1)
		local var_30_5 = table.indexof(var_30_1, var_30_3)

		if var_30_5 and var_30_5 <= var_30_4 then
			var_30_4 = var_30_4 + 1
		end

		var_30_2 = var_30_1[var_30_4] or var_30_1[1]
	else
		var_30_2 = var_30_1[math.random(#var_30_1)] or var_30_1[1]
	end

	arg_30_0:StopFrameTimer()

	arg_30_0.frameTimer_ = FrameTimer.New(function()
		if tostring(arg_30_0.criplayer_.status) == "Stop" then
			SetFile(arg_30_0.criplayer_, nil, var_30_2, CriMana.Player.SetMode.New)
			ActivitySkinDrawData:SetLastFile(arg_30_0.activityID_, var_30_2)
			arg_30_0.criMovie_:Play()
			arg_30_0:StopFrameTimer()
		end
	end, 1, -1)

	arg_30_0.frameTimer_:Start()
end

function var_0_0.StopFrameTimer(arg_32_0)
	if arg_32_0.frameTimer_ then
		arg_32_0.frameTimer_:Stop()

		arg_32_0.frameTimer_ = nil
	end
end

function var_0_0.RefreshMainReward(arg_33_0)
	if arg_33_0.isSkinPool_ then
		if arg_33_0.giftController_ then
			arg_33_0.giftController_:SetSelectedState("false")
		end

		for iter_33_0, iter_33_1 in ipairs(arg_33_0.mainReward_[arg_33_0.curPoolID_]) do
			if ActivitySkinDrawTools.GetIsSkinGift(iter_33_1.itemId) and arg_33_0.giftReward_ then
				arg_33_0.giftReward_:SetData(iter_33_1.itemId, iter_33_1.count, nil, arg_33_0.curPoolID_)
				arg_33_0.giftController_:SetSelectedState("true")
			elseif arg_33_0.skinID_ == iter_33_1.itemId then
				arg_33_0.skinRewardList_[iter_33_0]:RefreshData(iter_33_1, arg_33_0.curPoolID_)
			else
				arg_33_0.skinRewardList_[iter_33_0]:RefreshData(iter_33_1)
			end
		end
	else
		arg_33_0.sceneReward_:RefreshData(arg_33_0.mainReward_[arg_33_0.curPoolID_][1], arg_33_0.curPoolID_)

		local var_33_0 = 1
		local var_33_1 = arg_33_0.mainReward_[arg_33_0.curPoolID_][1].count > 0

		for iter_33_2 = 2, #arg_33_0.mainReward_[arg_33_0.curPoolID_] do
			local var_33_2 = arg_33_0.mainReward_[arg_33_0.curPoolID_][iter_33_2]

			if arg_33_0.dlcRewardList_[var_33_0] then
				arg_33_0.dlcRewardList_[var_33_0]:RefreshData({
					itemId = var_33_2.itemId,
					count = var_33_2.count
				})
				arg_33_0.dlcRewardList_[var_33_0]:SetLock(var_33_1)
			end

			var_33_0 = var_33_0 + 1
		end
	end
end

function var_0_0.RefreshDLC(arg_34_0)
	if arg_34_0.dlcBtn_ then
		if not arg_34_0.isSkinPool_ then
			SetActive(arg_34_0.dlcBtn_.gameObject, true)

			local var_34_0 = HomeSceneBundleCfg.get_id_list_by_scene_id[arg_34_0.sceneIDList_[arg_34_0.curPoolID_]] or {}
			local var_34_1 = 0

			for iter_34_0, iter_34_1 in ipairs(var_34_0) do
				if ItemTools.getItemNum(HomeSceneBundleCfg[iter_34_1].item_id) > 0 then
					var_34_1 = var_34_1 + 1
				end
			end

			arg_34_0.dlcNumText_.text = string.format("%s/%s", var_34_1, #var_34_0)
		else
			SetActive(arg_34_0.dlcBtn_.gameObject, false)
		end
	end
end

function var_0_0.CheckHadDrawed(arg_35_0)
	if not arg_35_0.params_.checkReward then
		return
	end

	if (getData("activity_check_had", "activity_" .. tostring(arg_35_0.activityID_)) or 0) == 0 and arg_35_0:CheckReward() then
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

function var_0_0.CheckReward(arg_37_0)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.mainReward_[arg_37_0.curPoolID_]) do
		local var_37_0
		local var_37_1
		local var_37_2
		local var_37_3 = iter_37_1.itemId
		local var_37_4 = ItemCfg[var_37_3]

		if var_37_4.type == ItemConst.ITEM_TYPE.FRAME then
			var_37_0 = arg_37_0.frameUnlock_ and iter_37_1.count > 0
		elseif var_37_4.type == ItemConst.ITEM_TYPE.HERO_SKIN or ActivitySkinDrawTools.GetIsSkinGift(var_37_3) then
			var_37_1 = arg_37_0.skinUnlock_ and iter_37_1.count > 0
		elseif var_37_4.type == ItemConst.ITEM_TYPE.SCENE then
			var_37_2 = arg_37_0.sceneUnlock_ and iter_37_1.count > 0
		end

		if var_37_0 or var_37_1 or var_37_2 then
			return true
		end
	end

	return false
end

function var_0_0.IsSceneHad(arg_38_0)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.sceneIDList_) do
		if HomeSceneSettingData:IsUnlockScene(iter_38_1) then
			return true
		end
	end

	return false
end

function var_0_0.CheckSceneDrawed(arg_39_0)
	local var_39_0 = arg_39_0.sceneIDList_[arg_39_0.curPoolID_]

	if arg_39_0.params_.isSceneDrawed and var_39_0 == arg_39_0.params_.sceneDrawedId then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("GENGCHEN_SWIMWEAR_CHANGE_SCENE"), ItemTools.getItemName(var_39_0)),
			OkCallback = function()
				JumpTools.OpenPageByJump("/customCenter", {
					selectType = CustomCenterView.SELECT_SCENE,
					sceneID = var_39_0
				})
			end
		})
	end

	arg_39_0.params_.isSceneDrawed = false
	arg_39_0.params_.sceneDrawedId = 0
end

function var_0_0.JumpToVideo(arg_41_0, arg_41_1)
	local var_41_0 = SkinCfg[arg_41_0.skinID_].video_url[arg_41_1]

	if not var_41_0 or var_41_0 == "" then
		return
	end

	OperationAction.OpenNormalUrl(var_41_0)
end

function var_0_0.DrawCheck(arg_42_0, arg_42_1)
	if not arg_42_0.activityData_:IsActivitying() then
		ShowTips("TIME_OVER")

		return
	end

	if not _G.SkipTip.SkipActivitySkinDrawTip then
		local var_42_0 = {}
		local var_42_1 = false
		local var_42_2 = false
		local var_42_3 = false

		if arg_42_0.isSkinPool_ then
			var_42_0[#var_42_0 + 1] = arg_42_0.skinID_
			var_42_1 = arg_42_0.skinUnlock_
			var_42_2 = arg_42_0.frameUnlock_

			if var_42_2 then
				var_42_0[#var_42_0 + 1] = arg_42_0.frameID_
			end
		else
			var_42_0[#var_42_0 + 1] = arg_42_0.sceneIDList_[arg_42_0.curPoolID_]
			var_42_3 = HomeSceneSettingData:IsUnlockScene(arg_42_0.sceneIDList_[arg_42_0.curPoolID_])
		end

		if var_42_3 or var_42_2 and var_42_1 then
			local var_42_4

			if var_42_3 then
				var_42_4 = string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE"), ItemTools.getItemName(var_42_0[1]))
			else
				var_42_4 = string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE2"), ItemTools.getItemName(var_42_0[1]), ItemTools.getItemName(var_42_0[2]))
			end

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = var_42_4,
				OkCallback = function()
					_G.SkipTip.SkipActivitySkinDrawTip = arg_42_0.SkipActivitySkinDrawTip_

					arg_42_0:AfterCheck(arg_42_1)
				end,
				ToggleCallback = function(arg_44_0)
					arg_42_0.SkipActivitySkinDrawTip_ = arg_44_0
				end
			})
		else
			arg_42_0:AfterCheck(arg_42_1)
		end
	else
		arg_42_0:AfterCheck(arg_42_1)
	end
end

function var_0_0.AfterCheck(arg_45_0, arg_45_1)
	local var_45_0 = ActivityLimitedDrawPoolListCfg[arg_45_0.curPoolID_]
	local var_45_1 = var_45_0.cost_once[1]

	if arg_45_1 <= ItemTools.getItemNum(var_45_1) then
		ActivitySkinDrawAction.StartDraw(arg_45_0.curPoolActivityId_, arg_45_0.curPoolID_, arg_45_1)
	else
		local var_45_2 = getShopCfg(var_45_0.payment_free[1])
		local var_45_3 = {}
		local var_45_4 = {}

		table.insert(var_45_3, var_45_0.payment_free[1])
		table.insert(var_45_4, var_45_2.discount)

		local var_45_5 = var_45_2.shop_id
		local var_45_6 = ShopData.GetShop(var_45_5)[var_45_0.payment_free[1]]
		local var_45_7 = var_45_2.limit_num - (var_45_6.buy_times or 0)
		local var_45_8 = var_45_0.payment

		for iter_45_0, iter_45_1 in ipairs(var_45_8) do
			local var_45_9 = getShopCfg(iter_45_1)
			local var_45_10 = var_45_9.shop_id
			local var_45_11 = ShopData.GetShop(var_45_10)[iter_45_1]

			if var_45_11 then
				local var_45_12 = var_45_9.limit_num - (var_45_11.buy_times or 0)

				if arg_45_1 <= var_45_12 and arg_45_1 <= var_45_7 then
					table.insert(var_45_3, iter_45_1)
					table.insert(var_45_4, var_45_9.discount)
					JumpTools.OpenPageByJump("activitySkinDrawPop", {
						mainActivity = arg_45_0.activityID_,
						poolActivityID = arg_45_0.curPoolActivityId_,
						poolID = arg_45_0.curPoolID_,
						cnt = arg_45_1,
						goods = var_45_3,
						discount = var_45_4
					})

					break
				elseif var_45_12 > 0 then
					JumpTools.GoToSystem("/activityShop", {
						goodId = iter_45_1,
						shopId = var_45_10,
						showShops = {
							var_45_10
						}
					}, ViewConst.SYSTEM_ID.SHOP)

					break
				end
			end
		end
	end
end

function var_0_0.BindRedPoint(arg_46_0)
	manager.redPoint:bindUIandKey(arg_46_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. arg_46_0.taskActiivtyID_)

	for iter_46_0, iter_46_1 in ipairs(arg_46_0.storyList_) do
		manager.redPoint:bindUIandKey(iter_46_1.noticeTrans_, RedPointConst.ACTIVITY_SKIN_DRAW .. iter_46_0)
	end
end

function var_0_0.UnbindRedPoint(arg_47_0)
	manager.redPoint:unbindUIandKey(arg_47_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. arg_47_0.taskActiivtyID_)

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.storyList_) do
		manager.redPoint:unbindUIandKey(iter_47_1.noticeTrans_, RedPointConst.ACTIVITY_SKIN_DRAW .. iter_47_0)
	end
end

function var_0_0.IndexItem(arg_48_0, arg_48_1, arg_48_2)
	arg_48_2:SetData(arg_48_0.poolDataList_[arg_48_1], arg_48_1)
	arg_48_2:RegisterClickFunc(handler(arg_48_0, arg_48_0.OnPoolItemClick))

	if arg_48_1 == arg_48_0.curIndex_ then
		arg_48_2:SelectItem(true)

		arg_48_0.selectItem_ = arg_48_2
	else
		arg_48_2:SelectItem(false)
	end
end

function var_0_0.OnPoolItemClick(arg_49_0, arg_49_1)
	if arg_49_0.selectItem_ then
		if arg_49_0.selectItem_.poolId_ == arg_49_1.poolId_ then
			return
		end

		arg_49_0.selectItem_:SelectItem(false)
	end

	arg_49_0.selectItem_ = arg_49_1

	arg_49_0.selectItem_:SelectItem(true)

	arg_49_0.curPoolID_ = arg_49_1.poolId_
	arg_49_0.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[arg_49_0.curPoolID_].activity_id[1]

	arg_49_0:RefreshCurPool()
end

function var_0_0.OnSelectPool(arg_50_0, arg_50_1)
	arg_50_0.curPoolID_ = arg_50_1
	arg_50_0.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[arg_50_0.curPoolID_].activity_id[1]

	local var_50_0

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.poolList_:GetItemList()) do
		if iter_50_1.poolId_ == arg_50_1 then
			var_50_0 = iter_50_1

			break
		end
	end

	if arg_50_0.selectItem_ then
		if arg_50_0.selectItem_.poolId_ == var_50_0.poolId_ then
			return
		end

		arg_50_0.selectItem_:SelectItem(false)
	end

	arg_50_0.selectItem_ = var_50_0

	arg_50_0.selectItem_:SelectItem(true)
	arg_50_0:RefreshCurPool()
end

function var_0_0.RefreshBar(arg_51_0)
	local var_51_0 = {
		BACK_BAR,
		HOME_BAR
	}
	local var_51_1 = {}

	for iter_51_0, iter_51_1 in ipairs(arg_51_0.poolDataList_) do
		local var_51_2 = iter_51_1.cost_once[1]

		if not table.indexof(var_51_0, var_51_2) then
			table.insert(var_51_1, var_51_2)
		end
	end

	table.insertto(var_51_0, var_51_1)
	table.insertto(var_51_0, {
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SwitchBar(var_51_0)

	for iter_51_2, iter_51_3 in ipairs(var_51_1) do
		manager.windowBar:SetBarCanClick(iter_51_3, true)
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function var_0_0.GetPoolNowStage(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.lastCount_[arg_52_1]
	local var_52_1 = arg_52_0.totalCount_[arg_52_1] - var_52_0
	local var_52_2 = 1

	for iter_52_0, iter_52_1 in ipairs(arg_52_0.poolStageCount_[arg_52_1]) do
		if iter_52_1 <= var_52_1 then
			var_52_2 = math.min(iter_52_0 + 1, #arg_52_0.poolStageCount_[arg_52_1])
		end
	end

	return var_52_2, arg_52_0.poolStageCount_[arg_52_1][var_52_2]
end

function var_0_0.OnTop(arg_53_0)
	arg_53_0:RefreshBar()
	arg_53_0:RefreshStroy()
end

function var_0_0.OnExit(arg_54_0)
	arg_54_0:StopTimer()
	arg_54_0:StopFrameTimer()
	arg_54_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	arg_54_0:RemoveAllEventListener()

	for iter_54_0, iter_54_1 in ipairs(arg_54_0.skinPoolItem_) do
		iter_54_1:OnExit()
	end

	for iter_54_2, iter_54_3 in ipairs(arg_54_0.scenePoolItem_) do
		iter_54_3:OnExit()
	end
end

function var_0_0.Dispose(arg_55_0)
	arg_55_0:RemoveAllListeners()

	for iter_55_0, iter_55_1 in ipairs(arg_55_0.skinRewardList_) do
		iter_55_1:Dispose()
	end

	arg_55_0.skinRewardList_ = {}

	if arg_55_0.giftReward_ then
		arg_55_0.giftReward_:Dispose()

		arg_55_0.giftReward_ = {}
	end

	if arg_55_0.sceneReward_ then
		arg_55_0.sceneReward_:Dispose()

		arg_55_0.sceneReward_ = {}
	end

	for iter_55_2, iter_55_3 in ipairs(arg_55_0.dlcRewardList_) do
		iter_55_3:Dispose()
	end

	arg_55_0.dlcRewardList_ = {}

	if arg_55_0.poolList_ then
		arg_55_0.poolList_:Dispose()

		arg_55_0.poolList_ = nil
	end

	arg_55_0.super.Dispose(arg_55_0)
end

return var_0_0
