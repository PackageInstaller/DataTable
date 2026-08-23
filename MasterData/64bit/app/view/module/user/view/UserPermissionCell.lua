local UserPermissionCell = class("UserPermissionCell", require("app.fairyGUI.user.UI_UserPermissionCell"))

function UserPermissionCell:ctor()
	self.m_settingBtn:addClickListener(handler(self, self._onSettingBtnClicked))

	if device.isIOS() then
		self.m_hideStateController:setSelectedIndex(1)
	else
		self.m_hideStateController:setSelectedIndex(0)
	end
end

function UserPermissionCell:updateCell(arg_2_1)
	self._info = arg_2_1

	self:setTitle(g.core.lang:get(arg_2_1.name))
	self.m_tipText:setText(g.core.lang:get(arg_2_1.tip))
	self:_updateState()
end

function UserPermissionCell:onLoad()
	if self._info then
		self:_updateState()
	end
end

function UserPermissionCell:_updateState()
	local var_4_0 = g.core.platform.PlatformProxy:hasPermission(self._info.androidName)

	release_print("_updateSwitch---------------------->" .. self._info.androidName .. " : " .. tostring(var_4_0))

	if var_4_0 then
		self.m_isOpenController:setSelectedIndex(1)
	else
		self.m_isOpenController:setSelectedIndex(0)
	end
end

function UserPermissionCell:_onSettingBtnClicked()
	if device.platform == "android" or device.platform == "ios" or device.isOHOS() then
		g.core.platform.PlatformProxy:jumpToAppPermission()
		self:newScheduleOnce(handler(self, self._updateState), 0.5)
	end
end

return UserPermissionCell
