-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/skin/HeroSkinConfig.lua

module("logic.extensions.charactersystem.config.skin.HeroSkinConfig", package.seeall)

local M = class("HeroSkinConfig", BaseConfig)

function M:onInit()
	self._heroSkin = {}
	self._skinLabel = {}
	self._skinTransformInfo = {}
end

function M:getNames()
	return {
		ConfigName.HeroSkin,
		ConfigName.SkinLabel,
		ConfigName.SkinPreviewTransformInfo
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.HeroSkin then
		self._heroSkin = content
	elseif name == ConfigName.SkinLabel then
		self._skinLabel = content
	elseif name == ConfigName.SkinPreviewTransformInfo then
		self._skinTransformInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getInfo(id)
	local tableInfo = self._heroSkin
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

function M:getAllInfo()
	return self._heroSkin
end

function M:getSkinLabel(skinId)
	return self._skinLabel[skinId]
end

function M:getSkinPreviewTransform(heroId)
	local result = self._skinTransformInfo[heroId]

	if result == nil then
		result = self._skinTransformInfo[0]
	end

	return result
end

M.instance = M.New()

return M
