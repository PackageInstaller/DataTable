-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroIntelligenceView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroIntelligenceView", package.seeall)

local M = class("HandbookHeroIntelligenceView", CharacterIntelligenceView)

function M:getPrefabSkinItem()
	local path = ResName.Intelligence_cloth_item
	local prefab = self._viewPresentor:getPrefab(path)

	return prefab
end

function M:getPrefabBgItem()
	local path = ResName.Intelligence_background_item
	local prefab = self._viewPresentor:getPrefab(path)

	return prefab
end

function M:_onClickHome()
	self:close()
end

return M
