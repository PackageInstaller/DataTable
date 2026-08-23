local AncientsSoulEchoComp = class("AncientsSoulEchoComp", require("app.fairyGUI.ancients.UI_AncientsSoulEchoComp"))

function var_0_1.ctor(arg_1_0)
	arg_1_0._tabIndex = 0
end

function var_0_1:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_PETSETKNIGHT, handler(self, self._onRcvSetKnight), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYTEAMCHANGE, handler(self, self._onRcvAncientTeamChange), self)
end

function var_0_1:_onRcvAncientTeamChange(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:updateView()
end

function var_0_1:_onRcvSetKnight()
	self:updateView()
end

function var_0_1:updateView()
	self._echoData = g.core.model.User.ancientsData:getPetEchoData(1)
	self._echoData2 = g.core.model.User.ancientsData:getPetEchoData(2)

	self.m_Comp_echoUser:updateView(self._echoData, 1)
	self.m_Comp_echoKnight:updateView(self._echoData, 1)
	self.m_Comp_echoKnight2:updateView(self._echoData2, 2)
end

return var_0_1
