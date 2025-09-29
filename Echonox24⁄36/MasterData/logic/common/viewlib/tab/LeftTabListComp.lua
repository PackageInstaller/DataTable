-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tab/LeftTabListComp.lua

module("logic.common.viewlib.tab.LeftTabListComp", package.seeall)

local M = class("LeftTabListComp")

function M:ctor(gameObject)
	self.mainGO = gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._tabCellList = {}
end

function M:Awake()
	self:buildUI()
end

function M:buildUI()
	self.go_tab_item = self._registry:getGo("0&left_tab_list_item_-51389005")
	self.tr_contentParent = self._registry:getRectTransform("left_tab_list_-1655680316")
end

function M:onEnter()
	goutil.setActive(self.go_tab_item, false)
end

function M:onExit()
	return
end

function M:getMainGO()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:getTabsCount()
	if not self._tabCellList then
		return 0
	end

	for i = 1, #self._tabCellList do
		local cell = self._tabCellList[i]

		if not cell:isVisible() then
			return i - 1
		end
	end

	return #self._tabCellList
end

function M:getTabCell(index)
	local cell = self._tabCellList[index]

	if not cell or not cell:isVisible() then
		printError(string.format("不存在index = [%s]的tab", index))

		return
	end

	return cell
end

function M:createTabCell(tabMo)
	local createIndex = self:_getCurCreateIndex()
	local cell = self._tabCellList[createIndex]

	if not cell then
		cell = self:_generateTabCell()
		self._tabCellList[createIndex] = cell
	end

	cell:spawn()
	cell:updateData(tabMo)

	return cell
end

function M:updateTabCell(index, tabMo)
	local cell = self:getTabCell(index)

	if cell then
		cell:updateData(tabMo)
	end
end

function M:resetTabList()
	if not self._tabCellList then
		return
	end

	for i = 1, #self._tabCellList do
		local cell = self._tabCellList[i]

		cell:recycle()
	end
end

function M:_generateTabCell()
	local go = goutil.cloneAndSetParent(self.go_tab_item, self.tr_contentParent)
	local cell = Astral.LuaComponentContainer.Add(go, LeftTabListCell)

	return cell
end

function M:_getCurCreateIndex()
	for i = 1, #self._tabCellList do
		local cell = self._tabCellList[i]

		if not cell:isVisible() then
			return i
		end
	end

	return #self._tabCellList + 1
end

function M:OnDestroy()
	self.mainGO = nil
	self._registry = nil
	self._tabCellList = nil
end

return M
