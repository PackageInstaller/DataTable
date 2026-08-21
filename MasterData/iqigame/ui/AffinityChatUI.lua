-- chunkname: @IQIGame\\UI\\AffinityChatUI.lua

local AffinityChatUI = {}

AffinityChatUI = Base:Extend("AffinityChatUI", "IQIGame.Onigao.UI.AffinityChatUI", AffinityChatUI)

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local RoleItemClass = require("IQIGame/UI/AffinityChat/AffinityChat_RoleItem")
local ChatItemClass = require("IQIGame/UI/AffinityChat/AffinityChat_ChatItem")
local OptionItemClass = require("IQIGame/UI/AffinityChat/AffinityChat_OptionItem")
local OptionData = UnityEngine.UI.Dropdown.OptionData
local m = AffinityChatUI
local DropType = {
	Favor = 0,
	Quality = 2,
	Lv = 1
}
local UpGradeType = {
	Low = 1,
	High = 2
}

function AffinityChatUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function AffinityChatUI:OnOpen(userData)
	local selectRole

	if userData then
		selectRole = userData.selectRole
	end

	LuaUtility.SetGameObjectShow(self.effect_interact, false)
	self.drop:SetValueWithoutNotify(0)
	self:RefreshHeroByDrop(DropType.Favor)

	if selectRole then
		local selectItem

		self.roleItemPool:ForItems(function(item)
			if item.gameObject.activeSelf and item.data.cid == selectRole then
				selectItem = item

				return true
			end
		end)

		if selectItem then
			selectItem:OnClickButtonClick()
		end
	else
		self:SetNoSelectedViewShow(true)
	end

	self:RefreshCostItem()
end

function AffinityChatUI:OnClose(userData)
	self.roleItemPool:ForItems(function(item)
		item:UnExpand()
	end)

	if self.currentSelectItem then
		self.currentSelectItem:UnSelected()
	end

	self.currentSelectItem = nil

	if self.currentSelectedEvent then
		self.currentSelectedEvent:UnSelected()
	end

	self.currentSelectedEvent = nil
	self.isAnimate = false
end

function m:InitMembers()
	self.chatDataModule = {}
	self.chatViewList = {}
	self.optionViewList = {}
	self.currentSelectItem = nil
	self.ascending = true
end

function m:InitComponent()
	self.roleItemPool = UIViewObjectPool.New(self.roleDialogItem, self.roleDialogGrid.transform, function(_view)
		return RoleItemClass.New(_view, self)
	end)
	self.chattingRecordsScrollRect = self.chattingRecordsScroll:GetComponent("RectTransform")
	self.chattingRecordsScroll = self.chattingRecordsScroll:GetComponent("OptimizedScrollRect")

	self.chattingRecordsScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateChatScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	function self.chattingRecordsScroll._OnRebuildLayoutDueToScrollViewSizeChangeBefore()
		for _, v in pairs(self.chatViewList) do
			v.hasPendingVisualSizeChange = true
		end
	end

	function self.chattingRecordsScroll.onItemHeightChangedPreTwinPass(OptimizedViewsHolder)
		OptimizedViewsHolder.hasPendingVisualSizeChange = false
	end

	self.interactEffectDuration = LuaUtility.GetParticleSystemLength(self.effect_interact)
	self.optionalChatContentRect = self.optionalChatContent:GetComponent("RectTransform")
	self.optionalChatContentImage = self.optionalChatContent:GetComponent("Image")
	self.drop = self.drop:GetComponent("UnityEngine.UI.Dropdown")

	local dropItems = {
		getTipText(5000008),
		getTipText(5000010),
		getTipText(5000011)
	}

	self.drop:ClearOptions()

	for i = 1, 3 do
		local data = OptionData.New()

		data.text = dropItems[i]

		self.drop.options:Add(data)
	end

	self.drop.value = 0
	self.drop.captionText.text = dropItems[1]
end

function m:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.delegateOnClickButtonInteract()
		self:OnClickButtonInteract()
	end

	function self.onDropValueChangeEvent(index)
		self:OnDropValueChange(index)
	end

	function self.delegateOnClickSortingOrderButton()
		self:OnClickSortingOrderButton()
	end

	function self.delegateOnClickButtonSkip()
		self:OnClickButtonSkip()
	end

	function self.delegateOnClickButtonNoInteract()
		self:OnClickButtonNoInteract()
	end

	function self.delegateOnClickFavorIcon()
		self:OnClickFavorIcon()
	end
end

