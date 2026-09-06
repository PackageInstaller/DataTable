-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/config/BonusConfig.lua

module("logic.extensions.bonus.config.BonusConfig", package.seeall)

local BonusConfig = class("BonusConfig", BaseConfig)

function BonusConfig:onInit()
	BonusConfig.super.onInit(self)

	self._cfg = nil
	self.publicbetarebate = false
end

function BonusConfig:getNames()
	return {
		"bonusview",
		"activitysetview",
		"bonusview_tab",
		"preferentialview"
	}
end

function BonusConfig:handleConfig(name, content)
	if name == "bonusview" then
		self._cfg = content
	elseif name == "activitysetview" then
		self._activitySetCfg = content
	elseif name == "bonusview_tab" then
		self._bonusview_tab = {}

		for i, v in ipairs(content) do
			table.insert(self._bonusview_tab, {
				id = -1 * i,
				tabId = v.tabId,
				tabName = v.tabName,
				tagName = v.tagName,
				tagColor = v.tagColor
			})
		end
	elseif name == "preferentialview" then
		self._preferentialcfgs = content
	end
end

function BonusConfig:getCfgById(id)
	return self._cfg[id]
end

function BonusConfig:getCfgs()
	return self._cfg.dataList
end

function BonusConfig:getCfgByFunid(funid)
	for k, v in pairs(self._cfg) do
		if v.funcId == funid then
			return v
		end
	end
end

function BonusConfig:getCfgByTab(tab)
	local result = {}

	for i, cfg in ipairs(self._cfg.dataList) do
		if cfg.tab == tab then
			table.insert(result, cfg)
		end
	end

	if #result > 1 then
		table.sort(result, function(a, b)
			return a.rank < b.rank
		end)
	end

	return result
end

function BonusConfig:getActivitySetCfgs()
	return self._activitySetCfg
end

function BonusConfig:getTabCfg()
	return self._bonusview_tab
end

function BonusConfig:getPreferentialCfgs()
	return self._preferentialcfgs
end

BonusConfig.instance = BonusConfig.New()

return BonusConfig
