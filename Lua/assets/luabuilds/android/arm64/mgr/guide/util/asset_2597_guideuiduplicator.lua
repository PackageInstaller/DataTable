local GuideUIDuplicator = class("GuideUIDuplicator")

function GuideUIDuplicator:Ctor(arg_1_1)
	self.caches = {}
	self.root = arg_1_1

	return
end

function GuideUIDuplicator:Duplicate(arg_2_1, arg_2_2)
	local var_2_0 = Object.Instantiate(arg_2_1, self.root).transform

	setActive(var_2_0, true)
	self:InitDuplication(var_2_0, arg_2_1, arg_2_2)

	if arg_2_2 then
		self:UpdateSettings(var_2_0, arg_2_1, arg_2_2)
	end

	table.insert(self.caches, var_2_0)

	return var_2_0
end

local function var_0_1(arg_3_0)
	return arg_3_0:GetComponent(typeof(Button)) ~= nil or arg_3_0:GetComponent(typeof(Toggle)) ~= nil or arg_3_0:GetComponent(typeof(EventTriggerListener)) ~= nil
end

local function var_0_2(arg_4_0)
	local var_4_0 = arg_4_0:GetComponent(typeof(Button))

	for iter_4_0, iter_4_1 in ipairs((arg_4_0:GetComponentsInChildren(typeof(Button)):ToTable())) do
		if var_4_0 ~= iter_4_1 then
			iter_4_1.enabled = false
		end
	end

	local var_4_1 = arg_4_0:GetComponent(typeof(Toggle))

	for iter_4_2, iter_4_3 in ipairs((arg_4_0:GetComponentsInChildren(typeof(Toggle)):ToTable())) do
		if var_4_1 ~= iter_4_3 then
			iter_4_3.enabled = false
		end
	end

	if var_4_1 then
		setToggleEnabled(arg_4_0, true)
	end

	return
end

local function var_0_3(arg_5_0)
	if LeanTween.isTweening(arg_5_0.gameObject) then
		LeanTween.cancel(arg_5_0.gameObject)
	end

	eachChild(arg_5_0, function(arg_6_0)
		if LeanTween.isTweening(arg_6_0.gameObject) then
			LeanTween.cancel(arg_6_0.gameObject)
		end

		return
	end)

	return
end

