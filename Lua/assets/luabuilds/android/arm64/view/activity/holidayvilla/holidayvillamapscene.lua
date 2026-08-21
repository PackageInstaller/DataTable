local var_0_0 = class("HolidayVillaMapScene", import("view.base.BaseUI"))
local var_0_1 = pg.activity_holiday_region
local var_0_2 = pg.activity_holiday_site

function var_0_0.getUIName(arg_1_0)
	return "HolidayVillaMapUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.mapScroll = arg_2_0._tf:Find("mapScroll")
	arg_2_0.map = arg_2_0._tf:Find("mapScroll/Viewport/map")
	arg_2_0.regionList = UIItemList.New(arg_2_0.map:Find("regions"), arg_2_0.map:Find("regions/region"))
	arg_2_0.siteList = UIItemList.New(arg_2_0.map:Find("sites"), arg_2_0.map:Find("sites/site"))
	arg_2_0.ani = arg_2_0.map:Find("ani")
	arg_2_0.backBtn = arg_2_0._tf:Find("ui/top/backBtn")
	arg_2_0.homeBtn = arg_2_0._tf:Find("ui/top/homeBtn")
	arg_2_0.helpBtn = arg_2_0._tf:Find("ui/top/helpBtn")
	arg_2_0.res = arg_2_0._tf:Find("ui/top/res")
	arg_2_0.watermelonGameBtn = arg_2_0._tf:Find("ui/left/watermelonGameBtn")
	arg_2_0.minerGameBtn = arg_2_0._tf:Find("ui/left/minerGameBtn")
	arg_2_0.springBtn = arg_2_0._tf:Find("ui/left/springBtn")
	arg_2_0.taskBar = arg_2_0._tf:Find("ui/taskBar")
	arg_2_0.bookBtn = arg_2_0._tf:Find("ui/bookBtn")
	arg_2_0.taskBtn = arg_2_0._tf:Find("ui/taskBtn")
	arg_2_0.shopBtn = arg_2_0._tf:Find("ui/shopBtn")
	arg_2_0.wharfBtn = arg_2_0._tf:Find("ui/wharfBtn")
	arg_2_0.mapScaleSlider = arg_2_0._tf:Find("ui/mapScaleSlider")
	arg_2_0.siteDescPage = arg_2_0._tf:Find("subPages/siteDescPage")
	arg_2_0.allRepairCompletePage = arg_2_0._tf:Find("subPages/allRepairCompletePage")

	setText(arg_2_0._tf:Find("ui/bookBtn/name"), i18n("holiday_tip_collection"))
	setText(arg_2_0._tf:Find("ui/taskBtn/name"), i18n("holiday_tip_task"))
	setText(arg_2_0._tf:Find("ui/shopBtn/name"), i18n("holiday_tip_shop"))
	setText(arg_2_0._tf:Find("ui/wharfBtn/name"), i18n("holiday_tip_trans"))
	setText(arg_2_0._tf:Find("ui/taskBar/title"), i18n("holiday_tip_task_now"))
	setText(arg_2_0.allRepairCompletePage:Find("panel/desc"), i18n("holiday_tip_finish"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:RefreshData()
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.holiday_tip_gametip.tip
		})

		return
	end, SFX_PANEL)

	arg_3_0.mapScaleSlider:GetComponent(typeof(Slider)).minValue = math.max(arg_3_0.mapScroll.rect.width / 0, arg_3_0.mapScroll.rect.height / 2522)
	arg_3_0.mapScaleSlider:GetComponent(typeof(Slider)).value = 1

	onSlider(arg_3_0, arg_3_0.mapScaleSlider, function(arg_7_0)
		arg_3_0.map.localScale = Vector3(arg_7_0, arg_7_0, 1)

		local var_7_0 = Vector3(1 / arg_7_0, 1 / arg_7_0, 1)

		for iter_7_0 = 0, arg_3_0.map:Find("regions").childCount - 1 do
			local var_7_1 = arg_3_0.map:Find("regions")

			var_7_1:GetChild(iter_7_0).localScale = var_7_0
		end

		for iter_7_1 = 0, arg_3_0.map:Find("sites").childCount - 1 do
			local var_7_2 = arg_3_0.map:Find("sites")

			var_7_2:GetChild(iter_7_1).localScale = var_7_0
		end

		setActive(arg_3_0.map:Find("regions"), arg_7_0 > 0.75)
		setActive(arg_3_0.map:Find("sites"), arg_7_0 > 0.75)

		return
	end)
	arg_3_0:Show()
	setActive(arg_3_0.ani, false)
	setActive(arg_3_0.siteDescPage, false)
	setActive(arg_3_0.allRepairCompletePage, false)
	pg.NewStoryMgr.GetInstance():Play(arg_3_0.firstStory, function()
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

function var_0_0.InitData(arg_9_0)
	arg_9_0.activityId = ActivityConst.HOLIDAY_ACT_ID
	arg_9_0.taskActivityId = ActivityConst.HOLIDAY_TASK_ID
	arg_9_0.activityProxy = getProxy(ActivityProxy)
	arg_9_0.taskProxy = getProxy(TaskProxy)
	arg_9_0.activity = arg_9_0.activityProxy:getActivityById(arg_9_0.activityId)
	arg_9_0.exchangeTaskId = arg_9_0.activity:getConfig("config_data")[1][1]

	local var_9_0 = arg_9_0.activity:getConfig("config_client")

	arg_9_0.taskIdAndPositions = var_9_0.task
	arg_9_0.mapTimes = var_9_0.endingtime
	arg_9_0.funtionIds = var_9_0.function_id
	arg_9_0.firstStory = var_9_0.first_story

	return
end

function var_0_0.RefreshData(arg_10_0)
	arg_10_0.activity = arg_10_0.activityProxy:getActivityById(arg_10_0.activityId)
	arg_10_0.hasExchanged = arg_10_0.activity.data1 == 1
	arg_10_0.clickedSiteIds = arg_10_0.activity:getData1List()

	return
end

function var_0_0.Show(arg_11_0)
	arg_11_0:ExchangeAndSiteClick()
	arg_11_0:ShowMap()
	arg_11_0:ShowUI()

	return
end

function var_0_0.ExchangeAndSiteClick(arg_12_0)
	if arg_12_0.activity:getData1() == 0 and arg_12_0.taskProxy:getFinishTaskById(arg_12_0.exchangeTaskId) and not arg_12_0.doingExchange then
		arg_12_0.beforeExchangeResList = {
			{
				66001,
				arg_12_0.activity:getVitemNumber(66001)
			},
			{
				66002,
				arg_12_0.activity:getVitemNumber(66002)
			},
			{
				66003,
				arg_12_0.activity:getVitemNumber(66003)
			},
			{
				66004,
				arg_12_0.activity:getVitemNumber(66004)
			},
			{
				66005,
				arg_12_0.activity:getVitemNumber(66005)
			}
		}

		arg_12_0:emit(HolidayVillaMapMediator.EXCHANGE_RESOURCES, arg_12_0.activityId)

		arg_12_0.doingExchange = true
	end

	for iter_12_0, iter_12_1 in ipairs(var_0_1.all) do
		local var_12_0 = arg_12_0.taskProxy:getTaskVO(var_0_1[iter_12_1].task_id)

		if var_12_0:getTaskStatus() == 2 and not table.contains(arg_12_0.clickedSiteIds, var_0_1[iter_12_1].site_id) then
			arg_12_0:emit(HolidayVillaMapMediator.SITE_CLICKED, arg_12_0.activityId, var_0_1[iter_12_1].site_id)
		end
	end

	for iter_12_2, iter_12_3 in ipairs(var_0_2.all) do
		if var_0_2[iter_12_3].type == 1 and table.contains(arg_12_0.clickedSiteIds, var_0_2[iter_12_3].id) then
			local var_12_1 = pg.NewStoryMgr.GetInstance()

			if not var_12_1:IsPlayed(var_0_2[iter_12_3].jumpto) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = var_0_2[iter_12_3].jumpto
				})
			end
		end
	end

	return
