local var_0_0 = class("GuildActivityAffixMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivitytalentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.selectRaceItemHandler_ = handler(arg_4_0, arg_4_0.OnSelectRaceItem)
	arg_4_0.selectAffixItemHandler_ = handler(arg_4_0, arg_4_0.OnSelectAffixItem)
	arg_4_0.raceItemList_ = {}
	arg_4_0.affixItemList_ = {}
	arg_4_0.affixInfoItemList_ = {}

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.selectController_ = ControllerUtil.GetController(arg_5_0.racePanelTrans_, "select")
	arg_5_0.upgeadeStateController_ = ControllerUtil.GetController(arg_5_0.transform_, "upgradeState")

	local var_5_0 = arg_5_0.racePanelTrans_.childCount

	for iter_5_0 = 1, var_5_0 do
		arg_5_0.raceItemList_[iter_5_0] = GuildActivityAffixRaceItem.New(arg_5_0.racePanelTrans_:GetChild(iter_5_0 - 1))

		arg_5_0.raceItemList_[iter_5_0]:SetSelectCallBack(arg_5_0.selectRaceItemHandler_)
	end

	local var_5_1 = arg_5_0.affixPanelTrans_.childCount

	for iter_5_1 = 1, var_5_1 do
		arg_5_0.affixItemList_[iter_5_1] = GuildActivityAffixItem.New(arg_5_0.affixPanelTrans_:GetChild(iter_5_1 - 1))

		arg_5_0.affixItemList_[iter_5_1]:SetSelectCallBack(arg_5_0.selectAffixItemHandler_)
	end

	local var_5_2 = arg_5_0.affixInfoPanelTrans_.childCount

	for iter_5_2 = 1, var_5_2 do
		arg_5_0.affixInfoItemList_[iter_5_2] = GuildActivityAffixInfoItem.New(arg_5_0.affixInfoPanelTrans_:GetChild(iter_5_2 - 1))
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.upgradeBtn_, nil, function()
		if arg_6_0.isMaxLevel_ == true then
			return
		end

		if arg_6_0.costEnough_ == false then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		GuildActivityAction.UpgradeAffix(arg_6_0.curAffixID_, function(arg_8_0, arg_8_1)
			if isSuccess(arg_8_0.result) then
				GuildActivityData:UpgradeAffix(arg_6_0.activityID_, arg_6_0.curAffixID_)
				arg_6_0:RefreshAffixItem()

				for iter_8_0, iter_8_1 in ipairs(arg_6_0.affixInfoItemList_) do
					if arg_6_0.curAffixLevel_ == iter_8_0 then
						iter_8_1:OnUpgrade()

						break
					end
				end
			else
				ShowTips(GetTips(arg_8_0.result))
			end
		end)
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:InitBar()
	arg_10_0:AddEventListeners()

	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.raceIDList_ = RaceEffectCfg.all

	arg_10_0:RefreshUI()
	arg_10_0:BindRedPoint()
end

function var_0_0.InitBar(arg_11_0)
	local var_11_0 = TalentTreeCfg.get_id_list_by_activity_id[arg_11_0.params_.activityID][1]

	arg_11_0.currencyID_ = TalentTreeCfg[var_11_0].cost[1][1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		arg_11_0.currencyID_
	})
	manager.windowBar:SetBarCanAdd(arg_11_0.currencyID_, true)
	manager.windowBar:SetGameHelpKey("CLUB_ACTIVITY_AFFIX_DESC")
end

function var_0_0.OnTop(arg_12_0)
	local var_12_0, var_12_1 = GuildActivityData:CheckRateUpgrade(arg_12_0.activityID_)

	if var_12_0 == true then
		JumpTools.OpenPageByJump("guildActivityRateUpgrad", {
			rateID = var_12_1
		})
		GuildActivityData:RefreshRateRedPoint(arg_12_0.params_.activityID)
	end
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	arg_13_0:UnBindRedPoint()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.affixInfoItemList_) do
		iter_13_1:OnExit()
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.selectRaceItemHandler_ = nil
	arg_14_0.selectAffixItemHandler_ = nil

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.raceItemList_) do
		iter_14_1:Dispose()
	end

	arg_14_0.raceItemList_ = nil

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.affixItemList_) do
		iter_14_3:Dispose()
	end

	arg_14_0.affixItemList_ = nil

	for iter_14_4, iter_14_5 in ipairs(arg_14_0.affixInfoItemList_) do
		iter_14_5:Dispose()
	end

	arg_14_0.affixInfoItemList_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshRaceItem()
end

function var_0_0.RefreshRaceItem(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.raceIDList_) do
		if arg_16_0.raceItemList_[iter_16_0] then
			arg_16_0.raceItemList_[iter_16_0]:SetData(iter_16_1)
			arg_16_0.raceItemList_[iter_16_0]:SetActive(true)
		end
	end

	for iter_16_2 = #arg_16_0.raceItemList_, #arg_16_0.raceIDList_ + 1, -1 do
		arg_16_0.raceItemList_[iter_16_2]:SetActive(false)
	end

	arg_16_0.curRaceID_ = GuildActivityData:GetSelectRaceID(arg_16_0.activityID_) or arg_16_0.raceIDList_[1]

	arg_16_0:OnSelectRaceItem(arg_16_0.curRaceID_)
