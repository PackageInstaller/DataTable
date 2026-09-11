local BloodCardBuildView = class("BloodCardBuildView", ReduxView)

BloodCardBuildView.OBJECT_TYPE = {
	ITEM = 2,
	TITLE = 1
}

function BloodCardBuildView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardBuildCardDeckUI"
end

function BloodCardBuildView:UIParent()
	return manager.ui.uiMain.transform
end

function BloodCardBuildView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.tabList_ = LuaList.New(handler(self, self.IndexTabItem), self.tabUIList_, BloodCardBuildCardTabItem)
	self.cardInfoView_ = BloodCardInfoView.New(self.cardInfoGo_)
	self.emptyController_ = self.controller_:GetController("empty")
	self.stateController_ = self.controller_:GetController("state")
	self.btnStateController_ = self.controller_:GetController("btnState")
	self.textController_ = self.controller_:GetController("text")
	self.smallCardItemList_ = {}
	self.loopScrollView_ = LoopScrollView.New(self, self.scrollRectEx_, self.gridTrs_, self.contentTf_, self.contentTf_.rect.height, self.gridTrs_:GetComponent("VerticalLayoutGroup").spacing)
	self.titleItemPool_ = {}
	self.cardItemPool_ = {}
	self.onSelectRelicHandler_ = handler(self, self.OnSelectCard)
	self.saveHandler_ = handler(self, self.RefreshUI)
	self.cleanCardHandler_ = handler(self, self.OnClearCardGroup)
end

function BloodCardBuildView:AddUIListener()
	self:AddBtnListener(self.subBtn_, nil, function()
		local var_5_0 = table.indexof(self.selectGroupCardIDList_, self.selectCardID_)

		if var_5_0 then
			table.remove(self.selectGroupCardIDList_, var_5_0)
		end

		self:RefreshCardInfoView()
		self:RefreshSmallCardContent()

		if self.selectItem_ then
			self.selectItem_:SetUsed(table.indexof(self.selectGroupCardIDList_, self.selectItem_.id_) ~= false)
			self.selectItem_:SetOwnNum(self.selectCardMap_[self.selectCardID_] or 0)
		end
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		table.insert(self.selectGroupCardIDList_, self.selectCardID_)
		self:RefreshCardInfoView()
		self:RefreshSmallCardContent()

		if self.selectItem_ then
			self.selectItem_:SetUsed(table.indexof(self.selectGroupCardIDList_, self.selectItem_.id_) ~= false)
			self.selectItem_:SetOwnNum(self.selectCardMap_[self.selectCardID_] or 0)
		end
	end)
	self:AddBtnListener(self.checkDeckBtn_, nil, function()
		return
	end)
	self:AddBtnListener(self.clearDeckBtn_, nil, function()
		if #BloodCardData:GetCardGroup(self.selectTabIndex_) == 0 then
			self.selectGroupCardIDList_ = {}

			self.emptyController_:SetSelectedState("true")

			return
		end

		if #BloodCardData:GetCardGroupList() == 1 then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARD_CANT_CLEAR_CARDECK")

			return
		end

		JumpTools.OpenPageByJump("eatSnakeQuitPop", {
			content = GetTips("ACTIVITY_BLOOD_CARD_GAME_CLEAR_CARDECK"),
			cancelAction = function()
				return
			end,
			failAction = function()
				BloodCardAction.SendClearCardGroup(self.activityID_, self.selectTabIndex_, function()
					return
				end)
			end
		})
	end)
	self:AddBtnListener(self.customBtn_, nil, function()
		BloodCardData:SetRecommendCardSetID(0)
		self.emptyController_:SetSelectedState("false")
	end)
	self:AddBtnListener(self.systemBtn_, nil, function()
		JumpTools.OpenPageByJump("bloodCardRecommendCardGroupPop", {
			selectTab = self.selectTabIndex_
		})
	end)
	self:AddBtnListener(self.saveDeckBtn_, nil, function()
		if #self.selectGroupCardIDList_ ~= self.groupCardLimitNum_ then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_ILLEGAL_CARDSET")
			self.checkBtnAni_:Play("UI_checkBtn_cx", -1, 0)
		elseif BloodCardData:GetCardGroupName(self.selectTabIndex_, true) == "" then
			JumpTools.OpenPageByJump("bloodCardChangeNamePop", {
				activityID = self.activityID_,
				selectTabIndex = self.selectTabIndex_,
				selectGroupCardIDList = self.selectGroupCardIDList_
			})
		else
			BloodCardAction.SendSaveCardGroup(self.activityID_, self.selectTabIndex_, self.selectGroupCardIDList_, BloodCardData:GetCardGroupName(self.selectTabIndex_), nil)
		end
	end)
	self:AddBtnListener(self.useDeckBtn_, nil, function()
		if #self.selectGroupCardIDList_ ~= self.groupCardLimitNum_ then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_ILLEGAL_CARDSET")

			return
		end

		BloodCardAction.SendSaveCardGroup(self.activityID_, self.selectTabIndex_, self.selectGroupCardIDList_, BloodCardData:GetCardGroupName(self.selectTabIndex_), nil)
		BloodCardAction.SendSetActiveCardGroup(self.activityID_, self.selectTabIndex_, function()
			self:RefreshUI()
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_CHANGE_CARDSET_SUCCESS")
		end)
	end)
