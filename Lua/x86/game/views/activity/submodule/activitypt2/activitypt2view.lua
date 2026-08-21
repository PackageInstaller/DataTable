local var_0_0 = class("ActivityPt2View", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityPt2Tools.GetMainUIName(arg_1_0.params_.mainActivityId)
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
	arg_4_0:RefreshShop()

	arg_4_0.normalBtn_ = {}
	arg_4_0.challengeBtn_ = {}
	arg_4_0.hardBtn_ = {}
	arg_4_0.normalCon_ = {}
	arg_4_0.challengeCon_ = {}
	arg_4_0.hardCon_ = {}
	arg_4_0.normalAni_ = {}
	arg_4_0.challengeAni_ = {}
	arg_4_0.hardAni_ = {}

	local var_4_0 = ActivityCfg[arg_4_0.params_.mainActivityId].sub_activity_list

	for iter_4_0, iter_4_1 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[var_4_0[1]]) do
		table.insert(arg_4_0.normalBtn_, arg_4_0["normalBtn_" .. iter_4_0])
		table.insert(arg_4_0.normalCon_, ControllerUtil.GetController(arg_4_0["normalBtn_" .. iter_4_0].transform, "status"))
		table.insert(arg_4_0.normalAni_, arg_4_0["normalAni_" .. iter_4_0])
	end

	for iter_4_2, iter_4_3 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[var_4_0[2]]) do
		table.insert(arg_4_0.challengeBtn_, arg_4_0["challengeBtn_" .. iter_4_2])
		table.insert(arg_4_0.challengeCon_, ControllerUtil.GetController(arg_4_0["challengeBtn_" .. iter_4_2].transform, "status"))
		table.insert(arg_4_0.challengeAni_, arg_4_0["challengeAni_" .. iter_4_2])
	end

	for iter_4_4, iter_4_5 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[var_4_0[3]]) do
		table.insert(arg_4_0.hardBtn_, arg_4_0["hardBtn_" .. iter_4_4])
		table.insert(arg_4_0.hardCon_, ControllerUtil.GetController(arg_4_0["hardBtn_" .. iter_4_4].transform, "status"))
		table.insert(arg_4_0.hardAni_, arg_4_0["hardAni_" .. iter_4_4])
	end

	arg_4_0.tgl_ = {
		arg_4_0.tgl_1,
		arg_4_0.tgl_2,
		arg_4_0.tgl_3
	}
	arg_4_0.lockCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "lock")
	arg_4_0.typeCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "type")
	arg_4_0.indexCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "index")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			arg_5_0:BlankAni()
			JumpTools.Back()
			arg_5_0.indexCon_:SetSelectedIndex(0)

			arg_5_0.selectLevel_ = 0
		end

		local var_6_0 = ActivityShopCfg[arg_5_0.activityID_]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0.activity_theme]) do
			local var_6_2 = ActivityShopCfg[iter_6_1].shop_id
			local var_6_3 = ActivityData:GetActivityData(ShopListCfg[var_6_2].activity_id)

			if var_6_3 and var_6_3:IsActivitying() then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_4, var_6_5 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_4 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_5 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_5 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0:Go("/activityRaceRank", {
			activityID = arg_5_0.rankID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			arg_5_0:BlankAni()
			JumpTools.Back()
			arg_5_0.indexCon_:SetSelectedIndex(0)

			arg_5_0.selectLevel_ = 0
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tgl_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_9_0)
			if arg_9_0 then
				if arg_5_0:IsOpenSectionView() then
					arg_5_0.tgl_[arg_5_0.index_].isOn = true

					return
				end

				if iter_5_0 ~= arg_5_0.index_ then
					if arg_5_0.changeAni_ then
						arg_5_0.changeCanvas_.alpha = 0
						arg_5_0.changeAni_.enabled = false
					end

					arg_5_0:ToggleOnAni(iter_5_0)

					local var_9_0, var_9_1, var_9_2 = ActivityPt2Tools.GetToggleClickEffect(arg_5_0.params_.mainActivityId, iter_5_0)

					if var_9_0 ~= "" and var_9_1 ~= "" then
						manager.audio:StopEffect()
						manager.audio:PlayEffect(var_9_0, var_9_1, var_9_2)
					end

					arg_5_0.index_ = iter_5_0
				end

				arg_5_0.indexCon_:SetSelectedState(0)
				arg_5_0.typeCon_:SetSelectedStateWithCallback(iter_5_0, function()
					if arg_5_0.changeAni_ then
						arg_5_0.changeAni_.enabled = true

						arg_5_0.changeAni_:Play("eff_middle_cx", 0, 0)
					end
				end)
				ActivityPt2Data:SetLastStage(arg_5_0.activityID_, iter_5_0, 1)
			end
		end)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.normalBtn_) do
		arg_5_0:AddBtnListener(iter_5_3, nil, function()
			arg_5_0:EnterLevel(1, iter_5_2)
		end)
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.challengeBtn_) do
		arg_5_0:AddBtnListener(iter_5_5, nil, function()
			arg_5_0:EnterLevel(2, iter_5_4)
		end)
	end

	for iter_5_6, iter_5_7 in ipairs(arg_5_0.hardBtn_) do
		arg_5_0:AddBtnListener(iter_5_7, nil, function()
			arg_5_0:EnterLevel(3, iter_5_6)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		local var_14_0 = ActivityCfg[arg_5_0.activityID_].sub_activity_list[3]
		local var_14_1 = ActivityPt2Cfg.get_id_list_by_activity_id[var_14_0][1]
		local var_14_2 = ActivityPt2Cfg[var_14_1].pre_stage
		local var_14_3 = ActivityPt2Cfg[var_14_2]

		ShowTips(string.format(GetTips("ACTIVITY_XUHENG_PT_EXLOCK"), var_14_3.time, BattleActivityPtStageV2ChallengeCfg[var_14_3.stage_id].name))
	end)

	if arg_5_0.eventTrigger_ then
		arg_5_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
			if arg_5_0:IsOpenSectionView() then
				JumpTools.Back()
			end

			arg_5_0.drag_ = true
		end))
		arg_5_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
			arg_5_0.drag_ = false
		end))
	end
