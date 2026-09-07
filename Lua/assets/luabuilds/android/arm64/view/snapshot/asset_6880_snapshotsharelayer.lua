local SnapshotShareLayer = class("SnapshotShareLayer", import("..base.BaseUI"))

function SnapshotShareLayer:getUIName()
	return "snapshotshareui"
end

function SnapshotShareLayer:init()
	self.photoImgTrans = self._tf:Find("PhotoImg")
	self.rawImage = self.photoImgTrans:GetComponent("RawImage")
	self.shareBtnTrans = self._tf:Find("BtnPanel/ShareBtn")
	self.confirmBtnTrans = self._tf:Find("BtnPanel/ConfirmBtn")
	self.cancelBtnTrans = self._tf:Find("BtnPanel/CancelBtn")
	self.userAgreenTF = self._tf:Find("UserAgreement")
	self.userAgreenMainTF = self.userAgreenTF:Find("window")
	self.closeUserAgreenTF = self.userAgreenMainTF:Find("close_btn")
	self.userRefuseConfirmTF = self.userAgreenMainTF:Find("refuse_btn")
	self.userAgreenConfirmTF = self.userAgreenMainTF:Find("accept_btn")

	setActive(self.userAgreenTF, false)

	self.rawImage.texture = self.contextData.photoTex
	self.bytes = self.contextData.photoData

	return
end

function SnapshotShareLayer:didEnter()
	onButton(self, self.shareBtnTrans, function()
		local var_4_0 = PlayerPrefs.GetInt("snapshotAgress")

		if not var_4_0 or var_4_0 <= 0 then
			self:showUserAgreement(function()
				PlayerPrefs.SetInt("snapshotAgress", 1)
				pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePhoto)

				return
			end)
		else
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePhoto)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtnTrans, function()
		YSNormalTool.MediaTool.SaveImageWithBytes(self.bytes, function(arg_7_0, arg_7_1)
			if arg_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
			end

			return
		end)
		pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
		self:closeView()

		return
	end)
	onButton(self, self.cancelBtnTrans, function()
		self:closeView()

		return
	end)

	return
end

function SnapshotShareLayer:willExit()
	return
end

function SnapshotShareLayer:showUserAgreement(arg_10_1)
	setButtonEnabled(self.userAgreenConfirmTF, true)

	self.userAgreenTitleTF = self._tf:Find("UserAgreement/window/title")
	self.userAgreenTitleTF:GetComponent("Text").text = i18n("word_snapshot_share_title")

	setActive(self.userAgreenTF, true)
	setText(self.userAgreenTF:Find("window/container/scrollrect/content/Text"), i18n("word_snapshot_share_agreement"))
	onButton(self, self.userRefuseConfirmTF, function()
		setActive(self.userAgreenTF, false)

		return
	end)
	onButton(self, self.userAgreenConfirmTF, function()
		setActive(self.userAgreenTF, false)

		if arg_10_1 then
			arg_10_1()
		end

		return
	end)
	onButton(self, self.closeUserAgreenTF, function()
		setActive(self.userAgreenTF, false)

		return
	end)

	return
end

return SnapshotShareLayer
