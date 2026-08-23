local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryCumulativeCell = class("AnniversaryCumulativeCell", require("app.fairyGUI.anniversary.UI_AnniversaryCumulativeCell"))

function AnniversaryCumulativeCell:ctor()
	self.m_bg:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_jianglidi.png"))
	self:addClickListener(handler(self, self._onClick))
end

function AnniversaryCumulativeCell:updateCumulativeCell(arg_2_1, arg_2_2, arg_2_3)
	self._cumulativeId = arg_2_2.id
	self._goods = g.core.common.Goods:convert({
		type = arg_2_2.reward_type,
		value = arg_2_2.reward_value
	})

	self.m_icon:setURL(self._goods.icon)
	self.m_numTxt:setText(g.core.lang:get(109066, {
		num = arg_2_2.reward_size
	}))
	self.m_qualityLoader:setURL("ui://base_new/pic_xmhy_pinzhi_" .. self._goods.quality + 1)
	self.m_timeTxt:setText(g.core.lang:get(431651, {
		time = arg_2_2.num
	}))
	self.m_isFinallyController:setSelectedIndex(arg_2_3 and 1 or 0)

	self._awardState = var_0_0:getJigsawCumulativeState(arg_2_2.id)

	self.m_stateController:setSelectedIndex(self._awardState)
	self:updateProgress(arg_2_1, arg_2_2)
	self.m_effLoop:removeAllEffect()
	self.m_effLoop:addEffectSpine({
		anim = "play",
		name = "eff_ui_anniversaryJigsaw_getglow",
		isLoop = true
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = arg_2_2.id
		}
	})
end

function AnniversaryCumulativeCell:updateProgress(arg_3_1, arg_3_2)
	local var_3_0 = var_0_0:getCumulativeDrawNum()
	local var_3_1 = 0
	local var_3_2 = 1

	if arg_3_1 then
		var_3_1 = math.max(var_3_0 - arg_3_1.num, 0)
		var_3_2 = arg_3_2.num - arg_3_1.num
	else
		var_3_1 = var_3_0
		var_3_2 = arg_3_2.num
	end

	if var_3_2 < var_3_1 then
		var_3_1 = var_3_2
	end

	self.m_progress:setPercent({
		cur = var_3_1,
		max = var_3_2
	})

	if self._awardState ~= var_0_1.CUMULATIVE_AWARD.NOT_GET then
		self.m_endProgress:setPercent({
			cur = 100,
			max = 100
		})
	else
		self.m_endProgress:setPercent({
			cur = 0,
			max = 100
		})
	end
end

function AnniversaryCumulativeCell:_onClick()
	if self._awardState == var_0_1.CUMULATIVE_AWARD.CAN_GET then
		self:dispatchCompEvent("GET_DRAW_NUM_AWARD", {
			cumulativeId = self._cumulativeId
		})
	else
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return AnniversaryCumulativeCell
