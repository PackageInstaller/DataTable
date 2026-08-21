ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local var_0_1 = class("BattleDropsView")

ys.Battle.BattleDropsView = var_0_1
var_0_1.__name = "BattleDropsView"
var_0_1.FLOAT_DURATION = 0.4

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._container = arg_1_2
	arg_1_0._containerTF = arg_1_0._container.transform

	arg_1_0:init()

	return
end

function var_0_1.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0._go, arg_2_1)

	return
end

function var_0_1.AddCamera(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._camera = arg_3_1
	arg_3_0._uiCamera = arg_3_2
	arg_3_0._cameraTF = arg_3_0._camera.transform
	arg_3_0._cameraSrcX = arg_3_0._cameraTF.localPosition.x
	arg_3_0._cameraSrcZ = arg_3_0._cameraTF.localPosition.z
	arg_3_0._cameraXRotate = arg_3_0._cameraTF.localEulerAngles.x

	return
end

function var_0_1.RefreshScaleRate(arg_4_0)
	local var_4_0 = arg_4_0._camera:ScreenToWorldPoint(Vector3(UnityEngine.Screen.width, UnityEngine.Screen.height, 0))

	arg_4_0._xScale = UnityEngine.Screen.width / var_4_0.x
	arg_4_0._yScale = UnityEngine.Screen.height / var_4_0.y

	return
end

function var_0_1.Update(arg_5_0)
	if #arg_5_0._resourceList == #arg_5_0._resourcePool then
		return
	end

	arg_5_0:updateContainerPosition()

	return
end

function var_0_1.init(arg_6_0)
	arg_6_0._resourceIcon = arg_6_0._tf:Find("resourceIcon")
	arg_6_0._resourceText = arg_6_0._tf:Find("resourceText"):GetComponent(typeof(Text))
	arg_6_0._resourceGO = arg_6_0._containerTF:Find("spin_gold")
	arg_6_0._resourceIconX = arg_6_0._resourceIcon.transform.anchoredPosition.x + arg_6_0._tf.rect.width / 2
	arg_6_0._resourceIconY = arg_6_0._resourceIcon.transform.anchoredPosition.y + arg_6_0._tf.rect.height / 2
	arg_6_0._itemPool = {}
	arg_6_0._resourcePool = {}
	arg_6_0._resourceList = {}
	arg_6_0._itemCount = 0
	arg_6_0._resourceCount = 0

	arg_6_0:updateCountText(arg_6_0._resourceText)

	arg_6_0._timerList = {}

	for iter_6_0 = 1, 5 do
		table.insert({}, arg_6_0:pop(arg_6_0._resourcePool))
	end

	for iter_6_1 = 1, 5 do
		arg_6_0:push(({})[iter_6_1], arg_6_0._resourcePool)
	end

	return
end

function var_0_1.pop(arg_7_0, arg_7_1)
	local var_7_0

	if #arg_7_1 == 0 then
		if arg_7_1 == arg_7_0._resourcePool then
			var_7_0 = Object.Instantiate(arg_7_0._resourceGO, Vector3.zero, Quaternion.identity)
			arg_7_0._resourceList[#arg_7_0._resourceList + 1] = var_7_0
		end

		var_7_0.transform:SetParent(arg_7_0._go, false)
	else
		var_7_0 = arg_7_1[#arg_7_1]
		arg_7_1[#arg_7_1] = nil
	end

	return var_7_0
end

function var_0_1.push(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.transform.localScale = Vector3(0.35, 0.35, 0.35)
	arg_8_1:GetComponent(typeof(Animator)).enabled = false

	SetActive(arg_8_1, false)

	arg_8_2[#arg_8_2 + 1] = arg_8_1

	return
end

function var_0_1.updateCountText(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_1 == arg_9_0._resourceText then
		var_9_0 = arg_9_0._resourceCount
	end

	arg_9_1.text = var_9_0 > 999 and string.format("%s%.1f%s", "x", var_9_0 / 1000, "k") or string.format("%s%d", "x", var_9_0)

	return
end

function var_0_1.ShowDrop(arg_10_0, arg_10_1)
	if #arg_10_0._resourceList == #arg_10_0._resourcePool then
		arg_10_0:updateContainerPosition()
	end

	local var_10_0 = var_0.Battle.BattleVariable.CameraPosToUICamera(arg_10_1.scenePos:Clone())
	local var_10_1 = Vector3(var_10_0.x, var_10_0.y, 2)
	local var_10_2, var_10_3 = math.modf(arg_10_1.drops.resourceCount / var_0_0.RESOURCE_STEP)

	if var_10_3 > 0 then
		arg_10_0:makeFloatAnima(var_10_1, arg_10_0._resourcePool, arg_10_0._resourceIconX, arg_10_0._resourceIconY, arg_10_0._resourceIcon, "_resourceCount", var_10_3 * var_0_0.RESOURCE_STEP, arg_10_0._resourceText, 0)
	end

	while var_10_2 > 0 do
		arg_10_0:makeFloatAnima(var_10_1, arg_10_0._resourcePool, arg_10_0._resourceIconX, arg_10_0._resourceIconY, arg_10_0._resourceIcon, "_resourceCount", var_0_0.RESOURCE_STEP, arg_10_0._resourceText, var_10_2)

		var_10_2 = var_10_2 - 1
	end

	return
end

function var_0_1.updateContainerPosition(arg_11_0)
	arg_11_0._containerTF.localPosition = Vector3(arg_11_0._xScale * (arg_11_0._cameraSrcX - arg_11_0._cameraTF.localPosition.x), arg_11_0._yScale * (arg_11_0._cameraSrcZ - arg_11_0._cameraTF.localPosition.z), 0)

	return
end

function var_0_1.makeFloatAnima(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8, arg_12_9)
	local var_12_0 = arg_12_0:pop(arg_12_2)
	local var_12_1 = var_12_0.transform

	SetActive(var_12_0, true)

	var_12_0.transform.position = arg_12_1
	var_12_0.transform.localPosition = var_12_0.transform.localPosition - arg_12_0._containerTF.localPosition

	arg_12_0:Update()
	var_12_0.transform:SetParent(arg_12_0._container, false)

	local var_12_2 = math.random() * 200

	LeanTween.moveX(rtf(var_12_0), var_12_0.transform.anchoredPosition.x + (math.random() * 200 - 100), var_0_0.RESOURCE_STAY_DURATION + arg_12_9 * 0.05):setOnComplete(System.Action(function()
		LeanTween.scale(go(var_12_0), Vector3(0.2, 0.2, 1), var_0_1.FLOAT_DURATION)

		var_12_1.localPosition = var_12_1.localPosition + arg_12_0._containerTF.localPosition

		var_12_1:SetParent(arg_12_0._go, false)
		LeanTween.move(rtf(var_12_0), Vector3(arg_12_3 - var_12_1.position.x, arg_12_4 - var_12_1.position.y, 0), var_0_1.FLOAT_DURATION):setOnComplete(System.Action(function()
			arg_12_0:push(var_12_0, arg_12_2)

			arg_12_5.transform.localScale = Vector3(0.35, 0.35, 0.35)
			arg_12_0[arg_12_6] = arg_12_0[arg_12_6] + arg_12_7

			arg_12_0:updateCountText(arg_12_8)
			LeanTween.scale(go(arg_12_5), Vector3(0.5, 0.5, 0.5), 0.12):setEase(LeanTweenType.easeOutExpo):setOnComplete(System.Action(function()
				LeanTween.scale(go(arg_12_5), Vector3(0.35, 0.35, 0.35), 0.3)

				return
			end))

			return
		end))

		return
	end))
	LeanTween.moveY(rtf(var_12_0), var_12_0.transform.anchoredPosition.y + var_12_2, 0.5 * (var_12_2 / 200)):setOnComplete(System.Action(function()
		var_12_0:GetComponent("Animator").enabled = true

		LeanTween.moveY(rtf(var_12_0), var_12_1.anchoredPosition.y - var_12_2, 1.5 * var_0):setEase(LeanTweenType.easeOutBounce)

		return
	end))

	return
end

function var_0_1.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._timerList) do
		if iter_17_1 then
			pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_17_0)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0._resourceList) do
		LeanTween.cancel(go(iter_17_3))
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
