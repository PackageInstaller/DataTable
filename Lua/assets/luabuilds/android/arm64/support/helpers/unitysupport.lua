function tf(arg_1_0)
	return arg_1_0.transform
end

function go(arg_2_0)
	return tf(arg_2_0).gameObject
end

function rtf(arg_3_0)
	return arg_3_0.transform
end

function findGO(arg_4_0, arg_4_1)
	assert(arg_4_0, "object or transform should exist")

	local var_4_0 = tf(arg_4_0):Find(arg_4_1)

	return var_4_0 and var_4_0.gameObject
end

function findTF(arg_5_0, arg_5_1)
	assert(arg_5_0, "object or transform should exist " .. arg_5_1)

	return (tf(arg_5_0):Find(arg_5_1))
end

function Instantiate(arg_6_0, ...)
	return Object.Instantiate(go(arg_6_0), ...)
end

instantiate = Instantiate

function Destroy(arg_7_0)
	Object.Destroy(go(arg_7_0))

	return
end

destroy = Destroy

function SetActive(arg_8_0, arg_8_1)
	if arg_8_0 == nil then
		print("<color=red>SetActive Object is NIL!!!!</color>")

		return
	end

	LuaHelper.SetActiveForLua(arg_8_0, tobool(arg_8_1))

	return
end

setActive = SetActive

function isActive(arg_9_0)
	return go(arg_9_0).activeSelf
end

function SetName(arg_10_0, arg_10_1)
	arg_10_0.name = arg_10_1

	return
end

setName = SetName

function SetParent(arg_11_0, arg_11_1, arg_11_2)
	LuaHelper.SetParentForLua(arg_11_0, arg_11_1, tobool(arg_11_2))

	return
end

setParent = SetParent

