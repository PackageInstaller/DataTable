class = var_0_10000

local var_0_0 = "ValentineQte2Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

var_0_1.MINIGAME_HUB_ID = 63
var_0_1.MINIGAME_ID = 50

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.awardPreviewBtn = var_1.Find(var_1_0, "AD/award_preview_btn")

	local var_1_1 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_1, "AD/go")

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_1.Find(var_1_2, "AD/index")
	local var_1_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.indexTxt = var_1_4(var_1_3, var_3(var_1_10004))

	local var_1_5 = arg_1_0._tf

	arg_1_0.iconBtn = var_1.Find(var_1_5, "AD/icon")

	local var_1_6 = arg_1_0._tf

	arg_1_0.markContainer = var_1.Find(var_1_6, "AD/marks")

	local var_1_7 = arg_1_0._tf

	arg_1_0.markTpl = var_1.Find(var_1_7, "AD/marks/1")
	setActive = var_1

	var_1(arg_1_0.markTpl, false)

	arg_1_0.markTrs = {}

	for iter_1_0 = 1, 7 do
		cloneTplTo = var_1_10005
		var_1_10005 = var_1_10005(arg_1_0.markTpl, arg_1_0.markContainer, iter_1_0)
		table = var_6

		var_6.insert(arg_1_0.markTrs, var_1_10005)
	end

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.goBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, var_0_1.MINIGAME_ID)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	getProxy = var_1_10001
	MiniGameProxy = var_3_0

	local var_3_3 = var_1_10001(var_3_0)

	onButton = var_3_0

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.iconBtn

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.ShowAwards(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_3_0

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.indexTxt

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.ShowAwards(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_7, var_3_8, var_3_9, var_1_10006)

	local var_3_10 = var_3_3:GetHubByHubId(var_0_1.MINIGAME_HUB_ID)

	arg_3_0:FlushMarks(var_3_10)

	Canvas = var_3

	var_3.ForceUpdateCanvases()
	arg_3_0:FlushIndex(var_3_10)

	return
end

function var_0_1.ShowAwards(arg_7_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = arg_7_0:GetDropList()
	local var_7_2 = var_7_0:GetHubByHubId(var_0_1.MINIGAME_HUB_ID).usedtime
	local var_7_3 = {}

	i18n = var_1_10006
	var_7_3[1] = var_1_10006("Valentine_minigame_label3")
	i18n = var_6
	var_7_3[2] = var_6("Valentine_minigame_label2")

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.emit

	ActivityMediator = var_1_10008

	var_7_5(var_7_4, var_1_10008.ON_AWARD_WINDOW, var_7_1, var_7_2, var_7_3)

	return
end

function var_0_1.GetDropList(arg_8_0)
	pg = var_1_10001

	return var_1_10001.mini_game[var_0_1.MINIGAME_ID].simple_config_data.drop_ids
end

function var_0_1.FlushMarks(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.usedtime + arg_9_1.count

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(arg_9_0.markTrs) do
		setActive = var_1_10010

		var_1_10010(iter_9_1, iter_9_0 <= var_9_0)

		setActive = var_1_10010

		var_1_10010(iter_9_1:Find("finish"), iter_9_0 <= var_2)

		setActive = var_1_10010

		var_1_10010(iter_9_1:Find("finish/line"), var_2 >= iter_9_0 + 1)
	end

	return
end

function var_0_1.FlushIndex(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.usedtime

	arg_10_0.indexTxt.text = "<color=#e68f72>" .. var_10_0 .. "</color><color=#5a4141>/7</color>"

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
