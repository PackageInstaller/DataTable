class = var_0_10000

local var_0_0 = "UIStrikeAnim"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".UIAnim"))

var_0_1.Fields = {
	char = "table",
	aniEvent = "userdata",
	painting = "userdata",
	playing = "boolean",
	transform = "userdata",
	prefab = "string",
	onTrigger = "function",
	onStart = "function",
	onEnd = "function",
	skelegraph = "userdata",
	shipVO = "table"
}
var_0_1.EventLoaded = "UIStrikeAnim.EventLoaded"

function var_0_1.Setup(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.prefab = arg_1_1
	arg_1_0.shipVO = arg_1_2

	return
end

function var_0_1.LoadBack(arg_2_0)
	if arg_2_0.transform and arg_2_0.painting and arg_2_0.char then
		arg_2_0:Init()
		arg_2_0:DispatchEvent(var_0_1.EventLoaded)
	end

	return
end

function var_0_1.Load(arg_3_0)
	local var_3_0 = arg_3_0.prefab

	PoolMgr = var_1_10002

	local var_3_1 = var_1_10002.GetInstance()

	var_2.GetUI(var_3_1, var_3_0, true, function(arg_4_0)
		if var_3_0 == arg_3_0.prefab then
			arg_3_0.transform = arg_4_0.transform

			local var_4_0 = arg_3_0

			var_1.LoadBack(var_4_0)
		else
			local var_4_1 = var_0

			var_1.ReturnUI(var_4_1, var_3_0, arg_4_0)
		end

		return
	end)
	arg_3_0:ReloadShip(arg_3_0.shipVO)

	return
end

function var_0_1.ReloadShip(arg_5_0, arg_5_1)
	arg_5_0.shipVO = arg_5_1
	arg_5_0.aniEvent = nil
	arg_5_0.painting = nil
	arg_5_0.char = nil
	PoolMgr = var_2

	local var_5_0 = var_2.GetInstance().GetInstance()

	var_3.GetPainting(var_5_0, arg_5_1:getPainting(), true, function(arg_6_0)
		local var_6_0 = arg_5_0

		var_6_0.painting = arg_6_0
		ShipExpressionHelper = var_6_0

		local var_6_1 = var_6_0.SetExpression
		local var_6_2 = arg_5_0.painting
		local var_6_3 = arg_5_1

		var_6_1(var_6_2, var_4.getPainting(var_6_3))

		local var_6_4 = arg_5_0

		var_1.LoadBack(var_6_4)

		return
	end)

	SpineAnimChar = var_3
	arg_5_0.char = var_3.New()

	local var_5_1 = arg_5_0.char

	var_3.SetPaint(var_5_1, arg_5_1:getPrefab())

	local var_5_2 = arg_5_0.char

	var_3.Load(var_5_2, true, function(arg_7_0)
		arg_5_0.char = arg_7_0

		local var_7_0 = arg_5_0.char
		local var_7_1 = var_1.SetLocalScale

		Vector3 = var_2_10004

		var_7_1(var_7_0, var_2_10004.one)

		local var_7_2 = arg_5_0

		var_1.LoadBack(var_7_2)

		return
	end)

	return
end

function var_0_1.UnloadShipVO(arg_8_0)
	local var_8_0 = arg_8_0.shipVO

	retPaintingPrefab = var_1_10002

	local var_8_1 = arg_8_0.transform

	var_1_10002(var_4.Find(var_8_1, "mask/painting"), var_8_0:getPainting())

	local var_8_2 = arg_8_0.char

	var_2.Dispose(var_8_2)

	arg_8_0.shipVO = nil
	arg_8_0.painting = nil
	arg_8_0.char = nil

	return
end

function var_0_1.Play(arg_9_0, arg_9_1)
	arg_9_0.playing = true

	function arg_9_0.onStart(arg_10_0)
		local var_10_0 = arg_9_0.char

		var_1.SetAction(var_10_0, "attack", 0)

		arg_9_0.skelegraph.freeze = true

		return
	end

	function arg_9_0.onTrigger(arg_11_0)
		arg_9_0.skelegraph.freeze = false

		local var_11_0 = arg_9_0.char

		var_1.SetActionCallBack(var_11_0, function(arg_12_0)
			if arg_12_0 == "action" then
				-- block empty
			elseif arg_12_0 == "finish" then
				arg_9_0.skelegraph.freeze = true
			end

			return
		end)

		return
	end

	arg_9_0.onEnd = arg_9_1

	arg_9_0:Update()

	return
end

function var_0_1.Stop(arg_13_0)
	arg_13_0.playing = false

	arg_13_0:Update()

	if arg_13_0.skelegraph then
		arg_13_0.skelegraph.freeze = false
	end

	arg_13_0:UnloadShipVO()

	return
end

function var_0_1.Init(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.transform, false)

	local var_14_0 = arg_14_0.transform
	local var_14_1 = var_1.Find(var_14_0, "torpedo")
	local var_14_2 = arg_14_0.transform
	local var_14_3 = var_2.Find(var_14_2, "mask/painting")
	local var_14_4 = arg_14_0.transform
	local var_14_5 = var_3.Find(var_14_4, "ship")

	setParent = var_14_2

	var_14_2(arg_14_0.painting, var_14_3:Find("fitter"), false)

	local var_14_6 = arg_14_0.char

	var_4.SetParent(var_14_6, var_14_5)

	setActive = var_4

	var_4(var_14_5, false)

	setActive = var_4

	var_4(var_14_1, false)

	local var_14_7 = arg_14_0.char

	arg_14_0.skelegraph = var_4.GetSkeletonGraphic(var_14_7)

	local var_14_8 = arg_14_0.transform

	arg_14_0.aniEvent = var_4.GetComponent(var_14_8, "DftAniEvent")

	arg_14_0:Update()

	return
end

return var_0_1