end

function var_0_0.ShowMap(arg_13_0)
	local var_13_0 = 0

	arg_13_0.regionList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = var_0_1[var_0_1.all[arg_14_1 + 1]]
			local var_14_1 = var_0_2[var_0_1[var_0_1.all[arg_14_1 + 1]].site_id]
			local var_14_2 = arg_13_0.taskProxy:getTaskVO(var_0_1[var_0_1.all[arg_14_1 + 1]].task_id)
			local var_14_3 = var_14_2:getTaskStatus()

			if var_0_2[var_0_1[var_0_1.all[arg_14_1 + 1]].site_id].task_id == 0 then
				setActive(arg_14_2, var_14_3 ~= 2)
			else
				local var_14_4 = arg_13_0.taskProxy:getTaskVO(var_14_1.task_id)

				setActive(arg_14_2, var_14_4:getTaskStatus() == 2 and var_14_3 ~= 2)
			end

			if var_14_3 ~= 2 then
				arg_14_2.anchoredPosition = Vector2(var_14_0.locate[1], var_14_0.locate[2])

				setText(arg_14_2:Find("name"), var_14_1.name)
				arg_13_0:SetRes(arg_14_2:Find("res"), (var_14_2:getConfig("target_id_2")))
				onButton(arg_13_0, arg_14_2, function()
					for iter_15_0, iter_15_1 in ipairs(var_0) do
						if iter_15_1[2] > arg_13_0.activity:getVitemNumber(iter_15_1[1]) then
							pg.TipsMgr.GetInstance():ShowTips(i18n("holiday_tip_rebuild_not"))

							return
						end
					end

					setActive(arg_13_0.ani, true)

					arg_13_0.ani.anchoredPosition = Vector2(var_14_0.rebuild_ani[1], var_14_0.rebuild_ani[2])

					SetActionCallback(arg_13_0.ani, function(arg_16_0)
						if arg_16_0 == "finish" then
							setActive(arg_13_0.ani, false)
							arg_13_0:emit(HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP, arg_13_0.taskActivityId, {
								var_14_0.task_id
							}, function(arg_17_0)
								if arg_17_0 then
									local var_17_0

									if var_0 == 1 then
										var_17_0 = "HOLIDAY_2"
									elseif var_0 == 3 then
										var_17_0 = "HOLIDAY_3"
									elseif var_0 == 4 then
										var_17_0 = "HOLIDAY_4"
									elseif var_0 == 5 then
										var_17_0 = "HOLIDAY_5"
									elseif var_0 == 6 then
										var_17_0 = "HOLIDAY_6"
									end

									arg_13_0:ShowSiteDescPage(var_14_1, true, function()
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
									arg_13_0:emit(HolidayVillaMapMediator.SITE_CLICKED, arg_13_0.activityId, var_14_0.site_id)
								end

								return
							end)
						end

						return
					end)
					SetAction(arg_13_0.ani, "normal", false)

					return
				end, SFX_PANEL)
			else
				var_13_0 = var_13_0 + 1
			end
		end

		return
	end)
	arg_13_0.regionList:align(#var_0_1.all)

	for iter_13_0 = 0, 8 do
		setActive(arg_13_0.map:GetChild(iter_13_0), false)
	end

	if 0 ~= 6 then
		setActive(arg_13_0.map:Find("bg" .. 0), true)
	else
		local var_13_1 = pg.TimeMgr.GetInstance():GetServerHour()

		for iter_13_1, iter_13_2 in ipairs(arg_13_0.mapTimes) do
			if iter_13_2[1][1] <= var_13_1 and var_13_1 < iter_13_2[1][2] then
				setActive(arg_13_0.map:Find("bg" .. 0 .. "_" .. iter_13_2[2]), true)

				if arg_13_0.bgm ~= iter_13_2[3] then
					arg_13_0.bgm = iter_13_2[3]

					pg.BgmMgr.GetInstance():Push(arg_13_0.__cname, iter_13_2[3])
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

	arg_13_0.siteList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_13_3[arg_19_1 + 1]
			local var_19_1 = var_0_2[var_13_3[arg_19_1 + 1]]
			local var_19_2 = var_0_2[var_13_3[arg_19_1 + 1]].type
			local var_19_3 = arg_13_0.taskProxy:getFinishTaskById(var_0_2[var_13_3[arg_19_1 + 1]].task_id)

			setActive(arg_19_2:Find("1"), var_0_2[var_13_3[arg_19_1 + 1]].type == 2)
			setActive(arg_19_2:Find("2"), var_19_2 == 1 or var_19_2 == 3)

			if var_19_3 and not table.contains(arg_13_0.clickedSiteIds, var_19_0) then
				arg_19_2.anchoredPosition = Vector2(var_19_1.locate[1], var_19_1.locate[2])

				if var_19_2 == 1 then
					for iter_19_0 = 0, arg_19_2:Find("2").childCount - 1 do
						local var_19_4 = arg_19_2:Find("2"):GetChild(iter_19_0)

						setActive(var_19_4, var_19_4.name == var_19_1.icon)
					end

					onButton(arg_13_0, arg_19_2, function()
						pg.NewStoryMgr.GetInstance():Play(var_19_1.jumpto)
						arg_13_0:emit(HolidayVillaMapMediator.SITE_CLICKED, arg_13_0.activityId, var_19_0)

						return
					end, SFX_PANEL)
				elseif var_19_2 == 2 then
					setText(arg_19_2:Find("1/name"), var_19_1.name)
					onButton(arg_13_0, arg_19_2, function()
						if var_19_0 == arg_13_0.funtionIds[1] then
							triggerButton(arg_13_0.watermelonGameBtn)
						elseif var_19_0 == arg_13_0.funtionIds[2] then
							triggerButton(arg_13_0.minerGameBtn)
						elseif var_19_0 == arg_13_0.funtionIds[3] then
							triggerButton(arg_13_0.springBtn)
						elseif var_19_0 == arg_13_0.funtionIds[4] then
							triggerButton(arg_13_0.wharfBtn)
						end

						return
					end, SFX_PANEL)
				elseif var_19_2 == 3 then
					for iter_19_1 = 0, arg_19_2:Find("2").childCount - 1 do
						local var_19_5 = arg_19_2:Find("2"):GetChild(iter_19_1)

						setActive(var_19_5, var_19_5.name == var_19_1.icon)
					end

					onButton(arg_13_0, arg_19_2, function()
						arg_13_0:ShowSiteDescPage(var_19_1, false)
						arg_13_0:emit(HolidayVillaMapMediator.SITE_CLICKED, arg_13_0.activityId, var_19_0)

						return
					end, SFX_PANEL)
				end
			else
				setActive(arg_19_2, false)
			end
		end

		return
	end)
	arg_13_0.siteList:align(#var_13_3)

	return
end

function var_0_0.ShowUI(arg_23_0)
	arg_23_0:SetRes(arg_23_0.res, {
		{
			66001,
			arg_23_0.activity:getVitemNumber(66001)
		},
		{
			66002,
			arg_23_0.activity:getVitemNumber(66002)
		},
		{
			66003,
			arg_23_0.activity:getVitemNumber(66003)
		},
		{
			66004,
			arg_23_0.activity:getVitemNumber(66004)
		}
	})

	local var_23_0 = arg_23_0.taskProxy:getFinishTaskById(var_0_2[arg_23_0.funtionIds[1]].task_id)

	setActive(arg_23_0.watermelonGameBtn:Find("lock"), not var_23_0)
	setActive(arg_23_0.watermelonGameBtn:Find("remain"), var_23_0)

	if var_23_0 then
		setText(arg_23_0.watermelonGameBtn:Find("remain/Text"), getProxy(MiniGameProxy):GetHubByGameId(76).count)
		onButton(arg_23_0, arg_23_0.watermelonGameBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.OPEN_MINI_GAME, 76)

			return
		end, SFX_PANEL)
	else
		onButton(arg_23_0, arg_23_0.watermelonGameBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_holiday_function_lock"))

			return
		end, SFX_PANEL)
	end

	local var_23_1 = arg_23_0.taskProxy:getFinishTaskById(var_0_2[arg_23_0.funtionIds[2]].task_id)

	setActive(arg_23_0.minerGameBtn:Find("lock"), not var_23_1)
	setActive(arg_23_0.minerGameBtn:Find("remain"), var_23_1)

	if var_23_1 then
		setText(arg_23_0.minerGameBtn:Find("remain/Text"), getProxy(MiniGameProxy):GetHubByGameId(77).count)
		onButton(arg_23_0, arg_23_0.minerGameBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.OPEN_MINI_GAME, 77)

			return
		end, SFX_PANEL)
	else
		onButton(arg_23_0, arg_23_0.minerGameBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_holiday_function_lock"))

			return
		end, SFX_PANEL)
	end

	local var_23_2 = arg_23_0.taskProxy:getFinishTaskById(var_0_2[arg_23_0.funtionIds[3]].task_id)

	setActive(arg_23_0.springBtn:Find("lock"), not var_23_2)
	setActive(arg_23_0.springBtn:Find("tip"), var_23_2)

	if var_23_2 then
		setActive(arg_23_0.springBtn:Find("tip"), false)
		onButton(arg_23_0, arg_23_0.springBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.GO_HOTSPRING)

			return
		end, SFX_PANEL)
	else
		onButton(arg_23_0, arg_23_0.springBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_holiday_function_lock"))

			return
		end, SFX_PANEL)
	end

	local var_23_3 = arg_23_0.taskProxy:getFinishTaskById(arg_23_0.taskIdAndPositions[1][1])

	setActive(arg_23_0.bookBtn, var_23_3)
	setActive(arg_23_0.taskBtn, var_23_3)
	setActive(arg_23_0.shopBtn, var_23_3)
	setActive(arg_23_0.wharfBtn, var_23_3)

	if var_23_3 then
		setActive(arg_23_0.bookBtn:Find("tip"), CollectionBookMediator.GetCollectionBookTip())
		onButton(arg_23_0, arg_23_0.bookBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.ON_BOOK)

			return
		end, SFX_PANEL)
		setActive(arg_23_0.taskBtn:Find("tip"), HolidayVillaTasksLayer.ShouldShowTip())
		onButton(arg_23_0, arg_23_0.taskBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.OPEN_HolidayVilla_TASk)

			return
		end, SFX_PANEL)
		setText(arg_23_0.shopBtn:Find("res/Text"), arg_23_0.activity:getVitemNumber(66005))
		onButton(arg_23_0, arg_23_0.shopBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.ON_SHOP)

			return
		end, SFX_PANEL)
		setText(arg_23_0.wharfBtn:Find("res/Text"), arg_23_0.activity:getVitemNumber(66006))
		onButton(arg_23_0, arg_23_0.wharfBtn, function()
			arg_23_0:emit(HolidayVillaMapMediator.OPEN_WHARF)

			return
		end, SFX_PANEL)
	end

	arg_23_0:SetTaskBar()

	return
