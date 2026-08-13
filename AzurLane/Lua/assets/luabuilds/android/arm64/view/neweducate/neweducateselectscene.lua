class = var_0_10000

local var_0_0 = "NewEducateSelectScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateSelectUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.PerformMgr.GetInstance()

	var_2.CheckLoad(var_2_0, function()
		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.rootTF = var_1.Find(var_4_0, "root")

	local var_4_1 = arg_4_0.rootTF

	arg_4_0.bgTF = var_1.Find(var_4_1, "bg")

	local var_4_2 = arg_4_0.rootTF

	arg_4_0.sureBtn = var_1.Find(var_4_2, "window/sure_btn")
	setText = var_1

	local var_4_3 = arg_4_0.sureBtn
	local var_4_4 = var_3.Find(var_4_3, "Text")

	i18n = var_4

	var_1(var_4_4, var_4("child2_enter"))

	local var_4_5 = arg_4_0.rootTF

	arg_4_0.hardSureBtn = var_1.Find(var_4_5, "window/hard_sure_btn")
	setText = var_1

	local var_4_6 = arg_4_0.hardSureBtn
	local var_4_7 = var_3.Find(var_4_6, "Text")

	i18n = var_4

	var_1(var_4_7, var_4("child2_hard_enter"))

	local var_4_8 = arg_4_0.rootTF
	local var_4_9 = var_1.Find(var_4_8, "window/info")

	arg_4_0.hardTF = var_1.Find(var_4_9, "hard")
	setText = var_2

	local var_4_10 = arg_4_0.hardTF
	local var_4_11 = var_4.Find(var_4_10, "Text")

	i18n = var_5

	var_2(var_4_11, var_5("child2_hard"))

	arg_4_0.hardToggle = var_1:Find("hard/toggle")
	arg_4_0.nameTF = var_1:Find("name")
	arg_4_0.progressTF = var_1:Find("progress")
	arg_4_0.gameTF = var_1:Find("game")

	local var_4_12 = arg_4_0.rootTF

	arg_4_0.topTF = var_2.Find(var_4_12, "top")

	local var_4_13 = arg_4_0.rootTF

	arg_4_0.contentTF = var_2.Find(var_4_13, "window/view/content")

	return
end

function var_0_1.InitData(arg_5_0)
	arg_5_0.infos = {}

	local var_5_0 = arg_5_0.infos

	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_5_1 = var_1_10002(var_1_10004)

	var_5_0[0] = var_2.GetSelectInfo(var_5_1)
	getProxy = var_5_0
	NewEducateProxy = var_1_10003

	local var_5_2 = var_5_0(var_1_10003)

	ipairs = var_2
	pg = var_5_1

	for iter_5_0, iter_5_1 in var_2(var_5_1.child2_data.all) do
		local var_5_3 = arg_5_0.infos
		local var_5_4 = var_5_2:GetChar(iter_5_1)

		var_5_3[iter_5_1] = var_8.GetSelectInfo(var_5_4)
	end

	getProxy = var_2
	PlayerProxy = var_4

	local var_5_5 = var_2(var_4)

	arg_5_0.playerID = var_2.getRawData(var_5_5).id
	NewEducateHelper = var_2

	if var_2.IsShowNewChildTip() then
		pg = var_2

		local var_5_6 = var_2.child2_data.all

		pg = var_3
		arg_5_0.newId = var_5_6[#var_3.child2_data.all]
		NewEducateHelper = var_2

		var_2.ClearShowNewChildTip()
	end

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.topTF
	local var_6_2 = var_4.Find(var_6_1, "return_btn")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.onBackPressed(var_7_0)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_0, var_6_2, var_6_3, var_6_1)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.topTF
	local var_6_6 = var_4.Find(var_6_5, "btns/collect")

	local function var_6_7()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.emit

		NewEducateSelectMediator = var_2_10003

		local var_8_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_8_3 = var_2_10004.New
		local var_8_4 = {}

		NewEducateCollectEntranceMediator = var_2_10007
		var_8_4.mediator = var_2_10007
		NewEducateCollectEntranceLayer = var_2_10007
		var_8_4.viewComponent = var_2_10007
		var_8_4.data = {
			isSelect = true,
			id = arg_6_0.selectedId
		}

		var_8_1(var_8_0, var_8_2, var_8_3(var_8_4))

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_4, var_6_6, var_6_7, var_6_5)

	onButton = var_1_10001

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.sureBtn

	local function var_6_10()
		local var_9_0 = arg_6_0

		var_0.EnterEasyMode(var_9_0)

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_8, var_6_9, var_6_10, var_6_5)

	onButton = var_1_10001

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.hardSureBtn

	local function var_6_13()
		local var_10_0 = arg_6_0

		var_0.EnterHardMode(var_10_0)

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_11, var_6_12, var_6_13, var_6_5)

	eachChild = var_1_10001

	var_1_10001(arg_6_0.contentTF, function(arg_11_0)
		onToggle = var_2_10001

		local var_11_0 = arg_6_0
		local var_11_1 = arg_11_0

		local function var_11_2(arg_12_0)
			tonumber = var_3_10001

			local var_12_0 = var_3_10001(arg_11_0.name)

			if arg_12_0 then
				PlayerPrefs = var_3_10002

				local var_12_1 = var_3_10002.SetInt
				local var_12_2 = arg_6_0

				var_12_1(var_4.GetSelectedLocalKey(var_12_2), var_12_0)

				arg_6_0.selectedId = var_12_0

				local var_12_3 = arg_6_0

				var_2.UpdataInfo(var_12_3)

				local var_12_4 = arg_11_0

				var_2.SetAsLastSibling(var_12_4)
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_11_0, var_11_1, var_11_2, var_2_10006)

		return
	end)

	onToggle = var_1_10001

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.hardToggle

	local function var_6_16(arg_13_0)
		local var_13_0 = arg_13_0 and "anim_educate_select_chage" or "anim_educate_select_chage2"

		quickPlayAnimation = var_2_10002

		local var_13_1 = arg_6_0._tf

		var_2_10002(var_4.Find(var_13_1, "root/window"), var_13_0)

		setActive = var_2_10002

		var_2_10002(arg_6_0.hardSureBtn, arg_13_0)

		setActive = var_2_10002

		var_2_10002(arg_6_0.sureBtn, not arg_13_0)

		local var_13_2 = arg_6_0.infos[arg_6_0.selectedId]

		setText = var_3

		local var_13_3 = arg_6_0.gameTF

		if arg_13_0 then
			i18n = var_13_1

			local var_13_4

			if not var_13_1("child2_hard") then
				var_13_4 = ""
			end

			i18n = var_7

			var_3(var_13_3, var_13_4 .. var_7("child2_game_cnt", var_13_2.gameCnt))

			return
		end
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_14, var_6_15, var_6_16, var_6_5)
	arg_6_0:InitData()

	local var_6_17

	if not arg_6_0.newId then
		PlayerPrefs = var_6_17

		if not var_6_17.GetInt(arg_6_0:GetSelectedLocalKey()) then
			var_6_17 = 0
		end
	end

	triggerToggle = var_1_10002

	local var_6_18 = arg_6_0.contentTF
	local var_6_19 = var_4.Find

	tostring = var_7

	var_1_10002(var_6_19(var_6_18, var_7(var_6_17)), true)

	return
