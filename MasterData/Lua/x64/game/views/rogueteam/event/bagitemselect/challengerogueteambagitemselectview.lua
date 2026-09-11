local ChallengeRogueTeamBagItemSelectView = class("ChallengeRogueTeamBagItemSelectView", ReduxView)

function ChallengeRogueTeamBagItemSelectView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeDiscardUI"
end

function ChallengeRogueTeamBagItemSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamBagItemSelectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ChallengeRogueTeamBagItemSelectItem)
	self.tabItemList_ = {}
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureBtnGo_, handler(self, self.OnClickBtn))
	self.onSelectItemHandler_ = handler(self, self.OnSelectItem)
	self.OnSelectTabHandler_ = handler(self, self.OnSelectTab)
	self.itemInfoView_ = ChallengeRogueTeamCommonItemView.New(self.itemInfoGo_)
	self.typeController_ = self.controllerEx_:GetController("Discard")
	self.emptyController_ = self.controllerEx_:GetController("empty")
end

function ChallengeRogueTeamBagItemSelectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	ChallengeRogueTeamTools.ShowBarList()

	self.effectID_ = ChallengeRogueTeamData:GetUnOperateData().paramList.effectID
	self.itemType_ = RogueTeamEffectCfg[self.effectID_].action == ChallengeRogueTeamConst.EFFECT_ACTION.DISCARD_TREASURE and ChallengeRogueTeamConst.ITEM_TYPE.TREASURE or ChallengeRogueTeamConst.ITEM_TYPE.RELIC
	self.campId_ = 0
	self.tabIndex_ = 1

	self:InitItemData()
	self.uiList_:StartScroll(#self.itemDataList_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECTED_ITEM, self.onSelectItemHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_DISCARD_SUIT_SKILL, self.OnSelectTabHandler_)
	self:RefreshItemInfo(0)
	self:RefreshBtn()
end

function ChallengeRogueTeamBagItemSelectView:OnExit()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECTED_ITEM, self.onSelectItemHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_DISCARD_SUIT_SKILL, self.OnSelectTabHandler_)
	manager.windowBar:HideBar()
	ChallengeRogueTeamTools.HideBarList()

	self.selectItemList_ = {}
end

function ChallengeRogueTeamBagItemSelectView:Dispose()
	self.itemInfoView_:Dispose()

	self.itemInfoView_ = nil
	self.onSelectItemHandler_ = nil
	self.OnSelectTabHandler_ = nil

	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil

	self.uiList_:Dispose()

	self.uiList_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.tabItemList_) do
		iter_6_1:Dispose()
	end

	self.tabItemList_ = nil
	self.itemDataList_ = nil

	ChallengeRogueTeamBagItemSelectView.super.Dispose(self)
end

function ChallengeRogueTeamBagItemSelectView:AddListeners()
	return
end

function ChallengeRogueTeamBagItemSelectView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.itemDataList_[arg_8_1], arg_8_1)
end

function ChallengeRogueTeamBagItemSelectView:RefreshTabList()
	for iter_9_0, iter_9_1 in ipairs(self.campList_) do
		if self.tabItemList_[iter_9_0] == nil then
			self.tabItemList_[iter_9_0] = ChallengeRogueTeamSuitSkillTabItem.New(self.tabItem_, self.tabParent_, iter_9_0)
		end

		self.tabItemList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #self.campList_ + 1, #self.tabItemList_ do
		self.tabItemList_[iter_9_2]:Show(false)
	end
end

