local SecondAnniversaryPage = class("SecondAnniversaryPage", import("...base.BaseActivityPage"))

function SecondAnniversaryPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnShop = self._tf:Find("BtnShop")
	self.btnContainer = self._tf:Find("BtnList/Viewport/Content")
	self.btn1 = self.btnContainer:Find("1")
	self.btn2 = self.btnContainer:Find("2")
	self.btn3 = self.btnContainer:Find("3")
	self.btn4 = self.btnContainer:Find("4")
	self.btn5 = self.btnContainer:Find("5")
	self.btn6 = self.btnContainer:Find("6")
	self.btn7 = self.btnContainer:Find("7")
	self.btn8 = self.btnContainer:Find("8")
	self.btn9 = self.btnContainer:Find("9")
	self.btnList1 = {
		self.btn1,
		self.btn2,
		self.btn3,
		self.btn4,
		self.btn5,
		self.btn6,
		self.btn7,
		self.btn8,
		self.btn9
	}
	self.btn11 = self.btnContainer:Find("11")
	self.btn12 = self.btnContainer:Find("12")
	self.btn13 = self.btnContainer:Find("13")
	self.btn14 = self.btnContainer:Find("14")
	self.btn15 = self.btnContainer:Find("15")
	self.btn16 = self.btnContainer:Find("16")
	self.btn17 = self.btnContainer:Find("17")
	self.btn18 = self.btnContainer:Find("18")
	self.btn19 = self.btnContainer:Find("19")
	self.btnList2 = {
		self.btn11,
		self.btn12,
		self.btn13,
		self.btn14,
		self.btn15,
		self.btn16,
		self.btn17,
		self.btn18,
		self.btn19
	}

	return
end

function SecondAnniversaryPage:OnFirstFlush()
	onButton(self, self.btnShop, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	self:initBtn(self.btnList1)
	self:initBtn(self.btnList2)

	return
end

function SecondAnniversaryPage:initBtn(arg_4_1)
	onButton(self, arg_4_1[1], function()
		self:emit(ActivityMediator.GO_PRAY_POOL)

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[2], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[3], function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID)

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[4], function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.XIMU_LOGIN_ID)

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[5], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_DIAMOND
		})

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[6], function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = "light"
		})

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[7], function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.SANDIEGO_PT_ID)

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[8], function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.SKIN_U73)

		return
	end, SFX_PANEL)
	onButton(self, arg_4_1[9], function()
		pg.TipsMgr.GetInstance():ShowTips("即将开放，敬请期待！")

		return
	end, SFX_PANEL)

	return
end

return SecondAnniversaryPage
