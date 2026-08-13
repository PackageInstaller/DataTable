class = var_0_10000

local var_0_0 = "HolidayVillaMapScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_holiday_region

pg = var_2

local var_0_3 = var_2.activity_holiday_site

function var_0_1.getUIName(arg_1_0)
	return "HolidayVillaMapUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.mapScroll = var_1.Find(var_2_0, "mapScroll")

	local var_2_1 = arg_2_0._tf

	arg_2_0.map = var_1.Find(var_2_1, "mapScroll/Viewport/map")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0.map
	local var_2_4 = var_2.Find(var_2_3, "regions")
	local var_2_5 = arg_2_0.map

	arg_2_0.regionList = var_2_2(var_2_4, var_3.Find(var_2_5, "regions/region"))
	UIItemList = var_1

	local var_2_6 = var_1.New
	local var_2_7 = arg_2_0.map
	local var_2_8 = var_2.Find(var_2_7, "sites")
	local var_2_9 = arg_2_0.map

	arg_2_0.siteList = var_2_6(var_2_8, var_3.Find(var_2_9, "sites/site"))

	local var_2_10 = arg_2_0.map

	arg_2_0.ani = var_1.Find(var_2_10, "ani")

	local var_2_11 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_11, "ui/top/backBtn")

	local var_2_12 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_12, "ui/top/homeBtn")

	local var_2_13 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_13, "ui/top/helpBtn")

	local var_2_14 = arg_2_0._tf

	arg_2_0.res = var_1.Find(var_2_14, "ui/top/res")

	local var_2_15 = arg_2_0._tf

	arg_2_0.watermelonGameBtn = var_1.Find(var_2_15, "ui/left/watermelonGameBtn")

	local var_2_16 = arg_2_0._tf

	arg_2_0.minerGameBtn = var_1.Find(var_2_16, "ui/left/minerGameBtn")

	local var_2_17 = arg_2_0._tf

	arg_2_0.springBtn = var_1.Find(var_2_17, "ui/left/springBtn")

	local var_2_18 = arg_2_0._tf

	arg_2_0.taskBar = var_1.Find(var_2_18, "ui/taskBar")

	local var_2_19 = arg_2_0._tf

	arg_2_0.bookBtn = var_1.Find(var_2_19, "ui/bookBtn")

	local var_2_20 = arg_2_0._tf

	arg_2_0.taskBtn = var_1.Find(var_2_20, "ui/taskBtn")

	local var_2_21 = arg_2_0._tf

	arg_2_0.shopBtn = var_1.Find(var_2_21, "ui/shopBtn")

	local var_2_22 = arg_2_0._tf

	arg_2_0.wharfBtn = var_1.Find(var_2_22, "ui/wharfBtn")

	local var_2_23 = arg_2_0._tf

	arg_2_0.mapScaleSlider = var_1.Find(var_2_23, "ui/mapScaleSlider")

	local var_2_24 = arg_2_0._tf

	arg_2_0.siteDescPage = var_1.Find(var_2_24, "subPages/siteDescPage")

	local var_2_25 = arg_2_0._tf

	arg_2_0.allRepairCompletePage = var_1.Find(var_2_25, "subPages/allRepairCompletePage")
	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_2.Find(var_2_26, "ui/bookBtn/name")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("holiday_tip_collection"))

	setText = var_1

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_2.Find(var_2_28, "ui/taskBtn/name")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("holiday_tip_task"))

	setText = var_1

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_2.Find(var_2_30, "ui/shopBtn/name")

	i18n = var_2_30

	var_1(var_2_31, var_2_30("holiday_tip_shop"))

	setText = var_1

	local var_2_32 = arg_2_0._tf
	local var_2_33 = var_2.Find(var_2_32, "ui/wharfBtn/name")

	i18n = var_2_32

	var_1(var_2_33, var_2_32("holiday_tip_trans"))

	setText = var_1

	local var_2_34 = arg_2_0._tf
	local var_2_35 = var_2.Find(var_2_34, "ui/taskBar/title")

	i18n = var_2_34

	var_1(var_2_35, var_2_34("holiday_tip_task_now"))

	setText = var_1

	local var_2_36 = arg_2_0.allRepairCompletePage
	local var_2_37 = var_2.Find(var_2_36, "panel/desc")

	i18n = var_2_36

	var_1(var_2_37, var_2_36("holiday_tip_finish"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:RefreshData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.helpBtn

	local function var_3_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.holiday_tip_gametip.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	local var_3_9 = arg_3_0.mapScroll.rect.width
	local var_3_10 = arg_3_0.mapScroll.rect.height

	math = var_3_7

	local var_3_11 = var_3_7.max(var_3_9 / 0, var_3_10 / 2522)
	local var_3_12 = arg_3_0.mapScaleSlider
	local var_3_13 = var_4.GetComponent

	typeof = var_1_10006
	Slider = var_1_10007
	var_3_13(var_3_12, var_1_10006(var_1_10007)).minValue = var_3_11

	local var_3_14 = arg_3_0.mapScaleSlider
	local var_3_15 = var_4.GetComponent

	typeof = var_6
	Slider = var_1_10007

	local var_3_16 = var_3_15(var_3_14, var_6(var_1_10007))

	var_3_16.value = 1
	onSlider = var_3_16

	var_3_16(arg_3_0, arg_3_0.mapScaleSlider, function(arg_7_0)
		local var_7_0 = arg_3_0.map

		Vector3 = var_2_10002
		var_7_0.localScale = var_2_10002(arg_7_0, arg_7_0, 1)
		Vector3 = var_7_0

		local var_7_1 = var_7_0(1 / arg_7_0, 1 / arg_7_0, 1)
		local var_7_2 = 0
		local var_7_3 = arg_3_0.map

		for iter_7_0 = var_7_2, var_3.Find(var_7_3, "regions").childCount - 1 do
			local var_7_4 = arg_3_0.map
			local var_7_5 = var_6.Find(var_7_4, "regions")

			var_6.GetChild(var_7_5, iter_7_0).localScale = var_7_1
		end

		local var_7_6 = 0
		local var_7_7 = arg_3_0.map

		for iter_7_1 = var_7_6, var_3.Find(var_7_7, "sites").childCount - 1 do
			local var_7_8 = arg_3_0.map
			local var_7_9 = var_6.Find(var_7_8, "sites")

			var_6.GetChild(var_7_9, iter_7_1).localScale = var_7_1
		end

		setActive = var_7_6

		local var_7_10 = arg_3_0.map

		var_7_6(var_3.Find(var_7_10, "regions"), arg_7_0 > 0.75)

		setActive = var_7_6

		local var_7_11 = arg_3_0.map

		var_7_6(var_3.Find(var_7_11, "sites"), arg_7_0 > 0.75)

		return
	end)
	arg_3_0:Show()

	setActive = var_4

	var_4(arg_3_0.ani, false)

	setActive = var_4

	var_4(arg_3_0.siteDescPage, false)

	setActive = var_4

	var_4(arg_3_0.allRepairCompletePage, false)

	pg = var_4

	local var_3_17 = var_4.NewStoryMgr.GetInstance()

	var_4.Play(var_3_17, arg_3_0.firstStory, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.NewStoryMgr.GetInstance()

		if not var_0.IsPlayed(var_8_0, "HOLIDAY_1") then
			pg = var_0

			local var_8_1 = var_0.NewGuideMgr.GetInstance()

			var_0.Play(var_8_1, "HOLIDAY_1")

			pg = var_0

			local var_8_2 = var_0.m02
			local var_8_3 = var_0.sendNotification

			GAME = var_2

			var_8_3(var_8_2, var_2.STORY_UPDATE, {
				storyId = "HOLIDAY_1"
			})
		end

		return
	end)

	return
end

function var_0_1.InitData(arg_9_0)
	ActivityConst = var_1_10001
	arg_9_0.activityId = var_1_10001.HOLIDAY_ACT_ID
	ActivityConst = var_1
	arg_9_0.taskActivityId = var_1.HOLIDAY_TASK_ID
	getProxy = var_1
	ActivityProxy = var_1_10002
	arg_9_0.activityProxy = var_1(var_1_10002)
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_9_0.taskProxy = var_1(var_1_10002)

	local var_9_0 = arg_9_0.activityProxy

	arg_9_0.activity = var_1.getActivityById(var_9_0, arg_9_0.activityId)

	local var_9_1 = arg_9_0.activity

	arg_9_0.exchangeTaskId = var_1.getConfig(var_9_1, "config_data")[1][1]

	local var_9_2 = arg_9_0.activity

	arg_9_0.taskIdAndPositions = var_1.getConfig(var_9_2, "config_client").task
	arg_9_0.mapTimes = var_1.endingtime
	arg_9_0.funtionIds = var_1.function_id
	arg_9_0.firstStory = var_1.first_story

	return
end

function var_0_1.RefreshData(arg_10_0)
	local var_10_0 = arg_10_0.activityProxy

	arg_10_0.activity = var_1.getActivityById(var_10_0, arg_10_0.activityId)
	arg_10_0.hasExchanged = arg_10_0.activity.data1 == 1

	local var_10_1 = arg_10_0.activity

	arg_10_0.clickedSiteIds = var_1.getData1List(var_10_1)

	return
end

function var_0_1.Show(arg_11_0)
	arg_11_0:ExchangeAndSiteClick()
	arg_11_0:ShowMap()
	arg_11_0:ShowUI()

	return
end

function var_0_1.ExchangeAndSiteClick(arg_12_0)
	local var_12_0 = arg_12_0.taskProxy
	local var_12_1 = var_1.getFinishTaskById(var_12_0, arg_12_0.exchangeTaskId)
	local var_12_2 = arg_12_0.activity
	local var_12_3

	if var_2.getData1(var_12_2) == 0 and var_12_1 and not arg_12_0.doingExchange then
		var_12_3 = {}

		local var_12_4 = {
			66001
		}
		local var_12_5 = arg_12_0.activity

		var_12_4[2] = var_4.getVitemNumber(var_12_5, 66001)
		var_12_3[1] = var_12_4

		local var_12_6 = {
			66002
		}
		local var_12_7 = arg_12_0.activity

		var_12_6[2] = var_4.getVitemNumber(var_12_7, 66002)
		var_12_3[2] = var_12_6

		local var_12_8 = {
			66003
		}
		local var_12_9 = arg_12_0.activity

		var_12_8[2] = var_4.getVitemNumber(var_12_9, 66003)
		var_12_3[3] = var_12_8

		local var_12_10 = {
			66004
		}
		local var_12_11 = arg_12_0.activity

		var_12_10[2] = var_4.getVitemNumber(var_12_11, 66004)
		var_12_3[4] = var_12_10

		local var_12_12 = {
			66005
		}
		local var_12_13 = arg_12_0.activity

		var_12_12[2] = var_4.getVitemNumber(var_12_13, 66005)
		var_12_3[5] = var_12_12
		arg_12_0.beforeExchangeResList = var_12_3

		local var_12_14 = arg_12_0

		var_12_3 = arg_12_0.emit
		HolidayVillaMapMediator = var_4

		var_12_3(var_12_14, var_4.EXCHANGE_RESOURCES, arg_12_0.activityId)

		arg_12_0.doingExchange = true
	end

	ipairs = var_12_3

	for iter_12_0, iter_12_1 in var_12_3(var_0_2.all) do
		local var_12_15 = var_0_2[iter_12_1]
		local var_12_16 = arg_12_0.taskProxy
		local var_12_17 = var_8.getTaskVO(var_12_16, var_12_15.task_id)

		if var_8.getTaskStatus(var_12_17) == 2 then
			table = var_12_17

			if not var_12_17.contains(arg_12_0.clickedSiteIds, var_12_15.site_id) then
				local var_12_18 = arg_12_0
				local var_12_19 = arg_12_0.emit

				HolidayVillaMapMediator = var_12

				var_12_19(var_12_18, var_12.SITE_CLICKED, arg_12_0.activityId, var_12_15.site_id)
			end
		end
	end

	ipairs = var_2

	for iter_12_2, iter_12_3 in var_2(var_0_3.all) do
		if var_0_3[iter_12_3].type == 1 then
			table = var_8

			if var_8.contains(arg_12_0.clickedSiteIds, var_7.id) then
				pg = var_8

				local var_12_20 = var_8.NewStoryMgr.GetInstance()

				if not var_8.IsPlayed(var_12_20, var_7.jumpto) then
					pg = var_8

					local var_12_21 = var_8.m02
					local var_12_22 = var_8.sendNotification

					GAME = var_10

					var_12_22(var_12_21, var_10.STORY_UPDATE, {
						storyId = var_7.jumpto
					})
				end
			end
		end
	end

	return
end

function var_0_1.ShowMap(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = arg_13_0.regionList

	var_2.make(var_13_1, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_0_2.all[arg_14_1 + 1]
			local var_14_1 = var_0_2[var_14_0]
			local var_14_2 = var_0_3[var_14_1.site_id]
			local var_14_3 = arg_13_0.taskProxy
			local var_14_4 = var_6.getTaskVO(var_14_3, var_14_1.task_id)
			local var_14_5 = var_6.getTaskStatus(var_14_4)

			if var_14_2.task_id == 0 then
				setActive = var_8

				var_8(arg_14_2, var_14_5 ~= 2)
			else
				local var_14_6 = arg_13_0.taskProxy
				local var_14_7 = var_8.getTaskVO(var_14_6, var_14_2.task_id)
				local var_14_8 = var_8.getTaskStatus(var_14_7)

				setActive = var_14_7

				var_14_7(arg_14_2, var_14_8 == 2 and var_14_5 ~= 2)
			end

			if var_14_5 ~= 2 then
				Vector2 = var_8
				arg_14_2.anchoredPosition = var_8(var_14_1.locate[1], var_14_1.locate[2])
				setText = var_8

				var_8(arg_14_2:Find("name"), var_14_2.name)

				local var_14_9 = var_6:getConfig("target_id_2")
				local var_14_10 = arg_13_0

				var_9.SetRes(var_14_10, arg_14_2:Find("res"), var_14_9)

				onButton = var_9

				local var_14_11 = arg_13_0
				local var_14_12 = arg_14_2

				local function var_14_13()
					ipairs = var_3_10000

					for iter_15_0, iter_15_1 in var_3_10000(var_14_9) do
						local var_15_0 = iter_15_1[1]
						local var_15_1 = iter_15_1[2]
						local var_15_2 = arg_13_0.activity

						if var_15_1 > var_7.getVitemNumber(var_15_2, var_15_0) then
							pg = var_15_2

							local var_15_3 = var_15_2.TipsMgr.GetInstance()
							local var_15_4 = var_8.ShowTips

							i18n = var_3_10010

							var_15_4(var_15_3, var_3_10010("holiday_tip_rebuild_not"))

							return
						end
					end

					setActive = var_0

					var_0(arg_13_0.ani, true)

					local var_15_5 = arg_13_0.ani

					Vector2 = var_1
					var_15_5.anchoredPosition = var_1(var_14_1.rebuild_ani[1], var_14_1.rebuild_ani[2])
					SetActionCallback = var_15_5

					var_15_5(arg_13_0.ani, function(arg_16_0)
						if arg_16_0 == "finish" then
							setActive = var_4_10001

							var_4_10001(arg_13_0.ani, false)

							local var_16_0 = arg_13_0
							local var_16_1 = var_1.emit

							HolidayVillaMapMediator = var_3

							var_16_1(var_16_0, var_3.ON_TASK_SUBMIT_ONESTEP, arg_13_0.taskActivityId, {
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

									local var_17_1 = arg_13_0

									var_2.ShowSiteDescPage(var_17_1, var_14_2, true, function()
										if var_17_0 then
											pg = var_0

											local var_18_0 = var_0.NewStoryMgr.GetInstance()

											if not var_0.IsPlayed(var_18_0, var_17_0) then
												pg = var_0

												local var_18_1 = var_0.NewGuideMgr.GetInstance()

												var_0.Play(var_18_1, var_17_0)

												pg = var_0

												local var_18_2 = var_0.m02
												local var_18_3 = var_0.sendNotification

												GAME = var_2

												var_18_3(var_18_2, var_2.STORY_UPDATE, {
													storyId = var_17_0
												})
											end
										end

										return
									end)

									local var_17_2 = arg_13_0
									local var_17_3 = var_2.emit

									HolidayVillaMapMediator = var_4

									var_17_3(var_17_2, var_4.SITE_CLICKED, arg_13_0.activityId, var_14_1.site_id)
								end

								return
							end)
						end

						return
					end)

					SetAction = var_15_5

					var_15_5(arg_13_0.ani, "normal", false)

					return
				end

				SFX_PANEL = var_13

				var_9(var_14_11, var_14_12, var_14_13, var_13)
			else
				var_13_0 = var_13_0 + 1
			end
		end

		return
	end)

	local var_13_2 = arg_13_0.regionList

	var_2.align(var_13_2, #var_0_2.all)

	for iter_13_0 = 0, 8 do
		setActive = var_1_10006
		var_1_10008 = arg_13_0.map

		var_1_10006(var_7.GetChild(var_1_10008, iter_13_0), false)
	end

	local var_13_4

	if var_13_0 ~= 6 then
		setActive = var_2

		local var_13_3 = arg_13_0.map

		var_2(var_13_4.Find(var_13_3, "bg" .. var_13_0), true)
	else
		pg = var_2
		var_13_4 = var_2.TimeMgr.GetInstance()

		local var_13_5 = var_2.GetServerHour(var_13_4)

		ipairs = var_13_4

		for iter_13_1, iter_13_2 in var_13_4(arg_13_0.mapTimes) do
			var_1_10008 = iter_13_2[1][1]

			local var_13_6 = iter_13_2[1][2]
			local var_13_7 = iter_13_2[2]
			local var_13_8 = iter_13_2[3]

			if var_1_10008 <= var_13_5 and var_13_5 < var_13_6 then
				setActive = var_1_10012

				local var_13_9 = arg_13_0.map

				var_1_10012(var_13.Find(var_13_9, "bg" .. var_13_0 .. "_" .. var_13_7), true)

				if arg_13_0.bgm ~= var_13_8 then
					arg_13_0.bgm = var_13_8
					pg = var_1_10012

					local var_13_10 = var_1_10012.BgmMgr.GetInstance()

					var_1_10012.Push(var_13_10, arg_13_0.__cname, var_13_8)
				end

				break
			end
		end
	end

	local var_13_11 = {
		1,
		2,
		3
	}

	Clone = var_13_4

	for iter_13_3 = #var_13_4(var_0_3.all), 1, -1 do
		table = var_1_10008

		if not var_1_10008.contains(var_13_11, var_0_3[var_3[iter_13_3]].type) then
			table = var_1_10008

			var_1_10008.remove(var_3, iter_13_3)
		end
	end

	local var_13_12 = arg_13_0.siteList

	var_4.make(var_13_12, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_0[arg_19_1 + 1]
			local var_19_1 = var_0_3[var_19_0].type
			local var_19_2 = arg_13_0.taskProxy
			local var_19_3 = var_6.getFinishTaskById(var_19_2, var_4.task_id)

			setActive = var_19_2

			var_19_2(arg_19_2:Find("1"), var_19_1 == 2)

			setActive = var_19_2

			var_19_2(arg_19_2:Find("2"), var_19_1 == 1 or var_19_1 == 3)

			if var_19_3 then
				table = var_19_2

				if not var_19_2.contains(arg_13_0.clickedSiteIds, var_19_0) then
					Vector2 = var_19_2
					arg_19_2.anchoredPosition = var_19_2(var_4.locate[1], var_4.locate[2])

					if var_19_1 == 1 then
						for iter_19_0 = 0, arg_19_2:Find("2").childCount - 1 do
							local var_19_4 = arg_19_2:Find("2")

							var_2_10011 = var_2_10011.GetChild(var_19_4, iter_19_0)
							setActive = var_19_4

							var_19_4(var_2_10011, var_2_10011.name == var_4.icon)
						end

						onButton = var_19_2

						local var_19_5 = arg_13_0
						local var_19_6 = arg_19_2

						local function var_19_7()
							pg = var_3_10000

							local var_20_0 = var_3_10000.NewStoryMgr.GetInstance()

							var_0.Play(var_20_0, var_0.jumpto)

							local var_20_1 = arg_13_0
							local var_20_2 = var_0.emit

							HolidayVillaMapMediator = var_2

							var_20_2(var_20_1, var_2.SITE_CLICKED, arg_13_0.activityId, var_19_0)

							return
						end

						SFX_PANEL = var_2_10011

						var_19_2(var_19_5, var_19_6, var_19_7, var_2_10011)
					elseif var_19_1 == 2 then
						setText = var_19_2

						var_19_2(arg_19_2:Find("1/name"), var_4.name)

						onButton = var_19_2

						local var_19_8 = arg_13_0
						local var_19_9 = arg_19_2

						local function var_19_10()
							if var_19_0 == arg_13_0.funtionIds[1] then
								triggerButton = var_0

								var_0(arg_13_0.watermelonGameBtn)
							elseif var_19_0 == arg_13_0.funtionIds[2] then
								triggerButton = var_0

								var_0(arg_13_0.minerGameBtn)
							elseif var_19_0 == arg_13_0.funtionIds[3] then
								triggerButton = var_0

								var_0(arg_13_0.springBtn)
							elseif var_19_0 == arg_13_0.funtionIds[4] then
								triggerButton = var_0

								var_0(arg_13_0.wharfBtn)
							end

							return
						end

						SFX_PANEL = var_2_10011

						var_19_2(var_19_8, var_19_9, var_19_10, var_2_10011)
					elseif var_19_1 == 3 then
						for iter_19_1 = 0, arg_19_2:Find("2").childCount - 1 do
							local var_19_11 = arg_19_2:Find("2")

							var_2_10011 = var_2_10011.GetChild(var_19_11, iter_19_1)
							setActive = var_19_11

							var_19_11(var_2_10011, var_2_10011.name == var_4.icon)
						end

						onButton = var_19_2

						local var_19_12 = arg_13_0
						local var_19_13 = arg_19_2

						local function var_19_14()
							local var_22_0 = arg_13_0

							var_0.ShowSiteDescPage(var_22_0, var_0, false)

							local var_22_1 = arg_13_0
							local var_22_2 = var_0.emit

							HolidayVillaMapMediator = var_2

							var_22_2(var_22_1, var_2.SITE_CLICKED, arg_13_0.activityId, var_19_0)

							return
						end

						SFX_PANEL = var_2_10011

						var_19_2(var_19_12, var_19_13, var_19_14, var_2_10011)
					end

					goto label_19_0
				end
			end

			setActive = var_19_2

			var_19_2(arg_19_2, false)

			::label_19_0::
		end

		return
	end)

	local var_13_13 = arg_13_0.siteList

	var_4.align(var_13_13, #var_3)

	return
end

function var_0_1.ShowUI(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = {
		66001
	}
	local var_23_2 = arg_23_0.activity

	var_23_1[2] = var_3.getVitemNumber(var_23_2, 66001)
	var_23_0[1] = var_23_1

	local var_23_3 = {
		66002
	}
	local var_23_4 = arg_23_0.activity

	var_23_3[2] = var_3.getVitemNumber(var_23_4, 66002)
	var_23_0[2] = var_23_3

	local var_23_5 = {
		66003
	}
	local var_23_6 = arg_23_0.activity

	var_23_5[2] = var_3.getVitemNumber(var_23_6, 66003)
	var_23_0[3] = var_23_5

	local var_23_7 = {
		66004
	}
	local var_23_8 = arg_23_0.activity

	var_23_7[2] = var_3.getVitemNumber(var_23_8, 66004)
	var_23_0[4] = var_23_7

	arg_23_0:SetRes(arg_23_0.res, var_23_0)

	local var_23_9 = var_0_3[arg_23_0.funtionIds[1]].task_id
	local var_23_10 = arg_23_0.taskProxy
	local var_23_11 = var_3.getFinishTaskById(var_23_10, var_23_9)

	setActive = var_23_10

	local var_23_12 = arg_23_0.watermelonGameBtn

	var_23_10(var_5.Find(var_23_12, "lock"), not var_23_11)

	setActive = var_23_10

	local var_23_13 = arg_23_0.watermelonGameBtn

	var_23_10(var_5.Find(var_23_13, "remain"), var_23_11)

	if var_23_11 then
		setText = var_23_10

		local var_23_14 = arg_23_0.watermelonGameBtn
		local var_23_15 = var_5.Find(var_23_14, "remain/Text")

		getProxy = var_23_14
		MiniGameProxy = var_7

		local var_23_16 = var_23_14(var_7)

		var_23_10(var_23_15, var_6.GetHubByGameId(var_23_16, 76).count)

		onButton = var_23_10

		local var_23_17 = arg_23_0
		local var_23_18 = arg_23_0.watermelonGameBtn

		local function var_23_19()
			local var_24_0 = arg_23_0
			local var_24_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_24_1(var_24_0, var_2_10002.OPEN_MINI_GAME, 76)

			return
		end

		SFX_PANEL = var_1_10008

		var_23_10(var_23_17, var_23_18, var_23_19, var_1_10008)
	else
		onButton = var_23_10

		local var_23_20 = arg_23_0
		local var_23_21 = arg_23_0.watermelonGameBtn

		local function var_23_22()
			pg = var_2_10000

			local var_25_0 = var_2_10000.TipsMgr.GetInstance()
			local var_25_1 = var_0.ShowTips

			i18n = var_2_10002

			var_25_1(var_25_0, var_2_10002("activity_holiday_function_lock"))

			return
		end

		SFX_PANEL = var_1_10008

		var_23_10(var_23_20, var_23_21, var_23_22, var_1_10008)
	end

	local var_23_23 = var_0_3[arg_23_0.funtionIds[2]].task_id
	local var_23_24 = arg_23_0.taskProxy
	local var_23_25 = var_5.getFinishTaskById(var_23_24, var_23_23)

	setActive = var_23_24

	local var_23_26 = arg_23_0.minerGameBtn

	var_23_24(var_7.Find(var_23_26, "lock"), not var_23_25)

	setActive = var_23_24

	local var_23_27 = arg_23_0.minerGameBtn

	var_23_24(var_7.Find(var_23_27, "remain"), var_23_25)

	if var_23_25 then
		setText = var_23_24

		local var_23_28 = arg_23_0.minerGameBtn
		local var_23_29 = var_7.Find(var_23_28, "remain/Text")

		getProxy = var_23_28
		MiniGameProxy = var_9

		local var_23_30 = var_23_28(var_9)

		var_23_24(var_23_29, var_8.GetHubByGameId(var_23_30, 77).count)

		onButton = var_23_24

		local var_23_31 = arg_23_0
		local var_23_32 = arg_23_0.minerGameBtn

		local function var_23_33()
			local var_26_0 = arg_23_0
			local var_26_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_26_1(var_26_0, var_2_10002.OPEN_MINI_GAME, 77)

			return
		end

		SFX_PANEL = var_1_10010

		var_23_24(var_23_31, var_23_32, var_23_33, var_1_10010)
	else
		onButton = var_23_24

		local var_23_34 = arg_23_0
		local var_23_35 = arg_23_0.minerGameBtn

		local function var_23_36()
			pg = var_2_10000

			local var_27_0 = var_2_10000.TipsMgr.GetInstance()
			local var_27_1 = var_0.ShowTips

			i18n = var_2_10002

			var_27_1(var_27_0, var_2_10002("activity_holiday_function_lock"))

			return
		end

		SFX_PANEL = var_1_10010

		var_23_24(var_23_34, var_23_35, var_23_36, var_1_10010)
	end

	local var_23_37 = var_0_3[arg_23_0.funtionIds[3]].task_id
	local var_23_38 = arg_23_0.taskProxy
	local var_23_39 = var_7.getFinishTaskById(var_23_38, var_23_37)

	setActive = var_23_38

	local var_23_40 = arg_23_0.springBtn

	var_23_38(var_9.Find(var_23_40, "lock"), not var_23_39)

	setActive = var_23_38

	local var_23_41 = arg_23_0.springBtn

	var_23_38(var_9.Find(var_23_41, "tip"), var_23_39)

	if var_23_39 then
		setActive = var_23_38

		local var_23_42 = arg_23_0.springBtn

		var_23_38(var_9.Find(var_23_42, "tip"), false)

		onButton = var_23_38

		local var_23_43 = arg_23_0
		local var_23_44 = arg_23_0.springBtn

		local function var_23_45()
			local var_28_0 = arg_23_0
			local var_28_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_28_1(var_28_0, var_2_10002.GO_HOTSPRING)

			return
		end

		SFX_PANEL = var_1_10012

		var_23_38(var_23_43, var_23_44, var_23_45, var_1_10012)
	else
		onButton = var_23_38

		local var_23_46 = arg_23_0
		local var_23_47 = arg_23_0.springBtn

		local function var_23_48()
			pg = var_2_10000

			local var_29_0 = var_2_10000.TipsMgr.GetInstance()
			local var_29_1 = var_0.ShowTips

			i18n = var_2_10002

			var_29_1(var_29_0, var_2_10002("activity_holiday_function_lock"))

			return
		end

		SFX_PANEL = var_1_10012

		var_23_38(var_23_46, var_23_47, var_23_48, var_1_10012)
	end

	local var_23_49 = arg_23_0.taskIdAndPositions[1][1]
	local var_23_50 = arg_23_0.taskProxy
	local var_23_51 = var_9.getFinishTaskById(var_23_50, var_23_49)

	setActive = var_23_50

	var_23_50(arg_23_0.bookBtn, var_23_51)

	setActive = var_23_50

	var_23_50(arg_23_0.taskBtn, var_23_51)

	setActive = var_23_50

	var_23_50(arg_23_0.shopBtn, var_23_51)

	setActive = var_23_50

	var_23_50(arg_23_0.wharfBtn, var_23_51)

	if var_23_51 then
		setActive = var_23_50

		local var_23_52 = arg_23_0.bookBtn
		local var_23_53 = var_11.Find(var_23_52, "tip")

		CollectionBookMediator = var_23_52

		var_23_50(var_23_53, var_23_52.GetCollectionBookTip())

		onButton = var_23_50

		local var_23_54 = arg_23_0
		local var_23_55 = arg_23_0.bookBtn

		local function var_23_56()
			local var_30_0 = arg_23_0
			local var_30_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_30_1(var_30_0, var_2_10002.ON_BOOK)

			return
		end

		SFX_PANEL = var_1_10014

		var_23_50(var_23_54, var_23_55, var_23_56, var_1_10014)

		setActive = var_23_50

		local var_23_57 = arg_23_0.taskBtn
		local var_23_58 = var_11.Find(var_23_57, "tip")

		HolidayVillaTasksLayer = var_23_57

		var_23_50(var_23_58, var_23_57.ShouldShowTip())

		onButton = var_23_50

		local var_23_59 = arg_23_0
		local var_23_60 = arg_23_0.taskBtn

		local function var_23_61()
			local var_31_0 = arg_23_0
			local var_31_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_31_1(var_31_0, var_2_10002.OPEN_HolidayVilla_TASk)

			return
		end

		SFX_PANEL = var_1_10014

		var_23_50(var_23_59, var_23_60, var_23_61, var_1_10014)

		setText = var_23_50

		local var_23_62 = arg_23_0.shopBtn
		local var_23_63 = var_11.Find(var_23_62, "res/Text")
		local var_23_64 = arg_23_0.activity

		var_23_50(var_23_63, var_12.getVitemNumber(var_23_64, 66005))

		onButton = var_23_50

		local var_23_65 = arg_23_0
		local var_23_66 = arg_23_0.shopBtn

		local function var_23_67()
			local var_32_0 = arg_23_0
			local var_32_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_32_1(var_32_0, var_2_10002.ON_SHOP)

			return
		end

		SFX_PANEL = var_14

		var_23_50(var_23_65, var_23_66, var_23_67, var_14)

		setText = var_23_50

		local var_23_68 = arg_23_0.wharfBtn
		local var_23_69 = var_11.Find(var_23_68, "res/Text")
		local var_23_70 = arg_23_0.activity

		var_23_50(var_23_69, var_12.getVitemNumber(var_23_70, 66006))

		onButton = var_23_50

		local var_23_71 = arg_23_0
		local var_23_72 = arg_23_0.wharfBtn

		local function var_23_73()
			local var_33_0 = arg_23_0
			local var_33_1 = var_0.emit

			HolidayVillaMapMediator = var_2_10002

			var_33_1(var_33_0, var_2_10002.OPEN_WHARF)

			return
		end

		SFX_PANEL = var_14

		var_23_50(var_23_71, var_23_72, var_23_73, var_14)
	end

	arg_23_0:SetTaskBar()

	return
end

function var_0_1.SetRes(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0 = 0, arg_34_1.childCount - 1 do
		setActive = var_1_10007

		var_1_10007(arg_34_1:GetChild(iter_34_0), false)
	end

	ipairs = var_3

	for iter_34_1, iter_34_2 in var_3(arg_34_2) do
		local var_34_0 = iter_34_2[1]
		local var_34_1 = iter_34_2[2]

		for iter_34_3 = 0, arg_34_1.childCount - 1 do
			local var_34_2 = arg_34_1:GetChild(iter_34_3).name

			tostring = var_16

			if var_34_2 == var_16(var_34_0) then
				setActive = var_34_2

				var_34_2(var_14, true)

				setText = var_34_2

				var_34_2(var_14:Find("Text"), var_34_1)

				break
			end
		end
	end

	return
end

function var_0_1.SetTaskBar(arg_35_0)
	local var_35_0 = false

	ipairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_0.taskIdAndPositions) do
		local var_35_1 = iter_35_1[1]
		local var_35_2 = iter_35_1[2]
		local var_35_3 = arg_35_0.taskProxy
		local var_35_4 = var_9.getTaskVO(var_35_3, var_35_1)

		if var_9.getTaskStatus(var_35_4) ~= 2 then
			var_35_0 = true

			if arg_35_0.nowTaskId ~= var_35_1 then
				arg_35_0.nowTaskId = var_35_1
				arg_35_0.initTaskPosition = false
			end

			setText = var_11

			local var_35_5 = arg_35_0.taskBar

			var_11(var_12.Find(var_35_5, "desc"), var_9:getConfig("desc"))

			onButton = var_11

			local var_35_6 = arg_35_0
			local var_35_7 = arg_35_0.taskBar

			local function var_35_8()
				local var_36_0 = arg_35_0.mapScaleSlider
				local var_36_1 = var_0.GetComponent

				typeof = var_2_10002
				Slider = var_2_10003
				var_36_1(var_36_0, var_2_10002(var_2_10003)).value = 1

				local var_36_2 = arg_35_0.mapScroll.rect.width
				local var_36_3 = arg_35_0.mapScroll.rect.height

				scrollTo = var_2

				var_2(arg_35_0.mapScroll, ((0 - var_36_2) / 2 - var_35_2[1]) / (0 - var_36_2), ((2522 - var_36_3) / 2 - var_35_2[2]) / (2522 - var_36_3))

				return
			end

			SFX_PANEL = var_15

			var_11(var_35_6, var_35_7, var_35_8, var_15)

			break
		end
	end

	if not var_35_0 then
		setText = var_2

		local var_35_9 = arg_35_0.taskBar
		local var_35_10 = var_3.Find(var_35_9, "desc")

		i18n = var_35_9

		var_2(var_35_10, var_35_9("holiday_tip_task_finish"))

		onButton = var_2

		local var_35_11 = arg_35_0
		local var_35_12 = arg_35_0.taskBar

		local function var_35_13()
			local var_37_0 = arg_35_0.mapScaleSlider
			local var_37_1 = var_0.GetComponent

			typeof = var_2_10002
			Slider = var_2_10003

			local var_37_2 = var_37_1(var_37_0, var_2_10002(var_2_10003))

			var_37_2.value = 1
			scrollTo = var_37_2

			var_37_2(arg_35_0.mapScroll, 0.5, 0.5)

			return
		end

		SFX_PANEL = iter_35_1

		var_2(var_35_11, var_35_12, var_35_13, iter_35_1)
	end

	if not arg_35_0.initTaskPosition then
		arg_35_0.initTaskPosition = true
		triggerButton = var_2

		var_2(arg_35_0.taskBar)
	end

	return
end

function var_0_1.ShowSiteDescPage(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	setActive = var_1_10004

	var_1_10004(arg_38_0.siteDescPage, true)

	pg = var_1_10004

	local var_38_0 = var_1_10004.UIMgr.GetInstance()

	var_4.BlurPanel(var_38_0, arg_38_0.siteDescPage)

	setActive = var_4

	local var_38_1 = arg_38_0.siteDescPage

	var_4(var_5.Find(var_38_1, "repairComplete"), arg_38_2)

	setText = var_4

	local var_38_2 = arg_38_0.siteDescPage

	var_4(var_5.Find(var_38_2, "panel/name"), arg_38_1.jumpto[1][1])

	setText = var_4

	local var_38_3 = arg_38_0.siteDescPage

	var_4(var_5.Find(var_38_3, "panel/desc"), arg_38_1.jumpto[2][1])

	LoadImageSpriteAsync = var_4

	local var_38_4 = arg_38_1.jumpto[3][1]
	local var_38_5 = arg_38_0.siteDescPage

	var_4(var_38_4, var_6.Find(var_38_5, "panel/picBg/mask/picture"))

	onButton = var_4

	local var_38_6 = arg_38_0
	local var_38_7 = arg_38_0.siteDescPage
	local var_38_8 = var_6.Find(var_38_7, "bg")

	local function var_38_9()
		setActive = var_2_10000

		var_2_10000(arg_38_0.siteDescPage, false)

		pg = var_2_10000

		local var_39_0 = var_2_10000.UIMgr.GetInstance()
		local var_39_1 = var_0.UnOverlayPanel
		local var_39_2 = arg_38_0.siteDescPage
		local var_39_3 = arg_38_0._tf

		var_39_1(var_39_0, var_39_2, var_3.Find(var_39_3, "subPages"))

		if arg_38_3 then
			arg_38_3()
		end

		return
	end

	SFX_CANCEL = var_8

	var_4(var_38_6, var_38_8, var_38_9, var_8)

	onButton = var_4

	local var_38_10 = arg_38_0
	local var_38_11 = arg_38_0.siteDescPage
	local var_38_12 = var_6.Find(var_38_11, "closeBtn")

	local function var_38_13()
		setActive = var_2_10000

		var_2_10000(arg_38_0.siteDescPage, false)

		pg = var_2_10000

		local var_40_0 = var_2_10000.UIMgr.GetInstance()
		local var_40_1 = var_0.UnOverlayPanel
		local var_40_2 = arg_38_0.siteDescPage
		local var_40_3 = arg_38_0._tf

		var_40_1(var_40_0, var_40_2, var_3.Find(var_40_3, "subPages"))

		if arg_38_3 then
			arg_38_3()
		end

		return
	end

	SFX_CANCEL = var_8

	var_4(var_38_10, var_38_12, var_38_13, var_8)

	return
end

function var_0_1.ShowAllRepairPage(arg_41_0)
	setActive = var_1_10001

	var_1_10001(arg_41_0.allRepairCompletePage, true)

	pg = var_1_10001

	local var_41_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_41_0, arg_41_0.allRepairCompletePage)

	local var_41_1 = arg_41_0
	local var_41_2 = arg_41_0.SetRes
	local var_41_3 = arg_41_0.allRepairCompletePage

	var_41_2(var_41_1, var_3.Find(var_41_3, "panel/source/res"), arg_41_0.beforeExchangeResList)

	setText = var_41_2

	local var_41_4 = arg_41_0.allRepairCompletePage
	local var_41_5 = var_2.Find(var_41_4, "panel/destination/res/Text")
	local var_41_6 = arg_41_0.activity

	var_41_2(var_41_5, var_3.getVitemNumber(var_41_6, 66005) - arg_41_0.beforeExchangeResList[5][2])

	onButton = var_41_2

	local var_41_7 = arg_41_0
	local var_41_8 = arg_41_0.allRepairCompletePage
	local var_41_9 = var_3.Find(var_41_8, "bg")

	local function var_41_10()
		setActive = var_2_10000

		var_2_10000(arg_41_0.allRepairCompletePage, false)

		pg = var_2_10000

		local var_42_0 = var_2_10000.UIMgr.GetInstance()
		local var_42_1 = var_0.UnOverlayPanel
		local var_42_2 = arg_41_0.allRepairCompletePage
		local var_42_3 = arg_41_0._tf

		var_42_1(var_42_0, var_42_2, var_3.Find(var_42_3, "subPages"))

		return
	end

	SFX_CANCEL = var_5

	var_41_2(var_41_7, var_41_9, var_41_10, var_5)

	onButton = var_41_2

	local var_41_11 = arg_41_0
	local var_41_12 = arg_41_0.allRepairCompletePage
	local var_41_13 = var_3.Find(var_41_12, "closeBtn")

	local function var_41_14()
		setActive = var_2_10000

		var_2_10000(arg_41_0.allRepairCompletePage, false)

		pg = var_2_10000

		local var_43_0 = var_2_10000.UIMgr.GetInstance()
		local var_43_1 = var_0.UnOverlayPanel
		local var_43_2 = arg_41_0.allRepairCompletePage
		local var_43_3 = arg_41_0._tf

		var_43_1(var_43_0, var_43_2, var_3.Find(var_43_3, "subPages"))

		return
	end

	SFX_CANCEL = var_5

	var_41_2(var_41_11, var_41_13, var_41_14, var_5)

	return
end

function var_0_1.willExit(arg_44_0)
	return
end

function var_0_1.onBackPressed(arg_45_0)
	isActive = var_1_10001

	local var_45_1

	if var_1_10001(arg_45_0.siteDescPage) then
		setActive = var_45_1

		var_45_1(arg_45_0.siteDescPage, false)

		pg = var_45_1

		local var_45_0 = var_45_1.UIMgr.GetInstance()

		var_45_1 = var_45_1.UnOverlayPanel

		local var_45_2 = arg_45_0.siteDescPage
		local var_45_3 = arg_45_0._tf

		var_45_1(var_45_0, var_45_2, var_4.Find(var_45_3, "subPages"))

		return
	end

	isActive = var_45_1

	if var_45_1(arg_45_0.allRepairCompletePage) then
		setActive = var_1

		var_1(arg_45_0.allRepairCompletePage, false)

		pg = var_1

		local var_45_4 = var_1.UIMgr.GetInstance()
		local var_45_5 = var_1.UnOverlayPanel
		local var_45_6 = arg_45_0.allRepairCompletePage
		local var_45_7 = arg_45_0._tf

		var_45_5(var_45_4, var_45_6, var_4.Find(var_45_7, "subPages"))

		return
	end

	arg_45_0:closeView()

	return
end

function var_0_1.IsShowMainTip(arg_46_0)
	local var_46_0 = arg_46_0:getConfig("config_client").task
	local var_46_1 = arg_46_0:getConfig("config_client").function_id
	local var_46_2 = var_0_3[var_46_1[1]].task_id

	getProxy = var_4
	TaskProxy = var_1_10005

	local var_46_3 = var_4(var_1_10005)
	local var_46_4 = var_4.getFinishTaskById(var_46_3, var_46_2)
	local var_46_5 = var_0_3[var_46_1[2]].task_id

	getProxy = var_6
	TaskProxy = var_1_10007

	local var_46_6 = var_6(var_1_10007)
	local var_46_7 = var_6.getFinishTaskById(var_46_6, var_46_5)
	local var_46_8 = var_46_0[1][1]

	getProxy = var_8
	TaskProxy = var_1_10009

	local var_46_9 = var_8(var_1_10009)
	local var_46_10 = var_8.getFinishTaskById(var_46_9, var_46_8)

	if var_46_4 then
		getProxy = var_46_9
		MiniGameProxy = var_46_11

		local var_46_11 = var_46_9(var_46_11)

		var_46_9 = var_46_9.GetHubByGameId(var_46_11, 76).count

		if not (0 < var_46_9) then
			if var_46_7 then
				getProxy = var_46_9
				MiniGameProxy = var_46_11

				local var_46_12 = var_46_9(var_46_11)

				if not (var_46_9.GetHubByGameId(var_46_12, 77).count > 0) then
					if var_46_10 then
						CollectionBookMediator = var_46_9

						if not var_46_9.GetCollectionBookTip() then
							if var_46_10 then
								::label_46_0::

								HolidayVillaTasksLayer = var_46_9
								var_46_9 = var_46_9.ShouldShowTip()

								if false then
									var_46_9 = false
								end

								goto label_46_1

								var_46_9 = true
							end
						end

						::label_46_1::

						return var_46_9
					end
				end
			end
		end
	end
end

return var_0_1