end

function BloodCardBuildView:OnEnter()
	self.activityID_ = BloodCardData:GetMainActivityID()
	self.groupLimitNum_ = 6
	self.groupCardLimitNum_ = 15
	self.smallCardShowLimitNum_ = 15
	self.selectGroupCardIDList_ = {}
	self.allCardList_ = BloodCardData:GetAllCardIDSortList()

	local var_17_0 = self.params_.tabIndex

	if not self.params_.tabIndex then
		var_17_0 = BloodCardData:GetUsingCardIndex()
		var_17_0 = var_17_0 or 1
	end

	self.selectTabIndex_ = var_17_0
	self.selectCardID_ = self.params_.selectCardID or 0
	self.cacaheNoneCard_ = {}
	self.unlockCardIDList_ = BloodCardData:GetUnlockCardIDList()

	BloodCardData:SetRecommendCardSetID(0)
	self.tabList_:StartScroll(self.groupLimitNum_)
	self:SelectTab(self.selectTabIndex_)
	manager.notify:RegistListener(BLOOD_CARD_SAVE_CARD_GROUP, self.saveHandler_)
	manager.notify:RegistListener(BLOOD_CARD_CLEAR_CARD_GROUP, self.cleanCardHandler_)
	manager.notify:RegistListener(BLOOD_CARD_BUILD_SELECTED, self.onSelectRelicHandler_)
end

function BloodCardBuildView:OnEnterOver()
	self:RefreshCardScroll()
end

function BloodCardBuildView:RefreshUI()
	self.selectGroupCardIDList_ = BloodCardData:GetCardGroup(self.selectTabIndex_)
	self.unlockCardIDList_ = BloodCardData:GetUnlockCardIDList()

	self.tabList_:StartScroll(self.groupLimitNum_)
	self:RefreshCardView()
end

function BloodCardBuildView:RefreshCardView()
	self.deckNumText_.text = BloodCardData:GetHasCardGroupNum() .. "/" .. self.groupLimitNum_

	self:RefreshCardInfoView()
	self:RefreshCardScroll()
	self:RefreshSmallCardContent()
end

