local HoloLivePage = class("HoloLivePage", import("view.base.BaseActivityPage"))

function HoloLivePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.listbtn = self.bg:Find("list")
	self.btnFubuki = self.listbtn:Find("1")
	self.btnBattle = self.listbtn:Find("2")
	self.btnSora = self.listbtn:Find("3")
	self.btnShion = self.listbtn:Find("4")
	self.btnMio = self.listbtn:Find("5")
	self.btnAqua = self.listbtn:Find("6")
	self.btnAyame = self.listbtn:Find("7")
	self.btnMatsuri = self.listbtn:Find("8")

	return
end

function HoloLivePage:OnFirstFlush()
	onButton(self, self.btnFubuki, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end)
	onButton(self, self.btnBattle, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	onButton(self, self.btnSora, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLOLIVE_MORNING_ID)

		return
	end)
	onButton(self, self.btnShion, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLOLIVE_PT_ID)

		return
	end)
	onButton(self, self.btnMio, function()
		self:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLOLIVE_MIO_ID)

		return
	end)
	onButton(self, self.btnAqua, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLOLIVE_LINKLINK_SELECT_SCENE)

		return
	end)
	onButton(self, self.btnAyame, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLOLIVE_MEDAL)

		return
	end)
	onButton(self, self.btnMatsuri, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

return HoloLivePage
