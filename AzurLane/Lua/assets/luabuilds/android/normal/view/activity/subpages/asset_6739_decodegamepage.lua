class = var_0_10000

local var_0_0 = "DecodeGamePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))
local var_0_2

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "Text")
	local var_1_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.dayTF = var_1_3(var_1_2, var_3(var_1_10004))

	local var_1_4 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_4, "items/item")

	local var_1_5 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_5, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_6 = arg_1_0._tf

	arg_1_0.start = var_1.Find(var_1_6, "AD/start")

	local var_1_7 = arg_1_0._tf

	arg_1_0.itemIcon = var_1.Find(var_1_7, "AD/ring/icon")

	local var_1_8 = arg_1_0._tf

	arg_1_0.itemLock = var_1.Find(var_1_8, "AD/ring/lock")

	local var_1_9 = arg_1_0._tf

	arg_1_0.itemGot = var_1.Find(var_1_9, "AD/ring/got")

	local var_1_10 = arg_1_0._tf

	arg_1_0.itemProgressG = var_1.Find(var_1_10, "AD/ring/bar_g")

	local var_1_11 = arg_1_0._tf

	arg_1_0.itemProgressB = var_1.Find(var_1_11, "AD/ring/bar_b")

	local var_1_12 = arg_1_0._tf

	arg_1_0.red = var_1.Find(var_1_12, "AD/red")

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_1.Find(var_1_13, "AD/1")
	local var_1_15 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_1_0.number1 = var_1_15(var_1_14, var_3(var_1_10004))

	local var_1_16 = arg_1_0._tf
	local var_1_17 = var_1.Find(var_1_16, "AD/2")
	local var_1_18 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_1_0.number2 = var_1_18(var_1_17, var_3(var_1_10004))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.activity

	var_0_2 = var_1.getConfig(var_2_0, "config_client").decodeGameId
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.start

	local function var_2_3()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_3_2 = var_2_10002.REQUEST_MINI_GAME
		local var_3_3 = {}

		MiniGameRequestCommand = var_2_10004
		var_3_3.type = var_2_10004.REQUEST_HUB_DATA

		function var_3_3.callback()
			pg = var_3_10000

			local var_4_0 = var_3_10000.m02
			local var_4_1 = var_0.sendNotification

			GAME = var_3_10002

			var_4_1(var_4_0, var_3_10002.GO_MINI_GAME, var_0_2)

			return
		end

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_1, var_2_2, var_2_3, var_1_10005)

	Equipment = var_1

	local var_2_4 = var_1.New
	local var_2_5 = {}

	DecodeGameConst = var_2_2
	var_2_5.id = var_2_2.AWARD[2]

	local var_2_6 = var_2_4(var_2_5)

	GetImageSpriteFromAtlasAsync = var_2_5

	var_2_5("equips/" .. var_2_6:getConfig("icon"), "", arg_2_0.itemIcon)

	return
end

function var_0_1.GetProgressColor(arg_5_0)
	return "#E6F9FD", "#738285"
end

function var_0_1.OnUpdateFlush(arg_6_0)
	var_0_1.super.OnUpdateFlush(arg_6_0)

	local var_6_0 = arg_6_0.dayTF

	var_6_0.text = arg_6_0.nday .. "/7"
	pg = var_6_0

	local var_6_1 = var_6_0.m02
	local var_6_2 = var_1.sendNotification

	GAME = var_3

	local var_6_3 = var_3.REQUEST_MINI_GAME
	local var_6_4 = {}

	MiniGameRequestCommand = var_1_10005
	var_6_4.type = var_1_10005.REQUEST_HUB_DATA

	function var_6_4.callback()
		local var_7_0 = arg_6_0

		var_0.UpdateGameProgress(var_7_0)

		return
	end

	var_6_2(var_6_1, var_6_3, var_6_4)

	return
end