function BloodCardBuildView:RefreshCardInfoView()
	self.selectCardMap_ = {}
	self.selectGoldCardID_ = 0

	for iter_21_0, iter_21_1 in ipairs(self.selectGroupCardIDList_) do
		if not BloodCardGameCardCfg[iter_21_1] then
			Debug.LogError("有不存在的卡牌ID:", iter_21_1)

			return
		end

		if BloodCardGameCardCfg[iter_21_1].kind == 99 then
			self.selectGoldCardID_ = iter_21_1
		end

		self.selectCardMap_[iter_21_1] = self.selectCardMap_[iter_21_1] and self.selectCardMap_[iter_21_1] + 1 or 1
	end

	self.selectCardMap_[self.selectCardID_] = self.selectCardMap_[self.selectCardID_] or 0

	if self.selectCardMap_[self.selectCardID_] >= BloodCardData:GetCardOwnNum(self.selectCardID_) or self.selectCardMap_[self.selectCardID_] and self.selectCardMap_[self.selectCardID_] == BloodCardGameCardCfg[self.selectCardID_].limit or self.selectGoldCardID_ ~= 0 and BloodCardGameCardCfg[self.selectCardID_].kind == 99 then
		self.stateController_:SetSelectedState("max")

		self.subBtn_.enabled = true
		self.addBtn_.enabled = false
	elseif not self.selectCardMap_[self.selectCardID_] or self.selectCardMap_[self.selectCardID_] == 0 then
		self.stateController_:SetSelectedState("min")

		self.subBtn_.enabled = false
		self.addBtn_.enabled = true
	else
		self.stateController_:SetSelectedState("normal")

		self.subBtn_.enabled = true
		self.addBtn_.enabled = true
	end

	self.ownNumText_.text = BloodCardData:GetCardOwnNum(self.selectCardID_)
	self.selectNumText_.text = self.selectCardMap_[self.selectCardID_] or 0

	self.cardInfoView_:SetData(self.selectCardID_)

	if #self.selectGroupCardIDList_ == 0 or self:HasDifferentIDs(self.selectGroupCardIDList_, BloodCardData:GetCardGroup(self.selectTabIndex_)) then
		self.btnStateController_:SetSelectedState("cansave")
	elseif self.selectTabIndex_ == BloodCardData:GetUsingCardIndex() and not self:HasDifferentIDs(self.selectGroupCardIDList_, BloodCardData:GetCardGroup(BloodCardData:GetUsingCardIndex())) then
		self.btnStateController_:SetSelectedState("using")
	else
		self.btnStateController_:SetSelectedState("canuse")
	end

	if BloodCardData:GetCardOwnNum(self.selectCardID_) == 0 then
		self.cardInfoView_:SetState("empty")
	elseif self.selectGoldCardID_ ~= 0 and BloodCardGameCardCfg[self.selectCardID_].kind == 99 and self.selectGoldCardID_ ~= self.selectCardID_ then
		self.cardInfoView_:SetState("limit")
	else
		self.cardInfoView_:SetState("normal")
	end
end

function BloodCardBuildView:OnClearCardGroup(arg_22_1)
	self:SelectTab(arg_22_1)
end

function BloodCardBuildView:RefreshCardScroll()
	local var_23_0 = math.floor(self.contentTf_.rect.width / self.itemTf_.rect.width)

	self.uiDataList_ = {}

	local var_23_1 = {}
	local var_23_2 = clone(BloodCardData:GetUnlockCardIDList())

	self:SortCardList(var_23_2)
	self:SortCardList(self.allCardList_)

	for iter_23_0, iter_23_1 in ipairs(self.allCardList_) do
		if table.indexof(var_23_2, iter_23_1) then
			local var_23_3 = math.floor((table.indexof(var_23_2, iter_23_1) - 1) / var_23_0) + 1

			var_23_1[var_23_3] = var_23_1[var_23_3] or {}

			table.insert(var_23_1[var_23_3], iter_23_1)
		end
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_1) do
		table.insert(self.uiDataList_, {
			lockType = 1,
			type = 1,
			objectType = BloodCardBuildView.OBJECT_TYPE.ITEM,
			data = iter_23_3
		})
	end

	local var_23_4 = {}
	local var_23_5 = {}

	if #var_23_2 ~= #self.allCardList_ then
		table.insert(self.uiDataList_, {
			objectType = BloodCardBuildView.OBJECT_TYPE.TITLE
		})

		for iter_23_4, iter_23_5 in ipairs(self.allCardList_) do
			if not table.indexof(var_23_2, iter_23_5) then
				table.insert(var_23_5, iter_23_5)
			end
		end

		for iter_23_6, iter_23_7 in ipairs(var_23_5) do
			local var_23_6 = math.floor((iter_23_6 - 1) / var_23_0) + 1

			var_23_4[var_23_6] = var_23_4[var_23_6] or {}

			table.insert(var_23_4[var_23_6], iter_23_7)
		end

		for iter_23_8, iter_23_9 in ipairs(var_23_4) do
			table.insert(self.uiDataList_, {
				lockType = 0,
				objectType = BloodCardBuildView.OBJECT_TYPE.ITEM,
				data = iter_23_9
			})
		end
	end

	if self.selectCardID_ == 0 then
		self.selectCardID_ = self.allCardList_[1]
	end

	self.loopScrollView_:RefreshScrollView(true)
end

