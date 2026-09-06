-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/config/AchievementConfig.lua

module("logic.extensions.achievement.config.AchievementConfig", package.seeall)

local AchievementConfig = class("AchievementConfig", BaseConfig)

function AchievementConfig:onInit()
	AchievementConfig.super.onInit(self)

	self._cfgs = nil
	self._indexCfgs = nil
	self._levelCfgs = nil
	self._allIndexs = nil
end

function AchievementConfig:getNames()
	return {
		"achievement_define",
		"achievement_index",
		"achievement_level"
	}
end

function AchievementConfig:handleConfig(name, content)
	if name == "achievement_define" then
		self._cfgs = content
		self._cfgMap = {}

		for _, v in ipairs(content.dataList) do
			self._cfgMap[v.root] = self._cfgMap[v.root] or {}
			self._cfgMap[v.root][v.leaf] = self._cfgMap[v.root][v.leaf] or {}

			table.insert(self._cfgMap[v.root][v.leaf], v)
		end
	elseif name == "achievement_index" then
		self._indexCfgs = content
		self._allIndexs = {}

		for k, v in pairs(self._indexCfgs) do
			if tonumber(k) then
				self._allIndexs[k] = 0

				for i, cfg in pairs(v) do
					if i > 0 then
						self._allIndexs[k] = self._allIndexs[k] + 1
					end
				end
			end
		end
	elseif name == "achievement_level" then
		self._levelCfgs = content
	end
end

function AchievementConfig:getCfgById(id)
	return self._cfgs[id]
end

function AchievementConfig:getCfgsByRootAndLeaf(root, leaf)
	root, leaf = self:getRealRootAndLeaf(root, leaf)

	if not self._cfgMap[root] then
		local cfgs = {}

		for k, v in pairs(self._cfgMap[root]) do
			if k == leaf or leaf == 0 then
				for _, cfg in ipairs(v) do
					table.insert(cfgs, cfg)
				end
			end
		end

		table.sort(cfgs, AchievementModel.sortAchievement)

		return cfgs
	end
end

function AchievementConfig:getCfgsMap()
	return self._cfgMap
end

function AchievementConfig:getCfgsList()
	return self._cfgs.dataList
end

function AchievementConfig:getIndexCfg(root, leaf)
	root, leaf = self:getRealRootAndLeaf(root, leaf)

	if self._indexCfgs and self._indexCfgs[root] then
		return self._indexCfgs[root][leaf]
	end

	return nil
end

function AchievementConfig:getRealRootAndLeaf(root, leaf)
	root = checknumber(root)
	leaf = checknumber(leaf)

	local keys = table.keys(self._allIndexs)

	table.sort(keys, function(a, b)
		return a < b
	end)

	root = keys[root + 1]

	if root and self._indexCfgs[root] then
		local t = table.values(self._indexCfgs[root])

		table.sort(t, function(a, b)
			return a.leaf < b.leaf
		end)

		leaf = t[leaf + 1].leaf
	else
		leaf = -1
	end

	return root, leaf
end

function AchievementConfig:getAllIndexs()
	local t = {}

	for k, v in pairs(self._allIndexs) do
		if tonumber(k) ~= nil then
			table.insert(t, -math.abs(v))
		end
	end

	return t
end

function AchievementConfig:getLvCfg(lv)
	if self._levelCfgs ~= nil then
		return self._levelCfgs[lv]
	else
		return nil
	end
end

function AchievementConfig:getLvCfgList()
	return self._levelCfgs.dataList
end

function AchievementConfig:getAchiIndexs()
	return self._indexCfgs
end

AchievementConfig.instance = AchievementConfig.New()

return AchievementConfig
