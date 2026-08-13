class = var_0_10000

local var_0_0 = "BeachGamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

var_0_1.MINIGAME_HUB_ID = 37
var_0_1.MINIGAME_ID = 44

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_0, "AD/go")

	local var_1_1 = arg_1_0._tf

	arg_1_0.indexTpl = var_1.Find(var_1_1, "AD/index")

	local var_1_2 = arg_1_0._tf

	arg_1_0.markContainer = var_1.Find(var_1_2, "AD/marks")

	local var_1_3 = arg_1_0._tf

	arg_1_0.markTpl = var_1.Find(var_1_3, "AD/marks/1")
	arg_1_0.markTrs = {}

	for iter_1_0 = 1, 7 do
		cloneTplTo = var_1_10005
		var_1_10005 = var_1_10005(arg_1_0.markTpl, arg_1_0.markContainer, iter_1_0)
		setActive = var_1_10006

		var_1_10006(var_1_10005:Find("open"), iter_1_0 ~= 7)

		setActive = var_1_10006

		var_1_10006(var_1_10005:Find("openL"), iter_1_0 == 7)

		table = var_1_10006

		var_1_10006.insert(arg_1_0.markTrs, var_1_10005)
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

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_MINI_GAME, var_0_1.MINIGAME_ID)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	getProxy = var_1_10001
	MiniGameProxy = var_3_0

	local var_3_3 = var_1_10001(var_3_0)
	local var_3_4 = var_1.GetHubByHubId(var_3_3, var_0_1.MINIGAME_HUB_ID)

	arg_3_0:FlushMarks(var_3_4)

	Canvas = var_3

	var_3.ForceUpdateCanvases()
	arg_3_0:FlushIndex(var_3_4)

	return
end

function var_0_1.FlushMarks(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.usedtime + arg_5_1.count

	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(arg_5_0.markTrs) do
		setActive = var_1_10010

		var_1_10010(iter_5_1, iter_5_0 <= var_5_0)

		setActive = var_1_10010

		var_1_10010(iter_5_1:Find("finish"), iter_5_0 <= var_2 and iter_5_0 ~= 7)

		setActive = var_1_10010

		var_1_10010(iter_5_1:Find("finishL"), iter_5_0 <= var_2 and iter_5_0 == 7)
	end

	return
end

function var_0_1.FlushIndex(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.usedtime

	setActive = var_1_10003

	var_1_10003(arg_6_0.indexTpl, var_6_0 > 0)

	if var_6_0 > 0 then
		local var_6_1 = arg_6_0.markTrs

		math = var_1_10004

		local var_6_2 = var_6_1[var_1_10004.min(var_6_0, #arg_6_0.markTrs)]
		local var_6_3 = arg_6_0.indexTpl.parent
		local var_6_4 = var_4.InverseTransformPoint(var_6_3, var_6_2.position)
		local var_6_5 = arg_6_0.indexTpl

		Vector3 = var_6_3
		var_6_5.localPosition = var_6_3(var_6_4.x, var_6_4.y, 0)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
