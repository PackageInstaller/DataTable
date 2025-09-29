-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/Character3DPreviewView.lua

module("logic.extensions.charactersystem.view.preview.Character3DPreviewView", package.seeall)

local M = class("Character3DPreviewView", ViewComponent)

function M:ctor()
	self._heroId = nil
	self._heroCO = nil
	self._heroData = nil
end

function M:buildUI()
	self._goAnchorHint = self:getGo("10&preview_heartanchor_hint_-1379369227")
	self._goAnchorPreview = self:getGo("9&preview_btn_group_1427983253")
	self._btnPreviewAnchor = self:getBtn("9&preview_btn_group_-154828406")
	self._btnClosePreviewAnchor = self:getBtn("9&preview_btn_group_-707336513")
	self._textCareer = self:getText("role_model_preview_view_-1222837786")
	self._goCareer = self:getGo("6&0&career_475494592")
	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(self:getGo("6&role_combat_-1916846192"), RoleCombatCell)
	self._careerCell = Astral.SimpleLuaComponentContainer.Add(self._goCareer, CareerCell)
	self._goDetail = self:getGo("2&role_model_preview_detail_2003533041")
	self._detailComp = Astral.SimpleLuaComponentContainer.Add(self._goDetail, CharacterDetailComp)
	self._quality2Go = {
		[GameEnum.QualityEnum.S] = self:getGo("role_model_preview_view_1745786814"),
		[GameEnum.QualityEnum.A] = self:getGo("role_model_preview_view_1781388356"),
		[GameEnum.QualityEnum.B] = self:getGo("role_model_preview_view_-1903912145"),
		[GameEnum.QualityEnum.C] = self:getGo("role_model_preview_view_-2098246958")
	}
end

function M:onEnter()
	self._heroId = CharacterPreviewModel.instance:getCurHeroId()
	self._heroData = CharacterPreviewModel.instance:getHeroData()
	self._heroCO = CharacterConfig.instance:getCfgInfoByID(self._heroId)

	if self._heroCO == nil then
		printError("hero not found, id = " .. self._heroId)

		return
	end

	self:_tweenMainSceneCam()
	self:_refreshView()
end

function M:bindEvents()
	self._btnPreviewAnchor:AddClickListener(self._onClickPreviewAnchor, self)
	self._btnClosePreviewAnchor:AddClickListener(self._onClickClosePreviewAnchor, self)
end

function M:unbindEvents()
	self._btnPreviewAnchor:RemoveClickListener()
	self._btnClosePreviewAnchor:RemoveClickListener()
end

function M:onExit()
	AirtightRoomController.instance:setPreviewState(nil)
end

function M:destroyUI()
	return
end

function M:_tweenMainSceneCam()
	if self:_isSkillDetailPreview() then
		MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, true, true)
	end
end

function M:_isMaxLevelPreview()
	return CharacterPreviewModel.instance:getShowType() == CharacterPreviewModel.PreviewType.MaxLevel
end

function M:_isSkillDetailPreview()
	return CharacterPreviewModel.instance:getShowType() == CharacterPreviewModel.PreviewType.SkillDetail
end

function M:_refreshView()
	self._detailComp:setData(self._heroId, self._heroCO, self._heroData)
	self:_refreshHeroInfo()
	self:_refreshAirtight()
end

function M:_refreshHeroInfo()
	self._textCareer.text = CharacterCOUtil.getCareerName(self._heroCO.career)

	self._roleCombatCell:updateHeroData(self._heroData)
	self._careerCell:setData(self._heroId)

	local heroQuality = self._heroData:getQuality()

	for quality, go in pairs(self._quality2Go) do
		goutil.setActive(go, quality == heroQuality)
	end
end

function M:_refreshAirtight()
	local isOpen = AirtightRoomUtil.isSystemOpen(false)
	local isInAirtightTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	goutil.setActive(self._goAnchorHint, false)
	goutil.setActive(self._goAnchorPreview, isOpen and not isInAirtightTime)
end

function M:_switchAnchor(isOn)
	goutil.setActive(self._btnPreviewAnchor.gameObject, not isOn)
	goutil.setActive(self._btnClosePreviewAnchor.gameObject, isOn)
	goutil.setActive(self._goAnchorHint, isOn)
	AirtightRoomController.instance:setPreviewState(isOn)
end

function M:_onClickPreviewAnchor()
	self:_switchAnchor(true)
end

function M:_onClickClosePreviewAnchor()
	self:_switchAnchor(false)
end

return M
