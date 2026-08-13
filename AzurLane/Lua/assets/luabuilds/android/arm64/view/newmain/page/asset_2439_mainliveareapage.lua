class = var_0_10000

local var_0_0 = "MainLiveAreaPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	NewMainScene = var_7

	var_1_1(var_1_0, var_7.UPDATE_COVER, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.ExecuteAction(var_2_0, "UpdateCover")

		return
	end)

	return
end

function var_0_1.getUIName(arg_3_0)
	return "MainLiveAreaUI"
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0._bg = var_1.Find(var_4_0, "bg")
	setText = var_1

	local var_4_1 = arg_4_0._bg
	local var_4_2 = var_3.Find(var_4_1, "day/Text")

	i18n = var_4

	var_1(var_4_2, var_4("word_harbour"))

	setText = var_1

	local var_4_3 = arg_4_0._bg
	local var_4_4 = var_3.Find(var_4_3, "night/Text")

	i18n = var_4

	var_1(var_4_4, var_4("word_harbour"))

	pg = var_1
	arg_4_0.timeCfg = var_1.gameset.main_live_area_time.description

	local var_4_5 = arg_4_0._tf

	arg_4_0._coverBtn = var_1.Find(var_4_5, "cover_btn")

	local var_4_6 = arg_4_0._tf

	arg_4_0._academyBtn = var_1.Find(var_4_6, "school_btn")

	local var_4_7 = arg_4_0._tf

	arg_4_0._haremBtn = var_1.Find(var_4_7, "backyard_btn")

	local var_4_8 = arg_4_0._tf

	arg_4_0._commanderBtn = var_1.Find(var_4_8, "commander_btn")

	local var_4_9 = arg_4_0._tf

	arg_4_0._educateBtn = var_1.Find(var_4_9, "educate_btn")

	local var_4_10 = arg_4_0._tf

	arg_4_0._islandBtn = var_1.Find(var_4_10, "island_btn")

	local var_4_11 = arg_4_0._islandBtn

	arg_4_0.islandAwardTF = var_1.Find(var_4_11, "banners/award")
	setText = var_1

	local var_4_12 = arg_4_0.islandAwardTF
	local var_4_13 = var_3.Find(var_4_12, "Text")

	i18n = var_4

	var_1(var_4_13, var_4("island_post_acceptable"))

	local var_4_14 = arg_4_0._islandBtn

	arg_4_0.islandEmptyTF = var_1.Find(var_4_14, "banners/empty")
	setText = var_1

	local var_4_15 = arg_4_0.islandEmptyTF
	local var_4_16 = var_3.Find(var_4_15, "Text")

	i18n = var_4

	var_1(var_4_16, var_4("island_post_vacant"))

	local var_4_17 = arg_4_0._tf

	arg_4_0._dormBtn = var_1.Find(var_4_17, "dorm_btn")

	local var_4_18 = arg_4_0._islandBtn

	arg_4_0._islandBtnEffect = var_1.Find(var_4_18, "VX")
	LivingAreaCoverPage = var_1
	arg_4_0.coverPage = var_1.New(arg_4_0._tf, arg_4_0.event, {
		onHide = function()
			local var_5_0 = arg_4_0

			var_0.UpdateCoverTip(var_5_0)

			return
		end,
		onSelected = function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.UpdateCoverTemp(var_6_0, arg_6_0)

			return
		end
	})
	pg = var_1

	local var_4_19 = var_1.EasyRedDotMgr.GetInstance()
	local var_4_20 = {}
	local var_4_21 = arg_4_0._haremBtn

	var_4_20[1] = var_3.Find(var_4_21, "tip")

	local var_4_22 = arg_4_0._academyBtn

	var_4_20[2] = var_3.Find(var_4_22, "tip")

	local var_4_23 = arg_4_0._commanderBtn

	var_4_20[3] = var_3.Find(var_4_23, "tip")
	arg_4_0.redDotUIList = var_4_20

	var_4_19:RegisterRedDot(arg_4_0.redDotUIList[1], {
		"COURTYARD"
	}, function(arg_7_0)
		setActive = var_2_10001

		local var_7_0 = arg_7_0

		getProxy = var_2_10004
		DormProxy = var_2_10006

		local var_7_1 = var_2_10004(var_2_10006)

		var_2_10001(var_7_0, var_4.IsShowRedDot(var_7_1))

		return
	end)
	var_4_19:RegisterRedDot(arg_4_0.redDotUIList[2], {
		"SCHOOL"
	}, function(arg_8_0)
		setActive = var_2_10001

		local var_8_0 = arg_8_0

		getProxy = var_2_10004
		NavalAcademyProxy = var_2_10006

		local var_8_1 = var_2_10004(var_2_10006)

		var_2_10001(var_8_0, var_4.IsShowTip(var_8_1))

		return
	end)
	var_4_19:RegisterRedDot(arg_4_0.redDotUIList[3], {
		"COMMANDER"
	}, function(arg_9_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_9_0 = var_2_10001(var_2_10003)

		if var_1.getRawData(var_9_0).level < 40 then
			setActive = var_1

			var_1(arg_9_0, false)

			return
		end

		getProxy = var_1
		CommanderProxy = var_9_0

		local var_9_1 = var_1(var_9_0)
		local var_9_2 = var_1.IsFinishAllBox(var_9_1)

		LOCK_CATTERY = var_2

		if not var_2 then
			setActive = var_2

			local var_9_3 = arg_9_0

			if not var_9_2 then
				::label_9_0::

				getProxy = var_2_10005
				CommanderProxy = var_2_10007

				local var_9_4 = var_2_10005(var_2_10007)

				if not var_2_10005.AnyCatteryExistOP(var_9_4) then
					getProxy = var_2_10005
					CommanderProxy = var_9_4

					local var_9_5 = var_2_10005(var_9_4)

					var_2_10005 = var_2_10005.AnyCatteryCanUse(var_9_5)
				end
			end

			var_2(var_9_3, var_2_10005)
		else
			setActive = var_2

			var_2(arg_9_0, var_9_2)
		end

		return
	end)

	return
end

function var_0_1.OnInit(arg_10_0)
	MainLiveAreaPageMediator = var_1_10001
	arg_10_0.mediator = var_1_10001.New()
	onButton = var_1

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._coverBtn

	local function var_10_2()
		local var_11_0 = arg_10_0.coverPage

		var_0.ExecuteAction(var_11_0, "Show")

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0._commanderBtn

	local function var_10_5()
		local var_12_0 = arg_10_0.mediator
		local var_12_1 = var_0.GoScene

		SCENE = var_2_10003

		local var_12_2 = var_2_10003.COMMANDERCAT
		local var_12_3 = {
			fromMain = true
		}

		CommanderCatScene = var_2_10005
		var_12_3.fleetType = var_2_10005.FLEET_TYPE_COMMON

		var_12_1(var_12_0, var_12_2, var_12_3)

		local var_12_4 = arg_10_0

		var_0.Hide(var_12_4)

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_3, var_10_4, var_10_5, var_1_10006)

	onButton = var_1

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0._haremBtn

	local function var_10_8()
		local var_13_0 = arg_10_0.mediator
		local var_13_1 = var_0.GoScene

		SCENE = var_2_10003

		var_13_1(var_13_0, var_2_10003.COURTYARD)

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_6, var_10_7, var_10_8, var_1_10006)

	onButton = var_1

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0._academyBtn

	local function var_10_11()
		local var_14_0 = arg_10_0.mediator
		local var_14_1 = var_0.GoScene

		SCENE = var_2_10003

		var_14_1(var_14_0, var_2_10003.NAVALACADEMYSCENE)

		local var_14_2 = arg_10_0

		var_0.Hide(var_14_2)

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_9, var_10_10, var_10_11, var_1_10006)

	onButton = var_1

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0._educateBtn

	local function var_10_14()
		LOCK_EDUCATE_SYSTEM = var_2_10000

		if var_2_10000 then
			return
		end

		LOCK_NEW_EDUCATE_SYSTEM = var_2_10000

		if var_2_10000 then
			local var_15_0 = arg_10_0.mediator
			local var_15_1 = var_0.GoScene

			SCENE = var_2_10003

			var_15_1(var_15_0, var_2_10003.EDUCATE, {
				isMainEnter = true
			})
		else
			local var_15_2 = arg_10_0.mediator
			local var_15_3 = var_0.GoScene

			SCENE = var_2_10003

			var_15_3(var_15_2, var_2_10003.NEW_EDUCATE_SELECT)
		end

		local var_15_4 = arg_10_0

		var_0.Hide(var_15_4)

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_12, var_10_13, var_10_14, var_1_10006)

	onButton = var_1

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0._islandBtn

	local function var_10_17()
		LOCK_ISLAND_DISPLAY = var_2_10000

		if var_2_10000 then
			return
		end

		local var_16_0 = {}
		local var_16_1 = "MAP"

		Application = var_2_10002

		local var_16_2

		if not var_2_10002.isEditor then
			GroupHelper = var_16_2

			if not var_16_2.IsGroupVerLastest(var_16_1) then
				GroupHelper = var_16_2

				if not var_16_2.IsGroupWaitToUpdate(var_16_1) then
					-- block empty
				else
					GroupHelper = var_16_2
					var_16_2 = var_16_2.GetGroupSize(var_16_1)
					HashUtil = var_2_10003
					var_2_10003 = var_2_10003.BytesToString(var_16_2)

					if 0 < var_16_2 then
						table = var_4

						var_4.insert(var_16_0, function(arg_17_0)
							pg = var_3_10001

							local var_17_0 = var_3_10001.MsgboxMgr.GetInstance()
							local var_17_1 = var_1.ShowMsgBox
							local var_17_2 = {
								modal = true,
								locked = true
							}

							MSGBOX_TYPE_FILE_DOWNLOAD = var_3_10005
							var_17_2.type = var_3_10005
							string = var_3_10005

							local var_17_3 = var_3_10005.format

							i18n = var_3_10007
							var_17_2.content = var_17_3(var_3_10007("group_download_tip", var_2_10003))
							var_17_2.onYes = arg_17_0

							var_17_1(var_17_0, var_17_2)

							return
						end)
					end

					table = var_4

					var_4.insert(var_16_0, function(arg_18_0)
						local var_18_0 = {}

						GroupHelper = var_3_10002

						if var_3_10002.GetGroupMgrByName(var_16_1).toUpdate then
							local var_18_1 = var_2.toUpdate.Count

							for iter_18_0 = 0, var_18_1 - 1 do
								local var_18_2 = var_2.toUpdate[iter_18_0][0]

								table = var_3_10010

								var_3_10010.insert(var_18_0, var_18_2)
							end
						end

						local var_18_3 = {
							groupName = var_16_1,
							fileNameList = var_18_0
						}
						local var_18_4 = {
							dataList = {
								var_18_3
							},
							onFinish = arg_18_0
						}

						pg = var_5

						local var_18_5 = var_5.FileDownloadMgr.GetInstance()

						var_5.Main(var_18_5, var_18_4)

						return
					end)
				end
			end
		end

		pg = var_16_2

		local var_16_3 = var_16_2.TimeMgr.GetInstance()
		local var_16_4 = var_2.CurrentSTimeDesc(var_16_3, "%Y/%m/%d", true)

		LOCK_ISLAND_ENTER_TIP_WINDOW = var_2_10003

		if not var_2_10003 then
			PlayerPrefs = var_2_10003

			if var_2_10003.GetString("ISLAND_ENTER_TIP_WINDOW", "") ~= var_16_4 then
				table = var_2_10003

				var_2_10003.insert(var_16_0, function(arg_19_0)
					local function var_19_0()
						pg = var_4_10000

						if var_4_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							PlayerPrefs = var_0

							var_0.SetString("ISLAND_ENTER_TIP_WINDOW", var_16_4)
						end

						arg_19_0()

						return
					end

					pg = var_3_10002

					local var_19_1 = var_3_10002.MsgboxMgr.GetInstance()
					local var_19_2 = var_2.ShowMsgBox
					local var_19_3 = {
						showStopRemind = true,
						toggleStatus = true
					}

					MSGBOX_TYPE_HELP = var_3_10006
					var_19_3.type = var_3_10006
					i18n = var_3_10006
					var_19_3.helps = var_3_10006("island_urgent_notice")
					var_19_3.onYes = var_19_0
					var_19_3.onNo = var_19_0

					var_19_2(var_19_1, var_19_3)

					return
				end)
			end
		end

		seriesAsync = var_2_10003

		var_2_10003(var_16_0, function()
			local var_21_0 = arg_10_0.mediator
			local var_21_1 = var_0.GoIsland

			getProxy = var_3_10003
			PlayerProxy = var_3_10005

			local var_21_2 = var_3_10003(var_3_10005)

			var_21_1(var_21_0, var_3.getRawData(var_21_2).id)

			local var_21_3 = arg_10_0

			var_0.Hide(var_21_3)

			return
		end)

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_15, var_10_16, var_10_17, var_1_10006)

	onButton = var_1

	local var_10_18 = arg_10_0
	local var_10_19 = arg_10_0._dormBtn

	local function var_10_20()
		local var_22_0 = arg_10_0.mediator

		var_0.OpenDormSelectLayer(var_22_0)

		local var_22_1 = arg_10_0

		var_0.Hide(var_22_1)

		return
	end

	SFX_MAIN = var_1_10006

	var_1(var_10_18, var_10_19, var_10_20, var_1_10006)

	onButton = var_1

	local var_10_21 = arg_10_0
	local var_10_22 = arg_10_0._tf

	local function var_10_23()
		local var_23_0 = arg_10_0

		var_0.Hide(var_23_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_10_21, var_10_22, var_10_23, var_1_10006)

	return
