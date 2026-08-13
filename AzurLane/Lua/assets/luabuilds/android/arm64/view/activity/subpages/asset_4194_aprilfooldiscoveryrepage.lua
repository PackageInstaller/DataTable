class = var_0_10000

local var_0_0 = "AprilFoolDiscoveryRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AprilFoolDiscoveryPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.bulin = var_1.Find(var_1_0, "bulin")

	local var_1_1 = arg_1_0.bulin
	local var_1_2 = var_1.Find(var_1_1, "bulin")

	arg_1_0.bulinAnim = var_1.GetComponent(var_1_2, "SpineAnimUI")
	setText = var_1

	local var_1_3 = arg_1_0.bulin
	local var_1_4 = var_3.Find(var_1_3, "Text")

	i18n = var_4

	var_1(var_1_4, var_4("super_bulin_tip"))

	setActive = var_1

	var_1(arg_1_0.bulin, false)

	arg_1_0._funcsLink = {}

	return
end

function var_0_1.AddFunc(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0._funcsLink, arg_2_1)

	if #arg_2_0._funcsLink > 1 then
		return
	end

	arg_2_0:PlayFuncsLink()

	return
end

function var_0_1.PlayFuncsLink(arg_3_0)
	local var_3_0 = false
	local var_3_1

	;(function(...)
		if var_3_0 then
			table = var_0

			var_0.remove(arg_3_0._funcsLink, 1)
		end

		var_3_0 = true

		if arg_3_0._funcsLink[1] then
			var_0(var_0, ...)
		end

		return
	end)()

	return
end

function var_0_1.OnDataSetting(arg_5_0)
	local var_5_0 = var_0_1.super.OnDataSetting(arg_5_0)

	local function var_5_1()
		if arg_5_0.activity.data1 == 1 and arg_5_0.activity.data3 == 1 then
			local var_6_0 = arg_5_0.activity

			var_6_0.data3 = 0
			pg = var_6_0

			local var_6_1 = var_6_0.m02
			local var_6_2 = var_0.sendNotification

			GAME = var_2_10003

			var_6_2(var_6_1, var_2_10003.PUZZLE_PIECE_OP, {
				cmd = 4,
				actId = arg_5_0.activity.id
			})

			return true
		end

		return
	end

	var_5_0 = var_5_0 or var_5_1()

	return var_5_0
end

