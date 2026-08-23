local HomeUserInfoComp = class("HomeUserInfoComp", require("app.fairyGUI.home.UI_HomeUserInfoComp"))

function HomeUserInfoComp:ctor()
	self._barWidth = self.m_expBar:getWidth()

	self.m_nameText:disableAutoChange()
	self:_initBtn()
end

function HomeUserInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onRcvResourceChange), self)
	g.core.common.GlobalFunc.checkAvatarId()
	g.core.common.GlobalFunc.checkFrameId()
	self:_updateView()
end

function HomeUserInfoComp:_initBtn()
	self:addClickListener(handler(self, self._onUserInfoClick))
	self.m_headIcon:setTouchCallFunc(handler(self, self._onUserInfoClick))
end

function HomeUserInfoComp:_updateView()
	local var_4_0 = g.core.model.User:getName()
	local var_4_1 = g.core.model.User:getFightValue()
	local var_4_2 = g.core.model.User:getLevelUpExp()
	local var_4_3 = var_4_2 == 0 and 1 or g.core.model.User.resourceData:getExp() / var_4_2

	self.m_lvText:setText(g.core.lang:get(2085, {
		lv = g.core.model.User:getLevel()
	}))
	self.m_nameText:setText(var_4_0)
	self.m_fightValueText:setText(var_4_1)
	self.m_expBar:setSize(var_4_3 * self._barWidth, self.m_expBar:getHeight())
	self.m_headIcon:updateAsSelf()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_headRedPoint
	})
end

function HomeUserInfoComp:_onRcvResourceChange()
	self:_updateView()
end

function HomeUserInfoComp:_onUserInfoClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.USER_MAIN)
end

return HomeUserInfoComp
