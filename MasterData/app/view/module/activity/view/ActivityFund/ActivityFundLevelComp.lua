local var_0_0 = g.core.const.ConstMgr.ActivityConst
local ActivityFundLevelComp = class("ActivityFundLevelComp", require("app.fairyGUI.activity.UI_ActivityFundLevelComp"))

function ActivityFundLevelComp:ctor()
	self.m_buyAwardTouch:addClickListener(handler(self, self._onClickBuyAward))
	self.m_normalAwardTouch:addClickListener(handler(self, self._onClickNormal))
end

function ActivityFundLevelComp:_onClickNormal()
	if not self._fundData then
		return
	end

	local var_2_0 = self._fundData.normal.info

	if self._fundData.normal.state == 1 then
		g.core.network.GameNetProxy:send_C2S_Recharge_GetFundRechargeAward({
			id = var_2_0.id
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._fundData.normal.info.reward_type_1,
			value = self._fundData.normal.info.reward_value_1
		})
	end
end

function ActivityFundLevelComp:_onClickBuyAward()
	if not self._fundData then
		return
	end

	local var_3_0 = self._fundData.advance.info

	if self._fundData.advance.state == 1 then
		g.core.network.GameNetProxy:send_C2S_Recharge_GetFundRechargeAward({
			id = var_3_0.id
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._fundData.advance.info.reward_type_1,
			value = self._fundData.advance.info.reward_value_1
		})
	end
end

function ActivityFundLevelComp:updateCellView(arg_4_1)
	self._fundData = arg_4_1.data

	self.m_normalAward:updateIcon({
		type = arg_4_1.data.normal.info.reward_type_1,
		value = arg_4_1.data.normal.info.reward_value_1,
		size = arg_4_1.data.normal.info.reward_size_1
	})
	self.m_buyAward:updateIcon({
		type = arg_4_1.data.advance.info.reward_type_1,
		value = arg_4_1.data.advance.info.reward_value_1,
		size = arg_4_1.data.advance.info.reward_size_1
	})
	self.m_stateAward1Controller:setSelectedIndex(arg_4_1.data.normal.state)
	self.m_stateAward2Controller:setSelectedIndex(arg_4_1.data.advance.state)
	self.m_normalEffHolder:removeAllEffect()
	self.m_buyEffHolder:removeAllEffect()

	if arg_4_1.fundType == var_0_0.ACTIVITY_FUND_TYPE.GROWTH then
		self.m_descTxt:setText(g.core.lang:get(405603))
		self.m_lvTxt:setText(g.core.utils.Number.getFormatNum(2, arg_4_1.data.normal.info.num))
		self.m_typeController:setSelectedIndex(0)
	elseif arg_4_1.fundType == var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN then
		self.m_descTxt:setText(g.core.lang:get(405612))
		self.m_dungeonStageTxt:setText(arg_4_1.data.normal.info.num)
		self.m_typeController:setSelectedIndex(1)
	elseif arg_4_1.fundType == var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG then
		self.m_descTxt:setText(g.core.lang:get(405613))
		self.m_wushTxt:setText(arg_4_1.data.normal.info.num)
		self.m_typeController:setSelectedIndex(2)
	elseif arg_4_1.fundType == var_0_0.ACTIVITY_FUND_TYPE.MYSTERY then
		self.m_descTxt:setText(g.core.lang:get(405628))
		self.m_mysteryTxt:setText(arg_4_1.data.normal.info.num)
		self.m_typeController:setSelectedIndex(3)
	elseif arg_4_1.fundType == var_0_0.ACTIVITY_FUND_TYPE.TOWER then
		local var_4_0 = g.core.config.tower_stage_info.get(arg_4_1.data.normal.info.num).stage_order
	end

	if arg_4_1.data.normal.state == 1 then
		self.m_normalEffHolder:addEffectSpine({
			anim = "play",
			name = "eff_ui_passCard_award",
			isLoop = true
		})
	end

	if arg_4_1.data.advance.state == 1 then
		self.m_buyEffHolder:addEffectSpine({
			anim = "play",
			name = "eff_ui_passCard_award",
			isLoop = true
		})
	end
end

return ActivityFundLevelComp
