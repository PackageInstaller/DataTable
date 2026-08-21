local var_0_0 = class("PlayerVitaeBaseBtn")

var_0_0.HRZ_TYPE = 1
var_0_0.VEC_TYPE = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.type = arg_1_2 or var_0_0.HRZ_TYPE
	arg_1_0.tpl = arg_1_1

	if isActive(arg_1_1) then
		setActive(arg_1_1, false)
	end

	arg_1_0.isLoaded = false
	arg_1_0.startPos = arg_1_0.tpl.anchoredPosition
	arg_1_0.tf = Object.Instantiate(arg_1_0.tpl, arg_1_0.tpl.parent).transform

	arg_1_0:Hide()

	return
end

function var_0_0.IsHrzType(arg_2_0)
	return arg_2_0.type == var_0_0.HRZ_TYPE
end

function var_0_0.NewGo(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0:GetBgName()
	local var_3_2 = arg_3_0.tf:GetComponent(typeof(Image))

	var_3_2.sprite = LoadSprite("ui/" .. var_3_0, var_3_1)

	var_3_2:SetNativeSize()
	arg_3_0:Show()

	return arg_3_0.tf
end

function var_0_0.Load(arg_4_0, arg_4_1)
	pg.DelegateInfo.New(arg_4_0)

	arg_4_0.on = findTF(arg_4_0.tf, "on")
	arg_4_0.off = findTF(arg_4_0.tf, "off")
	arg_4_0.block = findTF(arg_4_0.tf, "block")
	arg_4_0.stateTr = findTF(arg_4_0.tf, "state")
	arg_4_0.onTxt = findTF(arg_4_0.tf, "on_Text")
	arg_4_0.offTxt = findTF(arg_4_0.tf, "off_Text")

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
	arg_8_0.tf.anchoredPosition = Vector2(arg_8_0.startPos.x, (arg_8_0.index - 1) * (arg_8_0.tf.sizeDelta.y + 20) + arg_8_0.startPos.y)

	return
end

function var_0_0.IsOverlap(arg_9_0, arg_9_1)
	return arg_9_1 < arg_9_0.tf.localPosition.x + arg_9_0.tf.rect.width * 0.5
end

function var_0_0.UpdatePositionForHrz(arg_10_0)
	local var_10_0 = arg_10_0.index
	local var_10_1 = 0
	local var_10_2 = 20

	if PLATFORM_CODE == PLATFORM_US then
		var_10_1 = 310
		var_10_2 = 10
	else
		var_10_1 = arg_10_0.tf.sizeDelta.x
	end

	local var_10_3 = (var_10_0 - 1) * (var_10_1 + var_10_2) + arg_10_0.startPos.x

	arg_10_0.tf.anchorMax = Vector2(0, 0)
	arg_10_0.tf.anchorMin = Vector2(0, 0)
	arg_10_0.tf.anchoredPosition = Vector2(var_10_3, arg_10_0.startPos.y)

	return
end

function var_0_0.UpdatePositionForVec(arg_11_0)
	arg_11_0.tf.anchorMax = Vector2(0, 1)
	arg_11_0.tf.anchorMin = Vector2(0, 1)
	arg_11_0.tf.anchoredPosition = Vector2(arg_11_0.startPos.x, (arg_11_0.index - 1) * (arg_11_0.tf.sizeDelta.y + 20) + arg_11_0.startPos.y)

	return
end

local function var_0_1(arg_12_0, arg_12_1)
	if arg_12_0:IsHrzType() then
		local var_12_0 = arg_12_0.block

		var_12_0.anchoredPosition = arg_12_1 and Vector2(-33, 0) or Vector2(-96, 0)
	else
		setActive(arg_12_0.off, not arg_12_1)
		setActive(arg_12_0.on, arg_12_1)

		local var_12_1 = arg_12_1 and "#5A6177" or "#FFFFFFFF"

		arg_12_0.onTxt:GetComponent(typeof(Text)).text = "<color=" .. (arg_12_1 and "#FFFFFFFF" or "#5A6177") .. ">ON</color>"
		arg_12_0.offTxt:GetComponent(typeof(Text)).text = "<color=" .. var_12_1 .. ">OFF</color>"
	end

	return
end

function var_0_0.InitBtn(arg_13_0)
	arg_13_0.flag = arg_13_0:GetDefaultValue()

	onButton(arg_13_0, arg_13_0.tf, function()
		if arg_13_0:OnSwitch(not arg_13_0.flag) then
			arg_13_0.flag = not arg_13_0.flag

			var_0_1(arg_13_0, arg_13_0.flag)
			arg_13_0:OnSwitchDone()
		end

		return
	end, SFX_PANEL)
	arg_13_0:UpdateBtnState(false, arg_13_0.flag)

	return
end

function var_0_0.UpdateBtnState(arg_15_0, arg_15_1, arg_15_2)
	setActive(arg_15_0.on, not arg_15_1)
	setActive(arg_15_0.off, not arg_15_1)

	if arg_15_0:IsHrzType() then
		setActive(arg_15_0.block, not arg_15_1)
	end

	setActive(arg_15_0.stateTr, arg_15_1)

	if not arg_15_1 then
		var_0_1(arg_15_0, arg_15_2)
	end

	return
end

function var_0_0.Show(arg_16_0)
	setActive(arg_16_0.tf, true)

	return
end

function var_0_0.Hide(arg_17_0)
	setActive(arg_17_0.tf, false)

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
		pg.DelegateInfo.Dispose(arg_19_0)
		Object.Destroy(arg_19_0.tf.gameObject)
	end

	arg_19_0:OnDispose()

	return
end

function var_0_0.GetBgName(arg_20_0)
	assert(false, "overwrite me !!!")

	return
end

function var_0_0.GetDefaultValue(arg_21_0)
	assert(false, "overwrite me !!!")

	return
end

function var_0_0.OnSwitch(arg_22_0, arg_22_1)
	assert(false, "overwrite me !!!")

	return
end

function var_0_0.OnSwitchDone(arg_23_0)
	return
end

function var_0_0.OnDispose(arg_24_0)
	return
end

function var_0_0.setParent(arg_25_0, arg_25_1, arg_25_2)
	SetParent(arg_25_0.tf, arg_25_1)
	arg_25_0.tf:SetSiblingIndex(arg_25_2)

	return
end

return var_0_0
