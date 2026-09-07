local GuideFindUIPlayer = class("GuideFindUIPlayer", import(".GuidePlayer"))

function GuideFindUIPlayer:Ctor(arg_1_1)
	GuideFindUIPlayer.super.Ctor(self, arg_1_1)

	self.topContainer = arg_1_1:Find("top")
	self.fingerTF = arg_1_1:Find("top/finger")
	self.fingerXyz = self.fingerTF:Find("Xyz")
	self.fingerAnim = self.fingerXyz:GetComponent(typeof(Animator))

	return
end

function GuideFindUIPlayer:OnExecution(arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			self:DuplicateNode(arg_2_1, arg_3_0)

			return
		end
	}, arg_2_2)

	return
end

function GuideFindUIPlayer:DuplicateNode(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:GetEventUI()

	self:ClearFingerTimer()
	self:SearchUI(var_4_0, function(arg_5_0)
		if not arg_5_0 and var_4_0.notfoundSkip then
			arg_4_2()

			return
		end

		local var_5_0

		if not arg_5_0 then
			pg.NewGuideMgr.GetInstance():Stop()

			do return end

			var_5_0 = arg_5_0
		end

		local var_5_1 = self.uiDuplicator:Duplicate(arg_5_0, var_4_0.settings)

		if var_4_0.childIndex then
			var_5_0 = var_5_0:GetChild(var_4_0.childIndex)
			var_5_1 = var_5_1:GetChild(var_4_0.childIndex)
		elseif var_4_0.eventPath then
			var_5_0 = GameObject.Find(var_4_0.eventPath) or arg_5_0
		end

		self.fingerTimer = Timer.New(function()
			self:UpdateFinger(var_5_1, var_4_0)

			return
		end, 0.05, -1)

		self.fingerTimer:Start()
		self.fingerTimer:func()

		self.eventTrigger = GuideEventTrigger.New(var_4_0.triggerData.type, var_5_1, var_5_0, var_4_0.triggerData.arg, arg_4_2)

		return
	end)

	return
end

function GuideFindUIPlayer:NextOne()
	if self.eventTrigger then
		self.eventTrigger:Trigger()
	end

	return
end

function GuideFindUIPlayer:UpdateFinger(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.pivot - Vector2(0.5, 0.5)
	local var_8_1 = Vector2(arg_8_1.sizeDelta.x * var_8_0.x, arg_8_1.sizeDelta.y * var_8_0.y)

	SetActive(self.fingerTF, not arg_8_2.fingerPos or not arg_8_2.fingerPos.hideFinger)

	local var_8_2 = Vector2(arg_8_1.sizeDelta.x / 2, -arg_8_1.sizeDelta.y / 2) - var_8_1
	local var_8_3

	if arg_8_2.scale then
		var_8_3 = 1 / arg_8_2.scale or 1
	end

	self.fingerTF.localScale = Vector3(var_8_3, var_8_3, 1)

	local var_8_4 = arg_8_2.fingerPos and Vector3(arg_8_2.fingerPos.posX, arg_8_2.fingerPos.posY, 0) or Vector3(var_8_2.x, var_8_2.y, 0)
	local var_8_5 = Vector3(0, 0, 0)

	if arg_8_2.fingerPos then
		var_8_5 = Vector3(arg_8_2.fingerPos.rotateX or 0, arg_8_2.fingerPos.rotateY or 0, arg_8_2.fingerPos.rotateZ or 0)
	end

	self.fingerTF.localPosition = self.topContainer:InverseTransformPoint((arg_8_1.parent:TransformPoint(arg_8_1.localPosition + var_8_4)))
	self.fingerTF.localEulerAngles = var_8_5

	if arg_8_2.slipAnim and not LeanTween.isTweening(self.fingerXyz.gameObject) then
		self.fingerAnim.enabled = false

		LeanTween.value(self.fingerXyz.gameObject, 0, -200, 1):setOnUpdate(System.Action_float(function(arg_9_0)
			self.fingerXyz.localPosition = Vector3(arg_9_0, 0, 0)

			return
		end)):setRepeat(-1)
	elseif not arg_8_2.slipAnim and LeanTween.isTweening(self.fingerXyz.gameObject) then
		LeanTween.cancel(self.fingerXyz.gameObject)
	else
		self.fingerXyz.localPosition = Vector3.zero
	end

	return
end

function GuideFindUIPlayer:ClearFingerTimer()
	if self.fingerTimer then
		self.fingerTimer:Stop()

		self.fingerTimer = nil
	end

	return
end

function GuideFindUIPlayer:OnClear()
	if self.eventTrigger then
		self.eventTrigger:Clear()

		self.eventTrigger = nil
	end

	setActive(self.fingerTF, false)

	self.fingerTF.localScale = Vector3(1, 1, 1)

	self:ClearFingerTimer()
	LeanTween.cancel(self.fingerXyz.gameObject)

	self.fingerXyz.localPosition = Vector3.zero
	self.fingerAnim.enabled = true

	return
end

return GuideFindUIPlayer
