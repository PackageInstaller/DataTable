local var_0_0 = class("ActivityOathDrawMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return OathDrawTools.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_4_0.rewardCon_ = arg_4_0.controllerEx_:GetController("reward")
	arg_4_0.poolList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.poolListGo_, ActivitySkinDrawPoolItem)
	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
	arg_4_0.sceneReward_ = ActivitySkinDrawItem.New(arg_4_0.sceneReward_1)
	arg_4_0.skinGiftReward_ = ActivityOathGiftItem.New(arg_4_0.giftRewardObj_)
	arg_4_0.discountInfo_ = ActivityOathDiscountInfo.New(arg_4_0.couponObj_)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.poolDataList_[arg_5_1], arg_5_1)
	arg_5_2:RegisterClickFunc(handler(arg_5_0, arg_5_0.OnPoolItemClick))

	if arg_5_1 == arg_5_0.curIndex_ then
		arg_5_2:SelectItem(true)

		arg_5_0.selectItem_ = arg_5_2
	else
		arg_5_2:SelectItem(false)
	end
end

function var_0_0.OnPoolItemClick(arg_6_0, arg_6_1)
	if arg_6_0.selectItem_ then
		if arg_6_0.selectItem_ == arg_6_1 then
			return
		end

		arg_6_0.selectItem_:SelectItem(false)
	end

	arg_6_0.selectItem_ = arg_6_1

	arg_6_0.selectItem_:SelectItem(true)

	arg_6_0.curPoolID_ = arg_6_1.poolId_
	arg_6_0.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[arg_6_0.curPoolID_].activity_id[1]

	arg_6_0:RefreshCurPool()
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnInfo_, nil, function()
		JumpTools.OpenPageByJump("skinDrawInfo", {
			isOath = true,
			poolID = arg_7_0.curPoolID_,
			mainActivity = arg_7_0.activityID_,
			poolActivityID = arg_7_0.curPoolActivityId_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.goBtn_, nil, function()
		JumpTools.GoToSystem("activityOathDrawGameView", {
			poolID = arg_7_0.curPoolID_,
			activityID = arg_7_0.activityID_,
			isGetBestReward = arg_7_0:IsGetBestReward()
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.portraitBtn_, nil, function()
		if arg_7_0.isSkinPool_ then
			arg_7_0:Go("heroPortrait", {
				skinID = arg_7_0.skinID_
			})
		else
			arg_7_0:Go("heroPortraitFull", {
				skinID = arg_7_0.skinID_
			})
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.battleBtn_, nil, function()
		local var_11_0 = 0
		local var_11_1 = SkinTagCfg[arg_7_0.skinID_]
		local var_11_2 = var_11_1.trial_activity
		local var_11_3 = var_11_2[1]

		for iter_11_0, iter_11_1 in ipairs(var_11_2) do
			local var_11_4 = ActivitySkinTrialCfg[iter_11_1].activity_id

			if ActivityData:GetActivityIsOpen(var_11_4) then
				var_11_0 = var_11_4
				var_11_3 = iter_11_1

				break
			end
		end

		SkinTrialData:SaveStageID(var_11_3)
		arg_7_0:Go("/sectionSelectHero", {
			activityID = var_11_0,
			section = var_11_1.trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
end

function var_0_0.AddEventListeners(arg_12_0)
	arg_12_0:RegistEventListener(ACTIVITY_OATH_SKIN_DRAW_OPEN, handler(arg_12_0, arg_12_0.UpdateDrawCntShow))
end

function var_0_0.UpdateDrawCntShow(arg_13_0)
	arg_13_0:UpdateRemainCountShow()
	arg_13_0:RefreshMainReward()
	arg_13_0.discountInfo_:RefreshUI()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()
	arg_14_0:InitData()
	arg_14_0:RefreshUI()
end

function var_0_0.OnEnterOver(arg_15_0)
	arg_15_0:AddCheckRewardTimer()
end

function var_0_0.DelCheckRewardTimer(arg_16_0)
	if arg_16_0.checkRewardTimer_ then
		arg_16_0.checkRewardTimer_:Stop()

		arg_16_0.checkRewardTimer_ = nil
	end
end

function var_0_0.AddCheckRewardTimer(arg_17_0)
	arg_17_0:DelCheckRewardTimer()

	arg_17_0.checkRewardTimer_ = Timer.New(function()
		arg_17_0:CheckHadDrawed()
	end, 0.033)

	arg_17_0.checkRewardTimer_:Start()
end

function var_0_0.CheckHadDrawed(arg_19_0)
	if (getData("activity_check_had", "activity_" .. tostring(arg_19_0.activityID_)) or 0) == 0 and arg_19_0:CheckReward() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WEDDING_REWARD_TIPS1"),
			OkCallback = function()
				saveData("activity_check_had", "activity_" .. tostring(arg_19_0.activityID_), 1)
			end
		})
	end
end

function var_0_0.CheckReward(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.mainReward_[arg_21_0.curPoolID_]) do
		local var_21_0
		local var_21_1
		local var_21_2 = iter_21_1.itemId

		if ItemCfg[var_21_2].type == ItemConst.ITEM_TYPE.GIFT then
			var_21_0 = arg_21_0.skinUnlock_ and iter_21_1.count > 0
		elseif ItemCfg[var_21_2].type == ItemConst.ITEM_TYPE.SCENE then
			var_21_1 = arg_21_0.sceneUnlock_ and iter_21_1.count > 0
		end

		if var_21_0 or var_21_1 then
			return true
		end
	end

	return false
end

function var_0_0.InitData(arg_22_0)
	arg_22_0.activityID_ = arg_22_0.params_.activityID
	arg_22_0.activityData_ = ActivityData:GetActivityData(arg_22_0.activityID_)
	arg_22_0.startTime_ = arg_22_0.activityData_.startTime
	arg_22_0.stopTime_ = arg_22_0.activityData_.stopTime
	arg_22_0.poolIdList_ = OathDrawTools.GetPoolIdList(arg_22_0.activityID_)
	arg_22_0.sceneIDList_ = {}

	arg_22_0:InitPoolData()
	arg_22_0.discountInfo_:SetData(arg_22_0.activityID_)
end

function var_0_0.InitPoolData(arg_23_0)
	arg_23_0.poolDataList_ = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.poolIdList_) do
		arg_23_0.poolDataList_[#arg_23_0.poolDataList_ + 1] = clone(ActivityLimitedDrawPoolListCfg[iter_23_1])
	end
end

function var_0_0.RefreshUI(arg_24_0)
	arg_24_0:RefreshTime()
	arg_24_0:RefreshPool()
end

function var_0_0.RefreshTime(arg_25_0)
	local var_25_0
	local var_25_1 = manager.time:GetServerTime()

	arg_25_0:StopTimer()

	if var_25_1 < arg_25_0.stopTime_ then
		arg_25_0.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(arg_25_0.stopTime_))
		arg_25_0.timer_ = Timer.New(function()
			arg_25_0.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(arg_25_0.stopTime_))
			var_25_0 = arg_25_0.stopTime_ - manager.time:GetServerTime()

			if var_25_0 <= 0 then
				arg_25_0:StopTimer()
				arg_25_0:RefreshTime()
			end
		end, 1, -1)

		arg_25_0.timer_:Start()
	else
		arg_25_0.timeText_.text = GetI18NText(GetTips("TIME_OVER"))
	end
end

function var_0_0.StopTimer(arg_27_0)
	if arg_27_0.timer_ then
		arg_27_0.timer_:Stop()

		arg_27_0.timer_ = nil
	end
end

function var_0_0.RefreshPool(arg_28_0)
	arg_28_0:RefreshPoolData(arg_28_0.poolIdList_)

	arg_28_0.curPoolID_ = ActivityOathDrawData:GetCurDrawPool(arg_28_0.activityID_) or arg_28_0.poolIdList_[1]
	arg_28_0.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[arg_28_0.curPoolID_].activity_id[1]

	arg_28_0:RefreshCurPool()
	arg_28_0.poolList_:StartScroll(#arg_28_0.poolDataList_)
end

function var_0_0.RefreshPoolData(arg_29_0, arg_29_1)
	arg_29_0.mainReward_ = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0 = ActivityLimitedDrawPoolListCfg[iter_29_1]
		local var_29_1 = var_29_0.activity_id[1]
		local var_29_2 = var_29_0.main_icon_info

		arg_29_0.mainReward_[iter_29_1] = arg_29_0.mainReward_[iter_29_1] or {}

		for iter_29_2, iter_29_3 in ipairs(var_29_2) do
			local var_29_3 = iter_29_3[1]
			local var_29_4 = ActivityLimitedDrawPoolCfg[var_29_3]
			local var_29_5 = ActivityOathDrawData:GetDrawInfo(var_29_1, var_29_3)
			local var_29_6 = var_29_4.reward[1][1]

			if ItemCfg[var_29_6].type == ItemConst.ITEM_TYPE.GIFT then
				table.insert(arg_29_0.mainReward_[iter_29_1], {
					itemId = var_29_6,
					count = var_29_5 and var_29_5.num or var_29_4.total
				})

				local var_29_7 = ItemCfg[var_29_6].param

				for iter_29_4, iter_29_5 in pairs(var_29_7) do
					local var_29_8 = iter_29_5[1]

					if ItemCfg[var_29_8].type == ItemConst.ITEM_TYPE.HERO_SKIN then
						arg_29_0.skinID_ = var_29_8
					end
				end
			elseif ItemCfg[var_29_6].type == ItemConst.ITEM_TYPE.SCENE then
				arg_29_0.sceneIDList_[iter_29_1] = var_29_6

				table.insert(arg_29_0.mainReward_[iter_29_1], {
					itemId = var_29_6,
					count = var_29_5 and var_29_5.num or var_29_4.total
				})
			end
		end
	end

	arg_29_0.skinUnlock_ = HeroTools.GetHasOwnedSkin(arg_29_0.skinID_)
	arg_29_0.sceneUnlock_ = arg_29_0:IsSceneHad()
end

function var_0_0.IsGetBestReward(arg_30_0)
	if arg_30_0.isSkinPool_ then
		return arg_30_0.skinUnlock_
	else
		return arg_30_0.sceneUnlock_
	end
end

function var_0_0.IsSceneHad(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.sceneIDList_) do
		if HomeSceneSettingData:IsUnlockScene(iter_31_1) then
			return true
		end
	end

	return false
end

function var_0_0.RefreshCurPool(arg_32_0)
	ActivityOathDrawData:SetCurDrawPool(arg_32_0.activityID_, arg_32_0.curPoolID_)

	arg_32_0.isSkinPool_ = ActivityLimitedDrawPoolListCfg[arg_32_0.curPoolID_].pool_type == 1
	arg_32_0.curIndex_ = table.indexof(arg_32_0.poolIdList_, arg_32_0.curPoolID_) or 1

	arg_32_0.rewardCon_:SetSelectedIndex(arg_32_0.curIndex_ - 1)
	arg_32_0:RefreshMainReward()
	arg_32_0:RefreshMovie()
	arg_32_0:UpdateRemainCountShow()
end

function var_0_0.UpdateRemainCountShow(arg_33_0)
	local var_33_0 = ActivityOathDrawData:GetRemainCanDrawCnt(arg_33_0.curPoolActivityId_)
	local var_33_1 = OathDrawTools.GetDrawMaxDropCount(arg_33_0.curPoolID_)

	arg_33_0.drawText_.text = string.format(GetTips("SKIN_DRAE_DESC"), var_33_1, OathDrawTools.GetPoolBestRewardName(arg_33_0.curPoolID_))
	arg_33_0.remainCntText_.text = string.format("%s/%s", var_33_1 - var_33_0, var_33_1)
end

function var_0_0.RefreshMainReward(arg_34_0)
	if arg_34_0.isSkinPool_ then
		local var_34_0, var_34_1 = ActivityOathDrawData:GetGiftID()

		arg_34_0.skinGiftReward_:SetData(var_34_1, arg_34_0.curPoolActivityId_, nil, arg_34_0.curPoolID_)
	else
		local var_34_2 = ActivityOathDrawData:GetSceneDropID(arg_34_0.curPoolActivityId_)
		local var_34_3 = ActivityOathDrawData:GetDrawInfo(arg_34_0.curPoolActivityId_, var_34_2)
		local var_34_4 = ActivityOathDrawData:GetSceneID(arg_34_0.curPoolActivityId_)

		arg_34_0.sceneReward_:RefreshData({
			itemId = var_34_4,
			count = var_34_3.num
		}, arg_34_0.curPoolID_)
	end
end

function var_0_0.RefreshMovie(arg_35_0)
	arg_35_0.criMovie_:Stop()

	local var_35_0 = ObtainSkinBackgroundMovieCfg[arg_35_0.curPoolActivityId_]
	local var_35_1 = deepClone(var_35_0.start_path)
	local var_35_2
	local var_35_3 = ActivityOathDrawData:GetLastFile(arg_35_0.activityID_)

	if var_35_3 then
		local var_35_4 = math.random(#var_35_1 - 1)
		local var_35_5 = table.indexof(var_35_1, var_35_3)

		if var_35_5 and var_35_5 <= var_35_4 then
			var_35_4 = var_35_4 + 1
		end

		var_35_2 = var_35_1[var_35_4] or var_35_1[1]
	else
		var_35_2 = var_35_1[math.random(#var_35_1)] or var_35_1[1]
	end

	arg_35_0:StopFrameTimer()

	arg_35_0.frameTimer_ = FrameTimer.New(function()
		if tostring(arg_35_0.criplayer_.status) == "Stop" then
			SetFile(arg_35_0.criplayer_, nil, var_35_2, CriMana.Player.SetMode.New)
			ActivityOathDrawData:SetLastFile(arg_35_0.activityID_, var_35_2)
			arg_35_0.criMovie_:Play()
			arg_35_0:StopFrameTimer()
		end
	end, 1, -1)

	arg_35_0.frameTimer_:Start()
end

function var_0_0.StopFrameTimer(arg_37_0)
	if arg_37_0.frameTimer_ then
		arg_37_0.frameTimer_:Stop()

		arg_37_0.frameTimer_ = nil
	end
end

function var_0_0.RefreshBar(arg_38_0)
	local var_38_0 = {
		BACK_BAR,
		HOME_BAR
	}

	manager.windowBar:SwitchBar(var_38_0)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function var_0_0.OnTop(arg_39_0)
	arg_39_0:RefreshBar()
end

function var_0_0.OnExit(arg_40_0)
	arg_40_0:DelCheckRewardTimer()
	arg_40_0:StopTimer()
	arg_40_0:StopFrameTimer()
	manager.windowBar:HideBar()
	arg_40_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_41_0)
	arg_41_0.discountInfo_:Dispose()
	arg_41_0:RemoveAllListeners()

	if arg_41_0.poolList_ then
		arg_41_0.poolList_:Dispose()

		arg_41_0.poolList_ = nil
	end

	if arg_41_0.skinGiftReward_ then
		arg_41_0.skinGiftReward_:Dispose()

		arg_41_0.skinGiftReward_ = nil
	end

	if arg_41_0.sceneReward_ then
		arg_41_0.sceneReward_:Dispose()

		arg_41_0.sceneReward_ = {}
	end

	arg_41_0.super.Dispose(arg_41_0)
end

return var_0_0