end

function var_0_0.SetRes(arg_34_0, arg_34_1, arg_34_2)
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

function var_0_0.SetTaskBar(arg_35_0)
	local var_35_0 = false

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.taskIdAndPositions) do
		local var_35_1 = iter_35_1[2]
		local var_35_2 = arg_35_0.taskProxy:getTaskVO(iter_35_1[1])

		if var_35_2:getTaskStatus() ~= 2 then
			var_35_0 = true

			if arg_35_0.nowTaskId ~= iter_35_1[1] then
				arg_35_0.nowTaskId = iter_35_1[1]
				arg_35_0.initTaskPosition = false
			end

			setText(arg_35_0.taskBar:Find("desc"), var_35_2:getConfig("desc"))
			onButton(arg_35_0, arg_35_0.taskBar, function()
				arg_35_0.mapScaleSlider:GetComponent(typeof(Slider)).value = 1

				scrollTo(arg_35_0.mapScroll, ((0 - arg_35_0.mapScroll.rect.width) / 2 - var_35_1[1]) / (0 - arg_35_0.mapScroll.rect.width), ((2522 - arg_35_0.mapScroll.rect.height) / 2 - var_35_1[2]) / (2522 - arg_35_0.mapScroll.rect.height))

				return
			end, SFX_PANEL)

			break
		end
	end

	if not var_35_0 then
		setText(arg_35_0.taskBar:Find("desc"), i18n("holiday_tip_task_finish"))
		onButton(arg_35_0, arg_35_0.taskBar, function()
			arg_35_0.mapScaleSlider:GetComponent(typeof(Slider)).value = 1

			scrollTo(arg_35_0.mapScroll, 0.5, 0.5)

			return
		end, SFX_PANEL)
	end

	if not arg_35_0.initTaskPosition then
		arg_35_0.initTaskPosition = true

		triggerButton(arg_35_0.taskBar)
	end

	return
