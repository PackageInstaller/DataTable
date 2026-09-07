local MainLiveAreaPage = class("MainLiveAreaPage", import("view.base.BaseSubView"))

function MainLiveAreaPage:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainLiveAreaPage.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)
	self:bind(NewMainScene.UPDATE_COVER, function(arg_2_0)
		self:ExecuteAction("UpdateCover")

		return
	end)

	return
end

function MainLiveAreaPage:getUIName()
	return "MainLiveAreaUI"
end

function MainLiveAreaPage:OnLoaded()
	self._bg = self._tf:Find("bg")

	setText(self._bg:Find("day/Text"), i18n("word_harbour"))
	setText(self._bg:Find("night/Text"), i18n("word_harbour"))

	self.timeCfg = pg.gameset.main_live_area_time.description
	self._coverBtn = self._tf:Find("cover_btn")
	self._academyBtn = self._tf:Find("school_btn")
	self._haremBtn = self._tf:Find("backyard_btn")
	self._commanderBtn = self._tf:Find("commander_btn")
	self._educateBtn = self._tf:Find("educate_btn")
	self._islandBtn = self._tf:Find("island_btn")
	self.islandAwardTF = self._islandBtn:Find("banners/award")

	setText(self.islandAwardTF:Find("Text"), i18n("island_post_acceptable"))

	self.islandEmptyTF = self._islandBtn:Find("banners/empty")

	setText(self.islandEmptyTF:Find("Text"), i18n("island_post_vacant"))

	self._dormBtn = self._tf:Find("dorm_btn")
	self._islandBtnEffect = self._islandBtn:Find("VX")
	self.coverPage = LivingAreaCoverPage.New(self._tf, self.event, {
		onHide = function()
			self:UpdateCoverTip()

			return
		end,
		onSelected = function(arg_6_0)
			self:UpdateCoverTemp(arg_6_0)

			return
		end
	})

	local var_4_0 = pg.EasyRedDotMgr.GetInstance()

	self.redDotUIList = {
		self._haremBtn:Find("tip"),
		self._academyBtn:Find("tip"),
		self._commanderBtn:Find("tip")
	}

	var_4_0:RegisterRedDot(self.redDotUIList[1], {
		"COURTYARD"
	}, function(arg_7_0)
		setActive(arg_7_0, getProxy(DormProxy):IsShowRedDot())

		return
	end)
	var_4_0:RegisterRedDot(self.redDotUIList[2], {
		"SCHOOL"
	}, function(arg_8_0)
		setActive(arg_8_0, getProxy(NavalAcademyProxy):IsShowTip())

		return
	end)
	var_4_0:RegisterRedDot(self.redDotUIList[3], {
		"COMMANDER"
	}, function(arg_9_0)
		if getProxy(PlayerProxy):getRawData().level < 40 then
			setActive(arg_9_0, false)

			return
		end

		local var_9_0 = getProxy(CommanderProxy):IsFinishAllBox()

		if not LOCK_CATTERY then
			local var_9_1

			if not var_9_0 then
				::label_9_0::

				var_9_1 = getProxy(CommanderProxy):AnyCatteryExistOP()
				var_9_1 = var_9_1 or getProxy(CommanderProxy):AnyCatteryCanUse()
			end

			setActive(arg_9_0, var_9_1)
		else
			setActive(arg_9_0, var_9_0)
		end

		return
	end)

	return
end

