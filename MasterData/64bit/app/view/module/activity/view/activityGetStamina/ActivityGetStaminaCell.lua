local var_0_0 = require("app.view.module.activity.const.ActivityGetStaminaConst").RECEIVE_STATE
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.resource_info
local ActivityGetStaminaCell = class("ActivityGetStaminaCell", require("app.fairyGUI.activity.UI_ActivityGetStaminaCell"))

function ActivityGetStaminaCell:ctor()
	self._timeEventInfo = {}
	self._activityGetStaminaData = g.core.model.User.activityGetStaminaData

	self:_initView()
end

function ActivityGetStaminaCell:_initView()
	self.m_getBtn:addClickListener(handler(self, self._onClickGetBtn))
	self.m_iconLoader:setURL(var_0_2:convert({
		type = var_0_2.TYPE_ITEM,
		value = var_0_2.ITEM.TYPE_STAMINA_PILL
	}).bigIcon)
	self.m_currencyIconLoader:setURL((g.core.common.Path:getIconByTypeValue(var_0_2.TYPE_GOLD)))
end

function ActivityGetStaminaCell:updateCell(arg_3_1)
	self._timeEventInfo = arg_3_1

	self.m_indexTxt:setText(string.format("%02d", arg_3_1.num))
	self.m_getAwardTimeTxt:setText(g.core.lang:get(401001, {
		startTime = var_0_1:secondToHMString(arg_3_1.open_time),
		endTime = var_0_1:secondToHMString(arg_3_1.end_time)
	}))

	local var_3_0 = self._activityGetStaminaData:getStaminaInfo(arg_3_1.num)

	self.m_resupplyDescTxt:setText(var_3_0.saying_about_meal)
	self.m_nameTxt:setText(var_3_0.name)
	self.m_contentTxt:setText(g.core.lang:get(401002, {
		name = var_0_3.fetch(var_0_2.RESOURCE.TYPE_STAMINA).name,
		num = var_3_0.stamina
	}))
	self.m_currencyNumTxt:setText(var_3_0.supplement_cost)

	local var_3_1 = self._activityGetStaminaData:getReceivedState(arg_3_1)

	self.m_stateController:setSelectedIndex(var_3_1)

	if var_3_1 == 0 or var_3_1 == 1 then
		self.m_getBtn:setCtrlState("style", {
			index = 3
		})
	else
		self.m_getBtn:setCtrlState("style", {
			index = 6
		})
	end
end

function ActivityGetStaminaCell:_onClickGetBtn()
	local var_4_0 = self._activityGetStaminaData:getReceivedState(self._timeEventInfo)

	if var_4_0 == var_0_0.CAN_RECEIVE then
		local var_4_1 = self._activityGetStaminaData:getId(self._timeEventInfo)

		if self._activityGetStaminaData:isOverflowIfGet(var_4_1) then
			g.core.module.ModuleManager:tip(g.core.lang:get(401005))
		else
			g.core.network.GameNetProxy:send_C2S_GetStamina_Get({
				id = var_4_1
			})
		end
	elseif var_4_0 == var_0_0.CAN_RETROACTIVE then
		local var_4_2 = self._activityGetStaminaData:getId(self._timeEventInfo)

		if self._activityGetStaminaData:isOverflowIfGet(var_4_2) then
			g.core.module.ModuleManager:tip(g.core.lang:get(401005))
		elseif self._activityGetStaminaData:isEnoughMoneyRetroactive(var_4_2) then
			self:_onRetroactive()
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(401008))
		end
	elseif var_4_0 == var_0_0.NOT_RECEIVED then
		g.core.module.ModuleManager:tip(g.core.lang:get(401003))
	elseif var_4_0 == var_0_0.RECEIVED then
		g.core.module.ModuleManager:tip(g.core.lang:get(401004))
	end
end

function ActivityGetStaminaCell:_onRetroactive()
	local var_5_0 = self._activityGetStaminaData:getId(self._timeEventInfo)
	local var_5_1 = self._activityGetStaminaData:getStaminaInfo(var_5_0)

	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(401007),
		desc = g.core.lang:get(401006, {
			num1 = var_5_1.supplement_cost,
			name2 = var_0_3.fetch(var_0_2.RESOURCE.TYPE_STAMINA).name,
			num2 = var_5_1.stamina
		}),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_GetStamina_Get({
				id = var_5_0
			})
		end
	})))
end

function ActivityGetStaminaCell:playEnterAni()
	self.m_enterTransition:play()
end

return ActivityGetStaminaCell
