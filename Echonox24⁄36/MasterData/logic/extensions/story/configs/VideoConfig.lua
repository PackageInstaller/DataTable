-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/configs/VideoConfig.lua

module("logic.extensions.story.configs.VideoConfig", package.seeall)

local VideoConfig = class("VideoConfig", BaseConfig)

function VideoConfig:onInit()
	self._cfgVidemoInfo = false
end

function VideoConfig:getNames()
	return {
		ConfigName.Video
	}
end

function VideoConfig:handleConfig(name, content)
	if name == ConfigName.Video then
		self._cfgVidemoInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function VideoConfig:getVideoInfoCO(code)
	local videoCO = self._cfgVidemoInfo[code]

	if code > 0 and not videoCO and enableErrorLog then
		printError(string.format("VideoConfig::cannot find video config for code[%s]", code))
	end

	return videoCO
end

VideoConfig.instance = VideoConfig.New()

return VideoConfig
