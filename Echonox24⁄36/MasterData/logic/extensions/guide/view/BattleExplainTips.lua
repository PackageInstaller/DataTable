-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/BattleExplainTips.lua

module("logic.extensions.guide.view.BattleExplainTips", package.seeall)

local M = class("BattleExplainTips", ViewComponent)
local PageEnum = {
	Relation = 1,
	San = 3,
	Weak = 2
}

function M:buildUI()
	self._btnReturn = self:getBtn("battle_explain_tips_128586328")
	self._panels = {
		self:getGo("battle_explain_tips_1625936702"),
		self:getGo("battle_explain_tips_-1227479103"),
		self:getGo("battle_explain_tips_951315881")
	}

	local tabList = self:getGo("2&left_tab_content_-205429629")

	self._tabComp = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "left_tab_content"), LeftTabComp)

	self._tabComp:setActiveTabIndexLst({
		1,
		2,
		3
	})

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	for i = 1, 3 do
		tab = goutil.addComponentOnce(goutil.findChild(tabList, "tab_" .. i), UIComponentType.SpaceXToggle)

		self._toggleTabControl:addToggleTab(tab)
	end
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self._activeIndex = 1

	self._toggleTabControl:selectTab(self._activeIndex)
	self:selectPage(self._activeIndex)
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), self._activeIndex)
end

function M:onExit(reasonTyp)
	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._tabComp:playGuiAniTab(false, isNormalClose)
end

function M:setPage(tabIndex)
	if self._activeIndex == tabIndex then
		return
	end

	local samePage = self._activeIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = self._activeIndex and math.abs(self._activeIndex - tabIndex) <= 1 and 0.2 or duration

	self._tabComp:MoveSelectMark(tabIndex, duration)

	self._activeIndex = tabIndex

	self:selectPage(tabIndex)
end

function M:selectPage(index)
	for i = 1, 4 do
		goutil.setActive(self._panels[i], i == index)
	end
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:_onClickReturn()
	self:back()
end

return M
