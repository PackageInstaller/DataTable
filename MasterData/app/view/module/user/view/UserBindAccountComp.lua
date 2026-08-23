local UserBindAccountComp = class("UserBindAccountComp", require("app.fairyGUI.user.UI_UserBindAccountComp"))

function UserBindAccountComp:ctor()
	self.m_goToAccountBtn:addClickListener(handler(self, self._onBindAccountClick))
end

function UserBindAccountComp:updateView(arg_2_1)
	self._params = arg_2_1

	self.m_goToAccountBtn:setCtrlState("channel", {
		index = arg_2_1.selIndex
	})
	self:checkSelfState()
end

function UserBindAccountComp:_onBindAccountClick()
	if not self._params then
		return
	end

	if self._params.bindFunc then
		self._params.bindFunc()
	else
		g.core.platform.PlatformProxy:showAccountLinkJson(self._params.SDKName)
	end
end

function UserBindAccountComp:checkSelfState()
	if not self._params then
		return
	end

	if self._params.stateFunc then
		if self._params.stateFunc() then
			self.m_goToAccountBtn:setCtrlState("state", {
				index = 1
			})
			self.m_goToAccountBtn:setTouchable(false)
		else
			self.m_goToAccountBtn:setCtrlState("state", {
				index = 0
			})
		end
	elseif g.core.model.User.UserTitleData:isAccountBind(self._params.resultName) then
		self.m_goToAccountBtn:setCtrlState("state", {
			index = 1
		})
		self.m_goToAccountBtn:setTouchable(false)
	else
		self.m_goToAccountBtn:setCtrlState("state", {
			index = 0
		})
	end
end

return UserBindAccountComp
