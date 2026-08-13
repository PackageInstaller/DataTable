class = var_0_10000

local var_0_0 = "AprilFoolDiscovery2026Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityAprilFoolDiscoveryPage"))
local var_0_2 = "magicbuli"

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

	arg_1_0.tip_bg = var_2.Find(var_1_8, "tipbg")

	local var_1_9 = arg_1_0.bg

	arg_1_0.slider = var_2.Find(var_1_9, "slider")

	local var_1_10 = arg_1_0.slider

	arg_1_0.leftTime = var_2.Find(var_1_10, "time")

	local var_1_11 = arg_1_0.bg

	arg_1_0.sliderbg = var_2.Find(var_1_11, "sliderbg")
	AutoLoader = var_2
	arg_1_0.loader = var_2.New()

	for iter_1_0 = 1, #var_0_2 do
		local var_1_12 = arg_1_0.loader
		local var_1_13 = var_6.GetSprite
		local var_1_14 = "UI/AprilFoolDiscovery2026Page_atlas"

		string = var_1_10010
		var_1_10010 = var_1_10010.sub(var_0_2, iter_1_0, iter_1_0)

		local var_1_15 = arg_1_0.items[iter_1_0]

		var_1_13(var_1_12, var_1_14, var_1_10010, var_11.Find(var_1_15, "Character"), true)
	end

	arg_1_0._funcsLink = {}
	setText = var_2

	local var_1_16 = arg_1_0.slider
	local var_1_17 = var_4.Find(var_1_16, "timetext")

	i18n = iter_1_0

	var_2(var_1_17, iter_1_0("aprilfool_2026_cd"))

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

function var_0_1.CreateCDTimer(arg_7_0)
	if arg_7_0.CDTimer then
		return
	end

	if #arg_7_0.activity.data2_list ~= #arg_7_0.keyList then
		pg = var_1

		local var_7_0 = var_1.TimeMgr.GetInstance()

		if var_1.GetServerTime(var_7_0) >= arg_7_0.activity.data2 then
			setActive = var_1

			var_1(arg_7_0.slider, false)

			setActive = var_1

			var_1(arg_7_0.sliderbg, false)
			arg_7_0:RemoveCDTimer()

			return
		end

		setActive = var_1

		var_1(arg_7_0.slider, true)

		setActive = var_1

		var_1(arg_7_0.sliderbg, true)

		Timer = var_1
		arg_7_0.CDTimer = var_1.New(function()
			local var_8_0 = arg_7_0.activity.data2

			pg = var_2_10001

			local var_8_1 = var_2_10001.TimeMgr.GetInstance()

			if var_8_0 <= var_1.GetServerTime(var_8_1) then
				setActive = var_2_10002

				var_2_10002(arg_7_0.slider, false)

				setActive = var_2_10002

				var_2_10002(arg_7_0.sliderbg, false)

				local var_8_2 = arg_7_0

				var_2.RemoveCDTimer(var_8_2)

				return
			end

			local var_8_3 = var_8_0 - var_1

			math = var_8_1

			local var_8_4 = var_8_1.floor(var_8_3 / 60)
			local var_8_5 = var_8_3 % 60

			setText = var_5

			local var_8_6 = arg_7_0.leftTime

			string = var_2_10008

			var_5(var_8_6, var_2_10008.format("%d:%02d", var_8_4, var_8_5))

			local var_8_7 = arg_7_0.puzzleConfig.cd

			setSlider = var_2_10006

			var_2_10006(arg_7_0.slider, 0, 1, var_8_3 / var_8_7)

			return
		end, 1, -1)

		local var_7_1 = arg_7_0.CDTimer

		var_1.Start(var_7_1)
		arg_7_0.CDTimer.func()

		return
	end
end