end

function var_0_1.Show(arg_24_0, arg_24_1, arg_24_2)
	var_0_1.super.Show(arg_24_0)

	pg = var_3

	local var_24_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_24_0, arg_24_0._tf, {
		staticBlur = true
	})

	getProxy = var_3
	PlayerProxy = var_24_0

	local var_24_1 = var_3(var_24_0)
	local var_24_2 = var_3.getRawData(var_24_1)

	pg = var_1_10004

	local var_24_3 = var_1_10004.SystemOpenMgr.GetInstance()

	if not var_4.isOpenSystem(var_24_3, var_24_2.level, "CommanderCatMediator") then
		local var_24_4 = arg_24_0._commanderBtn

		var_24_1 = var_24_1.GetComponent
		typeof = var_8
		Image = var_1_10010
		var_24_1 = var_24_1(var_24_4, var_8(var_1_10010))
		Color = var_24_3
		var_24_1.color = var_24_3(0.5, 0.5, 0.5, 1)
	else
		local var_24_5 = arg_24_0._commanderBtn

		var_24_1 = var_24_1.GetComponent
		typeof = var_8
		Image = var_1_10010
		var_24_1 = var_24_1(var_24_5, var_8(var_1_10010))
		Color = var_24_3
		var_24_1.color = var_24_3(1, 1, 1, 1)
	end

	pg = var_24_1

	local var_24_6 = var_24_1.SystemOpenMgr.GetInstance()
	local var_24_7

	if not var_5.isOpenSystem(var_24_6, var_24_2.level, "CourtYardMediator") then
		var_24_7 = arg_24_0._haremBtn
		var_24_3 = var_24_3.GetComponent
		typeof = var_9
		Image = var_1_10011
		var_24_3 = var_24_3(var_24_7, var_9(var_1_10011))
		Color = var_24_6
		var_24_3.color = var_24_6(0.5, 0.5, 0.5, 1)
	else
		var_24_7 = arg_24_0._haremBtn
		var_24_3 = var_24_3.GetComponent
		typeof = var_9
		Image = var_1_10011
		var_24_3 = var_24_3(var_24_7, var_9(var_1_10011))
		Color = var_24_6
		var_24_3.color = var_24_6(1, 1, 1, 1)
	end

	LOCK_NEW_EDUCATE_SYSTEM = var_24_3

	local var_24_8 = var_24_3 and "EducateMediator" or "NewEducateSelectMediator"

	pg = var_24_6

	local var_24_9 = var_24_6.SystemOpenMgr.GetInstance()

	if not var_7.isOpenSystem(var_24_9, var_24_2.level, var_24_8) then
		local var_24_10 = arg_24_0._educateBtn

		var_24_7 = var_24_7.GetComponent
		typeof = var_11
		Image = var_1_10013
		var_24_7 = var_24_7(var_24_10, var_11(var_1_10013))
		Color = var_24_9
		var_24_7.color = var_24_9(0.5, 0.5, 0.5, 1)
	else
		local var_24_11 = arg_24_0._educateBtn

		var_24_7 = var_24_7.GetComponent
		typeof = var_11
		Image = var_1_10013
		var_24_7 = var_24_7(var_24_11, var_11(var_1_10013))
		Color = var_24_9
		var_24_7.color = var_24_9(1, 1, 1, 1)
	end

	setActive = var_24_7

	local var_24_12 = arg_24_0._educateBtn
	local var_24_13 = var_10.Find(var_24_12, "tip")

	NewEducateHelper = var_11

	var_24_7(var_24_13, var_11.IsShowNewChildTip())

	pg = var_24_7

	local var_24_14 = var_24_7.SystemOpenMgr.GetInstance()

	if not var_8.isOpenSystem(var_24_14, var_24_2.level, "SelectDorm3DMediator") then
		local var_24_15 = arg_24_0._dormBtn
		local var_24_16 = var_9.GetComponent

		typeof = var_12
		Image = var_1_10014

		local var_24_17 = var_24_16(var_24_15, var_12(var_1_10014))

		Color = var_24_14
		var_24_17.color = var_24_14(0.5, 0.5, 0.5, 1)
	else
		local var_24_18 = arg_24_0._dormBtn
		local var_24_19 = var_9.GetComponent

		typeof = var_12
		Image = var_1_10014

		local var_24_20 = var_24_19(var_24_18, var_12(var_1_10014))

		Color = var_24_14
		var_24_20.color = var_24_14(1, 1, 1, 1)
	end

	;(function()
		local var_25_0

		if var_0 then
			Dorm3dShopUI = var_25_0
			var_25_0 = var_25_0.ShouldShowAllTip()
		end

		local var_25_1

		if var_0 then
			Dorm3dFurniture = var_25_1
			var_25_1 = var_25_1.IsTimelimitShopTip()
		end

		setActive = var_2_10002

		local var_25_2 = arg_24_0._dormBtn
		local var_25_3 = var_4.Find(var_25_2, "tip")

		if not var_25_0 then
			::label_25_0::

			getProxy = var_2_10005
			ApartmentProxy = var_7

			local var_25_4 = var_2_10005(var_7)

			var_2_10005 = var_2_10005.HasGiftExpireSoon(var_25_4)
		end

		var_2_10002(var_25_3, var_2_10005)

		setActive = var_2_10002

		local var_25_5 = arg_24_0._dormBtn

		var_2_10002(var_4.Find(var_25_5, "tagFurniture"), var_25_1)

		return
	end)()

	pg = var_10

	local var_24_21 = var_10.SystemOpenMgr.GetInstance()

	if not var_10.isOpenSystem(var_24_21, var_24_2.level, "IslandMediator") then
		local var_24_22 = arg_24_0._islandBtn
		local var_24_23 = var_11.GetComponent

		typeof = var_14
		Image = var_1_10016

		local var_24_24 = var_24_23(var_24_22, var_14(var_1_10016))

		Color = var_24_21
		var_24_24.color = var_24_21(0.5, 0.5, 0.5, 1)
	else
		local var_24_25 = arg_24_0._islandBtn
		local var_24_26 = var_11.GetComponent

		typeof = var_14
		Image = var_1_10016

		local var_24_27 = var_24_26(var_24_25, var_14(var_1_10016))

		Color = var_24_21
		var_24_27.color = var_24_21(1, 1, 1, 1)
	end

	arg_24_0:UpdataIslandTip()
	arg_24_0:UpdateCover()
	arg_24_0:UpdateCoverTip()
	arg_24_0:UpdateTime()

	Timer = var_11
	arg_24_0.timer = var_11.New(function()
		local var_26_0 = arg_24_0

		var_0.UpdateTime(var_26_0)

		return
	end, 60, -1)

	local var_24_28 = arg_24_0.timer

	var_11.Start(var_24_28)

	setActive = var_11

	local var_24_29 = arg_24_0._islandBtnEffect

	tobool = var_14

	var_11(var_24_29, var_14(arg_24_1))

	if arg_24_2 then
		arg_24_2()
	end

	return
