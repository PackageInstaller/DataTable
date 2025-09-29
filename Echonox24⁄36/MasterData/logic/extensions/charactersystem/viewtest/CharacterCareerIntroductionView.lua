-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/viewtest/CharacterCareerIntroductionView.lua

module("logic.extensions.charactersystem.viewtest.CharacterCareerIntroductionView", package.seeall)

local M = class("CharacterCareerIntroductionView", ViewComponent)
local PageEnum = {
	Career = 1,
	Label = 2
}

function M:buildUI()
	self._btnBg = self:getBtn("1&middle_tips_common_bg_-1572128605")
	self._btnReturn = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._careerItem = self:getGo("career_introduction_tips_-1468112102")
	self._content = self:getGo("career_introduction_tips_-162135041")
	self._panelCareer = self:getGo("career_introduction_tips_-1521282804")
	self._panelLabel = self:getGo("career_introduction_tips_-656307901")
	self._labelParent = self:getGo("career_introduction_tips_-1496561019")
	self._labelGroup = self:getGo("career_introduction_tips_672041155")
	self._labelItem = self:getGo("career_introduction_tips_-1319436942")

	local tabList = self:getGo("2&universal_tips_tab_top_-1642209997")

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	local tab1 = goutil.addComponentOnce(goutil.findChild(tabList, "tab2"), UIComponentType.SpaceXToggle)
	local tab2 = goutil.addComponentOnce(goutil.findChild(tabList, "tab1"), UIComponentType.SpaceXToggle)

	self._toggleTabControl:addToggleTab(tab1)
	self._toggleTabControl:addToggleTab(tab2)

	self._careerItems = {}
	self._labelItems = {}

	goutil.setActive(self._labelGroup, false)
	goutil.setActive(self._careerItem, false)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnBg:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function M:onEnter()
	local index = self:getFirstParam() or 1

	self._toggleTabControl:selectTab(index)

	self._curIndex = index
end

function M:setPage(tabIndex)
	if self._curIndex == tabIndex then
		return
	end

	self._curIndex = tabIndex

	self:selectPage(tabIndex)
end

function M:selectPage(index)
	if index == PageEnum.Career then
		goutil.setActive(self._panelCareer, true)
		goutil.setActive(self._panelLabel, false)
		self:refreshCareer()
	elseif index == PageEnum.Label then
		goutil.setActive(self._panelCareer, false)
		goutil.setActive(self._panelLabel, true)
		self:refreshLabel()
	end
end

function M:refreshLabel()
	local conf = GuideConfig.instance:getIntroLabelDict()

	for i, v in ipairs(conf) do
		if not self._labelItems[i] then
			if i % 2 == 1 then
				self._lastGroup = goutil.cloneAndSetParent(self._labelGroup, self._labelParent.transform)

				goutil.setActive(self._lastGroup, true)

				local cell = goutil.findChild(self._lastGroup, "item1_1")

				goutil.setActive(cell, true)

				local labelCell = Astral.LuaComponentContainer.Add(cell, CharacterIntroCell)

				table.insert(self._labelItems, labelCell)
			else
				local cell = goutil.cloneAndSetParent(self._labelItem, self._lastGroup.transform)

				goutil.setActive(cell, true)

				local labelCell = Astral.LuaComponentContainer.Add(cell, CharacterIntroCell)

				table.insert(self._labelItems, labelCell)
			end
		end

		self._labelItems[i]:updateLabelData(v)
	end
end

function M:refreshCareer()
	local conf = GuideConfig.instance:getIntroCareerConfig()

	for i, v in ipairs(conf) do
		if not self._careerItems[i] then
			local item = goutil.cloneAndSetParent(self._careerItem, self._content.transform)
			local introCell = Astral.LuaComponentContainer.Add(item, CharacterIntroCell)

			goutil.setActive(item, true)
			table.insert(self._careerItems, introCell)
		end

		self._careerItems[i]:updateCareerData(v)
	end
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._careerItems = nil
	self._labelItems = nil
	self._lastGroup = nil
end

function M:_onClickReturn()
	self:back()
end

return M
