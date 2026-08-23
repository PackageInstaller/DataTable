local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.rebelData
local SpiritHelpRebel = class("SpiritHelpRebel", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpRebel:initData()
	self._cellName = "SpiritHelpCell2"
	self._isSelect = true
	self._hasMindBtn = true
	self._isMind = true
	self._helpTipText = g.core.lang:get(409502)
	self._hasHelpShow = true
	self._helpPopId = 268
	self._needAddEventList = {
		[var_0_2.EVENT_NET_S2C_REBEL_SPIRITHELP_ONEKEYATTACKBEGIN] = handler(self, self._onRcvChallengeBegin),
		[var_0_2.EVENT_NET_S2C_REBEL_SPIRITHELP_ONEKEY_ATTACKFINISH] = handler(self, self._onRcvChallengeFinish)
	}
	self._lastTimes = 0
end

function SpiritHelpRebel:getMaxCount()
	return var_0_0:getRebelAttack()
end

function SpiritHelpRebel:getAwardText(arg_3_1)
	return {
		langId = 409505,
		param = {
			count = self._lastTimes - var_0_0:getRebelAttack()
		}
	}
end

function SpiritHelpRebel:refreshState()
	self._state = var_0_1.STATE.FINISH

	if var_0_0:getRebelAttack() > 0 then
		self._state = var_0_1.STATE.NORMAL
	end
end

function SpiritHelpRebel:doing()
	if self:hasSending() then
		return
	end

	if var_0_0:getRebelAttack() > 0 and self:getCurCount() > 0 then
		local var_5_0 = false

		var_5_0 = self._isMind and var_0_3:isHotTime() or false
		self._lastTimes = var_0_0:getRebelAttack()

		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Rebel_SpiritHelp_OneKeyAttackBegin({
				count = self:getCurCount(),
				full_blow = var_5_0
			})
		end)
	end

	self._isFinish = true
end

function SpiritHelpRebel:_onRcvChallengeBegin(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:send(function()
		g.core.battle.BattleProxy:fastBattle(arg_7_4.battle_id)
	end)
end

function SpiritHelpRebel:_onRcvChallengeFinish(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:addCurDoAward(arg_9_4.awards)
	self:setDoingState(var_0_1.DOING_STATE.SUCCESS)
end

return SpiritHelpRebel
