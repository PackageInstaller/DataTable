-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/config/AssistanceBoxConfig.lua

module("logic.extensions.assistancebox.config.AssistanceBoxConfig", package.seeall)

local AssistanceBoxConfig = class("AssistanceBoxConfig", BaseConfig)

function AssistanceBoxConfig:onInit()
	AssistanceBoxConfig.super.onInit(self)
end

function AssistanceBoxConfig:getNames()
	return {
		"assistance_box_param",
		"assistance_box_prize",
		"assistance_box_define",
		"assistance_box_desc"
	}
end

function AssistanceBoxConfig:handleConfig(name, content)
	if name == "assistance_box_param" then
		self.assistance_box_paramCfg = content
	elseif name == "assistance_box_prize" then
		self.assistance_box_prizeCfg = content
	elseif name == "assistance_box_define" then
		self.assistance_box_defineCfg = content
	elseif name == "assistance_box_desc" then
		self.assistance_box_descCfg = content
	end
end

function AssistanceBoxConfig:getParamValue(key)
	if self.assistance_box_paramCfg[key] then
		return self.assistance_box_paramCfg[key].value
	end

	return ""
end

function AssistanceBoxConfig:getPrizeCfgById(id)
	return self.assistance_box_prize[id]
end

function AssistanceBoxConfig:getDefineCfgById(id)
	return self.assistance_box_defineCfg[id]
end

function AssistanceBoxConfig:getDescById(id)
	return self.assistance_box_descCfg[id]
end

function AssistanceBoxConfig:getDescList()
	return self.assistance_box_descCfg.dataList
end

AssistanceBoxConfig.instance = AssistanceBoxConfig.New()

return AssistanceBoxConfig
