local DALMainPage = class("DALMainPage", import("view.activity.CorePage.CoreActivityPage"))

function DALMainPage:OnInit()
	self.AD = self._tf:Find("bg")
	self.list = self.AD:Find("list")
	self.build = self.list:Find("build")
	self.build_bgtime = self.build:Find("time_bg")
	self.build_time = self.build_bgtime:Find("time")
	self.fight = self.list:Find("fight")
	self.shop = self.list:Find("shop")
	self.shop_bgtime = self.shop:Find("time_bg")
	self.shop_time = self.shop_bgtime:Find("time")

	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)
	setText(self.shop:Find("Text"), i18n("yumia_main_tip_3"))
	setText(self.fight:Find("Text"), i18n("yumia_main_tip_2"))
	setText(self.build:Find("Text"), i18n("yumia_main_tip_1"))

	return
end

function DALMainPage:OnDataSetting()
	self.timeMgr = pg.TimeMgr.GetInstance()
	self.shop_id = self.activity:getConfig("config_client").shopItemID

	return
end

function DALMainPage:OnFirstFlush()
	self:updateUI()

	return
end

function DALMainPage:OnUpdateFlush()
	self:updateUI()

	return
end

function DALMainPage:updateUI()
	if not self.shop_id then
		return
	end

	local var_5_0, var_5_1 = self.timeMgr:inTime(pg.shop_template[self.shop_id].time)
	local var_5_2

	if var_5_1 then
		var_5_2 = DALMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_5_1)))
	end

	setActive(self.shop_bgtime, var_5_2 and var_5_2 ~= 0)
	setText(self.shop_time, var_5_2)

	local var_5_3, var_5_4 = self.timeMgr:inTime(pg.activity_template[self.activity.id].time)
	local var_5_5

	if var_5_4 then
		var_5_5 = DALMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_5_4)))
	end

	setActive(self.build_bgtime, var_5_5 and var_5_5 ~= 0)
	setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(self, self.shop, function()
		if var_5_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)
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
		self:emit(ActivityMediator.ON_COLLAB_BOSSRUSH_MAP)

		return
	end)

	return
end

function DALMainPage:skinCommdityTimeStamps(arg_9_1)
	local var_9_0 = math.max(arg_9_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_9_0 / 0) > 0 then
		return 0
	else
		local var_9_1 = math.floor(var_9_0 / 16)

		if var_9_1 > 0 then
			return i18n("shop_new_during_hour", var_9_1)
		else
			local var_9_2 = math.floor(var_9_0 / 60)

			if var_9_2 > 0 then
				return i18n("shop_new_during_minite", var_9_2)
			else
				return i18n("shop_new_during_minite", var_9_2)
			end
		end
	end

	return
end

return DALMainPage