end

function var_0_0.ShowSiteDescPage(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	setActive(arg_38_0.siteDescPage, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_38_0.siteDescPage)
	setActive(arg_38_0.siteDescPage:Find("repairComplete"), arg_38_2)
	setText(arg_38_0.siteDescPage:Find("panel/name"), arg_38_1.jumpto[1][1])
	setText(arg_38_0.siteDescPage:Find("panel/desc"), arg_38_1.jumpto[2][1])
	LoadImageSpriteAsync(arg_38_1.jumpto[3][1], arg_38_0.siteDescPage:Find("panel/picBg/mask/picture"))
	onButton(arg_38_0, arg_38_0.siteDescPage:Find("bg"), function()
		setActive(arg_38_0.siteDescPage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_38_0.siteDescPage, arg_38_0._tf:Find("subPages"))

		if arg_38_3 then
			arg_38_3()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_38_0, arg_38_0.siteDescPage:Find("closeBtn"), function()
		setActive(arg_38_0.siteDescPage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_38_0.siteDescPage, arg_38_0._tf:Find("subPages"))

		if arg_38_3 then
			arg_38_3()
		end

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.ShowAllRepairPage(arg_41_0)
	setActive(arg_41_0.allRepairCompletePage, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_41_0.allRepairCompletePage)
	arg_41_0:SetRes(arg_41_0.allRepairCompletePage:Find("panel/source/res"), arg_41_0.beforeExchangeResList)
	setText(arg_41_0.allRepairCompletePage:Find("panel/destination/res/Text"), arg_41_0.activity:getVitemNumber(66005) - arg_41_0.beforeExchangeResList[5][2])
	onButton(arg_41_0, arg_41_0.allRepairCompletePage:Find("bg"), function()
		setActive(arg_41_0.allRepairCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_41_0.allRepairCompletePage, arg_41_0._tf:Find("subPages"))

		return
	end, SFX_CANCEL)
	onButton(arg_41_0, arg_41_0.allRepairCompletePage:Find("closeBtn"), function()
		setActive(arg_41_0.allRepairCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_41_0.allRepairCompletePage, arg_41_0._tf:Find("subPages"))

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.willExit(arg_44_0)
	return
end

function var_0_0.onBackPressed(arg_45_0)
	if isActive(arg_45_0.siteDescPage) then
		setActive(arg_45_0.siteDescPage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_45_0.siteDescPage, arg_45_0._tf:Find("subPages"))

		return
	end

	if isActive(arg_45_0.allRepairCompletePage) then
		setActive(arg_45_0.allRepairCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_45_0.allRepairCompletePage, arg_45_0._tf:Find("subPages"))

		return
	end

	arg_45_0:closeView()

	return
end

function var_0_0.IsShowMainTip(arg_46_0)
	local var_46_9000
	local var_46_0 = arg_46_0:getConfig("config_client").function_id
	local var_46_1 = getProxy(TaskProxy):getFinishTaskById(arg_46_0:getConfig("config_client").task[1][1])

	if getProxy(TaskProxy).getFinishTaskById(var_46_9000, var_0_2[var_46_0[1]].task_id) then
		if getProxy(MiniGameProxy):GetHubByGameId(76).count <= 0 then
			if getProxy(TaskProxy):getFinishTaskById(var_0_2[var_46_0[2]].task_id) then
				if getProxy(MiniGameProxy):GetHubByGameId(77).count <= 0 then
					if var_46_1 then
						local var_46_2 = CollectionBookMediator.GetCollectionBookTip()

						if not var_46_2 then
							if var_46_1 then
								::label_46_0::

								var_46_2 = HolidayVillaTasksLayer.ShouldShowTip()

								if false then
									var_46_2 = false
								end

								goto label_46_1

								var_46_2 = true
							end
						end

						::label_46_1::

						return var_46_2
					end
				end
			end
		end
	end
end

return var_0_0
