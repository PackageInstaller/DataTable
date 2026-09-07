local ChargeBirthdayLayer = class("ChargeBirthdayLayer", import("...base.BaseUI"))

function ChargeBirthdayLayer:getUIName()
	return "ChargeBirthdayUI"
end

function ChargeBirthdayLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()

	return
end

function ChargeBirthdayLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChargeBirthdayLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ChargeBirthdayLayer:initData()
	return
end

function ChargeBirthdayLayer:initUIText()
	self.inputSC.text = ""

	return
end

function ChargeBirthdayLayer:findUI()
	self.bg = self._tf:Find("bg")
	self.window = self._tf:Find("window")
	self.inputField = self.window:Find("birthday_input_panel/InputField")
	self.inputSC = GetComponent(self.inputField, typeof(InputField))
	self.cancelBtn = self.window:Find("birthday_input_panel/btns/cancel_btn")
	self.confirmBtn = self.window:Find("birthday_input_panel/btns/confirm_btn")
	self.closeBtn = self.window:Find("top/btnBack")

	return
end

function ChargeBirthdayLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end)
	onButton(self, self.cancelBtn, function()
		self:closeView()

		return
	end)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end)
	onButton(self, self.confirmBtn, function()
		if not checkBirthFormat(self.inputSC.text) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("set_birth_empty_tip"))
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				title = i18n("set_birth_title"),
				content = i18n("set_birth_confirm_tip", self.inputSC.text),
				onYes = function()
					pg.SdkMgr.GetInstance():SetBirth(self.inputSC.text)
					self:closeView()

					return
				end
			})
		end

		return
	end)

	return
end

return ChargeBirthdayLayer