function AffinityChatUI:OnAddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
	self.buttonInteract:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonInteract)
	self.drop.onValueChanged:AddListener(self.onDropValueChangeEvent)
	self.SortingOrderButton:GetComponent("Button").onClick:AddListener(self.delegateOnClickSortingOrderButton)
	self.buttonSkip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSkip)
	self.buttonNoInteract:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonNoInteract)
	self.favorIcon:GetComponent("Button").onClick:AddListener(self.delegateOnClickFavorIcon)
	EventUtil.AddEventListener(self, EventID.NetFavorResponse_NotifyEntry)
	EventUtil.AddEventListener(self, EventID.RefreshShowItemCount)
	EventUtil.AddEventListener(self, EventID.NetFavorResponse_NotifyMessageFinish)
	EventUtil.AddEventListener(self, EventID.NetFavorResponse_EntryOptionResultEvent)
end

function AffinityChatUI:OnRemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
	self.buttonInteract:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonInteract)
	self.drop.onValueChanged:RemoveListener(self.onDropValueChangeEvent)
	self.SortingOrderButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickSortingOrderButton)
	self.buttonSkip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSkip)
	self.buttonNoInteract:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonNoInteract)
	self.favorIcon:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickFavorIcon)
	EventUtil.ClearEventListener(self)
end

function m:OnClickFavorIcon()
	ItemModule.OpenItemTipsByItemData(WarehouseModule.FindItemForCid(113), false, false)
end

function m:OnClickButtonNoInteract()
	NoticeModule.ShowNotice(12003)
end

function m:__OnNetFavorResponse_EntryOptionResultEventHandler(optionId)
	if not optionId then
		return
	end

	local cfgFavorOption = CfgUtil.GetCfgFavorMessageOptionDataWithID(optionId)

	if cfgFavorOption.FavorType and cfgFavorOption.FavorType ~= 0 then
		self:SetUpgradeTipShow(true, cfgFavorOption.FavorType)
	end
end

function m:OnClickButtonSkip()
	if self.isAnimate then
		return
	end

	self.checkTime = false

	if self.testNextEntryFunc then
		self.testNextEntryFunc()

		self.testNextEntryFunc = nil
	end
end

function m:__OnNetFavorResponse_NotifyMessageFinishHandler()
	if not self.currentSelectItem then
		return
	end

	local selectRoleId = self.currentSelectItem.data.cid
	local selectGroupId = self.currentSelectedEvent.data.cid

	self:RefreshHeroByDrop(self.crrSortType and self.crrSortType or DropType.Favor)

	local selectItem

	self.roleItemPool:ForItems(function(_item)
		if not _item.gameObject.activeSelf then
			return
		end

		if _item.data and _item.data.cid == selectRoleId then
			selectItem = _item

			return true
		end
	end)

	if not selectItem then
		return
	end

	self.currentSelectItem = selectItem
	self.isAnimate = false

	if not self.currentSelectItem:SelectGroupWithID(selectGroupId) then
		self.currentSelectItem:SelectFirstGroup()
	end
end

function m:__OnRefreshShowItemCountHandler()
	self:RefreshCostItem()
end

function m:OnClickSortingOrderButton()
	if self.isAnimate then
		return
	end

	self.ascending = not self.ascending

	LuaUtility.SetGameObjectShow(self.SortingOrderButton_normalState, self.ascending)
	LuaUtility.SetGameObjectShow(self.SortingOrderButton_selectState, not self.ascending)
	self:RefreshHeroByDrop(self.drop.value)
end

function m:OnDropValueChange(index)
	if self.isAnimate then
		return
	end

	self:RefreshHeroByDrop(index)
end

function m:OnClickButtonInteract()
	if self.isAnimate then
		return
	end

	if not self.currentSelectItem then
		return
	end

	LuaUtility.SetGameObjectShow(self.effect_interact, false)
	LuaUtility.SetGameObjectShow(self.effect_interact, true)

	self.isAnimate = true

	coroutine.start(function()
		coroutine.wait(self.interactEffectDuration)
		AffinityModule.TriggerMessage(self.currentSelectItem.data.cid)
		LuaUtility.SetGameObjectShow(self.effect_interact, false)

		self.isAnimate = false
	end)
end

