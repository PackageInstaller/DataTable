class = var_0_10000

local var_0_0 = "AprilFoolDiscovery2025Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AprilFoolDiscoveryRePage"))
local var_0_2 = "burinteam"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_1.Find(var_1_1, "AD/List")

	CustomIndexLayer = var_1_10002
	arg_1_0.items = var_1_10002.Clone2Full(var_1_2, 9)
	arg_1_0.selectIndex = 0

	local var_1_3 = arg_1_0.bg

	arg_1_0.btnHelp = var_2.Find(var_1_3, "help_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.btnBattle = var_2.Find(var_1_4, "battle_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.battle_btn = var_2.Find(var_1_5, "battle_btn_1")

	local var_1_6 = arg_1_0.bg

	arg_1_0.btnIncomplete = var_2.Find(var_1_6, "incomplete_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.tip = var_2.Find(var_1_7, "tip")

	local var_1_8 = arg_1_0.bg

	arg_1_0.slider = var_2.Find(var_1_8, "slider")

	local var_1_9 = arg_1_0.slider

	arg_1_0.leftTime = var_2.Find(var_1_9, "time")
	AutoLoader = var_2
	arg_1_0.loader = var_2.New()

	for iter_1_0 = 1, #var_0_2 do
		local var_1_10 = arg_1_0.loader
		local var_1_11 = var_6.GetSprite
		local var_1_12 = "ui/activityuipage/AprilFoolDiscovery2025Page_atlas"

		string = var_1_10010
		var_1_10010 = var_1_10010.sub(var_0_2, iter_1_0, iter_1_0)

		local var_1_13 = arg_1_0.items[iter_1_0]

		var_1_11(var_1_10, var_1_12, var_1_10010, var_11.Find(var_1_13, "Character"))
	end

	arg_1_0._funcsLink = {}

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = var_0_1.super.OnDataSetting(arg_2_0)

	local function var_2_1()
		if arg_2_0.activity.data1 == 1 and arg_2_0.activity.data3 == 1 then
			local var_3_0 = arg_2_0.activity

			var_3_0.data3 = 0
			pg = var_3_0

			local var_3_1 = var_3_0.m02
			local var_3_2 = var_0.sendNotification

			GAME = var_2_10003

			var_3_2(var_3_1, var_2_10003.PUZZLE_PIECE_OP, {
				cmd = 4,
				actId = arg_2_0.activity.id
			})

			return true
		end

		return
	end

	var_2_0 = var_2_0 or var_2_1()

	return var_2_0
end

function var_0_1.OnFirstFlush(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.activity_event_picturepuzzle[arg_4_0.activity.id]

	assert = var_2

	var_2(var_4_0, "Can't Find activity_event_picturepuzzle 's ID : " .. arg_4_0.activity.id)

	arg_4_0.puzzleConfig = var_4_0
	Clone = var_2
	arg_4_0.keyList = var_2(var_4_0.pickup_picturepuzzle)
	table = var_2

	var_2.insertto(arg_4_0.keyList, var_4_0.drop_picturepuzzle)

	assert = var_2

	local var_4_1 = #arg_4_0.keyList == #arg_4_0.items

	string = var_5

	var_2(var_4_1, var_5.format("keyList has {0}, but items has {1}", #arg_4_0.keyList, #arg_4_0.items))

	table = var_2

	var_2.sort(arg_4_0.keyList)

	onButton = var_2

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.btnHelp

	local function var_4_4()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.SuperBulin2_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_7

	var_2(var_4_2, var_4_3, var_4_4, var_7)

	local var_4_5 = arg_4_0.activity.id

	onButton = var_1_10003

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnBattle

	local function var_4_8()
		if #arg_4_0.activity.data2_list < #arg_4_0.keyList then
			pg = var_0

			local var_6_0 = var_0.TipsMgr.GetInstance()
			local var_6_1 = var_0.ShowTips

			i18n = var_2_10003

			var_6_1(var_6_0, var_2_10003("caibulin_lock_tip"))

			return
		end

		local var_6_2 = arg_4_0.puzzleConfig.chapter
		local var_6_3 = arg_4_0
		local var_6_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_6_4(var_6_3, var_2_10004.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = var_6_2
		}, function()
			pg = var_3_10000

			local var_7_0 = var_3_10000.NewStoryMgr.GetInstance()
			local var_7_1 = var_0.IsPlayed

			tostring = var_3_10003

			local var_7_2

			if not var_7_1(var_7_0, var_3_10003(var_6_2), true) then
				pg = var_7_2
				var_7_0 = var_7_2.m02
				var_7_2 = var_7_2.sendNotification
				GAME = var_3

				local var_7_3 = var_3.STORY_UPDATE
				local var_7_4 = {}

				tostring = var_5
				var_7_4.storyId = var_5(var_6_2)

				var_7_2(var_7_0, var_7_3, var_7_4)
			end

			getProxy = var_7_2
			ActivityProxy = var_7_0

			local var_7_5 = var_7_2(var_7_0)

			if var_0.getActivityById(var_7_5, var_4_5).data1 == 1 then
				return
			end

			var_1.data3 = 1

			var_0:updateActivity(var_1)

			return
		end)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_4_6, var_4_7, var_4_8, var_8)

	local var_4_9 = arg_4_0.activity
	local var_4_10 = var_3.getConfig(var_4_9, "config_client").guideName

	arg_4_0:AddFunc(function(arg_8_0)
		pg = var_2_10001

		local var_8_0 = var_2_10001.NewStoryMgr.GetInstance()

		var_1.Play(var_8_0, var_4_10[1], arg_8_0)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	local var_9_0

	var_9_0 = arg_9_0.activity.data1 >= 1

	local var_9_1 = #arg_9_0.activity.data2_list == #arg_9_0.keyList
	local var_9_2 = arg_9_0.activity.data2_list
	local var_9_3 = arg_9_0.activity.data3_list

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(arg_9_0.items) do
		local var_9_4 = arg_9_0.keyList[iter_9_0]

		table = var_1_10011

		if var_1_10011.contains(var_9_2, var_9_4) then
			var_1_10011 = 3
		else
			table = var_1_10011
			var_1_10011 = var_1_10011.contains(var_9_3, var_9_4) and 2 or 1
		end

		onButton = var_1_10012

		var_1_10012(arg_9_0, iter_9_1, function()
			if var_1_10011 >= 3 then
				return
			end

			if var_1_10011 == 2 then
				arg_9_0.selectIndex = iter_9_0

				local var_10_0 = arg_9_0

				var_0.UpdateSelection(var_10_0)

				return
			elseif var_1_10011 == 1 then
				pg = var_0

				local var_10_1 = var_0.TimeMgr.GetInstance()
				local var_10_3

				if var_0.GetServerTime(var_10_1) < arg_9_0.activity.data2 then
					pg = var_10_3

					local var_10_2 = var_10_3.TipsMgr.GetInstance()

					var_10_3 = var_10_3.ShowTips
					i18n = var_2_10003

					var_10_3(var_10_2, var_2_10003("bulin_tip_other2"))

					return
				end

				pg = var_10_3

				local var_10_4 = var_10_3.MsgboxMgr.GetInstance()
				local var_10_5 = var_0.ShowMsgBox
				local var_10_6 = {}

				i18n = var_2_10004
				var_10_6.content = var_2_10004("bulin_tip_other1")

				function var_10_6.onYes()
					pg = var_3_10000

					local var_11_0 = var_3_10000.m02
					local var_11_1 = var_0.sendNotification

					GAME = var_3_10003

					var_11_1(var_11_0, var_3_10003.PUZZLE_PIECE_OP, {
						cmd = 3,
						actId = arg_9_0.activity.id,
						id = var_9_4
					})

					arg_9_0.selectIndex = iter_9_0

					return
				end

				var_10_5(var_10_4, var_10_6)
			end

			return
		end)

		setActive = var_1_10012

		var_1_10012(iter_9_1:Find("Character"), var_1_10011 == 3)

		setActive = var_1_10012

		var_1_10012(iter_9_1:Find("Unlock"), var_1_10011 == 2)

		setActive = var_1_10012

		var_1_10012(iter_9_1:Find("Locked"), var_1_10011 == 1)
	end

	SetActive = var_5

	var_5(arg_9_0.battle_btn, not var_9_1)

	SetActive = var_5

	var_5(arg_9_0.btnBattle, var_9_1)
	arg_9_0:UpdateSelection()

	pg = var_5

	local var_9_5 = var_5.activity_event_picturepuzzle[arg_9_0.activity.id]

	table = var_6

	if #var_6.mergeArray(arg_9_0.activity.data1_list, arg_9_0.activity.data2_list, true) >= #var_9_5.pickup_picturepuzzle + #var_9_5.drop_picturepuzzle then
		local var_9_6 = arg_9_0.activity
		local var_9_7 = var_7.getConfig(var_9_6, "config_client").comStory

		arg_9_0:AddFunc(function(arg_12_0)
			pg = var_2_10001

			local var_12_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_12_0, var_9_7, arg_12_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateSelection(arg_13_0)
	local var_13_0 = arg_13_0.keyList[arg_13_0.selectIndex]

	table = var_2

	local var_13_1 = var_2.contains(arg_13_0.activity.data3_list, var_13_0)

	setText = var_1_10003

	local var_13_2 = arg_13_0.tip

	if var_13_1 then
		i18n = var_1_10006

		local var_13_3

		if not var_1_10006("SuperBulin2_tip" .. arg_13_0.selectIndex) then
			var_13_3 = ""
		end

		var_1_10003(var_13_2, var_13_3)
		arg_13_0:CreateCDTimer()

		return
	end
end

return var_0_1
