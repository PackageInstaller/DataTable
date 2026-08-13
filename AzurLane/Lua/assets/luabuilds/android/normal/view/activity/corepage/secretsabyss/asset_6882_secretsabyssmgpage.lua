class = var_0_10000

local var_0_0 = "SecretsAbyssMGPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = 78
local var_0_3 = "temp"

function var_0_1.OnInit(arg_1_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0.mgHubData = var_1.GetHubByGameId(var_1_0, var_0_2)
	pg = var_1
	arg_1_0.drops = var_1.mini_game[var_0_2].simple_config_data.drop_ids
	arg_1_0.totalTimes = #arg_1_0.drops
	arg_1_0.useTimes = arg_1_0.mgHubData.usedtime
	arg_1_0.gameTimes = arg_1_0.mgHubData.count

	local var_1_1 = arg_1_0._tf

	arg_1_0.highestScore = var_1.Find(var_1_1, "ad/record/img/Text")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	findTF = var_1_10001
	arg_2_0.btnStart = var_1_10001(arg_2_0._tf, "ad/list/start")
	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0._tf, "ad/list/rule")
	findTF = var_1
	arg_2_0.btnRank = var_1(arg_2_0._tf, "ad/list/rank")
	setText = var_1
	findTF = var_2

	local var_2_0 = var_2(arg_2_0.btnStart, "Text")

	i18n = var_3

	var_1(var_2_0, var_3("beat_game_go"))

	setText = var_1
	findTF = var_2_0

	local var_2_1 = var_2_0(arg_2_0.btnRule, "Text")

	i18n = var_3

	var_1(var_2_1, var_3("beat_game_rule"))

	setText = var_1
	findTF = var_2_1

	local var_2_2 = var_2_1(arg_2_0.btnRank, "Text")

	i18n = var_3

	var_1(var_2_2, var_3("beat_game_rank"))

	GetComponent = var_1
	findTF = var_2_2

	local var_2_3 = var_2_2(arg_2_0._tf, "ad/desc")

	typeof = var_3
	Image = var_4

	local var_2_4 = var_1(var_2_3, var_3(var_4))

	var_1.SetNativeSize(var_2_4)

	findTF = var_1
	arg_2_0.awardsTf = var_1(arg_2_0._tf, "ad/awards")
	findTF = var_1
	arg_2_0.awardContent = var_1(arg_2_0._tf, "ad/awards/content")
	GetComponent = var_1

	local var_2_5 = arg_2_0.awardsTf

	typeof = var_3
	ScrollRect = var_4
	arg_2_0.awardsRect = var_1(var_2_5, var_3(var_4))
	findTF = var_1
	arg_2_0.itemTpl = var_1(arg_2_0._tf, "ad/awards/content/itemTpl")
	setActive = var_1

	var_1(arg_2_0.itemTpl, false)

	for iter_2_0 = 1, #arg_2_0.drops do
		tf = var_1_10005
		Instantiate = var_1_10006
		var_1_10005 = var_1_10005(var_1_10006(arg_2_0.itemTpl))
		setParent = var_1_10006

		var_1_10006(var_1_10005, arg_2_0.awardContent)

		setActive = var_1_10006

		var_1_10006(var_1_10005, true)

		var_1_10006 = arg_2_0.drops[iter_2_0]

		local var_2_6 = {
			type = var_1_10006[1],
			id = var_1_10006[2],
			count = var_1_10006[3]
		}

		findTF = var_8

		local var_2_7 = var_8(var_1_10005, "ad/IconTpl")

		updateDrop = var_9

		var_9(var_2_7, var_2_6)

		onButton = var_9

		local var_2_8 = arg_2_0
		local var_2_9 = var_1_10005

		local function var_2_10()
			local var_3_0 = arg_2_0
			local var_3_1 = var_0.emit

			BaseUI = var_2_10002

			var_3_1(var_3_0, var_2_10002.ON_DROP, var_2_6)

			return
		end

		SFX_PANEL = var_1_10013

		var_9(var_2_8, var_2_9, var_2_10, var_1_10013)

		setText = var_9
		findTF = var_2_8

		var_9(var_2_8(var_1_10005, "ad/day"), "DAY" .. iter_2_0)

		setActive = var_9
		findTF = var_10

		var_9(var_10(var_1_10005, "ad/lock"), iter_2_0 > arg_2_0.useTimes + arg_2_0.gameTimes)

		setActive = var_9
		findTF = var_10

		var_9(var_10(var_1_10005, "ad/got"), iter_2_0 <= arg_2_0.useTimes)
	end

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.btnStart

	local function var_2_13()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, var_0_2)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_11, var_2_12, var_2_13, var_1_10005)

	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.btnRule

	local function var_2_16()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.musicbeat_minigame_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_14, var_2_15, var_2_16, var_1_10005)

	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.btnRank

	local function var_2_19()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		var_6_1(var_6_0, var_2_10002.GO_MINI_GAME, {
			rank = true,
			id = var_0_2
		})

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_17, var_2_18, var_2_19, var_1_10005)

	local var_2_20 = 0

	if arg_2_0.mgHubData.highScores[var_0_2] and arg_2_0.mgHubData.highScores[var_0_2][1] then
		var_2_20 = arg_2_0.mgHubData.highScores[var_0_2][1]
	end

	setText = var_2

	var_2(arg_2_0.highestScore, var_2_20)

	local var_2_21 = arg_2_0.totalTimes - 7 < 0 and 0 or arg_2_0.totalTimes - 7

	scrollTo = var_3

	var_3(arg_2_0.awardsRect, 1 - var_2_21 / (arg_2_0.totalTimes - 7), 0)

	return
end

function var_0_1.willExit(arg_7_0)
	return
end

return var_0_1