end

function var_0_0.OnEnter(arg_17_0)
	if not arg_17_0.activityID_ or arg_17_0.activityID_ ~= arg_17_0.params_.mainActivityId then
		arg_17_0.activityID_ = arg_17_0.params_.mainActivityId

		arg_17_0:ReLoad()
	end

	arg_17_0:RefreshUI()
end

function var_0_0.ReLoad(arg_18_0)
	if arg_18_0.gameObject_ then
		arg_18_0:Dispose()
		Object.Destroy(arg_18_0.gameObject_)
	end

	local var_18_0 = Asset.Load(arg_18_0:UIName())

	arg_18_0.gameObject_ = Object.Instantiate(var_18_0, arg_18_0:UIParent())
	arg_18_0.transform_ = arg_18_0.gameObject_.transform

	arg_18_0:Init()
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshData()
	arg_19_0:RefreshTime()
	arg_19_0:RefreshState()
end

function var_0_0.RefreshData(arg_20_0)
	arg_20_0.activityID_ = arg_20_0.params_.mainActivityId
	arg_20_0.activityData_ = ActivityData:GetActivityData(arg_20_0.activityID_)
	arg_20_0.startTime_ = arg_20_0.activityData_.startTime
	arg_20_0.stopTime_ = arg_20_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_21_0)
	local var_21_0
	local var_21_1 = manager.time:GetServerTime()
	local var_21_2 = ActivityData:GetActivityData(arg_21_0.params_.mainActivityId)
	local var_21_3 = var_21_2.startTime
	local var_21_4 = var_21_2.stopTime
	local var_21_5 = ActivityShopCfg[arg_21_0.params_.mainActivityId].shop_id
	local var_21_6 = ActivityData:GetActivityData(ShopListCfg[var_21_5].activity_id).stopTime
	local var_21_7 = var_21_6 - var_21_1

	arg_21_0:StopTimer()

	if var_21_1 < var_21_3 and var_21_2:IsActivitying() == false then
		arg_21_0.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		arg_21_0.timer_ = Timer.New(function()
			var_21_0 = var_21_3 - manager.time:GetServerTime()

			if var_21_0 <= 0 then
				arg_21_0:StopTimer()
				arg_21_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_21_0.timer_:Start()
	elseif var_21_1 < var_21_4 or var_21_1 < var_21_6 then
		if var_21_1 < var_21_4 then
			arg_21_0.timeLabel_.text = manager.time:GetLostTimeStr2(var_21_4)
		else
			arg_21_0.timeLabel_.text = GetTips("TIME_OVER")
		end

		if arg_21_0.shopTimeGo_ then
			if var_21_7 <= GameSetting.time_remaining_show.value[1] * 86400 then
				arg_21_0.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_21_6)

				SetActive(arg_21_0.shopTimeGo_, true)
			else
				SetActive(arg_21_0.shopTimeGo_, false)
			end
		end

		arg_21_0.timer_ = Timer.New(function()
			var_21_1 = manager.time:GetServerTime()
			var_21_0 = var_21_4 - var_21_1
			var_21_7 = var_21_6 - var_21_1

			if var_21_0 <= 0 and var_21_7 <= 0 then
				arg_21_0:StopTimer()
				arg_21_0:RefreshTime()

				return
			end

			if var_21_1 < var_21_4 then
				arg_21_0.timeLabel_.text = manager.time:GetLostTimeStr2(var_21_4)
			else
				arg_21_0.timeLabel_.text = GetTips("TIME_OVER")
			end

			if arg_21_0.shopTimeGo_ then
				if var_21_7 <= GameSetting.time_remaining_show.value[1] * 86400 then
					arg_21_0.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_21_6)

					SetActive(arg_21_0.shopTimeGo_, true)
				else
					SetActive(arg_21_0.shopTimeGo_, false)
				end
			end
		end, 1, -1)

		arg_21_0.timer_:Start()
	else
		arg_21_0.timeLabel_.text = GetTips("TIME_OVER")
		arg_21_0.shopTimeLabel_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.timer_ then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