function BloodCardBuildView:IndexTabItem(arg_24_1, arg_24_2)
	arg_24_2:SetData(arg_24_1)
	arg_24_2:SetClickCallBack(function(arg_25_0)
		BloodCardData:SetRecommendCardSetID(0)

		if BloodCardBuildView:HasDifferentIDs(self.selectGroupCardIDList_, BloodCardData:GetCardGroup(self.selectTabIndex_)) then
			JumpTools.OpenPageByJump("eatSnakeQuitPop", {
				content = GetTips("ACTIVITY_BLOOD_CARD_GAME_UNSAVE_CARDSET"),
				cancelAction = function()
					self:SelectTab(arg_25_0)
				end,
				failAction = function()
					if #self.selectGroupCardIDList_ ~= self.groupCardLimitNum_ then
						ShowTips("ACTIVITY_BLOOD_CARD_GAME_ILLEGAL_CARDSET")

						return
					end

					BloodCardAction.SendSaveCardGroup(self.activityID_, self.selectTabIndex_, self.selectGroupCardIDList_, "", function()
						ShowTips("ACTIVITY_BLOOD_CARD_GAME_SAVE_CARDSET_SUCCESS")
					end)
					self:SelectTab(arg_25_0)
				end
			})
		else
			self:SelectTab(arg_25_0)
		end
	end)
	arg_24_2:SetRenameCallBack(function(arg_29_0)
		JumpTools.OpenPageByJump("bloodCardChangeNamePop", {
			activityID = self.activityID_,
			selectTabIndex = arg_29_0,
			selectGroupCardIDList = BloodCardData:GetCardGroup(arg_29_0)
		})
	end)
	arg_24_2:SelectTab(self.selectTabIndex_)
end

function BloodCardBuildView:HasDifferentIDs(arg_30_1, arg_30_2)
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

function BloodCardBuildView:SelectTab(arg_31_1)
	self.selectTabIndex_ = arg_31_1
	self.cacaheNoneCard_ = {}
	self.selectGroupCardIDList_ = BloodCardData:GetCardGroup(self.selectTabIndex_)

	if #self.selectGroupCardIDList_ > 0 then
		self:SortCardList(self.selectGroupCardIDList_)

		self.selectCardID_ = self.selectGroupCardIDList_[1]
	end

	for iter_31_0, iter_31_1 in pairs(self.tabList_:GetItemList()) do
		iter_31_1:SelectTab(arg_31_1)
	end

	self:RefreshUI()
	self:RefreshState()

	if #self.selectGroupCardIDList_ > 0 then
		for iter_31_2, iter_31_3 in ipairs(self.cardItemPool_) do
			if iter_31_3.itemView:IsSelectID(self.selectCardID_) then
				self.selectItem_ = iter_31_3.itemView:IsSelectID(self.selectCardID_)

				break
			end
		end
	end
end

function BloodCardBuildView:RefreshState()
	if #self.selectGroupCardIDList_ > 0 then
		self.emptyController_:SetSelectedState("false")
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function BloodCardBuildView:SelectCard(arg_33_1)
	self.cardInfoView_:SetData(self.selectCardID_)
	self:RefreshCardInfoView()
end

