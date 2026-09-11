local TweenDelegate = class("TweenDelegate")
local GameObjectTools = import("game.tools.GameObjectTools")
local cjson = require("cjson")
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

function TweenDelegate:Ctor(arg_1_1, arg_1_2)
	self.tweenManager_ = arg_1_1
	self.transform_ = arg_1_2

	self:OnCtor()
end

function TweenDelegate:OnCtor()
	self.tweenManager_.luaPlayFuc = LuaHelper.StringAction(function(arg_3_0)
		self:Play(arg_3_0, self.extraData_)
	end)
end

function TweenDelegate:Play(arg_4_1, arg_4_2, arg_4_3)
	if not self.tweenManager_ or not arg_4_1 or arg_4_1 == "" then
		return
	end

	local var_4_0

	for iter_4_0 = 0, self.tweenManager_.tweenS.Count - 1 do
		if self.tweenManager_.tweenS[iter_4_0].name == arg_4_1 then
			var_4_0 = self.tweenManager_.tweenS[iter_4_0].tweenJson
		end
	end

	if not var_4_0 then
		return
	end

	if self.timerTmp_ then
		for iter_4_1, iter_4_2 in ipairs(self.timerTmp_) do
			iter_4_2:Stop()
		end
	end

	self.timerTmp_ = {}

	if self.childTween_ then
		for iter_4_3, iter_4_4 in ipairs(self.childTween_) do
			iter_4_4:Dispose()
		end
	end

	self.childTween_ = {}

	local var_4_1 = cjson.decode(var_4_0) or {}

	for iter_4_5 = 1, #var_4_1 do
		if arg_4_3 then
			var_4_1[iter_4_5].delay = var_4_1[iter_4_5].delay + arg_4_3
		end

		if arg_4_2 and arg_4_2[iter_4_5] then
			self:PlayTween(var_4_1[iter_4_5], arg_4_2[iter_4_5])
		else
			self:PlayTween(var_4_1[iter_4_5])
		end
	end
end