function var_0_1.UpdateGameProgress(arg_8_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.GetHubByGameId(var_8_0, var_0_2)
	local var_8_2 = var_1
	local var_8_3 = var_1.GetMiniGameData(var_8_2, var_0_2)

	DecodeMiniGameView = var_8_2

	local var_8_4 = var_8_2.GetData(var_8_1, var_8_3)

	DecodeGameModel = var_5

	local var_8_5 = var_5.New()

	var_5.SetData(var_8_5, var_8_4)

	local var_8_6 = var_5
	local var_8_7 = var_5.GetUnlockedCnt(var_8_6)

	DecodeGameConst = var_8_6

	local var_8_8 = var_8_6.MAP_ROW

	DecodeGameConst = var_8

	local var_8_9 = var_8_8 * var_8.MAP_COLUMN

	DecodeGameConst = var_8

	if var_8_7 < var_8_9 * var_8.MAX_MAP_COUNT then
		setFillAmount = var_7

		local var_8_10 = arg_8_0.itemProgressB

		DecodeGameConst = var_1_10009

		var_7(var_8_10, var_8_7 * var_1_10009.PROGRESS2FILLAMOUMT)
	else
		setFillAmount = var_7

		var_7(arg_8_0.itemProgressB, 1)
	end

	local var_8_11 = {
		0.212,
		0.538,
		1
	}
	local var_8_12 = var_5:GetPassWordProgress()
	local var_8_13 = 0

	ipairs = var_1_10010

	for iter_8_0, iter_8_1 in var_1_10010(var_8_12) do
		if iter_8_1 then
			var_8_13 = var_8_13 + 1
		end
	end

	setFillAmount = var_10

	var_10(arg_8_0.itemProgressG, var_8_13 == 0 and 0 or var_8_11[var_8_13])

	local var_8_14 = var_5.isFinished

	setActive = var_11

	var_11(arg_8_0.itemLock, not var_8_14)

	setActive = var_11

	var_11(arg_8_0.itemGot, var_8_14)
	arg_8_0:UpdateCanUseCnt(var_5.canUseCnt)

	setActive = var_11

	var_11(arg_8_0.red, not var_8_14 and arg_8_0:IsFinishAllTasks())

	return
end

function var_0_1.IsFinishAllTasks(arg_9_0)
	local var_9_0 = arg_9_0.taskGroup[#arg_9_0.taskGroup]

	_ = var_2

	return var_2.all(var_9_0, function(arg_10_0)
		getProxy = var_2_10001
		TaskProxy = var_2_10002

		local var_10_0 = var_2_10001(var_2_10002)

		return var_1.getFinishTaskById(var_10_0, arg_10_0) ~= nil
	end)
end

function var_0_1.UpdateCanUseCnt(arg_11_0, arg_11_1)
	math = var_1_10002

	local var_11_0 = var_1_10002.floor(arg_11_1 / 10)
	local var_11_1 = arg_11_1 % 10
	local var_11_2 = arg_11_0.number1

	GetSpriteFromAtlas = var_1_10005
	var_11_2.sprite = var_1_10005("ui/DecodeGameNumber_atlas", var_11_0)

	local var_11_3 = arg_11_0.number2

	GetSpriteFromAtlas = var_5
	var_11_3.sprite = var_5("ui/DecodeGameNumber_atlas", var_11_1)
	tf = var_11_3

	local var_11_4 = var_11_3(arg_11_0.number1)

	if var_11_0 == 1 then
		Vector3 = var_11_5

		local var_11_5

		if not var_11_5(571, 221.6) then
			Vector3 = var_11_5
			var_11_5 = var_11_5(551.7, 221.6)
		end

		var_11_4.localPosition = var_11_5
		tf = var_11_4

		local var_11_6 = var_11_4(arg_11_0.number2)

		if var_11_1 == 1 then
			Vector3 = var_11_7

			local var_11_7

			if not var_11_7(644, 221.6) then
				Vector3 = var_11_7
				var_11_7 = var_11_7(625.5, 221.6)
			end

			var_11_6.localPosition = var_11_7

			return
		end
	end
end

return var_0_1
