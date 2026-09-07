local SpringFestival2026MainPage = class("SpringFestival2026MainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

function SpringFestival2026MainPage:OnInit()
	self.AD = self._tf:Find("bg")
	self.list = self.AD:Find("list")
	self.build = self.list:Find("buildbtn")
	self.build_bgtime = self.build:Find("time_bg")
	self.build_time = self.build_bgtime:Find("time")
	self.fight = self.list:Find("fightbtn")
	self.shop = self.list:Find("shopbtn")
	self.shop_bgtime = self.shop:Find("time_bg")
	self.shop_time = self.shop_bgtime:Find("time")
	self.Manual = self.AD:Find("Manualbtn")
	self.plot = self.AD:Find("plot")

	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)
	setText(self.Manual:Find("Text"), i18n("fengfanV3_20251023_jinianshouce"))
	setText(self.plot:Find("Text"), i18n("drawdiary_ui_2026"))

	return
end

function SpringFestival2026MainPage:OnFirstFlush()
	SpringFestival2026MainPage.super.OnFirstFlush(self)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = DonghuangMedalAlbumView
		})))

		return
	end)
	onButton(self, self.plot, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = SpringFestival2026ColoringAnshanMediator,
			viewComponent = SpringFestival2026ColoringAnshanscene
		})))

		return
	end)

	return
end

function SpringFestival2026MainPage:updateUI()
	if self.shop_id then
		local var_5_0, var_5_1 = self.timeMgr:inTime(pg.shop_template[self.shop_id].time)
		local var_5_2

		if var_5_1 then
			var_5_2 = SpringFestival2026MainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_5_1)))
		end

		setActive(self.shop_bgtime, var_5_2 and var_5_2 ~= 0)
		setText(self.shop_time, var_5_2)
		onButton(self, self.shop, function()
			if var_5_2 == nil then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			self:emit(ActivityMediator.GO_CHANGE_SHOP)

			return
		end)
	end

	local var_5_3, var_5_4 = self.timeMgr:inTime(pg.activity_template[self.activity.id].time)
	local var_5_5

	if var_5_4 then
		var_5_5 = SpringFestival2026MainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_5_4)))
	end

	setActive(self.build_bgtime, var_5_5 and var_5_5 ~= 0)
	setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(self, self.build, function()
		if var_5_5 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end)
	onButton(self, self.fight, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = ActivityBossMediatorTemplate,
			viewComponent = ActivityBossZhangwuScene
		})))

		return
	end)

	return
end

return SpringFestival2026MainPage