function var_0_1.OnFirstFlush(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.activity_event_picturepuzzle[arg_7_0.activity.id]

	assert = var_2

	var_2(var_7_0, "Can't Find activity_event_picturepuzzle 's ID : " .. arg_7_0.activity.id)

	arg_7_0.puzzleConfig = var_7_0
	Clone = var_2
	arg_7_0.keyList = var_2(var_7_0.pickup_picturepuzzle)
	table = var_2

	var_2.insertto(arg_7_0.keyList, var_7_0.drop_picturepuzzle)

	assert = var_2

	local var_7_1 = #arg_7_0.keyList == #arg_7_0.items

	string = var_5

	var_2(var_7_1, var_5.format("keyList has {0}, but items has 9", #arg_7_0.keyList))

	table = var_2

	var_2.sort(arg_7_0.keyList)

	onButton = var_2

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.btnHelp

	local function var_7_4()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip.bulin_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_7

	var_2(var_7_2, var_7_3, var_7_4, var_7)

	local var_7_5 = arg_7_0.activity.id

	onButton = var_1_10003

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.btnBattle

	local function var_7_8()
		if #arg_7_0.activity.data2_list < #arg_7_0.keyList then
			pg = var_0

			local var_9_0 = var_0.TipsMgr.GetInstance()
			local var_9_1 = var_0.ShowTips

			i18n = var_2_10003

			var_9_1(var_9_0, var_2_10003("common_activity_not_start"))

			return
		end

		local var_9_2 = arg_7_0
		local var_9_3 = var_0.emit

		ActivityMediator = var_2_10003

		var_9_3(var_9_2, var_2_10003.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = arg_7_0.puzzleConfig.chapter
		}, function()
			getProxy = var_3_10000
			ActivityProxy = var_3_10002

			local var_10_0 = var_3_10000(var_3_10002)

			if var_0.getActivityById(var_10_0, var_7_5).data1 == 1 then
				return
			end

			var_1.data3 = 1

			var_0:updateActivity(var_1)

			return
		end)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_7_6, var_7_7, var_7_8, var_8)

	onButton = var_1_10003

	var_1_10003(arg_7_0, arg_7_0.bulin, function()
		if arg_7_0.activity.data1 >= 1 then
			seriesAsync = var_0

			var_0({
				function(arg_12_0)
					pg = var_3_10001

					local var_12_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_12_1 = var_1.ShowMsgBox
					local var_12_2 = {}

					i18n = var_3_10005
					var_12_2.content = var_3_10005("super_bulin")
					var_12_2.onYes = arg_12_0

					var_12_1(var_12_0, var_12_2)

					return
				end,
				function(arg_13_0)
					local var_13_0 = arg_7_0
					local var_13_1 = var_1.emit

					ActivityMediator = var_3_10004

					local var_13_2 = var_3_10004.ON_SIMULATION_COMBAT
					local var_13_3 = {
						warnMsg = "bulin_tip_other3"
					}
					local var_13_4 = arg_7_0

					var_13_3.stageId = var_6.GetLinkStage(var_13_4)

					var_13_1(var_13_0, var_13_2, var_13_3, function()
						getProxy = var_4_10000
						ActivityProxy = var_4_10002

						local var_14_0 = var_4_10000(var_4_10002)

						if var_0.getActivityById(var_14_0, var_7_5).data1 == 2 then
							return
						end

						var_1.data3 = 1

						var_0:updateActivity(var_1)

						return
					end)

					return
				end
			})
		end

		return
	end)

	local var_7_9 = arg_7_0.activity
	local var_7_10 = var_3.getConfig(var_7_9, "config_client").guideName

	arg_7_0:AddFunc(function(arg_15_0)
		pg = var_2_10001

		local var_15_0 = var_2_10001.SystemGuideMgr.GetInstance()

		var_1.PlayByGuideId(var_15_0, var_7_10, nil, arg_15_0)

		return
	end)

	return
end

local var_0_2 = {
	"lock",
	"hint",
	"unlock"
}

function var_0_1.OnUpdateFlush(arg_16_0)
	local var_16_0 = arg_16_0.activity.data1 >= 1
	local var_16_1 = #arg_16_0.activity.data2_list == #arg_16_0.keyList

	if (var_16_0 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery") ~= arg_16_0.bgName then
		setImageSprite = var_4
		var_1_10006 = arg_16_0.bg
		LoadSprite = var_1_10007

		var_4(var_1_10006, var_1_10007("ui/activityuipage/AprilFoolDiscoveryRePage_atlas", var_3))

		var_1_10006 = arg_16_0.bg

		local var_16_2 = var_4.GetComponent

		typeof = var_7
		Image = var_9
		var_16_2(var_1_10006, var_7(var_9)).enabled = true
		arg_16_0.bgName = var_3
	end

	local var_16_3 = arg_16_0.activity.data2_list
	local var_16_4 = arg_16_0.activity.data3_list

	ipairs = var_1_10006

	for iter_16_0, iter_16_1 in var_1_10006(arg_16_0.items) do
		local var_16_5 = arg_16_0.keyList[iter_16_0]

		table = var_1_10012

		if var_1_10012.contains(var_16_3, var_16_5) then
			var_1_10012 = 3
		else
			table = var_1_10012
			var_1_10012 = var_1_10012.contains(var_16_4, var_16_5) and 2 or 1
		end

		onButton = var_1_10013

		var_1_10013(arg_16_0, iter_16_1, function()
			if var_1_10012 >= 3 then
				return
			end

			if var_1_10012 == 2 then
				arg_16_0.selectIndex = iter_16_0

				local var_17_0 = arg_16_0

				var_0.UpdateSelection(var_17_0)

				return
			elseif var_1_10012 == 1 then
				pg = var_0

				local var_17_1 = var_0.TimeMgr.GetInstance()
				local var_17_3

				if var_0.GetServerTime(var_17_1) < arg_16_0.activity.data2 then
					pg = var_17_3

					local var_17_2 = var_17_3.TipsMgr.GetInstance()

					var_17_3 = var_17_3.ShowTips
					i18n = var_2_10003

					var_17_3(var_17_2, var_2_10003("bulin_tip_other2"))

					return
				end

				pg = var_17_3

				local var_17_4 = var_17_3.MsgboxMgr.GetInstance()
				local var_17_5 = var_0.ShowMsgBox
				local var_17_6 = {}

				i18n = var_2_10004
				var_17_6.content = var_2_10004("bulin_tip_other1")

				function var_17_6.onYes()
					pg = var_3_10000

					local var_18_0 = var_3_10000.m02
					local var_18_1 = var_0.sendNotification

					GAME = var_3_10003

					var_18_1(var_18_0, var_3_10003.PUZZLE_PIECE_OP, {
						cmd = 3,
						actId = arg_16_0.activity.id,
						id = var_16_5
					})

					arg_16_0.selectIndex = iter_16_0

					return
				end

				var_17_5(var_17_4, var_17_6)
			end

			return
		end)

		local var_16_6 = arg_16_0.loader

		var_1_10013.GetSprite(var_16_6, "UI/ActivityUIPage/AprilFoolDiscoveryRePage_atlas", var_0_2[var_1_10012], iter_16_1:Find("state"))

		setActive = var_1_10013

		var_1_10013(iter_16_1:Find("character"), var_1_10012 == 3)
	end

	setActive = var_6

	var_6(arg_16_0.btnBattle, var_16_1)

	setActive = var_6

	var_6(arg_16_0.btnIncomplete, not var_16_1)
	arg_16_0:UpdateSelection()

	setActive = var_6

	var_6(arg_16_0.bulin, var_16_0)

	if arg_16_0.activity.data1 == 1 then
		local var_16_7 = arg_16_0.activity
		local var_16_8 = var_6.getConfig(var_16_7, "config_client").popStory

		arg_16_0:AddFunc(function(arg_19_0)
			pg = var_2_10001

			local var_19_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_19_0, var_16_8, arg_19_0)

			return
		end)
		arg_16_0:AddFunc(function(arg_20_0)
			getProxy = var_2_10001
			PlayerProxy = var_2_10003

			local var_20_0 = var_2_10001(var_2_10003)
			local var_20_1 = var_1.getRawData(var_20_0)

			PlayerPrefs = var_2_10002

			if var_2_10002.GetInt("SuperBurinPopUp_" .. var_20_1.id, 0) == 0 then
				LoadContextCommand = var_20_0

				local var_20_2 = var_20_0.LoadLayerOnTopContext

				Context = var_5

				local var_20_3 = var_5.New
				local var_20_4 = {}

				SuperBulinPopMediator = var_2_10008
				var_20_4.mediator = var_2_10008
				SuperBulinPopView = var_2_10008
				var_20_4.viewComponent = var_2_10008

				local var_20_5 = {}
				local var_20_6 = arg_16_0

				var_20_5.stageId = var_9.GetLinkStage(var_20_6)
				var_20_5.actId = arg_16_0.activity.id
				var_20_5.onRemoved = arg_20_0
				var_20_4.data = var_20_5

				var_20_2(var_20_3(var_20_4))

				PlayerPrefs = var_20_2

				var_20_2.SetInt("SuperBurinPopUp_" .. var_20_1.id, 1)
			end

			return
		end)
	end

	return
end

function var_0_1.OnDestroy(arg_21_0)
	var_0_1.super.OnDestroy(arg_21_0)

	return
end

function var_0_1.GetLinkStage(arg_22_0)
	local var_22_0 = arg_22_0.activity

	return var_1.getConfig(var_22_0, "config_client").lastChapter
end

return var_0_1
