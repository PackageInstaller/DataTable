-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/configs/StoryAttrConfig.lua

module("logic.extensions.story.configs.StoryAttrConfig", package.seeall)

local M = class("StoryAttrConfig", BaseConfig)

function M:onInit()
	return
end

function M:getNames()
	return {}
end

function M:handleConfig(name, content)
	return
end

function M:getStoryCfg(code)
	local storyCfgName = "logic.config.story.t_story_attrinfo_" .. code
	local storyCfg = false
	local f, ret = xpcall(function()
		storyCfg = require(storyCfgName)

		if code > 0 and not storyCfg then
			printError("cloud not found story config with code :" .. code)
		end
	end, debug.traceback)

	return storyCfg and storyCfg.dataList or false
end

function M:getStoryAttrInfo(code, question, index)
	local dataList = self:getStoryCfg(code)

	if dataList then
		for i = 1, #dataList do
			local storyAttrCfg = dataList[i]

			if storyAttrCfg and storyAttrCfg.questionKey == tonumber(question) then
				local dataLen = #storyAttrCfg.attrTypes

				if dataLen < index then
					return false, false
				end

				local tempIndex = tonumber(index)

				return storyAttrCfg.attrTypes[tempIndex], storyAttrCfg.attrValues[tempIndex]
			end
		end
	end

	return false, false
end

M.instance = M.New()

return M
