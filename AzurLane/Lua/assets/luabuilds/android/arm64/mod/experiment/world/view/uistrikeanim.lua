local var_0_0 = class("UIStrikeAnim", import(".UIAnim"))

var_0_0.Fields = {
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
var_0_0.EventLoaded = "UIStrikeAnim.EventLoaded"

function var_0_0.Setup(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.prefab = arg_1_1
	arg_1_0.shipVO = arg_1_2

	return
end

function var_0_0.LoadBack(arg_2_0)
	if arg_2_0.transform and arg_2_0.painting and arg_2_0.char then
		arg_2_0:Init()
		arg_2_0:DispatchEvent(var_0_0.EventLoaded)
	end

	return
end

function var_0_0.Load(arg_3_0)
	local var_3_0 = PoolMgr.GetInstance()

	PoolMgr.GetInstance():GetUI(arg_3_0.prefab, true, function(arg_4_0)
		if var_0 == arg_3_0.prefab then
			arg_3_0.transform = arg_4_0.transform

			arg_3_0:LoadBack()
		else
			var_3_0:ReturnUI(var_0, arg_4_0)
		end

		return
	end)
	arg_3_0:ReloadShip(arg_3_0.shipVO)

	return
end

function var_0_0.ReloadShip(arg_5_0, arg_5_1)
	arg_5_0.shipVO = arg_5_1
	arg_5_0.aniEvent = nil
	arg_5_0.painting = nil
	arg_5_0.char = nil

	PoolMgr.GetInstance().GetInstance():GetPainting(arg_5_1:getPainting(), true, function(arg_6_0)
		arg_5_0.painting = arg_6_0

		ShipExpressionHelper.SetExpression(arg_5_0.painting, arg_5_1:getPainting())
		arg_5_0:LoadBack()

		return
	end)

	arg_5_0.char = SpineAnimChar.New()

	arg_5_0.char:SetPaint(arg_5_1:getPrefab())
	arg_5_0.char:Load(true, function(arg_7_0)
		arg_5_0.char = arg_7_0

		arg_5_0.char:SetLocalScale(Vector3.one)
		arg_5_0:LoadBack()

		return
	end)

	return
end

function var_0_0.UnloadShipVO(arg_8_0)
	retPaintingPrefab(arg_8_0.transform:Find("mask/painting"), arg_8_0.shipVO:getPainting())
	arg_8_0.char:Dispose()

	arg_8_0.shipVO = nil
	arg_8_0.painting = nil
	arg_8_0.char = nil

	return
end

function var_0_0.Play(arg_9_0, arg_9_1)
	arg_9_0.playing = true

	function arg_9_0.onStart(arg_10_0)
		arg_9_0.char:SetAction("attack", 0)

		arg_9_0.skelegraph.freeze = true

		return
	end

	function arg_9_0.onTrigger(arg_11_0)
		arg_9_0.skelegraph.freeze = false

		arg_9_0.char:SetActionCallBack(function(arg_12_0)
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

function var_0_0.Stop(arg_13_0)
	arg_13_0.playing = false

	arg_13_0:Update()

	if arg_13_0.skelegraph then
		arg_13_0.skelegraph.freeze = false
	end

	arg_13_0:UnloadShipVO()

	return
end

function var_0_0.Init(arg_14_0)
	setActive(arg_14_0.transform, false)

	local var_14_0 = arg_14_0.transform:Find("ship")

	setParent(arg_14_0.painting, arg_14_0.transform:Find("mask/painting"):Find("fitter"), false)
	arg_14_0.char:SetParent(var_14_0)
	setActive(var_14_0, false)
	setActive(arg_14_0.transform:Find("torpedo"), false)

	arg_14_0.skelegraph = arg_14_0.char:GetSkeletonGraphic()
	arg_14_0.aniEvent = arg_14_0.transform:GetComponent("DftAniEvent")

	arg_14_0:Update()

	return
end

return var_0_0
