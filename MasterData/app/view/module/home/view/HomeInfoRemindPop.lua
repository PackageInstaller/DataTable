local var_0_0 = g.core.model.User.homeInfoRemindData
local HomeInfoRemindPop = class("HomeInfoRemindPop", require("app.fairyGUI.home.UI_HomeInfoRemindPop"), function()
	return fgui.GComponent:create({
		resName = "HomeInfoRemindPop",
		pkgPath = "ui/home/home",
		isFullScreen = true,
		pkgName = "home"
	}, ...)
end)

function HomeInfoRemindPop:ctor(arg_2_1)
	self:setOpaque(true)
	self:addClickListener(handler(self, self._onClose))

	self._isCanTouchBg = true
	self._isFirstEnter = true
	self.m_trans = self:getSharedTrans("enter", "CommonRightPanelAnim", self.m_contentComp)

	var_0_0:judgeResetHomeInfoClickRecordWhenLogin()
	var_0_0:resetLastUpdateTime()
end

function HomeInfoRemindPop:onLoad(arg_3_1)
	if self._isFirstEnter and self.m_trans then
		self._isFirstEnter = false

		self.m_trans:play()
	else
		self:_updateView()
	end
end

function HomeInfoRemindPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_HOME_REMIND_TIP_SETTING_CHANGED)
end

function HomeInfoRemindPop:_updateView()
	self.m_contentComp:updateContent()
end

function HomeInfoRemindPop:_onBack()
	if self._isCanTouchBg then
		self._isCanTouchBg = false

		local var_6_0 = self:getSharedTrans("back", "CommonRightPanelAnim", self.m_contentComp)

		if var_6_0 then
			var_6_0:play(handler(self, function(arg_7_0)
				g.core.module.ModuleManager:popComponent()
			end))
		end
	end
end

function HomeInfoRemindPop:_onClose(arg_8_1)
	if not self.m_contentComp:containPoint((arg_8_1:getInput():getTouch():getLocation())) then
		self:_onBack()
	end
end

return HomeInfoRemindPop
