local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local var_0_1 = g.core.model.User.monopolyDataMgr
local MonopolyPointRewardComp = class("MonopolyPointRewardComp", require("app.fairyGUI.monopoly.UI_MonopolyPointRewardComp"))

function MonopolyPointRewardComp:ctor()
	self._nodeCfg = nil
	self._data = var_0_1:getMonopolyData()

	self:addClickListener(handler(self, self._onRewardNodeClick))
end

function MonopolyPointRewardComp:updatePointItem(arg_2_1, arg_2_2, arg_2_3)
	self._nodeCfg = arg_2_1

	self.m_isLastController:setSelectedIndex(arg_2_2 and 1 or 0)
	self.m_scoreTxt:setText(arg_2_1.num)
	self.m_itemIcon:setURL(g.core.common.Goods:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value
	}).icon)
	self.m_numTxt:setText("x" .. arg_2_1.reward_size)
	self:updateUnrealProgress(arg_2_1, arg_2_3)
	self:updateRewardState(arg_2_1)
end

function MonopolyPointRewardComp:updateRewardState(arg_3_1)
	self.m_eff:removeAllEffect()

	if self._data:isNodeReward(arg_3_1.id) then
		self.m_stateController:setSelectedIndex(MonopolyConst.TASK_STATE.REWARD)
	elseif self._data:getCurScore() >= arg_3_1.num then
		self.m_stateController:setSelectedIndex(MonopolyConst.TASK_STATE.FINISH)
		self.m_eff:addEffectSpine({
			isLoop = true,
			anim = "play_full",
			name = "eff_ui_monopoly_get"
		})
	else
		self.m_stateController:setSelectedIndex(MonopolyConst.TASK_STATE.NOT_FINISH)
	end
end

function MonopolyPointRewardComp:updateUnrealProgress(arg_4_1, arg_4_2)
	if self.m_isLastController:getSelectedIndex() == 1 then
		return
	end

	local var_4_0 = self._data:getCurScore()

	if var_4_0 < arg_4_1.num then
		self.m_progressImg:setScaleX(0)

		return
	end

	local var_4_1 = 4

	if arg_4_2.num - arg_4_1.num <= var_4_0 - arg_4_1.num then
		self.m_progressImg:setScaleX(var_4_1)
	else
		self.m_progressImg:setScaleX(var_4_1 * (var_4_0 - arg_4_1.num) / (arg_4_2.num - arg_4_1.num))
	end
end

function MonopolyPointRewardComp:_onRewardNodeClick()
	if self.m_stateController:getSelectedIndex() == MonopolyConst.TASK_STATE.FINISH then
		g.core.network.GameNetProxy:send_C2S_Monopoly_NodeAward({
			activityId = self._data:getActivityId(),
			node_ids = {
				self._nodeCfg.id
			}
		})
		self.m_eff:addEffectSpine({
			isLoop = false,
			remove = true,
			anim = "play_get",
			name = "eff_ui_monopoly_get"
		})
	else
		g.core.common.GlobalFunc.pushInfoPop({
			type = self._nodeCfg.reward_type,
			value = self._nodeCfg.reward_value
		})
	end
end

return MonopolyPointRewardComp
