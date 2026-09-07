pg = pg or {}
pg.UserAgreementMgr = singletonClass("UserAgreementMgr")

local var_0_0 = "UserAgreementUI"
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function pg.UserAgreementMgr.Init(arg_1_0, arg_1_1)
	arg_1_0.state = var_0_1

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function pg.UserAgreementMgr:Show(arg_2_1)
	self.onClose = arg_2_1.onClose
	self.content = arg_2_1.content
	self.forceRead = arg_2_1.forceRead
	self.title = arg_2_1.title

	if self.state == var_0_1 then
		self:LoadUI()
	elseif self.state == var_0_3 then
		self:Flush()
	elseif self.state == var_0_2 then
		-- block empty
	end

	return
end

function pg.UserAgreementMgr.LoadUI(arg_3_0)
	arg_3_0.state = var_0_2

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetUI(var_0_0, true, function(arg_4_0)
		arg_3_0.state = var_0_3

		pg.UIMgr.GetInstance():LoadingOff()

		arg_3_0._go = arg_4_0

		arg_3_0:OnLoaded()
		arg_3_0:Flush()
		setActive(arg_3_0._go, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_3_0._go.transform)

		return
	end)

	return
end

function pg.UserAgreementMgr:OnLoaded()
	self.contentTxt = self._go.transform:Find("window/container/scrollrect/content/Text"):GetComponent(typeof(Text))
	self.acceptBtn = self._go.transform:Find("window/accept_btn")
	self.acceptBtnTxt = self.acceptBtn:Find("Text"):GetComponent(typeof(Text))
	self.scrollrect = self._go.transform:Find("window/container/scrollrect"):GetComponent(typeof(ScrollRect))
	self.titleTxt = self._go.transform:Find("window/title"):GetComponent(typeof(Text))
	self.msgboxTitleTxt = self._go.transform:Find("window/title1/Text"):GetComponent(typeof(Text))

	return
end

function pg.UserAgreementMgr:Flush()
	self.msgboxTitleTxt.text = i18n("title_info")
	self.contentTxt.text = self.content
	self.acceptBtnTxt.text = i18n("word_back")
	self.titleTxt.text = self.title

	local var_6_0 = not self.forceRead

	onButton(nil, self.acceptBtn, function()
		if var_6_0 then
			self:Hide()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("read_the_user_agreement"))
		end

		return
	end)
	onScroll(nil, self.scrollrect.gameObject, function(arg_8_0)
		if arg_8_0.y <= 0.01 and not var_6_0 then
			var_6_0 = true

			setButtonEnabled(self.acceptBtn, var_6_0)
		end

		return
	end)
	setButtonEnabled(self.acceptBtn, not self.forceRead)
	scrollTo(self.scrollrect.gameObject, 0, 1)

	return
end

function pg.UserAgreementMgr:Hide()
	if self.onClose then
		self.onClose()
	end

	if self.acceptBtn then
		removeOnButton(self.acceptBtn)
	end

	if self.scrollrect then
		self.scrollrect.onValueChanged:RemoveAllListeners()
	end

	self.onClose = nil
	self.content = nil
	self.forceRead = nil
	self.title = nil

	if self._go then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._go.transform, pg.UIMgr.GetInstance().UIMain)
		PoolMgr.GetInstance():ReturnUI(var_0_0, self._go)

		self._go = nil
	end

	self.state = var_0_1

	return
end

function pg.UserAgreementMgr:ShowForBiliPrivate()
	local BiliPrivate = require("GameCfg.useragreems.BiliPrivate")

	self:Show({
		content = BiliPrivate.content,
		title = BiliPrivate.title
	})

	return
end

function pg.UserAgreementMgr:ShowForBiliLicence()
	local BiliLicence = require("GameCfg.useragreems.BiliLicence")

	self:Show({
		content = BiliLicence.content,
		title = BiliLicence.title
	})

	return
end

function pg.UserAgreementMgr:ShowChtPrivate()
	local ChtPrivate = require("GameCfg.useragreems.ChtPrivate")

	self:Show({
		content = ChtPrivate.content,
		title = ChtPrivate.title
	})

	return
end

function pg.UserAgreementMgr:ShowChtLicence()
	local ChtLicence = require("GameCfg.useragreems.ChtLicence")

	self:Show({
		content = ChtLicence.content,
		title = ChtLicence.title
	})

	return
end

return
