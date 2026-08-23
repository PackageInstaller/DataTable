local var_0_0 = g.core.const.ConstMgr.SevenDaysConst
local var_0_1 = g.core.const.ConstMgr.SevenDaysConst.RECEIVE_STATE
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.common.GlobalFunc
local var_0_4 = g.core.common.Goods
local SevenDaysIntegralAwardCell = class("SevenDaysIntegralAwardCell", require("app.fairyGUI.sevenDaysActivity.UI_SevenDaysIntegralAwardCell"))

function SevenDaysIntegralAwardCell:ctor()
	self._initialized = false
	self._integralAwardStruct = nil

	self.m_iconLoader:addClickListener(handler(self, self._onClickIcon))
end

function SevenDaysIntegralAwardCell:_initIntegralIcon(arg_2_1)
	if self._initialized then
		return
	end

	self._initialized = true

	self.m_actValueController:setSelectedIndex(arg_2_1 - 1)
	self.m_integralIconLoader:setURL((var_0_2:getIconByTypeValue(var_0_4.TYPE_RESOURCE, (arg_2_1 == var_0_0.ACT_VALUE.PHASE_2 or nil) and var_0_4.RESOURCE.TYPE_COURAGE_2, true)))
end

function SevenDaysIntegralAwardCell:_onClickIcon(arg_3_1)
	if not self._integralAwardStruct then
		return
	end

	local var_3_0 = self._integralAwardStruct:getReceiveState()

	if var_3_0 == var_0_1.CAN_RECEIVE then
		local var_3_1 = g.core.model.User.sevenDaysData:getIntegralAllCanGetAwardId(self._integralAwardStruct:getInfo().type)

		for iter_3_0 = 1, #var_3_1 do
			g.core.network.GameNetProxy:send_C2S_NewSevendays_ScoreAward({
				id = var_3_1[iter_3_0]
			})
		end
	elseif var_3_0 == var_0_1.NOT_ACHIEVED then
		local var_3_2 = self._integralAwardStruct:getInfo()

		var_0_3.pushInfoPop({
			type = var_3_2.reward_type,
			value = var_3_2.reward_value,
			size = var_3_2.reward_size
		})
	end
end

function SevenDaysIntegralAwardCell:updateCell(arg_4_1, arg_4_2)
	self._integralAwardStruct = arg_4_1

	local var_4_0 = arg_4_1:getInfo()

	self:_initIntegralIcon(var_4_0.type)
	self.m_numTxt:setText(g.core.lang:get(403006, {
		num = var_4_0.reward_size
	}))
	self.m_integralTxt:setText(var_4_0.score)
	self.m_topProgBar:setValue((arg_4_1:getProgressRelativePre()))
	self.m_bottomController:setSelectedIndex(arg_4_2 and 1 or 0)

	if arg_4_2 then
		self.m_bottomProgBar:setValue((arg_4_1:getProgressRelativeNext()))
	end

	self.m_receivedController:setSelectedIndex(arg_4_1:getReceiveState() == var_0_1.RECEIVED and 1 or 0)
	self.m_iconLoader:setURL((var_0_2:getIconByTypeValue(var_4_0.reward_type, var_4_0.reward_value)))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		customData = {
			id = var_4_0.id,
			actValue = var_4_0.type
		},
		redPointComp = self.m_redPointComp
	})
end

return SevenDaysIntegralAwardCell
