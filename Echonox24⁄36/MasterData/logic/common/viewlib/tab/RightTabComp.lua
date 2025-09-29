-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tab/RightTabComp.lua

module("logic.common.viewlib.tab.RightTabComp", package.seeall)

local M = class("RightTabComp")

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
	local rootRect = self:getRectTransform("right_tab_content_-205429629")

	self._tabLstRoot = rootRect.gameObject
	self._tabLst = {}

	for i = 0, rootRect.childCount - 1 do
		local go = rootRect:GetChild(i).gameObject

		table.insert(self._tabLst, self:_buildTab(go))
	end
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
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	end
end

function M:getMainGO()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
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

function M:clearActiveTabIndex()
	self._activeTabIds = {}
end

function M:setActiveTabIndexLst(indexIds)
	if not self._activeTabIds then
		self._activeTabIds = {}
	end

	for _, value in ipairs(indexIds or {}) do
		table.insert(self._activeTabIds, value)
	end
end

function M:setActiveTabIndex(index)
	if not self._activeTabIds then
		self._activeTabIds = {}
	end

	table.insert(self._activeTabIds, index)
end

function M:isTabActive(index)
	if self._activeTabIds and #self._activeTabIds > 0 then
		return table.indexof(self._activeTabIds, index)
	end

	return true
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

function M:setIconSprite(index, iconTyp, path)
	if string.nilorempty(path) then
		printWarn(string.format("尝试设置tab[%s]图片为空路径", index))

		return
	end

	local icon1, icon2 = self:getIcons(index)

	if icon1 then
		IconLoader.setSprite(icon1, iconTyp, path)
	end

	if icon2 then
		IconLoader.setSprite(icon2, iconTyp, path)
	end
end

function M:_handleOnSystemOpen(e)
	for i = 1, self:getTabsCount() do
		local lock = not self:getIsSystemOpen(i)
		local online = self:getIsSystemOnline(i)
		local showOnLock = self:getIsSystemShowOnLock(i)
		local forceSetData = self:getForceSetLockData(i)

		if forceSetData then
			lock = forceSetData.lock
			online = forceSetData.online
			showOnLock = forceSetData.showOnLock
		end

		self:setLock(i, lock, online, showOnLock)
	end
end

function M:setSystemOpenLst(systemOpenKeyList)
	if systemOpenKeyList then
		self._systemOpenKeyList = systemOpenKeyList
	end

	self:_handleOnSystemOpen(nil)
end

function M:getIsSystemOpen(tabIndex)
	local key = self._systemOpenKeyList and self._systemOpenKeyList[tabIndex] or -1

	if key > 0 then
		return SystemOpenFacade.instance:isOpen(key, false)
	end

	return true
end

function M:getIsSystemOnline(tabIndex)
	local key = self._systemOpenKeyList and self._systemOpenKeyList[tabIndex] or -1

	if key > 0 then
		return SystemOpenModel.instance:getSystemIsOnline(key, true)
	end

	return true
end

function M:getIsSystemShowOnLock(tabIndex)
	local key = self._systemOpenKeyList and self._systemOpenKeyList[tabIndex] or -1

	if key > 0 then
		return SystemOpenFacade.instance:isShowOnLock(key)
	end

	return true
end

function M:setLock(index, lock, online, showOnLock)
	local comps = self:getTabComps(index)

	if comps then
		local showUI = not lock or lock and showOnLock or not online and showOnLock

		if not self:isTabActive(index) then
			showUI = false
		end

		goutil.setActive(comps.toggleTab.gameObject, showUI)

		if showUI then
			local txtColor = lock and "#E8E8E81E" or "#E8E8E8FF"

			comps.txt1.color = Astral.ColorUtil.ParseColor(txtColor)

			if comps.icon1 then
				local imgColor = lock and "#E8E8E81E" or "#E8E8E8FF"

				comps.icon1.color = Astral.ColorUtil.ParseColor(imgColor)
			end

			goutil.setActive(comps.imgLock.gameObject, lock)
		end
	end
end

function M:forceSetLock(index, lock, online, showOnLock)
	if not self._forceSetLockData then
		self._forceSetLockData = {}
	end

	self._forceSetLockData[index] = {
		lock = lock,
		online = online,
		showOnLock = showOnLock
	}

	self:setLock(index, lock, online, showOnLock)
end

function M:getForceSetLockData(index)
	if self._forceSetLockData then
		return self._forceSetLockData[index]
	end

	return nil
end

function M:setRedDotLst(redDotLst)
	self._redDotLst = redDotLst

	if self._redDotLst then
		for i = 1, self:getTabsCount() do
			local keyList = self._redDotLst[i] and self._redDotLst[i].keyList or nil

			if keyList then
				local comps = self:getTabComps(i)

				if comps and comps.redPointRoot then
					RedDotModel.instance:createDotView({
						dotNode = comps.redPointRoot,
						keyList = keyList
					})
				end
			end
		end
	end
end

function M:setRedPointNum(index, num)
	num = tonumber(num)

	if num > 0 then
		local comps = self:getTabComps(index)

		if comps then
			comps.redPointTxt.text = num

			goutil.setActive(comps.redPointRoot, num > 0)
		end
	else
		self:hideRedPoint(index)
	end
end

function M:hideRedPoint(index)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.redPointRoot, false)
	end
end

function M:_buildTab(tabGo)
	local tabInfo = {}

	tabInfo.toggleTab = tabGo:GetComponent(UIComponentType.SpaceXToggle)
	tabInfo.txt1 = goutil.findChildTextComponent(tabGo, "normal/Text1")
	tabInfo.txt2 = goutil.findChildTextComponent(tabGo, "select/Text1")
	tabInfo.icon1 = goutil.findChildImageComponent(tabGo, "normal/icon")
	tabInfo.icon2 = goutil.findChildImageComponent(tabGo, "select/icon")
	tabInfo.imgLock = goutil.findChildImageComponent(tabGo, "normal/lock")
	tabInfo.redPointRoot = goutil.findChild(tabGo, "red_point").gameObject
	tabInfo.redPointTxt = goutil.findChildTextComponent(tabGo, "red_point/type2/txtNum")

	goutil.setActive(goutil.findChild(tabGo, "red_point/type1").gameObject, false)
	goutil.setActive(goutil.findChild(tabGo, "red_point/type2").gameObject, true)
	goutil.setActive(tabInfo.redPointTxt.gameObject, true)
	goutil.setActive(tabInfo.redPointRoot, false)

	return tabInfo
end

return M
