-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/config/BattleStartAnimConfig.lua

module("logic.extensions.battlestartanim.config.BattleStartAnimConfig", package.seeall)

local BattleStartAnimConfig = class("BattleStartAnimConfig", BaseConfig)

function BattleStartAnimConfig:onInit()
	BattleStartAnimConfig.super.onInit(self)

	self.opening_effect = nil
	self.home_page_background = nil
	self.name_frame = nil
	self.opening_effect_common = nil
end

function BattleStartAnimConfig:getNames()
	return {
		"opening_effect",
		"home_page_background",
		"name_frame",
		"opening_effect_common",
		"player_message_skin",
		"battle_user_interface_skin",
		"battle_background_skin",
		"player_message_skin_color"
	}
end

function BattleStartAnimConfig:handleConfig(name, content)
	if name == "opening_effect" then
		self.opening_effect = content
	elseif name == "home_page_background" then
		self.home_page_background = content
	elseif name == "name_frame" then
		self.name_frame = content
	elseif name == "opening_effect_common" then
		self.opening_effect_common = content
	elseif name == "player_message_skin" then
		self.player_message_skin = content
	elseif name == "battle_user_interface_skin" then
		self._battle_user_interface_skin = content
	elseif name == "battle_background_skin" then
		self._battle_background_skin = content
	elseif name == "player_message_skin_color" then
		self.player_message_skin_color = content
	end
end

function BattleStartAnimConfig:getOpeningEffectCfgList()
	return self.opening_effect.dataList
end

function BattleStartAnimConfig:getOpeningEffectCfg(id)
	return self.opening_effect[id]
end

function BattleStartAnimConfig:getHomePageBgCfgList()
	return self.home_page_background.dataList
end

function BattleStartAnimConfig:getHomePageBgCfg(id)
	return self.home_page_background[id]
end

function BattleStartAnimConfig:getNameFrameCfgList()
	return self.name_frame.dataList
end

function BattleStartAnimConfig:getNameFrame(id)
	return self.name_frame[id]
end

function BattleStartAnimConfig:getCommonCfg(key)
	if self.opening_effect_common[key] then
		return self.opening_effect_common[key].value
	end
end

function BattleStartAnimConfig:getPlayerMessageSkinCfg()
	return self.player_message_skin.dataList
end

function BattleStartAnimConfig:getPlayerMessageSkinCfgById(id)
	return self.player_message_skin[id]
end

function BattleStartAnimConfig:getBattleBackgroundSkinCfgs()
	return self._battle_background_skin.dataList
end

function BattleStartAnimConfig:getBattleBackgroundSkinCfg(id)
	return self._battle_background_skin[id]
end

function BattleStartAnimConfig:getBattleUISkinCfgs()
	return self._battle_user_interface_skin.dataList
end

function BattleStartAnimConfig:getBattleUISkinCfg(id)
	return self._battle_user_interface_skin[id]
end

function BattleStartAnimConfig:getPlayerMessageSkinColorCfgById(id)
	return self.player_message_skin_color[id]
end

BattleStartAnimConfig.instance = BattleStartAnimConfig.New()

return BattleStartAnimConfig
