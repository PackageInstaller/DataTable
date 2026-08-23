local var_0_0 = g.core.model.User
local RechargeHotKnightComp = class("RechargeHotKnightComp", require("app.fairyGUI.recharge.UI_RechargeHotKnightComp"))

function RechargeHotKnightComp:ctor()
	self._info = var_0_0.hotSaleData:getShowHotKnightInfo()

	self.m_gotoBtn:addClickListener(handler(self, self._onClickGoto))
end

function RechargeHotKnightComp:updateComp()
	if self._info then
		self.m_picLoader:setURL("pic/hotSaleKnight/" .. self._info.res .. ".png")
		self.m_knight1:setKnight(self._info.knight1)

		if self._info.knight2 ~= 0 then
			self.m_styleController:setSelectedIndex(1)
			self.m_knight2:setKnight(self._info.knight2)
		else
			self.m_styleController:setSelectedIndex(0)
		end
	end
end

function RechargeHotKnightComp:_onClickGoto()
	if self._info then
		g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT)
	end
end

return RechargeHotKnightComp
