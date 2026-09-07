local HeLanMainPage = class("HeLanMainPage", import("...base.BaseActivityPage"))
local var_0_1 = 71132
local var_0_3 = 5901

function HeLanMainPage:OnInit()
	HeLanMainPage.super.OnInit(self)

	self.bg = self:findTF("AD")
	self.btnList = self.bg:Find("btn_list")
	self.build_bgtime = self.bg:Find("btn_list/build/build_bgtime")
	self.build_time = self.bg:Find("btn_list/build/build_bgtime/time")
	self.shop_bgtime = self.bg:Find("btn_list/shop/shop_bgtime")
	self.shop_time = self.bg:Find("btn_list/shop/shop_bgtime/time")
	self.Manual = self.bg:Find("Manual")

	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)

	return
end

function HeLanMainPage:OnDataSetting()
	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function HeLanMainPage:OnFirstFlush()
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM
		})

		return
	end)
	self:updateUI()
	eachChild(self.btnList, function(arg_5_0)
		self.btnFuncList[arg_5_0.name](arg_5_0)

		return
	end)

	return
end

function HeLanMainPage:OnUpdateFlush()
	self:updateUI()

	return
end

function HeLanMainPage:updateUI()
	local var_7_1, var_7_2 = self.timeMgr:inTime(pg.shop_template[var_0_1].time)
	local var_7_3

	if var_7_2 then
		var_7_3 = HeLanMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_7_2)))
	end

	local var_7_4, var_7_5 = self.timeMgr:inTime(pg.activity_template[var_0_3].time)
	local var_7_6 = 0

	if var_7_5 then
		var_7_6 = HeLanMainPage:skinCommdityTimeStamps((self.timeMgr:Table2ServerTime(var_7_5)))
	end

	if var_7_3 and var_7_3 ~= 0 then
		setActive(self.shop_bgtime, true)
		setText(self.shop_time, var_7_3)
	else
		setActive(self.shop_bgtime, false)
	end

	if var_7_6 and var_7_6 ~= 0 then
		setActive(self.build_bgtime, true)
		setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	else
		setActive(self.build_bgtime, false)
	end

	local var_7_7 = self.activity:getConfig("config_client")

	self.btnFuncList = {
		shop = function(arg_8_0)
			onButton(self, arg_8_0, function()
				if var_7_3 == nil then
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
				if var_7_6 == nil then
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
				self:emit(ActivityMediator.BATTLE_OPERA)

				return
			end)

			return
		end
	}

	return
end

function HeLanMainPage:skinCommdityTimeStamps(arg_14_1)
	local var_14_0 = math.max(arg_14_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_14_0 / 0) > 0 then
		return 0
	else
		local var_14_1 = math.floor(var_14_0 / 16)

		if var_14_1 > 0 then
			return i18n("time_remaining_tip") .. var_14_1 .. i18n("word_hour")
		else
			local var_14_2 = math.floor(var_14_0 / 60)

			if var_14_2 > 0 then
				return i18n("time_remaining_tip") .. var_14_2 .. i18n("word_minute")
			else
				return i18n("time_remaining_tip") .. var_14_0 .. i18n("word_second")
			end
		end
	end

	return
end

return HeLanMainPage