end

function var_0_1.UpdateTime(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.TimeMgr.GetInstance()
	local var_27_1 = var_1.GetServerHour(var_27_0) < 12

	setActive = var_27_0

	local var_27_2 = arg_27_0._bg

	var_27_0(var_6.Find(var_27_2, "AM"), var_27_1)

	setActive = var_27_0

	local var_27_3 = arg_27_0._bg

	var_27_0(var_6.Find(var_27_3, "PM"), not var_27_1)

	local var_27_4 = arg_27_0
	local var_27_5 = arg_27_0.getCoverType(var_27_4, var_27_18)

	setActive = var_1_10005

	local var_27_6 = arg_27_0._bg
	local var_27_7 = var_7.Find(var_27_6, "day")

	LivingAreaCover = var_27_3

	var_1_10005(var_27_7, var_27_5 == var_27_3.TYPE_DAY)

	setActive = var_1_10005

	local var_27_8 = arg_27_0._bg
	local var_27_9 = var_7.Find(var_27_8, "night")

	LivingAreaCover = var_8

	var_1_10005(var_27_9, var_27_5 == var_8.TYPE_NIGHT)

	setActive = var_1_10005

	local var_27_10 = arg_27_0._islandBtn
	local var_27_11 = var_7.Find(var_27_10, "lock/day")

	LivingAreaCover = var_8

	var_1_10005(var_27_11, var_27_5 == var_8.TYPE_DAY)

	setActive = var_1_10005

	local var_27_12 = arg_27_0._islandBtn
	local var_27_13 = var_7.Find(var_27_12, "lock/night")

	LivingAreaCover = var_8

	var_1_10005(var_27_13, var_27_5 ~= var_8.TYPE_DAY)

	local var_27_14 = var_1:CurrentSTimeDesc("%Y/%m/%d", true)

	setText = var_27_4

	local var_27_15 = arg_27_0._bg

	var_27_4(var_8.Find(var_27_15, "date"), var_27_14)

	local var_27_16 = var_1
	local var_27_17 = var_1.CurrentSTimeDesc(var_27_16, ":%M", true)
	local var_27_18

	if 12 < var_27_18 then
		var_27_18 = var_27_18 - 12
	end

	setText = var_7

	local var_27_19 = arg_27_0._bg

	var_7(var_9.Find(var_27_19, "time"), var_27_18 .. var_27_17)

	EducateHelper = var_7

	local var_27_20 = var_7.GetWeekStrByNumber(var_1:GetServerWeek())

	setText = var_27_16

	local var_27_21 = arg_27_0._bg

	var_27_16(var_10.Find(var_27_21, "date/week"), var_27_20)

	return
end

function var_0_1.getCoverType(arg_28_0, arg_28_1)
	ipairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.timeCfg) do
		if arg_28_1 >= iter_28_1[1][1] and arg_28_1 < var_7[2] then
			return iter_28_1[2]
		end
	end

	LivingAreaCover = var_2

	return var_2.TYPE_DAY
