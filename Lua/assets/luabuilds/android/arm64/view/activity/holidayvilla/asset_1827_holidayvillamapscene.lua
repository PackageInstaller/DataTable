local HolidayVillaMapScene = class("HolidayVillaMapScene", import("view.base.BaseUI"))
local var_0_1 = pg.activity_holiday_region
local var_0_2 = pg.activity_holiday_site

function HolidayVillaMapScene:getUIName()
	return "HolidayVillaMapUI"
end

function HolidayVillaMapScene:init()
	self.mapScroll = self._tf:Find("mapScroll")
	self.map = self._tf:Find("mapScroll/Viewport/map")
	self.regionList = UIItemList.New(self.map:Find("regions"), self.map:Find("regions/region"))
	self.siteList = UIItemList.New(self.map:Find("sites"), self.map:Find("sites/site"))
	self.ani = self.map:Find("ani")
	self.backBtn = self._tf:Find("ui/top/backBtn")
	self.homeBtn = self._tf:Find("ui/top/homeBtn")
	self.helpBtn = self._tf:Find("ui/top/helpBtn")
	self.res = self._tf:Find("ui/top/res")
	self.watermelonGameBtn = self._tf:Find("ui/left/watermelonGameBtn")
	self.minerGameBtn = self._tf:Find("ui/left/minerGameBtn")
	self.springBtn = self._tf:Find("ui/left/springBtn")
	self.taskBar = self._tf:Find("ui/taskBar")
	self.bookBtn = self._tf:Find("ui/bookBtn")
	self.taskBtn = self._tf:Find("ui/taskBtn")
	self.shopBtn = self._tf:Find("ui/shopBtn")
	self.wharfBtn = self._tf:Find("ui/wharfBtn")
	self.mapScaleSlider = self._tf:Find("ui/mapScaleSlider")
	self.siteDescPage = self._tf:Find("subPages/siteDescPage")
	self.allRepairCompletePage = self._tf:Find("subPages/allRepairCompletePage")

	setText(self._tf:Find("ui/bookBtn/name"), i18n("holiday_tip_collection"))
	setText(self._tf:Find("ui/taskBtn/name"), i18n("holiday_tip_task"))
	setText(self._tf:Find("ui/shopBtn/name"), i18n("holiday_tip_shop"))
	setText(self._tf:Find("ui/wharfBtn/name"), i18n("holiday_tip_trans"))
	setText(self._tf:Find("ui/taskBar/title"), i18n("holiday_tip_task_now"))
	setText(self.allRepairCompletePage:Find("panel/desc"), i18n("holiday_tip_finish"))

	return
end

function HolidayVillaMapScene:didEnter()
	self:InitData()
	self:RefreshData()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(HolidayVillaMapScene.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.holiday_tip_gametip.tip
		})

		return
	end, SFX_PANEL)

	self.mapScaleSlider:GetComponent(typeof(Slider)).minValue = math.max(self.mapScroll.rect.width / 0, self.mapScroll.rect.height / 2522)
	self.mapScaleSlider:GetComponent(typeof(Slider)).value = 1

	onSlider(self, self.mapScaleSlider, function(arg_7_0)
		self.map.localScale = Vector3(arg_7_0, arg_7_0, 1)

		local var_7_0 = Vector3(1 / arg_7_0, 1 / arg_7_0, 1)

		for iter_7_0 = 0, self.map:Find("regions").childCount - 1 do
			self.map:Find("regions"):GetChild(iter_7_0).localScale = var_7_0
		end

		for iter_7_1 = 0, self.map:Find("sites").childCount - 1 do
			self.map:Find("sites"):GetChild(iter_7_1).localScale = var_7_0
		end

		setActive(self.map:Find("regions"), arg_7_0 > 0.75)
		setActive(self.map:Find("sites"), arg_7_0 > 0.75)

		return
	end)
	self:Show()
	setActive(self.ani, false)
	setActive(self.siteDescPage, false)
	setActive(self.allRepairCompletePage, false)
	pg.NewStoryMgr.GetInstance():Play(self.firstStory, function()
		if not pg.NewStoryMgr.GetInstance():IsPlayed("HOLIDAY_1") then
			pg.NewGuideMgr.GetInstance():Play("HOLIDAY_1")
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "HOLIDAY_1"
			})
		end

		return
	end)

	return
