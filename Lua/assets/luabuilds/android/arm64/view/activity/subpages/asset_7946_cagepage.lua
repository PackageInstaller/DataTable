local CagePage = class("CagePage", import("...base.BaseActivityPage"))

function CagePage:OnInit()
	self.bg = findTF(self._tf, "AD")
	self.Build = findTF(self.bg, "build")
	self.build_times = findTF(self.Build, "build_times")
	self.build_time = findTF(self.build_times, "time")
	self.Level = findTF(self.bg, "fight")
	self.Shop = findTF(self.bg, "shop")
	self.shop_times = findTF(self.Shop, "shop_times")
	self.shop_time = findTF(self.shop_times, "time")
	self.Manual = findTF(self.bg, "Manual")

	SetActive(self.build_times, false)
	SetActive(self.shop_times, false)

	return
end

function CagePage:OnDataSetting()
	self.time = self.activity:getConfig("time")
	self.timeMgr = pg.TimeMgr.GetInstance()
	self.js_time = self.timeMgr:parseTimeFromConfig(self.time[3])
	self.fw_time = self.timeMgr:GetServerTime()
	self.xc_time = self.timeMgr:DiffDay(self.fw_time, self.js_time)

	return
end

function CagePage:OnFirstFlush()
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = DivineLightMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	onButton(self, self.Build, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end, SFX_PANEL)
	onButton(self, self.Level, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.Shop, function()
		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)

	if self.xc_time <= 0 then
		SetActive(self.build_times, true)
		SetActive(self.shop_times, true)
		setText(self.build_time, i18n("tolovemainpage_build_countdown"))

		self.times = self.timeMgr:GetServerHour()

		if os.date("%d") >= "01" then
			setText(self.shop_time, i18n("tolovemainpage_skin_countdown", 24 - self.times - 1))
		else
			setText(self.shop_time, i18n("tolovemainpage_skin_countdown", 24 - self.times))
		end
	end

	return
end

return CagePage