function var_0_0.RefreshState(arg_25_0)
	local var_25_0 = arg_25_0:IsLockEx()

	arg_25_0.lockCon_:SetSelectedState(var_25_0 and "true" or "false")

	local var_25_1 = ActivityPt2Data:GetLastStage(arg_25_0.activityID_)
	local var_25_2 = ActivityCfg[arg_25_0.params_.mainActivityId].sub_activity_list
	local var_25_3 = var_25_1 and var_25_1.type or 1

	arg_25_0.typeCon_:SetSelectedState(var_25_3)

	arg_25_0.index_ = var_25_3
	arg_25_0.tgl_[var_25_3].isOn = true

	local var_25_4, var_25_5, var_25_6 = ActivityPt2Tools.GetToggleClickEffect(arg_25_0.params_.mainActivityId, var_25_3)

	if var_25_4 ~= "" and var_25_5 ~= "" then
		manager.audio:StopEffect()
		manager.audio:PlayEffect(var_25_4, var_25_5, var_25_6)
	end

	arg_25_0:ToggleOnAni(var_25_3)

	arg_25_0.selectLevel_ = 0

	if arg_25_0:IsOpenSectionView() and var_25_1 then
		arg_25_0.indexCon_:SetSelectedState(var_25_1.type .. "_" .. var_25_1.index)
	else
		arg_25_0.indexCon_:SetSelectedState(0)
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.normalCon_) do
		local var_25_7 = ActivityPt2Cfg.get_id_list_by_activity_id[var_25_2[1]][iter_25_0]
		local var_25_8 = ActivityPt2Data:GetNormalData(var_25_2[1], var_25_7)

		if (var_25_8 and var_25_8.clear_time or 0) > 0 then
			iter_25_1:SetSelectedState("get")
		else
			iter_25_1:SetSelectedState("nor")
		end
	end

	for iter_25_2, iter_25_3 in ipairs(arg_25_0.challengeCon_) do
		local var_25_9 = ActivityPt2Cfg.get_id_list_by_activity_id[var_25_2[2]][iter_25_2]
		local var_25_10 = ActivityPt2Data:GetChallengeData(var_25_2[2], var_25_9)

		if (var_25_10 and var_25_10.clear_time or 0) > 0 then
			iter_25_3:SetSelectedState("get")
		else
			iter_25_3:SetSelectedState("nor")
		end
	end

	for iter_25_4, iter_25_5 in ipairs(arg_25_0.hardCon_) do
		local var_25_11 = ActivityPt2Data:GetHardData(var_25_2[3])

		if (var_25_11 and var_25_11.clear_time or 0) > 0 then
			iter_25_5:SetSelectedState("get")
		else
			iter_25_5:SetSelectedState("nor")
		end
	end

	arg_25_0.rankID_ = var_25_2[4]

	local var_25_12 = ActivityPt2Data:GetHardData(var_25_2[3])

	if var_25_12 and var_25_12.clear_time > 0 then
		local var_25_13 = ActivityPt2Data:GetExScore(var_25_2[3])

		arg_25_0.score_.text = var_25_13
	else
		arg_25_0.score_.text = GetTips("NO_RECORD")
	end
