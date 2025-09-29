-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryGraphAssetWithArg.lua

module("logic.extensions.story.core.graph.assets.StoryGraphAssetWithArg", package.seeall)

local M = class("StoryGraphAssetWithArg", StoryConfigAssetBase)

M.defaultVector4 = Vector4.zero
M.defaultVector3 = Vector3.zero
M.defaultVector2 = Vector2.zero

function M:ctor()
	M.super.ctor(self)

	self.args = {}
end

function M:GetArgValueVector4(key)
	local val = self:GetArgValue(key)

	return StoryArgValueParserUtil.ParseVector4(val, M.defaultVector4)
end

function M:GetArgValueVector3(key)
	local val = self:GetArgValue(key)

	return StoryArgValueParserUtil.ParseVector3(val, M.defaultVector3)
end

function M:GetArgValueVector2(key)
	local val = self:GetArgValue(key)

	return StoryArgValueParserUtil.ParseVector2(val, M.defaultVector2)
end

function M:GetArgValueEnum(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValueBoolean(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseBoolean(val)
end

function M:GetArgValueUInt(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValueInt(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValueFloat(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValueLong(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValueDouble(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValueNumber(key)
	local val = self:GetArgValue(key)

	return StoryUtils.ParseNumber(val)
end

function M:GetArgValue(key)
	local val = self:GetArg(key)

	return val and val.value or nil
end

function M:GetArg(key)
	for k, v in pairs(self.args) do
		if v.key == key then
			return v
		end
	end

	return nil
end

function M:HasAnyArg()
	return #self.args > 0
end

return M
