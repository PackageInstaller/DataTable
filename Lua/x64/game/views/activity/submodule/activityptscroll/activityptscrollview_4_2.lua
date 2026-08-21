local var_0_0 = class("ActivityPtScrollView_4_2", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityPtScrollTools.GetMainUIName(arg_1_0.params_.mainActivityID)
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
	arg_4_0.normalCon_ = {}
	arg_4_0.challengeCon_ = {}
	arg_4_0.normalselectCon_ = {}
	arg_4_0.challengeselectCon_ = {}
	arg_4_0.normalLevel_ = {}
	arg_4_0.challengeLevel_ = {}

	local var_4_0 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_4_0.params_.mainActivityID]

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if ActivityPtRouletteStageCfg[iter_4_1].mode == 1 then
			table.insert(arg_4_0.normalLevel_, ActivityPtRouletteStageCfg[iter_4_1].stage_id)
		else
			table.insert(arg_4_0.challengeLevel_, ActivityPtRouletteStageCfg[iter_4_1].stage_id)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.normalLevel_) do
		table.insert(arg_4_0.normalBtn_, arg_4_0["normalBtn_" .. iter_4_2])
		table.insert(arg_4_0.normalCon_, arg_4_0["normalBtn_" .. iter_4_2].transform:GetComponent("ControllerExCollection"):GetController("status"))
		table.insert(arg_4_0.normalselectCon_, arg_4_0["normalBtn_" .. iter_4_2].transform:GetComponent("ControllerExCollection"):GetController("select"))
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_0.challengeLevel_) do
		table.insert(arg_4_0.challengeBtn_, arg_4_0["challengeBtn_" .. iter_4_4])
		table.insert(arg_4_0.challengeCon_, arg_4_0["challengeBtn_" .. iter_4_4].transform:GetComponent("ControllerExCollection"):GetController("status"))
		table.insert(arg_4_0.challengeselectCon_, arg_4_0["challengeBtn_" .. iter_4_4].transform:GetComponent("ControllerExCollection"):GetController("select"))
	end

	arg_4_0.tgl_ = {
		arg_4_0.tgl_1,
		arg_4_0.tgl_2
	}
	arg_4_0.typeCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "type")
	arg_4_0.indexCon_ = arg_4_0.transform_:GetComponent("ControllerExCollection"):GetController("index")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0:ResetSelect()
		end

		local var_6_0 = ActivityPtScrollTools.GetShopActivityID(arg_5_0.mainActivityID_)
		local var_6_1 = ActivityShopCfg[var_6_0]
		local var_6_2 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_1.activity_theme]) do
			local var_6_3 = ActivityShopCfg[iter_6_1].shop_id
			local var_6_4 = ActivityData:GetActivityData(ShopListCfg[var_6_3].activity_id)

			if var_6_4 and var_6_4:IsActivitying() then
				table.insert(var_6_2, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_5, var_6_6 = ShopTools.IsShopOpen(var_6_1.shop_id)

		if var_6_5 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_1.shop_id,
				showShops = var_6_2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_6 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_6 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPtScrollPop", {
			isScroll = false,
			mainActivityID = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.affixBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPtScrollAffixSelect", {
			mainActivityID = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0:ResetSelect()
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tgl_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_10_0)
			if arg_10_0 then
				if arg_5_0:IsOpenSectionView() then
					arg_5_0.tgl_[arg_5_0.index_].isOn = true

					return
				end

				if iter_5_0 ~= arg_5_0.index_ then
					arg_5_0.index_ = iter_5_0
				end

				if arg_5_0.index_ == 2 then
					arg_5_0:CheckScroll()
				end

				arg_5_0.indexCon_:SetSelectedState(0)
				arg_5_0.typeCon_:SetSelectedState(iter_5_0)

				for iter_10_0, iter_10_1 in ipairs(arg_5_0.normalLevel_) do
					arg_5_0.normalselectCon_[iter_10_0]:SetSelectedIndex(0)
				end

				for iter_10_2, iter_10_3 in ipairs(arg_5_0.challengeLevel_) do
					arg_5_0.challengeselectCon_[iter_10_2]:SetSelectedIndex(0)
				end

				ActivityPtScrollData:SetLastStage(arg_5_0.mainActivityID_, iter_5_0, 1)
			end
		end)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.normalBtn_) do
		arg_5_0:AddBtnListener(iter_5_3, nil, function()
			if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
				ShowTips("TIME_OVER")

				return
			end

			arg_5_0:EnterLevel(1, iter_5_2)
		end)
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.challengeBtn_) do
		arg_5_0:AddBtnListener(iter_5_5, nil, function()
			if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
				ShowTips("TIME_OVER")

				return
			end

			arg_5_0:EnterLevel(2, iter_5_4)
		end)
	end

	if arg_5_0.eventTrigger_ then
		arg_5_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
			if arg_5_0:IsOpenSectionView() then
				JumpTools.Back()
			end

			arg_5_0.drag_ = true
		end))
		arg_5_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
			arg_5_0.drag_ = false
		end))
	end
