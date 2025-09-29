-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/configs/StorySceneConfig.lua

module("logic.extensions.story.configs.StorySceneConfig", package.seeall)

local StorySceneConfig = class("StorySceneConfig", BaseConfig)

function StorySceneConfig:onInit()
	self._cfgPlotSceneInfo = false
end

function StorySceneConfig:getNames()
	return {
		ConfigName.PlotScene
	}
end

function StorySceneConfig:handleConfig(name, content)
	if name == ConfigName.PlotScene then
		self._cfgPlotSceneInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function StorySceneConfig:getPlotSceneInfoCO(code)
	local sceneCO = self._cfgPlotSceneInfo[code]

	if code and code > 0 and not sceneCO and enableErrorLog then
		printError(string.format("StorySceneConfig::cannot find scene config for code[%s]", code))
	end

	return sceneCO
end

function StorySceneConfig:getPlotSceneCOByName(name)
	for _, v in pairs(self._cfgPlotSceneInfo) do
		if v.name == name then
			return v
		end
	end

	return false
end

StorySceneConfig.instance = StorySceneConfig.New()

return StorySceneConfig
