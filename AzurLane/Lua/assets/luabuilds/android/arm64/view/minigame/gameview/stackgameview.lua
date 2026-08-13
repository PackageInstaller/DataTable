class = var_0_10000

local var_0_0 = "StackGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

var_0_1.MINIGAME_HUB_ID = 39
var_0_1.MINIGAME_ID = 47

function var_0_1.getUIName(arg_1_0)
	return "PileGameUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "overview/back")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "overview/levels")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	ScrollRect = var_1_10006
	arg_2_0.scrollrect = var_2_3(var_2_2, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "overview/levels/mask/content")
	local var_2_7 = arg_2_0._tf

	arg_2_0.levelUIlist = var_2_4(var_2_6, var_4.Find(var_2_7, "overview/levels/mask/content/1"))

	local var_2_8 = arg_2_0._tf

	arg_2_0.topArrBtn = var_1.Find(var_2_8, "overview/levels/top")

	local var_2_9 = arg_2_0._tf

	arg_2_0.bottomArrBtn = var_1.Find(var_2_9, "overview/levels/bottom")

	return
end

local var_0_2 = 7

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.topArrBtn

	local function var_3_5()
		local var_5_0 = arg_3_0.scrollrect.normalizedPosition.y + 1 / (var_0_2 - 4)

		if 1 < var_5_0 then
			var_5_0 = 1
		end

		scrollTo = var_1

		var_1(arg_3_0.scrollrect, 0, var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bottomArrBtn

	local function var_3_8()
		local var_6_0

		if arg_3_0.scrollrect.normalizedPosition.y - 1 / (var_0_2 - 4) < 0 then
			var_6_0 = 0
		end

		scrollTo = var_1

		var_1(arg_3_0.scrollrect, 0, var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_9 = arg_3_0.levelUIlist

	var_1.make(var_3_9, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0

			var_3.UpdateLevelTr(var_7_0, arg_7_1 + 1, arg_7_2)
		end

		return
	end)

	local var_3_10 = arg_3_0.levelUIlist

	var_1.align(var_3_10, var_0_2)

	PileGameController = var_1
	arg_3_0.controller = var_1.New()

	local var_3_11 = arg_3_0.controller.view

	var_1.SetUI(var_3_11, arg_3_0._go)

	local var_3_12 = arg_3_0:PackData()
	local var_3_13 = arg_3_0.controller

	var_2.SetUp(var_3_13, var_3_12, function(arg_8_0, arg_8_1)
		if arg_8_1 < arg_8_0 then
			local var_8_0 = arg_3_0

			var_2.StoreDataToServer(var_8_0, {
				arg_8_0
			})
		end

		local var_8_1 = arg_3_0

		if var_2.GetMGHubData(var_8_1).count > 0 then
			local var_8_2 = arg_3_0

			var_3.SendSuccess(var_8_2, 0)
		end

		return
	end)

	return
end

function var_0_1.UpdateLevelTr(arg_9_0, arg_9_1, arg_9_2)
	getProxy = var_1_10003
	MiniGameProxy = var_1_10005

	local var_9_0 = var_1_10003(var_1_10005)
	local var_9_1 = var_3.GetHubByHubId(var_9_0, var_0_1.MINIGAME_HUB_ID)
	local var_9_2 = arg_9_2:Find("clear")
	local var_9_3 = arg_9_2
	local var_9_4 = arg_9_2.Find(var_9_3, "unopen")
	local var_9_5 = arg_9_2:Find("award")

	setActive = var_9_3

	var_9_3(var_9_2, arg_9_1 <= var_9_1.usedtime)

	local var_9_6 = arg_9_1 > var_9_1.count + var_9_1.usedtime

	setActive = var_9

	var_9(var_9_4, var_9_6)

	setActive = var_9

	var_9(var_9_5, not var_9_6)

	local var_9_7

	if not var_9_6 then
		pg = var_9
		var_9_7 = var_9.mini_game[var_0_1.MINIGAME_ID].simple_config_data.drop[arg_9_1]

		local var_9_8 = {
			type = var_9_7[1],
			id = var_9_7[2],
			count = var_9_7[3]
		}

		updateDrop = var_12

		var_12(var_9_5, var_9_8)

		onButton = var_12
		var_1_10014 = arg_9_0

		local var_9_9 = var_9_5

		local function var_9_10()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			BaseUI = var_2_10003

			var_10_1(var_10_0, var_2_10003.ON_DROP, var_9_8)

			return
		end

		SFX_PANEL = var_1_10017

		var_12(var_1_10014, var_9_9, var_9_10, var_1_10017)
	end

	local var_9_11 = arg_9_2:Find("Text")
	local var_9_12 = var_9.GetComponent

	typeof = var_12
	Image = var_1_10014

	local var_9_13 = var_9_12(var_9_11, var_12(var_1_10014))

	LoadSprite = var_9_7
	var_9_13.sprite = var_9_7("ui/minigameui/pile_atlas", "level" .. arg_9_1)

	return
end

function var_0_1.PackData(arg_11_0)
	local var_11_0 = arg_11_0:GetMGData()
	local var_11_1

	if not var_1.GetRuntimeData(var_11_0, "elements") or not var_1[1] then
		var_11_1 = 0
	end

	local var_11_2 = {
		highestScore = var_11_1
	}

	Vector2 = var_4
	var_11_2.screen = var_4(arg_11_0._tf.rect.width, arg_11_0._tf.rect.height)

	return var_11_2
end

function var_0_1.OnGetAwardDone(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.levelUIlist

	var_2.align(var_12_0, var_0_2)

	return
end

function var_0_1.onBackPressed(arg_13_0)
	local var_13_0 = arg_13_0.controller

	if var_1.onBackPressed(var_13_0) then
		return
	end

	arg_13_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.controller

	var_1.Dispose(var_14_0)

	return
end

return var_0_1
