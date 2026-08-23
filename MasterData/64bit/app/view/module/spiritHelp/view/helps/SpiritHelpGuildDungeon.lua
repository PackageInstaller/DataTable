local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.model.User.guildData
local SpiritHelpGuildDungeon = class("SpiritHelpGuildDungeon", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpGuildDungeon:initData()
	self._cellName = "SpiritHelpCell3"
	self._hasCount = false
	self._isMind = true
	self._helpTipText = g.core.lang:get(409504)
	self._hasHelpShow = false
	self._hasMindBtn = true
	self._needAddEventList = {
		[var_0_3.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYATTACKBEGIN] = handler(self, self._onRcvChallengeBegin),
		[var_0_3.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYATTACKFINISH] = handler(self, self._onRcvChallengeFinish)
	}
	self._lastTimes = 0
end

function SpiritHelpGuildDungeon:getAwardText(arg_2_1)
	return {
		langId = 409505,
		param = {
			count = self._lastTimes - var_0_0:getGuildDungeonTimes()
		}
	}
end

function SpiritHelpGuildDungeon:refreshState()
	self._state = var_0_2.STATE.FINISH
	self._isTip = false

	if not var_0_4:hasGuild() then
		self._state = var_0_2.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(403507)

		return
	end

	self._isTip = false

	local var_3_0 = g.core.config.function_info.get(var_0_1.FUNCTION_TYPE.GUILD_DUNGEON)

	if var_3_0.level_type == 3 and var_0_4:getGuildLevel() < var_3_0.level then
		self._isTip = true
		self._tipStr = g.core.lang:get(409503)
		self._state = var_0_2.STATE.LOCK

		return
	end

	if var_0_0:getGuildDungeonTimes() > 0 then
		self._state = var_0_2.STATE.NORMAL
	end
end

function SpiritHelpGuildDungeon:doing()
	if self:isFinish() then
		return
	end

	local var_4_0 = var_0_0:getGuildDungeonTimes()

	if var_4_0 > 0 then
		self._lastTimes = var_4_0

		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildDungeon_OneKeyAttackBegin({
				auto_award = self:isMind()
			})
		end)
	end

	self._isFinish = true
end

function SpiritHelpGuildDungeon:_onRcvChallengeBegin(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:addSending()
end

function SpiritHelpGuildDungeon:_onRcvChallengeFinish(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:addCurDoAward(arg_7_4.awards)
	self:setDoingState(var_0_2.DOING_STATE.SUCCESS)
end

return SpiritHelpGuildDungeon