local function var_0_4(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs({
		Animator,
		Animation
	}) do
		for iter_7_2, iter_7_3 in ipairs((arg_7_0:GetComponentsInChildren(typeof(iter_7_1)):ToTable())) do
			iter_7_3.enabled = false
		end
	end

	return
end

function GuideUIDuplicator:InitDuplication(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1:GetComponent(typeof(CanvasGroup))

	if var_8_0 then
		var_8_0.alpha = 1
	end

	local var_8_1 = arg_8_1:GetComponentInChildren(typeof(UnityEngine.UI.Graphic))

	if arg_8_1:GetComponentInChildren(typeof(Canvas)) or var_8_1 == nil then
		GetOrAddComponent(arg_8_1, typeof(Image)).color = Color.New(1, 1, 1, 0)
	end

	if var_8_1 and var_8_1.raycastTarget == false then
		var_8_1.raycastTarget = true
	end

	var_0_4(arg_8_1)

	if var_0_1(arg_8_1) or arg_8_3.clearChildEvent then
		var_0_2(arg_8_1)
	end

	var_0_3(arg_8_1)

	if not arg_8_3.keepScrollTxt then
		for iter_8_0, iter_8_1 in ipairs((arg_8_1:GetComponentsInChildren(typeof(ScrollText)):ToTable())) do
			setActive(iter_8_1.gameObject, false)
		end
	end

	if arg_8_1:GetComponent(typeof(Canvas)) and arg_8_1:GetComponent(typeof(GraphicRaycaster)) == nil then
		GetOrAddComponent(arg_8_1, typeof(GraphicRaycaster))
	end

	arg_8_1.anchorMax = arg_8_1.pivot
	arg_8_1.anchorMin = arg_8_1.pivot
	arg_8_1.sizeDelta = arg_8_2.rect.size

	return
end

function GuideUIDuplicator:UpdateSettings(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.customPosition then
		self:SetCustomPosition(arg_9_1, arg_9_2, arg_9_3)
	else
		self:Syn(arg_9_1, arg_9_2, arg_9_3)
	end

	if arg_9_3.clearAllEvent then
		GetOrAddComponent(arg_9_1, typeof(CanvasGroup)).blocksRaycasts = false
	end

	return
end

function GuideUIDuplicator:SetCustomPosition(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.pos then
		arg_10_1.localPosition = Vector3(arg_10_3.pos.x, arg_10_3.pos.y, arg_10_3.pos.z or 0)
	elseif arg_10_3.isLevelPoint then
		arg_10_1.localPosition = LuaHelper.ScreenToLocal(self.root, pg.UIMgr.GetInstance().levelCameraComp:WorldToScreenPoint((arg_10_2.transform.parent:TransformPoint(arg_10_2.transform.localPosition))), pg.UIMgr.GetInstance().overlayCameraComp)
	else
		arg_10_1.position = arg_10_2.transform.position
		arg_10_1.localPosition = Vector3(arg_10_1.localPosition.x, arg_10_1.localPosition.y, 0)
	end

	local var_10_1 = arg_10_3.scale or 1

	arg_10_1.localScale = Vector3(var_10_1, var_10_1, var_10_1)
	arg_10_1.eulerAngles = arg_10_3.eulerAngles and Vector3(arg_10_3.eulerAngles[1], arg_10_3.eulerAngles[2], arg_10_3.eulerAngles[3]) or Vector3(0, 0, 0)

	return
end

local function var_0_5(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.root:InverseTransformPoint(arg_11_2.transform.position)

	arg_11_1.localPosition = Vector3(var_11_0.x, var_11_0.y, 0)
	arg_11_1.localScale = Vector3(arg_11_2.transform.localScale.x, arg_11_2.transform.localScale.y, arg_11_2.transform.localScale.z)

	return
end

local function var_0_6(arg_12_0, arg_12_1, arg_12_2)
	local var_12_1
	local var_12_2 = arg_12_2.image.isChild and arg_12_1:Find(arg_12_2.image.source) or GameObject.Find(arg_12_2.image.source)

	var_12_1 = arg_12_2.image.isRelative and (arg_12_2.image.target == "" and arg_12_0 or arg_12_0:Find(arg_12_2.image.target)) or GameObject.Find(arg_12_2.image.target)

	if IsNil(var_12_2) or IsNil(var_12_1) then
		return
	end

	local var_12_3 = var_12_2:GetComponent(typeof(Image))
	local var_12_4 = var_12_1:GetComponent(typeof(Image))

	if not var_12_3 or not var_12_4 then
		return
	end

	local var_12_5 = var_12_3.sprite

	if var_12_3.sprite and var_12_4.sprite and var_12_5 ~= var_12_4.sprite then
		var_12_4.enabled = var_12_3.enabled

		setImageSprite(var_12_1, var_12_5)
	end

	return
end

function GuideUIDuplicator:Syn(arg_13_1, arg_13_2, arg_13_3)
	self:RemoveTimer()

	self.timer = Timer.New(function()
		var_0_5(self, arg_13_1, arg_13_2, arg_13_3)

		if arg_13_3.image then
			var_0_6(arg_13_1, arg_13_2, arg_13_3)
		end

		return
	end, 0.01, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function GuideUIDuplicator:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function GuideUIDuplicator:Clear()
	if self.caches and #self.caches > 0 then
		for iter_16_0, iter_16_1 in ipairs(self.caches) do
			Object.Destroy(iter_16_1.gameObject)
		end

		self.caches = {}
	end

	self:RemoveTimer()

	return
end

return GuideUIDuplicator
