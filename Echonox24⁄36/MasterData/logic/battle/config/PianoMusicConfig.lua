-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/PianoMusicConfig.lua

module("logic.battle.config.PianoMusicConfig", package.seeall)

local PianoMusicConfig = class("PianoMusicConfig", BaseConfig)

function PianoMusicConfig:onInit()
	self._cfgPianoMusic = false
end

function PianoMusicConfig:getNames()
	return {
		ConfigName.PianoMusic
	}
end

function PianoMusicConfig:handleConfig(name, content)
	if name == ConfigName.PianoMusic then
		self._cfgPianoMusic = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function PianoMusicConfig:getMusicCO(code)
	return self._cfgPianoMusic[code]
end

function PianoMusicConfig:getAudioName(code)
	if self._cfgPianoMusic[code] then
		return self._cfgPianoMusic[code].name
	end

	return "skill_120110_Piano_Test"
end

function PianoMusicConfig:getNotes(code)
	if self._cfgPianoMusic[code] then
		return self._cfgPianoMusic[code].note
	end

	return {}
end

PianoMusicConfig.instance = PianoMusicConfig.New()

return PianoMusicConfig