end

function var_0_0.OnEnter(arg_15_0)
	if arg_15_0.mainActivityID_ and arg_15_0.mainActivityID_ ~= arg_15_0.params_.mainActivityID then
		arg_15_0.mainActivityID_ = arg_15_0.params_.mainActivityID

		arg_15_0:ReLoad()
	end

	arg_15_0:RefreshUI()
end

function var_0_0.ReLoad(arg_16_0)
	if arg_16_0.gameObject_ then
		arg_16_0:Dispose()
		Object.Destroy(arg_16_0.gameObject_)
	end

	local var_16_0 = Asset.Load(arg_16_0:UIName())

	arg_16_0.gameObject_ = Object.Instantiate(var_16_0, arg_16_0:UIParent())
	arg_16_0.transform_ = arg_16_0.gameObject_.transform

	arg_16_0:Init()
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0:RefreshData()
	arg_17_0:RefreshTime()
	arg_17_0:RefreshState()
	arg_17_0:BindRedPointUI()
end

function var_0_0.RefreshData(arg_18_0)
	arg_18_0.mainActivityID_ = arg_18_0.params_.mainActivityID
	arg_18_0.activityID_ = ActivityPtScrollTools.GetLevelActivityID(arg_18_0.mainActivityID_)
	arg_18_0.activityData_ = ActivityData:GetActivityData(arg_18_0.activityID_)
	arg_18_0.startTime_ = arg_18_0.activityData_.startTime
	arg_18_0.stopTime_ = arg_18_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_19_0)
	local var_19_0 = ActivityData:GetActivityData(arg_19_0.mainActivityID_).stopTime
	local var_19_1 = manager.time:GetServerTime()

	arg_19_0:StopTimer()

	if var_19_1 < arg_19_0.startTime_ then
		SetActive(arg_19_0.shopTimeGo_, false)

		arg_19_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_19_0.timer_ = Timer.New(function()
			if arg_19_0.startTime_ <= manager.time:GetServerTime() then
				arg_19_0:StopTimer()
				arg_19_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_19_0.timer_:Start()
	elseif var_19_1 < var_19_0 then
		if var_19_1 < arg_19_0.stopTime_ then
			arg_19_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_19_0.stopTime_)
		else
			arg_19_0.timeLable_.text = GetTips("TIME_OVER")
		end

		if GameSetting.time_remaining_show.value[1] * 86400 > var_19_0 - var_19_1 then
			arg_19_0.shopTimeLable_.text = manager.time:GetLostTimeStr2(var_19_0, nil, false)

			SetActive(arg_19_0.shopTimeGo_, true)
		else
			SetActive(arg_19_0.shopTimeGo_, false)
		end

		arg_19_0.timer_ = Timer.New(function()
			var_19_1 = manager.time:GetServerTime()

			if var_19_0 <= var_19_1 then
				arg_19_0:StopTimer()
				arg_19_0:RefreshTime()

				return
			end

			if var_19_1 < arg_19_0.stopTime_ then
				arg_19_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_19_0.stopTime_)
			else
				arg_19_0.timeLable_.text = GetTips("TIME_OVER")
			end

			if GameSetting.time_remaining_show.value[1] * 86400 > var_19_0 - var_19_1 then
				arg_19_0.shopTimeLable_.text = manager.time:GetLostTimeStr2(var_19_0, nil, false)

				SetActive(arg_19_0.shopTimeGo_, true)
			else
				SetActive(arg_19_0.shopTimeGo_, false)
			end
		end, 1, -1)

		arg_19_0.timer_:Start()
	else
		SetActive(arg_19_0.shopTimeGo_, true)

		arg_19_0.timeLable_.text = GetTips("TIME_OVER")
		arg_19_0.shopTimeLable_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end
