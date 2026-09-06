-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/config/AnniversaryPreheatConfig.lua

module("logic.extensions.anniversarypreheat.config.AnniversaryPreheatConfig", package.seeall)

local AnniversaryPreheatConfig = class("AnniversaryPreheatConfig", BaseConfig)

function AnniversaryPreheatConfig:onInit()
	AnniversaryPreheatConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function AnniversaryPreheatConfig:getNames()
	return {
		"anniversary_preheat",
		"anniversary_preheat_prize",
		"anniversary_preheat_danmu",
		"anniversary_preheat_hud"
	}
end

function AnniversaryPreheatConfig:handleConfig(name, content)
	if name == "anniversary_preheat" then
		self._actCfgs = content
	elseif name == "anniversary_preheat_prize" then
		self._prizeCfgs = content
	elseif name == "anniversary_preheat_danmu" then
		self._bulletScreenCfgs = content
	elseif name == "anniversary_preheat_hud" then
		self._hudCfgs = content
	end
end

function AnniversaryPreheatConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function AnniversaryPreheatConfig:getPrizeCfgs(actId)
	return self._prizeCfgs[actId]
end

function AnniversaryPreheatConfig:getBulletScreenCfgs()
	return self._bulletScreenCfgs
end

function AnniversaryPreheatConfig:getBulletScreenCfgById(id)
	return self._bulletScreenCfgs[id]
end

function AnniversaryPreheatConfig:getHudCfgs(actId)
	return self._hudCfgs[actId]
end

AnniversaryPreheatConfig.instance = AnniversaryPreheatConfig.New()

return AnniversaryPreheatConfig
