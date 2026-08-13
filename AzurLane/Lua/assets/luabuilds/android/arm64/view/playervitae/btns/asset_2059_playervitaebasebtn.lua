class = var_0_10000

local var_0_0 = var_0_10000("PlayerVitaeBaseBtn")

var_0_0.HRZ_TYPE = 1
var_0_0.VEC_TYPE = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.type = arg_1_2 or var_0_0.HRZ_TYPE
	arg_1_0.tpl = arg_1_1
	isActive = var_3

	if var_3(arg_1_1) then
		setActive = var_3

		var_3(arg_1_1, false)
	end

	arg_1_0.isLoaded = false
	arg_1_0.startPos = arg_1_0.tpl.anchoredPosition
	Object = var_3
	arg_1_0.tf = var_3.Instantiate(arg_1_0.tpl, arg_1_0.tpl.parent).transform

	arg_1_0:Hide()

	return
end

function var_0_0.IsHrzType(arg_2_0)
	return arg_2_0.type == var_0_0.HRZ_TYPE
end

function var_0_0.NewGo(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0:GetBgName()
	local var_3_2 = arg_3_0.tf
	local var_3_3 = var_3.GetComponent

	typeof = var_1_10006
	Image = var_1_10008

	local var_3_4 = var_3_3(var_3_2, var_1_10006(var_1_10008))

	LoadSprite = var_1_10004
	var_3_4.sprite = var_1_10004("ui/" .. var_3_0, var_3_1)

	var_3_4:SetNativeSize()
	arg_3_0:Show()

	return arg_3_0.tf
end

function var_0_0.Load(arg_4_0, arg_4_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_4_0)

	findTF = var_2
	arg_4_0.on = var_2(arg_4_0.tf, "on")
	findTF = var_2
	arg_4_0.off = var_2(arg_4_0.tf, "off")
	findTF = var_2
	arg_4_0.block = var_2(arg_4_0.tf, "block")
	findTF = var_2
	arg_4_0.stateTr = var_2(arg_4_0.tf, "state")
	findTF = var_2
	arg_4_0.onTxt = var_2(arg_4_0.tf, "on_Text")
	findTF = var_2
	arg_4_0.offTxt = var_2(arg_4_0.tf, "off_Text")

	arg_4_0:InitBtn()

	arg_4_0.isLoaded = true

	return
end

function var_0_0.IsActive(arg_5_0)
	return false
end

function var_0_0.Update(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 then
		arg_6_0:Hide()

		return
	end

	arg_6_0.index = arg_6_2
	arg_6_0.ship = arg_6_3

	if not arg_6_0.isLoaded then
		arg_6_0:Load(arg_6_0:NewGo())
	else
		if arg_6_0.flag ~= arg_6_0:GetDefaultValue() then
			arg_6_0:InitBtn()
		end

		arg_6_0:Show()
	end

	arg_6_0:UpdatePosition()

	return
end

function var_0_0.UpdatePosition(arg_7_0)
	if arg_7_0:IsHrzType() then
		arg_7_0:UpdatePositionForHrz()
	else
		arg_7_0:UpdatePositionForVec()
	end

	return
end

function var_0_0.SwitchToVecLayout(arg_8_0)
	local var_8_0 = arg_8_0.startPos
	local var_8_1 = arg_8_0.index
	local var_8_2 = arg_8_0.tf.sizeDelta.y
	local var_8_3 = 20
	local var_8_4 = (var_8_1 - 1) * (var_8_2 + var_8_3) + var_8_0.y
	local var_8_5 = arg_8_0.tf

	Vector2 = var_1_10007
	var_8_5.anchoredPosition = var_1_10007(var_8_0.x, var_8_4)

	return
end

function var_0_0.IsOverlap(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.tf.rect.width * 0.5

	return arg_9_1 < arg_9_0.tf.localPosition.x + var_9_0
end

function var_0_0.UpdatePositionForHrz(arg_10_0)
	local var_10_0 = arg_10_0.startPos
	local var_10_1 = arg_10_0.index
	local var_10_2 = 0
	local var_10_3 = 20

	PLATFORM_CODE = var_1_10005
	PLATFORM_US = var_1_10006

	if var_1_10005 == var_1_10006 then
		var_10_2 = 310
		var_10_3 = 10
	else
		var_10_2 = arg_10_0.tf.sizeDelta.x
	end

	local var_10_4 = (var_10_1 - 1) * (var_10_2 + var_10_3) + var_10_0.x
	local var_10_5 = arg_10_0.tf

	Vector2 = var_1_10007
	var_10_5.anchorMax = var_1_10007(0, 0)

	local var_10_6 = arg_10_0.tf

	Vector2 = var_7
	var_10_6.anchorMin = var_7(0, 0)

	local var_10_7 = arg_10_0.tf

	Vector2 = var_7
	var_10_7.anchoredPosition = var_7(var_10_4, var_10_0.y)

	return
end

function var_0_0.UpdatePositionForVec(arg_11_0)
	local var_11_0 = arg_11_0.startPos
	local var_11_1 = arg_11_0.index
	local var_11_2 = arg_11_0.tf.sizeDelta.y
	local var_11_3 = 20
	local var_11_4 = (var_11_1 - 1) * (var_11_2 + var_11_3) + var_11_0.y
	local var_11_5 = arg_11_0.tf

	Vector2 = var_1_10007
	var_11_5.anchorMax = var_1_10007(0, 1)

	local var_11_6 = arg_11_0.tf

	Vector2 = var_7
	var_11_6.anchorMin = var_7(0, 1)

	local var_11_7 = arg_11_0.tf

	Vector2 = var_7
	var_11_7.anchoredPosition = var_7(var_11_0.x, var_11_4)

	return
end

local function var_0_1(arg_12_0, arg_12_1)
	if arg_12_0:IsHrzType() then
		local var_12_0 = arg_12_0.block

		if arg_12_1 then
			Vector2 = var_1_10003

			if not var_1_10003(-33, 0) then
				Vector2 = var_1_10003
				var_1_10003 = var_1_10003(-96, 0)
			end

			var_12_0.anchoredPosition = var_1_10003

			if false then
				setActive = var_12_0

				var_12_0(arg_12_0.off, not arg_12_1)

				setActive = var_12_0

				var_12_0(arg_12_0.on, arg_12_1)

				local var_12_1 = arg_12_1 and "#FFFFFFFF" or "#5A6177"
				local var_12_2 = arg_12_1 and "#5A6177" or "#FFFFFFFF"
				local var_12_3 = arg_12_0.onTxt
				local var_12_4 = var_4.GetComponent

				typeof = var_1_10007
				Text = var_1_10009
				var_12_4(var_12_3, var_1_10007(var_1_10009)).text = "<color=" .. var_12_1 .. ">ON</color>"

				local var_12_5 = arg_12_0.offTxt
				local var_12_6 = var_4.GetComponent

				typeof = var_7
				Text = var_1_10009
				var_12_6(var_12_5, var_7(var_1_10009)).text = "<color=" .. var_12_2 .. ">OFF</color>"
			end

			return
		end
	end
end

function var_0_0.InitBtn(arg_13_0)
	arg_13_0.flag = arg_13_0:GetDefaultValue()
	onButton = var_1

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.tf

	local function var_13_2()
		local var_14_0 = arg_13_0

		if var_0.OnSwitch(var_14_0, not arg_13_0.flag) then
			arg_13_0.flag = not arg_13_0.flag

			var_0_1(arg_13_0, arg_13_0.flag)

			local var_14_1 = arg_13_0

			var_0.OnSwitchDone(var_14_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_13_0, var_13_1, var_13_2, var_1_10006)
	arg_13_0:UpdateBtnState(false, arg_13_0.flag)

	return
end

function var_0_0.UpdateBtnState(arg_15_0, arg_15_1, arg_15_2)
	setActive = var_1_10003

	var_1_10003(arg_15_0.on, not arg_15_1)

	setActive = var_1_10003

	var_1_10003(arg_15_0.off, not arg_15_1)

	if arg_15_0:IsHrzType() then
		setActive = var_3

		var_3(arg_15_0.block, not arg_15_1)
	end

	setActive = var_3

	var_3(arg_15_0.stateTr, arg_15_1)

	if not arg_15_1 then
		var_0_1(arg_15_0, arg_15_2)
	end

	return
end

function var_0_0.Show(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0.tf, true)

	return
end

function var_0_0.Hide(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.tf, false)

	return
end

function var_0_0.ShowOrHide(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0:Show()
	else
		arg_18_0:Hide()
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.isLoaded then
		pg = var_1

		var_1.DelegateInfo.Dispose(arg_19_0)

		Object = var_1

		var_1.Destroy(arg_19_0.tf.gameObject)
	end

	arg_19_0:OnDispose()

	return
end

function var_0_0.GetBgName(arg_20_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.GetDefaultValue(arg_21_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.OnSwitch(arg_22_0, arg_22_1)
	assert = var_1_10002

	var_1_10002(false, "overwrite me !!!")

	return
end

function var_0_0.OnSwitchDone(arg_23_0)
	return
end

function var_0_0.OnDispose(arg_24_0)
	return
end

function var_0_0.setParent(arg_25_0, arg_25_1, arg_25_2)
	SetParent = var_1_10003

	var_1_10003(arg_25_0.tf, arg_25_1)

	local var_25_0 = arg_25_0.tf

	var_3.SetSiblingIndex(var_25_0, arg_25_2)

	return
end

return var_0_0
