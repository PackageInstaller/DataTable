-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/criwareAudio/CriwareAudioConfig.lua

module("logic.common.audio.criwareAudio.CriwareAudioConfig", package.seeall)

local M = class("CriwareAudioConfig", BaseConfig)

M._audioCOs = nil

function M:getNames()
	return {
		"criware_audio"
	}
end

function M:handleConfig(name, content)
	if name == "criware_audio" then
		self._audioCOs = content
	end
end

function M:getAudioCOById(Id)
	local co = self._audioCOs[Id]

	if not co then
		self:_audioLog(Id)

		return false
	end

	return co
end

function M:getCOByName(name)
	for i, co in pairs(self._audioCOs) do
		if co.cueName == name then
			return co
		end
	end

	self:_audioLog(name)

	return false
end

function M:_audioLog(str)
	if enableWarnLog then
		printWarn(string.format("criware..<color=yellow>cloud not found audio with [%s] in criware config</color>", str))
	end
end

M.instance = M.New()

return M