function TweenDelegate:PlayTween(arg_5_1, arg_5_2)
	if arg_5_1.type == var_0_3.scale then
		self:PlayScale(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.move then
		self:PlayMove(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.alpha then
		self:PlayAlpha(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.hide then
		self:PlayHide(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.listShow then
		self:PlayListShow(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.value then
		self:PlayValue(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.rotate then
		self:PlayRotate(arg_5_1, arg_5_2)
	elseif arg_5_1.type == var_0_3.pivot then
		self:PlayPivot(arg_5_1, arg_5_2)
	end
end

function TweenDelegate:PlayScale(arg_6_1, arg_6_2)
	local var_6_0 = self.transform_:Find(arg_6_1.go).gameObject

	if arg_6_1.isInitFrom == 1 then
		LuaHelper.SetTfLoalScaleValue(var_6_0.transform, arg_6_1.fromData.x, arg_6_1.fromData.y, arg_6_1.fromData.z)
	end

	if arg_6_2 and arg_6_2.onComplete then
		LeanTween.scale(var_6_0, Vector3(arg_6_1.toData.x, arg_6_1.toData.y, arg_6_1.toData.z), arg_6_1.time):setEase(LeanTweenType.IntToEnum(arg_6_1.easeType)):setDelay(arg_6_1.delay):setOnComplete(LuaHelper.VoidAction(function()
			arg_6_2.onComplete()
		end))
	end
end

function TweenDelegate:PlayMove(arg_8_1, arg_8_2)
	local var_8_0 = self.transform_:Find(arg_8_1.go).gameObject

	if arg_8_1.isInitFrom == 1 then
		local var_8_1 = GameObjectTools.GetAdaptedLocalPosition(var_8_0, arg_8_1.fromData)

		LuaHelper.SetTfLocalPosValue(var_8_0.transform, var_8_1.x, var_8_1.y, var_8_1.z)
	end

	if arg_8_2 and arg_8_2.onComplete then
		LeanTween.moveLocal(var_8_0, GameObjectTools.GetAdaptedLocalPosition(var_8_0, arg_8_1.toData), arg_8_1.time):setEase(LeanTweenType.IntToEnum(arg_8_1.easeType)):setDelay(arg_8_1.delay):setOnComplete(LuaHelper.VoidAction(function()
			arg_8_2.onComplete()
		end))
	end
end

function TweenDelegate:PlayAlpha(arg_10_1, arg_10_2)
	local var_10_1 = GameObjectTools.GetOrAddComponent(type(arg_10_1.go) == "string" and self.transform_:Find(arg_10_1.go).gameObject or arg_10_1.go, typeof(CanvasGroup))

	if arg_10_1.isInitFrom == 1 then
		LeanTween.alphaCanvas(var_10_1, arg_10_1.fromData.x, 0)
	end

	if arg_10_2 and arg_10_2.onComplete then
		LeanTween.alphaCanvas(var_10_1, arg_10_1.toData.x, arg_10_1.time):setEase(LeanTweenType.IntToEnum(arg_10_1.easeType)):setDelay(arg_10_1.delay):setOnComplete(LuaHelper.VoidAction(function()
			arg_10_2.onComplete()
		end))
	end
end

function TweenDelegate:PlayHide(arg_12_1, arg_12_2)
	local var_12_0 = self.transform_:Find(arg_12_1.go).gameObject

	LeanTween.delayedCall(arg_12_1.delay, System.Action(function()
		SetActive(var_12_0, false)
	end))

	if arg_12_2 and arg_12_2.onComplete then
		LeanTween.delayedCall(arg_12_1.delay + arg_12_1.time, LuaHelper.VoidAction(function()
			SetActive(var_12_0, true)
		end)):setOnComplete(LuaHelper.VoidAction(function()
			arg_12_2.onComplete()
		end))
	end
end

function TweenDelegate:PlayListShow(arg_16_1, arg_16_2)
	local var_16_0 = self.transform_:Find(arg_16_1.go)

	for iter_16_0 = 1, var_16_0.childCount do
		local var_16_1 = var_16_0:GetChild(0)
		local var_16_2 = var_16_1.gameObject:GetComponent("TweenManager")

		if var_16_2 ~= nil then
			local var_16_3 = TweenDelegate.New(var_16_2, var_16_1)

			if arg_16_1.fromData.x == 0 then
				var_16_3:Play("ItemShow", nil, arg_16_1.delay + 0 * arg_16_1.toData.x)
			else
				var_16_3:Play(tostring(arg_16_1.fromData.x), nil, arg_16_1.delay + 0 * arg_16_1.toData.x)
			end

			table.insert(self.childTween_, var_16_3)
		end
	end

	if arg_16_2 and arg_16_2.onComplete then
		local var_16_5 = Timer.New(function()
			arg_16_2.onComplete()
		end, arg_16_1.delay + arg_16_1.time, 1)

		var_16_5:Start()
		table.insert(self.timerTmp_, var_16_5)
	end
end

function TweenDelegate:PlayValue(arg_18_1, arg_18_2)
	if arg_18_2 then
		local var_18_1 = arg_18_2

		LeanTween.value(arg_18_2.fromData, arg_18_2.toData, arg_18_1.time).setEase(LeanTweenType.IntToEnum(arg_18_1.easeType)).setDelay(arg_18_1.delay).setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
			var_18_1.onUpdate(arg_19_0)
		end))
	end
end

function TweenDelegate:PlayRotate(arg_20_1, arg_20_2)
	local var_20_0 = self.transform_:Find(arg_20_1.go).gameObject

	if arg_20_1.isInitFrom == 1 then
		LuaHelper.SetTfLocalRotateValue(var_20_0.transform, arg_20_1.fromData.x, arg_20_1.fromData.y, arg_20_1.fromData.z)
	end

	if arg_20_2 and arg_20_2.onComplete then
		LeanTween.rotateLocal(var_20_0, Vector3(arg_20_1.toData.x, arg_20_1.toData.y, arg_20_1.toData.z), arg_20_1.time):setEase(LeanTweenType.IntToEnum(arg_20_1.easeType)):setDelay(arg_20_1.delay):setOnComplete(LuaHelper.VoidAction(function()
			arg_20_2.onComplete()
		end))
	end
end

function TweenDelegate:PlayPivot(arg_22_1, arg_22_2)
	local var_22_0 = self.transform_:Find(arg_22_1.go).gameObject:GetComponent("RectTransform")
	local var_22_1 = Timer.New(function()
		if var_22_0 then
			local var_23_0 = Vector2(var_22_0.pivot.x, var_22_0.pivot.y)

			var_22_0.pivot = Vector2(arg_22_1.toData.x, arg_22_1.toData.y)
			var_22_0.localPosition = Vector3(var_22_0.localPosition.x + ((arg_22_1.toData.x - var_22_0.pivot.x) * var_22_0.sizeDelta.x * math.cos(math.rad(var_22_0.localEulerAngles.z)) + (arg_22_1.toData.y - var_22_0.pivot.y) * var_22_0.sizeDelta.y * math.sin(math.rad(var_22_0.localEulerAngles.z))), var_22_0.localPosition.y + ((arg_22_1.toData.y - var_22_0.pivot.y) * var_22_0.sizeDelta.y * math.cos(math.rad(var_22_0.localEulerAngles.z)) + (arg_22_1.toData.x - var_22_0.pivot.x) * var_22_0.sizeDelta.x * math.sin(math.rad(var_22_0.localEulerAngles.z))), var_22_0.localPosition.z)
		end
	end, arg_22_1.delay, 1)

	var_22_1:Start()
	table.insert(self.timerTmp_, var_22_1)
end

function TweenDelegate:Dispose()
	if self.timerTmp_ then
		for iter_24_0, iter_24_1 in ipairs(self.timerTmp_) do
			iter_24_1:Stop()
		end
	end

	self.timerTmp_ = nil

	if self.childTween_ then
		for iter_24_2, iter_24_3 in ipairs(self.childTween_) do
			iter_24_3:Dispose()
		end
	end

	self.childTween_ = nil
end

return TweenDelegate