function m:__OnNetFavorResponse_NotifyEntryHandler(heroCid, groupId, entryId)
	if not self.currentSelectItem then
		return
	end

	if self.currentSelectItem.data.cid ~= heroCid then
		return
	end

	self:RefreshHeroByDrop(self.crrSortType and self.crrSortType or DropType.Favor)

	local selectItem

	self.roleItemPool:ForItems(function(_item)
		if not _item.gameObject.activeSelf then
			return
		end

		if _item.data and _item.data.cid == heroCid then
			selectItem = _item

			return true
		end
	end)

	if not selectItem then
		return
	end

	self.currentSelectItem = selectItem

	self.currentSelectItem:SelectGroupWithID(groupId)

	local index = self.chattingRecordsScroll.VisibleItemsCount - 1

	if index < 0 then
		return
	end

	local viewsHolder = self.chattingRecordsScroll:GetItemViewsHolder(index)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID
		local lastView = self.chatViewList[instanceID]
		local cfgFavorEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(lastView.data)

		if cfgFavorEntry.IsLastEntry ~= 1 then
			lastView:ShowBubble()
		end
	end

	index = self.chattingRecordsScroll.VisibleItemsCount - 2

	if index < 0 then
		return
	end

	local viewsHolder = self.chattingRecordsScroll:GetItemViewsHolder(index)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID
		local lastView = self.chatViewList[instanceID]

		if self.lastEntryId and self.lastEntryId ~= lastView.data then
			lastView:PlayEnterAni()
			LuaUtility.PlaySoundWithID(11210001)
		end
	end
end

function AffinityChatUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function AffinityChatUI:UpdateChatScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.chatDataModule[index + 1]

	if not self.chatViewList[instanceID] then
		self.chatViewList[instanceID] = ChatItemClass.New(viewGameObject, OptimizedViewsHolder, self)
	end

	self.chatViewList[instanceID]:Refresh(data, OptimizedViewsHolder)

	if self.chatViewList[instanceID].hasPendingVisualSizeChange then
		OptimizedViewsHolder:MarkForRebuild()
		self.chattingRecordsScroll:ComputeVisibilityTwinPass(true)
	end
end

function AffinityChatUI:GetPreloadAssetPaths()
	return nil
end

function AffinityChatUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AffinityChatUI:IsManualShowOnOpen(userData)
	return false
end

function AffinityChatUI:GetBGM(userData)
	return nil
end

function AffinityChatUI:OnPause()
	return
end

function AffinityChatUI:OnResume()
	return
end

function AffinityChatUI:OnCover()
	return
end

function AffinityChatUI:OnReveal()
	return
end

function AffinityChatUI:OnRefocus(userData)
	return
end

function AffinityChatUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.checkTime and Time.time - self.dReadyStartTime > self.timeDuration then
		self.checkTime = false

		if self.testNextEntryFunc then
			self.testNextEntryFunc()

			self.testNextEntryFunc = nil
		end
	end
end

function AffinityChatUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AffinityChatUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AffinityChatUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function m:RefreshHeroByDrop(type, isPlayAni)
	local data = WarlockModule.GetHeroFavorArray()

	if type == DropType.Favor then
		table.sort(data, function(a, b)
			local success, result = a:CompWithFavorLv(b, self.ascending)

			if success then
				return result
			end

			success, result = a:CompareWithLevel(b, self.ascending)

			if success then
				return result
			end

			local success, result = a:CompareWithQuality(b, self.ascending)

			if success then
				return result
			end

			return false
		end)
	elseif type == DropType.Lv then
		table.sort(data, function(a, b)
			local success, result = a:CompareWithLevel(b, self.ascending)

			if success then
				return result
			end

			local success, result = a:CompWithFavorLv(b, self.ascending)

			if success then
				return result
			end

			local success, result = a:CompareWithQuality(b, self.ascending)

			if success then
				return result
			end

			return false
		end)
	elseif type == DropType.Quality then
		table.sort(data, function(a, b)
			local success, result = a:CompareWithQuality(b, self.ascending)

			if success then
				return result
			end

			local success, result = a:CompWithFavorLv(b, self.ascending)

			if success then
				return result
			end

			local success, result = a:CompareWithLevel(b, self.ascending)

			if success then
				return result
			end

			return false
		end)
	else
		logError("【好感度】下拉框没有index = " .. type)
	end

	self.roleItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #data do
		local item = self.roleItemPool:GetFree(function(_item)
			return not _item:GetActive()
		end)

		item:Show()
		item:Refresh(data[i], i, isPlayAni)
	end

	self.crrSortType = type
end