end

function var_0_1.GetSelectedLocalKey(arg_14_0)
	NewEducateConst = var_1_10001

	return var_1_10001.NEW_EDUCATE_SELECT_ID .. "_" .. arg_14_0.playerID
end

function var_0_1.UpdataInfo(arg_15_0)
	local var_15_0 = arg_15_0.infos[arg_15_0.selectedId]

	setText = var_2

	var_2(arg_15_0.nameTF, var_15_0.name)

	setText = var_2

	var_2(arg_15_0.progressTF, var_15_0.progressStr)

	setImageSprite = var_2

	local var_15_1 = arg_15_0.bgTF

	LoadSprite = var_5

	var_2(var_15_1, var_5("bg/" .. var_15_0.bg), false)

	local var_15_2 = arg_15_0.selectedId

	if 1 < var_15_2 then
		local var_15_3 = var_15_0.gameCnt
		local var_15_4

		if not (1 < var_15_3) then
			var_15_4 = false
		else
			var_15_4 = true
		end

		setActive = var_3

		var_3(arg_15_0.hardTF, var_15_4)

		triggerToggle = var_3

		var_3(arg_15_0.hardToggle, var_15_4 and var_15_0.isHard)
		arg_15_0:CheckGuide(var_15_4)

		return
	end
end

