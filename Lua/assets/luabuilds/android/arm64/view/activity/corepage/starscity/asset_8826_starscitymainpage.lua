local StarsCityMainPage = class("StarsCityMainPage", import("view.activity.CorePage.CoreActivityPage"))

function StarsCityMainPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.btnManual = self.AD:Find("TopPage/top/manual")
	self.Txtmanual = self.btnManual:Find("Text")
	self.redMalPoint = self.btnManual:Find("tip")
	self.btnGroup = self.AD:Find("btn_list")
	self.btnBuild = self.btnGroup:Find("build")
	self.btnFight = self.btnGroup:Find("fight")
	self.btnShop = self.btnGroup:Find("shop")
	self.resTimeBuild = self.btnBuild:Find("resTime/Text")
	self.resTimeShop = self.btnShop:Find("resTime/Text")

	return
end

function StarsCityMainPage:OnFirstFlush()
	local var_2_0 = self.activity:getConfig("config_client")

	var_2_0 = type(var_2_0) == "table" and var_2_0 or {}

	local function var_2_1(arg_3_0)
		if not arg_3_0 then
			return false
		end

		local var_3_0 = getProxy(ActivityProxy):getActivityById(arg_3_0)

		return not var_3_0 or var_3_0:isEnd()
	end

	onButton(self, self.btnBuild, function()
		if var_2_1(var_2_0.buildLinkActID) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnFight, function()
		if var_2_0.fightLinkActID and var_2_1(var_2_0.fightLinkActID) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		if var_2_0.fightLinkActID then
			self:emit(ActivityMediator.SKIP_ACTIVITY_MAP, var_2_0.fightLinkActID)
		else
			self:emit(ActivityMediator.BATTLE_OPERA)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnShop, function()
		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.btnManual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = StarsCityMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	setText(self.Txtmanual, i18n("anniversary_nine_main_page"))
	self:refreshBtnResTime()
	self:refreshRed()

	return
end

function StarsCityMainPage:refreshBtnResTime()
	local var_8_0 = self.activity:getConfig("config_client")

	var_8_0 = type(var_8_0) == "table" and var_8_0 or {}

	local var_8_1 = pg.TimeMgr.GetInstance():GetServerTime()

	local function var_8_2(arg_9_0, arg_9_1, arg_9_2)
		if not arg_9_0 then
			return
		end

		local var_9_1 = 0
		local var_9_2 = false

		if arg_9_2 == 1 then
			local var_9_3

			if arg_9_1 then
				var_9_3 = getProxy(ActivityProxy):getActivityById(arg_9_1) or nil
			end

			var_9_2 = var_9_3 and not var_9_3:isEnd() and var_9_3.stopTime and var_9_3.stopTime > var_8_1
			var_9_1 = math.floor((var_9_3.stopTime - var_8_1) / 16)
		else
			local var_9_4 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.shop_template[arg_9_1].time[2]) - var_8_1

			var_9_1 = math.floor(var_9_4 / 16)
			var_9_2 = var_9_4 > 0
		end

		if var_9_2 and var_9_1 <= 24 then
			setActive(arg_9_0.parent, true)

			if arg_9_2 == 1 then
				setText(arg_9_0, i18n("StarsCityMainPage_no_time"))
			else
				setText(arg_9_0, i18n("StarsCityMainPage_res_day_time", var_9_1))
			end
		else
			setActive(arg_9_0.parent, false)
			setText(arg_9_0, "")
		end

		return
	end

	var_8_2(self.resTimeBuild, var_8_0.buildLinkActID, 1)
	var_8_2(self.resTimeShop, var_8_0.shopItemID, 2)

	return
end

function StarsCityMainPage:OnUpdateFlush()
	self:refreshRed()
	self:refreshBtnResTime()

	return
end

function StarsCityMainPage:refreshRed()
	local var_11_0, var_11_1 = StarsCityMainPage.GetFujinBayMedalTaskCount()

	setActive(self.redMalPoint, var_11_1 > 0)

	return
end

function StarsCityMainPage:IsShowReminder()
	return StarsCityMainPage.IsTip()
end

function StarsCityMainPage.IsTip()
	return StarsCityMainPage.IsFujinBayMedalTaskTip()
end

function StarsCityMainPage.IsFujinBayMedalTaskTip()
	local var_14_0, var_14_1 = StarsCityMainPage.GetFujinBayMedalTaskCount()

	return var_14_1 > 0
end

function StarsCityMainPage.GetFujinBayMedalTaskCount()
	local var_15_0

	if pg.activity_medal_group[StarsCityMedalAlbumView.GROUP_ID] then
		var_15_0 = pg.activity_medal_group[StarsCityMedalAlbumView.GROUP_ID].activity_link or {}
	end

	local var_15_1

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = getProxy(ActivityProxy):getActivityById(iter_15_1[2])

		if var_15_2 and not var_15_2:isEnd() then
			var_15_1 = iter_15_1[3]

			break
		end
	end

	if not var_15_1 then
		return 0, 0, 0
	end

	local var_15_3 = getProxy(TaskProxy)
	local var_15_4 = 0
	local var_15_5 = 0

	for iter_15_2, iter_15_3 in ipairs(var_15_1) do
		local var_15_6 = var_15_3:getTaskById(iter_15_3) or var_15_3:getFinishTaskById(iter_15_3)

		if var_15_6 then
			local var_15_7 = var_15_6:getTaskStatus()

			if var_15_7 == 1 then
				var_15_5 = var_15_5 + 1
				var_15_4 = var_15_4 + 1
			elseif var_15_7 == 2 then
				var_15_4 = var_15_4 + 1
			end
		end
	end

	return var_15_4, var_15_5, #var_15_1
end

return StarsCityMainPage
