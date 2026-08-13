class = var_0_10000

local var_0_0 = "PreviewPtHybridTemplatePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnList = var_1.Find(var_1_1, "btn_list")

	local var_1_2 = arg_1_0.btnList

	arg_1_0.battleBtn = var_1.Find(var_1_2, "fight")

	local var_1_3 = arg_1_0.btnList

	arg_1_0.getBtn = var_1.Find(var_1_3, "get_btn")

	local var_1_4 = arg_1_0.btnList

	arg_1_0.gotBtn = var_1.Find(var_1_4, "got_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.ptList = var_1.Find(var_1_5, "pt_list")

	local var_1_6 = arg_1_0.ptList

	arg_1_0.slider = var_1.Find(var_1_6, "slider")

	local var_1_7 = arg_1_0.ptList

	arg_1_0.step = var_1.Find(var_1_7, "step")

	local var_1_8 = arg_1_0.ptList

	arg_1_0.progress = var_1.Find(var_1_8, "progress")

	local var_1_9 = arg_1_0.ptList

	arg_1_0.awardTF = var_1.Find(var_1_9, "award")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0:initBtn()

	eachChild = var_1

	var_1(arg_2_0.btnList, function(arg_3_0)
		arg_2_0.btnFuncList[arg_3_0.name](arg_3_0)

		return
	end)

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	if arg_4_0.ptData then
		local var_4_0 = arg_4_0.ptData

		var_1.Update(var_4_0, arg_4_0.activity)
	else
		ActivityPtData = var_1
		arg_4_0.ptData = var_1.New(arg_4_0.activity)
	end

	return
end

function var_0_1.initBtn(arg_5_0)
	local function var_5_0(arg_6_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10002

		local var_6_0 = var_2_10001(var_2_10002)

		if not var_1.getActivityById(var_6_0, arg_6_0) or var_1 and var_1:isEnd() then
			return true
		else
			return false
		end

		return
	end

	local var_5_1 = arg_5_0.activity
	local var_5_2 = var_2.getConfig(var_5_1, "config_client")

	arg_5_0.btnFuncList = {
		task = function(arg_7_0)
			onButton = var_2_10001

			var_2_10001(arg_5_0, arg_7_0, function()
				if var_5_2.taskLinkActID and var_5_0(var_5_2.taskLinkActID) then
					pg = var_0

					local var_8_0 = var_0.TipsMgr.GetInstance()
					local var_8_1 = var_0.ShowTips

					i18n = var_3_10002

					var_8_1(var_8_0, var_3_10002("common_activity_end"))

					return
				end

				local var_8_2 = arg_5_0
				local var_8_3 = var_0.emit

				ActivityMediator = var_3_10002

				local var_8_4 = var_3_10002.EVENT_GO_SCENE

				SCENE = var_3_10003

				var_8_3(var_8_2, var_8_4, var_3_10003.TASK, {
					page = "activity"
				})

				return
			end)

			return
		end,
		shop = function(arg_9_0)
			onButton = var_2_10001

			var_2_10001(arg_5_0, arg_9_0, function()
				if var_5_2.shopLinkActID then
					getProxy = var_10_0
					ActivityProxy = var_3_10001
					var_3_10001 = var_10_0(var_3_10001)

					local var_10_0

					if not var_10_0.getActivitiesById(var_3_10001, var_5_2.shopLinkActID) then
						underscore = var_10_0
						var_10_0 = var_10_0.detect
						getProxy = var_3_10001
						ActivityProxy = var_3_10002

						local var_10_1 = var_3_10001(var_3_10002)

						var_3_10001 = var_3_10001.getActivitiesByType
						ActivityConst = var_3_10003
						var_10_0 = var_10_0(var_3_10001(var_10_1, var_3_10003.ACTIVITY_TYPE_SHOP), function(arg_11_0)
							return not arg_11_0:isEnd()
						end)
					end

					if not var_10_0 or var_10_0:isEnd() then
						pg = var_3_10001

						local var_10_2 = var_3_10001.TipsMgr.GetInstance()
						local var_10_3 = var_1.ShowTips

						i18n = var_3_10003

						var_10_3(var_10_2, var_3_10003("common_activity_end"))

						return
					end

					local var_10_4 = arg_5_0
					local var_10_5 = var_1.emit

					ActivityMediator = var_3_10003

					local var_10_6 = var_3_10003.GO_SHOPS_LAYER
					local var_10_7 = {}

					NewShopsScene = var_3_10005
					var_10_7.warp = var_3_10005.TYPE_ACTIVITY
					var_10_7.actId = var_10_0.id

					var_10_5(var_10_4, var_10_6, var_10_7)

					return
				end
			end)

			return
		end,
		build = function(arg_12_0)
			onButton = var_2_10001

			var_2_10001(arg_5_0, arg_12_0, function()
				if var_5_2.buildLinkActID and var_5_0(var_5_2.buildLinkActID) then
					pg = var_0

					local var_13_0 = var_0.TipsMgr.GetInstance()
					local var_13_1 = var_0.ShowTips

					i18n = var_3_10002

					var_13_1(var_13_0, var_3_10002("common_activity_end"))

					return
				end

				local var_13_2 = arg_5_0
				local var_13_3 = var_0.emit

				ActivityMediator = var_3_10002

				local var_13_4 = var_3_10002.EVENT_GO_SCENE

				SCENE = var_3_10003

				local var_13_5 = var_3_10003.GETBOAT
				local var_13_6 = {}

				BuildShipScene = var_3_10005
				var_13_6.page = var_3_10005.PAGE_BUILD
				BuildShipScene = var_5
				var_13_6.projectName = var_5.PROJECTS.ACTIVITY

				var_13_3(var_13_2, var_13_4, var_13_5, var_13_6)

				return
			end)

			return
		end,
		fight = function(arg_14_0)
			onButton = var_2_10001

			var_2_10001(arg_5_0, arg_14_0, function()
				if var_5_2.fightLinkActID and var_5_0(var_5_2.fightLinkActID) then
					pg = var_0

					local var_15_0 = var_0.TipsMgr.GetInstance()
					local var_15_1 = var_0.ShowTips

					i18n = var_3_10002

					var_15_1(var_15_0, var_3_10002("common_activity_end"))

					return
				end

				local var_15_2 = arg_5_0
				local var_15_3 = var_0.emit

				ActivityMediator = var_3_10002

				var_15_3(var_15_2, var_3_10002.BATTLE_OPERA)

				return
			end)

			return
		end,
		lottery = function(arg_16_0)
			onButton = var_2_10001

			var_2_10001(arg_5_0, arg_16_0, function()
				if var_5_2.lotteryLinkActID and var_5_0(var_5_2.lotteryLinkActID) then
					pg = var_0

					local var_17_0 = var_0.TipsMgr.GetInstance()
					local var_17_1 = var_0.ShowTips

					i18n = var_3_10002

					var_17_1(var_17_0, var_3_10002("common_activity_end"))

					return
				end

				local var_17_2 = arg_5_0
				local var_17_3 = var_0.emit

				ActivityMediator = var_3_10002

				var_17_3(var_17_2, var_3_10002.GO_LOTTERY)

				return
			end)

			return
		end,
		memory = function(arg_18_0)
			return
		end,
		activity = function(arg_19_0)
			return
		end,
		mountain = function(arg_20_0)
			return
		end,
		skinshop = function(arg_21_0)
			onButton = var_2_10001

			var_2_10001(arg_5_0, arg_21_0, function()
				local var_22_0 = arg_5_0
				local var_22_1 = var_0.emit

				ActivityMediator = var_3_10002

				local var_22_2 = var_3_10002.EVENT_GO_SCENE

				SCENE = var_3_10003

				var_22_1(var_22_0, var_22_2, var_3_10003.SKINSHOP)

				return
			end)

			return
		end,
		display_btn = function(arg_23_0)
			onButton = var_2_10001

			local var_23_0 = arg_5_0
			local var_23_1 = arg_23_0

			local function var_23_2()
				local var_24_0 = arg_5_0
				local var_24_1 = var_0.emit

				ActivityMediator = var_3_10002

				local var_24_2 = var_3_10002.SHOW_AWARD_WINDOW

				PtAwardWindow = var_3_10003

				local var_24_3 = {
					type = arg_5_0.ptData.type,
					dropList = arg_5_0.ptData.dropList,
					targets = arg_5_0.ptData.targets,
					level = arg_5_0.ptData.level,
					count = arg_5_0.ptData.count,
					resId = arg_5_0.ptData.resId
				}
				local var_24_4 = arg_5_0.ptData

				var_24_3.unlockStamps = var_5.GetDayUnlockStamps(var_24_4)

				var_24_1(var_24_0, var_24_2, var_3_10003, var_24_3)

				return
			end

			SFX_PANEL = var_2_10005

			var_2_10001(var_23_0, var_23_1, var_23_2, var_2_10005)

			return
		end,
		get_btn = function(arg_25_0)
			onButton = var_2_10001

			local var_25_0 = arg_5_0
			local var_25_1 = arg_25_0

			local function var_25_2()
				local var_26_0 = {}
				local var_26_1 = arg_5_0.ptData
				local var_26_2 = var_1.GetAward(var_26_1)

				getProxy = var_26_1
				PlayerProxy = var_3_10003

				local var_26_3 = var_26_1(var_3_10003)
				local var_26_4 = var_2.getRawData(var_26_3)

				pg = var_26_3

				local var_26_5 = var_26_3.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_3_10005

				if var_3_10005 then
					var_3_10005 = 0
				else
					getProxy = var_3_10005
					BagProxy = var_3_10006
					var_3_10006 = var_3_10005(var_3_10006)
					var_3_10005 = var_3_10005.GetLimitCntById(var_3_10006, var_26_5)
				end

				Task = var_3_10006

				local var_26_6, var_26_7 = var_3_10006.StaticJudgeOverflow(var_26_4.gold, var_26_4.oil, var_3_10005, true, true, {
					{
						var_26_2.type,
						var_26_2.id,
						var_26_2.count
					}
				})

				if var_26_6 then
					table = var_8

					var_8.insert(var_26_0, function(arg_27_0)
						pg = var_4_10001

						local var_27_0 = var_4_10001.MsgboxMgr.GetInstance()
						local var_27_1 = var_1.ShowMsgBox
						local var_27_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_4_10004
						var_27_2.type = var_4_10004
						i18n = var_4_10004
						var_27_2.content = var_4_10004("award_max_warning")
						var_27_2.items = var_26_7
						var_27_2.onYes = arg_27_0

						var_27_1(var_27_0, var_27_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_26_0, function()
					local var_28_0 = arg_5_0.ptData
					local var_28_1, var_28_2 = var_0.GetResProgress(var_28_0)
					local var_28_3 = arg_5_0
					local var_28_4 = var_2.emit

					ActivityMediator = var_4_10004

					local var_28_5 = var_4_10004.EVENT_PT_OPERATION
					local var_28_6 = {
						cmd = 1
					}
					local var_28_7 = arg_5_0.ptData

					var_28_6.activity_id = var_6.GetId(var_28_7)
					var_28_6.arg1 = var_28_2

					var_28_4(var_28_3, var_28_5, var_28_6)

					return
				end)

				return
			end

			SFX_PANEL = var_2_10005

			var_2_10001(var_25_0, var_25_1, var_25_2, var_2_10005)

			return
		end,
		got_btn = function(arg_29_0)
			return
		end,
		boost_btn = function(arg_30_0)
			onButton = var_2_10001

			local var_30_0 = arg_5_0
			local var_30_1 = arg_30_0

			local function var_30_2()
				local var_31_0

				if var_5_2.boostLinkActID and var_5_0(var_5_2.boostLinkActID) then
					pg = var_31_0
					var_3_10001 = var_31_0.TipsMgr.GetInstance()
					var_31_0 = var_31_0.ShowTips
					i18n = var_3_10002

					var_31_0(var_3_10001, var_3_10002("common_activity_end"))

					return
				end

				getProxy = var_31_0
				ActivityProxy = var_3_10001

				local var_31_1 = var_31_0(var_3_10001)
				local var_31_2 = var_0.getActivityById(var_31_1, var_5_2.boostLinkActID)
				local var_31_3 = var_0.getConfig(var_31_2, "config_id")
				local var_31_4 = var_0:getConfig("config_client").icon
				local var_31_5 = var_0:getConfig("config_client").name
				local var_31_6 = var_0
				local var_31_7 = var_0.getConfig(var_31_6, "config_client").desc

				if var_31_4 and var_31_5 and var_31_7 then
					pg = var_31_6

					local var_31_8 = var_31_6.MsgboxMgr.GetInstance()
					local var_31_9 = var_5.ShowMsgBox
					local var_31_10 = {
						yesText = "text_confirm",
						hideNo = true
					}

					MSGBOX_TYPE_DROP_ITEM = var_3_10008
					var_31_10.type = var_3_10008
					i18n = var_3_10008
					var_31_10.content = var_3_10008(var_31_7)
					i18n = var_8
					var_31_10.name = var_8(var_31_5)
					var_31_10.iconPath = {
						"Props/" .. var_31_4,
						var_31_4
					}

					var_31_9(var_31_8, var_31_10)
				end

				return
			end

			SFX_PANEL = var_2_10005

			var_2_10001(var_30_0, var_30_1, var_30_2, var_2_10005)

			return
		end
	}

	return
end

function var_0_1.OnUpdateFlush(arg_32_0)
	local var_32_0 = arg_32_0.ptData
	local var_32_1 = var_1.getTargetLevel(var_32_0)
	local var_32_2 = arg_32_0.activity
	local var_32_3 = var_2.getConfig(var_32_2, "config_client").story

	checkExist = var_32_2

	if var_32_2(var_32_3, {
		var_32_1
	}, {
		1
	}) then
		pg = var_3

		local var_32_4 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_32_4, var_32_3[var_32_1][1])
	end

	if arg_32_0.step then
		local var_32_5 = arg_32_0.ptData
		local var_32_6, var_32_7, var_32_8 = var_3.GetLevelProgress(var_32_5)

		setText = var_6

		var_6(arg_32_0.step, var_32_6 .. "/" .. var_32_7)
	end

	local var_32_9 = arg_32_0.ptData
	local var_32_10, var_32_11, var_32_12 = var_3.GetResProgress(var_32_9)

	setText = var_6

	local var_32_13 = arg_32_0.progress

	if 1 <= var_32_12 then
		setColorStr = var_8

		local var_32_14 = var_32_10

		COLOR_GREEN = var_1_10010

		local var_32_15

		if not var_8(var_32_14, var_1_10010) then
			var_32_15 = var_32_10
		end

		var_6(var_32_13, var_32_15 .. "/" .. var_32_11)

		setSlider = var_6

		var_6(arg_32_0.slider, 0, 1, var_32_12)

		local var_32_16 = arg_32_0.ptData
		local var_32_17 = var_6.CanGetAward(var_32_16)
		local var_32_18 = arg_32_0.ptData
		local var_32_19 = var_7.CanGetNextAward(var_32_18)
		local var_32_20 = arg_32_0.ptData
		local var_32_21 = var_8.CanGetMorePt(var_32_20)

		setActive = var_32_20

		var_32_20(arg_32_0.battleBtn, var_32_21 and not var_32_17 and var_32_19)

		setActive = var_32_20

		var_32_20(arg_32_0.getBtn, var_32_17)

		setActive = var_32_20

		var_32_20(arg_32_0.gotBtn, not var_32_19)

		local var_32_22 = arg_32_0.ptData
		local var_32_23 = var_9.GetAward(var_32_22)

		updateDrop = var_32_22

		var_32_22(arg_32_0.awardTF, var_32_23)

		onButton = var_32_22

		local var_32_24 = arg_32_0
		local var_32_25 = arg_32_0.awardTF

		local function var_32_26()
			local var_33_0 = arg_32_0
			local var_33_1 = var_0.emit

			BaseUI = var_2_10002

			var_33_1(var_33_0, var_2_10002.ON_DROP, var_32_23)

			return
		end

		SFX_PANEL = var_1_10014

		var_32_22(var_32_24, var_32_25, var_32_26, var_1_10014)

		return
	end
end

function var_0_1.OnDestroy(arg_34_0)
	return
end

function var_0_1.GetWorldPtData(arg_35_0, arg_35_1)
	pg = var_1_10002

	local var_35_0 = var_1_10002.TimeMgr.GetInstance()
	local var_35_1 = var_2.GetServerTime(var_35_0)

	ActivityMainScene = var_35_0

	local var_35_2

	if not var_35_0.Data2Time then
		var_35_2 = 0
	end

	if arg_35_1 <= var_35_1 - var_35_2 then
		ActivityMainScene = var_2
		pg = var_35_2

		local var_35_3 = var_35_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_35_3)

		local var_35_4 = arg_35_0
		local var_35_5 = arg_35_0.emit

		ActivityMediator = var_35_3

		local var_35_6 = var_35_3.EVENT_PT_OPERATION
		local var_35_7 = {
			cmd = 2
		}
		local var_35_8 = arg_35_0.ptData

		var_35_7.activity_id = var_6.GetId(var_35_8)

		var_35_5(var_35_4, var_35_6, var_35_7)
	end

	return
end

return var_0_1
