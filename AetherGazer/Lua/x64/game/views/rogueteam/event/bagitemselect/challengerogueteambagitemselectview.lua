local var_0_0 = class("ChallengeRogueTeamBagItemSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeDiscardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, ChallengeRogueTeamBagItemSelectItem)
	arg_3_0.tabItemList_ = {}
	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureBtnGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.onSelectItemHandler_ = handler(arg_3_0, arg_3_0.OnSelectItem)
	arg_3_0.OnSelectTabHandler_ = handler(arg_3_0, arg_3_0.OnSelectTab)
	arg_3_0.itemInfoView_ = ChallengeRogueTeamCommonItemView.New(arg_3_0.itemInfoGo_)
	arg_3_0.typeController_ = arg_3_0.controllerEx_:GetController("Discard")
	arg_3_0.emptyController_ = arg_3_0.controllerEx_:GetController("empty")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	ChallengeRogueTeamTools.ShowBarList()

	arg_4_0.effectID_ = ChallengeRogueTeamData:GetUnOperateData().paramList.effectID

	if RogueTeamEffectCfg[arg_4_0.effectID_].action == ChallengeRogueTeamConst.EFFECT_ACTION.DISCARD_TREASURE then
		arg_4_0.itemType_ = ChallengeRogueTeamConst.ITEM_TYPE.TREASURE
	else
		arg_4_0.itemType_ = ChallengeRogueTeamConst.ITEM_TYPE.RELIC
	end

	arg_4_0.campId_ = 0
	arg_4_0.tabIndex_ = 1

	arg_4_0:InitItemData()
	arg_4_0.uiList_:StartScroll(#arg_4_0.itemDataList_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECTED_ITEM, arg_4_0.onSelectItemHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_DISCARD_SUIT_SKILL, arg_4_0.OnSelectTabHandler_)
	arg_4_0:RefreshItemInfo(0)
	arg_4_0:RefreshBtn()
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECTED_ITEM, arg_5_0.onSelectItemHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_DISCARD_SUIT_SKILL, arg_5_0.OnSelectTabHandler_)
	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()

	arg_5_0.selectItemList_ = {}
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.itemInfoView_:Dispose()

	arg_6_0.itemInfoView_ = nil
	arg_6_0.onSelectItemHandler_ = nil
	arg_6_0.OnSelectTabHandler_ = nil

	arg_6_0.rogueTeamSureBtnView_:Dispose()

	arg_6_0.rogueTeamSureBtnView_ = nil

	arg_6_0.uiList_:Dispose()

	arg_6_0.uiList_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.tabItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.tabItemList_ = nil
	arg_6_0.itemDataList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.itemDataList_[arg_8_1]

	arg_8_2:SetData(var_8_0, arg_8_1)
end

function var_0_0.RefreshTabList(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.campList_) do
		if arg_9_0.tabItemList_[iter_9_0] == nil then
			arg_9_0.tabItemList_[iter_9_0] = ChallengeRogueTeamSuitSkillTabItem.New(arg_9_0.tabItem_, arg_9_0.tabParent_, iter_9_0)
		end

		arg_9_0.tabItemList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #arg_9_0.campList_ + 1, #arg_9_0.tabItemList_ do
		arg_9_0.tabItemList_[iter_9_2]:Show(false)
	end
end

function var_0_0.OnSelectTab(arg_10_0, arg_10_1)
	if arg_10_0.tabIndex_ == arg_10_1 then
		return
	end

	arg_10_0.tabIndex_ = arg_10_1

	arg_10_0:RefreshSelectTabItem()

	local var_10_0 = arg_10_0.treasureDataList_[arg_10_0.campList_[arg_10_1]] or {}

	arg_10_0.itemDataList_ = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = {
			id = iter_10_1.id,
			rare = iter_10_1.rare,
			isSelect = table.keyof(arg_10_0.selectItemList_, iter_10_1.id) ~= nil
		}

		arg_10_0.itemDataList_[iter_10_0] = var_10_1
	end

	arg_10_0.uiList_:StartScroll(#arg_10_0.itemDataList_)
end

function var_0_0.RefreshSelectTabItem(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.tabItemList_) do
		iter_11_1:RefreshSelect(arg_11_0.campList_[arg_11_0.tabIndex_])
	end
end

function var_0_0.InitItemData(arg_12_0)
	local var_12_0 = ChallengeRogueTeamData:GetUnOperateData()

	arg_12_0.canSelectCnt_ = var_12_0.paramList.canSelectCnt
	arg_12_0.selectItemList_ = {}
	arg_12_0.itemDataList_ = {}

	local var_12_1 = arg_12_0.itemType_
	local var_12_2
	local var_12_3 = RogueTeamEffectCfg[var_12_0.paramList.effectID]

	if var_12_1 == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		arg_12_0.typeController_:SetSelectedState("Treasure")

		local var_12_4 = ChallengeRogueTeamTools.FilterTreasure(var_12_3.params)

		arg_12_0.treasureDataList_ = ChallengeRogueTeamTools.TreasureGroup(var_12_4)

		local var_12_5, var_12_6 = ChallengeRogueTeamTools:GetAllSuitSkillIDList()

		arg_12_0.campList_ = var_12_6

		arg_12_0:RefreshTabList()

		var_12_2 = arg_12_0.treasureDataList_[arg_12_0.campList_[arg_12_0.tabIndex_]]

		local var_12_7 = GetTips("ROGUE_TEAM_TREASURE_NAME")

		arg_12_0.titleText1_.text = string.format(GetTips("ROGUE_TEAM_DISCARD_ITEM_WF"), var_12_7)
		arg_12_0.titleText2_.text = string.format(GetTips("ROGUE_TEAM_SELECT_ITEM"), arg_12_0.canSelectCnt_, var_12_7)

		arg_12_0:RefreshSelectTabItem()
	else
		var_12_2 = ChallengeRogueTeamTools.FilterRelic(var_12_3.params)

		arg_12_0.typeController_:SetSelectedState("Relic")

		local var_12_8 = GetTips("ROGUE_TEAM_RELIC_NAME")

		arg_12_0.titleText1_.text = string.format(GetTips("ROGUE_TEAM_DISCARD_ITEM_WF"), var_12_8)
		arg_12_0.titleText2_.text = string.format(GetTips("ROGUE_TEAM_SELECT_ITEM"), arg_12_0.canSelectCnt_, var_12_8)
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_9 = var_12_2[iter_12_0]
		local var_12_10 = {
			id = var_12_9.id,
			rare = var_12_9.rare
		}

		var_12_10.isSelect = false
		arg_12_0.itemDataList_[iter_12_0] = var_12_10
	end
end

function var_0_0.GetItemIndex(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.itemDataList_) do
		if iter_13_1.id == arg_13_1 then
			return iter_13_0
		end
	end

	return 0
end

function var_0_0.OnSelectItem(arg_14_0, arg_14_1)
	local var_14_0 = table.keyof(arg_14_0.selectItemList_, arg_14_1.id)

	if not var_14_0 then
		local var_14_1 = arg_14_0:GetItemIndex(arg_14_1.id)

		arg_14_0.itemDataList_[var_14_1].isSelect = true

		arg_14_0:RefreshItemInfo(var_14_1)
		table.insert(arg_14_0.selectItemList_, arg_14_1.id)

		for iter_14_0 = #arg_14_0.selectItemList_, arg_14_0.canSelectCnt_ + 1, -1 do
			local var_14_2 = arg_14_0:GetItemIndex(arg_14_0.selectItemList_[1])

			if var_14_2 ~= 0 then
				arg_14_0.itemDataList_[var_14_2].isSelect = false
			end

			table.remove(arg_14_0.selectItemList_, 1)
		end
	else
		arg_14_0:RefreshItemInfo(0)

		local var_14_3 = arg_14_0:GetItemIndex(arg_14_0.selectItemList_[#arg_14_0.selectItemList_])

		if var_14_3 ~= 0 then
			arg_14_0.itemDataList_[var_14_3].isSelect = false
		end

		table.remove(arg_14_0.selectItemList_, var_14_0)
	end

	arg_14_0:RefreshBtn()
	arg_14_0.uiList_:Refresh()
end

function var_0_0.RefreshBtn(arg_15_0)
	if #arg_15_0.selectItemList_ >= arg_15_0.canSelectCnt_ then
		arg_15_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	else
		arg_15_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
	end
end

function var_0_0.RefreshItemInfo(arg_16_0, arg_16_1)
	if arg_16_1 == 0 then
		arg_16_0.emptyController_:SetSelectedState("true")
	else
		local var_16_0 = clone(ChallengeRogueTeamCommonItemData)
		local var_16_1 = arg_16_0.itemDataList_[arg_16_1]

		var_16_0.id = var_16_1.id
		var_16_0.rare = var_16_1.rare
		var_16_0.descRaycastFlag = true

		arg_16_0.itemInfoView_:SetData(var_16_0)
		arg_16_0.emptyController_:SetSelectedState("false")
	end
end

function var_0_0.OnClickBtn(arg_17_0)
	local var_17_0 = arg_17_0:GetItemMaxCnt()

	if (var_17_0 < arg_17_0.canSelectCnt_ and var_17_0 or arg_17_0.canSelectCnt_) > #arg_17_0.selectItemList_ then
		return
	end

	ChallengeRogueTeamAction.RemoveSelectedItem(arg_17_0.selectItemList_, function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()

		if #arg_17_0.selectItemList_ > 0 then
			ChallengeRogueTeamData:UISetEventPause(true)
		end

		arg_17_0:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
	end)
end

function var_0_0.GetItemMaxCnt(arg_19_0)
	local var_19_0 = ChallengeRogueTeamData:GetUnOperateData()
	local var_19_1 = arg_19_0.itemType_
	local var_19_2
	local var_19_3 = RogueTeamEffectCfg[var_19_0.paramList.effectID]

	if var_19_1 == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		var_19_2 = ChallengeRogueTeamData:TreasureGetList()
	else
		var_19_2 = ChallengeRogueTeamTools.FilterRelic(var_19_3.params)
	end

	return table.length(var_19_2)
end

return var_0_0
