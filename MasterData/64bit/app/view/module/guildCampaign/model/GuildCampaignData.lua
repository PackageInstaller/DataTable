local var_0_0 = g.core.config.guild_des_info
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.const.ConstMgr.GuildBossConst
local GuildCampaignData = class("GuildCampaignData", require("app.core.model.BaseData"))

function GuildCampaignData:ctor()
	self:initData()
end

function GuildCampaignData:initData()
	self._playInfoList = {}
	self._playerList = {}
	self._setConfig = nil

	self:_init()
end

function GuildCampaignData:_init()
	self:_initPlayDesInfo()
end

function GuildCampaignData:_initPlayDesInfo()
	self._playInfoList = {}

	for iter_4_0 = 1, var_0_0.getLength() do
		local var_4_0 = {}
		local var_4_1 = var_0_0.indexOf(iter_4_0)

		if var_0_1:isModuleShow(var_4_1.id) and self:isOpenDayFinish(var_4_1.id) then
			var_4_0.cfgInfo = var_4_1
			var_4_0.isLock = true

			table.insert(self._playInfoList, var_4_0)
		end
	end
end

function GuildCampaignData:isOpenDayFinish(arg_5_1)
	if arg_5_1 == g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS then
		return g.core.common.ServerTime:getOpenDays() >= var_0_2.SHOW_NEED_OPEN_DAYS
	else
		return true
	end
end

function GuildCampaignData:_updatePlayDesInfo()
	self:_initPlayDesInfo()

	for iter_6_0, iter_6_1 in ipairs(self._playInfoList) do
		iter_6_1.isLock = not var_0_1:isModuleUnlock((iter_6_1.cfgInfo or {}).id)
		iter_6_1.isHasEnter = self:judgeFunctionHasEnter(iter_6_1.cfgInfo.id)
	end

	table.sort(self._playInfoList, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.isLock and 1 or 0
		local var_7_1 = arg_7_1.isLock and 1 or 0
		local var_7_2 = self:isActivityOpen(arg_7_0.cfgInfo.id)

		if (arg_7_0.isLock and 1 or 0) ~= (arg_7_1.isLock and 1 or 0) then
			return var_7_0 < var_7_1
		else
			if var_7_2 ~= self:isActivityOpen(arg_7_1.cfgInfo.id) then
				return var_7_2
			end

			return arg_7_0.cfgInfo.order < arg_7_1.cfgInfo.order
		end
	end)
end

function GuildCampaignData:isActivityOpen(arg_8_1)
	if arg_8_1 == g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS then
		local var_8_0 = g.core.model.User.guildBossData:getTodayBossInfo()

		return var_8_0 and var_8_0.is_open == 1
	elseif arg_8_1 == g.core.const.ConstMgr.FUNCTION_TYPE.GUILDFIGHT_PLAYERLEVEL then
		return g.core.model.User.GuildFightData:isInOpenTime()
	end

	return true
end

function GuildCampaignData:getPlayDesInfo()
	self:_updatePlayDesInfo()

	return self._playInfoList
end

function GuildCampaignData:getNewestPlay()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self._playInfoList) do
		if iter_10_0 > 4 and not iter_10_1.isHasEnter then
			var_10_0 = iter_10_0
		end
	end

	return var_10_0
end

function GuildCampaignData:getFunctionEnterJudgeStr(arg_11_1)
	return "GuildCampaign" .. tostring(arg_11_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function GuildCampaignData:setFunctionHasEnterRecord(arg_12_1)
	local var_12_0 = self._setConfig

	if not self._setConfig then
		var_12_0 = g.core.common.Storage:load("GuildCampaignRecord.json", false)
		var_12_0 = var_12_0 or {}
	end

	self._setConfig = var_12_0
	self._setConfig[self:getFunctionEnterJudgeStr(arg_12_1)] = "1"

	g.core.common.Storage:save("GuildCampaignRecord.json", self._setConfig, false)
end

function GuildCampaignData:judgeFunctionHasEnter(arg_13_1)
	if (g.core.common.Storage:load("GuildCampaignRecord.json", false) or {})[self:getFunctionEnterJudgeStr(arg_13_1)] then
		return true
	end

	return false
end

return GuildCampaignData
