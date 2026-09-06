-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/config/CantoneseOperaConfig.lua

module("logic.extensions.cantoneseopera.config.CantoneseOperaConfig", package.seeall)

local CantoneseOperaConfig = class("CantoneseOperaConfig", BaseConfig)

function CantoneseOperaConfig:onInit()
	return
end

function CantoneseOperaConfig:getNames()
	return {
		"cantonese_opera_introduce",
		"cantonese_opera_introduce_prize",
		"cantonese_opera_introduce_desc"
	}
end

function CantoneseOperaConfig:handleConfig(name, content)
	if name == "cantonese_opera_introduce" then
		self.cantonese_opera_introduceCfg = content
	elseif name == "cantonese_opera_introduce_prize" then
		self.cantonese_opera_introduce_prizeCfg = content
	elseif name == "cantonese_opera_introduce_desc" then
		self.cantonese_opera_introduce_descCfg = content
	end
end

function CantoneseOperaConfig:getActivityCfg(actId)
	return self.cantonese_opera_introduceCfg[actId]
end

function CantoneseOperaConfig:getPlanCfg(planId, nodeId)
	if self.cantonese_opera_introduce_prizeCfg[planId] then
		return self.cantonese_opera_introduce_prizeCfg[planId][nodeId]
	end
end

function CantoneseOperaConfig:getDescList(id)
	return self.cantonese_opera_introduce_descCfg[id]
end

function CantoneseOperaConfig:getDescListPage(id, page)
	local cfg = {}

	for k, v in pairs(self.cantonese_opera_introduce_descCfg[id]) do
		if v.page == page then
			table.insert(cfg, v)
		end
	end

	return cfg
end

CantoneseOperaConfig.instance = CantoneseOperaConfig.New()

return CantoneseOperaConfig