function ChallengeRogueTeamBagItemSelectView:OnSelectTab(arg_10_1)
	if self.tabIndex_ == arg_10_1 then
		return
	end

	self.tabIndex_ = arg_10_1

	self:RefreshSelectTabItem()

	self.itemDataList_ = {}

	for iter_10_0, iter_10_1 in ipairs(self.treasureDataList_[self.campList_[arg_10_1]] or {}) do
		self.itemDataList_[iter_10_0] = {
			id = iter_10_1.id,
			rare = iter_10_1.rare,
			isSelect = table.keyof(self.selectItemList_, iter_10_1.id) ~= nil
		}
	end

	self.uiList_:StartScroll(#self.itemDataList_)
end

function ChallengeRogueTeamBagItemSelectView:RefreshSelectTabItem()
	for iter_11_0, iter_11_1 in ipairs(self.tabItemList_) do
		iter_11_1:RefreshSelect(self.campList_[self.tabIndex_])
	end
end

function ChallengeRogueTeamBagItemSelectView:InitItemData()
	local var_12_0 = ChallengeRogueTeamData:GetUnOperateData()

	self.canSelectCnt_ = var_12_0.paramList.canSelectCnt
	self.selectItemList_ = {}
	self.itemDataList_ = {}

	local var_12_1

	if self.itemType_ == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		self.typeController_:SetSelectedState("Treasure")

		self.treasureDataList_ = ChallengeRogueTeamTools.TreasureGroup((ChallengeRogueTeamTools.FilterTreasure(RogueTeamEffectCfg[var_12_0.paramList.effectID].params)))

		local var_12_2, var_12_3 = ChallengeRogueTeamTools:GetAllSuitSkillIDList()

		self.campList_ = var_12_3

		self:RefreshTabList()

		var_12_1 = self.treasureDataList_[self.campList_[self.tabIndex_]]

		local var_12_4 = GetTips("ROGUE_TEAM_TREASURE_NAME")

		self.titleText1_.text = string.format(GetTips("ROGUE_TEAM_DISCARD_ITEM_WF"), var_12_4)
		self.titleText2_.text = string.format(GetTips("ROGUE_TEAM_SELECT_ITEM"), self.canSelectCnt_, var_12_4)

		self:RefreshSelectTabItem()
	else
		var_12_1 = ChallengeRogueTeamTools.FilterRelic(RogueTeamEffectCfg[var_12_0.paramList.effectID].params)

		self.typeController_:SetSelectedState("Relic")

		local var_12_5 = GetTips("ROGUE_TEAM_RELIC_NAME")

		self.titleText1_.text = string.format(GetTips("ROGUE_TEAM_DISCARD_ITEM_WF"), var_12_5)
		self.titleText2_.text = string.format(GetTips("ROGUE_TEAM_SELECT_ITEM"), self.canSelectCnt_, var_12_5)
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_6 = {
			id = var_12_1[iter_12_0].id,
			rare = var_12_1[iter_12_0].rare
		}

		var_12_6.isSelect = false
		self.itemDataList_[iter_12_0] = var_12_6
	end
end

function ChallengeRogueTeamBagItemSelectView:GetItemIndex(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.itemDataList_) do
		if iter_13_1.id == arg_13_1 then
			return iter_13_0
		end
	end

	return 0
end

function ChallengeRogueTeamBagItemSelectView:OnSelectItem(arg_14_1)
	local var_14_0 = table.keyof(self.selectItemList_, arg_14_1.id)

	if not var_14_0 then
		local var_14_1 = self:GetItemIndex(arg_14_1.id)

		self.itemDataList_[var_14_1].isSelect = true

		self:RefreshItemInfo(var_14_1)
		table.insert(self.selectItemList_, arg_14_1.id)

		for iter_14_0 = #self.selectItemList_, self.canSelectCnt_ + 1, -1 do
			local var_14_2 = self:GetItemIndex(self.selectItemList_[1])

			if var_14_2 ~= 0 then
				self.itemDataList_[var_14_2].isSelect = false
			end

			table.remove(self.selectItemList_, 1)
		end
	else
		self:RefreshItemInfo(0)

		local var_14_3 = self:GetItemIndex(self.selectItemList_[#self.selectItemList_])

		if var_14_3 ~= 0 then
			self.itemDataList_[var_14_3].isSelect = false
		end

		table.remove(self.selectItemList_, var_14_0)
	end

	self:RefreshBtn()
	self.uiList_:Refresh()
end

function ChallengeRogueTeamBagItemSelectView:RefreshBtn()
	if #self.selectItemList_ >= self.canSelectCnt_ then
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	else
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK, ChallengeRogueTeamButton.BUTTON_TEXT.MAKE_CHOICE)
	end
end

function ChallengeRogueTeamBagItemSelectView:RefreshItemInfo(arg_16_1)
	if arg_16_1 == 0 then
		self.emptyController_:SetSelectedState("true")
	else
		local var_16_0 = clone(ChallengeRogueTeamCommonItemData)

		var_16_0.id = self.itemDataList_[arg_16_1].id
		var_16_0.rare = self.itemDataList_[arg_16_1].rare
		var_16_0.descRaycastFlag = true

		self.itemInfoView_:SetData(var_16_0)
		self.emptyController_:SetSelectedState("false")
	end
end

function ChallengeRogueTeamBagItemSelectView:OnClickBtn()
	local var_17_0 = self:GetItemMaxCnt()

	if (var_17_0 < self.canSelectCnt_ and var_17_0 or self.canSelectCnt_) > #self.selectItemList_ then
		return
	end

	ChallengeRogueTeamAction.RemoveSelectedItem(self.selectItemList_, function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()

		if #self.selectItemList_ > 0 then
			ChallengeRogueTeamData:UISetEventPause(true)
		end

		self:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
	end)
end

function ChallengeRogueTeamBagItemSelectView:GetItemMaxCnt()
	return table.length(self.itemType_ == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and ChallengeRogueTeamData:TreasureGetList() or ChallengeRogueTeamTools.FilterRelic(RogueTeamEffectCfg[ChallengeRogueTeamData:GetUnOperateData().paramList.effectID].params))
end

return ChallengeRogueTeamBagItemSelectView
