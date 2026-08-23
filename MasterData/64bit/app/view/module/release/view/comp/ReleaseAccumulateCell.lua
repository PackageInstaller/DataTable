local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseAccumulateCell = class("ReleaseAccumulateCell", require("app.fairyGUI.release.UI_ReleaseAccumulateCell"))

function ReleaseAccumulateCell:ctor()
	self:addClickListener(handler(self, self._onClickSelf))
	self.m_eff:addEffectSpine({
		anim = "play_0",
		scale = 0.5,
		isLoop = true,
		name = "eff_ui_common_iconget"
	})
end

function ReleaseAccumulateCell:updateAccumulateCell(arg_2_1, arg_2_2)
	self._rewardInfo = arg_2_1

	self.m_isFirstController:setSelectedIndex(arg_2_2 == 1 and 1 or 0)
	self.m_drawCountTxt:setText(self._rewardInfo.num)

	self._goods = g.core.common.Goods:convert({
		type = self._rewardInfo.reward_type,
		value = self._rewardInfo.reward_value
	})

	if self._goods then
		self.m_icon:setURL(self._goods.icon)
		self.m_numTxt:setText(g.core.lang:get(107073, {
			num = self._rewardInfo.reward_size
		}))
	end

	self._isAward = var_0_0:isGetReleaseReward(self._rewardInfo.id)

	if self._isAward then
		self.m_stateController:setSelectedIndex(2)
		self.m_progBarComp:setValue(100)
	elseif var_0_0:getDrawTime() >= self._rewardInfo.num then
		self.m_stateController:setSelectedIndex(1)
		self.m_progBarComp:setValue(100)
	else
		self.m_stateController:setSelectedIndex(0)
		self.m_progBarComp:setValue(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._rewardInfo.id
		}
	})
end

function ReleaseAccumulateCell:_onClickSelf()
	if self.m_stateController:getSelectedIndex() == 1 then
		g.core.network.GameNetProxy:send_C2S_Release_GetReward({
			id = self._rewardInfo.id
		})
	elseif self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return ReleaseAccumulateCell