function m:RefreshMessageContent(data)
	if not self.currentSelectItem then
		return
	end

	self.chattingRecordsScroll:RefreshByItemCount(0, true)

	self.checkTime = false

	self:SetNoSelectedViewShow(false)
	LuaUtility.SetGameObjectShow(self.buttonSkip, false)
	LuaUtility.SetGameObjectShow(self.ChatFrame, false)
	self:SetUpgradeTipShow(false)
	LuaUtility.SetText(self.roleName, self.currentSelectItem.data:GetCfg().Name)

	self.chatDataModule = {}

	local len = #data.entrys

	for i = 1, len do
		table.insert(self.chatDataModule, data.entrys[i])
	end

	self.chattingRecordsScroll:RefreshByItemCount(#self.chatDataModule, true)

	for i = 1, #self.optionViewList do
		self.optionViewList[i]:Hide()
	end

	LuaUtility.SetSizeDeltaYWithGameObject(self.chattingRecordsScroll.gameObject, 497.16)

	if #self.chatDataModule <= 0 then
		self:SetInterActShow(true)

		return
	end

	self.lastEntryId = self.chatDataModule[#self.chatDataModule]

	local cfgEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(self.lastEntryId)

	if not cfgEntry then
		return
	end

	local optionArray = AffinityModule.GetEntryOptionArray(self.lastEntryId)

	if #optionArray > 0 then
		self:ShowOptions(optionArray)

		return
	end

	if cfgEntry.IsLastEntry == 1 then
		AffinityModule.EntryComplete(cfgEntry.Id)
		self:SetInterActShow(data.cid == 0)

		return
	end

	if cfgEntry.NextId == 0 then
		return
	end

	self.timeDuration = cfgEntry.Interval / 1000
	self.dReadyStartTime = Time.time
	self.checkTime = true

	function self.testNextEntryFunc()
		AffinityModule.EntryComplete(cfgEntry.Id)
	end

	self:SetInterActShow(false)
	LuaUtility.SetGameObjectShow(self.buttonSkip, true)
	LuaUtility.SetGameObjectShow(self.ChatFrame, true)
end

function m:RefreshChatScrollRect()
	self.chattingRecordsScroll:Refresh(true)
end

function m:RoleSelected(roleItem)
	if self.isAnimate then
		return
	end

	if self.currentSelectItem then
		self.currentSelectItem:UnSelected()
	end

	self.currentSelectItem = roleItem

	self.currentSelectItem:Selected()
	self.currentSelectItem:SelectFirstGroup()
end

function m:ShowOptions(optionArray)
	local index

	for i = 1, #optionArray do
		if i > #self.optionViewList then
			local o = GameObject.Instantiate(self.optionalChatItem, self.optionalChatContent.transform)
			local v = OptionItemClass.New(o, self)

			self.optionViewList[i] = v
		end

		self.optionViewList[i]:Show()
		self.optionViewList[i]:Refresh(optionArray[i])

		index = i
	end

	for i = index + 1, #self.optionViewList do
		self.optionViewList[i]:Hide()
	end

	coroutine.start(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.optionalChatContentRect)
		coroutine.wait(0.1)
		LuaUtility.SetSizeDeltaYWithGameObject(self.chattingRecordsScroll.gameObject, self.chattingRecordsScrollRect.sizeDelta.y - self.optionalChatContentRect.sizeDelta.y + 50)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.chattingRecordsScrollRect)
		coroutine.wait(0.1)
		self.chattingRecordsScroll:SetNormalizedPosition(0)
	end)
end

function m:OnOptionClick(view)
	self:__DisableOptionItemButton()
	coroutine.start(function()
		view:SetSelect(true)

		self.isAnimate = true

		LuaUtility.PlayAnimation(view.gameObject, "selectState_click 1")
		coroutine.wait(LuaUtility.GetAnimationLengthWithName(view.gameObject, "selectState_click 1"))
		AffinityModule.EntryOption(view.data.EntryID, view.data.Sort)

		self.isAnimate = false
	end)
end

function m:__DisableOptionItemButton()
	ForPairs(self.optionViewList, function(_, _item)
		_item:SetInteractable(false)
	end)
end

function m:SetNoSelectedViewShow(show)
	if show then
		LuaUtility.SetGameObjectShow(self.emptyRoot, true)
		LuaUtility.SetGameObjectShow(self.titleParent, false)
		self:SetInterActShow(false)
		self.chattingRecordsScroll:RefreshByItemCount(0)
		LuaUtility.SetGameObjectShow(self.ChatFrame, false)
	else
		LuaUtility.SetGameObjectShow(self.emptyRoot, false)
		LuaUtility.SetGameObjectShow(self.titleParent, true)
	end
end

