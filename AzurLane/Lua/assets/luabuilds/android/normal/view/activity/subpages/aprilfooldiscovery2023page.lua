class = var_0_10000

local var_0_0 = "AprilFoolDiscovery2023Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AprilFoolDiscoveryRePage"))
local var_0_2 = "superburin"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_1.Find(var_1_1, "AD/list1")

	CustomIndexLayer = var_1_1
	arg_1_0.items = var_1_1.Clone2Full(var_1_2, 5)
	table = var_2

	local var_1_3 = var_2.insertto
	local var_1_4 = arg_1_0.items

	CustomIndexLayer = var_4

	local var_1_5 = var_4.Clone2Full
	local var_1_6 = arg_1_0._tf

	var_1_3(var_1_4, var_1_5(var_5.Find(var_1_6, "AD/list2"), 5))

	arg_1_0.selectIndex = 0

	local var_1_7 = arg_1_0.bg

	arg_1_0.btnHelp = var_2.Find(var_1_7, "help_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.btnBattle = var_2.Find(var_1_8, "battle_btn")

	local var_1_9 = arg_1_0.bg

	arg_1_0.tip = var_2.Find(var_1_9, "tip")

	local var_1_10 = arg_1_0.bg

	arg_1_0.slider = var_2.Find(var_1_10, "slider")

	local var_1_11 = arg_1_0.slider

	arg_1_0.leftTime = var_2.Find(var_1_11, "time")
	AutoLoader = var_2
	arg_1_0.loader = var_2.New()

	for iter_1_0 = 1, #var_0_2 do
		local var_1_12 = arg_1_0.loader
		local var_1_13 = var_6.GetSprite
		local var_1_14 = "ui/activityuipage/aprilfooldiscovery2023page_atlas"

		string = var_1_10009
		var_1_10009 = var_1_10009.sub(var_0_2, iter_1_0, iter_1_0)

		local var_1_15 = arg_1_0.items[iter_1_0]

		var_1_13(var_1_12, var_1_14, var_1_10009, var_10.Find(var_1_15, "character"))
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

			GAME = var_2_10002

			var_3_2(var_3_1, var_2_10002.PUZZLE_PIECE_OP, {
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

	string = var_4

	var_2(var_4_1, var_4.format("keyList has {0}, but items has 9", #arg_4_0.keyList))

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

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.caibulin_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_4_2, var_4_3, var_4_4, var_6)

	local var_4_5 = arg_4_0.activity.id

	onButton = var_4_2

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnBattle

	local function var_4_8()
		if #arg_4_0.activity.data2_list < #arg_4_0.keyList then
			pg = var_0

			local var_6_0 = var_0.TipsMgr.GetInstance()
			local var_6_1 = var_0.ShowTips

			i18n = var_2_10002

			var_6_1(var_6_0, var_2_10002("caibulin_tip11"))

			return
		end

		local var_6_2 = arg_4_0.puzzleConfig.chapter
		local var_6_3 = arg_4_0
		local var_6_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_6_4(var_6_3, var_2_10003.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = var_6_2
		}, function()
			pg = var_3_10000

			local var_7_0 = var_3_10000.NewStoryMgr.GetInstance()
			local var_7_1 = var_0.IsPlayed

			tostring = var_3_10002

			local var_7_2

			if not var_7_1(var_7_0, var_3_10002(var_6_2), true) then
				pg = var_7_2
				var_7_0 = var_7_2.m02
				var_7_2 = var_7_2.sendNotification
				GAME = var_2

				local var_7_3 = var_2.STORY_UPDATE
				local var_7_4 = {}

				tostring = var_3_10004
				var_7_4.storyId = var_3_10004(var_6_2)

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

	SFX_PANEL = var_1_10007

	var_4_2(var_4_6, var_4_7, var_4_8, var_1_10007)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	local var_8_0

	var_8_0 = arg_8_0.activity.data1 >= 1

	local var_8_1 = #arg_8_0.activity.data2_list == #arg_8_0.keyList
	local var_8_2 = arg_8_0.activity.data2_list
	local var_8_3 = arg_8_0.activity.data3_list

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_0.items) do
		local var_8_4 = arg_8_0.keyList[iter_8_0]

		table = var_1_10011

		if var_1_10011.contains(var_8_2, var_8_4) then
			var_1_10011 = 3
		else
			table = var_1_10011
			var_1_10011 = var_1_10011.contains(var_8_3, var_8_4) and 2 or 1
		end

		onButton = var_12

		var_12(arg_8_0, iter_8_1, function()
			if var_1_10011 >= 3 then
				return
			end

			if var_1_10011 == 2 then
				arg_8_0.selectIndex = iter_8_0

				local var_9_0 = arg_8_0

				var_0.UpdateSelection(var_9_0)

				return
			elseif var_1_10011 == 1 then
				pg = var_0

				local var_9_1 = var_0.TimeMgr.GetInstance()
				local var_9_3

				if var_0.GetServerTime(var_9_1) < arg_8_0.activity.data2 then
					pg = var_9_3

					local var_9_2 = var_9_3.TipsMgr.GetInstance()

					var_9_3 = var_9_3.ShowTips
					i18n = var_2_10002

					var_9_3(var_9_2, var_2_10002("bulin_tip_other2"))

					return
				end

				pg = var_9_3

				local var_9_4 = var_9_3.MsgboxMgr.GetInstance()
				local var_9_5 = var_0.ShowMsgBox
				local var_9_6 = {}

				i18n = var_2_10003
				var_9_6.content = var_2_10003("bulin_tip_other1")

				function var_9_6.onYes()
					pg = var_3_10000

					local var_10_0 = var_3_10000.m02
					local var_10_1 = var_0.sendNotification

					GAME = var_3_10002

					var_10_1(var_10_0, var_3_10002.PUZZLE_PIECE_OP, {
						cmd = 3,
						actId = arg_8_0.activity.id,
						id = var_8_4
					})

					arg_8_0.selectIndex = iter_8_0

					return
				end

				var_9_5(var_9_4, var_9_6)
			end

			return
		end)

		setActive = var_12

		var_12(iter_8_1:Find("character"), var_1_10011 == 3)

		setActive = var_12

		var_12(iter_8_1:Find("Unlock"), var_1_10011 == 2)

		setActive = var_12

		var_12(iter_8_1:Find("Locked"), var_1_10011 == 1)
	end

	setGray = var_5

	var_5(arg_8_0.btnBattle, not var_8_1)
	arg_8_0:UpdateSelection()

	pg = var_5

	local var_8_5 = var_5.activity_event_picturepuzzle[arg_8_0.activity.id]

	table = var_6

	if #var_6.mergeArray(arg_8_0.activity.data1_list, arg_8_0.activity.data2_list, true) >= #var_8_5.pickup_picturepuzzle + #var_8_5.drop_picturepuzzle then
		local var_8_6 = arg_8_0.activity
		local var_8_7 = var_7.getConfig(var_8_6, "config_client").comStory

		arg_8_0:AddFunc(function(arg_11_0)
			pg = var_2_10001

			local var_11_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_11_0, var_8_7, arg_11_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateSelection(arg_12_0)
	local var_12_0 = arg_12_0.keyList[arg_12_0.selectIndex]

	table = var_2

	local var_12_1 = var_2.contains(arg_12_0.activity.data3_list, var_12_0)

	setText = var_3

	local var_12_2 = arg_12_0.tip

	if var_12_1 then
		i18n = var_1_10005

		local var_12_3

		if not var_1_10005("caibulin_tip" .. arg_12_0.selectIndex) then
			var_12_3 = ""
		end

		var_3(var_12_2, var_12_3)
		arg_12_0:CreateCDTimer()

		return
	end
end

return var_0_1
