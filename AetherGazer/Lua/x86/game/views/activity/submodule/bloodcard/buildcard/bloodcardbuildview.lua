local var_0_0 = class("BloodCardBuildView", ReduxView)

var_0_0.OBJECT_TYPE = {
	ITEM = 2,
	TITLE = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardBuildCardDeckUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.tabList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexTabItem), arg_3_0.tabUIList_, BloodCardBuildCardTabItem)
	arg_3_0.cardInfoView_ = BloodCardInfoView.New(arg_3_0.cardInfoGo_)
	arg_3_0.emptyController_ = arg_3_0.controller_:GetController("empty")
	arg_3_0.stateController_ = arg_3_0.controller_:GetController("state")
	arg_3_0.btnStateController_ = arg_3_0.controller_:GetController("btnState")
	arg_3_0.textController_ = arg_3_0.controller_:GetController("text")
	arg_3_0.smallCardItemList_ = {}

	local var_3_0 = arg_3_0.contentTf_.rect.height
	local var_3_1 = arg_3_0.gridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scrollRectEx_, arg_3_0.gridTrs_, arg_3_0.contentTf_, var_3_0, var_3_1)
	arg_3_0.titleItemPool_ = {}
	arg_3_0.cardItemPool_ = {}
	arg_3_0.onSelectRelicHandler_ = handler(arg_3_0, arg_3_0.OnSelectCard)
	arg_3_0.saveHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
	arg_3_0.cleanCardHandler_ = handler(arg_3_0, arg_3_0.OnClearCardGroup)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.subBtn_, nil, function()
		local var_5_0 = table.indexof(arg_4_0.selectGroupCardIDList_, arg_4_0.selectCardID_)

		if var_5_0 then
			table.remove(arg_4_0.selectGroupCardIDList_, var_5_0)
		end

		arg_4_0:RefreshCardInfoView()
		arg_4_0:RefreshSmallCardContent()

		if arg_4_0.selectItem_ then
			arg_4_0.selectItem_:SetUsed(table.indexof(arg_4_0.selectGroupCardIDList_, arg_4_0.selectItem_.id_) ~= false)
			arg_4_0.selectItem_:SetOwnNum(arg_4_0.selectCardMap_[arg_4_0.selectCardID_] or 0)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.addBtn_, nil, function()
		table.insert(arg_4_0.selectGroupCardIDList_, arg_4_0.selectCardID_)
		arg_4_0:RefreshCardInfoView()
		arg_4_0:RefreshSmallCardContent()

		if arg_4_0.selectItem_ then
			arg_4_0.selectItem_:SetUsed(table.indexof(arg_4_0.selectGroupCardIDList_, arg_4_0.selectItem_.id_) ~= false)
			arg_4_0.selectItem_:SetOwnNum(arg_4_0.selectCardMap_[arg_4_0.selectCardID_] or 0)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.checkDeckBtn_, nil, function()
		return
	end)
	arg_4_0:AddBtnListener(arg_4_0.clearDeckBtn_, nil, function()
		local var_8_0 = #BloodCardData:GetCardGroupList()

		if #BloodCardData:GetCardGroup(arg_4_0.selectTabIndex_) == 0 then
			arg_4_0.selectGroupCardIDList_ = {}

			arg_4_0.emptyController_:SetSelectedState("true")

			return
		end

		if var_8_0 == 1 then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARD_CANT_CLEAR_CARDECK")

			return
		end

		JumpTools.OpenPageByJump("eatSnakeQuitPop", {
			content = GetTips("ACTIVITY_BLOOD_CARD_GAME_CLEAR_CARDECK"),
			cancelAction = function()
				return
			end,
			failAction = function()
				BloodCardAction.SendClearCardGroup(arg_4_0.activityID_, arg_4_0.selectTabIndex_, function()
					return
				end)
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.customBtn_, nil, function()
		BloodCardData:SetRecommendCardSetID(0)
		arg_4_0.emptyController_:SetSelectedState("false")
	end)
	arg_4_0:AddBtnListener(arg_4_0.systemBtn_, nil, function()
		JumpTools.OpenPageByJump("bloodCardRecommendCardGroupPop", {
			selectTab = arg_4_0.selectTabIndex_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.saveDeckBtn_, nil, function()
		if #arg_4_0.selectGroupCardIDList_ ~= arg_4_0.groupCardLimitNum_ then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_ILLEGAL_CARDSET")
			arg_4_0.checkBtnAni_:Play("UI_checkBtn_cx", -1, 0)
		elseif BloodCardData:GetCardGroupName(arg_4_0.selectTabIndex_, true) == "" then
			JumpTools.OpenPageByJump("bloodCardChangeNamePop", {
				activityID = arg_4_0.activityID_,
				selectTabIndex = arg_4_0.selectTabIndex_,
				selectGroupCardIDList = arg_4_0.selectGroupCardIDList_
			})
		else
			BloodCardAction.SendSaveCardGroup(arg_4_0.activityID_, arg_4_0.selectTabIndex_, arg_4_0.selectGroupCardIDList_, BloodCardData:GetCardGroupName(arg_4_0.selectTabIndex_), nil)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.useDeckBtn_, nil, function()
		if #arg_4_0.selectGroupCardIDList_ ~= arg_4_0.groupCardLimitNum_ then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_ILLEGAL_CARDSET")

			return
		end

		BloodCardAction.SendSaveCardGroup(arg_4_0.activityID_, arg_4_0.selectTabIndex_, arg_4_0.selectGroupCardIDList_, BloodCardData:GetCardGroupName(arg_4_0.selectTabIndex_), nil)
		BloodCardAction.SendSetActiveCardGroup(arg_4_0.activityID_, arg_4_0.selectTabIndex_, function()
			arg_4_0:RefreshUI()
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_CHANGE_CARDSET_SUCCESS")
		end)
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.activityID_ = BloodCardData:GetMainActivityID()
	arg_17_0.groupLimitNum_ = 6
	arg_17_0.groupCardLimitNum_ = 15
	arg_17_0.smallCardShowLimitNum_ = 15
	arg_17_0.selectGroupCardIDList_ = {}
	arg_17_0.allCardList_ = BloodCardData:GetAllCardIDSortList()
	arg_17_0.selectTabIndex_ = arg_17_0.params_.tabIndex or BloodCardData:GetUsingCardIndex() or 1
	arg_17_0.selectCardID_ = arg_17_0.params_.selectCardID or 0
	arg_17_0.cacaheNoneCard_ = {}
	arg_17_0.unlockCardIDList_ = BloodCardData:GetUnlockCardIDList()

	BloodCardData:SetRecommendCardSetID(0)
	arg_17_0.tabList_:StartScroll(arg_17_0.groupLimitNum_)
	arg_17_0:SelectTab(arg_17_0.selectTabIndex_)
	manager.notify:RegistListener(BLOOD_CARD_SAVE_CARD_GROUP, arg_17_0.saveHandler_)
	manager.notify:RegistListener(BLOOD_CARD_CLEAR_CARD_GROUP, arg_17_0.cleanCardHandler_)
	manager.notify:RegistListener(BLOOD_CARD_BUILD_SELECTED, arg_17_0.onSelectRelicHandler_)
end

function var_0_0.OnEnterOver(arg_18_0)
	arg_18_0:RefreshCardScroll()
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0.selectGroupCardIDList_ = BloodCardData:GetCardGroup(arg_19_0.selectTabIndex_)
	arg_19_0.unlockCardIDList_ = BloodCardData:GetUnlockCardIDList()

	arg_19_0.tabList_:StartScroll(arg_19_0.groupLimitNum_)
	arg_19_0:RefreshCardView()
end

function var_0_0.RefreshCardView(arg_20_0)
	arg_20_0.deckNumText_.text = BloodCardData:GetHasCardGroupNum() .. "/" .. arg_20_0.groupLimitNum_

	arg_20_0:RefreshCardInfoView()
	arg_20_0:RefreshCardScroll()
	arg_20_0:RefreshSmallCardContent()
end

function var_0_0.RefreshCardInfoView(arg_21_0)
	arg_21_0.selectCardMap_ = {}
	arg_21_0.selectGoldCardID_ = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.selectGroupCardIDList_) do
		if not BloodCardGameCardCfg[iter_21_1] then
			Debug.LogError("有不存在的卡牌ID:", iter_21_1)

			return
		end

		if BloodCardGameCardCfg[iter_21_1].kind == 99 then
			arg_21_0.selectGoldCardID_ = iter_21_1
		end

		if arg_21_0.selectCardMap_[iter_21_1] then
			arg_21_0.selectCardMap_[iter_21_1] = arg_21_0.selectCardMap_[iter_21_1] + 1
		else
			arg_21_0.selectCardMap_[iter_21_1] = 1
		end
	end

	if not arg_21_0.selectCardMap_[arg_21_0.selectCardID_] then
		arg_21_0.selectCardMap_[arg_21_0.selectCardID_] = 0
	end

	if arg_21_0.selectCardMap_[arg_21_0.selectCardID_] >= BloodCardData:GetCardOwnNum(arg_21_0.selectCardID_) or arg_21_0.selectCardMap_[arg_21_0.selectCardID_] and arg_21_0.selectCardMap_[arg_21_0.selectCardID_] == BloodCardGameCardCfg[arg_21_0.selectCardID_].limit or arg_21_0.selectGoldCardID_ ~= 0 and BloodCardGameCardCfg[arg_21_0.selectCardID_].kind == 99 then
		arg_21_0.stateController_:SetSelectedState("max")

		arg_21_0.subBtn_.enabled = true
		arg_21_0.addBtn_.enabled = false
	elseif not arg_21_0.selectCardMap_[arg_21_0.selectCardID_] or arg_21_0.selectCardMap_[arg_21_0.selectCardID_] == 0 then
		arg_21_0.stateController_:SetSelectedState("min")

		arg_21_0.subBtn_.enabled = false
		arg_21_0.addBtn_.enabled = true
	else
		arg_21_0.stateController_:SetSelectedState("normal")

		arg_21_0.subBtn_.enabled = true
		arg_21_0.addBtn_.enabled = true
	end

	arg_21_0.ownNumText_.text = BloodCardData:GetCardOwnNum(arg_21_0.selectCardID_)
	arg_21_0.selectNumText_.text = arg_21_0.selectCardMap_[arg_21_0.selectCardID_] or 0

	arg_21_0.cardInfoView_:SetData(arg_21_0.selectCardID_)

	if #arg_21_0.selectGroupCardIDList_ == 0 or arg_21_0:HasDifferentIDs(arg_21_0.selectGroupCardIDList_, BloodCardData:GetCardGroup(arg_21_0.selectTabIndex_)) then
		arg_21_0.btnStateController_:SetSelectedState("cansave")
	elseif arg_21_0.selectTabIndex_ == BloodCardData:GetUsingCardIndex() and not arg_21_0:HasDifferentIDs(arg_21_0.selectGroupCardIDList_, BloodCardData:GetCardGroup(BloodCardData:GetUsingCardIndex())) then
		arg_21_0.btnStateController_:SetSelectedState("using")
	else
		arg_21_0.btnStateController_:SetSelectedState("canuse")
	end

	if BloodCardData:GetCardOwnNum(arg_21_0.selectCardID_) == 0 then
		arg_21_0.cardInfoView_:SetState("empty")
	elseif arg_21_0.selectGoldCardID_ ~= 0 and BloodCardGameCardCfg[arg_21_0.selectCardID_].kind == 99 and arg_21_0.selectGoldCardID_ ~= arg_21_0.selectCardID_ then
		arg_21_0.cardInfoView_:SetState("limit")
	else
		arg_21_0.cardInfoView_:SetState("normal")
	end
end

function var_0_0.OnClearCardGroup(arg_22_0, arg_22_1)
	arg_22_0:SelectTab(arg_22_1)
end

function var_0_0.RefreshCardScroll(arg_23_0)
	local var_23_0 = arg_23_0.contentTf_.rect.width
	local var_23_1 = arg_23_0.itemTf_.rect.width
	local var_23_2 = math.floor(var_23_0 / var_23_1)

	arg_23_0.uiDataList_ = {}

	local var_23_3 = {}
	local var_23_4 = clone(BloodCardData:GetUnlockCardIDList())

	arg_23_0:SortCardList(var_23_4)
	arg_23_0:SortCardList(arg_23_0.allCardList_)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.allCardList_) do
		if table.indexof(var_23_4, iter_23_1) then
			local var_23_5 = math.floor((table.indexof(var_23_4, iter_23_1) - 1) / var_23_2) + 1

			var_23_3[var_23_5] = var_23_3[var_23_5] or {}

			table.insert(var_23_3[var_23_5], iter_23_1)
		end
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_3) do
		table.insert(arg_23_0.uiDataList_, {
			lockType = 1,
			type = 1,
			objectType = var_0_0.OBJECT_TYPE.ITEM,
			data = iter_23_3
		})
	end

	local var_23_6 = {}
	local var_23_7 = {}

	if #var_23_4 ~= #arg_23_0.allCardList_ then
		table.insert(arg_23_0.uiDataList_, {
			objectType = var_0_0.OBJECT_TYPE.TITLE
		})

		for iter_23_4, iter_23_5 in ipairs(arg_23_0.allCardList_) do
			if not table.indexof(var_23_4, iter_23_5) then
				table.insert(var_23_7, iter_23_5)
			end
		end

		for iter_23_6, iter_23_7 in ipairs(var_23_7) do
			local var_23_8 = math.floor((iter_23_6 - 1) / var_23_2) + 1

			var_23_6[var_23_8] = var_23_6[var_23_8] or {}

			table.insert(var_23_6[var_23_8], iter_23_7)
		end

		for iter_23_8, iter_23_9 in ipairs(var_23_6) do
			table.insert(arg_23_0.uiDataList_, {
				lockType = 0,
				objectType = var_0_0.OBJECT_TYPE.ITEM,
				data = iter_23_9
			})
		end
	end

	if arg_23_0.selectCardID_ == 0 then
		arg_23_0.selectCardID_ = arg_23_0.allCardList_[1]
	end

	arg_23_0.loopScrollView_:RefreshScrollView(true)
end

function var_0_0.IndexTabItem(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2:SetData(arg_24_1)
	arg_24_2:SetClickCallBack(function(arg_25_0)
		BloodCardData:SetRecommendCardSetID(0)

		if var_0_0:HasDifferentIDs(arg_24_0.selectGroupCardIDList_, BloodCardData:GetCardGroup(arg_24_0.selectTabIndex_)) then
			JumpTools.OpenPageByJump("eatSnakeQuitPop", {
				content = GetTips("ACTIVITY_BLOOD_CARD_GAME_UNSAVE_CARDSET"),
				cancelAction = function()
					arg_24_0:SelectTab(arg_25_0)
				end,
				failAction = function()
					if #arg_24_0.selectGroupCardIDList_ ~= arg_24_0.groupCardLimitNum_ then
						ShowTips("ACTIVITY_BLOOD_CARD_GAME_ILLEGAL_CARDSET")

						return
					end

					BloodCardAction.SendSaveCardGroup(arg_24_0.activityID_, arg_24_0.selectTabIndex_, arg_24_0.selectGroupCardIDList_, "", function()
						ShowTips("ACTIVITY_BLOOD_CARD_GAME_SAVE_CARDSET_SUCCESS")
					end)
					arg_24_0:SelectTab(arg_25_0)
				end
			})
		else
			arg_24_0:SelectTab(arg_25_0)
		end
	end)
	arg_24_2:SetRenameCallBack(function(arg_29_0)
		local var_29_0 = BloodCardData:GetCardGroup(arg_29_0)

		JumpTools.OpenPageByJump("bloodCardChangeNamePop", {
			activityID = arg_24_0.activityID_,
			selectTabIndex = arg_29_0,
			selectGroupCardIDList = var_29_0
		})
	end)
	arg_24_2:SelectTab(arg_24_0.selectTabIndex_)
end

function var_0_0.HasDifferentIDs(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	if #arg_30_1 ~= #arg_30_2 then
		return true
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		var_30_0[iter_30_1] = true
	end

	for iter_30_2, iter_30_3 in ipairs(arg_30_2) do
		if not var_30_0[iter_30_3] then
			return true
		end
	end

	local var_30_1 = {}

	for iter_30_4, iter_30_5 in ipairs(arg_30_2) do
		var_30_1[iter_30_5] = true
	end

	for iter_30_6, iter_30_7 in ipairs(arg_30_1) do
		if not var_30_1[iter_30_7] then
			return true
		end
	end

	return false
end

function var_0_0.SelectTab(arg_31_0, arg_31_1)
	arg_31_0.selectTabIndex_ = arg_31_1
	arg_31_0.cacaheNoneCard_ = {}
	arg_31_0.selectGroupCardIDList_ = BloodCardData:GetCardGroup(arg_31_0.selectTabIndex_)

	if #arg_31_0.selectGroupCardIDList_ > 0 then
		arg_31_0:SortCardList(arg_31_0.selectGroupCardIDList_)

		arg_31_0.selectCardID_ = arg_31_0.selectGroupCardIDList_[1]
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0.tabList_:GetItemList()) do
		iter_31_1:SelectTab(arg_31_1)
	end

	arg_31_0:RefreshUI()
	arg_31_0:RefreshState()

	if #arg_31_0.selectGroupCardIDList_ > 0 then
		for iter_31_2, iter_31_3 in ipairs(arg_31_0.cardItemPool_) do
			if iter_31_3.itemView:IsSelectID(arg_31_0.selectCardID_) then
				arg_31_0.selectItem_ = iter_31_3.itemView:IsSelectID(arg_31_0.selectCardID_)

				break
			end
		end
	end
end

function var_0_0.RefreshState(arg_32_0)
	if #arg_32_0.selectGroupCardIDList_ > 0 then
		arg_32_0.emptyController_:SetSelectedState("false")
	else
		arg_32_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.SelectCard(arg_33_0, arg_33_1)
	arg_33_0.cardInfoView_:SetData(arg_33_0.selectCardID_)
	arg_33_0:RefreshCardInfoView()
end

function var_0_0.RefreshSmallCardContent(arg_34_0)
	if #arg_34_0.selectGroupCardIDList_ > arg_34_0.groupCardLimitNum_ then
		arg_34_0.buildCardNumText_.text = "<color=#FFAC4F>" .. #arg_34_0.selectGroupCardIDList_ .. "</color>/" .. arg_34_0.groupCardLimitNum_
	else
		arg_34_0.buildCardNumText_.text = #arg_34_0.selectGroupCardIDList_ .. "/" .. arg_34_0.groupCardLimitNum_
	end

	arg_34_0.textController_:SetSelectedState(tostring(#arg_34_0.selectGroupCardIDList_ == 15))
end

function var_0_0.OnExit(arg_35_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(BLOOD_CARD_SAVE_CARD_GROUP, arg_35_0.saveHandler_)
	manager.notify:RemoveListener(BLOOD_CARD_CLEAR_CARD_GROUP, arg_35_0.cleanCardHandler_)
	manager.notify:RemoveListener(BLOOD_CARD_BUILD_SELECTED, arg_35_0.onSelectRelicHandler_)
end

function var_0_0.OnTop(arg_36_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_36_0.selectRecommendCardSetID = BloodCardData:GetRecommendCardSetID()

	if arg_36_0.selectRecommendCardSetID ~= 0 then
		arg_36_0.selectGroupCardIDList_ = {}

		for iter_36_0, iter_36_1 in ipairs(BloodCardGameRecommendCardSetCfg[arg_36_0.selectRecommendCardSetID].card_list) do
			if BloodCardData:GetCardOwnNum(iter_36_1) == 0 then
				table.insert(arg_36_0.cacaheNoneCard_, iter_36_1)
			else
				table.insert(arg_36_0.selectGroupCardIDList_, iter_36_1)
			end
		end

		arg_36_0:RefreshCardInfoView()
		arg_36_0:RefreshCardScroll()
		arg_36_0:RefreshSmallCardContent()
		arg_36_0:RefreshState()
	end
end

function var_0_0.OnSelectCard(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.selectCardID_ = arg_37_1
	arg_37_0.selectItem_ = arg_37_2

	if table.indexof(arg_37_0.cacaheNoneCard_, arg_37_1) then
		table.remove(arg_37_0.cacaheNoneCard_, table.indexof(arg_37_0.cacaheNoneCard_, arg_37_1))
	end

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.cardItemPool_) do
		iter_37_1.itemView:RefreshNone(arg_37_0.selectCardID_, false)
		iter_37_1.itemView:SetSelectID(arg_37_0.selectCardID_)
	end

	arg_37_0:RefreshCardInfoView()
end

function var_0_0.LsAddItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1.objectType
	local var_38_1

	if var_38_0 == var_0_0.OBJECT_TYPE.TITLE then
		var_38_1 = arg_38_0:GetFreeTitleItem(arg_38_0.titleItemPool_, arg_38_0.titleItemGo_, function()
			return BloodCardBuildTitleItem.New(arg_38_0.titleItemGo_, arg_38_0.gridTrs_)
		end)
	else
		var_38_1 = arg_38_0:GetFreeTitleItem(arg_38_0.cardItemPool_, arg_38_0.cardItemGo_, function()
			return BloodCardBuildPanelItem.New(arg_38_0.cardItemGo_, arg_38_0.gridTrs_)
		end)
	end

	if var_38_0 == var_0_0.OBJECT_TYPE.ITEM then
		var_38_1.itemView:SetData(arg_38_1.data, arg_38_2, arg_38_1.lockType, arg_38_0.selectGroupCardIDList_, arg_38_0.cacaheNoneCard_, arg_38_0.selectCardMap_)
		var_38_1.itemView:SetSelectID(arg_38_0.selectCardID_)
	else
		var_38_1.itemView:SetData(arg_38_1.data, arg_38_2)
	end

	return var_38_1
end

function var_0_0.LsRemoveItem(arg_41_0, arg_41_1, arg_41_2)
	arg_41_1.itemView:Show(false)

	arg_41_1.isFree = true
end

function var_0_0.LsGetItemData(arg_42_0)
	return arg_42_0.uiDataList_
end

function var_0_0.GetFreeTitleItem(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	for iter_43_0, iter_43_1 in pairs(arg_43_1) do
		if iter_43_1.isFree == true then
			iter_43_1.isFree = false

			return iter_43_1
		end
	end

	local var_43_0 = {
		isFree = false,
		gameObject = arg_43_2,
		itemView = arg_43_3()
	}

	table.insert(arg_43_1, var_43_0)

	return var_43_0
end

function var_0_0.SortCardList(arg_44_0, arg_44_1)
	if not table.isEmpty(arg_44_0.selectGroupCardIDList_) then
		table.sort(arg_44_1, function(arg_45_0, arg_45_1)
			local var_45_0 = table.indexof(arg_44_0.selectGroupCardIDList_, arg_45_0) and 1 or 99
			local var_45_1 = table.indexof(arg_44_0.selectGroupCardIDList_, arg_45_1) and 1 or 99

			if var_45_0 ~= var_45_1 then
				return var_45_0 < var_45_1
			end

			if BloodCardGameCardCfg[arg_45_0].kind ~= BloodCardGameCardCfg[arg_45_1].kind then
				return BloodCardGameCardCfg[arg_45_0].kind > BloodCardGameCardCfg[arg_45_1].kind
			end

			local var_45_2 = table.indexof(arg_44_0.unlockCardIDList_, arg_45_0) and 1 or 999
			local var_45_3 = table.indexof(arg_44_0.unlockCardIDList_, arg_45_1) and 1 or 999

			if var_45_2 ~= var_45_3 then
				return var_45_2 < var_45_3
			end

			return arg_45_0 < arg_45_1
		end)
	end
end

function var_0_0.Dispose(arg_46_0)
	if arg_46_0.tabList_ then
		arg_46_0.tabList_:Dispose()
	end

	if arg_46_0.cardInfoView_ then
		arg_46_0.cardInfoView_:Dispose()
	end

	if arg_46_0.smallCardItemList_ then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0.smallCardItemList_) do
			iter_46_1:Dispose()
		end
	end

	for iter_46_2, iter_46_3 in ipairs(arg_46_0.titleItemPool_) do
		iter_46_3.itemView:Dispose()
	end

	arg_46_0.titleItemPool_ = nil

	for iter_46_4, iter_46_5 in ipairs(arg_46_0.cardItemPool_) do
		iter_46_5.itemView:Dispose()
	end

	arg_46_0.cardItemPool_ = nil

	arg_46_0.loopScrollView_:Dispose()

	arg_46_0.loopScrollView_ = nil

	var_0_0.super.Dispose(arg_46_0)
end

return var_0_0
