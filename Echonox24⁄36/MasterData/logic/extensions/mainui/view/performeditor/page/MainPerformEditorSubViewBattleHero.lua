-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewBattleHero.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewBattleHero", package.seeall)

local M = class("MainPerformEditorSubViewBattleHero")
local PageTyp = {
	PosData = 1
}
local PageName = {
	[PageTyp.PosData] = "位置"
}

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()

	self._isInit = true
end

function M:Awake()
	return
end

function M:OnEnable()
	if not self._isInit then
		return
	end
end

function M:OnDestroy()
	self._heroPosComp:destroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._viewRegistry
end

function M:buildUI()
	local registry = self:getRegistry()

	self._heroPosComp = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "ViewPort/Content/posInfo"), BattleHeroPosInfoComp)
	self._toggleCompList = {}

	table.insert(self._toggleCompList, goutil.findChild(self.mainGO, "tabLst/tab_1"):GetComponent(UIComponentType.SpaceXToggle))
	table.insert(self._toggleCompList, goutil.findChild(self.mainGO, "tabLst/tab_2"):GetComponent(UIComponentType.SpaceXToggle))
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil
end

function M:bindEvents()
	for i, v in ipairs(self._toggleCompList) do
		v:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(i, isOn)
			end
		end, nil)
	end
end

function M:unbindEvents()
	for i, v in ipairs(self._toggleCompList) do
		v:RemoveListener()
	end
end

function M:_dealToggleClick(index, isOn)
	if isOn then
		self._heroPosComp:setTabIndex(index)
	end
end

function M:setEvent(add)
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	self._heroPosComp:onEnter()
	self:setEvent(true)

	self._toggleCompList[1].IsOn = true
end

function M:onExit()
	self._heroPosComp:onExit()
	self:setEvent(false)
end

return M
