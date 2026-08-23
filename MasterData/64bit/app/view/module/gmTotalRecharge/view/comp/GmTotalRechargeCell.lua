local GmTotalRechargeConst = require("app.view.module.gmTotalRecharge.const.GmTotalRechargeConst")
local var_0_1 = GmTotalRechargeConst.TabType
local var_0_2 = g.core.model.User.rechargeData
local var_0_3 = g.core.model.User.gmTotalRechargeData
local GmTotalRechargeCell = class("GmTotalRechargeCell", require("app.fairyGUI.gmTotalRecharge.UI_GmTotalRechargeCell"))

function GmTotalRechargeCell:ctor()
	self._tabType = var_0_1.TOTAL_RECHARGE
	self._cellData = {}

	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_maskLoader:addClickListener(handler(self, self._onClickGetAwardsOrGoToBtn))
	self.m_receiveBtn:addClickListener(handler(self, self._onClickGetAwardsOrGoToBtn))
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function GmTotalRechargeCell:updateCell(arg_2_1, arg_2_2)
	self._tabType = arg_2_1
	self._cellData = arg_2_2

	local var_2_0 = arg_2_2.awardState

	if arg_2_1 == var_0_1.TOTAL_DRAW_CARD then
		self.m_descTxt:setText((g.core.lang:getByString(arg_2_2.info.des, {
			num = arg_2_2.info.task_value
		})))
		self.m_progressComp:setPercent({
			cur = arg_2_2.curValue,
			max = arg_2_2.info.task_value
		})
		self.m_curProgressTxt:setText(arg_2_2.curValue)
		self.m_demandProgressText:setText("/" .. arg_2_2.info.task_value)
	else
		local var_2_1 = var_0_2:getPriceByNum(arg_2_2.info.num, true)
		local var_2_2 = g.core.lang:getByString(arg_2_2.info.des, {
			num = var_2_1
		})

		self.m_descTxt:setText((g.core.platform.PlatformProxy:isDmmPC() or nil) and g.core.lang:get(404500, {
			num = var_2_1,
			moneyUnit = var_0_2:getCurrency()
		}))

		local var_2_3 = var_0_2:getPriceByNum(arg_2_2.curValue, true)

		self.m_progressComp:setPercent({
			cur = var_2_3,
			max = var_2_1
		})
		self.m_curProgressTxt:setText(var_2_3, nil, true)
		self.m_demandProgressText:setText("/" .. var_2_1, nil, true)
	end

	self.m_awardList:setNumItems(#arg_2_2.awardInfoArr)
	self.m_canGetEffDad:removeAllEffect()

	if var_2_0 == GmTotalRechargeConst.AwardState.CAN_GET then
		self.m_canGetEffDad:addEffectSpine({
			isLoop = true,
			name = "eff_ui_GmTotalRecharge_getbtnlight"
		})
	end

	self.m_drawStateController:setSelectedIndex(var_2_0)
end

function GmTotalRechargeCell:_onItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._cellData.awardInfoArr[arg_3_1 + 1])
end

function GmTotalRechargeCell:_onClickGetAwardsOrGoToBtn()
	if self._cellData.awardState == GmTotalRechargeConst.AwardState.CAN_GET then
		local var_4_0 = var_0_3:getGmTotalRechargeActivityId()

		if self._tabType == var_0_1.TOTAL_DRAW_CARD then
			g.core.network.GameNetProxy:send_C2S_Recharge_GetGMTotalRechargeTaskAward({
				activity_id = var_4_0,
				task_id = self._cellData.info.id
			})
		else
			g.core.network.GameNetProxy:send_C2S_Recharge_GetGMTotalRechargeAward({
				activity_id = var_4_0,
				id = self._cellData.info.id
			})
		end
	elseif self._cellData.awardState == GmTotalRechargeConst.AwardState.NOT_REACH then
		if self._cellData.info.route_id > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._cellData.info.route_id)
		end
	else
		g.core.module.ModuleManager:tip((g.core.lang:get(404502)))
	end
end

return GmTotalRechargeCell
