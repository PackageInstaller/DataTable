-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/config/WelfareSigninConfig.lua

module("logic.extensions.signin.config.WelfareSigninConfig", package.seeall)

local M = class("WelfareSigninConfig", BaseConfig)

function M:onInit()
	self._const = {}
	self._maxDailyRewardDay = 28
	self._maxHistoryRewardDay = {}
	self._cfgDailyReward = {}
	self._cfgHistoryReward = {}
	self._cfgLandLady = {}
	self._cfgLandLadyDialogue = {}
end

function M:getNames()
	return {
		ConfigName.SignInDailyReward,
		ConfigName.SignInHistoryReward,
		ConfigName.SignInLandlady,
		ConfigName.SignInLandladyDialogue,
		ConfigName.SignInConst
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.SignInConst then
		self._const = content
	elseif name == ConfigName.SignInDailyReward then
		for k, v in pairs(content.dataList or {}) do
			self._cfgDailyReward[v.day] = v

			if v.day >= self._maxDailyRewardDay then
				self._maxDailyRewardDay = v.day
			end
		end
	elseif name == ConfigName.SignInHistoryReward then
		for k, v in pairs(content.dataList or {}) do
			self._cfgHistoryReward[v.id] = v

			if not self._maxHistoryRewardDay[v.id] then
				self._maxHistoryRewardDay[v.id] = 0
			end

			local day = v.rewards and #v.rewards or 0

			if day >= self._maxHistoryRewardDay[v.id] then
				self._maxHistoryRewardDay[v.id] = day
			end
		end
	elseif name == ConfigName.SignInLandlady then
		for k, v in pairs(content.dataList or {}) do
			self._cfgLandLady[v.formula] = v
		end
	elseif name == ConfigName.SignInLandladyDialogue then
		for k, v in pairs(content.dataList or {}) do
			self._cfgLandLadyDialogue[v.formula] = v
		end
	end
end

function M:getConstByKey(key)
	return self._const[key] and self._const[key].numValue or 0
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getDailyReward(day)
	local itemId, itemCount = 0, 0
	local cfg = self._cfgDailyReward[day]
	local rewardId = cfg and cfg.reward or nil

	if rewardId then
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)

		if not rewardCO then
			printError(string.format("无法从[t_%s]找到code[%s]的配置", ConfigName.Reward, rewardId))
		end

		if rewardCO.reward and #rewardCO.reward > 0 then
			itemId = rewardCO.reward[1].code
			itemCount = rewardCO.reward[1].num
		end
	else
		printError(string.format("无法从[t_%s]找到day[%s]的配置", ConfigName.SignInDailyReward, day))
	end

	return itemId, itemCount
end

function M:getMaxDailyRewardDay()
	return self._maxDailyRewardDay
end

function M:getMaxHistoryRewardDay(formula)
	return self._maxHistoryRewardDay[formula] or 0
end

function M:getHistoryReward(formula, day)
	local rewardTable

	if self._cfgHistoryReward[formula] and self._cfgHistoryReward[formula].rewards then
		rewardTable = self._cfgHistoryReward[formula].rewards[day]
	end

	if not rewardTable then
		printError(string.format("无法从[t_%s]找到formula[%s] day[%s]的配置", ConfigName.SignInHistoryReward, formula, day))
	end

	return rewardTable
end

function M:getSevenSignInRewardTye(formula, day)
	local rewardType = WelfareSigninEnum.SevenSignInRewardType.Normal

	if self._cfgHistoryReward[formula] and self._cfgHistoryReward[formula].importentRewards and table.indexof(self._cfgHistoryReward[formula].importentRewards, day) then
		rewardType = WelfareSigninEnum.SevenSignInRewardType.Important
	end

	return rewardType
end

function M:getLandLady(formula)
	return self._cfgLandLady[formula]
end

function M:getLandLadyDialogue(formula)
	return self._cfgLandLadyDialogue[formula]
end

M.instance = M.New()

return M
