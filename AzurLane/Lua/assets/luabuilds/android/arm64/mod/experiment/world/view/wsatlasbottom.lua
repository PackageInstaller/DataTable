class = var_0_10000

local var_0_0 = "WSAtlasBottom"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	btnShop = "userdata",
	rtBg = "userdata",
	btnOverview = "userdata",
	transform = "userdata",
	wsTimer = "table",
	rtButton = "userdata",
	btnBoss = "userdata",
	comSilder = "userdata",
	twId = "number",
	btnCollection = "userdata",
	btnDailyTask = "userdata"
}
var_0_1.EventUpdateScale = "WSAtlasBottom.EventUpdateScale"

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.transform

	arg_3_0.rtBg = var_1.Find(var_3_0, "bg")
	arg_3_0.rtButton = var_1:Find("button")

	local var_3_1 = arg_3_0.rtButton

	arg_3_0.btnBoss = var_2.Find(var_3_1, "btn_boss")

	local var_3_2 = arg_3_0.rtButton

	arg_3_0.btnShop = var_2.Find(var_3_2, "btn_shop")

	local var_3_3 = arg_3_0.rtButton

	arg_3_0.btnOverview = var_2.Find(var_3_3, "btn_overview")

	local var_3_4 = arg_3_0.rtButton

	arg_3_0.btnCollection = var_2.Find(var_3_4, "btn_collection")

	local var_3_5 = arg_3_0.rtButton

	arg_3_0.btnDailyTask = var_2.Find(var_3_5, "btn_daily")

	local var_3_6 = var_1:Find("scale/Slider")

	arg_3_0.comSilder = var_2.GetComponent(var_3_6, "Slider")

	local var_3_7 = arg_3_0.comSilder

	CAMERA_MOVE_OPEN = var_1_10003
	var_3_7.interactable = var_1_10003
	CAMERA_MOVE_OPEN = var_3_7

	if var_3_7 then
		local var_3_8 = arg_3_0.comSilder.onValueChanged

		var_2.AddListener(var_3_8, function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.DispatchEvent(var_4_0, var_0_1.EventUpdateScale, arg_4_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateScale(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 then
		var_1_10004 = arg_5_0.comSilder.value
		setImageAlpha = var_1_10005

		var_1_10005(arg_5_0.btnOverview, var_1_10004)

		setActive = var_1_10005

		var_1_10005(arg_5_0.btnOverview, true)

		LeanTween = var_1_10005

		local var_5_0 = var_1_10005.value

		go = var_7

		local var_5_1 = var_7(arg_5_0.comSilder)
		local var_5_2 = var_1_10004
		local var_5_3 = arg_5_1

		WSAtlasWorld = var_1_10010

		local var_5_4 = var_5_0(var_5_1, var_5_2, var_5_3, var_1_10010.baseDuration)
		local var_5_5 = var_5.setEase

		LeanTweenType = var_5_2

		local var_5_6 = var_5_5(var_5_4, var_5_2.easeInOutSine)
		local var_5_7 = var_5.setOnUpdate

		System = var_8

		local var_5_8 = var_5_7(var_5_6, var_8.Action_float(function(arg_6_0)
			local var_6_0 = arg_5_0.comSilder

			var_6_0.value = arg_6_0
			setImageAlpha = var_6_0

			var_6_0(arg_5_0.btnOverview, arg_6_0)

			return
		end))
		local var_5_9 = var_5.setOnComplete

		System = var_8
		arg_5_0.twId = var_5_9(var_5_8, var_8.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_5_0.btnOverview, arg_5_1 == 1)

			existCall = var_2_10000

			return var_2_10000(arg_5_3)
		end)).uniqueId

		local var_5_10 = arg_5_0.wsTimer

		var_5.AddTween(var_5_10, arg_5_0.twId)
	else
		setImageAlpha = var_1_10004

		var_1_10004(arg_5_0.btnOverview, arg_5_1)

		setActive = var_1_10004

		var_1_10004(arg_5_0.btnOverview, arg_5_1 == 1)

		local var_5_11 = arg_5_0.comSilder

		var_5_11.value = arg_5_1
		existCall = var_5_11

		return var_5_11(arg_5_3)
	end

	return
end

function var_0_1.CheckIsTweening(arg_8_0)
	local var_8_0

	if arg_8_0.twId then
		LeanTween = var_8_0
		var_8_0 = var_8_0.isTweening(arg_8_0.twId)
	end

	return var_8_0
end

function var_0_1.SetOverSize(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.rtBg

	Vector2 = var_1_10003
	var_9_0.offsetMin = var_1_10003(arg_9_1, arg_9_0.rtBg.offsetMin.y)

	local var_9_1 = arg_9_0.rtBg

	Vector2 = var_3
	var_9_1.offsetMax = var_3(-arg_9_1, arg_9_0.rtBg.offsetMax.y)

	return
end

return var_0_1
