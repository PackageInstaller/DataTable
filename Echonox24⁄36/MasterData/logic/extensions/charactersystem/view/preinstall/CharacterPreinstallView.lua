-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallView.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallView", package.seeall)

local M = class("CharacterPreinstallView", ViewComponent)
local PresetItemType = {
	Current = 1,
	Saves = 3,
	Recommended = 2
}
local kSaveDuration = 0.25

function M:buildUI()
	local param = self:getOpenParam()

	self._curHeroId = param[1]
	self._tableIndex = param[2]
	self._btnClose = self:getBtn("5&middle_tips_common_bg_-1205189576")
	self._panel1 = self:getGo("character_presets_tips_1225445783")
	self._panel2 = self:getGo("character_presets_tips_-1850752002")
	self._planeClick = self:getBtn("5&middle_tips_common_bg_-1572128605")

	local tabRoot = self:getRectTransform("2&universal_tips_tab_top_-1642209997")

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	for i = 0, tabRoot.childCount - 1 do
		local tmpGo = tabRoot:GetChild(i).gameObject
		local tab = goutil.addComponentOnce(tmpGo, UIComponentType.SpaceXToggle)

		self._toggleTabControl:addToggleTab(tab)
	end

	local cell = self:getGo("character_presets_tips_1163857724")

	self._goCurPreinstall = goutil.findChild(cell, "preset_item")
	self._curTeamItem = Astral.SimpleLuaComponentContainer.Add(self._goCurPreinstall.gameObject, CharacterPreinstallCellItem)

	self._curTeamItem:setHandler(self)
	self._curTeamItem:setHeroDataByHeroID(self._curHeroId)

	local tempScroll = self:getGo("character_presets_tips_-45487549")

	self._loopList = LoopListHelper.New(tempScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._scrollRect = tempScroll:GetComponent(UIComponentType.ScrollRect)
	self._curTeamRect = cell:GetComponent(UIComponentType.RectTransform)
	self._goTeamContent = self:getGo("character_presets_tips_-1667523549")
	self._gridLayoutGroup = self:getGo("character_presets_tips_-1667523549"):GetComponent(UIComponentType.GridLayoutGroup)
	self._cellHeight = RectTransformUtils.GetHeight(self._goCurPreinstall.transform) + 6
	self._recommendedLoopList = LoopListHelper.New(self:getGo("character_presets_tips_-437634346"))

	self._recommendedLoopList:InitListView(0, self._onRecommendedCellUpdate, self)

	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._btnClose = nil
	self._planeClick = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopList:Dispose()

	self._loopList = nil

	self._recommendedLoopList:Dispose()

	self._recommendedLoopList = nil
	self._curTeamItem = nil
	self._panel1 = nil
	self._panel2 = nil
	self._curHeroId = nil
	self._tableIndex = nil
end

function M:_callBackChangeFunc()
	self._curTeamItem:setPreinstallType(PresetItemType.Current, nil)
	FloatWordMgr.instance:show(lang("tip_character_preinstall_changesuccess"))
end

function M:onEnter()
	self:setEvent(true)
	self._curTeamItem:setPreinstallType(PresetItemType.Current, nil)
	self._loopList:ClearCells(true)

	local preinstallList = CharacterPreinstallModle.instance:getHeroPreinstallList(self._curHeroId)

	if preinstallList then
		self:refreshPreinstallLst(preinstallList, true)
	end

	local temp = CharacterPreinstallConfig.instance:GetCharacterPreInstallList(self._curHeroId, true)

	self:_showRecommendedPreinstall(temp, true)
	self._toggleTabControl:selectTab(self._tableIndex)
end

function M:onExit()
	self:setEvent(false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._planeClick:AddClickListener(self._onClickClose, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._planeClick:RemoveClickListener()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CHARACTER_PREINSTALLS_CHANGE, self._handlerHeroPreinstallChange, self)
		GlobalDispatcher:addEventListener(EventType.ChARACTER_PREINSTALLS_CURRENT, self._callBackChangeFunc, self)
		GlobalDispatcher:addEventListener(EventType.ChARACTER_PREINSTALLS_SAVE, self._onSaveTopTips, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleItemChangedPush, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_PREINSTALLS_CHANGE, self._handlerHeroPreinstallChange, self)
		GlobalDispatcher:removeEventListener(EventType.ChARACTER_PREINSTALLS_CURRENT, self._callBackChangeFunc, self)
		GlobalDispatcher:removeEventListener(EventType.ChARACTER_PREINSTALLS_SAVE, self._onSaveTopTips, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleItemChangedPush, self)
	end
end

function M:_onSaveTopTips(e, msg)
	FloatWordMgr.instance:show(lang("tip_character_preinstall_save"))

	if msg == true then
		self:setKineticEffect()
	end
end

function M:setKineticEffect()
	self._curTeamItem:playRainBowAnim()

	self._scrollRect.verticalNormalizedPosition = 1

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
	settimer(0.4, self._onBeginSaveTeam, self, false)
	settimer(kSaveDuration + 0.45, self._onEndSaveTeam, self, false)
end

function M:_onBeginSaveTeam()
	self._scrollRect.enabled = false

	local tempVec2 = Vector2.New()
	local curAnchorPos = self._curTeamRect.anchoredPosition

	tempVec2:Set(curAnchorPos.x, curAnchorPos.y - self._cellHeight)
	self._curTeamRect:DOAnchorPos(tempVec2, kSaveDuration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

	for i = 0, self._goTeamContent.transform.childCount - 1 do
		local itemRect = self._goTeamContent.transform:GetChild(i).gameObject:GetComponent(UIComponentType.RectTransform)
		local anchoredPos = itemRect.anchoredPosition

		tempVec2:Set(anchoredPos.x, anchoredPos.y - self._cellHeight)
		itemRect:DOAnchorPos(tempVec2, kSaveDuration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	end
end

function M:_onEndSaveTeam()
	self._curTeamItem:setSelected(true)
	self._curTeamItem:setCurPreinstallText()
	self._curTeamItem:setCurButton()

	local curAnchorPos = self._curTeamRect.anchoredPosition

	RectTransformUtils.SetAnchoredPosition(self._curTeamRect, curAnchorPos.x, curAnchorPos.y + self._cellHeight)

	self._scrollRect.enabled = true

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	self:_handlerHeroPreinstallChange(1, true)
end

function M:_handleItemChangedPush(e, msg)
	if msg and msg.optType == GameEnum.OptionType.ITEM_LOCK then
		self._loopList:RefreshAllShownItem()
		self._curTeamItem:setPreinstallType(PresetItemType.Current, nil)
	end
end

function M:_onClickClose()
	self:close()
end

function M:setPage(tabIndex)
	self._curPage = tabIndex

	self._guiAnimation:StopTimelineAni()
	goutil.setActive(self._panel1, true)
	goutil.setActive(self._panel2, true)

	if tabIndex == 1 then
		self._guiAnimation:PlayAniByName("change1")
	elseif tabIndex == 2 then
		self._guiAnimation:PlayAniByName("change2")
	end
end

function M:_handlerHeroPreinstallChange(e, isSave)
	local preinstallList = CharacterPreinstallModle.instance:getHeroPreinstallList(self._curHeroId)

	if preinstallList and not isSave then
		self:refreshPreinstallLst(preinstallList, false)
	elseif preinstallList and isSave then
		self:refreshPreinstallLst(preinstallList, true)
	end
end

function M:refreshPreinstallLst(moLst, resetPos)
	self._preintallMoLst = moLst

	local count = self._preintallMoLst and #self._preintallMoLst or 0

	self._loopList:SetListItemCount(count, resetPos)
	self._loopList:RefreshAllShownItem()

	if resetPos then
		self._loopList:MoveToItemIndex(0)
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = CharacterPreinstallCellItem
	local item = self._loopList:NewListViewItem("preset_item")
	local onePreinstall = self._preintallMoLst[curIndex]
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.SimpleLuaComponentContainer.Add(item.gameObject, class)

	shower:setHandler(self)
	shower:setHeroDataByHeroID(self._curHeroId)
	shower:setPreinstallType(PresetItemType.Saves, onePreinstall)

	return item
end

function M:_showRecommendedPreinstall(moLst, resetPos)
	self._recommendedpreinstallMoLst = moLst

	local count = self._recommendedpreinstallMoLst and #self._recommendedpreinstallMoLst or 0

	self._recommendedLoopList:SetListItemCount(count, resetPos)
	self._recommendedLoopList:RefreshAllShownItem()

	if resetPos then
		self._recommendedLoopList:MoveToItemIndex(0)
	end
end

function M:_onRecommendedCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = CharacterPreinstallCellItem
	local item = self._recommendedLoopList:NewListViewItem("preset_item")
	local onePreinstall = self._recommendedpreinstallMoLst[curIndex]
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.SimpleLuaComponentContainer.Add(item.gameObject, class)

	shower:setHandler(self)
	shower:setHeroDataByHeroID(self._curHeroId)
	shower:setPreinstallType(PresetItemType.Recommended, onePreinstall)

	return item
end

function M:_dealTimelineListener(e, tagName, reason)
	if tagName == "change1" then
		goutil.setActive(self._panel1, false)
		goutil.setActive(self._panel2, true)
	elseif tagName == "change2" then
		goutil.setActive(self._panel1, true)
		goutil.setActive(self._panel2, false)
	end
end

return M