end

function var_0_1.UpdateCover(arg_29_0)
	getProxy = var_1_10001
	LivingAreaCoverProxy = var_1_10003

	local var_29_0 = var_1_10001(var_1_10003)
	local var_29_1 = var_1.GetCurCover(var_29_0)

	if arg_29_0.cover and arg_29_0.cover.id == var_29_1.id then
		return
	end

	arg_29_0.cover = var_29_1

	arg_29_0:_loadBg()

	return
end

function var_0_1.UpdateCoverTemp(arg_30_0, arg_30_1)
	if arg_30_0.cover and arg_30_0.cover.id == arg_30_1.id then
		return
	end

	arg_30_0.cover = arg_30_1

	arg_30_0:_loadBg()

	return
end

function var_0_1._loadBg(arg_31_0)
	setImageSprite = var_1_10001

	local var_31_0 = arg_31_0._bg
	local var_31_1 = var_3.Find(var_31_0, "day")

	GetSpriteFromAtlas = var_1_10004

	local var_31_2 = arg_31_0.cover
	local var_31_3 = var_6.GetBg

	LivingAreaCover = var_1_10009

	var_1_10001(var_31_1, var_1_10004(var_31_3(var_31_2, var_1_10009.TYPE_DAY), ""), true)

	setImageSprite = var_1_10001

	local var_31_4 = arg_31_0._bg
	local var_31_5 = var_3.Find(var_31_4, "night")

	GetSpriteFromAtlas = var_4

	local var_31_6 = arg_31_0.cover
	local var_31_7 = var_6.GetBg

	LivingAreaCover = var_9

	var_1_10001(var_31_5, var_4(var_31_7(var_31_6, var_9.TYPE_NIGHT), ""), true)

	return