function var_0_1.EnterEasyMode(arg_16_0)
	if arg_16_0.selectedId == 0 then
		arg_16_0:EnterScene()

		return
	end

	local var_16_0 = {}

	if arg_16_0.infos[arg_16_0.selectedId].isHard then
		table = var_2

		var_2.insert(var_16_0, function(arg_17_0)
			pg = var_2_10001

			local var_17_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
			local var_17_1 = var_1.Show

			pg = var_2_10004

			local var_17_2 = var_2_10004.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
			local var_17_3 = {}

			i18n = var_2_10006
			var_17_3.contentText = var_2_10006("child2_switch_sure")
			var_17_3.onConfirm = arg_17_0

			var_17_1(var_17_0, var_17_2, var_17_3)

			return
		end)

		table = var_2

		var_2.insert(var_16_0, function(arg_18_0)
			local var_18_0 = arg_16_0
			local var_18_1 = var_1.emit

			NewEducateSelectMediator = var_2_10004

			local var_18_2 = var_2_10004.SWITCH_DIFFICULTY
			local var_18_3 = {
				id = arg_16_0.selectedId
			}

			NewEducateChar = var_6
			var_18_3.difficulty = var_6.DIFFICULTY.EASY
			var_18_3.callback = arg_18_0

			var_18_1(var_18_0, var_18_2, var_18_3)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_16_0, function()
		local var_19_0 = arg_16_0

		var_0.EnterScene(var_19_0)

		return
	end)

	return
end

function var_0_1.EnterHardMode(arg_20_0)
	if arg_20_0.selectedId == 0 then
		return
	end

	local var_20_0 = {}

	if not arg_20_0.infos[arg_20_0.selectedId].isHard then
		table = var_2

		var_2.insert(var_20_0, function(arg_21_0)
			pg = var_2_10001

			local var_21_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
			local var_21_1 = var_1.Show

			pg = var_2_10004

			local var_21_2 = var_2_10004.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
			local var_21_3 = {}

			i18n = var_2_10006
			var_21_3.contentText = var_2_10006("child2_switch_sure")
			var_21_3.onConfirm = arg_21_0

			var_21_1(var_21_0, var_21_2, var_21_3)

			return
		end)

		table = var_2

		var_2.insert(var_20_0, function(arg_22_0)
			local var_22_0 = arg_20_0
			local var_22_1 = var_1.emit

			NewEducateSelectMediator = var_2_10004

			local var_22_2 = var_2_10004.SWITCH_DIFFICULTY
			local var_22_3 = {
				id = arg_20_0.selectedId
			}

			NewEducateChar = var_6
			var_22_3.difficulty = var_6.DIFFICULTY.HARD
			var_22_3.callback = arg_22_0

			var_22_1(var_22_0, var_22_2, var_22_3)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_20_0, function()
		local var_23_0 = arg_20_0

		var_0.EnterScene(var_23_0)

		return
	end)

	return
end

function var_0_1.EnterScene(arg_24_0)
	if arg_24_0.selectedId == 0 then
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.emit

		NewEducateSelectMediator = var_1_10004
		var_1_10004 = var_1_10004.GO_SCENE
		SCENE = var_1_10005

		var_24_1(var_24_0, var_1_10004, var_1_10005.EDUCATE, {
			isMainEnter = true
		})
	else
		local var_24_2 = arg_24_0
		local var_24_3 = arg_24_0.emit

		NewEducateSelectMediator = var_1_10004

		local var_24_4 = var_1_10004.GO_SCENE

		SCENE = var_1_10005

		var_24_3(var_24_2, var_24_4, var_1_10005.NEW_EDUCATE, {
			isMainEnter = true,
			id = arg_24_0.selectedId
		})
	end

	return
end

function var_0_1.CheckGuide(arg_25_0, arg_25_1)
	if arg_25_1 then
		pg = var_1_10002

		local var_25_0 = var_1_10002.NewStoryMgr.GetInstance()

		if not var_2.IsPlayed(var_25_0, "tb2_19") then
			pg = var_2

			local var_25_1 = var_2.m02
			local var_25_2 = var_2.sendNotification

			GAME = var_5

			var_25_2(var_25_1, var_5.STORY_UPDATE, {
				storyId = "tb2_19"
			})

			pg = var_25_2

			local var_25_3 = var_25_2.NewGuideMgr.GetInstance()

			var_2.Play(var_25_3, "tb2_19", {
				arg_25_0.selectedId
			})
		end
	end

	return
end

function var_0_1.onBackPressed(arg_26_0)
	if arg_26_0.contextData.isTb1 then
		local var_26_0 = arg_26_0
		local var_26_1 = arg_26_0.emit

		NewEducateBaseUI = var_1_10004

		var_26_1(var_26_0, var_1_10004.ON_HOME)
	else
		var_0_1.super.onBackPressed(arg_26_0)
	end

	return
end

return var_0_1
