local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.model.User.wushTowerData
local var_0_3 = g.core.const.ConstMgr.WushTowerConst
local var_0_4 = g.core.config.dead_tower_enter_info
local var_0_5 = g.core.config.function_info
local WushTowerEntranceComp = class("WushTowerEntranceComp", require("app.fairyGUI.wushTower.UI_WushTowerEntranceComp"))

function WushTowerEntranceComp:ctor()
	self._typeIdx = 1
	self._awardData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function WushTowerEntranceComp:updateEntranceInfo()
	self._typeIdx = self.m_typeController:getSelectedIndex() + 1

	if self._typeIdx == var_0_3.WUSH_NORMAL then
		self:_updateNormalResetTime()
		self.m_failureCount:setValueText((g.core.model.User.wushData:getLeftFailTimes()))

		local var_2_0 = var_0_4.get(var_0_3.WUSH_NORMAL)

		self.m_normaldescTxt:setText(var_2_0.des)
		self.m_enterNameTxt:setText(var_0_5.get(var_2_0.func_id).name)

		self._awardData = self:_getModuleAwards(var_2_0)

		self.m_redPointComp:setId(var_0_3.WUSH_NORAML_REDID)
		self.m_effEnter:removeAllEffect()
		self.m_effEnter:addEffectSpine({
			anim = "play",
			name = "eff_ui_wushTower_enterNormal",
			isLoop = false
		})
	else
		self:_updateHardResetTime()
		self.m_hardFailureCount:setValueText((var_0_2:getChallengeNum()))
		self.m_hardChallengeCount:setValueText((var_0_2:getCanChallengeCount()))

		local var_2_1 = var_0_4.get(var_0_3.WUSH_HARD)

		self.m_hardDescTxt:setText(var_2_1.des)
		self.m_enterNameTxt:setText(var_0_5.get(var_2_1.func_id).name)

		self._awardData = self:_getModuleAwards(var_2_1)

		self.m_redPointComp:setId(var_0_3.WUSH_HARD_REDID)
		self.m_effEnter:removeAllEffect()
		self.m_effEnter:addEffectSpine({
			anim = "play",
			name = "eff_ui_wushTower_enterHard",
			isLoop = false
		})
	end

	self.m_enterTransition:play()
	self.m_rewardList:setNumItems(#self._awardData)
	self:_startScheduleCD()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function WushTowerEntranceComp:_startScheduleCD()
	self._updateHandler = self._updateHandler or self:newSchedule(handler(self, self._onUpdateCountdown), 1)
end

function WushTowerEntranceComp:_onUpdateCountdown()
	self:_updateNormalResetTime()
	self:_updateHardResetTime()
end

function WushTowerEntranceComp:_updateNormalResetTime()
	if var_0_1:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.WUSH) > 0 then
		self.m_resetTime:setValueText(g.core.lang:get(408405))
	else
		self.m_resetTime:setValueText((var_0_0:secondToHMSString(math.max(0, (var_0_0:getOpenLeftTime(24, 0, 0))))))
	end
end

function WushTowerEntranceComp:_updateHardResetTime()
	self.m_hardResetTime:setValueText((var_0_0:secondToHMSString(math.max(0, (g.core.common.ServerTime:getLeftSeconds((var_0_2:getNextResetTime())))))))
end

function WushTowerEntranceComp:_getModuleAwards(arg_7_1)
	local var_7_0 = {}

	for iter_7_0 = 1, var_0_3.AWARD_COUNT do
		if arg_7_1["reward_type_" .. iter_7_0] > 0 then
			table.insert(var_7_0, {
				size = 0,
				type = arg_7_1["reward_type_" .. iter_7_0],
				value = arg_7_1["reward_value_" .. iter_7_0]
			})
		end
	end

	return var_7_0
end

function WushTowerEntranceComp:_onRenderRewardList(arg_8_1, arg_8_2)
	arg_8_2:updateIcon(self._awardData[arg_8_1 + 1])
end

return WushTowerEntranceComp
