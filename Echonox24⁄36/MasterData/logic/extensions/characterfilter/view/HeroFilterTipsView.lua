-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterfilter/view/HeroFilterTipsView.lua

module("logic.extensions.characterfilter.view.HeroFilterTipsView", package.seeall)

local M = class("HeroFilterTipsView", ViewComponent)
local HeroFilter = CommEnum.HeroFilter

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._btnClose = self:getBtnByPath("click")
	self._btnConfirm = self:getBtnByPath("btnEnsure")
	self._btnReset = self:getBtnByPath("btnDelete")
	self._rectTrTabRoot = goutil.findChildComponent(self.mainGO, "Content/content1/sortList", UIComponentType.RectTransform)
	self._tabComps = {}

	for i = 0, self._rectTrTabRoot.childCount - 1 do
		local index = i + 1

		self._tabComps[index] = self:_buildTabCell(self._rectTrTabRoot:GetChild(i).gameObject, index)
	end

	self._scorll = goutil.findChildComponent(self.mainGO, "Content/content3/d6Scroll", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scorll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	for _, cell in pairs(self._tabComps or {}) do
		cell.destroyUI()
	end

	self._tabComps = nil

	for _, cell in pairs(self._cellComps or {}) do
		cell.destroyUI()
	end

	self._cellComps = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	self._canvasGroup.interactable = true

	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._moduleType = info.moduleType
	self._confirmEvent = info.confirmEvent
	self._dataList = info.data or {}
	self._recordData = CharacterUtil.getFilterViewOpt(self._moduleType) and TableUtil.deepCopy(CharacterUtil.getFilterViewOpt(self._moduleType)) or {}

	local defaultIndex = self:_refreshTab()

	self:_onTabCellClick(defaultIndex)
end

function M:onExit(reasonTyp)
	self._canvasGroup.interactable = false

	self:setEvent(false)

	self._recordData = nil
	self._selectTabIndex = nil
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickConfirm()
	CharacterUtil.saveFilterViewOpt(self._moduleType, self._recordData)

	self._dataList = CharacterUtil.SortAndFitler(self._moduleType, self._dataList)

	if self._confirmEvent then
		GlobalDispatcher:dispatchEvent(self._confirmEvent, self._dataList)
	end

	self:close()
end

function M:_onClickReset()
	self._recordData.camp = {
		0
	}
	self._recordData.quality = {
		0
	}
	self._recordData.career = {
		0
	}
	self._recordData.color = {
		0
	}
	self._recordData.tag = {
		0
	}

	self:_refreshView(true)
end

function M:_onClickClose()
	self:close()
end

function M:_initView()
	return
end

function M:_refreshView(resetPos)
	local tabType = self._tabTypeLst[self._selectTabIndex]
	local items = HeroFilterEnum.getTypeItems(tabType)
	local count = items and #items or 0

	if count > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(count, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex)
	local dataIndex = curIndex + 1
	local tabType = self._tabTypeLst[self._selectTabIndex]
	local tabItemData = HeroFilterEnum.getTypeItems(tabType)[dataIndex]
	local item = self._loopList:NewListViewItem("team_filter_tab")

	self:_updateCell(item.gameObject, dataIndex, tabType, tabItemData)

	return item
end

function M:_updateCell(go, dataIndex, tabType, data)
	if not self._cellComps then
		self._cellComps = {}
	end

	local key = go:GetInstanceID()
	local cell = self._cellComps[key]

	if not cell then
		cell = {
			goNormal = goutil.findChild(go, "normal").gameObject,
			goSelect = goutil.findChild(go, "select").gameObject,
			toggle = goutil.findChildComponent(go, "", UIComponentType.SpaceXToggle),
			imgNormal = goutil.findChildImageComponent(go, "normal/icon"),
			imgSelect = goutil.findChildImageComponent(go, "select/icon"),
			txtName1 = goutil.findChildComponent(go, "normal/Text", UIComponentType.TMPText),
			txtName2 = goutil.findChildComponent(go, "select/Text", UIComponentType.TMPText),
			btn = UIComponentType.ButtonAdapter(go)
		}

		function cell.setSelect(selected)
			goutil.setActive(cell.goNormal, not selected)
			goutil.setActive(cell.goSelect, selected)
		end

		function cell.getDataIndex()
			return cell.dataIndex
		end

		function cell.getTabType()
			return cell.tabType
		end

		function cell.updateSelect()
			local isSelected = self:getIsSelectedCell(cell.getTabType(), cell.getDataIndex())

			cell.toggle:ForceSetOn(isSelected)
			cell.setSelect(isSelected)
		end

		cell.btn:AddClickListener(function()
			self:_onCellClick(cell)
		end, self)

		function cell.destroyUI()
			cell.btn:RemoveClickListener()
		end

		self._cellComps[key] = cell
	end

	cell.data = data
	cell.dataIndex = dataIndex
	cell.tabType = tabType
	cell.txtName1.text = data.name
	cell.txtName2.text = data.name

	local hasIcon = not string.nilorempty(data.icon)

	goutil.setActive(cell.imgNormal.gameObject, hasIcon)
	goutil.setActive(cell.imgSelect.gameObject, hasIcon)

	if hasIcon then
		IconLoader.setSprite(cell.imgNormal, data.iconType, data.icon)
		IconLoader.setSprite(cell.imgSelect, data.iconType, data.icon)
	end

	cell.updateSelect()
end

function M:getIsSelectedCell(tabType, dataIndex)
	if not tabType or not dataIndex then
		return false
	end

	local isSelected = false
	local itemData = HeroFilterEnum.getTypeItems(tabType)[dataIndex]
	local camp = self._recordData.camp or {}
	local quality = self._recordData.quality or {}
	local career = self._recordData.career or {}
	local color = self._recordData.color or {}
	local tag = self._recordData.tag or {}

	if tabType == HeroFilterEnum.TabType.CareerAndColor then
		if itemData.isCareer then
			if table.indexof(career, itemData.val) then
				isSelected = true
			end
		elseif table.indexof(color, itemData.val) then
			isSelected = true
		end
	elseif tabType == HeroFilterEnum.TabType.Quality then
		if table.indexof(quality, itemData.val) then
			isSelected = true
		end
	elseif tabType == HeroFilterEnum.TabType.Tag and table.indexof(tag, itemData.val) then
		isSelected = true
	end

	return isSelected
end

function M:_onCellClick(cell)
	local tabType = cell.getTabType()
	local dataIndex = cell.getDataIndex()
	local itemData = HeroFilterEnum.getTypeItems(tabType)[dataIndex]
	local camp = self._recordData.camp or {}
	local quality = self._recordData.quality or {}
	local career = self._recordData.career or {}
	local color = self._recordData.color or {}
	local tag = self._recordData.tag or {}

	local function _findAndRemove(_table, val)
		local remove = false

		if _table then
			local findIndex = table.indexof(_table, val)

			if findIndex then
				table.remove(_table, findIndex)

				remove = true
			end
		end

		return remove
	end

	if tabType == HeroFilterEnum.TabType.CareerAndColor then
		if itemData.isCareer then
			if not _findAndRemove(career, itemData.val) then
				_findAndRemove(career, 0)
				table.insert(career, itemData.val)
			end

			if #career == 0 then
				table.insert(career, 0)
			end

			self._recordData.career = career
		else
			if not _findAndRemove(color, itemData.val) then
				_findAndRemove(color, 0)
				table.insert(color, itemData.val)
			end

			if #color == 0 then
				table.insert(color, 0)
			end

			self._recordData.color = color
		end
	elseif tabType == HeroFilterEnum.TabType.Quality then
		if not _findAndRemove(quality, itemData.val) then
			_findAndRemove(quality, 0)
			table.insert(quality, itemData.val)
		end

		if #quality == 0 then
			table.insert(quality, 0)
		end

		self._recordData.quality = quality
	elseif tabType == HeroFilterEnum.TabType.Tag then
		if not _findAndRemove(tag, itemData.val) then
			_findAndRemove(tag, 0)
			table.insert(tag, itemData.val)
		end

		if #tag == 0 then
			table.insert(tag, 0)
		end

		self._recordData.tag = tag
	end

	cell.updateSelect()
end

function M:_refreshTab()
	local moduleType = self._moduleType
	local tabTypeLst = HeroFilterEnum.HeroFilterTab[moduleType]

	if not tabTypeLst then
		printError(string.format("无法找到[%s]的tabList", moduleType))

		self._moduleType = CommEnum.HeroFilter.Team
		tabTypeLst = HeroFilterEnum.HeroFilterTab[self._moduleType]
	end

	self._tabTypeLst = tabTypeLst

	if #self._tabComps < #self._tabTypeLst then
		printError(string.format("[%s]的tabList的数量%s与UI不匹配", moduleType, #self._tabTypeLst))
	end

	for index, cell in ipairs(self._tabComps or {}) do
		local tabType = tabTypeLst[index]

		cell.setTabType(tabType)
	end

	local selectedIndex = -1

	for index, _tabType in ipairs(tabTypeLst or {}) do
		if selectedIndex < 0 and CharacterUtil.isTabTypeSelected(moduleType, _tabType) then
			selectedIndex = index
		end
	end

	if selectedIndex < 0 then
		selectedIndex = 1
	end

	return selectedIndex
end

function M:_buildTabCell(go, index)
	local cell = {}

	cell.go = go
	cell.index = index
	cell.goNormal = goutil.findChild(go, "normal").gameObject
	cell.goSelect = goutil.findChild(go, "select").gameObject
	cell.txtName1 = goutil.findChildComponent(go, "normal/Text", UIComponentType.Text)
	cell.txtName2 = goutil.findChildComponent(go, "select/Text", UIComponentType.Text)
	cell.btn = UIComponentType.ButtonAdapter(go)

	function cell.getIndex()
		return cell.index
	end

	function cell.setName(str)
		cell.txtName1.text = str
		cell.txtName2.text = str
	end

	function cell.setTabType(tabType)
		cell.tabType = tabType

		local name = HeroFilterEnum.TabTypeNameLangKey[tabType]

		name = name and lang(name) or ""

		cell.setName(name)
	end

	function cell.getTabType()
		return cell.tabType
	end

	function cell.updateSelect(selectIndex)
		local isSelect = cell.getIndex() == selectIndex

		goutil.setActive(cell.goNormal, not isSelect)
		goutil.setActive(cell.goSelect, isSelect)
	end

	cell.btn:AddClickListener(function()
		self:_onTabCellClick(cell.getIndex())
	end, self)

	function cell.destroyUI()
		cell.btn:RemoveClickListener()
	end

	return cell
end

function M:_onTabCellClick(index)
	local tabType = self._tabTypeLst[index]
	local needRefresh = self._selectTabIndex and self._selectTabIndex ~= index or not self._selectTabIndex

	self._selectTabIndex = index

	if needRefresh then
		self:_refreshView(true)
	end

	for _, cell in pairs(self._tabComps or {}) do
		cell.updateSelect(index)
	end
end

return M