function setText(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	arg_12_0:GetComponent(typeof(Text)).text = tostring(arg_12_1)

	return
end

function setTextInNewStyleBox(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	for iter_13_0, iter_13_1 in pairs(pg.NewStyleMsgboxMgr.COLOR_MAP) do
		arg_13_1 = string.gsub(arg_13_1, iter_13_0, iter_13_1)
	end

	arg_13_0:GetComponent(typeof(Text)).text = tostring(arg_13_1)

	return
end

function setScrollText(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_0:GetComponent("ScrollText"):SetText(tostring(arg_14_1))

	return
end

function setTextEN(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	arg_15_1 = splitByWordEN(arg_15_1, arg_15_0)
	arg_15_0:GetComponent(typeof(Text)).text = tostring(arg_15_1)

	return
end

function setBestFitTextEN(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_0:GetComponent(typeof(RectTransform))
	local var_16_1 = arg_16_0:GetComponent(typeof(Text))
	local var_16_2 = arg_16_2 or 20
	local var_16_3 = var_16_0.rect.width

	while var_16_2 > 0 do
		var_16_1.fontSize = var_16_2
		var_16_1.text = tostring((splitByWordEN(arg_16_1, arg_16_0)))

		if var_16_3 >= var_16_1.preferredWidth and var_16_0.rect.height >= var_16_1.preferredHeight then
			break
		end

		var_16_2 = var_16_2 - 1
	end

	return
end

function setTextFont(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	arg_17_0:GetComponent(typeof(Text)).font = arg_17_1

	return
end

function getText(arg_18_0)
	return arg_18_0:GetComponent(typeof(Text)).text
end

function setInputText(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return
	end

	arg_19_0:GetComponent(typeof(InputField)).text = arg_19_1

	return
end

function getInputText(arg_20_0)
	return arg_20_0:GetComponent(typeof(InputField)).text
end

function onInputEndEdit(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:GetComponent(typeof(InputField)).onEndEdit

	pg.DelegateInfo.Add(arg_21_0, var_21_0)
	var_21_0:RemoveAllListeners()
	var_21_0:AddListener(arg_21_2)

	return
end

function activateInputField(arg_22_0)
	arg_22_0:GetComponent(typeof(InputField)):ActivateInputField()

	return
end

function setButtonText(arg_23_0, arg_23_1, arg_23_2)
	setWidgetText(arg_23_0, arg_23_1, arg_23_2)

	return
end

function setWidgetText(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or "Text"
	arg_24_2 = findTF(arg_24_0, arg_24_2)

	setText(arg_24_2, arg_24_1)

	return
end

function setWidgetTextEN(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or "Text"
	arg_25_2 = findTF(arg_25_0, arg_25_2)

	setTextEN(arg_25_2, arg_25_1)

	return
end

local var_0_1 = true
local var_0_2 = -1

function onButton(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = GetOrAddComponent(arg_26_1, typeof(Button))

	assert(var_26_0, "could not found Button component on " .. arg_26_1.name)
	assert(arg_26_2, "callback should exist")
	pg.DelegateInfo.Add(arg_26_0, var_26_0.onClick)
	var_26_0.onClick:RemoveAllListeners()
	var_26_0.onClick:AddListener(function()
		if var_0_2 == Time.frameCount and Input.touchCount > 1 then
			return
		end

		var_0_2 = Time.frameCount

		if arg_26_3 and var_0_1 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_26_3)
		end

		arg_26_2()

		return
	end)

	return
end

function removeOnButton(arg_28_0)
	local var_28_0 = arg_28_0:GetComponent(typeof(Button))

	if var_28_0 ~= nil then
		var_28_0.onClick:RemoveAllListeners()
	end

	return
end

function removeAllOnButton(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs((arg_29_0:GetComponentsInChildren(typeof(Button)):ToTable())) do
		if iter_29_1 ~= nil then
			iter_29_1.onClick:RemoveAllListeners()
		end
	end

	return
end

function ClearAllText(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs((arg_30_0:GetComponentsInChildren(typeof(Text)):ToTable())) do
		if iter_30_1 ~= nil then
			iter_30_1.text = ""
		end
	end

	return
end

function onLongPressTrigger(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = GetOrAddComponent(arg_31_1, typeof(UILongPressTrigger))

	assert(var_31_0, "could not found UILongPressTrigger component on " .. arg_31_1.name)
	assert(arg_31_2, "callback should exist")
	pg.DelegateInfo.Add(arg_31_0, var_31_0.onLongPressed)
	var_31_0.onLongPressed:RemoveAllListeners()
	var_31_0.onLongPressed:AddListener(function()
		if arg_31_3 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_31_3)
		end

		arg_31_2()

		return
	end)

	return
end

function removeOnLongPressTrigger(arg_33_0)
	local var_33_0 = arg_33_0:GetComponent(typeof(UILongPressTrigger))

	if var_33_0 ~= nil then
		var_33_0.onLongPressed:RemoveAllListeners()
	end

	return
end

function setButtonEnabled(arg_34_0, arg_34_1)
	GetComponent(arg_34_0, typeof(Button)).interactable = arg_34_1

	return
end

function setToggleEnabled(arg_35_0, arg_35_1)
	GetComponent(arg_35_0, typeof(Toggle)).interactable = arg_35_1

	return
end

function setSliderEnable(arg_36_0, arg_36_1)
	GetComponent(arg_36_0, typeof(Slider)).interactable = arg_36_1

	return
end

function triggerButton(arg_37_0)
	var_0_1 = false
	var_0_2 = -1

	GetComponent(arg_37_0, typeof(Button)).onClick:Invoke()

	var_0_1 = true

	return
end

local var_0_3 = true

function onToggle(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	local var_38_0 = GetComponent(arg_38_1, typeof(Toggle))

	assert(arg_38_2, "callback should exist")
	var_38_0.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_38_0, var_38_0.onValueChanged)
	var_38_0.onValueChanged:AddListener(function(arg_39_0)
		if var_0_3 then
			if arg_39_0 and arg_38_3 and var_38_0.isOn == arg_39_0 then
				arg_38_3 = SFX_UI_TAG

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_38_3)
			elseif not arg_39_0 and arg_38_4 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_38_4)
			end
		end

		arg_38_2(arg_39_0)

		return
	end)

	local var_38_1 = GetComponent(arg_38_1, typeof(UIToggleEvent))

	if not IsNil(var_38_1) then
		var_38_1:Rebind()
	end

	return
end

function removeOnToggle(arg_40_0)
	local var_40_0 = GetComponent(arg_40_0, typeof(Toggle))

	if var_40_0 ~= nil then
		var_40_0.onValueChanged:RemoveAllListeners()
	end

	return
end

function triggerToggle(arg_41_0, arg_41_1)
	local var_41_0 = GetComponent(arg_41_0, typeof(Toggle))

	var_0_3 = false
	arg_41_1 = tobool(arg_41_1)

	if var_41_0.isOn ~= arg_41_1 then
		var_41_0.isOn = arg_41_1
	else
		var_41_0.onValueChanged:Invoke(arg_41_1)
	end

	var_0_3 = true

	return
end

function triggerToggleWithoutNotify(arg_42_0, arg_42_1)
	var_0_3 = false
	arg_42_1 = tobool(arg_42_1)

	LuaHelper.ChangeToggleValueWithoutNotify(GetComponent(arg_42_0, typeof(Toggle)), arg_42_1)

	var_0_3 = true

	return
end

function onSlider(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = GetComponent(arg_43_1, typeof(Slider)).onValueChanged

	assert(arg_43_2, "callback should exist")
	var_43_0:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_43_0, var_43_0)
	var_43_0:AddListener(arg_43_2)

	return
end

function setSlider(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = GetComponent(arg_44_0, typeof(Slider))

	assert(var_44_0, "slider should exist")

	var_44_0.minValue = arg_44_1
	var_44_0.maxValue = arg_44_2
	var_44_0.value = arg_44_3

	return
end

function eachChild(arg_45_0, arg_45_1)
	local var_45_0 = tf(arg_45_0)

	for iter_45_0 = var_45_0.childCount - 1, 0, -1 do
		arg_45_1(var_45_0:GetChild(iter_45_0), iter_45_0)
	end

	return
end

function removeAllChildren(arg_46_0)
	eachChild(arg_46_0, function(arg_47_0)
		tf(arg_47_0).transform:SetParent(nil, false)
		Destroy(arg_47_0)

		return
	end)

	return
end

function scrollToIndex(arg_48_0, arg_48_1)
	Canvas.ForceUpdateCanvases()

	local var_48_0 = GetComponent(arg_48_0, typeof(ScrollRect))
	local var_48_1 = Vector2(math.max(var_48_0.content.rect.width - var_48_0.viewport.rect.width, 0), math.max(var_48_0.content.rect.height - var_48_0.viewport.rect.height, 0))

	if var_48_1 == Vector2.zero then
		scrollTo(arg_48_0, 0, 0)
	else
		local var_48_2 = var_48_0.content:GetChild(arg_48_1 - 1)

		scrollTo(arg_48_0, math.clamp((var_48_2.rect.x + var_48_2.localPosition.x) / var_48_1.x, 0, 1), math.clamp(1 + (var_48_2.rect.y + var_48_2.rect.height + var_48_2.localPosition.y - (var_48_0.content.rect.y + var_48_0.content.rect.height)) / var_48_1.y, 0, 1))
	end

	return
end

function scrollTo(arg_49_0, arg_49_1, arg_49_2)
	Canvas.ForceUpdateCanvases()

	local var_49_0 = GetComponent(arg_49_0, typeof(ScrollRect))
	local var_49_1 = Vector2(var_49_0.horizontal and arg_49_1 or var_49_0.normalizedPosition.x, var_49_0.vertical and arg_49_2 or var_49_0.normalizedPosition.y)

	onNextTick(function()
		if not IsNil(arg_49_0) then
			var_49_0.normalizedPosition = var_49_1

			var_49_0.onValueChanged:Invoke(var_49_1)
		end

		return
	end)

	return
end

function scrollToBottom(arg_51_0)
	scrollTo(arg_51_0, 0, 0)

	return
end

function onScroll(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = GetComponent(arg_52_1, typeof(ScrollRect)).onValueChanged

	assert(arg_52_2, "callback should exist")
	var_52_0:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_52_0, var_52_0)
	var_52_0:AddListener(arg_52_2)

	return
end

function ClearEventTrigger(arg_53_0)
	arg_53_0:RemovePointClickFunc()
	arg_53_0:RemovePointDownFunc()
	arg_53_0:RemovePointEnterFunc()
	arg_53_0:RemovePointExitFunc()
	arg_53_0:RemovePointUpFunc()
	arg_53_0:RemoveCheckDragFunc()
	arg_53_0:RemoveBeginDragFunc()
	arg_53_0:RemoveDragFunc()
	arg_53_0:RemoveDragEndFunc()
	arg_53_0:RemoveDropFunc()
	arg_53_0:RemoveScrollFunc()
	arg_53_0:RemoveSelectFunc()
	arg_53_0:RemoveUpdateSelectFunc()
	arg_53_0:RemoveMoveFunc()

	return
end

function ClearLScrollrect(arg_54_0)
	if not arg_54_0 then
		return
	end

	arg_54_0.onStart = nil
	arg_54_0.onInitItem = nil
	arg_54_0.onUpdateItem = nil
	arg_54_0.onReturnItem = nil

	return
end

function GetComponent(arg_55_0, arg_55_1)
	return (arg_55_0:GetComponent(arg_55_1))
end

function GetOrAddComponent(arg_56_0, arg_56_1)
	assert(arg_56_0, "objectOrTransform not found: " .. debug.traceback())

	local var_56_0 = arg_56_1

	if type(arg_56_1) == "string" then
		assert(_G[arg_56_1], arg_56_1 .. " not exist in Global")

		var_56_0 = typeof(_G[arg_56_1])
	end

	return LuaHelper.GetOrAddComponentForLua(arg_56_0, var_56_0)
end

function RemoveComponent(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:GetComponent(arg_57_1)

	if var_57_0 then
		Object.Destroy(var_57_0)
	end

	return
end

function SetComponentEnabled(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0:GetComponent(arg_58_1)

	assert(var_58_0, "compoment not found")

	var_58_0.enabled = tobool(arg_58_2)

	return
end

SetCompomentEnabled = SetComponentEnabled

function GetInChildren(arg_59_0, arg_59_1)
	return (function(arg_60_0, arg_60_1)
		if not arg_60_0 then
			return nil
		end

		if arg_60_0.name == arg_60_1 then
			return arg_60_0
		end

		for iter_60_0 = 0, arg_60_0.childCount - 1 do
			local var_60_0 = arg_60_0:GetChild(iter_60_0)

			if arg_60_1 == var_60_0.name then
				return var_60_0
			end

			local var_60_1 = var_0(var_60_0, arg_60_1)

			if var_60_1 then
				return var_60_1
			end
		end

		return nil
	end)(arg_59_0, arg_59_1)
end

function onNextTick(arg_61_0)
	FrameTimer.New(arg_61_0, 1, 1):Start()

	return
end

function onDelayTick(arg_62_0, arg_62_1)
	local var_62_0 = Timer.New(arg_62_0, arg_62_1, 1)

	var_62_0:Start()

	return var_62_0
end

function seriesAsync(arg_63_0, arg_63_1, ...)
	local var_63_0 = 0
	local var_63_1 = #arg_63_0

	;(function(...)
		var_63_0 = var_63_0 + 1

		if var_63_0 <= var_63_1 then
			arg_63_0[var_63_0](var_0, ...)
		elseif var_63_0 == var_63_1 + 1 and arg_63_1 then
			arg_63_1(...)
		end

		return
	end)(...)

	return
end

function seriesAsyncExtend(arg_65_0, arg_65_1, ...)
	(function(...)
		if #arg_65_0 > 0 then
			table.remove(arg_65_0, 1)(var_0, ...)
		elseif arg_65_1 then
			arg_65_1(...)
		end

		return
	end)(...)

	return
end

function parallelAsync(arg_67_0, arg_67_1)
	if #arg_67_0 > 0 then
		for iter_67_0, iter_67_1 in ipairs(arg_67_0) do
			iter_67_1(function()
				var_0 = var_0 - 1

				if var_0 == 0 and arg_67_1 then
					arg_67_1()
				end

				return
			end)
		end
	elseif arg_67_1 then
		arg_67_1()
	end

	return
end

function limitedParallelAsync(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = #arg_69_0
	local var_69_1, var_69_2

	if #arg_69_0 == 0 then
		arg_69_2()

		do return end

		var_69_1 = nil

		function var_69_2()
			var_0 = var_0 - 1

			if var_0 == 0 then
				arg_69_2()
			elseif var_0 + 1 <= var_69_0 then
				var_0 = var_0 + 1

				arg_69_0[var_0](var_69_2)
			end

			return
		end
	end

	for iter_69_0 = 1, math.min(arg_69_1, #arg_69_0) do
		arg_69_0[iter_69_0](function()
			var_0 = var_0 - 1

			if var_0 == 0 then
				arg_69_2()
			elseif var_0 + 1 <= var_69_0 then
				var_0 = var_0 + 1

				arg_69_0[var_0](var_69_2)
			end

			return
		end)
	end

	return
end

function waitUntil(arg_71_0, arg_71_1)
	local var_71_0

	var_71_0 = FrameTimer.New(function()
		if arg_71_0() then
			arg_71_1()
			var_71_0:Stop()

			return
		end

		return
	end, 1, -1)

	;(nil):Start()

	return var_71_0
end

function setImageSprite(arg_73_0, arg_73_1, arg_73_2)
	if IsNil(arg_73_0) then
		assert(false)

		return
	end

	local var_73_0 = GetComponent(arg_73_0, typeof(Image))

	if IsNil(var_73_0) then
		return
	end

	var_73_0.sprite = arg_73_1

	if arg_73_2 then
		var_73_0:SetNativeSize()
	end

	return
end

function clearImageSprite(arg_74_0)
	GetComponent(arg_74_0, typeof(Image)).sprite = nil

	return
end

function getImageSprite(arg_75_0)
	local var_75_0 = GetComponent(arg_75_0, typeof(Image))

	return var_75_0 and var_75_0.sprite
end

function tex2sprite(arg_76_0)
	return UnityEngine.Sprite.Create(arg_76_0, UnityEngine.Rect.New(0, 0, arg_76_0.width, arg_76_0.height), Vector2(0.5, 0.5), 100)
end

function setFillAmount(arg_77_0, arg_77_1)
	GetComponent(arg_77_0, typeof(Image)).fillAmount = arg_77_1

	return
end

function string2vector3(arg_78_0)
	local var_78_0 = string.split(arg_78_0, ",")

	return Vector3(var_78_0[1], var_78_0[2], var_78_0[3])
end

function getToggleState(arg_79_0)
	return arg_79_0:GetComponent(typeof(Toggle)).isOn
end

function setLocalPosition(arg_80_0, arg_80_1)
	local var_80_0 = tf(arg_80_0).localPosition

	arg_80_1.x = arg_80_1.x or var_80_0.x
	arg_80_1.y = arg_80_1.y or var_80_0.y
	arg_80_1.z = arg_80_1.z or var_80_0.z
	tf(arg_80_0).localPosition = arg_80_1

	return
end

function setAnchoredPosition(arg_81_0, arg_81_1)
	local var_81_0 = rtf(arg_81_0)

	arg_81_1.x = arg_81_1.x or var_81_0.anchoredPosition.x
	arg_81_1.y = arg_81_1.y or var_81_0.anchoredPosition.y
	var_81_0.anchoredPosition = arg_81_1

	return
end

function setAnchoredPosition3D(arg_82_0, arg_82_1)
	local var_82_0 = rtf(arg_82_0)

	arg_82_1.x = arg_82_1.x or var_82_0.anchoredPosition3D.x
	arg_82_1.y = arg_82_1.y or var_82_0.anchoredPosition3D.y
	arg_82_1.z = arg_82_1.y or var_82_0.anchoredPosition3D.z
	var_82_0.anchoredPosition3D = arg_82_1

	return
end

function getAnchoredPosition(arg_83_0)
	return rtf(arg_83_0).anchoredPosition
end

function setLocalScale(arg_84_0, arg_84_1)
	local var_84_0 = tf(arg_84_0).localScale

	arg_84_1.x = arg_84_1.x or var_84_0.x
	arg_84_1.y = arg_84_1.y or var_84_0.y
	arg_84_1.z = arg_84_1.z or var_84_0.z
	tf(arg_84_0).localScale = arg_84_1

	return
end

function setLocalRotation(arg_85_0, arg_85_1)
	local var_85_0 = tf(arg_85_0).localRotation

	arg_85_1.x = arg_85_1.x or var_85_0.x
	arg_85_1.y = arg_85_1.y or var_85_0.y
	arg_85_1.z = arg_85_1.z or var_85_0.z
	tf(arg_85_0).localRotation = arg_85_1

	return
end

function setLocalEulerAngles(arg_86_0, arg_86_1)
	local var_86_0 = tf(arg_86_0).localEulerAngles

	arg_86_1.x = arg_86_1.x or var_86_0.x
	arg_86_1.y = arg_86_1.y or var_86_0.y
	arg_86_1.z = arg_86_1.z or var_86_0.z
	tf(arg_86_0).localEulerAngles = arg_86_1

	return
end

function ActivateInputField(arg_87_0)
	GetComponent(arg_87_0, typeof(InputField)):ActivateInputField()

	return
end

function onInputChanged(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0 = GetComponent(arg_88_1, typeof(InputField)).onValueChanged

	var_88_0:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_88_0, var_88_0)
	var_88_0:AddListener(arg_88_2)

	return
end

function getImageColor(arg_89_0)
	return GetComponent(arg_89_0, typeof(Image)).color
end

function setImageColor(arg_90_0, arg_90_1)
	GetComponent(arg_90_0, typeof(Image)).color = arg_90_1

	return
end

function getImageAlpha(arg_91_0)
	return GetComponent(arg_91_0, typeof(Image)).color.a
end

function setImageAlpha(arg_92_0, arg_92_1)
	local var_92_0 = GetComponent(arg_92_0, typeof(Image))

	var_92_0.color.a = arg_92_1
	var_92_0.color = var_92_0.color

	return
end

function getImageRaycastTarget(arg_93_0)
	return GetComponent(arg_93_0, typeof(Image)).raycastTarget
end

function setImageRaycastTarget(arg_94_0, arg_94_1)
	GetComponent(arg_94_0, typeof(Image)).raycastTarget = tobool(arg_94_1)

	return
end

function getCanvasGroupAlpha(arg_95_0)
	return GetOrAddComponent(arg_95_0, typeof(CanvasGroup)).alpha
end

function setCanvasGroupAlpha(arg_96_0, arg_96_1)
	GetOrAddComponent(arg_96_0, typeof(CanvasGroup)).alpha = arg_96_1

	return
end

function setActiveByCanvasGroup(arg_97_0, arg_97_1)
	local var_97_0 = GetOrAddComponent(arg_97_0, typeof(CanvasGroup))

	var_97_0.alpha = arg_97_1 and 1 or 0
	var_97_0.blocksRaycasts = arg_97_1

	return
end

function setActiveViaLayer(arg_98_0, arg_98_1)
	HotfixHelper.SetUIActiveViaLayer(go(arg_98_0), arg_98_1)

	return
end

function getTextColor(arg_99_0)
	return GetComponent(arg_99_0, typeof(Text)).color
end

function setTextColor(arg_100_0, arg_100_1)
	GetComponent(arg_100_0, typeof(Text)).color = arg_100_1

	return
end

function getTextAlpha(arg_101_0)
	return GetComponent(arg_101_0, typeof(Text)).color.a
end

function setTextAlpha(arg_102_0, arg_102_1)
	local var_102_0 = GetComponent(arg_102_0, typeof(Text))

	var_102_0.color.a = arg_102_1
	var_102_0.color = var_102_0.color

	return
end

function setSizeDelta(arg_103_0, arg_103_1)
	local var_103_0 = GetComponent(arg_103_0, typeof(RectTransform))

	if not var_103_0 then
		return
	end

	local var_103_1 = var_103_0.sizeDelta

	var_103_1.x = arg_103_1.x or var_103_1.x
	var_103_1.y = arg_103_1.y or var_103_1.y
	var_103_0.sizeDelta = var_103_1

	return
end

function getOutlineColor(arg_104_0)
	return GetComponent(arg_104_0, typeof(Outline)).effectColor
end

function setOutlineColor(arg_105_0, arg_105_1)
	GetComponent(arg_105_0, typeof(Outline)).effectColor = arg_105_1

	return
end

function pressPersistTrigger(arg_106_0, arg_106_1, arg_106_2, arg_106_3, arg_106_4, arg_106_5, arg_106_6, arg_106_7)
	arg_106_6 = defaultValue(arg_106_6, 0.25)

	assert(arg_106_6 > 0, "maxSpeed less than zero")
	assert(arg_106_0, "should exist objectOrTransform")

	local var_106_0 = GetOrAddComponent(arg_106_0, typeof(EventTriggerListener))

	assert(arg_106_2, "should exist callback")

	local var_106_1

	local function var_106_2()
		if var_106_1 then
			var_106_1:Stop()

			var_106_1 = nil

			existCall(arg_106_3)
		end

		return
	end

	var_106_0:AddPointDownFunc(function()
		var_106_1 = Timer.New(function()
			if arg_106_5 then
				var_106_1.duration = math.max(var_106_1.duration - arg_106_1 / 10, arg_106_6)
			end

			existCall(arg_106_2, var_106_2)

			return
		end, arg_106_1, -1)

		var_106_1:Start()

		if arg_106_4 then
			var_106_1.func()
		end

		if arg_106_7 and var_0_1 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_106_7)
		end

		return
	end)
	var_106_0:AddPointUpFunc(function()
		if var_106_1 then
			var_106_1:Stop()

			var_106_1 = nil

			existCall(arg_106_3)
		end

		return
	end)

	return var_106_0
end

function getSpritePivot(arg_110_0)
	return Vector2(-arg_110_0.bounds.center.x / arg_110_0.bounds.extents.x / 2 + 0.5, -arg_110_0.bounds.center.y / arg_110_0.bounds.extents.y / 2 + 0.5)
end

function resetAspectRatio(arg_111_0)
	local var_111_0 = GetComponent(arg_111_0, "Image")

	GetComponent(arg_111_0, "AspectRatioFitter").aspectRatio = var_111_0.preferredWidth / var_111_0.preferredHeight

	return
end

function cloneTplTo(arg_112_0, arg_112_1, arg_112_2)
	local var_112_0 = tf(Instantiate(arg_112_0))

	var_112_0:SetParent(tf(arg_112_1), false)
	SetActive(var_112_0, true)

	if arg_112_2 then
		var_112_0.name = arg_112_2
	end

	return var_112_0
end

function setGray(arg_113_0, arg_113_1, arg_113_2)
	if arg_113_1 then
		local var_113_0 = GetOrAddComponent(arg_113_0, "UIGrayScale")

		var_113_0.Recursive = defaultValue(arg_113_2, true)
		var_113_0.enabled = true
	else
		RemoveComponent(arg_113_0, "UIGrayScale")
	end

	return
end

function setBlackMask(arg_114_0, arg_114_1, arg_114_2)
	if arg_114_1 then
		arg_114_2 = setmetatable(arg_114_2 or {}, {
			__index = {
				recursive = true,
				color = Color(0, 0, 0, 0.2)
			}
		})

		local var_114_0 = GetOrAddComponent(arg_114_0, "UIMaterialAdjuster")

		var_114_0.Recursive = arg_114_2.recursive

		local var_114_1 = Material.New(pg.ShaderMgr.GetInstance():GetShader("M02/Unlit Colored_Alpha_UI"))

		var_114_1:SetColor("_Color", arg_114_2.color)

		var_114_0.adjusterMaterial = var_114_1
		var_114_0.enabled = true
	else
		RemoveComponent(arg_114_0, "UIMaterialAdjuster")
	end

	return
end

function blockBlackMask(arg_115_0, arg_115_1, arg_115_2)
	if arg_115_1 then
		local var_115_0 = GetOrAddComponent(arg_115_0, "UIMaterialAdjuster")

		var_115_0.Recursive = tobool(defaultValue(arg_115_2, true))
		var_115_0.enabled = false
	else
		RemoveComponent(arg_115_0, "UIMaterialAdjuster")
	end

	return
end

function long2int(arg_116_0)
	local var_116_0, var_116_1 = int64.tonum2(arg_116_0)

	return var_116_0
end

function OnSliderWithButton(arg_117_0, arg_117_1, arg_117_2)
	local var_117_0 = arg_117_1:GetComponent("Slider")

	var_117_0.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_117_0, var_117_0.onValueChanged)
	var_117_0.onValueChanged:AddListener(arg_117_2)

	local var_117_1 = (var_117_0.maxValue - var_117_0.minValue) * 0.1

	onButton(arg_117_0, arg_117_1:Find("up"), function()
		var_117_0.value = math.clamp(var_117_0.value + var_117_1, var_117_0.minValue, var_117_0.maxValue)

		return
	end, SFX_PANEL)
	onButton(arg_117_0, arg_117_1:Find("down"), function()
		var_117_0.value = math.clamp(var_117_0.value - var_117_1, var_117_0.minValue, var_117_0.maxValue)

		return
	end, SFX_PANEL)

	return
end

function addSlip(arg_120_0, arg_120_1, arg_120_2, arg_120_3, arg_120_4)
	local var_120_0 = GetOrAddComponent(arg_120_1, "EventTriggerListener")
	local var_120_1
	local var_120_2 = 0
	local var_120_3 = 50

	var_120_0:AddPointDownFunc(function()
		var_120_2 = 0
		var_120_1 = nil

		return
	end)
	var_120_0:AddDragFunc(function(arg_122_0, arg_122_1)
		var_120_1 = var_120_1 or arg_122_1.position

		if arg_120_0 == SLIP_TYPE_HRZ then
			var_120_2 = arg_122_1.position.x - var_120_1.x
		elseif arg_120_0 == SLIP_TYPE_VERT then
			var_120_2 = arg_122_1.position.y - var_120_1.y
		end

		return
	end)
	var_120_0:AddPointUpFunc(function(arg_123_0, arg_123_1)
		if var_120_2 < -var_120_3 then
			if arg_120_3 then
				arg_120_3()
			end
		elseif var_120_2 > var_120_3 then
			if arg_120_2 then
				arg_120_2()
			end
		elseif arg_120_4 then
			arg_120_4()
		end

		return
	end)

	return
end

function getSizeRate()
	local var_124_0 = pg.UIMgr.GetInstance().LevelMain.transform.rect

	return Vector2.New(var_124_0.width / UnityEngine.Screen.width, var_124_0.height / UnityEngine.Screen.height), var_124_0.width, var_124_0.height
end

function IsUsingWifi()
	return Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork
end

function getSceneRootTFDic(arg_126_0)
	for iter_126_0, iter_126_1 in ipairs(arg_126_0:GetRootGameObjects():ToTable()) do
		({})[iter_126_1.name] = iter_126_1.transform
	end

	return {}
end

function bindComponent(arg_127_0, arg_127_1, arg_127_2)
	local var_127_0 = tf(arg_127_1):GetComponent(typeof(ComponentBinding))

	if var_127_0 == nil then
		return
	end

	local var_127_1 = var_127_0:GetLuaNames()
	local var_127_2 = var_127_0:GetComponentValues():ToTable()

	for iter_127_0, iter_127_1 in ipairs((var_127_1:ToTable())) do
		if not arg_127_2 then
			arg_127_0[iter_127_1] = var_127_2[iter_127_0] or nil
		end
	end

	return
end

return
