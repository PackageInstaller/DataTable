local var_0_0 = g.core.model.User.mailData
local MailLayer = class("MailLayer", require("app.fairyGUI.mail.UI_MailLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/mail/mail",
		resName = "MailLayer",
		pkgName = "mail",
		isFullScreen = true
	}, ...)
end)

function MailLayer:ctor(arg_2_1)
	self._playEnterAniEnable = true
	self._mailList = nil
	self._curMailInfoList = {}
	self._curMailIndex = 0

	self:addBg("bg/common/pic_bb_beijing.jpg")
	self:_initMainView()
end

local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr

function MailLayer:_initMainView()
	self.m_topBarComp:setResInfoById(19)
	self.m_oneKeyReceiveBtn:addClickListener(handler(self, self._onOneKeyReceiveClick))
	self.m_oneKeyDeleteBtn:addClickListener(handler(self, self._onOneKeyDeleteClick))
	self:_showOneKeyButton()
	self.m_tabList:setVirtual()
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._renderTabItem))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickMailTab))
end

function MailLayer:_showOneKeyButton()
	local var_4_0 = var_0_2:isModuleShow(var_0_3.FUNCTION_TYPE.MAIL_ONEKEY_COLLECTION)
	local var_4_1 = var_0_2:isModuleShow(var_0_3.FUNCTION_TYPE.MAIL_BATCH_DEL)
	local var_4_2 = 0

	if var_4_0 and var_4_1 then
		var_4_2 = 3
	elseif var_4_1 then
		var_4_2 = 1
	elseif var_4_0 then
		var_4_2 = 2
	end

	self.m_showBtnController:setSelectedIndex(var_4_2)
end

function MailLayer:_renderTabItem(arg_5_1, arg_5_2)
	arg_5_2:updateView(arg_5_1, self._curMailIndex, self._mailList[arg_5_1 + 1])
end

function MailLayer:_onClickMailTab(arg_6_1)
	local var_6_0 = arg_6_1:getDataValue()

	if var_6_0 == self._curMailIndex then
		return
	end

	self._curMailIndex = var_6_0

	self:_markMailAsRead()
	self.m_mailContent:updateView(self._mailList[self._curMailIndex + 1], true)
	self.m_tabList:setNumItems(#self._mailList)
end

function MailLayer:_markMailAsRead()
	if self._mailList[self._curMailIndex + 1] == nil then
		return
	end

	var_0_0:markAsRead(self._mailList[self._curMailIndex + 1])

	if self._mailList[self._curMailIndex + 1]:isAwardExsist() then
		self:dispatchCompEvent("MailMainLayer_refresh")
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MAIL_CLICK_REFRESH_RED_POINT)
end

function MailLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_INFO, handler(self, self._onReceiveMailInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_AWARD, handler(self, self._onReceiveMailAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_DEL, handler(self, self._onReceiveMailDelete), self)

	if not var_0_0:isMailRefresh() then
		g.core.network.GameNetProxy:send_C2S_Mail_Info({
			mail_type = 1
		})
		g.core.network.GameNetProxy:send_C2S_Mail_Info({
			mail_type = 2
		})
		var_0_0:notifyMailRefresh(true)
	else
		var_0_0:refreshMailInfo()
		self:_updateMailView(true)
	end
end

function MailLayer:_updateMailView(arg_9_1)
	self._mailList = var_0_0:getMailList()

	if #self._mailList <= 0 then
		self.m_emptyController:setSelectedIndex(0)
		self.m_showBtnController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(1)
		self:_showOneKeyButton()

		if #self._mailList <= self._curMailIndex then
			self._curMailIndex = #self._mailList - 1
		end

		self.m_mailContent:updateView(self._mailList[self._curMailIndex + 1], arg_9_1)
		self.m_tabList:setNumItems(#self._mailList)

		if self._curMailIndex == 0 then
			self:_markMailAsRead()
			self.m_tabList:setNumItems(#self._mailList)
		end
	end

	self:_playEnterAni()
end

function MailLayer:_playEnterAni()
	if not self._playEnterAniEnable then
		return
	end

	self._playEnterAniEnable = false

	if #self._mailList > 0 then
		self.m_tabList:transitionShowCells("enter_left", 0.03)
	else
		self.m_enterTransition:play()
	end
end

function MailLayer:_onReceiveMailInfo()
	self:_updateMailView(true)
end

function MailLayer:_onReceiveMailAward()
	self:_updateMailView(false)

	if var_0_0:getReceivedState() then
		local var_12_0 = var_0_0:getReceivedReward()

		if #var_12_0 > 0 then
			g.core.module.ModuleManager:awardSummary(var_12_0)
		end

		var_0_0:setReceivedState(false)
	end
end

function MailLayer:_onReceiveMailDelete(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self:_updateMailView(true)

	if arg_13_4.id == nil then
		return
	end

	if #arg_13_4.id > 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102001))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(102002))
	end
end

function MailLayer:_onOneKeyReceiveClick()
	if var_0_2:isModuleUnlock(var_0_3.FUNCTION_TYPE.MAIL_ONEKEY_COLLECTION) then
		var_0_0:setReceivedState(false)

		if var_0_0:isHasExpireMail() then
			g.core.module.ModuleManager:tip(g.core.lang:get(102015))
		elseif var_0_0:isHasAwardMail() then
			g.core.network.GameNetProxy:send_C2S_Mail_Award({
				mail_type = 1,
				id = 0
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(102003))
		end
	end
end

function MailLayer:_onOneKeyDeleteClick()
	if var_0_2:checkModuleUnlockStatus(var_0_3.FUNCTION_TYPE.MAIL_BATCH_DEL) then
		local var_15_0, var_15_1 = var_0_0:getCanDeledMail(0)

		if table.nums(var_15_0) > 0 or table.nums(var_15_1) > 0 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
				title = g.core.lang:get(102013),
				desc = g.core.lang:get(102004),
				onConfirm = handler(self, function()
					self:_deleteMail(var_15_0, var_15_1)
				end)
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(102005))
		end
	end
end

function MailLayer:_deleteMail(arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		table.insert(var_17_0, iter_17_1.mailType)
		table.insert(var_17_1, iter_17_1.mailId)
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_2) do
		table.insert(var_17_0, iter_17_3:getMailType())
		table.insert(var_17_1, iter_17_3:getMailId())
	end

	g.core.network.GameNetProxy:send_C2S_Mail_Del({
		mail_type = var_17_0,
		id = var_17_1
	})
end

function MailLayer:onUnload()
	return
end

return MailLayer
