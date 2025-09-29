-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroDetailFragmentView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroDetailFragmentView", package.seeall)

local M = class("HandbookHeroDetailFragmentView", CharacterDetailFragmentView)

function M:buildUI()
	M.super.buildUI(self)

	self._txtExperienceTitle = self:getText("character_detail_panel_copy_1508031381")
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._txtExperienceTitle = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
end

function M:onEnter()
	self._photoUnit = nil

	M.super.onEnter(self)
	self:hideFunctionBtn()
end

function M:onExit()
	self._photoUnit = nil

	M.super.onExit(self)
end

function M:hideFunctionBtn()
	goutil.setActive(self._btnTacit.gameObject, false)
	goutil.setActive(self._btnDeta.gameObject, false)
	goutil.setActive(self._btnIncrExp.gameObject, false)
	goutil.setActive(self._levelExp.gameObject, false)
end

function M:_initTacit()
	return
end

function M:_onClickCloth()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleSkin, true) then
		return
	end

	ViewMgr.instance:open(ViewName.HandbookHeroIntelligenceView, self._heroData)
end

function M:showCharacterInfo()
	M.super.showCharacterInfo(self)

	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(self._heroData:getId())

	self._txtExperience.text = nil
	self._txtExperienceTitle.text = "CV." .. heroInfoCO.CV
end

function M:_handleOnSystemOpen()
	return
end

return M
