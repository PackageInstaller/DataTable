local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr.GuildCommonConst
local var_0_2 = g.core.model.User.guildWorshipData
local var_0_3 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.model.User.shopData
local var_0_6 = g.core.model.User.guildData
local SpiritHelpGuildTaskContribute = class("SpiritHelpGuildTaskContribute", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))
local var_0_8 = 1

function SpiritHelpGuildTaskContribute:initData()
	self._cellName = "SpiritHelpCell2"
	self._isLoadCount = false
	self._needAddEventList = {
		[var_0_4.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION_ONEKEY] = handler(self, self._onRcvFinishMission)
	}
end

function SpiritHelpGuildTaskContribute:getMaxCount()
	return #var_0_5:getBuyPriceInfo(var_0_1.priceId) - self:getWorshipCount()
end

function SpiritHelpGuildTaskContribute:getCountCostItem()
	local var_3_0 = 0

	for iter_3_0 = 1, self:getCurCount() do
		var_3_0 = var_3_0 + var_0_5:getBuyPrice(var_0_1.priceId, self:getWorshipCount() + iter_3_0)
	end

	return {
		value = 0,
		type = var_0_0.TYPE_GOLD,
		size = var_3_0
	}
end

function SpiritHelpGuildTaskContribute:getWorshipCount()
	return var_0_2:getWorshipNumById(var_0_8) or 0
end

function SpiritHelpGuildTaskContribute:refreshState()
	self._state = var_0_3.STATE.FINISH
	self._isTip = false
	self._tipStr = ""

	if not var_0_6:hasGuild() then
		self._state = var_0_3.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409512)

		return
	end

	local var_5_0, var_5_1, var_5_2 = var_0_2:getTaskStateById(var_0_8)

	if self:getWorshipCount() == 0 then
		self._state = var_0_3.STATE.NORMAL

		self:setCurCount(1)
	else
		self:setCurCount(0)

		self._state = var_0_3.STATE.FINISH
	end
end

function SpiritHelpGuildTaskContribute:doing()
	if self:getCurCount() > 0 then
		local var_6_0 = {
			is_helper = true,
			id = {
				var_0_8
			},
			num = {
				self:getCurCount()
			}
		}

		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GuildWorship_FinishMission_OneKey(var_6_0)
		end)
	end

	self._isFinish = true
end

function SpiritHelpGuildTaskContribute:_onRcvFinishMission(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:addCurDoAward(arg_8_4.awards)
	self:setDoingState(var_0_3.DOING_STATE.SUCCESS)
end

return SpiritHelpGuildTaskContribute