end

function HolidayVillaMapScene:InitData()
	self.activityId = ActivityConst.HOLIDAY_ACT_ID
	self.taskActivityId = ActivityConst.HOLIDAY_TASK_ID
	self.activityProxy = getProxy(ActivityProxy)
	self.taskProxy = getProxy(TaskProxy)
	self.activity = self.activityProxy:getActivityById(self.activityId)
	self.exchangeTaskId = self.activity:getConfig("config_data")[1][1]

	local var_9_0 = self.activity:getConfig("config_client")

	self.taskIdAndPositions = var_9_0.task
	self.mapTimes = var_9_0.endingtime
	self.funtionIds = var_9_0.function_id
	self.firstStory = var_9_0.first_story

	return
end

function HolidayVillaMapScene:RefreshData()
	self.activity = self.activityProxy:getActivityById(self.activityId)
	self.hasExchanged = self.activity.data1 == 1
	self.clickedSiteIds = self.activity:getData1List()

	return
end

function HolidayVillaMapScene:Show()
	self:ExchangeAndSiteClick()
	self:ShowMap()
	self:ShowUI()

	return
end

function HolidayVillaMapScene:ExchangeAndSiteClick()
	if self.activity:getData1() == 0 and self.taskProxy:getFinishTaskById(self.exchangeTaskId) and not self.doingExchange then
		self.beforeExchangeResList = {
			{
				66001,
				self.activity:getVitemNumber(66001)
			},
			{
				66002,
				self.activity:getVitemNumber(66002)
			},
			{
				66003,
				self.activity:getVitemNumber(66003)
			},
			{
				66004,
				self.activity:getVitemNumber(66004)
			},
			{
				66005,
				self.activity:getVitemNumber(66005)
			}
		}

		self:emit(HolidayVillaMapMediator.EXCHANGE_RESOURCES, self.activityId)

		self.doingExchange = true
	end

	for iter_12_0, iter_12_1 in ipairs(var_0_1.all) do
		if self.taskProxy:getTaskVO(var_0_1[iter_12_1].task_id):getTaskStatus() == 2 and not table.contains(self.clickedSiteIds, var_0_1[iter_12_1].site_id) then
			self:emit(HolidayVillaMapMediator.SITE_CLICKED, self.activityId, var_0_1[iter_12_1].site_id)
		end
	end

	for iter_12_2, iter_12_3 in ipairs(var_0_2.all) do
		if var_0_2[iter_12_3].type == 1 and table.contains(self.clickedSiteIds, var_0_2[iter_12_3].id) then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_0_2[iter_12_3].jumpto) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = var_0_2[iter_12_3].jumpto
				})
			end
		end
	end

	return
end