function BloodCardBuildView:RefreshSmallCardContent()
	self.buildCardNumText_.text = #self.selectGroupCardIDList_ > self.groupCardLimitNum_ and "<color=#FFAC4F>" .. #self.selectGroupCardIDList_ .. "</color>/" .. self.groupCardLimitNum_ or #self.selectGroupCardIDList_ .. "/" .. self.groupCardLimitNum_

	self.textController_:SetSelectedState(tostring(#self.selectGroupCardIDList_ == 15))
end

function BloodCardBuildView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(BLOOD_CARD_SAVE_CARD_GROUP, self.saveHandler_)
	manager.notify:RemoveListener(BLOOD_CARD_CLEAR_CARD_GROUP, self.cleanCardHandler_)
	manager.notify:RemoveListener(BLOOD_CARD_BUILD_SELECTED, self.onSelectRelicHandler_)
end

function BloodCardBuildView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.selectRecommendCardSetID = BloodCardData:GetRecommendCardSetID()

	if self.selectRecommendCardSetID ~= 0 then
		self.selectGroupCardIDList_ = {}

		for iter_36_0, iter_36_1 in ipairs(BloodCardGameRecommendCardSetCfg[self.selectRecommendCardSetID].card_list) do
			if BloodCardData:GetCardOwnNum(iter_36_1) == 0 then
				table.insert(self.cacaheNoneCard_, iter_36_1)
			else
				table.insert(self.selectGroupCardIDList_, iter_36_1)
			end
		end

		self:RefreshCardInfoView()
		self:RefreshCardScroll()
		self:RefreshSmallCardContent()
		self:RefreshState()
	end
end

function BloodCardBuildView:OnSelectCard(arg_37_1, arg_37_2)
	self.selectCardID_ = arg_37_1
	self.selectItem_ = arg_37_2

	if table.indexof(self.cacaheNoneCard_, arg_37_1) then
		table.remove(self.cacaheNoneCard_, table.indexof(self.cacaheNoneCard_, arg_37_1))
	end

	for iter_37_0, iter_37_1 in ipairs(self.cardItemPool_) do
		iter_37_1.itemView:RefreshNone(self.selectCardID_, false)
		iter_37_1.itemView:SetSelectID(self.selectCardID_)
	end

	self:RefreshCardInfoView()
end

function BloodCardBuildView:LsAddItem(arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1.objectType == BloodCardBuildView.OBJECT_TYPE.TITLE and self:GetFreeTitleItem(self.titleItemPool_, self.titleItemGo_, function()
		return BloodCardBuildTitleItem.New(self.titleItemGo_, self.gridTrs_)
	end) or self:GetFreeTitleItem(self.cardItemPool_, self.cardItemGo_, function()
		return BloodCardBuildPanelItem.New(self.cardItemGo_, self.gridTrs_)
	end)

	if arg_38_1.objectType == BloodCardBuildView.OBJECT_TYPE.ITEM then
		var_38_0.itemView:SetData(arg_38_1.data, arg_38_2, arg_38_1.lockType, self.selectGroupCardIDList_, self.cacaheNoneCard_, self.selectCardMap_)
		var_38_0.itemView:SetSelectID(self.selectCardID_)
	else
		var_38_0.itemView:SetData(arg_38_1.data, arg_38_2)
	end

	return var_38_0
end

function BloodCardBuildView:LsRemoveItem(arg_41_1, arg_41_2)
	arg_41_1.itemView:Show(false)

	arg_41_1.isFree = true
end

function BloodCardBuildView:LsGetItemData()
	return self.uiDataList_
end

function BloodCardBuildView:GetFreeTitleItem(arg_43_1, arg_43_2, arg_43_3)
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

function BloodCardBuildView:SortCardList(arg_44_1)
	if not table.isEmpty(self.selectGroupCardIDList_) then
		table.sort(arg_44_1, function(arg_45_0, arg_45_1)
			local var_45_0 = table.indexof(self.selectGroupCardIDList_, arg_45_0) and 1 or 99
			local var_45_1 = table.indexof(self.selectGroupCardIDList_, arg_45_1) and 1 or 99

			if var_45_0 ~= var_45_1 then
				return var_45_0 < var_45_1
			end

			if BloodCardGameCardCfg[arg_45_0].kind ~= BloodCardGameCardCfg[arg_45_1].kind then
				return BloodCardGameCardCfg[arg_45_0].kind > BloodCardGameCardCfg[arg_45_1].kind
			end

			local var_45_2 = table.indexof(self.unlockCardIDList_, arg_45_0) and 1 or 999
			local var_45_3 = table.indexof(self.unlockCardIDList_, arg_45_1) and 1 or 999

			if var_45_2 ~= var_45_3 then
				return var_45_2 < var_45_3
			end

			return arg_45_0 < arg_45_1
		end)
	end
end

function BloodCardBuildView:Dispose()
	if self.tabList_ then
		self.tabList_:Dispose()
	end

	if self.cardInfoView_ then
		self.cardInfoView_:Dispose()
	end

	if self.smallCardItemList_ then
		for iter_46_0, iter_46_1 in ipairs(self.smallCardItemList_) do
			iter_46_1:Dispose()
		end
	end

	for iter_46_2, iter_46_3 in ipairs(self.titleItemPool_) do
		iter_46_3.itemView:Dispose()
	end

	self.titleItemPool_ = nil

	for iter_46_4, iter_46_5 in ipairs(self.cardItemPool_) do
		iter_46_5.itemView:Dispose()
	end

	self.cardItemPool_ = nil

	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	BloodCardBuildView.super.Dispose(self)
end

return BloodCardBuildView
