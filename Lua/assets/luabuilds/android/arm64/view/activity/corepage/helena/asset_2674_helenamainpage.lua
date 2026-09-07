local HelenaMainPage = class("HelenaMainPage", import("view.activity.CorePage.DAL.DALMainPage"))

function HelenaMainPage:OnInit()
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

	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)
	setText(self.shop:Find("shop"), i18n("yumia_main_tip_3"))
	setText(self.fight:Find("fight"), i18n("yumia_main_tip_2"))
	setText(self.build:Find("build"), i18n("yumia_main_tip_1"))
	setText(self.Manual:Find("Manual"), i18n("fengfanV3_20251023_jinianshouce"))

	return
end

function HelenaMainPage:OnFirstFlush()
	HelenaMainPage.super.OnFirstFlush(self)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = TianqiongMedalAlbumView
		})))

		return
	end)

	return
end

function HelenaMainPage:updateUI()
	if not self.shop_id then
		return
	end

	local var_4_0, var_4_1 = self.timeMgr:inTime(pg.shop_template[self.shop_id].time)
	local var_4_2

	if var_4_1 then
		var_4_2 = HelenaMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_4_1)))
	end

	setActive(self.shop_bgtime, var_4_2 and var_4_2 ~= 0)
	setText(self.shop_time, var_4_2)

	local var_4_3, var_4_4 = self.timeMgr:inTime(pg.activity_template[self.activity.id].time)
	local var_4_5

	if var_4_4 then
		var_4_5 = HelenaMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_4_4)))
	end

	setActive(self.build_bgtime, var_4_5 and var_4_5 ~= 0)
	setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(self, self.shop, function()
		if var_4_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)
	onButton(self, self.build, function()
		if var_4_5 == nil then
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
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end)

	return
end

return HelenaMainPage