function MainLiveAreaPage:OnInit()
	self.mediator = MainLiveAreaPageMediator.New()

	onButton(self, self._coverBtn, function()
		self.coverPage:ExecuteAction("Show")

		return
	end, SFX_MAIN)
	onButton(self, self._commanderBtn, function()
		self.mediator:GoScene(SCENE.COMMANDERCAT, {
			fromMain = true,
			fleetType = CommanderCatScene.FLEET_TYPE_COMMON
		})
		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._haremBtn, function()
		self.mediator:GoScene(SCENE.COURTYARD)

		return
	end, SFX_MAIN)
	onButton(self, self._academyBtn, function()
		self.mediator:GoScene(SCENE.NAVALACADEMYSCENE)
		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._educateBtn, function()
		if LOCK_EDUCATE_SYSTEM then
			return
		end

		if LOCK_NEW_EDUCATE_SYSTEM then
			self.mediator:GoScene(SCENE.EDUCATE, {
				isMainEnter = true
			})
		else
			self.mediator:GoScene(SCENE.NEW_EDUCATE_SELECT)
		end

		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._islandBtn, function()
		if LOCK_ISLAND_DISPLAY then
			return
		end

		local var_16_0 = {}
		local var_16_1 = "MAP"

		if Application.isEditor or GroupHelper.IsGroupVerLastest("MAP") or not GroupHelper.IsGroupWaitToUpdate("MAP") then
			-- block empty
		else
			local var_16_2 = GroupHelper.GetGroupSize("MAP")
			local var_16_3 = HashUtil.BytesToString(var_16_2)

			if var_16_2 > 0 then
				table.insert(var_16_0, function(arg_17_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						modal = true,
						locked = true,
						type = MSGBOX_TYPE_FILE_DOWNLOAD,
						content = string.format(i18n("group_download_tip", var_16_3)),
						onYes = arg_17_0
					})

					return
				end)
			end

			table.insert(var_16_0, function(arg_18_0)
				local var_18_0 = {}
				local var_18_1 = GroupHelper.GetGroupMgrByName(var_16_1)
				local var_18_3
				local var_18_2

				if var_18_1.toUpdate then
					for iter_18_0 = 0, var_18_1.toUpdate.Count - 1 do
						table.insert(var_18_0, var_18_1.toUpdate[iter_18_0][0])
					end

					var_18_2 = {}
					var_18_3 = {}
				end

				var_18_3[1] = {
					groupName = var_16_1,
					fileNameList = var_18_0
				}
				var_18_2.dataList = var_18_3
				var_18_2.onFinish = arg_18_0

				pg.FileDownloadMgr.GetInstance():Main(var_18_2)

				return
			end)
		end

		local var_16_4 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d", true)

		if not LOCK_ISLAND_ENTER_TIP_WINDOW and PlayerPrefs.GetString("ISLAND_ENTER_TIP_WINDOW", "") ~= var_16_4 then
			table.insert(var_16_0, function(arg_19_0)
				local function var_19_0()
					if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
						PlayerPrefs.SetString("ISLAND_ENTER_TIP_WINDOW", var_16_4)
					end

					arg_19_0()

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					showStopRemind = true,
					toggleStatus = true,
					type = MSGBOX_TYPE_HELP,
					helps = i18n("island_urgent_notice"),
					onYes = var_19_0,
					onNo = var_19_0
				})

				return
			end)
		end

		seriesAsync(var_16_0, function()
			self.mediator:GoIsland(getProxy(PlayerProxy):getRawData().id)
			self:Hide()

			return
		end)

		return
	end, SFX_MAIN)
	onButton(self, self._dormBtn, function()
		self.mediator:OpenDormSelectLayer()
		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function MainLiveAreaPage:Show(arg_24_1, arg_24_2)
	MainLiveAreaPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	local var_24_0 = getProxy(PlayerProxy):getRawData()

	self._commanderBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "CommanderCatMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	if not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "CourtYardMediator") then
		self._haremBtn:GetComponent(typeof(Image)).color = Color(0.5, 0.5, 0.5, 1)
	end

	local var_24_1

	do
		self._haremBtn:GetComponent(typeof(Image)).color = Color(1, 1, 1, 1)
		var_24_1 = pg.SystemOpenMgr.GetInstance()
	end

	self._educateBtn:GetComponent(typeof(Image)).color = not var_24_1:isOpenSystem(var_24_0.level, LOCK_NEW_EDUCATE_SYSTEM and "EducateMediator" or "NewEducateSelectMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	setActive(self._educateBtn:Find("tip"), NewEducateHelper.IsShowNewChildTip())

	local var_24_2 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "SelectDorm3DMediator")

	self._dormBtn:GetComponent(typeof(Image)).color = not var_24_2 and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	;(function()
		local var_25_0 = var_24_2 and Dorm3dShopUI.ShouldShowAllTip()
		local var_25_1 = var_24_2 and Dorm3dFurniture.IsTimelimitShopTip()

		setActive(self._dormBtn:Find("tip"), var_25_0 or getProxy(ApartmentProxy):HasGiftExpireSoon())
		setActive(self._dormBtn:Find("tagFurniture"), var_25_1)

		return
	end)()

	self._islandBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "IslandMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	self:UpdataIslandTip()
	self:UpdateCover()
	self:UpdateCoverTip()
	self:UpdateTime()

	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 60, -1)

	self.timer:Start()
	setActive(self._islandBtnEffect, tobool(arg_24_1))

	if arg_24_2 then
		arg_24_2()
	end

	return
