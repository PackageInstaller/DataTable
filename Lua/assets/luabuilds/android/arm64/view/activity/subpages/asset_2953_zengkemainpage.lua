local ZengKeMainPage = class("ZengKeMainPage", import("...base.BaseActivityPage"))
local var_0_1 = 71151
local var_0_3 = 50013

function ZengKeMainPage:OnInit()
	ZengKeMainPage.super.OnInit(self)

	self.bg = self:findTF("AD")
	self.btnList = self:findTF("btn_list", self.bg)
	self.build_bgtime = self.bg:Find("btn_list/build/build_bgtime")
	self.build_time = self.bg:Find("btn_list/build/build_bgtime/time")
	self.shop_bgtime = self.bg:Find("btn_list/shop/shop_bgtime")
	self.shop_time = self.bg:Find("btn_list/shop/shop_bgtime/time")
	self.Manual = self.bg:Find("Manual")

	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)

	return
end

function ZengKeMainPage:OnDataSetting()
	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function ZengKeMainPage:OnFirstFlush()
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = CamouflageCityMedalAlbumView
		})))

		return
	end)
	self:updateUI()
	eachChild(self.btnList, function(arg_5_0)
		self.btnFuncList[arg_5_0.name](arg_5_0)

		return
	end)

	return
end

function ZengKeMainPage:OnUpdateFlush()
	self:updateUI()

	return
end

function ZengKeMainPage:updateUI()
	local var_7_0, var_7_1 = self.timeMgr:inTime(pg.shop_template[var_0_1].time)
	local var_7_2

	if var_7_1 then
		var_7_2 = ZengKeMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_7_1)))
	end

	setActive(self.shop_bgtime, var_7_2 and var_7_2 ~= 0)
	setText(self.shop_time, var_7_2)

	local var_7_3, var_7_4 = self.timeMgr:inTime(pg.activity_template[var_0_3].time)
	local var_7_5

	if var_7_4 then
		var_7_5 = ZengKeMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_7_4)))
	end

	setActive(self.build_bgtime, var_7_5 and var_7_5 ~= 0)
	setText(self.build_time, i18n("tolovemainpage_build_countdown"))

	local var_7_6 = self.activity:getConfig("config_client")

	self.btnFuncList = {
		shop = function(arg_8_0)
			onButton(self, arg_8_0, function()
				if var_7_2 == nil then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.GO_CHANGE_SHOP)

				return
			end)

			return
		end,
		build = function(arg_10_0)
			onButton(self, arg_10_0, function()
				if var_7_5 == nil then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
					page = BuildShipScene.PAGE_BUILD,
					projectName = BuildShipScene.PROJECTS.ACTIVITY
				})

				return
			end)

			return
		end,
		fight = function(arg_12_0)
			onButton(self, arg_12_0, function()
				self:emit(ActivityMediator.ON_BOSSRUSH_MAP)

				return
			end)

			return
		end
	}

	return
end

function ZengKeMainPage:skinCommdityTimeStamps(arg_14_1)
	local var_14_0 = math.max(arg_14_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_14_0 / 0) > 0 then
		return 0
	else
		local var_14_1 = math.floor(var_14_0 / 16)

		if var_14_1 > 0 then
			return var_14_1 .. i18n("word_hour")
		else
			local var_14_2 = math.floor(var_14_0 / 60)

			if var_14_2 > 0 then
				return var_14_2 .. i18n("word_minute")
			else
				return var_14_0 .. i18n("word_second")
			end
		end
	end

	return
end

return ZengKeMainPage