end

function var_0_0.RefreshState(arg_23_0)
	arg_23_0:RefreshLevel()
	arg_23_0:RefreshReward()
	arg_23_0:RefreshBuff()
	arg_23_0:RefreshServant()
end

function var_0_0.RefreshLevel(arg_24_0)
	local var_24_0 = ActivityPtScrollData:GetLastStage(arg_24_0.mainActivityID_)

	arg_24_0.index_ = var_24_0 and var_24_0.type or 1

	arg_24_0.typeCon_:SetSelectedState(arg_24_0.index_)

	arg_24_0.tgl_[arg_24_0.index_].isOn = true
	arg_24_0.selectLevel_ = 0

	if arg_24_0:IsOpenSectionView() and var_24_0 then
		local var_24_1 = var_24_0.type
		local var_24_2 = var_24_0.index

		arg_24_0.selectLevel_ = var_24_2

		ActivityPtScrollData:SetLastStage(arg_24_0.mainActivityID_, var_24_1, var_24_2)
		arg_24_0.indexCon_:SetSelectedState(var_24_0.type .. "_" .. var_24_0.index)

		if var_24_0.type == 1 then
			for iter_24_0, iter_24_1 in ipairs(arg_24_0.normalLevel_) do
				arg_24_0.normalselectCon_[iter_24_0]:SetSelectedIndex(iter_24_0 == var_24_0.index and 1 or 0)
			end
		else
			for iter_24_2, iter_24_3 in ipairs(arg_24_0.challengeLevel_) do
				arg_24_0.challengeselectCon_[iter_24_2]:SetSelectedIndex(iter_24_2 == var_24_0.index and 1 or 0)
			end
		end
	else
		arg_24_0.indexCon_:SetSelectedState(0)

		for iter_24_4, iter_24_5 in ipairs(arg_24_0.normalLevel_) do
			arg_24_0.normalselectCon_[iter_24_4]:SetSelectedIndex(0)
		end

		for iter_24_6, iter_24_7 in ipairs(arg_24_0.challengeLevel_) do
			arg_24_0.challengeselectCon_[iter_24_6]:SetSelectedIndex(0)
		end
	end

	if arg_24_0.index_ == 2 then
		arg_24_0:CheckScroll()
	end
end

function var_0_0.RefreshReward(arg_25_0)
	local var_25_0 = ActivityPtScrollData:GetClearList(arg_25_0.mainActivityID_)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.normalLevel_) do
		if table.indexof(var_25_0, iter_25_1) then
			arg_25_0.normalCon_[iter_25_0]:SetSelectedState("get")
		else
			arg_25_0.normalCon_[iter_25_0]:SetSelectedState("nor")
		end
	end

	for iter_25_2, iter_25_3 in ipairs(arg_25_0.challengeLevel_) do
		if table.indexof(var_25_0, iter_25_3) then
			arg_25_0.challengeCon_[iter_25_2]:SetSelectedState("get")
		else
			arg_25_0.challengeCon_[iter_25_2]:SetSelectedState("nor")
		end
	end
end

function var_0_0.RefreshBuff(arg_26_0)
	local var_26_0 = ActivityPtScrollData:GetChooseAffixID(arg_26_0.mainActivityID_)
	local var_26_1 = ActivityPtScrollData:GetAffixInfo(arg_26_0.mainActivityID_, var_26_0)

	if var_26_1.useless then
		local var_26_2 = ActivityPtRouletteTipsCfg[var_26_1.affix]

		arg_26_0.buffIcon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. var_26_2.icon)
		arg_26_0.buffText_.text = var_26_2.desc
	else
		arg_26_0.buffIcon_.sprite = getAffixSprite({
			var_26_1.affix
		})
		arg_26_0.buffText_.text = getAffixDesc({
			var_26_1.affix,
			var_26_1.level
		})
	end
end

function var_0_0.RefreshServant(arg_27_0)
	local var_27_0, var_27_1 = ActivityPtScrollData:GetUpSelect(arg_27_0.mainActivityID_)
	local var_27_2 = EquipSuitCfg[var_27_1]

	if var_27_2 then
		arg_27_0.keyText_.text = var_27_2.name

		SetSpriteWithoutAtlasAsync(arg_27_0.keyIcon_, SpritePathCfg.EquipIcon_s.path .. var_27_1)
	end
