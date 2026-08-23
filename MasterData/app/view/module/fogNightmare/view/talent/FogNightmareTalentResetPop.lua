local FogNightmareTalentResetPop = class("FogNightmareTalentResetPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareTalentResetPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareTalentResetPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_1 = g.core.model.User.fogNightmareData
local var_0_2 = g.core.model.User.shopData

function FogNightmareTalentResetPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curTab = arg_2_1.tab
	self._freeTimes = arg_2_1.freeTimes or 0

	self.m_cancelBtn:addClickListener(handler(self, self._onCancel))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirm))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))

	local var_2_0 = g.core.config.play_num_info.get(75)
	local var_2_1 = var_0_2:getLeftCount(75)

	self.m_checkBtn:setSelected(var_2_1 > 0 and var_0_1:getTalentData():getIsSelectResetPopFree() or var_0_1:getTalentData():getIsSelectResetPop())

	if var_2_1 == 0 then
		self.m_isFreeController:setSelectedIndex(0)

		self._needCost = {
			type = var_2_0.price_type,
			value = var_2_0.price_value,
			size = var_0_2:getBuyPrice(var_2_0.price_add_id, var_0_2:getPlayBuyCount(75) + 1)
		}

		self.m_costComp:updateByTVS(self._needCost)
		self.m_lastTimes:setText(g.core.lang:get(500225, {
			num = var_0_2:getBuyLimitLeft((g.core.config.play_num_info.get(75)))
		}))
	else
		self.m_isFreeController:setSelectedIndex(1)
		self.m_txtFreeCost:setText(g.core.lang:get(500139, {
			num = var_2_1 .. "/" .. var_2_0.reset
		}))
	end

	local var_2_3 = var_0_1:getTalentData():getTalentTabCostNumByTab(self._curTab)

	self._costBack = {
		type = var_2_3[1].type,
		value = var_2_3[1].value,
		size = var_2_3[1].size
	}

	self.m_costBackComp:updateByTVS(self._costBack)
end

function FogNightmareTalentResetPop:_onCheckBtnClick()
	local var_3_0 = self.m_checkBtn:isSelected()

	if var_0_2:getLeftCount(75) > 0 then
		var_0_1:getTalentData():setIsSelectResetPopFree(var_3_0)
	else
		var_0_1:getTalentData():setIsSelectResetPop(var_3_0)
	end
end

function FogNightmareTalentResetPop:_onCancel()
	g.core.module.ModuleManager:popComponent()
end

function FogNightmareTalentResetPop:_onConfirm()
	g.core.network.GameNetProxy:send_C2S_Fog_Talent_Reset({
		tab = self._curTab
	})
	g.core.module.ModuleManager:popComponent()
end

return FogNightmareTalentResetPop