function var_0_1.OnFirstFlush(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.activity_event_picturepuzzle[arg_9_0.activity.id]

	assert = var_2

	var_2(var_9_0, "Can't Find activity_event_picturepuzzle 's ID : " .. arg_9_0.activity.id)

	arg_9_0.puzzleConfig = var_9_0
	Clone = var_2
	arg_9_0.keyList = var_2(var_9_0.pickup_picturepuzzle)
	table = var_2

	var_2.insertto(arg_9_0.keyList, var_9_0.drop_picturepuzzle)

	assert = var_2

	local var_9_1 = #arg_9_0.keyList == #arg_9_0.items

	string = var_5

	var_2(var_9_1, var_5.format("keyList has {0}, but items has {1}", #arg_9_0.keyList, #arg_9_0.items))

	table = var_2

	var_2.sort(arg_9_0.keyList)

	onButton = var_2

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.btnHelp

	local function var_9_4()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.SuperBulin2_help.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_7

	var_2(var_9_2, var_9_3, var_9_4, var_7)

	local var_9_5 = arg_9_0.activity.id

	onButton = var_1_10003

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.btnBattle

	local function var_9_8()
		if #arg_9_0.activity.data2_list < #arg_9_0.keyList then
			pg = var_0

			local var_11_0 = var_0.TipsMgr.GetInstance()
			local var_11_1 = var_0.ShowTips

			i18n = var_2_10003

			var_11_1(var_11_0, var_2_10003("caibulin_lock_tip"))

			return
		end

		local var_11_2 = arg_9_0.puzzleConfig.chapter
		local var_11_3 = arg_9_0
		local var_11_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_11_4(var_11_3, var_2_10004.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = var_11_2
		}, function()
			pg = var_3_10000

			local var_12_0 = var_3_10000.NewStoryMgr.GetInstance()
			local var_12_1 = var_0.IsPlayed

			tostring = var_3_10003

			local var_12_2

			if not var_12_1(var_12_0, var_3_10003(var_11_2), true) then
				pg = var_12_2
				var_12_0 = var_12_2.m02
				var_12_2 = var_12_2.sendNotification
				GAME = var_3

				local var_12_3 = var_3.STORY_UPDATE
				local var_12_4 = {}

				tostring = var_5
				var_12_4.storyId = var_5(var_11_2)

				var_12_2(var_12_0, var_12_3, var_12_4)
			end

			getProxy = var_12_2
			ActivityProxy = var_12_0

			local var_12_5 = var_12_2(var_12_0)

			if var_0.getActivityById(var_12_5, var_9_5).data1 == 1 then
				return
			end

			var_1.data3 = 1

			var_0:updateActivity(var_1)

			return
		end)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_9_6, var_9_7, var_9_8, var_8)

	local var_9_9 = arg_9_0.activity
	local var_9_10 = var_3.getConfig(var_9_9, "config_client").guideName

	arg_9_0:AddFunc(function(arg_13_0)
		pg = var_2_10001

		local var_13_0 = var_2_10001.NewStoryMgr.GetInstance()

		var_1.Play(var_13_0, var_9_10[1], arg_13_0)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_14_0)
	local var_14_0

	var_14_0 = arg_14_0.activity.data1 >= 1

	local var_14_1 = #arg_14_0.activity.data2_list == #arg_14_0.keyList
	local var_14_2 = arg_14_0.activity.data2_list
	local var_14_3 = arg_14_0.activity.data3_list

	ipairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(arg_14_0.items) do
		local var_14_4 = arg_14_0.keyList[iter_14_0]

		table = var_1_10011

		if var_1_10011.contains(var_14_2, var_14_4) then
			var_1_10011 = 3
		else
			table = var_1_10011
			var_1_10011 = var_1_10011.contains(var_14_3, var_14_4) and 2 or 1
		end

		onButton = var_1_10012

		var_1_10012(arg_14_0, iter_14_1, function()
			if var_1_10011 >= 3 then
				return
			end

			if var_1_10011 == 2 then
				arg_14_0.selectIndex = iter_14_0

				local var_15_0 = arg_14_0

				var_0.UpdateSelection(var_15_0)

				quickPlayAnimation = var_0
				var_2_10004 = iter_14_1

				return var_0(var_2.Find(var_2_10004, "Unlock"), "im_AprilFoolDiscovery2026Page_Unlock")
			elseif var_1_10011 == 1 then
				pg = var_0

				local var_15_1 = var_0.TimeMgr.GetInstance()
				local var_15_3

				if var_0.GetServerTime(var_15_1) < arg_14_0.activity.data2 then
					pg = var_15_3

					local var_15_2 = var_15_3.TipsMgr.GetInstance()

					var_15_3 = var_15_3.ShowTips
					i18n = var_2_10003

					var_15_3(var_15_2, var_2_10003("bulin_tip_other2"))

					return
				end

				pg = var_15_3

				local var_15_4 = var_15_3.MsgboxMgr.GetInstance()
				local var_15_5 = var_0.ShowMsgBox
				local var_15_6 = {}

				i18n = var_2_10004
				var_15_6.content = var_2_10004("bulin_tip_other1")

				function var_15_6.onYes()
					pg = var_3_10000

					local var_16_0 = var_3_10000.m02
					local var_16_1 = var_0.sendNotification

					GAME = var_3_10003

					var_16_1(var_16_0, var_3_10003.PUZZLE_PIECE_OP, {
						cmd = 3,
						actId = arg_14_0.activity.id,
						id = var_14_4
					})

					arg_14_0.selectIndex = iter_14_0

					return
				end

				var_15_5(var_15_4, var_15_6)
			end

			return
		end)

		setActive = var_1_10012

		var_1_10012(iter_14_1:Find("Character"), var_1_10011 == 3)

		if var_1_10011 == 3 then
			quickPlayAnimation = var_1_10012

			var_1_10012(iter_14_1, "anim_AprilFoolDiscovery2026Page_open")
		end

		setActive = var_1_10012

		var_1_10012(iter_14_1:Find("Selected"), var_1_10011 == 2)

		if var_1_10011 == 2 then
			setActive = var_1_10012

			var_1_10012(iter_14_1:Find("Unlock"), true)
		end

		setActive = var_1_10012

		var_1_10012(iter_14_1:Find("Locked"), var_1_10011 == 1)
	end

	SetActive = var_5

	var_5(arg_14_0.battle_btn, not var_14_1)

	SetActive = var_5

	var_5(arg_14_0.btnBattle, var_14_1)
	arg_14_0:UpdateSelection()

	pg = var_5

	local var_14_5 = var_5.activity_event_picturepuzzle[arg_14_0.activity.id]

	table = var_6

	if #var_6.mergeArray(arg_14_0.activity.data1_list, arg_14_0.activity.data2_list, true) >= #var_14_5.pickup_picturepuzzle + #var_14_5.drop_picturepuzzle then
		local var_14_6 = arg_14_0.activity
		local var_14_7 = var_7.getConfig(var_14_6, "config_client").comStory

		arg_14_0:AddFunc(function(arg_17_0)
			pg = var_2_10001

			local var_17_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_17_0, var_14_7, arg_17_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateSelection(arg_18_0)
	local var_18_0 = arg_18_0.keyList[arg_18_0.selectIndex]

	table = var_2

	local var_18_1 = var_2.contains(arg_18_0.activity.data3_list, var_18_0)

	SetActive = var_1_10003

	local var_18_2 = arg_18_0.tip

	if var_18_1 then
		i18n = var_1_10006

		local var_18_3

		if not var_1_10006("SuperBulin2_tip" .. arg_18_0.selectIndex) then
			var_18_3 = false
		end

		var_1_10003(var_18_2, var_18_3)

		SetActive = var_1_10003

		local var_18_4 = arg_18_0.tip_bg

		if var_18_1 then
			i18n = var_18_3

			local var_18_5

			if not var_18_3("SuperBulin2_tip" .. arg_18_0.selectIndex) then
				var_18_5 = false
			end

			var_1_10003(var_18_4, var_18_5)

			setText = var_1_10003

			local var_18_6 = arg_18_0.tip

			if var_18_1 then
				i18n = var_18_5

				local var_18_7

				if not var_18_5("SuperBulin2_tip" .. arg_18_0.selectIndex) then
					var_18_7 = ""
				end

				var_1_10003(var_18_6, var_18_7)
				arg_18_0:CreateCDTimer()

				return
			end
		end
	end
end

return var_0_1
