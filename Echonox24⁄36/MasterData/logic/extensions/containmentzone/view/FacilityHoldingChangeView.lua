-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingChangeView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingChangeView", package.seeall)

local M = class("FacilityHoldingChangeView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._columnNum = 4
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._rectTRoomTabRoot = self:getRectTransform("facility_holding_change_view_-1087728071")
	self._goRoomTabItem = self:getGo("facility_holding_change_view_-857990247")
	self._infoCellCollection = LocalReusableCollection.New(HoldingRoomTabCell, 6)
	self._scrollProtomer = LoopStaggeredGridViewHelper.New(self:getGo("facility_holding_change_view_-837437632"))
end

function M:destroyUI()
	self._guiAnimation = nil
	self._rectTRoomTabRoot = nil
	self._goRoomTabItem = nil
	self._scrollProtomer = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
	self._infoCellCollection = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	self._cellItem = {}

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
	self:_duelWithRoomTab()
	self:_duelWithTotalProtomer()

	local info = self:getFirstParam()
	local defaultSelectTabIndex = info and info.selectTab or 1

	self._toggleTabControl:selectTab(defaultSelectTabIndex)
	self._guiAnimation:StopTimelineAni()

	local trContent = self._scrollProtomer:getScrollRect().content
	local canvasGroup = trContent:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1

	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")

	self._activeIndex = nil

	self._infoCellCollection:clearAllInstance()
	self._scrollProtomer:ClearCells(true)

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._aniMark = nil
	self._protomerShowIndex = nil
end

function M:_handleHouseHoldRoomInfoChange()
	self:_updateRoomTabShow()
	self:_duelWithTotalProtomer()
end

function M:onProtomerCellClick(protomerCell)
	if protomerCell:getIsUnLock() then
		local roomId = self:getCurRoomId() + 1100

		ToolTipsMgr.showFacilityHoldingInfoTips(roomId, protomerCell:getId())
	else
		ToolTipsMgr.showFacilityHoldingUnlockConditionTips(protomerCell:getId())
	end

	self:setCurSelectProtomerId(protomerCell:getId())
end

function M:setCurSelectProtomerId(selectProtomerId)
	self._curSelectProtomerId = selectProtomerId

	for _, shower in pairs(self._cellItem or {}) do
		shower:refreshSelect(self._curSelectProtomerId)
	end
end

function M:_duelWithTotalProtomer()
	local _protomerCfgLst = ProtomerModel.instance:getProtomerInfoLstForChangeView()

	self._protomerShowLst = {}
	self._protomerShowIndex = {}
	self._cachePObjClass = nil

	for k, v in pairs(_protomerCfgLst) do
		if not self._cachePObjClass or self._cachePObjClass ~= v.degree then
			if #self._protomerShowLst ~= 0 then
				local needDataNum = #self._protomerShowLst % self._columnNum

				if needDataNum ~= 0 then
					needDataNum = self._columnNum - needDataNum

					for i = 1, needDataNum do
						table.insert(self._protomerShowLst, {
							isFakeData = true,
							degree = v.degree
						})
					end
				end
			end

			table.insert(self._protomerShowLst, {
				isTitle = true,
				degree = v.degree
			})

			for i = 1, 3 do
				table.insert(self._protomerShowLst, {
					isFakeData = true,
					isTitle = true,
					degree = v.degree
				})
			end

			self._cachePObjClass = v.degree
		end

		table.insert(self._protomerShowLst, {
			isFakeData = false,
			isTitle = false,
			degree = v.degree,
			cfg = v
		})

		self._protomerShowIndex[v.id] = #self._protomerShowLst
	end

	self._cachePObjClass = nil

	if self._scrollProtomer:IsInited() then
		self._scrollProtomer:SetListItemCount(#self._protomerShowLst, true)
		self._scrollProtomer:RefreshAllShownItem()
	else
		self._scrollProtomer:InitStaggeredGridView(#self._protomerShowLst, 0, 0, self._columnNum, 240, self._onCellUpdate, self)
		self._scrollProtomer:RefreshAllShownItem()
	end
end

function M:_onCellUpdate(index)
	index = index + 1

	local itemData = self._protomerShowLst[index]
	local showItem = not itemData.isFakeData
	local itemPrefabName = itemData.isTitle and "holding_title_item" or "holding_goods_item"
	local itemClass = itemData.isTitle and HoldingRoomChangeViewTitleCell or HoldingRoomChangeViewProtomerCell
	local item = self._scrollProtomer:NewListViewItem(itemPrefabName)
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, itemClass)

	shower:setShow(showItem)

	if showItem then
		if itemData.isTitle then
			shower:setIcon(itemData.degree)
		else
			shower:setDataByCfg(itemData.cfg)
			shower:setHandler(self)
		end
	end

	if not self._aniMark then
		self._aniMark = {}
	end

	if not self._aniMark[item.gameObject:GetInstanceID()] then
		self._aniMark[item.gameObject:GetInstanceID()] = 1

		if showItem then
			shower:playOpenAni()
		end
	else
		shower:fixAni()
	end

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:_duelWithRoomTab()
	self._activeIndex = -1
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(_tabCheckFunc)

	if self._infoCellCollection then
		self._infoCellCollection:clearAllInstance()
	end

	for i = 1, ContainmentEnum.maxRoomCount do
		local roomId = i + 1100
		local shower = self._infoCellCollection:createInstance(self._goRoomTabItem)

		goutil.addChildToParent(shower.mainGO, self._rectTRoomTabRoot)

		shower.view = self

		shower:setRoomId(roomId)
		shower:setName(string.format(lang("tip_house_holdroom_idname"), i))
		goutil.setActive(shower.mainGO, true)
		self._toggleTabControl:addToggleTab(goutil.addComponentOnce(shower.mainGO, UIComponentType.SpaceXToggle))
	end

	self:_updateRoomTabShow()
end

function M:_updateRoomTabShow()
	for i = 1, ContainmentEnum.maxRoomCount do
		local roomId = i + 1100
		local _lock = not ContainmentModel.instance:getRoomInfoExist(roomId)
		local tempGo = self._rectTRoomTabRoot:GetChild(i).gameObject
		local shower = Astral.LuaComponentContainer.Add(tempGo, HoldingRoomTabCell)

		shower:setLockMarkShow(_lock)
	end
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self._scrollProtomer:RefreshAllShownItem()

		local roomId = self:getCurRoomId() + 1100
		local protomerId = ContainmentModel.instance:getProtomerId(roomId)

		if orgIndex >= 0 then
			self:movePanelToProtomer(protomerId)
		else
			self._theProtomerId = protomerId

			settimer(0.1, self._delayMoveToProtomer, self, false)
		end

		self:setCurSelectProtomerId(nil)
	end
end

function M:_delayMoveToProtomer()
	removetimer(self._delayMoveToProtomer, self)
	self:movePanelToProtomer(self._theProtomerId)

	self._theProtomerId = nil
end

function M:movePanelToProtomer(protomerId)
	if protomerId > 0 then
		local index = self._protomerShowIndex[protomerId]

		if index then
			index = index - 1

			self:movePanelToItemIndex(index)
		end
	else
		self:movePanelToItemIndex(0)
	end
end

function M:movePanelToItemIndex(index)
	local loopStaggeredGridView = self._scrollProtomer:GetLoopStaggeredGridView()

	loopStaggeredGridView.MovePanelToItemIndex(loopStaggeredGridView, index, 0)
end

function M:getCurRoomId()
	return self._activeIndex
end

function _tabCheckFunc(tabIndex)
	return ContainmentUtil.roomTabSelectCheckFunc(tabIndex)
end

return M
