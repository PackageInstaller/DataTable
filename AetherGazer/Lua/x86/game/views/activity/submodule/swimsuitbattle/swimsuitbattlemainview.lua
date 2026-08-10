local var_0_0 = class("SwimsuitBattleMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitBattleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
	arg_3_0:AddEventListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroInfoList_ = {}
	arg_4_0.curTabIndex_ = 0
	arg_4_0.startTime_ = nil
	arg_4_0.stopTime_ = nil
	arg_4_0.tabItemList_ = {}
	arg_4_0.greyController_ = arg_4_0.mainControllerEx_:GetController("grey")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.baseBtn_, nil, function()
		local var_6_0 = arg_5_0.heroInfoList_[arg_5_0.curTabIndex_].activityID
		local var_6_1 = SwimsuitBattleHeroCfg[var_6_0].stage_id[1]
		local var_6_2 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SWIMSUIT_BATTLE, arg_5_0.curTabIndex_, nil, {
			stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
			stageID = var_6_1,
			activityID = var_6_0
		})

		arg_5_0:Go("/sectionSelectHero", {
			section = var_6_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
			activityID = var_6_0,
			reserveParams = var_6_2,
			heroDataType = HeroConst.HERO_DATA_TYPE.SWIMSUITBATTLE
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.hardBtn_, nil, function()
		local var_7_0 = arg_5_0.heroInfoList_[arg_5_0.curTabIndex_].activityID
		local var_7_1 = SwimsuitBattleHeroCfg[var_7_0].stage_id[2]
		local var_7_2 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SWIMSUIT_BATTLE, arg_5_0.curTabIndex_, nil, {
			stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
			stageID = var_7_1,
			activityID = var_7_0
		})

		arg_5_0:Go("/sectionSelectHero", {
			section = var_7_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
			activityID = var_7_0,
			reserveParams = var_7_2,
			heroDataType = HeroConst.HERO_DATA_TYPE.SWIMSUITBATTLE
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		local var_8_0 = {}
		local var_8_1 = AssignmentCfg.get_id_list_by_activity_id[282951]

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			if not table.indexof(var_8_0, iter_8_1) then
				table.insert(var_8_0, iter_8_1)
			end
		end

		JumpTools.OpenPageByJump("summerQuestRewardPop", {
			activityIDList = var_8_0
		})
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = SwimsuitBattleData:GetVoteTicketInfo(arg_10_0.params_.activity)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_10_0
	})
	manager.windowBar:SetBarCanAdd(var_10_0, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SWIMSUIT_EXPLAIN_BATTLE")

	arg_10_0.heroInfoList_ = SwimsuitBattleData:GetUseHeroList(arg_10_0.params_.activity)

	local var_10_3 = SwimsuitBattleData:GetLastUseHeroID()

	if var_10_3 ~= 0 then
		arg_10_0.curTabIndex_ = var_10_3
	else
		for iter_10_0 = #arg_10_0.heroInfoList_, 1, -1 do
			if ActivityData:GetActivityData(arg_10_0.heroInfoList_[iter_10_0].activityID).startTime <= manager.time:GetServerTime() then
				arg_10_0.curTabIndex_ = iter_10_0

				break
			end
		end
	end

	if arg_10_0.curTabIndex_ == 0 then
		arg_10_0.curTabIndex_ = 1
	end

	if #arg_10_0.tabItemList_ == 0 then
		for iter_10_1 = 1, #arg_10_0.heroInfoList_ do
			local var_10_4 = Object.Instantiate(arg_10_0.tabGo_, arg_10_0.tabRootTrs_)

			SetActive(var_10_4, true)

			arg_10_0.tabItemList_[iter_10_1] = SwimsuitBattleTabItem.New(var_10_4)

			arg_10_0.tabItemList_[iter_10_1]:SetData(arg_10_0.heroInfoList_[iter_10_1].heroID, arg_10_0.heroInfoList_[iter_10_1].skinID, arg_10_0.heroInfoList_[iter_10_1].activityID, iter_10_1 == arg_10_0.curTabIndex_, function()
				if arg_10_0.curTabIndex_ == iter_10_1 then
					return
				end

				arg_10_0.tabItemList_[arg_10_0.curTabIndex_]:Select(false)
				arg_10_0.tabItemList_[iter_10_1]:Select(true)

				arg_10_0.curTabIndex_ = iter_10_1

				arg_10_0:UpdateView()
				arg_10_0.changeAni_:Play("role_change", -1, 0)
			end)
		end
	else
		for iter_10_2 = 1, #arg_10_0.tabItemList_ do
			arg_10_0.tabItemList_[iter_10_2]:RefreshLock()
		end
	end

	arg_10_0.tabRootTrs_:SetAnchoredPositionY((arg_10_0.curTabIndex_ - 1) * 144)

	arg_10_0.voteImg_.sprite = ItemTools.getItemSprite(var_10_0)
	arg_10_0.voteText_.text = var_10_1 .. "/" .. var_10_2

	local var_10_5 = ActivityData:GetActivityData(arg_10_0.params_.activity)

	arg_10_0.startTime_ = var_10_5.startTime
	arg_10_0.stopTime_ = var_10_5.stopTime

	arg_10_0:AddTimer()
	arg_10_0:UpdateView()
	manager.redPoint:bindUIandKey(arg_10_0.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD)
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0 = SwimsuitVoteHeroCfg[SwimsuitVoteHeroCfg.get_id_list_by_hero_id[arg_12_0.heroInfoList_[arg_12_0.curTabIndex_].heroID][1]]

	arg_12_0.AvatarImg_.spriteAsync = "TextureConfig/Swimsuit/" .. var_12_0.show_image

	if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, arg_12_0.heroInfoList_[arg_12_0.curTabIndex_].activityID)) == 1 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, arg_12_0.heroInfoList_[arg_12_0.curTabIndex_].activityID), 0)
		saveData("SwimsuitBattleHeroRedPoint", "battle" .. arg_12_0.heroInfoList_[arg_12_0.curTabIndex_].activityID, 1)
	end

	if ActivityData:GetActivityData(arg_12_0.heroInfoList_[arg_12_0.curTabIndex_].activityID).startTime > manager.time:GetServerTime() then
		arg_12_0.greyController_:SetSelectedState("true")
	else
		arg_12_0.greyController_:SetSelectedState("false")
	end
end

function var_0_0.AddTimer(arg_13_0)
	arg_13_0:StopTimer()

	arg_13_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_, true)
	arg_13_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_13_0.stopTime_ then
			return
		end

		arg_13_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_, true)
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	arg_16_0:StopTimer()
	SwimsuitBattleData:SetLastUseHeroID(arg_16_0.curTabIndex_)
	manager.redPoint:unbindUIandKey(arg_16_0.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD)
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()

	for iter_17_0 = 1, #arg_17_0.tabItemList_ do
		arg_17_0.tabItemList_[iter_17_0]:Dispose()

		arg_17_0.tabItemList_[iter_17_0] = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