end

function var_0_1.UpdateCoverTip(arg_32_0)
	setActive = var_1_10001

	local var_32_0 = arg_32_0._coverBtn
	local var_32_1 = var_3.Find(var_32_0, "tip")

	getProxy = var_1_10004
	LivingAreaCoverProxy = var_6

	local var_32_2 = var_1_10004(var_6)

	var_1_10001(var_32_1, var_4.IsTip(var_32_2))

	return
end

function var_0_1.UpdataIslandTip(arg_33_0)
	setActive = var_1_10001

	local var_33_0 = arg_33_0._islandBtn
	local var_33_1 = var_3.Find(var_33_0, "banners")

	LOCK_ISLAND_DISPLAY = var_1_10004

	var_1_10001(var_33_1, not var_1_10004)

	LOCK_ISLAND_DISPLAY = var_1_10001

	if var_1_10001 then
		return
	end

	getProxy = var_1_10001
	SystemTipProxy = var_33_1

	local var_33_2 = var_1_10001(var_33_1)
	local var_33_3, var_33_4 = var_1.GetIslandTipInfos(var_33_2)

	setActive = var_33_2

	var_33_2(arg_33_0.islandAwardTF, var_33_3 > 0)

	setActive = var_33_2

	var_33_2(arg_33_0.islandEmptyTF, var_33_4 > 0)

	return
