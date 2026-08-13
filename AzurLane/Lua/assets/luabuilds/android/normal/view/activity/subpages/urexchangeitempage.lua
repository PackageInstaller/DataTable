class = var_0_10000

local var_0_0 = "UrExchangeItemPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.exchangeBtn = var_1.Find(var_1_0, "AD/exchange")

	local var_1_1 = arg_1_0._tf

	arg_1_0.exchangeTip = var_1.Find(var_1_1, "AD/exchange/tip")

	local var_1_2 = arg_1_0._tf

	arg_1_0.battleBtn = var_1.Find(var_1_2, "AD/battle")

	local var_1_3 = arg_1_0._tf

	arg_1_0.taskBtn = var_1.Find(var_1_3, "AD/task")

	local var_1_4 = arg_1_0._tf

	arg_1_0.progress = var_1.Find(var_1_4, "AD/progress/Image")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_1.Find(var_1_5, "AD/Text")
	local var_1_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.progressTxt = var_1_7(var_1_6, var_3(var_1_10004))

	local var_1_8 = arg_1_0._tf

	arg_1_0.itemTF = var_1.Find(var_1_8, "AD/item")

	local var_1_9 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_9, "AD/help")

	local var_1_10 = arg_1_0._tf

	arg_1_0.moreBtn = var_1.Find(var_1_10, "AD/more")
	onButton = var_1

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.helpBtn

	local function var_1_13()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_2_2.type = var_2_10003
		pg = var_2_10003
		var_2_2.helps = var_2_10003.gametip.ur_exchange_help_tip.tip

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_11, var_1_12, var_1_13, var_1_10005)

	onButton = var_1

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.moreBtn

	local function var_1_16()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		pg = var_2_10003
		var_3_2.helps = var_2_10003.gametip.ur_exchange_help_tip.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_14, var_1_15, var_1_16, var_1_10005)

	onButton = var_1

	local var_1_17 = arg_1_0
	local var_1_18 = arg_1_0.exchangeBtn

	local function var_1_19()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)
		local var_4_1 = var_0.getRawData(var_4_0)

		pg = var_4_0

		local var_4_2 = var_4_0.SystemOpenMgr.GetInstance()
		local var_4_3, var_4_4 = var_1.isOpenSystem(var_4_2, var_4_1.level, "FragmentShop")

		if not var_4_3 then
			pg = var_3

			local var_4_5 = var_3.TipsMgr.GetInstance()

			var_3.ShowTips(var_4_5, var_4_4)

			return
		end

		local var_4_6 = arg_1_0
		local var_4_7 = var_3.emit

		ActivityMediator = var_2_10005

		local var_4_8 = var_2_10005.GO_SHOPS_LAYER_STEEET
		local var_4_9 = {}

		NewShopsScene = var_2_10007
		var_4_9.warp = var_2_10007.TYPE_FRAGMENT

		var_4_7(var_4_6, var_4_8, var_4_9)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_17, var_1_18, var_1_19, var_1_10005)

	onButton = var_1

	local var_1_20 = arg_1_0
	local var_1_21 = arg_1_0.battleBtn

	local function var_1_22()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_20, var_1_21, var_1_22, var_1_10005)

	onButton = var_1

	local var_1_23 = arg_1_0
	local var_1_24 = arg_1_0.taskBtn

	local function var_1_25()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_6_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.TASK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_23, var_1_24, var_1_25, var_1_10005)

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.gameset.urpt_chapter_max.description[1]
	local var_7_1 = var_1[2]

	getProxy = var_1_10004
	BagProxy = var_1_10005

	local var_7_2 = var_1_10004(var_1_10005)
	local var_7_3 = var_4.GetLimitCntById(var_7_2, var_7_0)
	local var_7_4 = arg_7_0.progressTxt

	var_7_4.text = var_7_3 .. "/" .. var_7_1
	setFillAmount = var_7_4

	var_7_4(arg_7_0.progress, var_7_3 / var_7_1)

	updateDrop = var_7_4

	local var_7_5 = arg_7_0.itemTF

	Drop = var_7

	local var_7_6 = var_7.New
	local var_7_7 = {
		count = 0
	}

	DROP_TYPE_ITEM = var_1_10009
	var_7_7.type = var_1_10009
	var_7_7.id = var_7_0

	var_7_4(var_7_5, var_7_6(var_7_7))

	setActive = var_7_4

	local var_7_8 = arg_7_0.exchangeTip

	NotifyTipHelper = var_7

	var_7_4(var_7_8, var_7.ShouldShowUrTip())

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
