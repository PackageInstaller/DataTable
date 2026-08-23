local var_0_0 = g.core.model.User.guildWorshipData
local var_0_1 = g.core.model.User.resourceData
local var_0_2 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_3 = g.core.config.guild_worship_mission_info
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.model.User.guildData
local SpiritHelpGuildTaskGift = class("SpiritHelpGuildTaskGift", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpGuildTaskGift:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_4.EVENT_NET_S2C_GUILD_ONEKEYSENDGIFT] = handler(self, self._onRcvAllBlitz),
		[var_0_4.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION] = handler(self, self._onRcvFinishMission)
	}
	self._sendCount = 0
end

function SpiritHelpGuildTaskGift:refreshState()
	self._state = var_0_2.STATE.FINISH
	self._isTip = false
	self._tipStr = ""

	if not var_0_5:hasGuild() then
		self._state = var_0_2.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409512)

		return
	end

	if var_0_1:getVit() >= 1000 then
		self._state = var_0_2.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409518)

		return
	end

	if self:getServerState() == var_0_2.SERVER_STATE.NORMAL then
		self._state = var_0_2.STATE.NORMAL or var_0_2.STATE.FINISH
	end
end

function SpiritHelpGuildTaskGift:doing()
	if self:getServerState() == var_0_2.SERVER_STATE.NORMAL then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Guild_OneKeySendGift({
				member_ids = {}
			})
		end)

		return
	end

	self._isFinish = true
end

function SpiritHelpGuildTaskGift:getAwardText(arg_5_1)
	return {
		langId = 409517,
		param = {
			maxTime = 3,
			finishTime = self._sendCount
		}
	}
end

function SpiritHelpGuildTaskGift:_onRcvAllBlitz(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:addCurDoAward(arg_6_4.awards)

	self._sendCount = arg_6_4.guild_send_count or 0

	local var_6_0 = g.core.model.User:getGuildId()

	for iter_6_0, iter_6_1 in ipairs(arg_6_4.member_ids or {}) do
		var_0_0:setCurGuildPlayerSendGiftRecord(var_6_0, iter_6_1)
	end

	if arg_6_4.can_award_worship_help then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildWorship_FinishMission({
				id = 2,
				num = 1
			})
		end)
		self:setDoingState(var_0_2.DOING_STATE.DOING)
	else
		self:setDoingState(var_0_2.DOING_STATE.SUCCESS)
	end
end

function SpiritHelpGuildTaskGift:_onRcvFinishMission(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_3.get(2)

	self:addCurDoAward({
		{
			value = 45,
			type = g.core.common.Goods.TYPE_RESOURCE,
			size = var_8_0.worship_value
		},
		{
			value = 46,
			type = g.core.common.Goods.TYPE_RESOURCE,
			size = var_8_0.guild_exp
		}
	})
	self:addCurDoAward(arg_8_4.awards)
	self:setDoingState(var_0_2.DOING_STATE.SUCCESS)
end

return SpiritHelpGuildTaskGift
