class = var_0_10000

local var_0_0 = "RyzaMGPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = 43
local var_0_3 = "temp"

function var_0_1.OnInit(arg_1_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0.mgHubData = var_1.GetHubByGameId(var_1_0, var_0_2)
	pg = var_1
	arg_1_0.drops = var_1.mini_game[var_0_2].simple_config_data.drop_ids
	arg_1_0.totalTimes = #arg_1_0.drops
	arg_1_0.useTimes = arg_1_0.mgHubData.usedtime
	arg_1_0.gameTimes = arg_1_0.mgHubData.count

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	findTF = var_1_10001
	arg_2_0.btnStart = var_1_10001(arg_2_0._tf, "ad/start")
	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0._tf, "ad/rule")
	findTF = var_1
	arg_2_0.moveLeft = var_1(arg_2_0._tf, "ad/moveLeft")
	findTF = var_1
	arg_2_0.moveRight = var_1(arg_2_0._tf, "ad/moveRight")
	findTF = var_1
	arg_2_0.awardsTf = var_1(arg_2_0._tf, "ad/awards")
	findTF = var_1
	arg_2_0.awardContent = var_1(arg_2_0._tf, "ad/awards/content")
	GetComponent = var_1

	local var_2_0 = arg_2_0.awardsTf

	typeof = var_4
	ScrollRect = var_1_10006
	arg_2_0.awardsRect = var_1(var_2_0, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.itemTpl = var_1(arg_2_0._tf, "ad/awards/content/itemTpl")
	setActive = var_1

	var_1(arg_2_0.itemTpl, false)

	for iter_2_0 = 1, #arg_2_0.drops do
		tf = var_1_10005
		Instantiate = var_1_10007
		var_1_10005 = var_1_10005(var_1_10007(arg_2_0.itemTpl))
		setParent = var_1_10006

		var_1_10006(var_1_10005, arg_2_0.awardContent)

		setActive = var_1_10006

		var_1_10006(var_1_10005, true)

		var_1_10006 = arg_2_0.drops[iter_2_0]
		var_1_10007 = {
			type = var_1_10006[1],
			id = var_1_10006[2],
			count = var_1_10006[3]
		}
		findTF = var_8

		local var_2_1 = var_8(var_1_10005, "ad/IconTpl")

		updateDrop = var_9

		var_9(var_2_1, var_1_10007)

		onButton = var_9

		local var_2_2 = arg_2_0
		local var_2_3 = var_1_10005

		local function var_2_4()
			local var_3_0 = arg_2_0
			local var_3_1 = var_0.emit

			BaseUI = var_2_10003

			var_3_1(var_3_0, var_2_10003.ON_DROP, var_1_10007)

			return
		end

		SFX_PANEL = var_1_10014

		var_9(var_2_2, var_2_3, var_2_4, var_1_10014)

		GetSpriteFromAtlasAsync = var_9

		var_9("ui/ryzamgpage_atlas", "day_" .. iter_2_0, function(arg_4_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_1_10005, "ad/complete"), arg_4_0, true)

			return
		end)

		GetSpriteFromAtlasAsync = var_9

		var_9("ui/ryzamgpage_atlas", "day_c_" .. iter_2_0, function(arg_5_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_1_10005, "ad/open"), arg_5_0, true)

			return
		end)

		setActive = var_9
		findTF = var_11

		var_9(var_11(var_1_10005, "ad/open"), iter_2_0 > arg_2_0.useTimes)

		setActive = var_9
		findTF = var_11

		var_9(var_11(var_1_10005, "ad/complete"), iter_2_0 <= arg_2_0.useTimes)

		setActive = var_9
		findTF = var_11

		var_9(var_11(var_1_10005, "ad/got"), iter_2_0 <= arg_2_0.useTimes)
	end

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.btnStart

	local function var_2_7()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_MINI_GAME, var_0_2)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_5, var_2_6, var_2_7, var_1_10006)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.btnRule

	local function var_2_10()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.ryza_mini_game.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_8, var_2_9, var_2_10, var_1_10006)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.moveRight

	local function var_2_13()
		local var_8_0

		if arg_2_0.awardsRect.normalizedPosition.x + 1 / (arg_2_0.totalTimes - 4) <= 0 then
			var_8_0 = 0
		end

		scrollTo = var_1

		var_1(arg_2_0.awardsRect, var_8_0, 0)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_11, var_2_12, var_2_13, var_1_10006)

	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.moveLeft

	local function var_2_16()
		local var_9_0 = arg_2_0.awardsRect.normalizedPosition.x - 1 / (arg_2_0.totalTimes - 4)

		if 1 < var_9_0 then
			var_9_0 = 1
		end

		scrollTo = var_1

		var_1(arg_2_0.awardsRect, var_9_0, 0)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_14, var_2_15, var_2_16, var_1_10006)

	local var_2_17 = arg_2_0.totalTimes - 4 < 0 and 0 or arg_2_0.totalTimes - 4

	scrollTo = var_2

	var_2(arg_2_0.awardsRect, 1 - var_2_17 / (arg_2_0.totalTimes - 4), 0)

	return
end

function var_0_1.willExit(arg_10_0)
	return
end

return var_0_1
