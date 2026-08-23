local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.guildStatueData
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_4 = g.core.config.guild_worship_mission_info
local var_0_5 = g.core.event.enum
local var_0_6 = g.core.model.User.guildData
local SpiritHelpGuildTaskStatue = class("SpiritHelpGuildTaskStatue", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpGuildTaskStatue:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_5.EVENT_NET_S2C_GUILD_STATUE_FASTFINISH] = handler(self, self._onRevStatueFinish),
		[var_0_5.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION] = handler(self, self._onRcvFinishMission)
	}
	self._usedStone = 0
end

function SpiritHelpGuildTaskStatue:refreshState()
	self._isTip = false
	self._tipStr = ""

	if not var_0_6:hasGuild() then
		self._state = var_0_3.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409512)

		return
	end

	if var_0_1:getStatueTimeStage() == 1 then
		self._state = var_0_3.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409513)

		return
	end

	if self:getServerState() == var_0_3.SERVER_STATE.NORMAL then
		self._state = var_0_3.STATE.NORMAL
	elseif self:getServerState() == var_0_3.SERVER_STATE.FINISH then
		self._state = var_0_3.STATE.FINISH
	else
		self._isTip = true
		self._tipStr = g.core.lang:get(109711)
		self._state = var_0_3.STATE.LOCK
	end
end

function SpiritHelpGuildTaskStatue:doing()
	if var_0_2:getCountById(var_0_0.TYPE_ITEM, var_0_0.ITEM.TYPE_STATUE_STONE) > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildStatue_FastFinish({})
		end)
	end

	self._isFinish = true
end

function SpiritHelpGuildTaskStatue:getAwardText(arg_5_1)
	return {
		langId = 409514,
		param = {
			num = self._usedStone
		}
	}
end

function SpiritHelpGuildTaskStatue:_onRevStatueFinish(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._usedStone = arg_6_4.stone_used_curr or 0

	self:addCurDoAward(arg_6_4.awards)

	if arg_6_4.can_award_worship_statue then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildWorship_FinishMission({
				num = 1,
				id = 3
			})
		end)
		self:setDoingState(var_0_3.DOING_STATE.DOING)
	else
		self:setDoingState(var_0_3.DOING_STATE.SUCCESS)
	end
end

function SpiritHelpGuildTaskStatue:_onRcvFinishMission(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_4.get(3)

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
	self:setDoingState(var_0_3.DOING_STATE.SUCCESS)
end

return SpiritHelpGuildTaskStatue
