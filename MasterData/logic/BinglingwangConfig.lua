-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/BinglingwangConfig.lua

module("logic.extensions.timelimitedchallenge.config.BinglingwangConfig", package.seeall)

local BinglingwangConfig = class("BinglingwangConfig", BaseConfig)

function BinglingwangConfig:getNames()
	return {
		"ice_king_challenge_config",
		"ice_king_challenge_monster",
		"ice_king_challenge_creeps",
		"ice_king_bubble_config",
		"ice_king_challenge_progress_prize"
	}
end

function BinglingwangConfig:handleConfig(name, content)
	if name == "ice_king_challenge_config" then
		self._commonCfg = content
	elseif name == "ice_king_challenge_monster" then
		self._monsterCfg = content
	elseif name == "ice_king_challenge_creeps" then
		self._creepsCfg = content
	elseif name == "ice_king_challenge_progress_prize" then
		self._prizeCfg = content
	elseif name == "ice_king_bubble_config" then
		self._bubble_config = content
	end
end

function BinglingwangConfig:getRandBubbleTxt()
	if self._bubble_config then
		local len = #self._bubble_config.dataList
		local idx = math.random(1, len)

		return self._bubble_config[idx].content
	end

	return ""
end

function BinglingwangConfig:getBaseConfig(challengeId)
	return self._commonCfg[challengeId]
end

function BinglingwangConfig:getPrizeCfgs(challengeId)
	if self._prizeCfg and self._prizeCfg[challengeId] then
		local plan = self._prizeCfg[challengeId]
		local list = table.values(plan)

		table.sort(list, function(a, b)
			return a.prizeId < b.prizeId
		end)

		return list
	end
end

function BinglingwangConfig:getMonsterCfg(challengeId, day)
	if self._monsterCfg and self._monsterCfg[challengeId] then
		local cfgList = self._monsterCfg[challengeId]
		local len = #cfgList

		day = math.min(day, len)

		return cfgList[day]
	end
end

function BinglingwangConfig:getCreepsCfg(creepsMasterId)
	if self._creepsCfg and self._creepsCfg[creepsMasterId] then
		return self._creepsCfg[creepsMasterId]
	end
end

BinglingwangConfig.instance = BinglingwangConfig.New()

return BinglingwangConfig
