local function var_0_0(arg_1_0)
	return arg_1_0.transform
end

local var_0_1 = tf

local function var_0_2(arg_2_0)
	tf = var_1_10001

	return var_1_10001(arg_2_0).gameObject
end

local var_0_3 = go

local function var_0_4(arg_3_0)
	return arg_3_0.transform
end

local var_0_5 = rtf

local function var_0_6(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(arg_4_0, "object or transform should exist")

	tf = var_1_10002

	local var_4_0 = var_1_10002(arg_4_0)
	local var_4_1

	var_4_1 = var_2.Find(var_4_0, arg_4_1) and var_2.gameObject

	return var_4_1
end

local var_0_7 = findGO

local function var_0_8(arg_5_0, arg_5_1)
	assert = var_1_10002

	var_1_10002(arg_5_0, "object or transform should exist " .. arg_5_1)

	tf = var_1_10002

	local var_5_0 = var_1_10002(arg_5_0)

	return (var_2.Find(var_5_0, arg_5_1))
end

local var_0_9 = findTF

local function var_0_10(arg_6_0, ...)
	Object = var_1_10001

	local var_6_0 = var_1_10001.Instantiate

	go = var_1_10002

	return var_6_0(var_1_10002(arg_6_0), ...)
end

Instantiate = Instantiate

local var_0_11 = instantiate

local function var_0_12(arg_7_0)
	Object = var_1_10001

	local var_7_0 = var_1_10001.Destroy

	go = var_1_10002

	var_7_0(var_1_10002(arg_7_0))

	return
end

Destroy = Destroy

local var_0_13 = destroy

local function var_0_14(arg_8_0, arg_8_1)
	if arg_8_0 == nil then
		print = var_1_10002

		var_1_10002("<color=red>SetActive Object is NIL!!!!</color>")

		return
	end

	LuaHelper = var_1_10002

	local var_8_0 = var_1_10002.SetActiveForLua
	local var_8_1 = arg_8_0

	tobool = var_1_10004

	var_8_0(var_8_1, var_1_10004(arg_8_1))

	return
end

SetActive = SetActive

local var_0_15 = setActive

local function var_0_16(arg_9_0)
	go = var_1_10001

	return var_1_10001(arg_9_0).activeSelf
end

local var_0_17 = isActive

local function var_0_18(arg_10_0, arg_10_1)
	arg_10_0.name = arg_10_1

	return
end

SetName = SetName

local var_0_19 = setName

local function var_0_20(arg_11_0, arg_11_1, arg_11_2)
	LuaHelper = var_1_10003

	local var_11_0 = var_1_10003.SetParentForLua
	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_1

	tobool = var_1_10006

	var_11_0(var_11_1, var_11_2, var_1_10006(arg_11_2))

	return
end

SetParent = SetParent

local var_0_21 = setParent

local function var_0_22(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.GetComponent

	typeof = var_1_10004
	Text = var_1_10005

	local var_12_2 = var_12_1(var_12_0, var_1_10004(var_1_10005))

	tostring = var_12_0
	var_12_2.text = var_12_0(arg_12_1)

	return
end

local var_0_23 = setText

local function var_0_24(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	pairs = var_1_10002
	pg = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10002(var_1_10003.NewStyleMsgboxMgr.COLOR_MAP) do
		string = var_1_10007
		arg_13_1 = var_1_10007.gsub(arg_13_1, iter_13_0, iter_13_1)
	end

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetComponent

	typeof = var_4
	Text = iter_13_0

	local var_13_2 = var_13_1(var_13_0, var_4(iter_13_0))

	tostring = var_13_0
	var_13_2.text = var_13_0(arg_13_1)

	return
end

local var_0_25 = setTextInNewStyleBox

local function var_0_26(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_0:GetComponent("ScrollText")
	local var_14_1 = var_2.SetText

	tostring = var_4

	var_14_1(var_14_0, var_4(arg_14_1))

	return
end

local var_0_27 = setScrollText

local function var_0_28(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	splitByWordEN = var_1_10002
	arg_15_1 = var_1_10002(arg_15_1, arg_15_0)

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetComponent

	typeof = var_4
	Text = var_1_10005

	local var_15_2 = var_15_1(var_15_0, var_4(var_1_10005))

	tostring = var_15_0
	var_15_2.text = var_15_0(arg_15_1)

	return
end

local var_0_29 = setTextEN

local function var_0_30(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetComponent

	typeof = var_1_10005
	RectTransform = var_1_10006

	local var_16_2 = var_16_1(var_16_0, var_1_10005(var_1_10006))
	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0.GetComponent

	typeof = var_1_10006
	Text = var_1_10007

	local var_16_5 = var_16_4(var_16_3, var_1_10006(var_1_10007))
	local var_16_6 = arg_16_2 or 20
	local var_16_7 = var_16_2.rect.width
	local var_16_8 = var_16_2.rect.height

	while 0 < var_16_6 do
		var_16_5.fontSize = var_16_6
		splitByWordEN = var_16_9

		local var_16_9 = var_16_9(arg_16_1, arg_16_0)

		tostring = var_9
		var_16_5.text = var_9(var_16_9)

		if var_16_7 >= var_16_5.preferredWidth and var_16_8 >= var_16_5.preferredHeight then
			break
		end

		var_16_6 = var_16_6 - 1
	end

	return
end

local var_0_31 = setBestFitTextEN

local function var_0_32(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.GetComponent

	typeof = var_1_10004
	Text = var_1_10005
	var_17_1(var_17_0, var_1_10004(var_1_10005)).font = arg_17_1

	return
end

local var_0_33 = setTextFont

local function var_0_34(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetComponent

	typeof = var_1_10003
	Text = var_1_10004

	return var_18_1(var_18_0, var_1_10003(var_1_10004)).text
end

local var_0_35 = getText

local function var_0_36(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return
	end

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.GetComponent

	typeof = var_1_10004
	InputField = var_1_10005
	var_19_1(var_19_0, var_1_10004(var_1_10005)).text = arg_19_1

	return
end

local var_0_37 = setInputText

local function var_0_38(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetComponent

	typeof = var_1_10003
	InputField = var_1_10004

	return var_20_1(var_20_0, var_1_10003(var_1_10004)).text
end

local var_0_39 = getInputText

local function var_0_40(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetComponent

	typeof = var_1_10005
	InputField = var_1_10006

	local var_21_2 = var_21_1(var_21_0, var_1_10005(var_1_10006)).onEndEdit

	pg = var_21_0

	var_21_0.DelegateInfo.Add(arg_21_0, var_21_2)
	var_21_2:RemoveAllListeners()
	var_21_2:AddListener(arg_21_2)

	return
end

local var_0_41 = onInputEndEdit

local function var_0_42(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.GetComponent

	typeof = var_1_10003
	InputField = var_1_10004

	local var_22_2 = var_22_1(var_22_0, var_1_10003(var_1_10004))

	var_1.ActivateInputField(var_22_2)

	return
end

local var_0_43 = activateInputField

local function var_0_44(arg_23_0, arg_23_1, arg_23_2)
	setWidgetText = var_1_10003

	var_1_10003(arg_23_0, arg_23_1, arg_23_2)

	return
end

local var_0_45 = setButtonText

local function var_0_46(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or "Text"
	findTF = var_1_10003
	arg_24_2 = var_1_10003(arg_24_0, arg_24_2)
	setText = var_3

	var_3(arg_24_2, arg_24_1)

	return
end

local var_0_47 = setWidgetText

local function var_0_48(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or "Text"
	findTF = var_1_10003
	arg_25_2 = var_1_10003(arg_25_0, arg_25_2)
	setTextEN = var_3

	var_3(arg_25_2, arg_25_1)

	return
end

local var_0_49 = setWidgetTextEN
local var_0_50
local var_0_51 = true
local var_0_52 = -1

local function var_0_53(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	GetOrAddComponent = var_1_10005

	local var_26_0 = arg_26_1

	typeof = var_1_10007
	Button = var_1_10008

	local var_26_1 = var_1_10005(var_26_0, var_1_10007(var_1_10008))

	assert = var_26_0

	var_26_0(var_26_1, "could not found Button component on " .. arg_26_1.name)

	assert = var_26_0

	var_26_0(arg_26_2, "callback should exist")

	local var_26_2 = var_26_1.onClick

	pg = var_7

	var_7.DelegateInfo.Add(arg_26_0, var_26_2)
	var_26_2:RemoveAllListeners()
	var_26_2:AddListener(function()
		local var_27_0 = var_0_52

		Time = var_2_10001

		if var_27_0 == var_2_10001.frameCount then
			Input = var_27_0

			if var_27_0.touchCount > 1 then
				return
			end
		end

		Time = var_27_0
		var_0_52 = var_27_0.frameCount

		if arg_26_3 and var_0_51 then
			pg = var_0

			local var_27_1 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_27_1, arg_26_3)
		end

		arg_26_2()

		return
	end)

	return
end

local var_0_54 = onButton

local function var_0_55(arg_28_0)
	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.GetComponent

	typeof = var_1_10003
	Button = var_1_10004

	if var_28_1(var_28_0, var_1_10003(var_1_10004)) ~= nil then
		local var_28_2 = var_1.onClick

		var_2.RemoveAllListeners(var_28_2)
	end

	return
end

local var_0_56 = removeOnButton

local function var_0_57(arg_29_0)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.GetComponentsInChildren

	typeof = var_1_10003
	Button = var_1_10004

	local var_29_2 = var_29_1(var_29_0, var_1_10003(var_1_10004))
	local var_29_3 = var_1.ToTable(var_29_2)

	ipairs = var_29_2

	for iter_29_0, iter_29_1 in var_29_2(var_29_3) do
		if iter_29_1 ~= nil then
			local var_29_4 = iter_29_1.onClick

			var_7.RemoveAllListeners(var_29_4)
		end
	end

	return
end

local var_0_58 = removeAllOnButton

local function var_0_59(arg_30_0)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.GetComponentsInChildren

	typeof = var_1_10003
	Text = var_1_10004

	local var_30_2 = var_30_1(var_30_0, var_1_10003(var_1_10004))
	local var_30_3 = var_1.ToTable(var_30_2)

	ipairs = var_30_2

	for iter_30_0, iter_30_1 in var_30_2(var_30_3) do
		if iter_30_1 ~= nil then
			iter_30_1.text = ""
		end
	end

	return
end

local var_0_60 = ClearAllText

local function var_0_61(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	GetOrAddComponent = var_1_10004

	local var_31_0 = arg_31_1

	typeof = var_1_10006
	UILongPressTrigger = var_1_10007

	local var_31_1 = var_1_10004(var_31_0, var_1_10006(var_1_10007))

	assert = var_31_0

	var_31_0(var_31_1, "could not found UILongPressTrigger component on " .. arg_31_1.name)

	assert = var_31_0

	var_31_0(arg_31_2, "callback should exist")

	local var_31_2 = var_31_1.onLongPressed

	pg = var_6

	var_6.DelegateInfo.Add(arg_31_0, var_31_2)
	var_31_2:RemoveAllListeners()
	var_31_2:AddListener(function()
		if arg_31_3 then
			pg = var_0

			local var_32_0 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_32_0, arg_31_3)
		end

		arg_31_2()

		return
	end)

	return
end

local var_0_62 = onLongPressTrigger

local function var_0_63(arg_33_0)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.GetComponent

	typeof = var_1_10003
	UILongPressTrigger = var_1_10004

	if var_33_1(var_33_0, var_1_10003(var_1_10004)) ~= nil then
		local var_33_2 = var_1.onLongPressed

		var_2.RemoveAllListeners(var_33_2)
	end

	return
end

local var_0_64 = removeOnLongPressTrigger

local function var_0_65(arg_34_0, arg_34_1)
	GetComponent = var_1_10002

	local var_34_0 = arg_34_0

	typeof = var_1_10004
	Button = var_1_10005
	var_1_10002(var_34_0, var_1_10004(var_1_10005)).interactable = arg_34_1

	return
end

local var_0_66 = setButtonEnabled

local function var_0_67(arg_35_0, arg_35_1)
	GetComponent = var_1_10002

	local var_35_0 = arg_35_0

	typeof = var_1_10004
	Toggle = var_1_10005
	var_1_10002(var_35_0, var_1_10004(var_1_10005)).interactable = arg_35_1

	return
end

local var_0_68 = setToggleEnabled

local function var_0_69(arg_36_0, arg_36_1)
	GetComponent = var_1_10002

	local var_36_0 = arg_36_0

	typeof = var_1_10004
	Slider = var_1_10005
	var_1_10002(var_36_0, var_1_10004(var_1_10005)).interactable = arg_36_1

	return
end

local var_0_70 = setSliderEnable

local function var_0_71(arg_37_0)
	GetComponent = var_1_10001

	local var_37_0 = arg_37_0

	typeof = var_1_10003
	Button = var_1_10004

	local var_37_1 = var_1_10001(var_37_0, var_1_10003(var_1_10004))

	var_0_51 = false
	var_0_52 = -1

	local var_37_2 = var_37_1.onClick

	var_2.Invoke(var_37_2)

	var_0_51 = true

	return
end

local var_0_72 = triggerButton
local var_0_73 = true

local function var_0_74(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	GetComponent = var_1_10005

	local var_38_0 = arg_38_1

	typeof = var_1_10007
	Toggle = var_1_10008

	local var_38_1 = var_1_10005(var_38_0, var_1_10007(var_1_10008))

	assert = var_38_0

	var_38_0(arg_38_2, "callback should exist")

	local var_38_2 = var_38_1.onValueChanged

	var_6.RemoveAllListeners(var_38_2)

	pg = var_7

	var_7.DelegateInfo.Add(arg_38_0, var_6)
	var_6:AddListener(function(arg_39_0)
		if var_0_73 then
			if arg_39_0 and arg_38_3 and var_38_1.isOn == arg_39_0 then
				SFX_UI_TAG = var_1
				arg_38_3 = var_1
				pg = var_1

				local var_39_0 = var_1.CriMgr.GetInstance()

				var_1.PlaySoundEffect_V3(var_39_0, arg_38_3)
			elseif not arg_39_0 and arg_38_4 then
				pg = var_1

				local var_39_1 = var_1.CriMgr.GetInstance()

				var_1.PlaySoundEffect_V3(var_39_1, arg_38_4)
			end
		end

		arg_38_2(arg_39_0)

		return
	end)

	GetComponent = var_7

	local var_38_3 = arg_38_1

	typeof = var_9
	UIToggleEvent = var_1_10010

	local var_38_4 = var_7(var_38_3, var_9(var_1_10010))

	IsNil = var_38_3

	if not var_38_3(var_38_4) then
		var_38_4:Rebind()
	end

	return
end

local var_0_75 = onToggle

local function var_0_76(arg_40_0)
	GetComponent = var_1_10001

	local var_40_0 = arg_40_0

	typeof = var_1_10003
	Toggle = var_1_10004

	if var_1_10001(var_40_0, var_1_10003(var_1_10004)) ~= nil then
		local var_40_1 = var_1.onValueChanged

		var_2.RemoveAllListeners(var_40_1)
	end

	return
end

local var_0_77 = removeOnToggle

local function var_0_78(arg_41_0, arg_41_1)
	GetComponent = var_1_10002

	local var_41_0 = arg_41_0

	typeof = var_1_10004
	Toggle = var_1_10005

	local var_41_1 = var_1_10002(var_41_0, var_1_10004(var_1_10005))

	var_0_73 = false
	tobool = var_41_0
	arg_41_1 = var_41_0(arg_41_1)

	if var_41_1.isOn ~= arg_41_1 then
		var_41_1.isOn = arg_41_1
	else
		local var_41_2 = var_41_1.onValueChanged

		var_3.Invoke(var_41_2, arg_41_1)
	end

	var_0_73 = true

	return
end

local var_0_79 = triggerToggle

local function var_0_80(arg_42_0, arg_42_1)
	GetComponent = var_1_10002

	local var_42_0 = arg_42_0

	typeof = var_1_10004
	Toggle = var_1_10005

	local var_42_1 = var_1_10002(var_42_0, var_1_10004(var_1_10005))

	var_0_73 = false
	tobool = var_42_0
	arg_42_1 = var_42_0(arg_42_1)
	LuaHelper = var_3

	var_3.ChangeToggleValueWithoutNotify(var_42_1, arg_42_1)

	var_0_73 = true

	return
end

local var_0_81 = triggerToggleWithoutNotify

local function var_0_82(arg_43_0, arg_43_1, arg_43_2)
	GetComponent = var_1_10003

	local var_43_0 = arg_43_1

	typeof = var_1_10005
	Slider = var_1_10006

	local var_43_1 = var_1_10003(var_43_0, var_1_10005(var_1_10006)).onValueChanged

	assert = var_43_0

	var_43_0(arg_43_2, "callback should exist")
	var_43_1:RemoveAllListeners()

	pg = var_4

	var_4.DelegateInfo.Add(arg_43_0, var_43_1)
	var_43_1:AddListener(arg_43_2)

	return
end

local var_0_83 = onSlider

local function var_0_84(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	GetComponent = var_1_10004

	local var_44_0 = arg_44_0

	typeof = var_1_10006
	Slider = var_1_10007

	local var_44_1 = var_1_10004(var_44_0, var_1_10006(var_1_10007))

	assert = var_44_0

	var_44_0(var_44_1, "slider should exist")

	var_44_1.minValue = arg_44_1
	var_44_1.maxValue = arg_44_2
	var_44_1.value = arg_44_3

	return
end

local var_0_85 = setSlider

local function var_0_86(arg_45_0, arg_45_1)
	tf = var_1_10002

	for iter_45_0 = var_1_10002(arg_45_0).childCount - 1, 0, -1 do
		arg_45_1(var_2:GetChild(iter_45_0), iter_45_0)
	end

	return
end

local var_0_87 = eachChild

local function var_0_88(arg_46_0)
	eachChild = var_1_10001

	var_1_10001(arg_46_0, function(arg_47_0)
		tf = var_2_10001

		local var_47_0 = var_2_10001(arg_47_0).transform

		var_1.SetParent(var_47_0, nil, false)

		Destroy = var_1

		var_1(arg_47_0)

		return
	end)

	return
end

local var_0_89 = removeAllChildren

local function var_0_90(arg_48_0, arg_48_1)
	Canvas = var_1_10002

	var_1_10002.ForceUpdateCanvases()

	GetComponent = var_2

	local var_48_0 = arg_48_0

	typeof = var_1_10004
	ScrollRect = var_1_10005

	local var_48_1 = var_2(var_48_0, var_1_10004(var_1_10005)).viewport.rect
	local var_48_2 = var_2.content.rect

	Vector2 = var_1_10005
	math = var_1_10006

	local var_48_3 = var_1_10006.max(var_48_2.width - var_48_1.width, 0)

	math = var_7

	local var_48_4 = var_1_10005(var_48_3, var_7.max(var_48_2.height - var_48_1.height, 0))

	Vector2 = var_48_3

	if var_48_4 == var_48_3.zero then
		scrollTo = var_6

		var_6(arg_48_0, 0, 0)
	else
		local var_48_5 = var_2.content
		local var_48_6 = (var_6.GetChild(var_48_5, arg_48_1 - 1).rect.x + var_6.localPosition.x) / var_48_4.x
		local var_48_7 = 1 + (var_7.y + var_7.height + var_6.localPosition.y - (var_48_2.y + var_48_2.height)) / var_48_4.y

		scrollTo = var_10

		local var_48_8 = arg_48_0

		math = var_1_10012

		local var_48_9 = var_1_10012.clamp(var_48_6, 0, 1)

		math = var_13

		var_10(var_48_8, var_48_9, var_13.clamp(var_48_7, 0, 1))
	end

	return
end

local var_0_91 = scrollToIndex

local function var_0_92(arg_49_0, arg_49_1, arg_49_2)
	Canvas = var_1_10003

	var_1_10003.ForceUpdateCanvases()

	GetComponent = var_3

	local var_49_0 = arg_49_0

	typeof = var_1_10005
	ScrollRect = var_1_10006

	local var_49_1 = var_3(var_49_0, var_1_10005(var_1_10006))

	Vector2 = var_49_0

	local var_49_2 = var_49_0(var_49_1.horizontal and arg_49_1 or var_49_1.normalizedPosition.x, var_49_1.vertical and arg_49_2 or var_49_1.normalizedPosition.y)

	onNextTick = var_5

	var_5(function()
		IsNil = var_2_10000

		if not var_2_10000(arg_49_0) then
			var_49_1.normalizedPosition = var_49_2

			local var_50_0 = var_49_1.onValueChanged

			var_0.Invoke(var_50_0, var_49_2)
		end

		return
	end)

	return
end

local var_0_93 = scrollTo

local function var_0_94(arg_51_0)
	scrollTo = var_1_10001

	var_1_10001(arg_51_0, 0, 0)

	return
end

local var_0_95 = scrollToBottom

local function var_0_96(arg_52_0, arg_52_1, arg_52_2)
	GetComponent = var_1_10003

	local var_52_0 = arg_52_1

	typeof = var_1_10005
	ScrollRect = var_1_10006

	local var_52_1 = var_1_10003(var_52_0, var_1_10005(var_1_10006)).onValueChanged

	assert = var_52_0

	var_52_0(arg_52_2, "callback should exist")
	var_52_1:RemoveAllListeners()

	pg = var_4

	var_4.DelegateInfo.Add(arg_52_0, var_52_1)
	var_52_1:AddListener(arg_52_2)

	return
end

local var_0_97 = onScroll

local function var_0_98(arg_53_0)
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

local var_0_99 = ClearEventTrigger

local function var_0_100(arg_54_0)
	if not arg_54_0 then
		return
	end

	arg_54_0.onStart = nil
	arg_54_0.onInitItem = nil
	arg_54_0.onUpdateItem = nil
	arg_54_0.onReturnItem = nil

	return
end

local var_0_101 = ClearLScrollrect

local function var_0_102(arg_55_0, arg_55_1)
	return (arg_55_0:GetComponent(arg_55_1))
end

local var_0_103 = GetComponent

local function var_0_104(arg_56_0, arg_56_1)
	assert = var_1_10002

	local var_56_0 = arg_56_0
	local var_56_1 = "objectOrTransform not found: "

	debug = var_1_10005

	var_1_10002(var_56_0, var_56_1 .. var_1_10005.traceback())

	local var_56_2 = arg_56_1

	type = var_56_0

	if var_56_0(arg_56_1) == "string" then
		assert = var_3
		_G = var_4

		var_3(var_4[arg_56_1], arg_56_1 .. " not exist in Global")

		typeof = var_3
		_G = var_4
		var_56_2 = var_3(var_4[arg_56_1])
	end

	LuaHelper = var_3

	return var_3.GetOrAddComponentForLua(arg_56_0, var_56_2)
end

local var_0_105 = GetOrAddComponent

local function var_0_106(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0

	if arg_57_0.GetComponent(var_57_0, arg_57_1) then
		Object = var_57_0

		var_57_0.Destroy(var_2)
	end

	return
end

local var_0_107 = RemoveComponent

local function var_0_108(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0
	local var_58_1 = arg_58_0.GetComponent(var_58_0, arg_58_1)

	assert = var_58_0

	var_58_0(var_58_1, "compoment not found")

	tobool = var_58_0
	var_58_1.enabled = var_58_0(arg_58_2)

	return
end

SetComponentEnabled = SetComponentEnabled

local var_0_109 = SetCompomentEnabled

local function var_0_110(arg_59_0, arg_59_1)
	return (function(arg_60_0, arg_60_1)
		if not arg_60_0 then
			return nil
		end

		if arg_60_0.name == arg_60_1 then
			return arg_60_0
		end

		for iter_60_0 = 0, arg_60_0.childCount - 1 do
			if arg_60_1 == arg_60_0:GetChild(iter_60_0).name then
				return var_6
			end

			if var_0(var_6, arg_60_1) then
				return var_7
			end
		end

		return nil
	end)(arg_59_0, arg_59_1)
end

local var_0_111 = GetInChildren

local function var_0_112(arg_61_0)
	FrameTimer = var_1_10001

	local var_61_0 = var_1_10001.New(arg_61_0, 1, 1)

	var_1.Start(var_61_0)

	return
end

local var_0_113 = onNextTick

local function var_0_114(arg_62_0, arg_62_1)
	Timer = var_1_10002

	local var_62_0 = var_1_10002.New(arg_62_0, arg_62_1, 1)

	var_2.Start(var_62_0)

	return var_2
end

local var_0_115 = onDelayTick

local function var_0_116(arg_63_0, arg_63_1, ...)
	local var_63_0 = 0
	local var_63_1 = #arg_63_0
	local var_63_2

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

local var_0_117 = seriesAsync

local function var_0_118(arg_65_0, arg_65_1, ...)
	local var_65_0

	;(function(...)
		if #arg_65_0 > 0 then
			table = var_0

			var_0.remove(arg_65_0, 1)(var_0, ...)
		elseif arg_65_1 then
			arg_65_1(...)
		end

		return
	end)(...)

	return
end

local var_0_119 = seriesAsyncExtend

local function var_0_120(arg_67_0, arg_67_1)
	local var_67_0 = #arg_67_0

	local function var_67_1()
		var_67_0 = var_67_0 - 1

		if var_67_0 == 0 and arg_67_1 then
			arg_67_1()
		end

		return
	end

	if 0 < var_67_0 then
		ipairs = var_4

		for iter_67_0, iter_67_1 in var_4(arg_67_0) do
			iter_67_1(var_67_1)
		end
	elseif arg_67_1 then
		arg_67_1()
	end

	return
end

local var_0_121 = parallelAsync

local function var_0_122(arg_69_0, arg_69_1, arg_69_2)
	if #arg_69_0 == 0 then
		arg_69_2()

		return
	end

	math = var_1_10005

	local var_69_0 = var_1_10005.min(arg_69_1, var_3)
	local var_69_1

	local function var_69_2()
		var_0 = var_0 - 1

		if var_0 == 0 then
			arg_69_2()
		elseif var_69_0 + 1 <= var_0 then
			var_69_0 = var_69_0 + 1

			arg_69_0[var_69_0](var_69_2)
		end

		return
	end

	for iter_69_0 = 1, var_69_0 do
		arg_69_0[iter_69_0](var_69_2)
	end

	return
end

local var_0_123 = limitedParallelAsync

local function var_0_124(arg_71_0, arg_71_1)
	local var_71_0

	FrameTimer = var_1_10003

	local var_71_1 = var_1_10003.New(function()
		if arg_71_0() then
			arg_71_1()

			local var_72_0 = var_71_0

			var_0.Stop(var_72_0)

			return
		end

		return
	end, 1, -1)

	var_71_0.Start(var_71_1)

	return var_71_0
end

local var_0_125 = waitUntil

local function var_0_126(arg_73_0, arg_73_1, arg_73_2)
	IsNil = var_1_10003

	if var_1_10003(arg_73_0) then
		assert = var_3

		var_3(false)

		return
	end

	GetComponent = var_3

	local var_73_0 = arg_73_0

	typeof = var_1_10005
	Image = var_1_10006

	local var_73_1 = var_3(var_73_0, var_1_10005(var_1_10006))

	IsNil = var_73_0

	if var_73_0(var_73_1) then
		return
	end

	var_73_1.sprite = arg_73_1

	if arg_73_2 then
		var_73_1:SetNativeSize()
	end

	return
end

local var_0_127 = setImageSprite

local function var_0_128(arg_74_0)
	GetComponent = var_1_10001

	local var_74_0 = arg_74_0

	typeof = var_1_10003
	Image = var_1_10004
	var_1_10001(var_74_0, var_1_10003(var_1_10004)).sprite = nil

	return
end

local var_0_129 = clearImageSprite

local function var_0_130(arg_75_0)
	GetComponent = var_1_10001

	local var_75_0 = arg_75_0

	typeof = var_1_10003
	Image = var_1_10004

	local var_75_1

	var_75_1 = var_1_10001(var_75_0, var_1_10003(var_1_10004)) and var_1.sprite

	return var_75_1
end

local var_0_131 = getImageSprite

local function var_0_132(arg_76_0)
	UnityEngine = var_1_10001

	local var_76_0 = var_1_10001.Sprite.Create
	local var_76_1 = arg_76_0

	UnityEngine = var_1_10003

	local var_76_2 = var_1_10003.Rect.New(0, 0, arg_76_0.width, arg_76_0.height)

	Vector2 = var_4

	return var_76_0(var_76_1, var_76_2, var_4(0.5, 0.5), 100)
end

local var_0_133 = tex2sprite

local function var_0_134(arg_77_0, arg_77_1)
	GetComponent = var_1_10002

	local var_77_0 = arg_77_0

	typeof = var_1_10004
	Image = var_1_10005
	var_1_10002(var_77_0, var_1_10004(var_1_10005)).fillAmount = arg_77_1

	return
end

local var_0_135 = setFillAmount

local function var_0_136(arg_78_0)
	string = var_1_10001

	local var_78_0 = var_1_10001.split(arg_78_0, ",")

	Vector3 = var_2

	return var_2(var_78_0[1], var_78_0[2], var_78_0[3])
end

local var_0_137 = string2vector3

local function var_0_138(arg_79_0)
	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.GetComponent

	typeof = var_1_10003
	Toggle = var_1_10004

	return var_79_1(var_79_0, var_1_10003(var_1_10004)).isOn
end

local var_0_139 = getToggleState

local function var_0_140(arg_80_0, arg_80_1)
	tf = var_1_10002

	local var_80_0 = var_1_10002(arg_80_0).localPosition
	local var_80_1

	if not arg_80_1.x then
		var_80_1 = var_80_0.x
	end

	arg_80_1.x = var_80_1

	local var_80_2

	if not arg_80_1.y then
		var_80_2 = var_80_0.y
	end

	arg_80_1.y = var_80_2

	local var_80_3

	if not arg_80_1.z then
		var_80_3 = var_80_0.z
	end

	arg_80_1.z = var_80_3
	tf = var_80_3
	var_80_3(arg_80_0).localPosition = arg_80_1

	return
end

local var_0_141 = setLocalPosition

local function var_0_142(arg_81_0, arg_81_1)
	rtf = var_1_10002

	local var_81_0 = var_1_10002(arg_81_0).anchoredPosition
	local var_81_1

	if not arg_81_1.x then
		var_81_1 = var_81_0.x
	end

	arg_81_1.x = var_81_1

	local var_81_2

	if not arg_81_1.y then
		var_81_2 = var_81_0.y
	end

	arg_81_1.y = var_81_2
	var_2.anchoredPosition = arg_81_1

	return
end

local var_0_143 = setAnchoredPosition

local function var_0_144(arg_82_0, arg_82_1)
	rtf = var_1_10002

	local var_82_0 = var_1_10002(arg_82_0).anchoredPosition3D
	local var_82_1

	if not arg_82_1.x then
		var_82_1 = var_82_0.x
	end

	arg_82_1.x = var_82_1

	local var_82_2

	if not arg_82_1.y then
		var_82_2 = var_82_0.y
	end

	arg_82_1.y = var_82_2

	local var_82_3

	if not arg_82_1.y then
		var_82_3 = var_82_0.z
	end

	arg_82_1.z = var_82_3
	var_2.anchoredPosition3D = arg_82_1

	return
end

local var_0_145 = setAnchoredPosition3D

local function var_0_146(arg_83_0)
	rtf = var_1_10001

	return var_1_10001(arg_83_0).anchoredPosition
end

local var_0_147 = getAnchoredPosition

local function var_0_148(arg_84_0, arg_84_1)
	tf = var_1_10002

	local var_84_0 = var_1_10002(arg_84_0).localScale
	local var_84_1

	if not arg_84_1.x then
		var_84_1 = var_84_0.x
	end

	arg_84_1.x = var_84_1

	local var_84_2

	if not arg_84_1.y then
		var_84_2 = var_84_0.y
	end

	arg_84_1.y = var_84_2

	local var_84_3

	if not arg_84_1.z then
		var_84_3 = var_84_0.z
	end

	arg_84_1.z = var_84_3
	tf = var_84_3
	var_84_3(arg_84_0).localScale = arg_84_1

	return
end

local var_0_149 = setLocalScale

local function var_0_150(arg_85_0, arg_85_1)
	tf = var_1_10002

	local var_85_0 = var_1_10002(arg_85_0).localRotation
	local var_85_1

	if not arg_85_1.x then
		var_85_1 = var_85_0.x
	end

	arg_85_1.x = var_85_1

	local var_85_2

	if not arg_85_1.y then
		var_85_2 = var_85_0.y
	end

	arg_85_1.y = var_85_2

	local var_85_3

	if not arg_85_1.z then
		var_85_3 = var_85_0.z
	end

	arg_85_1.z = var_85_3
	tf = var_85_3
	var_85_3(arg_85_0).localRotation = arg_85_1

	return
end

local var_0_151 = setLocalRotation

local function var_0_152(arg_86_0, arg_86_1)
	tf = var_1_10002

	local var_86_0 = var_1_10002(arg_86_0).localEulerAngles
	local var_86_1

	if not arg_86_1.x then
		var_86_1 = var_86_0.x
	end

	arg_86_1.x = var_86_1

	local var_86_2

	if not arg_86_1.y then
		var_86_2 = var_86_0.y
	end

	arg_86_1.y = var_86_2

	local var_86_3

	if not arg_86_1.z then
		var_86_3 = var_86_0.z
	end

	arg_86_1.z = var_86_3
	tf = var_86_3
	var_86_3(arg_86_0).localEulerAngles = arg_86_1

	return
end

local var_0_153 = setLocalEulerAngles

local function var_0_154(arg_87_0)
	GetComponent = var_1_10001

	local var_87_0 = arg_87_0

	typeof = var_1_10003
	InputField = var_1_10004

	local var_87_1 = var_1_10001(var_87_0, var_1_10003(var_1_10004))

	var_1.ActivateInputField(var_87_1)

	return
end

local var_0_155 = ActivateInputField

local function var_0_156(arg_88_0, arg_88_1, arg_88_2)
	GetComponent = var_1_10003

	local var_88_0 = arg_88_1

	typeof = var_1_10005
	InputField = var_1_10006

	local var_88_1 = var_1_10003(var_88_0, var_1_10005(var_1_10006)).onValueChanged

	var_3.RemoveAllListeners(var_88_1)

	pg = var_4

	var_4.DelegateInfo.Add(arg_88_0, var_3)
	var_3:AddListener(arg_88_2)

	return
end

local var_0_157 = onInputChanged

local function var_0_158(arg_89_0)
	GetComponent = var_1_10001

	local var_89_0 = arg_89_0

	typeof = var_1_10003
	Image = var_1_10004

	return var_1_10001(var_89_0, var_1_10003(var_1_10004)).color
end

local var_0_159 = getImageColor

local function var_0_160(arg_90_0, arg_90_1)
	GetComponent = var_1_10002

	local var_90_0 = arg_90_0

	typeof = var_1_10004
	Image = var_1_10005
	var_1_10002(var_90_0, var_1_10004(var_1_10005)).color = arg_90_1

	return
end

local var_0_161 = setImageColor

local function var_0_162(arg_91_0)
	GetComponent = var_1_10001

	local var_91_0 = arg_91_0

	typeof = var_1_10003
	Image = var_1_10004

	return var_1_10001(var_91_0, var_1_10003(var_1_10004)).color.a
end

local var_0_163 = getImageAlpha

local function var_0_164(arg_92_0, arg_92_1)
	GetComponent = var_1_10002

	local var_92_0 = arg_92_0

	typeof = var_1_10004
	Image = var_1_10005

	local var_92_1 = var_1_10002(var_92_0, var_1_10004(var_1_10005)).color

	var_92_1.a = arg_92_1
	var_2.color = var_92_1

	return
end

local var_0_165 = setImageAlpha

local function var_0_166(arg_93_0)
	GetComponent = var_1_10001

	local var_93_0 = arg_93_0

	typeof = var_1_10003
	Image = var_1_10004

	return var_1_10001(var_93_0, var_1_10003(var_1_10004)).raycastTarget
end

local var_0_167 = getImageRaycastTarget

local function var_0_168(arg_94_0, arg_94_1)
	GetComponent = var_1_10002

	local var_94_0 = arg_94_0

	typeof = var_1_10004
	Image = var_1_10005

	local var_94_1 = var_1_10002(var_94_0, var_1_10004(var_1_10005))

	tobool = var_94_0
	var_94_1.raycastTarget = var_94_0(arg_94_1)

	return
end

local var_0_169 = setImageRaycastTarget

local function var_0_170(arg_95_0)
	GetOrAddComponent = var_1_10001

	local var_95_0 = arg_95_0

	typeof = var_1_10003
	CanvasGroup = var_1_10004

	return var_1_10001(var_95_0, var_1_10003(var_1_10004)).alpha
end

local var_0_171 = getCanvasGroupAlpha

local function var_0_172(arg_96_0, arg_96_1)
	GetOrAddComponent = var_1_10002

	local var_96_0 = arg_96_0

	typeof = var_1_10004
	CanvasGroup = var_1_10005
	var_1_10002(var_96_0, var_1_10004(var_1_10005)).alpha = arg_96_1

	return
end

local var_0_173 = setCanvasGroupAlpha

local function var_0_174(arg_97_0, arg_97_1)
	GetOrAddComponent = var_1_10002

	local var_97_0 = arg_97_0

	typeof = var_1_10004
	CanvasGroup = var_1_10005

	local var_97_1 = var_1_10002(var_97_0, var_1_10004(var_1_10005))

	var_97_1.alpha = arg_97_1 and 1 or 0
	var_97_1.blocksRaycasts = arg_97_1

	return
end

local var_0_175 = setActiveByCanvasGroup

local function var_0_176(arg_98_0, arg_98_1)
	HotfixHelper = var_1_10002

	local var_98_0 = var_1_10002.SetUIActiveViaLayer

	go = var_1_10003

	var_98_0(var_1_10003(arg_98_0), arg_98_1)

	return
end

local var_0_177 = setActiveViaLayer

local function var_0_178(arg_99_0)
	GetComponent = var_1_10001

	local var_99_0 = arg_99_0

	typeof = var_1_10003
	Text = var_1_10004

	return var_1_10001(var_99_0, var_1_10003(var_1_10004)).color
end

local var_0_179 = getTextColor

local function var_0_180(arg_100_0, arg_100_1)
	GetComponent = var_1_10002

	local var_100_0 = arg_100_0

	typeof = var_1_10004
	Text = var_1_10005
	var_1_10002(var_100_0, var_1_10004(var_1_10005)).color = arg_100_1

	return
end

local var_0_181 = setTextColor

local function var_0_182(arg_101_0)
	GetComponent = var_1_10001

	local var_101_0 = arg_101_0

	typeof = var_1_10003
	Text = var_1_10004

	return var_1_10001(var_101_0, var_1_10003(var_1_10004)).color.a
end

local var_0_183 = getTextAlpha

local function var_0_184(arg_102_0, arg_102_1)
	GetComponent = var_1_10002

	local var_102_0 = arg_102_0

	typeof = var_1_10004
	Text = var_1_10005

	local var_102_1 = var_1_10002(var_102_0, var_1_10004(var_1_10005)).color

	var_102_1.a = arg_102_1
	var_2.color = var_102_1

	return
end

local var_0_185 = setTextAlpha

local function var_0_186(arg_103_0, arg_103_1)
	GetComponent = var_1_10002

	local var_103_0 = arg_103_0

	typeof = var_1_10004
	RectTransform = var_1_10005

	if not var_1_10002(var_103_0, var_1_10004(var_1_10005)) then
		return
	end

	local var_103_1 = var_2.sizeDelta
	local var_103_2

	if not arg_103_1.x then
		var_103_2 = var_103_1.x
	end

	var_103_1.x = var_103_2

	local var_103_3

	if not arg_103_1.y then
		var_103_3 = var_103_1.y
	end

	var_103_1.y = var_103_3
	var_2.sizeDelta = var_103_1

	return
end

local var_0_187 = setSizeDelta

local function var_0_188(arg_104_0)
	GetComponent = var_1_10001

	local var_104_0 = arg_104_0

	typeof = var_1_10003
	Outline = var_1_10004

	return var_1_10001(var_104_0, var_1_10003(var_1_10004)).effectColor
end

local var_0_189 = getOutlineColor

local function var_0_190(arg_105_0, arg_105_1)
	GetComponent = var_1_10002

	local var_105_0 = arg_105_0

	typeof = var_1_10004
	Outline = var_1_10005
	var_1_10002(var_105_0, var_1_10004(var_1_10005)).effectColor = arg_105_1

	return
end

local var_0_191 = setOutlineColor

local function var_0_192(arg_106_0, arg_106_1, arg_106_2, arg_106_3, arg_106_4, arg_106_5, arg_106_6, arg_106_7)
	defaultValue = var_1_10008
	arg_106_6 = var_1_10008(arg_106_6, 0.25)
	assert = var_8

	var_8(arg_106_6 > 0, "maxSpeed less than zero")

	assert = var_8

	var_8(arg_106_0, "should exist objectOrTransform")

	GetOrAddComponent = var_8

	local var_106_0 = arg_106_0

	typeof = var_10
	EventTriggerListener = var_1_10011

	local var_106_1 = var_8(var_106_0, var_10(var_1_10011))

	assert = var_106_0

	var_106_0(arg_106_2, "should exist callback")

	local var_106_2

	local function var_106_3()
		if var_106_2 then
			local var_107_0 = var_106_2

			var_0.Stop(var_107_0)

			var_106_2 = nil
			existCall = var_0

			var_0(arg_106_3)
		end

		return
	end

	var_106_1:AddPointDownFunc(function()
		Timer = var_2_10000
		var_106_2 = var_2_10000.New(function()
			local var_109_0

			if arg_106_5 then
				math = var_109_0
				var_109_0 = var_109_0.max(var_106_2.duration - arg_106_1 / 10, arg_106_6)
				var_106_2.duration = var_109_0
			end

			existCall = var_109_0

			var_109_0(arg_106_2, var_106_3)

			return
		end, arg_106_1, -1)

		local var_108_0 = var_106_2

		var_0.Start(var_108_0)

		if arg_106_4 then
			var_106_2.func()
		end

		if arg_106_7 and var_0_51 then
			pg = var_0

			local var_108_1 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_108_1, arg_106_7)
		end

		return
	end)
	var_106_1:AddPointUpFunc(var_106_3)

	return var_106_1
end

local var_0_193 = pressPersistTrigger

local function var_0_194(arg_110_0)
	local var_110_0 = -arg_110_0.bounds.center.x / var_1.extents.x / 2 + 0.5
	local var_110_1 = -var_1.center.y / var_1.extents.y / 2 + 0.5

	Vector2 = var_4

	return var_4(var_110_0, var_110_1)
end

local var_0_195 = getSpritePivot

local function var_0_196(arg_111_0)
	GetComponent = var_1_10001

	local var_111_0 = var_1_10001(arg_111_0, "Image")

	GetComponent = var_2
	var_2(arg_111_0, "AspectRatioFitter").aspectRatio = var_111_0.preferredWidth / var_111_0.preferredHeight

	return
end

local var_0_197 = resetAspectRatio

local function var_0_198(arg_112_0, arg_112_1, arg_112_2)
	tf = var_1_10003
	Instantiate = var_1_10004

	local var_112_0 = var_1_10003(var_1_10004(arg_112_0))
	local var_112_1 = var_3.SetParent

	tf = var_1_10006

	var_112_1(var_112_0, var_1_10006(arg_112_1), false)

	SetActive = var_112_1

	var_112_1(var_3, true)

	if arg_112_2 then
		var_3.name = arg_112_2
	end

	return var_3
end

local var_0_199 = cloneTplTo

local function var_0_200(arg_113_0, arg_113_1, arg_113_2)
	if arg_113_1 then
		GetOrAddComponent = var_1_10003
		var_1_10003 = var_1_10003(arg_113_0, "UIGrayScale")
		defaultValue = var_4
		var_1_10003.Recursive = var_4(arg_113_2, true)
		var_1_10003.enabled = true
	else
		RemoveComponent = var_1_10003

		var_1_10003(arg_113_0, "UIGrayScale")
	end

	return
end

local var_0_201 = setGray

local function var_0_202(arg_114_0, arg_114_1, arg_114_2)
	if arg_114_1 then
		setmetatable = var_1_10003

		local var_114_0 = arg_114_2 or {}
		local var_114_1 = {}
		local var_114_2 = {
			recursive = true
		}

		Color = var_1_10007
		var_114_2.color = var_1_10007(0, 0, 0, 0.2)
		var_114_1.__index = var_114_2
		arg_114_2 = var_1_10003(var_114_0, var_114_1)
		GetOrAddComponent = var_1_10003
		var_1_10003 = var_1_10003(arg_114_0, "UIMaterialAdjuster")
		var_1_10003.Recursive = arg_114_2.recursive
		Material = var_4

		local var_114_3 = var_4.New

		pg = var_5

		local var_114_4 = var_5.ShaderMgr.GetInstance()
		local var_114_5 = var_114_3(var_5.GetShader(var_114_4, "M02/Unlit Colored_Alpha_UI"))

		var_4.SetColor(var_114_5, "_Color", arg_114_2.color)

		var_1_10003.adjusterMaterial = var_4
		var_1_10003.enabled = true
	else
		RemoveComponent = var_1_10003

		var_1_10003(arg_114_0, "UIMaterialAdjuster")
	end

	return
end

local var_0_203 = setBlackMask

local function var_0_204(arg_115_0, arg_115_1, arg_115_2)
	if arg_115_1 then
		GetOrAddComponent = var_1_10003
		var_1_10003 = var_1_10003(arg_115_0, "UIMaterialAdjuster")
		tobool = var_4
		defaultValue = var_5
		var_1_10003.Recursive = var_4(var_5(arg_115_2, true))
		var_1_10003.enabled = false
	else
		RemoveComponent = var_1_10003

		var_1_10003(arg_115_0, "UIMaterialAdjuster")
	end

	return
end

local var_0_205 = blockBlackMask

local function var_0_206(arg_116_0)
	int64 = var_1_10001

	local var_116_0, var_116_1 = var_1_10001.tonum2(arg_116_0)

	return var_116_0
end

local var_0_207 = long2int

local function var_0_208(arg_117_0, arg_117_1, arg_117_2)
	local var_117_0 = arg_117_1:GetComponent("Slider").onValueChanged

	var_4.RemoveAllListeners(var_117_0)

	pg = var_4

	var_4.DelegateInfo.Add(arg_117_0, var_3.onValueChanged)

	local var_117_1 = var_3.onValueChanged

	var_4.AddListener(var_117_1, arg_117_2)

	local var_117_2 = (var_3.maxValue - var_3.minValue) * 0.1

	onButton = var_5

	local var_117_3 = arg_117_0
	local var_117_4 = arg_117_1:Find("up")

	local function var_117_5()
		local var_118_0 = var_0

		math = var_2_10001
		var_118_0.value = var_2_10001.clamp(var_0.value + var_117_2, var_0.minValue, var_0.maxValue)

		return
	end

	SFX_PANEL = var_9

	var_5(var_117_3, var_117_4, var_117_5, var_9)

	onButton = var_5

	local var_117_6 = arg_117_0
	local var_117_7 = arg_117_1:Find("down")

	local function var_117_8()
		local var_119_0 = var_0

		math = var_2_10001
		var_119_0.value = var_2_10001.clamp(var_0.value - var_117_2, var_0.minValue, var_0.maxValue)

		return
	end

	SFX_PANEL = var_9

	var_5(var_117_6, var_117_7, var_117_8, var_9)

	return
end

local var_0_209 = OnSliderWithButton

local function var_0_210(arg_120_0, arg_120_1, arg_120_2, arg_120_3, arg_120_4)
	GetOrAddComponent = var_1_10005

	local var_120_0 = var_1_10005(arg_120_1, "EventTriggerListener")
	local var_120_1
	local var_120_2 = 0
	local var_120_3 = 50

	var_120_0:AddPointDownFunc(function()
		var_120_2 = 0
		var_120_1 = nil

		return
	end)
	var_120_0:AddDragFunc(function(arg_122_0, arg_122_1)
		local var_122_0 = arg_122_1.position

		if not var_120_1 then
			var_120_1 = var_122_0
		end

		local var_122_1 = arg_120_0

		SLIP_TYPE_HRZ = var_2_10004

		if var_122_1 == var_2_10004 then
			var_120_2 = var_122_0.x - var_120_1.x
		else
			local var_122_2 = arg_120_0

			SLIP_TYPE_VERT = var_2_10004

			if var_122_2 == var_2_10004 then
				var_120_2 = var_122_0.y - var_120_1.y
			end
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

local var_0_211 = addSlip

local function var_0_212()
	pg = var_1_10000

	local var_124_0 = var_1_10000.UIMgr.GetInstance().LevelMain.transform.rect

	UnityEngine = var_1_10001

	local var_124_1 = var_1_10001.Screen

	Vector2 = var_1_10002

	return var_1_10002.New(var_124_0.width / var_124_1.width, var_124_0.height / var_124_1.height), var_124_0.width, var_124_0.height
end

local var_0_213 = getSizeRate

local function var_0_214()
	Application = var_1_10000

	local var_125_0 = var_1_10000.internetReachability

	UnityEngine = var_1_10001

	return var_125_0 == var_1_10001.NetworkReachability.ReachableViaLocalAreaNetwork
end

local var_0_215 = IsUsingWifi

local function var_0_216(arg_126_0)
	local var_126_0 = {}

	ipairs = var_1_10002

	local var_126_1 = arg_126_0:GetRootGameObjects()

	for iter_126_0, iter_126_1 in var_1_10002(var_3.ToTable(var_126_1)) do
		var_126_0[iter_126_1.name] = iter_126_1.transform
	end

	return var_126_0
end

local var_0_217 = getSceneRootTFDic

local function var_0_218(arg_127_0, arg_127_1, arg_127_2)
	tf = var_1_10003

	local var_127_0 = var_1_10003(arg_127_1)
	local var_127_1 = var_3.GetComponent

	typeof = var_1_10005
	ComponentBinding = var_1_10006

	if var_127_1(var_127_0, var_1_10005(var_1_10006)) == nil then
		return
	end

	local var_127_2 = var_3:GetLuaNames()
	local var_127_3 = var_4.ToTable(var_127_2)
	local var_127_4 = var_3:GetComponentValues()
	local var_127_5 = var_5.ToTable(var_127_4)

	ipairs = var_127_4

	for iter_127_0, iter_127_1 in var_127_4(var_127_3) do
		local var_127_6

		if arg_127_2 or not var_127_5[iter_127_0] then
			var_127_6 = nil
		end

		arg_127_0[iter_127_1] = var_127_6
	end

	return
end

local var_0_219 = bindComponent

return
