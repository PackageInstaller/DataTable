-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/config/BirthdayCakeConfig.lua

module("logic.extensions.birthdaycake.config.BirthdayCakeConfig", package.seeall)

local BirthdayCakeConfig = class("BirthdayCakeConfig", BaseConfig)

function BirthdayCakeConfig:onInit()
	BirthdayCakeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function BirthdayCakeConfig:getNames()
	return {
		"birthday_cake_activity",
		"birthday_cake_task",
		"birthday_cake_config",
		"birthday_cake_store",
		"birthday_cake_world_progress_reward",
		"birthday_cake_buy",
		"canke_xiaonuo_common"
	}
end

function BirthdayCakeConfig:handleConfig(name, content)
	if name == "birthday_cake_activity" then
		self._birthday_cake_activity = content
	elseif name == "birthday_cake_task" then
		self._birthday_cake_task = content
	elseif name == "birthday_cake_config" then
		self._birthday_cake_config = content
	elseif name == "birthday_cake_store" then
		self._birthday_cake_store = content
	elseif name == "birthday_cake_world_progress_reward" then
		self._birthday_cake_world_progress_reward = content
	elseif name == "birthday_cake_buy" then
		self._birthday_cake_buy = content
	elseif name == "canke_xiaonuo_common" then
		self._canke_xiaonuo_common = content
	end
end

function BirthdayCakeConfig:getOpenActivityCfg()
	if self._birthday_cake_activity == nil then
		return self:actTime(-1)
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.BirthdayCake)

	if cfgs == nil then
		return self:actTime(-2)
	end

	for _, item in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.BirthdayCake, item.activityId) then
			return item.activityId
		end
	end

	return self:actTime(-3)
end

function BirthdayCakeConfig:actTime(key)
	printError("lbc=======(-1:没有拿到活动表，表可能为空；-2:y运营-活动时间(改)这个表有问题，没有对应的活动类型；-3:没有在活动时间)     活动id:", key)

	return key
end

function BirthdayCakeConfig:getCfgById(id)
	return self._birthday_cake_activity[id]
end

function BirthdayCakeConfig:getTaskCfgById(activityId, id)
	local cfg = self._birthday_cake_task[activityId]

	if cfg then
		return cfg[id]
	end

	return {}
end

function BirthdayCakeConfig:getWorldRewardCfg(id)
	if self._birthday_cake_world_progress_reward[id] then
		return self._birthday_cake_world_progress_reward[id]
	end

	return {}
end

function BirthdayCakeConfig:getCakeThingsCfg(id)
	if self._birthday_cake_config[id] then
		return self._birthday_cake_config[id]
	end

	return {}
end

function BirthdayCakeConfig:getCakeStoreCfg(storePlan, id)
	local cfg = self._birthday_cake_store[storePlan]

	if cfg then
		return cfg[id]
	end

	return {}
end

function BirthdayCakeConfig:getAllCakeStoreCfg(storePlan)
	local cfg = self._birthday_cake_store[storePlan]

	if cfg then
		return cfg
	end

	return {}
end

function BirthdayCakeConfig:getCakeBuyTimeCfg(id)
	local cfg = self._birthday_cake_buy[id]

	if cfg then
		return cfg
	end

	return {}
end

function BirthdayCakeConfig:getCommonString(key)
	if self._canke_xiaonuo_common[key] then
		return self._canke_xiaonuo_common[key].value
	end

	return ""
end

BirthdayCakeConfig.instance = BirthdayCakeConfig.New()

return BirthdayCakeConfig
