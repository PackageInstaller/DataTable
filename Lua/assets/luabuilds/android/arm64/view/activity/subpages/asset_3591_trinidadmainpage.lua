local TrinidadMainPage = class("TrinidadMainPage", import("...base.BaseActivityPage"))
local var_0_1 = 71136
local var_0_3 = 5941

function TrinidadMainPage:OnInit()
	self.bg = self:findTF("AD")
	self.btn_list = self.bg:Find("btn_list")
	self.buildbtn = self:findTF("build", self.btn_list)
	self.build_bgtime = self:findTF("build_bgtime", self.buildbtn)
	self.build_time = self:findTF("time", self.build_bgtime)
	self.fightbtn = self:findTF("fight", self.btn_list)
	self.shopbtn = self:findTF("shop", self.btn_list)
	self.shop_bgtime = self:findTF("shop_bgtime", self.shopbtn)
	self.shop_time = self:findTF("time", self.shop_bgtime)
	self.Manual = self:findTF("Manual", self.bg)

	SetActive(self.build_bgtime, false)
	SetActive(self.shop_bgtime, false)

	return
end

function TrinidadMainPage:OnDataSetting()
	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function TrinidadMainPage:OnFirstFlush()
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = TowerRoseMedalAlbumView
		})))

		return
	end)
	self:updateUI()

	return
end

function TrinidadMainPage:OnUpdateFlush()
	self:updateUI()

	return
end

function TrinidadMainPage:updateUI()
	local var_6_0, var_6_1 = self.timeMgr:inTime(pg.shop_template[var_0_1].time)
	local var_6_2

	if var_6_1 then
		var_6_2 = TrinidadMainPage:TimeStamps((self.timeMgr:Table2ServerTime(var_6_1)))
	end

	if var_6_2 and var_6_2 ~= 0 then
		setActive(self.shop_bgtime, true)
		setText(self.shop_time, var_6_2)
	else
		setActive(self.shop_bgtime, false)
	end

	onButton(self, self.shopbtn, function()
		if var_6_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)

	local var_6_3, var_6_4 = self.timeMgr:inTime(pg.activity_template[var_0_3].time)
	local var_6_5

	if var_6_4 then
		var_6_5 = TrinidadMainPage:TimeStamps((self.timeMgr:Table2ServerTime(var_6_4)))
	end

	if var_6_5 and var_6_5 ~= 0 then
		setActive(self.build_bgtime, true)
		setText(self.build_time, i18n("tolovemainpage_build_countdown"))
	else
		setActive(self.build_bgtime, false)
	end

	onButton(self, self.buildbtn, function()
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
	onButton(self, self.fightbtn, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end)

	return
end

function TrinidadMainPage:TimeStamps(arg_10_1)
	local var_10_0 = math.max(arg_10_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_10_0 / 0) > 0 then
		return 0
	else
		local var_10_1 = math.floor(var_10_0 / 16)

		if var_10_1 > 0 then
			return i18n("time_remaining_tip") .. var_10_1 .. i18n("word_hour")
		else
			local var_10_2 = math.floor(var_10_0 / 60)

			if var_10_2 > 0 then
				return i18n("time_remaining_tip") .. var_10_2 .. i18n("word_minute")
			else
				return i18n("time_remaining_tip") .. var_10_0 .. i18n("word_second")
			end
		end
	end

	return
end

return TrinidadMainPage
