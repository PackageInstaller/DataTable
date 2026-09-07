local HuaShangQiaoPage = class("HuaShangQiaoPage", import("...base.BaseActivityPage"))

function HuaShangQiaoPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.Build = self.bg:Find("build"):GetComponent("Button")
	self.build_times = self.bg:Find("build/build_times")
	self.build_time = self.bg:Find("build/build_times/time"):GetComponent("Text")
	self.Level = self.bg:Find("fight"):GetComponent("Button")
	self.fight_times = self.bg:Find("fight/fight_times")
	self.fight_time = self.bg:Find("fight/fight_times/time"):GetComponent("Text")
	self.Shop = self.bg:Find("shop"):GetComponent("Button")
	self.shop_times = self.bg:Find("shop/shop_times")
	self.shop_time = self.bg:Find("shop/shop_times/time"):GetComponent("Text")
	self.Manual = self.bg:Find("Manual"):GetComponent("Button")

	SetActive(self.build_times, false)
	SetActive(self.fight_times, false)
	SetActive(self.shop_times, false)

	return
end

function HuaShangQiaoPage:OnDataSetting()
	self.time = self.activity:getConfig("time")
	self.time = self.time[2]
	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function HuaShangQiaoPage:OnFirstFlush()
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = SpringFashionFestaMedalAlbumView
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
		self:emit(ActivityMediator.GO_SPECIAL_EXERCISE)

		return
	end, SFX_PANEL)
	onButton(self, self.Shop, function()
		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)

	if os.date("%d") == "06" and os.date("%m") == "02" and os.date("%Y") == "2025" then
		SetActive(self.build_times, true)
		SetActive(self.fight_times, true)
		SetActive(self.shop_times, true)
		setText(self.build_time, i18n("tolovemainpage_build_countdown"))
		setText(self.fight_time, i18n("tolovemainpage_build_countdown"))

		self.times = self.timeMgr:GetServerHour()

		if os.date("%d") >= "01" then
			setText(self.shop_time, i18n("tolovemainpage_skin_countdown", 24 - self.times - 1))
		else
			setText(self.shop_time, i18n("tolovemainpage_skin_countdown", 24 - self.times))
		end
	end

	return
end

return HuaShangQiaoPage
