local var_0_0 = g.core.config.recharge_total_info
local var_0_1 = g.core.model.User.rechargeData
local var_0_2 = g.core.model.User.totalRechargeData
local TotalRechargeConst = require("app.view.module.totalRecharge.model.TotalRechargeConst")
local TotalRechargeCell = class("TotalRechargeCell", require("app.fairyGUI.totalRecharge.UI_TotalRechargeCell"))

function TotalRechargeCell:ctor(arg_1_1)
	self._drawState = nil
	self._awardArr = {}
	self._info = {}

	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_receiveBtn:addClickListener(handler(self, self._onReceiveBtnClick))
	self.m_hasDrawComp:addClickListener(handler(self, self._onHasDrawCompClick))
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function TotalRechargeCell:updateCell(arg_2_1)
	self._drawState = arg_2_1.drawState
	self._info = arg_2_1.info

	if arg_2_1.info.id ~= self._info.id then
		self._awardArr = self:_getAwardArr(arg_2_1.info)
	end

	self.m_drawStateController:setSelectedIndex(self._drawState)

	local var_2_0 = var_0_1:getPriceByNum(arg_2_1.info.num, true)
	local var_2_1 = string.gsub(arg_2_1.info.des, "#num#", var_2_0)

	self.m_descTxt:setText((g.core.platform.PlatformProxy:isDmmPC() or nil) and g.core.lang:get(404500, {
		num = var_2_0,
		moneyUnit = var_0_1:getCurrency()
	}))

	local var_2_2 = var_0_1:getPriceByNum(var_0_2:getActivityTotalRecharge(), true)

	self.m_progressComp:setPercent({
		cur = var_2_2,
		max = var_2_0
	})
	self.m_curProgressTxt:setText(var_2_2, nil, true)
	self.m_demandProgressText:setText("/" .. var_2_0, nil, true)
	self.m_awardList:setNumItems(#self._awardArr)
end

function TotalRechargeCell:_onItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardArr[arg_3_1 + 1])
end

function TotalRechargeCell:_onReceiveBtnClick()
	if not var_0_2:getActivityData() then
		g.core.module.ModuleManager:tip(g.core.lang:get(404503))

		return
	end

	if self._drawState == TotalRechargeConst.AWARD_STATE.CAN_GET then
		g.core.network.GameNetProxy:send_C2S_Recharge_GetTotalRechargeAward({
			id = self._info.id
		})
	elseif self._drawState == TotalRechargeConst.AWARD_STATE.CAN_NOT_GET then
		if checknumber(self._info.route_id) > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._info.route_id)
		end
	end
end

function TotalRechargeCell:_onHasDrawCompClick()
	g.core.module.ModuleManager:tip(g.core.lang:get(404502))
end

function TotalRechargeCell:_getAwardArr(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = 1

	while var_0_0.hasKey("reward_type_" .. 1) do
		if arg_6_1["reward_type_" .. 1] > 0 then
			table.insert(var_6_0, {
				type = arg_6_1["reward_type_" .. 1],
				value = arg_6_1["reward_value_" .. var_6_1],
				size = arg_6_1["reward_size_" .. var_6_1]
			})
		end

		var_6_1 = var_6_1 + 1
	end

	return var_6_0
end

return TotalRechargeCell
