local GuideShowSignPlayer = class("GuideShowSignPlayer", import(".GuidePlayer"))

function GuideShowSignPlayer:Ctor(arg_1_1)
	GuideShowSignPlayer.super.Ctor(self, arg_1_1)

	self.signTrs = {}

	return
end

function GuideShowSignPlayer:OnExecution(arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			self:loadSigns(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			self:InitSign(arg_2_1, arg_4_0)

			return
		end
	}, arg_2_2)

	return
end

function GuideShowSignPlayer:loadSigns(arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs((arg_5_1:GetSignList())) do
		table.insert(var_5_0, function(arg_6_0)
			self:LoadSignRes(iter_5_1, function(arg_7_0)
				table.insert(self.signTrs, arg_7_0)
				arg_6_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_5_0, arg_5_2)

	return
end

function GuideShowSignPlayer:LoadSignRes(arg_8_1, arg_8_2)
	self.uiLoader:Load(arg_8_1.signName, function(arg_9_0)
		if arg_8_1.atlasName and arg_8_1.fileName then
			setImageSprite(findTF(arg_9_0, "shadow"), LoadSprite(arg_8_1.atlasName, arg_8_1.fileName), true)
		end

		arg_9_0.localPosition = arg_8_1.pos
		arg_9_0.eulerAngles = Vector3(0, 0, 0)
		arg_9_0.localScale = Vector3.one

		setActive(arg_9_0, true)

		if arg_8_2 then
			arg_8_2(arg_9_0)
		end

		return
	end)

	return
end

function GuideShowSignPlayer:InitSign(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetSignType()

	if var_10_0 == GuideShowSignStep.SIGN_TYPE_2 then
		self:UpdateSign2(arg_10_1, arg_10_2)
	elseif var_10_0 == GuideShowSignStep.SIGN_TYPE_3 then
		self:UpdateSign3(arg_10_1, arg_10_2)
	else
		self:UpdateCommonSign(arg_10_1, arg_10_2)
	end

	return
end

function GuideShowSignPlayer:UpdateSign2(arg_11_1, arg_11_2)
	local var_11_0 = self.signTrs[1]
	local var_11_1 = findTF(self.signTrs[1], "btn")

	if arg_11_1:ShouldClick() then
		setActive(self.signTrs[1], false)

		local var_11_2 = arg_11_1:GetClickData()

		self:SearchUI(var_11_2, function(arg_12_0)
			if IsNil(arg_12_0) then
				pg.NewGuideMgr.GetInstance():Stop()

				return
			end

			var_11_0.localPosition = var_11_0.parent:InverseTransformPoint(arg_12_0.position) - Vector3(arg_12_0.sizeDelta.x * (arg_12_0.pivot.x - 0.5), arg_12_0.sizeDelta.y * (arg_12_0.pivot.y - 0.5), 0)
			var_11_1.sizeDelta = arg_12_0.sizeDelta + var_11_2.sizeDeltaPlus

			setActive(var_11_0, true)

			return
		end)
	elseif arg_11_1:ExistClickArea() then
		var_11_1.sizeDelta = arg_11_1:GetClickArea()
	end

	local var_11_3 = GetOrAddComponent(var_11_1, typeof(UILongPressTrigger))

	var_11_3.onLongPressed:RemoveAllListeners()
	var_11_3.onReleased:RemoveAllListeners()

	if arg_11_1:GetTriggerType() == 1 then
		var_11_3.onLongPressed:AddListener(arg_11_2)
	else
		var_11_3.onReleased:AddListener(arg_11_2)
	end

	return
end

function GuideShowSignPlayer:UpdateSign3(arg_13_1, arg_13_2)
	self.signTrs[1].sizeDelta = arg_13_1:GetClickArea()

	arg_13_2()

	return
end

function GuideShowSignPlayer:UpdateCommonSign(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:GetExitDelay()

	if var_14_0 <= 0 then
		arg_14_2()
	else
		Timer.New(arg_14_2, var_14_0, 1):Start()
	end

	return
end

function GuideShowSignPlayer:OnClear()
	self.signTrs = {}

	return
end

return GuideShowSignPlayer
