local var_0_0 = class("TweenDelegate")
local var_0_1 = import("game.tools.GameObjectTools")
local var_0_2 = require("cjson")
local var_0_3 = {
	listShow = 5,
	value = 6,
	hide = 4,
	rotate = 7,
	alpha = 3,
	pivot = 8,
	scale = 1,
	move = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.tweenManager_ = arg_1_1
	arg_1_0.transform_ = arg_1_2

	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.tweenManager_.luaPlayFuc = LuaHelper.StringAction(function(arg_3_0)
		arg_2_0:Play(arg_3_0, arg_2_0.extraData_)
	end)
end

function var_0_0.Play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0.tweenManager_ or not arg_4_1 or arg_4_1 == "" then
		return
	end

	local var_4_0

	for iter_4_0 = 0, arg_4_0.tweenManager_.tweenS.Count - 1 do
		if arg_4_0.tweenManager_.tweenS[iter_4_0].name == arg_4_1 then
			var_4_0 = arg_4_0.tweenManager_.tweenS[iter_4_0].tweenJson
		end
	end

	if not var_4_0 then
		return
	end

	if arg_4_0.timerTmp_ then
		for iter_4_1, iter_4_2 in ipairs(arg_4_0.timerTmp_) do
			iter_4_2:Stop()
		end
	end

	arg_4_0.timerTmp_ = {}

	if arg_4_0.childTween_ then
		for iter_4_3, iter_4_4 in ipairs(arg_4_0.childTween_) do
			iter_4_4:Dispose()
		end
	end

	arg_4_0.childTween_ = {}

	local var_4_1 = var_0_2.decode(var_4_0) or {}
	local var_4_2 = #var_4_1

	for iter_4_5 = 1, var_4_2 do
		if arg_4_3 then
			var_4_1[iter_4_5].delay = var_4_1[iter_4_5].delay + arg_4_3
		end

		if arg_4_2 and arg_4_2[iter_4_5] then
			arg_4_0:PlayTween(var_4_1[iter_4_5], arg_4_2[iter_4_5])
		else
			arg_4_0:PlayTween(var_4_1[iter_4_5])
		end
	end
end

function var_0_0.PlayTween(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1.type == var_0_3.scale then
		arg_5_0:PlayScale(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.move then
		arg_5_0:PlayMove(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.alpha then
		arg_5_0:PlayAlpha(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.hide then
		arg_5_0:PlayHide(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.listShow then
		arg_5_0:PlayListShow(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.value then
		arg_5_0:PlayValue(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.rotate then
		arg_5_0:PlayRotate(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.pivot then
		arg_5_0:PlayPivot(arg_5_1, arg_5_2)
	end
end

function var_0_0.PlayScale(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.transform_:Find(arg_6_1.go).gameObject

	if arg_6_1.isInitFrom == 1 then
		local var_6_1 = var_6_0.transform

		LuaHelper.SetTfLoalScaleValue(var_6_1, arg_6_1.fromData.x, arg_6_1.fromData.y, arg_6_1.fromData.z)
	end

	local var_6_2 = LeanTween.scale(var_6_0, Vector3(arg_6_1.toData.x, arg_6_1.toData.y, arg_6_1.toData.z), arg_6_1.time):setEase(LeanTweenType.IntToEnum(arg_6_1.easeType)):setDelay(arg_6_1.delay)

	if arg_6_2 and arg_6_2.onComplete then
		var_6_2:setOnComplete(LuaHelper.VoidAction(function()
			arg_6_2.onComplete()
		end))
	end
end

function var_0_0.PlayMove(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.transform_:Find(arg_8_1.go).gameObject

	if arg_8_1.isInitFrom == 1 then
		local var_8_1 = var_8_0.transform
		local var_8_2 = var_0_1.GetAdaptedLocalPosition(var_8_0, arg_8_1.fromData)

		LuaHelper.SetTfLocalPosValue(var_8_1, var_8_2.x, var_8_2.y, var_8_2.z)
	end

	local var_8_3 = var_0_1.GetAdaptedLocalPosition(var_8_0, arg_8_1.toData)
	local var_8_4 = LeanTween.moveLocal(var_8_0, var_8_3, arg_8_1.time):setEase(LeanTweenType.IntToEnum(arg_8_1.easeType)):setDelay(arg_8_1.delay)

	if arg_8_2 and arg_8_2.onComplete then
		var_8_4:setOnComplete(LuaHelper.VoidAction(function()
			arg_8_2.onComplete()
		end))
	end
end

function var_0_0.PlayAlpha(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if type(arg_10_1.go) == "string" then
		var_10_0 = arg_10_0.transform_:Find(arg_10_1.go).gameObject
	else
		var_10_0 = arg_10_1.go
	end

	local var_10_1 = var_0_1.GetOrAddComponent(var_10_0, typeof(CanvasGroup))

	if arg_10_1.isInitFrom == 1 then
		LeanTween.alphaCanvas(var_10_1, arg_10_1.fromData.x, 0)
	end

	local var_10_2 = LeanTween.alphaCanvas(var_10_1, arg_10_1.toData.x, arg_10_1.time):setEase(LeanTweenType.IntToEnum(arg_10_1.easeType)):setDelay(arg_10_1.delay)

	if arg_10_2 and arg_10_2.onComplete then
		var_10_2:setOnComplete(LuaHelper.VoidAction(function()
			arg_10_2.onComplete()
		end))
	end
end

function var_0_0.PlayHide(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.transform_:Find(arg_12_1.go).gameObject

	LeanTween.delayedCall(arg_12_1.delay, System.Action(function()
		SetActive(var_12_0, false)
	end))

	local var_12_1 = LeanTween.delayedCall(arg_12_1.delay + arg_12_1.time, LuaHelper.VoidAction(function()
		SetActive(var_12_0, true)
	end))

	if arg_12_2 and arg_12_2.onComplete then
		var_12_1:setOnComplete(LuaHelper.VoidAction(function()
			arg_12_2.onComplete()
		end))
	end
end

function var_0_0.PlayListShow(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0
	local var_16_1 = arg_16_0.transform_:Find(arg_16_1.go)
	local var_16_2 = var_16_1.childCount

	for iter_16_0 = 1, var_16_2 do
		local var_16_3 = var_16_1:GetChild(var_16_0)
		local var_16_4 = var_16_3.gameObject:GetComponent("TweenManager")

		if var_16_4 ~= nil then
			local var_16_5 = TweenDelegate.New(var_16_4, var_16_3)
			local var_16_6 = arg_16_1.delay + var_16_0 * arg_16_1.toData.x

			if arg_16_1.fromData.x == 0 then
				var_16_5:Play("ItemShow", nil, var_16_6)
			else
				var_16_5:Play(tostring(arg_16_1.fromData.x), nil, var_16_6)
			end

			table.insert(arg_16_0.childTween_, var_16_5)
		end

		var_16_0 = var_16_0 + 1
	end

	if arg_16_2 and arg_16_2.onComplete then
		local var_16_7 = arg_16_1.delay + arg_16_1.time
		local var_16_8 = Timer.New(function()
			arg_16_2.onComplete()
		end, var_16_7, 1)

		var_16_8:Start()
		table.insert(arg_16_0.timerTmp_, var_16_8)
	end
end

function var_0_0.PlayValue(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.toData.x

	if arg_18_2 then
		local var_18_1 = arg_18_2

		LeanTween.value(var_18_1.fromData, var_18_1.toData, arg_18_1.time).setEase(LeanTweenType.IntToEnum(arg_18_1.easeType)).setDelay(arg_18_1.delay).setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
			var_18_1.onUpdate(arg_19_0)
		end))
	end
end

function var_0_0.PlayRotate(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.transform_:Find(arg_20_1.go).gameObject

	if arg_20_1.isInitFrom == 1 then
		local var_20_1 = var_20_0.transform

		LuaHelper.SetTfLocalRotateValue(var_20_1, arg_20_1.fromData.x, arg_20_1.fromData.y, arg_20_1.fromData.z)
	end

	local var_20_2 = LeanTween.rotateLocal(var_20_0, Vector3(arg_20_1.toData.x, arg_20_1.toData.y, arg_20_1.toData.z), arg_20_1.time):setEase(LeanTweenType.IntToEnum(arg_20_1.easeType)):setDelay(arg_20_1.delay)

	if arg_20_2 and arg_20_2.onComplete then
		var_20_2:setOnComplete(LuaHelper.VoidAction(function()
			arg_20_2.onComplete()
		end))
	end
end

function var_0_0.PlayPivot(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.transform_:Find(arg_22_1.go).gameObject:GetComponent("RectTransform")
	local var_22_1 = Timer.New(function()
		if var_22_0 then
			local var_23_0 = Vector2(var_22_0.pivot.x, var_22_0.pivot.y)
			local var_23_1 = arg_22_1.toData.x - var_22_0.pivot.x
			local var_23_2 = arg_22_1.toData.y - var_22_0.pivot.y
			local var_23_3 = var_22_0.sizeDelta
			local var_23_4 = var_23_1 * var_22_0.sizeDelta.x * math.cos(math.rad(var_22_0.localEulerAngles.z)) + var_23_2 * var_22_0.sizeDelta.y * math.sin(math.rad(var_22_0.localEulerAngles.z))
			local var_23_5 = var_23_2 * var_22_0.sizeDelta.y * math.cos(math.rad(var_22_0.localEulerAngles.z)) + var_23_1 * var_22_0.sizeDelta.x * math.sin(math.rad(var_22_0.localEulerAngles.z))

			var_22_0.pivot = Vector2(arg_22_1.toData.x, arg_22_1.toData.y)
			var_22_0.localPosition = Vector3(var_22_0.localPosition.x + var_23_4, var_22_0.localPosition.y + var_23_5, var_22_0.localPosition.z)
		end
	end, arg_22_1.delay, 1)

	var_22_1:Start()
	table.insert(arg_22_0.timerTmp_, var_22_1)
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.timerTmp_ then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0.timerTmp_) do
			iter_24_1:Stop()
		end
	end

	arg_24_0.timerTmp_ = nil

	if arg_24_0.childTween_ then
		for iter_24_2, iter_24_3 in ipairs(arg_24_0.childTween_) do
			iter_24_3:Dispose()
		end
	end

	arg_24_0.childTween_ = nil
end

return var_0_0
