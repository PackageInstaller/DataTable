class = var_0_10000

local var_0_0 = "CoreActivityAprilFoolDiscoveryPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")
	arg_1_0.bgName = nil

	local var_1_1 = arg_1_0._tf

	arg_1_0.itemList = var_1.Find(var_1_1, "AD/list")
	CustomIndexLayer = var_1
	arg_1_0.items = var_1.Clone2Full(arg_1_0.itemList, 9)
	arg_1_0.selectIndex = 0

	local var_1_2 = arg_1_0.bg

	arg_1_0.btnHelp = var_1.Find(var_1_2, "help_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.btnBattle = var_1.Find(var_1_3, "battle_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.btnIncomplete = var_1.Find(var_1_4, "incomplete_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.tip = var_1.Find(var_1_5, "tip")

	local var_1_6 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_6, "slider")

	local var_1_7 = arg_1_0.slider

	arg_1_0.leftTime = var_1.Find(var_1_7, "time")
	AutoLoader = var_1
	arg_1_0.loader = var_1.New()

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0

	if arg_2_0.activity.data1 == 0 and arg_2_0.activity.data3 == 1 then
		var_2_0 = arg_2_0.activity
		var_2_0.data3 = 0
		pg = var_2_0

		local var_2_1 = var_2_0.m02

		var_2_0 = var_2_0.sendNotification
		GAME = var_1_10004

		var_2_0(var_2_1, var_1_10004.PUZZLE_PIECE_OP, {
			cmd = 1,
			actId = arg_2_0.activity.id
		})

		return true
	end

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(arg_2_0.activity.data1_list) do
		table = var_1_10006

		if not var_1_10006.contains(arg_2_0.activity.data2_list, iter_2_1) then
			pg = var_1_10006

			local var_2_2 = var_1_10006.m02

			var_1_10006 = var_1_10006.sendNotification
			GAME = var_9

			var_1_10006(var_2_2, var_9.MEMORYBOOK_UNLOCK, {
				id = iter_2_1,
				actId = arg_2_0.activity.id
			})

			return true
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.activity_event_picturepuzzle[arg_3_0.activity.id]

	assert = var_2

	var_2(var_3_0, "Can't Find activity_event_picturepuzzle 's ID : " .. arg_3_0.activity.id)

	arg_3_0.puzzleConfig = var_3_0
	Clone = var_2
	arg_3_0.keyList = var_2(var_3_0.pickup_picturepuzzle)
	table = var_2

	var_2.insertto(arg_3_0.keyList, var_3_0.drop_picturepuzzle)

	assert = var_2

	local var_3_1 = #arg_3_0.keyList == #arg_3_0.items

	string = var_5

	var_2(var_3_1, var_5.format("keyList has {0}, but items has 9", #arg_3_0.keyList))

	table = var_2

	var_2.sort(arg_3_0.keyList)

	onButton = var_2

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.btnHelp

	local function var_3_4()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		pg = var_2_10004
		var_4_2.helps = var_2_10004.gametip.bulin_help.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_7

	var_2(var_3_2, var_3_3, var_3_4, var_7)

	local var_3_5 = arg_3_0.activity.id

	onButton = var_1_10003

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.btnBattle

	local function var_3_8()
		if #arg_3_0.activity.data2_list < #arg_3_0.keyList then
			pg = var_0

			local var_5_0 = var_0.TipsMgr.GetInstance()
			local var_5_1 = var_0.ShowTips

			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("common_activity_not_start"))

			return
		end

		local var_5_2 = arg_3_0
		local var_5_3 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_3(var_5_2, var_2_10003.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = arg_3_0.puzzleConfig.chapter
		}, function()
			getProxy = var_3_10000
			ActivityProxy = var_3_10002

			local var_6_0 = var_3_10000(var_3_10002)

			if var_0.getActivityById(var_6_0, var_3_5).data1 == 1 then
				return
			end

			var_1.data3 = 1

			var_0:updateActivity(var_1)

			return
		end)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_3_6, var_3_7, var_3_8, var_8)

	local var_3_9 = arg_3_0.activity
	local var_3_10 = var_3.getConfig(var_3_9, "config_client")

	pg = var_3_2

	local var_3_11 = var_3_2.SystemGuideMgr.GetInstance()

	var_4.PlayByGuideId(var_3_11, var_3_10.guideName)

	return
end

local var_0_2 = {
	"lock",
	"hint",
	"unlock"
}