end

function var_0_0.OnSelectRaceItem(arg_17_0, arg_17_1)
	GuildActivityData:SetSelectRaceID(arg_17_0.activityID_, arg_17_1)

	arg_17_0.curRaceID_ = arg_17_1

	arg_17_0.selectController_:SetSelectedState(tostring(arg_17_0.curRaceID_))
	arg_17_0:RefreshAffixItem()
end

function var_0_0.RefreshAffixItem(arg_18_0)
	arg_18_0.affixIDList_ = TalentTreeCfg.get_id_list_by_activity_id_and_race[arg_18_0.activityID_][arg_18_0.curRaceID_]
	arg_18_0.unlockAffixIDList_ = GuildActivityData:GetUnLockAffixList()

	local var_18_0
	local var_18_1
	local var_18_2

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.affixIDList_) do
		if arg_18_0.affixItemList_[iter_18_0] then
			local var_18_3 = arg_18_0.unlockAffixIDList_[iter_18_1]
			local var_18_4 = var_18_3 ~= nil
			local var_18_5 = var_18_3 and var_18_3.level or 0

			arg_18_0.affixItemList_[iter_18_0]:SetData(iter_18_1, var_18_4, var_18_5)
			arg_18_0.affixItemList_[iter_18_0]:SetActive(true)
		end
	end

	for iter_18_2 = #arg_18_0.affixItemList_, #arg_18_0.affixIDList_ + 1, -1 do
		arg_18_0.affixItemList_[iter_18_2]:SetActive(false)
	end

	local var_18_6 = GuildActivityData:GetSelectAffixID(arg_18_0.activityID_, arg_18_0.curRaceID_)

	arg_18_0.curAffixID_ = GuildActivityData:GetSelectAffixID(arg_18_0.activityID_, arg_18_0.curRaceID_) or arg_18_0.affixIDList_[1]

	local var_18_7 = arg_18_0.unlockAffixIDList_[arg_18_0.curAffixID_]

	arg_18_0.curAffixLevel_ = var_18_7 and var_18_7.level or 0

	arg_18_0:OnSelectAffixItem(arg_18_0.curAffixID_, arg_18_0.curAffixLevel_)
end

function var_0_0.OnSelectAffixItem(arg_19_0, arg_19_1, arg_19_2)
	GuildActivityData:SetSelectAffixID(arg_19_0.activityID_, arg_19_0.curRaceID_, arg_19_1)

	arg_19_0.curAffixID_ = arg_19_1
	arg_19_0.curAffixLevel_ = arg_19_2

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.affixItemList_) do
		iter_19_1:SetSelect(arg_19_1)
	end

	arg_19_0:RefershAffixInfo()
	arg_19_0:RefreshUpgradeBtn()
end

function var_0_0.RefershAffixInfo(arg_20_0)
	local var_20_0 = TalentTreeCfg[arg_20_0.curAffixID_].affix_id

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.affixInfoItemList_) do
		iter_20_1:SetData(var_20_0, iter_20_0, arg_20_0.curAffixLevel_)
	end

	arg_20_0.titleText_.text = GetI18NText(TalentTreeCfg[arg_20_0.curAffixID_].name)
	arg_20_0.descText_.text = GetI18NText(TalentTreeCfg[arg_20_0.curAffixID_].desc)
end

function var_0_0.RefreshUpgradeBtn(arg_21_0)
	local var_21_0 = TalentTreeCfg[arg_21_0.curAffixID_].cost[arg_21_0.curAffixLevel_ + 1]

	if var_21_0 ~= nil then
		arg_21_0.isMaxLevel_ = false

		SetActive(arg_21_0.consumePanelGo_, true)

		arg_21_0.currencyID_ = var_21_0[1]
		arg_21_0.upgradeCost_ = var_21_0[2]

		local var_21_1 = ItemTools.getItemNum(arg_21_0.currencyID_) or 0

		arg_21_0.costEnough_ = arg_21_0.upgradeCost_ ~= nil and var_21_1 >= arg_21_0.upgradeCost_
		arg_21_0.consumeIcon_.sprite = ItemTools.getItemSprite(arg_21_0.currencyID_)

		if arg_21_0.costEnough_ == true then
			arg_21_0.consumeNumText_.text = arg_21_0.upgradeCost_
		else
			arg_21_0.consumeNumText_.text = "<color='#FF0000'>" .. arg_21_0.upgradeCost_ .. "</color>"
		end
	else
		arg_21_0.isMaxLevel_ = true

		SetActive(arg_21_0.consumePanelGo_, false)
	end

	if arg_21_0.costEnough_ == true and arg_21_0.isMaxLevel_ == false then
		arg_21_0.upgeadeStateController_:SetSelectedState("true")
	else
		arg_21_0.upgeadeStateController_:SetSelectedState("false")
	end
end

function var_0_0.BindRedPoint(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.raceItemList_) do
		iter_22_1:BindRedPoint(arg_22_0.activityID_)
	end
end

function var_0_0.UnBindRedPoint(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.raceItemList_) do
		iter_23_1:UnBindRedPoint(arg_23_0.activityID_)
	end
end

return var_0_0
