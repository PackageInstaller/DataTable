class = var_0_10000

local var_0_0 = "AuctionGamePtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.get = var_1.Find(var_1_0, "PT_bg/Text")

	local var_1_1 = arg_1_0.bg

	arg_1_0.playerInfo = var_1.Find(var_1_1, "playerInfo")

	local var_1_2 = arg_1_0.playerInfo

	arg_1_0.playerFrame = var_1.Find(var_1_2, "frame")

	local var_1_3 = arg_1_0.playerInfo

	arg_1_0.playerIcon = var_1.Find(var_1_3, "frame/icon")

	local var_1_4 = arg_1_0.playerInfo

	arg_1_0.playerName = var_1.Find(var_1_4, "name")

	local var_1_5 = arg_1_0.playerInfo

	arg_1_0.playerCount = var_1.Find(var_1_5, "count")
	setText = var_1

	local var_1_6 = arg_1_0.bg
	local var_1_7 = var_3.Find(var_1_6, "tip")

	i18n = var_4

	var_1(var_1_7, var_4("auction_pt_info"))

	setText = var_1

	local var_1_8 = arg_1_0.bg
	local var_1_9 = var_3.Find(var_1_8, "get_btn/text")

	i18n = var_4

	var_1(var_1_9, var_4("auction_signin_collect"))

	setText = var_1

	local var_1_10 = arg_1_0.bg
	local var_1_11 = var_3.Find(var_1_10, "PT_bg/Text")

	i18n = var_4

	var_1(var_1_11, var_4("auction_pt_tip"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)
	arg_3_0:setPlayerInfo()

	setActive = var_1

	var_1(arg_3_0.getBtnGray, false)

	setActive = var_1

	var_1(arg_3_0.getBtn, true)

	setGray = var_1

	local var_3_0 = arg_3_0.getBtn
	local var_3_1 = arg_3_0.ptData
	local var_3_2 = var_4.GetMaxAvailableTargetIndex(var_3_1)
	local var_3_3 = arg_3_0.ptData

	var_1(var_3_0, var_3_2 == var_5.GetLevel(var_3_3))

	return
end

function var_0_1.setPlayerInfo(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getRawData(var_4_0)
	local var_4_2 = var_1.GetShipPhantomMarks(var_4_1)[1]

	getProxy = var_4_0
	BayProxy = var_1_10005

	local var_4_3 = var_4_0(var_1_10005)
	local var_4_4 = var_3.GetShipPhantom(var_4_3, var_4_2)

	GetImageSpriteFromAtlasAsync = var_4_1

	local var_4_5 = "SquareIcon/"
	local var_4_6 = var_4_4

	var_4_1(var_4_5 .. var_4_4.getPainting(var_4_6), "", arg_4_0.playerIcon)

	setText = var_4_1

	var_4_1(arg_4_0.playerName, var_1.name)

	setText = var_4_1

	local var_4_7 = arg_4_0.playerCount

	StringHelper = var_7

	local var_4_8 = var_7.ForamtNumberK

	AuctionGameTools = var_4_6

	var_4_1(var_4_7, var_4_8(var_4_6.GetCurrencyCnt()))

	return
end

return var_0_1
