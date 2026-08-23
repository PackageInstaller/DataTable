local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User
local var_0_4 = g.core.model.User.guildDungeonData
local DebugOneKeyGuildDungeon = class("DebugOneKeyGuildDungeon", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyGuildDungeon:initData()
	self._oneKeyName = "一键枯叶行动领宝箱"
	self._needAddEventList = {
		[var_0_2.EVENT_NET_S2C_GUILD_GETINFO] = handler(self, self._onS2CGetInfo),
		[var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_GETINFO] = handler(self, self._onS2CGetInfo),
		[var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYGETFINISHAWARD] = handler(self, self._onGetDungeonAward),
		[var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH] = handler(self, self._onDungeonBattleEnd)
	}
end

function DebugOneKeyGuildDungeon:doOneKey()
	if not var_0_3:isJoinGuild() or not var_0_0:isFunctionUnlock(var_0_1.GUILD_DUNGEON) then
		self._isFinish = true

		return "未达到条件"
	end

	if self:hasSending() then
		return
	end

	if not self._isGetInfo then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
		end)
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetInfo({})
		end)

		return
	end

	if self:getMaxStageId() > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildDungeon_AttackBegin({
				stage_id = self:getMaxStageId()
			})
		end)

		return
	end

	if var_0_0:isFunctionUnlock(var_0_1.GUILD_DUNGEON_ONEKEY_AWARD) and var_0_4:canReceiveTreasure() then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildDungeon_OneKeyGetFinishAward({})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyGuildDungeon:getMaxStageId()
	return 0
end

function DebugOneKeyGuildDungeon:_onS2CGetInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._isGetInfo = true

	return "信息更新中"
end

function DebugOneKeyGuildDungeon:_onDungeonBattleEnd(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	return "枯叶行动挑战成功"
end

function DebugOneKeyGuildDungeon:_onGetDungeonAward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	return "一键领取枯叶行动宝箱成功"
end

return DebugOneKeyGuildDungeon
