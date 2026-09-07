local SailingShip3MainPage = class("SailingShip3MainPage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 71226
local var_0_3 = 5

function SailingShip3MainPage:OnInit()
	self.AD = self._tf:Find("bg")
	self.list = self.AD:Find("list")
	self.build = self.list:Find("build")
	self.build_bgtime = self.build:Find("time_bg")
	self.build_time = self.build_bgtime:Find("time")
	self.fight = self.list:Find("fight")
	self.shop = self.list:Find("shop")
	self.shop_bgtime = self.shop:Find("time_bg")
	self.shop_time = self.shop_bgtime:Find("time")
	self.Manual = self.AD:Find("Manual")
	self.name = self.Manual:Find("name")

	setText(self.name, i18n("fengfanV3_20251023_jinianshouce"))
	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)

	return
end

function SailingShip3MainPage:OnDataSetting()
	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function SailingShip3MainPage:OnFirstFlush()
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = SailingShip3MedalAlbumView
		})))

		return
	end)
	self:updateUI()

	return
end

function SailingShip3MainPage:OnUpdateFlush()
	self:updateUI()

	return
end

function SailingShip3MainPage:updateUI()
	local var_6_0, var_6_1 = self.timeMgr:inTime(pg.shop_template[var_0_1].time)
	local var_6_2

	if var_6_1 then
		var_6_2 = SailingShip3MainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_6_1)))
	end

	setActive(self.shop_bgtime, var_6_2 and var_6_2 ~= 0)
	setText(self.shop_time, var_6_2)

	local var_6_3, var_6_4 = self.timeMgr:inTime(pg.activity_template[var_0_3].time)
	local var_6_5

	if var_6_4 then
		var_6_5 = SailingShip3MainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_6_4)))
	end

	setActive(self.build_bgtime, var_6_5 and var_6_5 ~= 0)
	setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(self, self.shop, function()
		if var_6_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)
	onButton(self, self.build, function()
		if var_6_5 == nil then
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
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end)

	return
end

function SailingShip3MainPage:skinCommdityTimeStamps(arg_10_1)
	local var_10_0 = math.max(arg_10_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_10_0 / 0) > 0 then
		return 0
	else
		local var_10_1 = math.floor(var_10_0 / 16)

		if var_10_1 > 0 then
			return i18n("shop_new_during_hour", var_10_1)
		else
			local var_10_2 = math.floor(var_10_0 / 60)

			if var_10_2 > 0 then
				return i18n("shop_new_during_minite", var_10_2)
			end
		end
	end

	return
end

function SailingShip3MainPage:OnShowFlush()
	setCanvasGroupAlpha(self._tf, 1)

	return
end

return SailingShip3MainPage
