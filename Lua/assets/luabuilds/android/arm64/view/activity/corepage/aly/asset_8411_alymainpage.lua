local ALYMainPage = class("ALYMainPage", import("view.activity.CorePage.CoreActivityPage"))

function ALYMainPage:OnInit()
	self.AD = self._tf:Find("bg")
	self.list = self.AD:Find("list")
	self.build = self.list:Find("build")
	self.fight = self.list:Find("fight")
	self.shop = self.list:Find("shop")

	return
end

function ALYMainPage:OnFirstFlush()
	onButton(self, self.build, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end, SFX_PANEL)
	onButton(self, self.fight, function()
		self:emit(ActivityMediator.SKIP_ACTIVITY_MAP, 6)

		return
	end, SFX_PANEL)
	onButton(self, self.shop, function()
		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)
	setText(self._tf:Find("Text (Legacy)", self.build), i18n("yumia_main_tip_1"))
	setText(self._tf:Find("Text (Legacy)", self.fight), i18n("yumia_main_tip_2"))
	setText(self._tf:Find("Text (Legacy)", self.shop), i18n("yumia_main_tip_3"))

	return
end

function ALYMainPage:OnDestroy()
	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return ALYMainPage
