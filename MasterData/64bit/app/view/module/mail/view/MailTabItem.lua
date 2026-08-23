local MailTabItem = class("MailTabItem", require("app.fairyGUI.mail.UI_MailTabItem"), function()
	return fgui.GComponent:create({
		pkgName = "mail",
		isFullScreen = false,
		pkgPath = "ui/mail/mail",
		resName = "MailTabItem"
	}, ...)
end)

function MailTabItem:ctor()
	self.getSharedTrans(self, "enter_left", "CommonShortCellList", self)
	self:addClickListener(handler(self, self._onClick))
end

function MailTabItem:_onClick()
	return
end

function MailTabItem:updateView(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_3 then
		return
	end

	if arg_4_1 == arg_4_2 then
		self.m_buttonController:setSelectedIndex(1)
	else
		self.m_buttonController:setSelectedIndex(0)
	end

	self.m_scrollTxtComp:setText((g.core.lang:getByString(g.core.config.mail_info.get(arg_4_3:getMailBaseId()).title, (arg_4_3:getMailKeyValues()))))

	local var_4_0 = self:_calculateTime(arg_4_3)

	if var_4_0 then
		self.m_timeText:setText(var_4_0)
	end

	if arg_4_3:isAwardExsist() then
		if arg_4_3:isReceived() then
			self.m_statusController:setSelectedIndex(3)
		else
			self.m_statusController:setSelectedIndex(2)
		end

		if not arg_4_3:getMailAwards() then
			-- block empty
		end
	elseif arg_4_3:isRead() then
		self.m_statusController:setSelectedIndex(1)
	else
		self.m_statusController:setSelectedIndex(0)
	end

	if arg_4_3:isRead() then
		self.m_newStatusController:setSelectedIndex(1)
	else
		self.m_newStatusController:setSelectedIndex(0)
	end
end

function MailTabItem:_calculateTime(arg_5_1)
	local var_5_0 = arg_5_1:getMailSendTime()
	local var_5_1 = g.core.common.ServerTime:getTimerBeforeDHM(var_5_0)

	return (g.core.common.ServerTime:getTime() - var_5_0 <= 60 or nil) and g.core.lang:get(102006)
end

return MailTabItem
