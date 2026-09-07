local NewBattleResultAnimation = class("NewBattleResultAnimation")

function NewBattleResultAnimation:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.bgImage = self._tf:GetComponent(typeof(Image))
	self.paintingTr = self._tf:Find("painting/painting")
	self.mask = self._tf:Find("mask")
	self.items = {}
	self.paintingPosition = Vector2(698, 0)
	self.paintingSizeDelta = Vector2(625, 1080)

	self:Start()

	return
end

function NewBattleResultAnimation:CollectionItems(arg_2_1)
	eachChild(self._tf, function(arg_3_0)
		if arg_3_0 ~= self.mask then
			table.insert(arg_2_1, {
				position = arg_3_0.position,
				tr = arg_3_0
			})
		end

		return
	end)

	return
end

function NewBattleResultAnimation:Start()
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function NewBattleResultAnimation:Play(arg_5_1, arg_5_2)
	self.setUp = true

	setActive(self.mask, true)
	self:CollectionItems(self.items)
	self:MaskItems()
	parallelAsync({
		function(arg_6_0)
			self:ZoomMask(arg_6_0)

			return
		end,
		function(arg_7_0)
			if not arg_5_1 then
				return arg_7_0()
			end

			self:ZoomPainting(arg_5_1, arg_7_0)

			return
		end
	}, function()
		self.setUp = false

		self:RevertItems()
		setActive(self.mask, false)
		self:Clear()
		arg_5_2()

		return
	end)

	return
end

function NewBattleResultAnimation:ZoomPainting(arg_9_1, arg_9_2)
	onNextTick(function()
		if self.exited then
			return
		end

		local var_10_0 = self.paintingTr:Find("fitter")

		var_10_0:GetComponent(typeof(PaintingScaler)).enabled = false

		local var_10_1 = var_10_0:GetChild(0)

		self:SetPivot(var_10_1, arg_9_1.pivot)
		LeanTween.value(var_10_1.gameObject, Vector2(var_10_1.position.x, var_10_1.position.y), arg_9_1.position, 0.2):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_11_0)
			var_10_1.position = Vector3(arg_11_0.x, arg_11_0.y, 0)
			var_10_1.localPosition = Vector3(var_10_1.localPosition.x, var_10_1.localPosition.y, 0)

			return
		end))
		LeanTween.value(var_10_1.gameObject, Vector2(var_10_1.localScale.x, var_10_1.localScale.y), arg_9_1.scale, 0.2):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_12_0)
			var_10_1.localScale = Vector3(arg_12_0.x, arg_12_0.y, 1)

			return
		end)):setOnComplete(System.Action(arg_9_2))

		return
	end)

	return
end

function NewBattleResultAnimation:SetPivot(arg_13_1, arg_13_2)
	arg_13_1.pivot = arg_13_2
	arg_13_1.localPosition = arg_13_1.localPosition - Vector3((arg_13_1.pivot - arg_13_2).x * arg_13_1.rect.size.x, (arg_13_1.pivot - arg_13_2).y * arg_13_1.rect.size.y)

	return
end

local function var_0_1(arg_14_0, arg_14_1)
	return arg_14_0:InverseTransformPoint(arg_14_1)
end

function NewBattleResultAnimation:RevertItems()
	for iter_15_0 = #self.items, 1, -1 do
		setParent(self.items[iter_15_0].tr, self._tf, true)

		self.items[iter_15_0].tr.localPosition = var_0_1(self._tf, self.items[iter_15_0].position)
	end

	return
end

function NewBattleResultAnimation:ZoomMask(arg_16_1)
	LeanTween.value(self.mask.gameObject, Vector2(418, 936), Vector2(4180, 2000), 0.4):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_17_0)
		self.mask.sizeDelta = arg_17_0

		return
	end)):setOnComplete(System.Action(arg_16_1))

	return
end

function NewBattleResultAnimation:MaskItems()
	for iter_18_0 = #self.items, 1, -1 do
		setParent(self.items[iter_18_0].tr, self.mask, true)
	end

	return
end

function NewBattleResultAnimation:Update()
	if self.setUp then
		self:SynItemsPosition()
	end

	return
end

function NewBattleResultAnimation:SynItemsPosition()
	for iter_20_0, iter_20_1 in ipairs(self.items) do
		iter_20_1.tr.localPosition = var_0_1(self.mask, iter_20_1.position)
	end

	return
end

function NewBattleResultAnimation:Clear()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	if LeanTween.isTweening(self.mask.gameObject) then
		LeanTween.cancel(self.mask.gameObject)
	end

	if LeanTween.isTweening(self.paintingTr.gameObject) then
		LeanTween.cancel(self.paintingTr.gameObject)
	end

	return
end

function NewBattleResultAnimation:Dispose()
	self.exited = true

	self:Clear()

	return
end

return NewBattleResultAnimation
