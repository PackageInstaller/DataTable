class = var_0_10000

local var_0_0 = "SimpleDropdown"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IndexDropdownUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.tag = arg_2_4
	arg_2_0.virtualBtn = arg_2_5
	findTF = var_10
	arg_2_0.virtualBtnTitle = var_10(arg_2_0.virtualBtn, "Image")
	findTF = var_10
	arg_2_0.virtualBtnDropdownSign = var_10(arg_2_0.virtualBtn, "dropdown")
	arg_2_0.setting = arg_2_6
	arg_2_0.options = arg_2_0.setting.options
	arg_2_0.names = arg_2_0.setting.names
	arg_2_0.isSelected = true
	arg_2_0.onUpdate = arg_2_7
	arg_2_0.greySprite = arg_2_8
	arg_2_0.yellowSprite = arg_2_9

	arg_2_0:UpdateVirtualBtn()

	return
end

function var_0_1.UpdateVirtualBtn(arg_3_0)
	local var_3_0 = arg_3_0.contextData.indexDatas[arg_3_0.tag]

	table = var_2

	local var_3_1

	if not var_2.indexof(arg_3_0.options, var_3_0) then
		var_3_1 = 1
	end

	arg_3_0.preIndex = var_3_1
	setText = var_3_1

	local var_3_2 = arg_3_0.virtualBtnTitle

	i18n = var_5

	var_3_1(var_3_2, var_5(arg_3_0.names[arg_3_0.preIndex]))

	setImageSprite = var_3_1

	local var_3_3 = arg_3_0.virtualBtn
	local var_3_4

	if arg_3_0.preIndex ~= 1 or not arg_3_0.greySprite then
		var_3_4 = arg_3_0.yellowSprite
	end

	var_3_1(var_3_3, var_3_4)

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.btnTpl = var_1.Find(var_4_0, "resource/tpl")
	arg_4_0.btnList = {}
	tf = var_1
	instantiate = var_4_0
	arg_4_0.mainBtn = var_1(var_4_0(arg_4_0.btnTpl))

	local var_4_1 = arg_4_0.mainBtn

	arg_4_0.mainTitle = var_1.Find(var_4_1, "Image")
	setImageSprite = var_1

	var_1(arg_4_0.mainBtn, arg_4_0.yellowSprite)

	setParent = var_1

	var_1(arg_4_0.mainBtn, arg_4_0._tf)

	setActive = var_1

	var_1(arg_4_0.mainBtn, true)

	local var_4_2 = arg_4_0.mainBtn
	local var_4_3 = var_1.Find(var_4_2, "dropdown")

	Vector3 = var_1_10002
	var_4_3.localEulerAngles = var_1_10002.New(0, 0, 0)
	onButton = var_4_3

	var_4_3(arg_4_0, arg_4_0.mainBtn, function()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end)

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_1.Find(var_4_4, "mask")

	onButton = var_2

	var_2(arg_4_0, var_4_5, function()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end)

	local var_4_6 = arg_4_0._tf

	arg_4_0.attrs = var_2.Find(var_4_6, "Attrs")
	GetComponent = var_2

	local var_4_7 = arg_4_0.attrs

	typeof = var_5
	GridLayoutGroup = var_1_10007
	var_2(var_4_7, var_5(var_1_10007)).constraintCount = 1

	for iter_4_0 = 1, #arg_4_0.options do
		local var_4_8 = arg_4_0.options[iter_4_0]

		if iter_4_0 == 1 then
			-- block empty
		else
			tf = var_1_10008
			instantiate = var_1_10010

			local var_4_9 = var_1_10008(var_1_10010(arg_4_0.btnTpl))
			local var_4_10 = var_1_10008.Find(var_4_9, "Image")

			go = var_1_10010
			var_1_10010 = var_1_10010(var_1_10008)
			i18n = var_4_9
			var_1_10010.name = var_4_9(arg_4_0.names[iter_4_0])
			setActive = var_1_10010

			var_1_10010(var_1_10008, true)

			setActive = var_1_10010

			var_1_10010(var_1_10008:Find("dropdown"), false)

			setText = var_1_10010

			local var_4_11 = var_4_10

			i18n = var_13

			var_1_10010(var_4_11, var_13(arg_4_0.names[iter_4_0]))

			setParent = var_1_10010

			var_1_10010(var_1_10008, arg_4_0.attrs)

			onButton = var_1_10010

			local var_4_12 = arg_4_0
			local var_4_13 = var_1_10008

			local function var_4_14()
				local var_7_0 = arg_4_0

				var_0.UpdateData(var_7_0, iter_4_0)

				local var_7_1 = arg_4_0

				var_0.UpdateBtnState(var_7_1)

				return
			end

			SFX_UI_TAG = var_15

			var_1_10010(var_4_12, var_4_13, var_4_14, var_15)

			table = var_1_10010

			var_1_10010.insert(arg_4_0.btnList, var_1_10008)
		end
	end

	arg_4_0:UpdateVirtualBtn()
	arg_4_0:SelectLast()

	return
end

function var_0_1.SelectLast(arg_8_0)
	arg_8_0:UpdateBtnState()

	return
end

function var_0_1.UpdateData(arg_9_0, arg_9_1)
	arg_9_0.contextData.indexDatas[arg_9_0.tag] = arg_9_0.options[arg_9_1]

	if arg_9_0.onUpdate then
		arg_9_0.onUpdate()
	end

	return
end

function var_0_1.UpdateBtnState(arg_10_0)
	local function var_10_0(arg_11_0)
		setText = var_2_10001

		local var_11_0 = arg_10_0.mainTitle

		i18n = var_2_10004

		var_2_10001(var_11_0, var_2_10004(arg_10_0.names[arg_11_0]))

		setText = var_2_10001

		local var_11_1 = arg_10_0.virtualBtnTitle

		i18n = var_4

		var_2_10001(var_11_1, var_4(arg_10_0.names[arg_11_0]))

		return
	end

	local var_10_1 = false

	ipairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_0.btnList) do
		local var_10_2 = arg_10_0.options[iter_10_0 + 1] == arg_10_0.contextData.indexDatas[arg_10_0.tag]

		setImageSprite = var_9

		local var_10_3 = iter_10_1
		local var_10_4

		if not var_10_2 or not arg_10_0.yellowSprite then
			var_10_4 = arg_10_0.greySprite
		end

		var_9(var_10_3, var_10_4)

		if var_10_2 then
			var_10_1 = true

			var_10_0(iter_10_0 + 1)
		end
	end

	if not var_10_1 then
		var_10_0(1)
	end

	return
end

function var_0_1.Show(arg_12_0, arg_12_1)
	arg_12_0.attrs.localPosition = arg_12_1
	arg_12_0.mainBtn.anchoredPosition = arg_12_0.attrs.anchoredPosition

	local var_12_0 = arg_12_0.attrs
	local var_12_1 = arg_12_0.attrs.anchoredPosition

	Vector2 = var_1_10004
	var_12_0.anchoredPosition = var_12_1 + var_1_10004.New(0, -45)
	setActive = var_12_0

	var_12_0(arg_12_0._tf, true)

	setActive = var_12_0

	var_12_0(arg_12_0.virtualBtnDropdownSign, false)
	arg_12_0:UpdateBtnState()

	return
end

function var_0_1.Hide(arg_13_0)
	var_0_1.super.Hide(arg_13_0)

	setActive = var_1

	var_1(arg_13_0.virtualBtnDropdownSign, true)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	arg_14_0.btnList = nil

	return
end

return var_0_1
