class = var_0_10000

local var_0_0 = "ActivityBossAisaikesiScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityBossSceneTemplate"))

var_0_1.ASKSRemasterStage = 1201204

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossAisaikesiUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	local var_3_0 = 0

	onButton = var_2

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.mainTF

	var_2(var_3_1, var_4.Find(var_3_2, "logo"), function()
		var_3_0 = var_3_0 + 1

		if var_3_0 >= 10 then
			local var_4_0 = arg_3_0

			var_0.RemasterSuffering(var_4_0)

			var_3_0 = 0

			return
		end

		pg = var_0

		local var_4_1 = var_0.TipsMgr.GetInstance()

		var_0.ShowTips(var_4_1, 10 - var_3_0)

		return
	end)

	return
end

function var_0_1.UpdatePage(arg_5_0)
	var_0_1.super.UpdatePage(arg_5_0)

	return
end

function var_0_1.EnterAnim(arg_6_0)
	local function var_6_0()
		var_0_1.super.EnterAnim(arg_6_0)

		local var_7_0 = arg_6_0.loader

		var_0.GetPrefab(var_7_0, "ui/ASKS_Loop", "", function(arg_8_0)
			setParent = var_3_10001

			var_3_10001(arg_8_0, arg_6_0.mainTF)

			setAnchoredPosition = var_3_10001

			var_3_10001(arg_8_0, {
				x = -154.7,
				y = -120.9
			})

			tf = var_3_10001

			local var_8_0 = var_3_10001(arg_8_0)

			var_1.SetAsFirstSibling(var_8_0)

			local var_8_1 = arg_6_0

			var_8_1.raidarAnim = arg_8_0
			setActive = var_8_1

			var_8_1(arg_8_0, true)

			return
		end)

		return
	end

	if not arg_6_0.contextData.showAni then
		var_6_0()

		return
	end

	arg_6_0.contextData.showAni = nil

	local var_6_1 = arg_6_0.mainTF
	local var_6_2 = var_2.Find(var_6_1, "logo")

	setActive = var_6_1

	var_6_1(var_6_2, false)

	local var_6_3

	local function var_6_4()
		setActive = var_2_10000

		var_2_10000(var_6_2, true)

		setActive = var_2_10000

		var_2_10000(var_6_3, false)

		local var_9_0 = arg_6_0.loader

		var_0.ReturnPrefab(var_9_0, var_6_3)

		return
	end

	local var_6_5 = arg_6_0.loader

	var_5.GetPrefab(var_6_5, "ui/asks", "asks", function(arg_10_0)
		setParent = var_2_10001

		var_2_10001(arg_10_0, arg_6_0._tf)

		var_6_3 = arg_10_0

		local var_10_0
		local var_10_1 = arg_10_0:GetComponent("DftAniEvent")

		var_2.SetEndEvent(var_10_1, var_6_4)
		var_2:SetTriggerEvent(function()
			var_6_0()

			var_10_0 = true

			return
		end)

		onButton = var_3

		var_3(arg_6_0, arg_10_0, function()
			local var_12_0

			if not var_10_0 and not var_6_0() then
				var_12_0 = true
			end

			var_10_0 = var_12_0

			var_6_4()

			return
		end)

		return
	end)

	return
end

function var_0_1.RemasterSuffering(arg_13_0)
	GameObject = var_1_10001

	local var_13_0 = var_1_10001.New("Mask")
	local var_13_1 = var_1.AddComponent

	typeof = var_1_10004
	RectTransform = var_1_10005

	local var_13_2 = var_13_1(var_13_0, var_1_10004(var_1_10005))

	Vector2 = var_13_0
	var_13_2.anchorMin = var_13_0.zero
	Vector2 = var_3
	var_13_2.anchorMax = var_3.one

	local var_13_3 = var_1
	local var_13_4 = var_1.AddComponent

	typeof = var_1_10005
	Image = var_1_10006

	local var_13_5 = var_13_4(var_13_3, var_1_10005(var_1_10006))

	Color = var_13_3
	var_13_5.color = var_13_3.New(0, 0, 0, 1)
	var_13_5.raycastTarget = false

	var_13_2:SetParent(arg_13_0._tf)

	pg = var_4

	local var_13_6 = var_4.NewStoryMgr.GetInstance()

	var_4.Play(var_13_6, "AISAIKESICAIDAN", function()
		local var_14_0 = arg_13_0

		var_0.emit(var_14_0, arg_13_0.contextData.mediatorClass.ON_PERFORM_COMBAT, arg_13_0.ASKSRemasterStage)

		return
	end)

	return
end

function var_0_1.willExit(arg_15_0)
	local var_15_0 = arg_15_0.loader

	var_1.Clear(var_15_0)
	var_0_1.super.willExit(arg_15_0)

	return
end

return var_0_1