end

function var_0_0.ToggleOnAni(arg_26_0, arg_26_1)
	local var_26_0 = {}

	if arg_26_1 == 1 then
		var_26_0 = arg_26_0.normalAni_
	elseif arg_26_1 == 2 then
		var_26_0 = arg_26_0.challengeAni_
	elseif arg_26_1 == 3 then
		var_26_0 = arg_26_0.hardAni_
	end

	local var_26_1 = ActivityPt2Tools.GetBtnEnterAnimation(arg_26_0.activityID_)

	if var_26_1 ~= "" then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			iter_26_1:Play(var_26_1, -1, 0)
		end
	end
end

function var_0_0.EnterLevel(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0.selectLevel_ ~= arg_27_2 then
		arg_27_0:CheckClickBtnAni(arg_27_2)
	end

	arg_27_0.selectLevel_ = arg_27_2

	ActivityPt2Data:SetLastStage(arg_27_0.activityID_, arg_27_1, arg_27_2)
	arg_27_0.indexCon_:SetSelectedState(arg_27_1 .. "_" .. arg_27_2)

	local var_27_0 = ActivityCfg[arg_27_0.params_.mainActivityId].sub_activity_list[arg_27_1]
	local var_27_1 = ActivityPt2Cfg.get_id_list_by_activity_id[var_27_0][arg_27_2]
	local var_27_2 = ActivityPt2Cfg[var_27_1].stage_id
	local var_27_3

	if arg_27_1 == 1 then
		var_27_3 = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL
	elseif arg_27_1 == 2 then
		var_27_3 = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE
	else
		var_27_3 = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD
	end

	JumpTools.OpenPageByJump("activityPt2SectionInfo", {
		section = var_27_2,
		sectionType = var_27_3,
		mainActivityId = arg_27_0.activityID_,
		activityId = var_27_0,
		repeat_id = var_27_1,
		backCall = function()
			arg_27_0:BlankAni()
			arg_27_0.indexCon_:SetSelectedIndex(0)

			arg_27_0.selectLevel_ = 0
		end
	})
end

function var_0_0.CheckClickBtnAni(arg_29_0, arg_29_1)
	local var_29_0
	local var_29_1

	if arg_29_0.index_ == 1 then
		var_29_1 = arg_29_0.normalAni_[arg_29_1]
		var_29_0 = arg_29_0.normalAni_[arg_29_0.selectLevel_]
	elseif arg_29_0.index_ == 2 then
		var_29_1 = arg_29_0.challengeAni_[arg_29_1]
		var_29_0 = arg_29_0.challengeAni_[arg_29_0.selectLevel_]
	else
		var_29_1 = arg_29_0.hardAni_[arg_29_1]
		var_29_0 = arg_29_0.hardAni_[arg_29_0.selectLevel_]
	end

	if var_29_0 then
		local var_29_2 = ActivityPt2Tools.GetBtnDisappearAnimation(arg_29_0.params_.mainActivityId)

		if var_29_2 ~= "" then
			var_29_0:Play(var_29_2, -1, 0)
		end
	end

	if var_29_1 then
		local var_29_3 = ActivityPt2Tools.GetBtnAppearAnimation(arg_29_0.params_.mainActivityId)

		if var_29_3 ~= "" then
			var_29_1:Play(var_29_3, -1, 0)
		end
	end
end

function var_0_0.BlankAni(arg_30_0)
	local var_30_0

	if arg_30_0.index_ == 1 then
		var_30_0 = arg_30_0.normalAni_[arg_30_0.selectLevel_]
	elseif arg_30_0.index_ == 2 then
		var_30_0 = arg_30_0.challengeAni_[arg_30_0.selectLevel_]
	else
		var_30_0 = arg_30_0.hardAni_[arg_30_0.selectLevel_]
	end

	if var_30_0 then
		local var_30_1 = ActivityPt2Tools.GetBtnDisappearAnimation(arg_30_0.params_.mainActivityId)

		if var_30_1 ~= "" then
			var_30_0:Play(var_30_1, -1, 0)
		end
	end
end

function var_0_0.IsLockEx(arg_31_0)
	local var_31_0 = ActivityCfg[arg_31_0.activityID_].sub_activity_list[3]
	local var_31_1 = ActivityPt2Cfg.get_id_list_by_activity_id[var_31_0][1]
	local var_31_2 = ActivityPt2Cfg[var_31_1].pre_stage
	local var_31_3 = ActivityCfg[arg_31_0.params_.mainActivityId].sub_activity_list
	local var_31_4 = ActivityPt2Data:GetChallengeData(var_31_3[2], var_31_2)
	local var_31_5 = ActivityPt2Cfg[var_31_2]

	if not var_31_4 or var_31_4.clear_time <= 0 then
		return true
	end

	return var_31_4.use_time > var_31_5.time
end

function var_0_0.IsOpenSectionView(arg_32_0)
	return arg_32_0:IsOpenRoute("activityPt2SectionInfo")
end

function var_0_0.RefreshShop(arg_33_0)
	local var_33_0 = ActivityShopCfg[arg_33_0.params_.mainActivityId].shop_id

	arg_33_0.shopName_.text = ShopListCfg[var_33_0].remark
end

function var_0_0.OnTop(arg_34_0)
	local var_34_0 = ActivityPt2Tools.GetHelpKey(arg_34_0.activityID_)
	local var_34_1 = ActivityPt2Tools.GetChallengeCurrencyID(arg_34_0.activityID_)

	if var_34_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_34_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetGameHelpKey(var_34_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_34_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(var_34_1, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.OnExit(arg_35_0)
	arg_35_0:StopTimer()
	manager.windowBar:HideBar()
	arg_35_0.indexCon_:SetSelectedState(-1)
end

function var_0_0.Dispose(arg_36_0)
	arg_36_0:RemoveAllListeners()
	arg_36_0.super.Dispose(arg_36_0)
end

return var_0_0