function var_0_1.OnUpdateFlush(arg_7_0)
	var_0_1.super.OnUpdateFlush(arg_7_0)

	local var_7_0 = arg_7_0.activity.data1 > 0
	local var_7_1 = #arg_7_0.activity.data2_list == #arg_7_0.keyList

	if (var_7_0 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery") ~= arg_7_0.bgName then
		setImageSprite = var_4
		var_1_10006 = arg_7_0.bg
		LoadSprite = var_1_10007

		var_4(var_1_10006, var_1_10007("ui/AprilFoolDiscoveryPage_atlas", var_3))

		var_1_10006 = arg_7_0.bg

		local var_7_2 = var_4.GetComponent

		typeof = var_7
		Image = var_9
		var_7_2(var_1_10006, var_7(var_9)).enabled = true
		arg_7_0.bgName = var_3
	end

	local var_7_3 = arg_7_0.activity.data2_list
	local var_7_4 = arg_7_0.activity.data3_list

	ipairs = var_1_10006

	for iter_7_0, iter_7_1 in var_1_10006(arg_7_0.items) do
		local var_7_5 = arg_7_0.keyList[iter_7_0]

		table = var_1_10012

		if var_1_10012.contains(var_7_3, var_7_5) then
			var_1_10012 = 3
		else
			table = var_1_10012
			var_1_10012 = var_1_10012.contains(var_7_4, var_7_5) and 2 or 1
		end

		onButton = var_1_10013

		var_1_10013(arg_7_0, iter_7_1, function()
			if var_1_10012 >= 3 then
				return
			end

			if var_1_10012 == 2 then
				arg_7_0.selectIndex = iter_7_0

				local var_8_0 = arg_7_0

				var_0.UpdateSelection(var_8_0)

				return
			elseif var_1_10012 == 1 then
				pg = var_0

				local var_8_1 = var_0.TimeMgr.GetInstance()
				local var_8_3

				if var_0.GetServerTime(var_8_1) < arg_7_0.activity.data2 then
					pg = var_8_3

					local var_8_2 = var_8_3.TipsMgr.GetInstance()

					var_8_3 = var_8_3.ShowTips
					i18n = var_2_10003

					var_8_3(var_8_2, var_2_10003("bulin_tip_other2"))

					return
				end

				pg = var_8_3

				local var_8_4 = var_8_3.MsgboxMgr.GetInstance()
				local var_8_5 = var_0.ShowMsgBox
				local var_8_6 = {}

				i18n = var_2_10004
				var_8_6.content = var_2_10004("bulin_tip_other1")

				function var_8_6.onYes()
					pg = var_3_10000

					local var_9_0 = var_3_10000.m02
					local var_9_1 = var_0.sendNotification

					GAME = var_3_10003

					var_9_1(var_9_0, var_3_10003.PUZZLE_PIECE_OP, {
						cmd = 3,
						actId = arg_7_0.activity.id,
						id = var_7_5
					})

					arg_7_0.selectIndex = iter_7_0

					return
				end

				var_8_5(var_8_4, var_8_6)
			end

			return
		end)

		local var_7_6 = arg_7_0.loader

		var_1_10013.GetSprite(var_7_6, "UI/AprilFoolDiscoveryPage_atlas", var_0_2[var_1_10012], iter_7_1:Find("state"))

		setActive = var_1_10013

		var_1_10013(iter_7_1:Find("character"), var_1_10012 == 3)
	end

	setActive = var_6

	var_6(arg_7_0.btnBattle, var_7_1)

	setActive = var_6

	var_6(arg_7_0.btnIncomplete, not var_7_1)
	arg_7_0:UpdateSelection()

	return
end

function var_0_1.UpdateSelection(arg_10_0)
	local var_10_0 = arg_10_0.keyList[arg_10_0.selectIndex]

	table = var_2

	local var_10_1 = var_2.contains(arg_10_0.activity.data3_list, var_10_0)

	setText = var_1_10003

	local var_10_2 = arg_10_0.tip

	if var_10_1 then
		i18n = var_1_10006

		local var_10_3

		if not var_1_10006("bulin_tip" .. arg_10_0.selectIndex) then
			var_10_3 = ""
		end

		var_1_10003(var_10_2, var_10_3)
		arg_10_0:CreateCDTimer()

		return
	end
end

function var_0_1.CreateCDTimer(arg_11_0)
	if arg_11_0.CDTimer then
		return
	end

	if #arg_11_0.activity.data2_list ~= #arg_11_0.keyList then
		pg = var_1

		local var_11_0 = var_1.TimeMgr.GetInstance()

		if var_1.GetServerTime(var_11_0) >= arg_11_0.activity.data2 then
			setActive = var_1

			var_1(arg_11_0.slider, false)
			arg_11_0:RemoveCDTimer()

			return
		end

		setActive = var_1

		var_1(arg_11_0.slider, true)

		Timer = var_1
		arg_11_0.CDTimer = var_1.New(function()
			local var_12_0 = arg_11_0.activity.data2

			pg = var_2_10001

			local var_12_1 = var_2_10001.TimeMgr.GetInstance()

			if var_12_0 <= var_1.GetServerTime(var_12_1) then
				setActive = var_2_10002

				var_2_10002(arg_11_0.slider, false)

				local var_12_2 = arg_11_0

				var_2.RemoveCDTimer(var_12_2)

				return
			end

			local var_12_3 = var_12_0 - var_1

			math = var_12_1

			local var_12_4 = var_12_1.floor(var_12_3 / 60)
			local var_12_5 = var_12_3 % 60

			setText = var_5

			local var_12_6 = arg_11_0.leftTime

			string = var_2_10008

			var_5(var_12_6, var_2_10008.format("%d:%02d", var_12_4, var_12_5))

			local var_12_7 = arg_11_0.puzzleConfig.cd

			setSlider = var_2_10006

			var_2_10006(arg_11_0.slider, 0, 1, var_12_3 / var_12_7)

			return
		end, 1, -1)

		local var_11_1 = arg_11_0.CDTimer

		var_1.Start(var_11_1)
		arg_11_0.CDTimer.func()

		return
	end
end

function var_0_1.RemoveCDTimer(arg_13_0)
	if arg_13_0.CDTimer then
		local var_13_0 = arg_13_0.CDTimer

		var_1.Stop(var_13_0)

		arg_13_0.CDTimer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	local var_14_0 = arg_14_0.loader

	var_1.Clear(var_14_0)
	arg_14_0:RemoveCDTimer()
	var_0_1.super.OnDestroy(arg_14_0)

	return
end

return var_0_1