function m:SetInterActShow(show)
	LuaUtility.SetGameObjectShow(self.bottomParent, false)
	LuaUtility.SetGameObjectShow(self.Unlock, false)
	LuaUtility.SetGameObjectShow(self.NoInteract, false)

	if not show then
		return
	end

	if not self.currentSelectItem then
		return
	end

	if not AffinityModule.GetHeroHaveActive(self.currentSelectItem.data.cid) then
		LuaUtility.SetGameObjectShow(self.NoInteract, true)

		return
	end

	local condition = AffinityModule.GetGroupStageCondition(self.currentSelectItem.data.cid)

	if not ConditionModule.Check(condition) then
		LuaUtility.SetGameObjectShow(self.Unlock, true)
		LuaUtility.SetText(self.textUnlock, ConditionModule.GetDesc(condition))

		return
	end

	if show then
		LuaUtility.SetGameObjectShow(self.bottomParent, true)

		local costId, costNum

		for _, v in pairsCfg(CfgFavorMessageGroupTable) do
			if v.StartCost[1] and v.StartCost[2] then
				costId = v.StartCost[1]
				costNum = v.StartCost[2]

				break
			end
		end

		local cfgItem = CfgUtil.GetItemCfgDataWithID(costId)
		local haveCount = WarehouseModule.GetItemNumByCfgID(costId)

		if costNum <= haveCount then
			LuaUtility.SetGameObjectShow(self.notInteractRoot, false)
			LuaUtility.SetGameObjectShow(self.canInteractRoot, true)
		else
			LuaUtility.SetGameObjectShow(self.notInteractRoot, true)
			LuaUtility.SetGameObjectShow(self.canInteractRoot, false)
		end

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), self.imageCost:GetComponent("Image"))
		LuaUtility.SetText(self.textConsume, string.format("X%s", costNum))
	end
end

function AffinityChatUI:RefreshCostItem()
	local cfgItem = CfgUtil.GetItemCfgDataWithID(113)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), self.favorIcon:GetComponent("Image"))
	LuaUtility.SetText(self.favorNum, WarehouseModule.GetItemNumByCfgID(cfgItem.Id))
end

function AffinityChatUI:SetUpgradeTipShow(show, upGradeType)
	if show then
		LuaUtility.SetGameObjectShow(self.UpgradeTip, true)
		LuaUtility.SetGameObjectShow(self.ChatFrame, false)

		if upGradeType == UpGradeType.Low then
			LuaUtility.SetGameObjectShow(self.effectHigh, false)
			LuaUtility.SetGameObjectShow(self.effectLow, true)
		elseif upGradeType == UpGradeType.High then
			LuaUtility.SetGameObjectShow(self.effectHigh, true)
			LuaUtility.SetGameObjectShow(self.effectLow, false)
		end

		if self.upGradeShowCo then
			coroutine.stop(self.upGradeShowCo)

			self.upGradeShowCo = nil
		end

		self.upGradeShowCo = coroutine.start(function()
			coroutine.wait(2.5)
			LuaUtility.SetGameObjectShow(self.UpgradeTip, false)
			LuaUtility.SetGameObjectShow(self.ChatFrame, true)
		end)
	else
		LuaUtility.SetGameObjectShow(self.UpgradeTip, false)
	end
end

function AffinityChatUI:OnEventClick(eventItem)
	if self.isAnimate then
		return
	end

	if self.currentSelectedEvent then
		self.currentSelectedEvent:UnSelected()
	end

	self.currentSelectedEvent = eventItem

	self.currentSelectedEvent:Selected()

	if self.currentSelectItem and self.currentSelectItem ~= self.currentSelectedEvent.mainView then
		self.currentSelectItem:UnSelected()

		self.currentSelectItem = self.currentSelectedEvent.mainView

		self.currentSelectItem:Selected()
	end

	self:RefreshMessageContent(self.currentSelectedEvent.data)
end

function AffinityChatUI:OnDestroy()
	self.chattingRecordsScroll._OnRebuildLayoutDueToScrollViewSizeChangeBefore = nil
	self.chattingRecordsScroll.onItemHeightChangedPreTwinPass = nil
	self.chattingRecordsScroll = nil
	self.optionalChatContentRect = nil
	self.optionalChatContentImage = nil
	self.chattingRecordsScrollRect = nil

	self.roleItemPool:Dispose(function(item)
		item:OnDestroy()
	end)

	for _, v in pairs(self.chatViewList) do
		v:OnDestroy()
	end

	self.chatViewList = nil

	for _, v in pairs(self.optionViewList) do
		v:OnDestroy()
	end

	self.optionViewList = nil

	AssetUtil.UnloadAsset(self)
end

return AffinityChatUI
