-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/utils/StoryArgValueParserUtil.lua

module("logic.extensions.story.core.utils.StoryArgValueParserUtil", package.seeall)

function ParseVector4(value, defaultVector)
	return StoryUtils.ParseVector4(value) or defaultVector
end

function ParseVector3(value, defaultVector)
	return StoryUtils.ParseVector3(value) or defaultVector
end

function ParseVector2(value, defaultVector)
	return StoryUtils.ParseVector2(value) or defaultVector
end
