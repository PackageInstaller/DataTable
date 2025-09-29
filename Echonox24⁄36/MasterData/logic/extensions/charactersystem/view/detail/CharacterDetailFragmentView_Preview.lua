-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/detail/CharacterDetailFragmentView_Preview.lua

module("logic.extensions.charactersystem.view.detail.CharacterDetailFragmentView_Preview", package.seeall)

local M = class("CharacterDetailFragmentView_Preview", CharacterDetailFragmentView)

function M:buildUI()
	M.super.buildUI(self)
	self:hideFunctionBtn()
end

function M:hideFunctionBtn()
	goutil.setActive(self._btnCloth.gameObject, false)
	goutil.setActive(self._btnDeta.gameObject, false)
	goutil.setActive(self._btnIncrExp.gameObject, false)
	goutil.setActive(self._specialHint.gameObject, true)
end

function M:_refreshRedDot()
	return
end

function M:showTalentSkillInfo(characterCO)
	local shared = SkillEnhanceMO.getSharedMO(characterCO.battleTalent[1])

	self._talentSkillName.text = shared and shared:getName() or ""

	local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(characterCO.battleTalent[1])

	for i, allEnhanceCode in ipairs(allEnhanceCodes) do
		shared:addSkillEnhanceCode(allEnhanceCode)
	end

	shared:rebuild()

	self._talentSkillDesc.text = shared and shared:getDescription() or ""

	SkillEnhanceMO.releaseSharedMO(shared)
end

function M:_handleOnSystemOpen()
	return
end

return M
