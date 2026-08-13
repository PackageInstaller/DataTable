class = var_0_10000

local var_0_0 = "SculpturePresentedPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculpturePresentedUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.container = var_1.Find(var_2_0, "frame/container")

	local var_2_1 = arg_2_0._tf

	arg_2_0.sendBtn = var_1.Find(var_2_1, "frame/btn")
	setAnchoredPosition = var_1

	var_1(arg_2_0.container, {
		x = 0,
		y = -80
	})

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.Show(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:Clear()
	var_0_1.super.Show(arg_4_0)

	arg_4_0.id = arg_4_1
	arg_4_0.activity = arg_4_2

	if arg_4_3 then
		arg_4_3()
	end

	seriesAsync = var_4

	var_4({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.LoadSculpture(var_5_0, arg_5_0)

			return
		end
	}, function()
		local var_6_0 = arg_4_0

		var_0.RegisterEvent(var_6_0)

		return
	end)

	pg = var_4

	local var_4_0 = var_4.BgmMgr.GetInstance()

	var_4.Push(var_4_0, arg_4_0.__cname, "story-richang-8")

	return
end

function var_0_1.LoadSculpture(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.activity
	local var_7_1 = var_2.GetResorceName(var_7_0, arg_7_0.id)
	local var_7_2 = "gift_" .. var_7_1

	PoolMgr = var_4

	local var_7_3 = var_4.GetInstance()

	var_4.GetSpineChar(var_7_3, var_7_2, true, function(arg_8_0)
		local var_8_0 = arg_8_0.transform

		var_1.SetParent(var_8_0, arg_7_0.container)

		local var_8_1 = arg_8_0.transform

		Vector3 = var_2_10002
		var_8_1.localScale = var_2_10002.one

		local var_8_2 = arg_8_0.transform

		Vector3 = var_2
		var_8_2.localPosition = var_2(0, 0, 0)

		local var_8_3 = arg_8_0
		local var_8_4 = arg_8_0.GetComponent

		typeof = var_4
		SpineAnimUI = var_6

		local var_8_5 = var_8_4(var_8_3, var_4(var_6))

		var_1.SetAction(var_8_5, "normal", 0)

		arg_7_0.charName = var_7_2
		arg_7_0.charGo = arg_8_0

		if arg_7_1 then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_1.RegisterEvent(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.sendBtn

	local function var_9_2()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		SculptureScene = var_2_10003

		var_10_1(var_10_0, var_2_10003.OPEN_GRATITUDE_PAGE, arg_9_0.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10006)

	return
end

function var_0_1.Clear(arg_11_0)
	if arg_11_0.charGo then
		PoolMgr = var_1

		local var_11_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_11_0, arg_11_0.charName, arg_11_0.charGo)
	end

	return
end

function var_0_1.Hide(arg_12_0)
	var_0_1.super.Hide(arg_12_0)

	pg = var_1

	local var_12_0 = var_1.BgmMgr.GetInstance()

	var_1.Pop(var_12_0, arg_12_0.__cname)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:Clear()

	return
end

return var_0_1