end

function var_0_1.Hide(arg_34_0)
	if arg_34_0.coverPage then
		local var_34_0 = arg_34_0.coverPage

		if var_1.GetLoaded(var_34_0) then
			local var_34_1 = arg_34_0.coverPage

			if var_1.isShowing(var_34_1) then
				local var_34_2 = arg_34_0.coverPage

				var_1.Hide(var_34_2)

				return
			end
		end
	end

	if arg_34_0:isShowing() then
		var_0_1.super.Hide(arg_34_0)

		pg = var_1

		local var_34_3 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_34_3, arg_34_0._tf, arg_34_0._parentTf)
	end

	if arg_34_0.timer ~= nil then
		local var_34_4 = arg_34_0.timer

		var_1.Stop(var_34_4)

		arg_34_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_35_0)
	pg = var_1_10001

	local var_35_0 = var_1_10001.EasyRedDotMgr.GetInstance()

	ipairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_0.redDotUIList) do
		var_35_0:UnRegisterRedDot(iter_35_1)
	end

	arg_35_0.redDotUIList = nil

	local var_35_1 = arg_35_0.mediator

	var_2.Dispose(var_35_1)

	arg_35_0.mediator = nil

	arg_35_0:Hide()

	local var_35_2 = arg_35_0.coverPage

	var_2.Destroy(var_35_2)

	arg_35_0.coverPage = nil
	arg_35_0.cover = nil

	return
end

return var_0_1