end

function MainLiveAreaPage:UpdateTime()
	local var_27_0 = pg.TimeMgr.GetInstance()
	local var_27_1 = var_27_0:GetServerHour()
	local var_27_2 = var_27_1 < 12

	setActive(self._bg:Find("AM"), var_27_1 < 12)
	setActive(self._bg:Find("PM"), not var_27_2)

	local var_27_3 = self:getCoverType(var_27_1)

	setActive(self._bg:Find("day"), var_27_3 == LivingAreaCover.TYPE_DAY)
	setActive(self._bg:Find("night"), var_27_3 == LivingAreaCover.TYPE_NIGHT)
	setActive(self._islandBtn:Find("lock/day"), var_27_3 == LivingAreaCover.TYPE_DAY)
	setActive(self._islandBtn:Find("lock/night"), var_27_3 ~= LivingAreaCover.TYPE_DAY)
	setText(self._bg:Find("date"), (var_27_0:CurrentSTimeDesc("%Y/%m/%d", true)))

	if var_27_1 > 12 then
		var_27_1 = var_27_1 - 12
	end

	setText(self._bg:Find("time"), var_27_1 .. var_27_0:CurrentSTimeDesc(":%M", true))
	setText(self._bg:Find("date/week"), (EducateHelper.GetWeekStrByNumber(var_27_0:GetServerWeek())))

	return
end

function MainLiveAreaPage:getCoverType(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(self.timeCfg) do
		if arg_28_1 >= iter_28_1[1][1] and arg_28_1 < iter_28_1[1][2] then
			return iter_28_1[2]
		end
	end

	return LivingAreaCover.TYPE_DAY
end

function MainLiveAreaPage:UpdateCover()
	local var_29_0 = getProxy(LivingAreaCoverProxy):GetCurCover()

	if self.cover and self.cover.id == var_29_0.id then
		return
	end

	self.cover = var_29_0

	self:_loadBg()

	return
end

function MainLiveAreaPage:UpdateCoverTemp(arg_30_1)
	if self.cover and self.cover.id == arg_30_1.id then
		return
	end

	self.cover = arg_30_1

	self:_loadBg()

	return
end

function MainLiveAreaPage:_loadBg()
	setImageSprite(self._bg:Find("day"), GetSpriteFromAtlas(self.cover:GetBg(LivingAreaCover.TYPE_DAY), ""), true)
	setImageSprite(self._bg:Find("night"), GetSpriteFromAtlas(self.cover:GetBg(LivingAreaCover.TYPE_NIGHT), ""), true)

	return
end

function MainLiveAreaPage:UpdateCoverTip()
	setActive(self._coverBtn:Find("tip"), getProxy(LivingAreaCoverProxy):IsTip())

	return
end

function MainLiveAreaPage:UpdataIslandTip()
	setActive(self._islandBtn:Find("banners"), not LOCK_ISLAND_DISPLAY)

	if LOCK_ISLAND_DISPLAY then
		return
	end

	local var_33_0, var_33_1 = getProxy(SystemTipProxy):GetIslandTipInfos()

	setActive(self.islandAwardTF, var_33_0 > 0)
	setActive(self.islandEmptyTF, var_33_1 > 0)

	return
end

function MainLiveAreaPage:Hide()
	if self.coverPage and self.coverPage:GetLoaded() and self.coverPage:isShowing() then
		self.coverPage:Hide()

		return
	end

	if self:isShowing() then
		MainLiveAreaPage.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MainLiveAreaPage:OnDestroy()
	local var_35_0 = pg.EasyRedDotMgr.GetInstance()

	for iter_35_0, iter_35_1 in ipairs(self.redDotUIList) do
		var_35_0:UnRegisterRedDot(iter_35_1)
	end

	self.redDotUIList = nil

	self.mediator:Dispose()

	self.mediator = nil

	self:Hide()
	self.coverPage:Destroy()

	self.coverPage = nil
	self.cover = nil

	return
end

return MainLiveAreaPage
