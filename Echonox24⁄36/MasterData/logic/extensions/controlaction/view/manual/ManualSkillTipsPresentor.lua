-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualSkillTipsPresentor.lua

module("logic.extensions.controlaction.view.manual.ManualSkillTipsPresentor", package.seeall)

local M = class("ManualSkillTipsPresentor", ToolTipsCharacterSkillNormalViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Regulatory_manual_skill_tips,
		ViewlibResPath.BuffDetailItem1,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	}
end

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)
	table.insert(views, ManualCharacterSkillComp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
