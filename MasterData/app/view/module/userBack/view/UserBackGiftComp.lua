local var_0_0 = g.core.model.User.userBackData
local UserBackGiftComp = class("UserBackGiftComp", require("app.fairyGUI.userBack.UI_UserBackGiftComp"))

function UserBackGiftComp:ctor()
	self._giftCfgData = var_0_0:getGiftCfgData()

	self:_initView()
end

function UserBackGiftComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_USER_BACK_BUYGIFT, handler(self, self._onRcvGetGiftAward), self)
end

function UserBackGiftComp:_initView()
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftRender))
end

function UserBackGiftComp:updateView()
	self._giftCfgData = var_0_0:getGiftCfgData()

	self.m_giftList:setNumItems(#self._giftCfgData)
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
end

function UserBackGiftComp:_onGiftRender(arg_5_1, arg_5_2)
	arg_5_2:updateView(self._giftCfgData[arg_5_1 + 1])
end

function UserBackGiftComp:_onRcvGetGiftAward(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	self:updateView()
end

return UserBackGiftComp
