-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/CharacterLookoverView.lua

module("logic.extensions.charactersystem.view.CharacterLookoverView", package.seeall)

local M = class("CharacterLookoverView", CharacterMainSystemView)
local kNewViewClass = {
	CharacterDetailFragmentView_Lookover,
	CharacterAuthorityFragmentView,
	CharacterEquipLookoverFragmentView,
	CharacterEchoLookoverFragmentView,
	CharacterThinkingLookoverFragmentView
}

function M:buildUI()
	M.super.buildUI(self)
	self:setSystemOpenLst()
	self:hideToggleTabs(2)

	for index, view in ipairs(kNewViewClass) do
		self:changeViewClass(index, view)
	end

	self._otherPlayerUI = true
	self._playerCourseHeroData = PlayerCourseModel.instance:getDisplayData(GameEnum.DisplayTypeEnum.Hero)
	self._heroIds = self._playerCourseHeroData:getDisplayHero()
	self._playerId = PlayerCourseModel.instance:getCourseUserId()
end

function M:_setEvent(add)
	M.super._setEvent(self, add)

	if add then
		GlobalDispatcher:addEventListener(EventType.COURSE_HERO_DETAIL_VIEW, self.showHeroDetail, self)
	else
		GlobalDispatcher:removeEventListener(EventType.COURSE_HERO_DETAIL_VIEW, self.showHeroDetail, self)
	end
end

function M:_getHeroByIndex(index, next)
	local heroId = self._heroIds[index]:getId()
	local heroDetail = self._playerCourseHeroData:getHeroDetail(heroId)

	if heroDetail then
		self:stopVoice()

		self._heroData = heroDetail

		local viewPageMo = HeroDepotModel.instance:getViewPageMo()

		viewPageMo.hero = heroDetail

		self:refreshCharacterInfo(next)
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_MAIN_SYSTEM_SWITCH)
	else
		PlayerCourseAgent.instance:sendGetHeroDetailInfoRequest(self._playerId, heroId)
	end

	self._hasNext = next
end

function M:showHeroDetail(_, heroInfo)
	self:stopVoice()

	self._heroData = self._playerCourseHeroData:createHeroDetail(heroInfo)

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	viewPageMo.hero = self._heroData

	self:refreshCharacterInfo(self._hasNext)
	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_MAIN_SYSTEM_SWITCH)
end

return M
