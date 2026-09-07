local SecondAnniversaryCollectPage = class("SecondAnniversaryCollectPage", import("...base.BaseActivityPage"))

function SecondAnniversaryCollectPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnContainer = self._tf:Find("BtnList")
	self.btn1 = self.btnContainer:Find("1")
	self.btn2 = self.btnContainer:Find("2")
	self.btn3 = self.btnContainer:Find("3")
	self.btn4 = self.btnContainer:Find("4")
	self.btn5 = self.btnContainer:Find("5")
	self.btn6 = self.btnContainer:Find("6")

	return
end

function SecondAnniversaryCollectPage:OnFirstFlush()
	onButton(self, self.btn1, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.btn2, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID2)

		return
	end, SFX_PANEL)
	onButton(self, self.btn3, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.YIDALI_MAIN_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.btn4, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ANNIVERSARY_LOGIN_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.btn5, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.CARDPAIR_ZQ)

		return
	end, SFX_PANEL)
	onButton(self, self.btn6, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.DACHAOLIFU_SKIN)

		return
	end, SFX_PANEL)

	return
end

return SecondAnniversaryCollectPage
