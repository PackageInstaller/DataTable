local TranscodeAlertView = class("TranscodeAlertView", import("...base.BaseSubView"))

function TranscodeAlertView:getUIName()
	return "TranscodeAlertView"
end

function TranscodeAlertView:OnLoaded()
	return
end

function TranscodeAlertView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function TranscodeAlertView:OnInit()
	self.transcodeAlert = self._tf
	self.tcSureBtn = self.transcodeAlert:Find("transcode_sure")
	self.uidTxt = self.transcodeAlert:Find("uid_input_txt"):GetComponent(typeof(InputField))
	self.transcodeTxt = self.transcodeAlert:Find("transcode_input_txt"):GetComponent(typeof(InputField))
	self.tcDesc = self.transcodeAlert:Find("desc")

	setText(self.tcDesc, i18n("transcode_desc"))
	self:InitEvent()

	return
end

function TranscodeAlertView:InitEvent()
	onButton(self, self.tcSureBtn, function()
		if self.uidTxt.text == "" or self.transcodeTxt.text == "" then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("transcode_empty_tip")
			})
		else
			pg.SdkMgr.GetInstance():LoginWithTranscode(self.uidTxt.text, self.transcodeTxt.text)
		end

		return
	end)
	onButton(self, self.transcodeAlert, function()
		self:Hide()

		return
	end)

	return
end

function TranscodeAlertView:OnDestroy()
	return
end

return TranscodeAlertView