function HolidayVillaMapScene:ShowMap()
	local var_13_0 = 0

	self.regionList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = var_0_1.all[arg_14_1 + 1]
			local var_14_1 = var_0_1[var_0_1.all[arg_14_1 + 1]]
			local var_14_2 = var_0_2[var_0_1[var_0_1.all[arg_14_1 + 1]].site_id]
			local var_14_3 = self.taskProxy:getTaskVO(var_0_1[var_0_1.all[arg_14_1 + 1]].task_id)
			local var_14_4 = var_14_3:getTaskStatus()

			if var_0_2[var_0_1[var_0_1.all[arg_14_1 + 1]].site_id].task_id == 0 then
				setActive(arg_14_2, var_14_4 ~= 2)
			else
				setActive(arg_14_2, self.taskProxy:getTaskVO(var_14_2.task_id):getTaskStatus() == 2 and var_14_4 ~= 2)
			end

			if var_14_4 ~= 2 then
				arg_14_2.anchoredPosition = Vector2(var_14_1.locate[1], var_14_1.locate[2])

				setText(arg_14_2:Find("name"), var_14_2.name)

				local var_14_5 = var_14_3:getConfig("target_id_2")

				self:SetRes(arg_14_2:Find("res"), var_14_5)
				onButton(self, arg_14_2, function()
					for iter_15_0, iter_15_1 in ipairs(var_14_5) do
						if iter_15_1[2] > self.activity:getVitemNumber(iter_15_1[1]) then
							pg.TipsMgr.GetInstance():ShowTips(i18n("holiday_tip_rebuild_not"))

							return
						end
					end

					setActive(self.ani, true)

					self.ani.anchoredPosition = Vector2(var_14_1.rebuild_ani[1], var_14_1.rebuild_ani[2])

					SetActionCallback(self.ani, function(arg_16_0)
						if arg_16_0 == "finish" then
							setActive(self.ani, false)
							self:emit(HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
								var_14_1.task_id
							}, function(arg_17_0)
								if arg_17_0 then
									local var_17_0

									if var_14_0 == 1 then
										var_17_0 = "HOLIDAY_2"
									elseif var_14_0 == 3 then
										var_17_0 = "HOLIDAY_3"
									elseif var_14_0 == 4 then
										var_17_0 = "HOLIDAY_4"
									elseif var_14_0 == 5 then
										var_17_0 = "HOLIDAY_5"
									elseif var_14_0 == 6 then
										var_17_0 = "HOLIDAY_6"
									end

									self:ShowSiteDescPage(var_14_2, true, function()
										if var_17_0 then
											if not pg.NewStoryMgr.GetInstance():IsPlayed(var_17_0) then
												pg.NewGuideMgr.GetInstance():Play(var_17_0)
												pg.m02:sendNotification(GAME.STORY_UPDATE, {
													storyId = var_17_0
												})
											end
										end

										return
									end)
									self:emit(HolidayVillaMapMediator.SITE_CLICKED, self.activityId, var_14_1.site_id)
								end

								return
							end)
						end

						return
					end)
					SetAction(self.ani, "normal", false)

					return
				end, SFX_PANEL)
			else
				var_13_0 = var_13_0 + 1
			end
		end

		return
	end)
	self.regionList:align(#var_0_1.all)

	for iter_13_0 = 0, 8 do
		setActive(self.map:GetChild(iter_13_0), false)
	end

	if 0 ~= 6 then
		setActive(self.map:Find("bg" .. 0), true)
	else
		local var_13_1 = pg.TimeMgr.GetInstance():GetServerHour()

		for iter_13_1, iter_13_2 in ipairs(self.mapTimes) do
			if iter_13_2[1][1] <= var_13_1 and var_13_1 < iter_13_2[1][2] then
				setActive(self.map:Find("bg" .. 0 .. "_" .. iter_13_2[2]), true)

				if self.bgm ~= iter_13_2[3] then
					self.bgm = iter_13_2[3]

					pg.BgmMgr.GetInstance():Push(self.__cname, iter_13_2[3])
				end

				break
			end
		end
	end

	local var_13_2 = {
		1,
		2,
		3
	}
	local var_13_3 = Clone(var_0_2.all)

	for iter_13_3 = #var_13_3, 1, -1 do
		if not table.contains(var_13_2, var_0_2[var_13_3[iter_13_3]].type) then
			table.remove(var_13_3, iter_13_3)
		end
	end

	self.siteList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_13_3[arg_19_1 + 1]
			local var_19_1 = var_0_2[var_13_3[arg_19_1 + 1]]
			local var_19_2 = var_0_2[var_13_3[arg_19_1 + 1]].type
			local var_19_3 = self.taskProxy:getFinishTaskById(var_0_2[var_13_3[arg_19_1 + 1]].task_id)

			setActive(arg_19_2:Find("1"), var_0_2[var_13_3[arg_19_1 + 1]].type == 2)
			setActive(arg_19_2:Find("2"), var_19_2 == 1 or var_19_2 == 3)

			if var_19_3 and not table.contains(self.clickedSiteIds, var_19_0) then
				arg_19_2.anchoredPosition = Vector2(var_19_1.locate[1], var_19_1.locate[2])

				if var_19_2 == 1 then
					for iter_19_0 = 0, arg_19_2:Find("2").childCount - 1 do
						local var_19_4 = arg_19_2:Find("2"):GetChild(iter_19_0)

						setActive(var_19_4, var_19_4.name == var_19_1.icon)
					end

					onButton(self, arg_19_2, function()
						pg.NewStoryMgr.GetInstance():Play(var_19_1.jumpto)
						self:emit(HolidayVillaMapMediator.SITE_CLICKED, self.activityId, var_19_0)

						return
					end, SFX_PANEL)
				elseif var_19_2 == 2 then
					setText(arg_19_2:Find("1/name"), var_19_1.name)
					onButton(self, arg_19_2, function()
						if var_19_0 == self.funtionIds[1] then
							triggerButton(self.watermelonGameBtn)
						elseif var_19_0 == self.funtionIds[2] then
							triggerButton(self.minerGameBtn)
						elseif var_19_0 == self.funtionIds[3] then
							triggerButton(self.springBtn)
						elseif var_19_0 == self.funtionIds[4] then
							triggerButton(self.wharfBtn)
						end

						return
					end, SFX_PANEL)
				elseif var_19_2 == 3 then
					for iter_19_1 = 0, arg_19_2:Find("2").childCount - 1 do
						local var_19_5 = arg_19_2:Find("2"):GetChild(iter_19_1)

						setActive(var_19_5, var_19_5.name == var_19_1.icon)
					end

					onButton(self, arg_19_2, function()
						self:ShowSiteDescPage(var_19_1, false)
						self:emit(HolidayVillaMapMediator.SITE_CLICKED, self.activityId, var_19_0)

						return
					end, SFX_PANEL)
				end
			else
				setActive(arg_19_2, false)
			end
		end

		return
	end)
	self.siteList:align(#var_13_3)

	return
end

function HolidayVillaMapScene:ShowUI()
	self:SetRes(self.res, {
		{
			66001,
			self.activity:getVitemNumber(66001)
		},
		{
			66002,
			self.activity:getVitemNumber(66002)
		},
		{
			66003,
			self.activity:getVitemNumber(66003)
		},
		{
			66004,
			self.activity:getVitemNumber(66004)
		}
	})

	local var_23_0 = self.taskProxy:getFinishTaskById(var_0_2[self.funtionIds[1]].task_id)

	setActive(self.watermelonGameBtn:Find("lock"), not var_23_0)
	setActive(self.watermelonGameBtn:Find("remain"), var_23_0)

	if var_23_0 then
		setText(self.watermelonGameBtn:Find("remain/Text"), getProxy(MiniGameProxy):GetHubByGameId(76).count)
		onButton(self, self.watermelonGameBtn, function()
			self:emit(HolidayVillaMapMediator.OPEN_MINI_GAME, 76)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.watermelonGameBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_holiday_function_lock"))

			return
		end, SFX_PANEL)
	end

	local var_23_1 = self.taskProxy:getFinishTaskById(var_0_2[self.funtionIds[2]].task_id)

	setActive(self.minerGameBtn:Find("lock"), not var_23_1)
	setActive(self.minerGameBtn:Find("remain"), var_23_1)

	if var_23_1 then
		setText(self.minerGameBtn:Find("remain/Text"), getProxy(MiniGameProxy):GetHubByGameId(77).count)
		onButton(self, self.minerGameBtn, function()
			self:emit(HolidayVillaMapMediator.OPEN_MINI_GAME, 77)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.minerGameBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_holiday_function_lock"))

			return
		end, SFX_PANEL)
	end

	local var_23_2 = self.taskProxy:getFinishTaskById(var_0_2[self.funtionIds[3]].task_id)

	setActive(self.springBtn:Find("lock"), not var_23_2)
	setActive(self.springBtn:Find("tip"), var_23_2)

	if var_23_2 then
		setActive(self.springBtn:Find("tip"), false)
		onButton(self, self.springBtn, function()
			self:emit(HolidayVillaMapMediator.GO_HOTSPRING)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.springBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_holiday_function_lock"))

			return
		end, SFX_PANEL)
	end

	local var_23_3 = self.taskProxy:getFinishTaskById(self.taskIdAndPositions[1][1])

	setActive(self.bookBtn, var_23_3)
	setActive(self.taskBtn, var_23_3)
	setActive(self.shopBtn, var_23_3)
	setActive(self.wharfBtn, var_23_3)

	if var_23_3 then
		setActive(self.bookBtn:Find("tip"), CollectionBookMediator.GetCollectionBookTip())
		onButton(self, self.bookBtn, function()
			self:emit(HolidayVillaMapMediator.ON_BOOK)

			return
		end, SFX_PANEL)
		setActive(self.taskBtn:Find("tip"), HolidayVillaTasksLayer.ShouldShowTip())
		onButton(self, self.taskBtn, function()
			self:emit(HolidayVillaMapMediator.OPEN_HolidayVilla_TASk)

			return
		end, SFX_PANEL)
		setText(self.shopBtn:Find("res/Text"), self.activity:getVitemNumber(66005))
		onButton(self, self.shopBtn, function()
			self:emit(HolidayVillaMapMediator.ON_SHOP)

			return
		end, SFX_PANEL)
		setText(self.wharfBtn:Find("res/Text"), self.activity:getVitemNumber(66006))
		onButton(self, self.wharfBtn, function()
			self:emit(HolidayVillaMapMediator.OPEN_WHARF)

			return
		end, SFX_PANEL)
	end

	self:SetTaskBar()

	return
end

function HolidayVillaMapScene:SetRes(arg_34_1, arg_34_2)
	for iter_34_0 = 0, arg_34_1.childCount - 1 do
		setActive(arg_34_1:GetChild(iter_34_0), false)
	end

	for iter_34_1, iter_34_2 in ipairs(arg_34_2) do
		for iter_34_3 = 0, arg_34_1.childCount - 1 do
			local var_34_0 = arg_34_1:GetChild(iter_34_3)

			if var_34_0.name == tostring(iter_34_2[1]) then
				setActive(var_34_0, true)
				setText(var_34_0:Find("Text"), iter_34_2[2])

				break
			end
		end
	end

	return
end

function HolidayVillaMapScene:SetTaskBar()
	local var_35_0 = false

	for iter_35_0, iter_35_1 in ipairs(self.taskIdAndPositions) do
		local var_35_1 = iter_35_1[2]
		local var_35_2 = self.taskProxy:getTaskVO(iter_35_1[1])

		if var_35_2:getTaskStatus() ~= 2 then
			var_35_0 = true

			if self.nowTaskId ~= iter_35_1[1] then
				self.nowTaskId = iter_35_1[1]
				self.initTaskPosition = false
			end

			setText(self.taskBar:Find("desc"), var_35_2:getConfig("desc"))
			onButton(self, self.taskBar, function()
				self.mapScaleSlider:GetComponent(typeof(Slider)).value = 1

				scrollTo(self.mapScroll, ((0 - self.mapScroll.rect.width) / 2 - var_35_1[1]) / (0 - self.mapScroll.rect.width), ((2522 - self.mapScroll.rect.height) / 2 - var_35_1[2]) / (2522 - self.mapScroll.rect.height))

				return
			end, SFX_PANEL)

			break
		end
	end

	if not var_35_0 then
		setText(self.taskBar:Find("desc"), i18n("holiday_tip_task_finish"))
		onButton(self, self.taskBar, function()
			self.mapScaleSlider:GetComponent(typeof(Slider)).value = 1

			scrollTo(self.mapScroll, 0.5, 0.5)

			return
		end, SFX_PANEL)
	end

	if not self.initTaskPosition then
		self.initTaskPosition = true

		triggerButton(self.taskBar)
	end

	return
end

function HolidayVillaMapScene:ShowSiteDescPage(arg_38_1, arg_38_2, arg_38_3)
	setActive(self.siteDescPage, true)
	pg.UIMgr.GetInstance():BlurPanel(self.siteDescPage)
	setActive(self.siteDescPage:Find("repairComplete"), arg_38_2)
	setText(self.siteDescPage:Find("panel/name"), arg_38_1.jumpto[1][1])
	setText(self.siteDescPage:Find("panel/desc"), arg_38_1.jumpto[2][1])
	LoadImageSpriteAsync(arg_38_1.jumpto[3][1], self.siteDescPage:Find("panel/picBg/mask/picture"))
	onButton(self, self.siteDescPage:Find("bg"), function()
		setActive(self.siteDescPage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.siteDescPage, self._tf:Find("subPages"))

		if arg_38_3 then
			arg_38_3()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.siteDescPage:Find("closeBtn"), function()
		setActive(self.siteDescPage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.siteDescPage, self._tf:Find("subPages"))

		if arg_38_3 then
			arg_38_3()
		end

		return
	end, SFX_CANCEL)

	return
end

function HolidayVillaMapScene:ShowAllRepairPage()
	setActive(self.allRepairCompletePage, true)
	pg.UIMgr.GetInstance():BlurPanel(self.allRepairCompletePage)
	self:SetRes(self.allRepairCompletePage:Find("panel/source/res"), self.beforeExchangeResList)
	setText(self.allRepairCompletePage:Find("panel/destination/res/Text"), self.activity:getVitemNumber(66005) - self.beforeExchangeResList[5][2])
	onButton(self, self.allRepairCompletePage:Find("bg"), function()
		setActive(self.allRepairCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.allRepairCompletePage, self._tf:Find("subPages"))

		return
	end, SFX_CANCEL)
	onButton(self, self.allRepairCompletePage:Find("closeBtn"), function()
		setActive(self.allRepairCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.allRepairCompletePage, self._tf:Find("subPages"))

		return
	end, SFX_CANCEL)

	return
end

function HolidayVillaMapScene:willExit()
	return
end

function HolidayVillaMapScene:onBackPressed()
	if isActive(self.siteDescPage) then
		setActive(self.siteDescPage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.siteDescPage, self._tf:Find("subPages"))

		return
	end

	if isActive(self.allRepairCompletePage) then
		setActive(self.allRepairCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.allRepairCompletePage, self._tf:Find("subPages"))

		return
	end

	self:closeView()

	return
end

function HolidayVillaMapScene:IsShowMainTip()
	local var_46_0 = self:getConfig("config_client").function_id
	local var_46_1 = getProxy(TaskProxy):getFinishTaskById(self:getConfig("config_client").task[1][1])

	if getProxy(TaskProxy):getFinishTaskById(var_0_2[var_46_0[1]].task_id) then
		if getProxy(MiniGameProxy):GetHubByGameId(76).count <= 0 then
			if getProxy(TaskProxy):getFinishTaskById(var_0_2[var_46_0[2]].task_id) then
				if getProxy(MiniGameProxy):GetHubByGameId(77).count <= 0 then
					local var_46_2

					if var_46_1 then
						var_46_2 = CollectionBookMediator.GetCollectionBookTip()

						if not var_46_2 then
							if var_46_1 then
								::label_46_0::

								var_46_2 = HolidayVillaTasksLayer.ShouldShowTip()
							else
								var_46_2 = true
							end
						end
					end
				end
			end
		end
	end

	return var_46_2
end

return HolidayVillaMapScene
