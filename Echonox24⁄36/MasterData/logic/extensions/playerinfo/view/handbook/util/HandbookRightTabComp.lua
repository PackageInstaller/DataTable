-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/util/HandbookRightTabComp.lua

module("logic.extensions.playerinfo.view.handbook.util.HandbookRightTabComp", package.seeall)

local M = class("HandbookRightTabComp")

function M:ctor(gameObject)
	self.mainGO = gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local rootRect = self._registry:getRectTransform("right_tab_content_-205429629")

	self._tabLstRoot = rootRect.gameObject
	self._tabLst = {}

	table.insert(self._tabLst, self:_buildTab(self._registry:getGo("right_tab_content_-242000516")))
	table.insert(self._tabLst, self:_buildTab(self._registry:getGo("right_tab_content_-1578871314")))
	table.insert(self._tabLst, self:_buildTab(self._registry:getGo("right_tab_content_1651451756")))
	table.insert(self._tabLst, self:_buildTab(self._registry:getGo("right_tab_content_-1691267181")))
	table.insert(self._tabLst, self:_buildTab(self._registry:getGo("right_tab_content_-1462805221")))
	table.insert(self._tabLst, self:_buildTab(self._registry:getGo("right_tab_content_-1190107081")))
end

function M:destroyUI()
	self._tabLstRoot = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self.mainGO = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:getMainGO()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:_buildTab(tabGo)
	local tabInfo = {}

	tabInfo.toggleTab = tabGo:GetComponent(UIComponentType.SpaceXToggle)
	tabInfo.txt1 = goutil.findChildTextComponent(tabGo, "normal/Text1")
	tabInfo.txt2 = goutil.findChildTextComponent(tabGo, "select/Text1")
	tabInfo.icon1 = goutil.findChildImageComponent(tabGo, "normal/icon")
	tabInfo.icon2 = goutil.findChildImageComponent(tabGo, "select/icon")
	tabInfo.redPointRoot = goutil.findChild(tabGo, "red_point").gameObject
	tabInfo.redPointTxt = goutil.findChildTextComponent(tabGo, "red_point/type2/txtNum")

	goutil.setActive(goutil.findChild(tabGo, "red_point/type1").gameObject, false)
	goutil.setActive(goutil.findChild(tabGo, "red_point/type2").gameObject, true)
	goutil.setActive(tabInfo.redPointTxt.gameObject, true)
	goutil.setActive(tabInfo.redPointRoot, false)

	return tabInfo
end

function M:getTabsCount()
	return #self._tabLst
end

function M:getTabComps(index)
	local comps = self._tabLst[index]

	if not comps then
		printError(string.format("不存在index = [%s]的tab", index))
	end

	return comps
end

function M:getToggleTab(index)
	local comps = self:getTabComps(index)

	if comps then
		return comps.toggleTab
	end

	return nil
end

function M:setTabShow(index, show)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.toggleTab.gameObject, show)
	end
end

function M:setTabName(index, str)
	local comps = self:getTabComps(index)

	if comps then
		comps.txt1.text = str
		comps.txt2.text = str
	end
end

function M:getIcons(index)
	local comps = self:getTabComps(index)

	if comps then
		return comps.icon1, comps.icon2
	end

	return nil
end

function M:setIconSprite(index, iconType, iconName)
	local comps = self:getTabComps(index)

	if comps then
		IconLoader.setSprite(comps.icon1, iconType, iconName)
		IconLoader.setSprite(comps.icon2, iconType, iconName)
	end
end

function M:setRedPointNum(index, num)
	num = tonumber(num)

	local comps = self:getTabComps(index)

	if comps then
		comps.redPointTxt.text = num

		goutil.setActive(comps.redPointRoot, num > 0)
	end
end

function M:hideRedPoint(index)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.redPointRoot, false)
	end
end

return M
