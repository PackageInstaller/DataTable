-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aocore/AocoreConfig.lua

module("logic.extensions.aocore.AocoreConfig", package.seeall)

local AocoreConfig = class("AocoreConfig", BaseConfig)

function AocoreConfig:onInit()
	AocoreConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function AocoreConfig:getNames()
	return {
		"aocore",
		"qicore"
	}
end

function AocoreConfig:handleConfig(name, content)
	if name == "aocore" then
		self._cofignameCfg = content
	elseif name == "qicore" then
		self._qicore = content
	end
end

function AocoreConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function AocoreConfig:getCfgList()
	local list = self._cofignameCfg.dataList

	table.sort(list, function(a, b)
		if a.order ~= b.order then
			return checknumber(a.order) < checknumber(b.order)
		else
			return a.id < b.id
		end
	end)

	return list
end

function AocoreConfig:getQiCoreCfgById(id)
	return self._qicore[id]
end

function AocoreConfig:getQiCoreCfgList()
	local list = self._qicore.dataList

	table.sort(list, function(a, b)
		if a.order ~= b.order then
			return checknumber(a.order) < checknumber(b.order)
		else
			return a.id < b.id
		end
	end)

	return list
end

AocoreConfig.instance = AocoreConfig.New()

return AocoreConfig