end

function var_0_0.CheckScroll(arg_28_0)
	if (getData("activityPtScroll", "last_scroll_time") or 0) < manager.time:GetTodayFreshTime() then
		JumpTools.OpenPageByJump("activityPtScrollPop", {
			isScroll = true,
			mainActivityID = arg_28_0.mainActivityID_
		})

		local var_28_0 = manager.time:GetServerTime()

		saveData("activityPtScroll", "last_scroll_time", var_28_0)
	end
end

function var_0_0.EnterLevel(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.selectLevel_ = arg_29_2

	ActivityPtScrollData:SetLastStage(arg_29_0.mainActivityID_, arg_29_1, arg_29_2)
	arg_29_0.indexCon_:SetSelectedState(arg_29_1 .. "_" .. arg_29_2)

	if arg_29_1 == 1 then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0.normalLevel_) do
			arg_29_0.normalselectCon_[iter_29_0]:SetSelectedIndex(iter_29_0 == arg_29_2 and 1 or 0)
		end
	else
		for iter_29_2, iter_29_3 in ipairs(arg_29_0.challengeLevel_) do
			arg_29_0.challengeselectCon_[iter_29_2]:SetSelectedIndex(iter_29_2 == arg_29_2 and 1 or 0)
		end
	end

	local var_29_0 = arg_29_1 == 1 and arg_29_0.normalLevel_[arg_29_2] or arg_29_0.challengeLevel_[arg_29_2]

	JumpTools.OpenPageByJump("activityPtScrollSectionInfo", {
		section = var_29_0,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL,
		mainActivityID = arg_29_0.mainActivityID_,
		activityId = arg_29_0.mainActivityID_,
		backCall = handler(arg_29_0, arg_29_0.ResetSelect)
	})
end

function var_0_0.ResetSelect(arg_30_0)
	arg_30_0.indexCon_:SetSelectedState(0)

	arg_30_0.selectLevel_ = 0

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.normalLevel_) do
		arg_30_0.normalselectCon_[iter_30_0]:SetSelectedIndex(0)
	end

	for iter_30_2, iter_30_3 in ipairs(arg_30_0.challengeLevel_) do
		arg_30_0.challengeselectCon_[iter_30_2]:SetSelectedIndex(0)
	end
end

function var_0_0.IsOpenSectionView(arg_31_0)
	return arg_31_0:IsOpenRoute("activityPtScrollSectionInfo")
end

function var_0_0.OnSetSelectSuit(arg_32_0)
	arg_32_0:RefreshServant()
end

function var_0_0.RefreshShop(arg_33_0)
	local var_33_0 = ActivityPtScrollTools.GetShopActivityID(arg_33_0.params_.mainActivityID)
	local var_33_1 = ActivityShopCfg[var_33_0].shop_id

	arg_33_0.shopName_.text = ShopListCfg[var_33_1].remark
end

function var_0_0.BindRedPointUI(arg_34_0)
	manager.redPoint:bindUIandKey(arg_34_0.upRect_, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_34_0.mainActivityID_)
	manager.redPoint:bindUIandKey(arg_34_0.tgl_2.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_34_0.mainActivityID_)
end

function var_0_0.UnbindRedPointUI(arg_35_0)
	manager.redPoint:unbindUIandKey(arg_35_0.upRect_, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_35_0.mainActivityID_)
	manager.redPoint:unbindUIandKey(arg_35_0.tgl_2.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_35_0.mainActivityID_)
end

function var_0_0.OnTop(arg_36_0)
	local var_36_0 = ActivityPtScrollTools.GetHelpKey(arg_36_0.mainActivityID_)
	local var_36_1 = ActivityPtScrollTools.GetChallengeCurrencyID(arg_36_0.mainActivityID_)

	if var_36_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_36_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetGameHelpKey(var_36_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_36_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(var_36_1, true)
end

function var_0_0.OnExit(arg_37_0)
	arg_37_0:StopTimer()
	arg_37_0:UnbindRedPointUI()
	manager.windowBar:HideBar()
	arg_37_0.indexCon_:SetSelectedState(-1)
end

function var_0_0.Dispose(arg_38_0)
	arg_38_0:RemoveAllListeners()
	arg_38_0.super.Dispose(arg_38_0)
end

return var_0_0
