local var_0_0 = g.core.common.Goods
local FogNightmareIdleIcon = class("FogNightmareIdleIcon", require("app.fairyGUI.fogNightmare.UI_FogNightmareIdleIcon"))

function FogNightmareIdleIcon:ctor()
	self:addClickListener(handler(self, self._onTouchClick))
end

function FogNightmareIdleIcon:updateIcon(arg_2_1)
	if not arg_2_1 then
		self.m_stateController:setSelectedIndex(0)

		self._goods = nil
	else
		self.m_stateController:setSelectedIndex(1)

		local var_2_0 = var_0_0:convert(arg_2_1)

		self._goods = var_2_0

		self.m_itemLoader:setURL(var_2_0.icon)
		self.m_numTxt:setText(arg_2_1.size)
		self.m_bgLoader:setURL("ui://base_new/pic_wjmy_guaji_reward" .. var_2_0.quality + 1)
	end
end

function FogNightmareIdleIcon:_onTouchClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return FogNightmareIdleIcon
