local var_0_0 = g.core.model.User.guildData
local var_0_1 = g.core.model.User.guildStatueData
local var_0_2 = g.core.config.guild_worship_mission_info
local var_0_3 = g.core.model.User.guildWorshipData
local var_0_4 = g.core.model.User
local DebugOneKeyGuildTask = class("DebugOneKeyGuildTask", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyGuildTask:initData()
	self._oneKeyName = "一键公会任务"
	self._needAddEventList = {
		[g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO] = handler(self, self._onRcvGetInfo),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETINFO] = handler(self, self._onRcvGetInfo),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETINFO] = handler(self, self._onRcvGetInfo),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_SENDGIFT] = handler(self, self._onS2CSendGift),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_ONEKEYSTAGEAWARD] = handler(self, self._onS2CGetStatueAward),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_DOCAST] = handler(self, self._onS2CDoCast),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION] = handler(self, self._onS2CTaskFinish),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETINFO] = handler(self, self._onRcvGetInfo),
		[g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD] = handler(self, self._onS2CProgressAward)
	}
end

function DebugOneKeyGuildTask:doOneKey()
	if not var_0_4:isJoinGuild() then
		self._isFinish = true

		return "未加入公会"
	end

	if self:hasSending() then
		return
	end

	if not self._isGetInfo then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
		end)
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildWorship_GetInfo({})
		end)
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildStatue_GetInfo({})
		end)
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildWorship_GetInfo({})
		end)

		return
	end

	if g.core.model.User.resourceData:getVit() <= 900 then
		if var_0_0:canSendGift() then
			for iter_2_0, iter_2_1 in pairs((var_0_3:getSendGiftMemberData())) do
				if not iter_2_1.isHasGetGift then
					local var_2_0 = iter_2_1.user.id

					self:send(function()
						g.core.network.GameNetProxy:send_C2S_Guild_SendGift({
							member_id = var_2_0
						})
					end)

					return
				end
			end
		end
	else
		self:insertLog("体力有点多，请先清下体力")
	end

	if var_0_1:hasStatueStageAward() then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildStatue_OneKeyStageAward({})
		end)

		return
	end

	local var_2_1 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_STATUE_STONE)

	if var_2_1 > 0 then
		for iter_2_2, iter_2_3 in pairs((var_0_1:getStatueData())) do
			local var_2_2 = iter_2_3.type

			if var_0_1:getPartStateByType(iter_2_3.type) == 0 then
				local var_2_3 = math.ceil((g.core.config.guild_statue_info.get(iter_2_3.base_id).progress - iter_2_3.progress) / 5)
				local var_2_4 = var_2_3 < var_2_1 and var_2_3 or var_2_1
				local var_2_5 = var_0_1:getLastStoneTimes()

				if var_2_5 < (var_2_3 < var_2_1 and var_2_3 or var_2_1) then
					var_2_4 = var_2_5
				end

				if var_2_4 > 0 then
					self:send(function()
						g.core.network.GameNetProxy:send_C2S_GuildStatue_DoCast({
							cast_type = 2,
							value = 5,
							type = var_2_2,
							stone = var_2_4
						})
					end)

					return
				end
			end
		end
	end

	for iter_2_4, iter_2_5 in pairs((var_0_3:getTaskList())) do
		local var_2_6 = iter_2_5.id or 1
		local var_2_7 = var_0_2.get(var_2_6)
		local var_2_8, var_2_9, var_2_10 = var_0_3:getTaskStateById(var_2_6)

		if var_2_7.type == 1 then
			if var_0_3:getWorshipNumById(var_2_6) == 0 then
				self:sendFinishMissionById(var_2_6)

				return
			end
		elseif var_2_8 == 1 then
			self:sendFinishMissionById(var_2_6)

			return
		end
	end

	local var_2_11 = var_0_0:getCfg(var_0_3:getGuildLevelAtZero() or 1)

	for iter_2_6 = 1, 4 do
		if not var_0_3:isWorshipAwardReceive(iter_2_6) and var_0_3:getWorshipProgress() >= var_2_11["worship_value_" .. iter_2_6] then
			self:send(function()
				g.core.network.GameNetProxy:send_C2S_GuildWorship_GetProgressAward({
					index = iter_2_6
				})
			end)

			return
		end
	end

	self._isFinish = true
end

function DebugOneKeyGuildTask:sendFinishMissionById(arg_11_1)
	self:send(function()
		g.core.network.GameNetProxy:send_C2S_GuildWorship_FinishMission({
			num = 1,
			id = arg_11_1
		})
	end)
end

function DebugOneKeyGuildTask:_onRcvGetInfo(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self._isGetInfo = true

	return "获得info数据"
end

function DebugOneKeyGuildTask:_onS2CSendGift(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = "成功赠送礼物给："
	local var_14_1 = var_0_0:getGuildMemberByPlayerId(arg_14_4.member_id)

	var_0_3:setCurGuildPlayerSendGiftRecord(var_14_1.user.guild_id, arg_14_4.member_id)

	if var_14_1 then
		var_14_0 = var_14_0 .. var_14_1.user.name
	end

	return var_14_0
end

function DebugOneKeyGuildTask:_onS2CGetStatueAward(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	return "领取高能奖励成功"
end

function DebugOneKeyGuildTask:_onS2CDoCast(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	return "高能反应堆充能成功"
end

function DebugOneKeyGuildTask:_onS2CProgressAward(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	return "任务进度奖励领取成功"
end

function DebugOneKeyGuildTask:_onS2CTaskFinish(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	return var_0_2.get(arg_18_4.id or 1).name .. "完成"
end

return DebugOneKeyGuildTask
