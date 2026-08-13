ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig

class = var_0_10002

local var_0_2 = var_0_10002("BattleDropsView")

var_0.Battle.BattleDropsView = var_0_2
var_0_2.__name = "BattleDropsView"
var_0_2.FLOAT_DURATION = 0.4

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._container = arg_1_2
	arg_1_0._containerTF = arg_1_0._container.transform

	arg_1_0:init()

	return
end

function var_0_2.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._go, arg_2_1)

	return
end

function var_0_2.AddCamera(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._camera = arg_3_1
	arg_3_0._uiCamera = arg_3_2
	arg_3_0._cameraTF = arg_3_0._camera.transform
	arg_3_0._cameraSrcX = arg_3_0._cameraTF.localPosition.x
	arg_3_0._cameraSrcZ = var_3.z
	arg_3_0._cameraXRotate = arg_3_0._cameraTF.localEulerAngles.x

	return
end

function var_0_2.RefreshScaleRate(arg_4_0)
	UnityEngine = var_1_10001

	local var_4_0 = var_1_10001.Screen.width

	UnityEngine = var_1_10002

	local var_4_1 = var_1_10002.Screen.height
	local var_4_2 = arg_4_0._camera
	local var_4_3 = var_3.ScreenToWorldPoint

	Vector3 = var_1_10006
	arg_4_0._xScale = var_4_0 / var_4_3(var_4_2, var_1_10006(var_4_0, var_4_1, 0)).x
	arg_4_0._yScale = var_4_1 / var_3.y

	return
end

function var_0_2.Update(arg_5_0)
	if #arg_5_0._resourceList == #arg_5_0._resourcePool then
		return
	end

	arg_5_0:updateContainerPosition()

	return
end

function var_0_2.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0._resourceIcon = var_1.Find(var_6_0, "resourceIcon")

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_1.Find(var_6_1, "resourceText")
	local var_6_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_6_0._resourceText = var_6_3(var_6_2, var_4(var_1_10006))

	local var_6_4 = arg_6_0._containerTF

	arg_6_0._resourceGO = var_1.Find(var_6_4, "spin_gold")

	local var_6_5 = arg_6_0._tf.rect.width / 2
	local var_6_6 = arg_6_0._tf.rect.height / 2

	arg_6_0._resourceIconX = arg_6_0._resourceIcon.transform.anchoredPosition.x + var_6_5
	arg_6_0._resourceIconY = arg_6_0._resourceIcon.transform.anchoredPosition.y + var_6_6
	arg_6_0._itemPool = {}
	arg_6_0._resourcePool = {}
	arg_6_0._resourceList = {}
	arg_6_0._itemCount = 0
	arg_6_0._resourceCount = 0

	arg_6_0:updateCountText(arg_6_0._resourceText)

	arg_6_0._timerList = {}

	local var_6_7 = {}

	for iter_6_0 = 1, 5 do
		table = var_1_10008

		var_1_10008.insert(var_6_7, arg_6_0:pop(arg_6_0._resourcePool))
	end

	for iter_6_1 = 1, 5 do
		arg_6_0:push(var_6_7[iter_6_1], arg_6_0._resourcePool)
	end

	local var_6_8

	return
end

function var_0_2.pop(arg_7_0, arg_7_1)
	local var_7_0

	if #arg_7_1 == 0 then
		if arg_7_1 == arg_7_0._resourcePool then
			Object = var_3

			local var_7_1 = var_3.Instantiate
			local var_7_2 = arg_7_0._resourceGO

			Vector3 = var_1_10006

			local var_7_3 = var_1_10006.zero

			Quaternion = var_1_10007
			var_7_0 = var_7_1(var_7_2, var_7_3, var_1_10007.identity)
			arg_7_0._resourceList[#arg_7_0._resourceList + 1] = var_7_0
		end

		local var_7_4 = var_7_0.transform

		var_3.SetParent(var_7_4, arg_7_0._go, false)
	else
		var_7_0 = arg_7_1[#arg_7_1]
		arg_7_1[#arg_7_1] = nil
	end

	return var_7_0
end

function var_0_2.push(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.transform

	Vector3 = var_1_10004
	var_8_0.localScale = var_1_10004(0.35, 0.35, 0.35)

	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.GetComponent

	typeof = var_6
	Animator = var_8

	local var_8_3 = var_8_2(var_8_1, var_6(var_8))

	var_8_3.enabled = false
	SetActive = var_8_3

	var_8_3(arg_8_1, false)

	arg_8_2[#arg_8_2 + 1] = arg_8_1

	return
end

function var_0_2.updateCountText(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_1 == arg_9_0._resourceText then
		var_9_0 = arg_9_0._resourceCount
	end

	if 999 < var_9_0 then
		string = var_3
		arg_9_1.text = var_3.format("%s%.1f%s", "x", var_9_0 / 1000, "k")
	else
		string = var_3
		arg_9_1.text = var_3.format("%s%d", "x", var_9_0)
	end

	return
end

function var_0_2.ShowDrop(arg_10_0, arg_10_1)
	if #arg_10_0._resourceList == #arg_10_0._resourcePool then
		arg_10_0:updateContainerPosition()
	end

	local var_10_0 = var_0.Battle.BattleVariable.CameraPosToUICamera
	local var_10_1 = arg_10_1.scenePos
	local var_10_2 = var_10_0(var_4.Clone(var_10_1))

	Vector3 = var_3

	local var_10_3 = var_3(var_10_2.x, var_10_2.y, 2)
	local var_10_4 = arg_10_1.drops.resourceCount

	math = var_5

	local var_10_5, var_10_6 = var_5.modf(var_10_4 / var_0_1.RESOURCE_STEP)

	if var_10_6 > 0 then
		arg_10_0:makeFloatAnima(var_10_3, arg_10_0._resourcePool, arg_10_0._resourceIconX, arg_10_0._resourceIconY, arg_10_0._resourceIcon, "_resourceCount", var_10_6 * var_0_1.RESOURCE_STEP, arg_10_0._resourceText, 0)
	end

	while var_10_5 > 0 do
		arg_10_0:makeFloatAnima(var_10_3, arg_10_0._resourcePool, arg_10_0._resourceIconX, arg_10_0._resourceIconY, arg_10_0._resourceIcon, "_resourceCount", var_0_1.RESOURCE_STEP, arg_10_0._resourceText, var_10_5)

		var_10_5 = var_10_5 - 1
	end

	return
end

function var_0_2.updateContainerPosition(arg_11_0)
	local var_11_0 = arg_11_0._cameraTF.localPosition
	local var_11_1 = arg_11_0._containerTF

	Vector3 = var_1_10003
	var_11_1.localPosition = var_1_10003(arg_11_0._xScale * (arg_11_0._cameraSrcX - var_11_0.x), arg_11_0._yScale * (arg_11_0._cameraSrcZ - var_11_0.z), 0)

	return
end

function var_0_2.makeFloatAnima(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8, arg_12_9)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.pop(var_12_0, arg_12_2).transform

	SetActive = var_12_0

	var_12_0(var_10, true)

	var_12_1.position = arg_12_1
	var_12_1.localPosition = var_12_1.localPosition - arg_12_0._containerTF.localPosition

	arg_12_0:Update()

	local var_12_2 = var_12_1

	var_12_1.SetParent(var_12_2, arg_12_0._container, false)

	math = var_12

	local var_12_3 = var_12.random() * 200 - 100

	math = var_13

	local var_12_4 = var_13.random() * 200

	LeanTween = var_12_2

	local var_12_5 = var_12_2.moveX

	rtf = var_16

	local var_12_6 = var_12_5(var_16(var_10), var_12_1.anchoredPosition.x + var_12_3, var_0_1.RESOURCE_STAY_DURATION + arg_12_9 * 0.05)
	local var_12_7 = var_14.setOnComplete

	System = var_17

	var_12_7(var_12_6, var_17.Action(function()
		LeanTween = var_2_10000

		local var_13_0 = var_2_10000.scale

		go = var_2_10002

		local var_13_1 = var_2_10002(var_0)

		Vector3 = var_2_10003

		var_13_0(var_13_1, var_2_10003(0.2, 0.2, 1), var_0_2.FLOAT_DURATION)

		Vector3 = var_13_0

		local var_13_2 = var_13_0(arg_12_3 - var_12_1.position.x, arg_12_4 - var_12_1.position.y, 0)

		var_12_1.localPosition = var_12_1.localPosition + arg_12_0._containerTF.localPosition

		local var_13_3 = var_12_1

		var_1.SetParent(var_13_3, arg_12_0._go, false)

		LeanTween = var_1

		local var_13_4 = var_1.move

		rtf = var_13_3

		local var_13_5 = var_13_4(var_13_3(var_0), var_13_2, var_0_2.FLOAT_DURATION)
		local var_13_6 = var_1.setOnComplete

		System = var_4

		var_13_6(var_13_5, var_4.Action(function()
			local var_14_0 = arg_12_0

			var_0.push(var_14_0, var_0, arg_12_2)

			local var_14_1 = arg_12_5.transform

			Vector3 = var_3_10001
			var_14_1.localScale = var_3_10001(0.35, 0.35, 0.35)
			arg_12_0[arg_12_6] = arg_12_0[arg_12_6] + arg_12_7

			local var_14_2 = arg_12_0

			var_0.updateCountText(var_14_2, arg_12_8)

			LeanTween = var_0

			local var_14_3 = var_0.scale

			go = var_14_2

			local var_14_4 = var_14_2(arg_12_5)

			Vector3 = var_3

			local var_14_5 = var_14_3(var_14_4, var_3(0.5, 0.5, 0.5), 0.12)
			local var_14_6 = var_0.setEase

			LeanTweenType = var_3

			local var_14_7 = var_14_6(var_14_5, var_3.easeOutExpo)
			local var_14_8 = var_0.setOnComplete

			System = var_3

			var_14_8(var_14_7, var_3.Action(function()
				LeanTween = var_4_10000

				local var_15_0 = var_4_10000.scale

				go = var_4_10002

				local var_15_1 = var_4_10002(arg_12_5)

				Vector3 = var_4_10003

				var_15_0(var_15_1, var_4_10003(0.35, 0.35, 0.35), 0.3)

				return
			end))

			return
		end))

		return
	end))

	local var_12_8 = var_12_4 / 200

	LeanTween = var_15

	local var_12_9 = var_15.moveY

	rtf = var_17

	local var_12_10 = var_12_9(var_17(var_10), var_12_1.anchoredPosition.y + var_12_4, 0.5 * var_12_8)
	local var_12_11 = var_15.setOnComplete

	System = var_18

	var_12_11(var_12_10, var_18.Action(function()
		local var_16_0 = var_0
		local var_16_1 = var_0.GetComponent(var_16_0, "Animator")

		var_16_1.enabled = true
		LeanTween = var_16_1

		local var_16_2 = var_16_1.moveY

		rtf = var_16_0

		local var_16_3 = var_16_2(var_16_0(var_0), var_12_1.anchoredPosition.y - var_12_4, 1.5 * var_12_8)
		local var_16_4 = var_0.setEase

		LeanTweenType = var_3

		var_16_4(var_16_3, var_3.easeOutBounce)

		return
	end))

	return
end

function var_0_2.Dispose(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0._timerList) do
		if iter_17_1 then
			pg = var_1_10006
			var_1_10008 = var_1_10006.TimeMgr.GetInstance()

			var_1_10006.RemoveBattleTimer(var_1_10008, iter_17_0)
		end
	end

	ipairs = var_1

	for iter_17_2, iter_17_3 in var_1(arg_17_0._resourceList) do
		LeanTween = var_1_10006
		var_1_10006 = var_1_10006.cancel
		go = var_1_10008

		var_1_10006(var_1_10008(iter_17_3))
	end

	arg_17_0._timerList = nil
	arg_17_0._go = nil
	arg_17_0._resourceIcon = nil
	arg_17_0._resourceText = nil
	arg_17_0._itemIcon = nil
	arg_17_0._itemText = nil
	arg_17_0._camera = nil
	arg_17_0._uiCamera = nil

	return
end

return
