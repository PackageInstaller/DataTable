local var_0_0 = g.core.common.ServerTime
local MailContentComp = class("MailContentComp", require("app.fairyGUI.mail.UI_MailContentComp"), function()
	return fgui.GComponent:create({
		resName = "MailContentComp",
		pkgPath = "ui/mail/mail",
		isFullScreen = false,
		pkgName = "mail"
	}, ...)
end)

function MailContentComp:ctor()
	self._data = {}
	self._rewards = {}
	self._isReceived = false

	self.m_receiveBtn:addClickListener(handler(self, self._onClickReceiveBtn))
	self.m_deleteBtn:addClickListener(handler(self, self._onClickDeleteBtn))
	self.m_translateBtn:addClickListener(handler(self, self._onTranslateClick))

	if g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].HIDE_TRANSLATE_BTN or g.core.platform.PlatformProxy:isChannelOfChina() then
		self.m_translateBtn:setVisible(false)
	end

	self:_initRewardList()
end

function MailContentComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TRANSLATE_FINISH_NOTIFY, self._onTranslateFinish, self)
end

function MailContentComp:_onClickReceiveBtn()
	if not self._isReceived and #self._rewards > 0 then
		if self._expireTime > 0 and var_0_0:getTime() > self._expireTime then
			g.core.module.ModuleManager:tip(g.core.lang:get(102015))

			return
		end

		g.core.model.User.mailData:setReceivedState(false)
		g.core.network.GameNetProxy:send_C2S_Mail_Award({
			mail_type = self._data:getMailType(),
			id = self._data:getMailId()
		})
	end
end

function MailContentComp:_onClickDeleteBtn()
	if self._isReceived or #self._rewards == 0 then
		g.core.network.GameNetProxy:send_C2S_Mail_Del({
			mail_type = {
				self._data:getMailType()
			},
			id = {
				self._data:getMailId()
			}
		})
	end
end

function MailContentComp:_initRewardList()
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._renderRewardItem))
end

function MailContentComp:_renderRewardItem(arg_7_1, arg_7_2)
	self._rewards[arg_7_1 + 1].isMask = self._isReceived

	arg_7_2:updateIcon(self._rewards[arg_7_1 + 1])
end

function MailContentComp:_parseMailContent(arg_8_1, arg_8_2)
	return g.core.utils.String.dealMailStr(arg_8_1, arg_8_2)
end

function MailContentComp:_onTranslateClick()
	if self._data:isTranslated() then
		self._data:setTranslateOpen(not self._data:isTranslateOpen())
		self:_onTranslateFinish()
	else
		if self.m_translateBtn.clickTime and os.time() - self.m_translateBtn.clickTime < 2 then
			g.core.module.ModuleManager:tip(g.core.lang:get(2502))

			return
		end

		self.m_translateBtn.clickTime = os.time()

		g.core.module.ModuleManager:tip(g.core.lang:get(2500))
		g.core.model.User.translateData:onTranslateMail(self._data)
	end
end

function MailContentComp:_onTranslateFinish()
	self:updateView()
end

function MailContentComp:updateView(arg_11_1, arg_11_2)
	if not arg_11_1 and not self._data then
		return
	end

	if arg_11_1 then
		self._data = arg_11_1
	end

	arg_11_1 = arg_11_1 or self._data

	local var_11_0

	if arg_11_1:isTranslated() then
		var_11_0 = g.core.model.User.translateData:getMailTranslateData(arg_11_1:getUniqueId())
	end

	local var_11_1 = arg_11_1:getMailKeyValues()
	local var_11_2 = g.core.config.mail_info.get(arg_11_1:getMailBaseId())
	local var_11_3 = g.core.lang:getByString(var_11_2.title, var_11_1)
	local var_11_4 = ""

	var_11_4 = table.nums(arg_11_1:getMailSendName()) > 0 and g.core.lang:getByString(var_11_2.from, arg_11_1:getMailSendName()) or var_11_2.from

	local var_11_5 = self:_parseMailContent(var_11_2.content, var_11_1)

	if var_11_0 and arg_11_1:isTranslateOpen() then
		var_11_3 = var_11_0:getTitle() or var_11_3
		var_11_4 = var_11_0:getFrom() or var_11_4
		var_11_5 = var_11_0:getContent() or var_11_5

		self.m_translateController:setSelectedIndex(1)
	else
		self.m_translateController:setSelectedIndex(0)
	end

	self.m_titleText:setText(var_11_3)
	self.m_mailSourceText:setText(var_11_4)
	self.m_mailDes:updateText(var_11_5)

	self._isReceived = arg_11_1:isReceived()
	self._rewards = arg_11_1:getMailAwards() or {}

	if self._isReceived or #self._rewards <= 0 then
		self.m_mailOperateController:setSelectedIndex(1)
	else
		self.m_mailOperateController:setSelectedIndex(0)
	end

	self.m_rewardList:setNumItems(#self._rewards)

	self._expireTime = arg_11_1:getMailExpireTime() or 0

	if self._expireTime > 0 then
		self.m_expireTimeTxt:setVisible(true)
		self:_expireTimeUpdate()
	else
		self.m_expireTimeTxt:setVisible(false)
	end

	if arg_11_2 then
		self:_playEnterAni()
	end
end

function MailContentComp:_expireTimeUpdate()
	if var_0_0:getTime() <= self._expireTime then
		self.m_expireTimeTxt:setText(g.core.lang:get(102014) .. var_0_0:getDateYMDHMFormat(self._expireTime))
	else
		self.m_expireTimeTxt:setVisible(false)
	end
end

function MailContentComp:_playEnterAni()
	self.m_enterTransition:play()
	self.m_rewardList:transitionShowCells("listIconUiScaleIn", 0.03)
end

return MailContentComp
