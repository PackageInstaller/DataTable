class = var_0_10000

local var_0_0 = "CustomDropdown"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IndexDropdownUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.tag = arg_2_4
	arg_2_0.virtualBtn = arg_2_5
	findTF = var_6
	arg_2_0.virtualBtnTitle = var_6(arg_2_0.virtualBtn, "Image")
	findTF = var_6
	arg_2_0.virtualBtnDropdownSign = var_6(arg_2_0.virtualBtn, "dropdown")
	arg_2_0.setting = arg_2_0.contextData.customPanels[arg_2_0.tag]

	local var_2_0

	if not arg_2_0.setting.mode then
		CustomIndexLayer = var_2_0
		var_2_0 = var_2_0.Mode.OR
	end

	arg_2_0.mode = var_2_0
	arg_2_0.options = arg_2_0.setting.options
	arg_2_0.names = arg_2_0.setting.names

	arg_2_0:UpdateVirtualBtn()

	return
end

function var_0_1.UpdateVirtualBtn(arg_3_0)
	local var_3_0 = arg_3_0.contextData.indexDatas
	local var_3_1 = arg_3_0.tag
	local var_3_2

	if not arg_3_0.contextData.indexDatas[arg_3_0.tag] then
		var_3_2 = arg_3_0.options[1]
	end

	var_3_0[var_3_1] = var_3_2
	table = var_3_0
	arg_3_0.preIndex = var_3_0.indexof(arg_3_0.options, arg_3_0.contextData.indexDatas[arg_3_0.tag])
	setText = var_1

	local var_3_3 = arg_3_0.virtualBtnTitle

	i18n = var_3

	var_1(var_3_3, var_3(arg_3_0.names[arg_3_0.preIndex]))

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.btnTpl = var_1.Find(var_4_0, "resource/tpl")
	arg_4_0.btnList = {}

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "resource/grey")
	local var_4_3 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_4_0.greySprite = var_4_3(var_4_2, var_3(var_1_10004)).sprite

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_1.Find(var_4_4, "resource/yellow")
	local var_4_6 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_4_0.yellowSprite = var_4_6(var_4_5, var_3(var_1_10004)).sprite
	tf = var_1
	instantiate = var_4_5
	arg_4_0.mainBtn = var_1(var_4_5(arg_4_0.btnTpl))

	local var_4_7 = arg_4_0.mainBtn

	arg_4_0.mainTitle = var_1.Find(var_4_7, "Image")
	setImageSprite = var_1

	var_1(arg_4_0.mainBtn, arg_4_0.yellowSprite)

	setParent = var_1

	var_1(arg_4_0.mainBtn, arg_4_0._tf)

	setActive = var_1

	var_1(arg_4_0.mainBtn, true)

	local var_4_8 = arg_4_0.mainBtn
	local var_4_9 = var_1.Find(var_4_8, "dropdown")

	Vector3 = var_4_8
	var_4_9.localEulerAngles = var_4_8.New(0, 0, 0)
	onButton = var_4_9

	var_4_9(arg_4_0, arg_4_0.mainBtn, function()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end)

	local var_4_10 = arg_4_0._tf
	local var_4_11 = var_1.Find(var_4_10, "mask")

	onButton = var_4_10

	var_4_10(arg_4_0, var_4_11, function()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end)

	local var_4_12 = arg_4_0._tf

	arg_4_0.attrs = var_2.Find(var_4_12, "Attrs")
	GetComponent = var_2

	local var_4_13 = arg_4_0.attrs

	typeof = var_4
	GridLayoutGroup = var_5

	local var_4_14 = var_2(var_4_13, var_4(var_5))

	if #arg_4_0.options > 6 then
		var_4_14.constraintCount = 2
	else
		var_4_14.constraintCount = 1
	end

	for iter_4_0 = 1, #arg_4_0.options do
		local var_4_15 = arg_4_0.options[iter_4_0]

		if iter_4_0 == 1 then
			-- block empty
		else
			tf = var_1_10008
			instantiate = var_1_10009

			local var_4_16 = var_1_10008(var_1_10009(arg_4_0.btnTpl))

			var_1_10009 = var_1_10008.Find(var_4_16, "Image")
			go = var_4_16

			local var_4_17 = var_4_16(var_1_10008)

			i18n = var_11
			var_4_17.name = var_11(arg_4_0.names[iter_4_0])
			setActive = var_4_17

			var_4_17(var_1_10008, true)

			setActive = var_4_17

			var_4_17(var_1_10008:Find("dropdown"), false)

			setText = var_4_17

			local var_4_18 = var_1_10009

			i18n = var_12

			var_4_17(var_4_18, var_12(arg_4_0.names[iter_4_0]))

			setParent = var_4_17

			var_4_17(var_1_10008, arg_4_0.attrs)

			onButton = var_4_17

			local var_4_19 = arg_4_0
			local var_4_20 = var_1_10008

			local function var_4_21()
				local var_7_0 = arg_4_0

				var_0.UpdateData(var_7_0, iter_4_0)

				local var_7_1 = arg_4_0

				var_0.UpdateBtnState(var_7_1)

				return
			end

			SFX_UI_TAG = var_1_10014

			var_4_17(var_4_19, var_4_20, var_4_21, var_1_10014)

			table = var_4_17

			var_4_17.insert(arg_4_0.btnList, var_1_10008)
		end
	end

	arg_4_0:SelectLast()

	return
end

function var_0_1.SelectLast(arg_8_0)
	arg_8_0:UpdateBtnState()

	return
end

function var_0_1.UpdateData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.contextData.indexDatas[arg_9_0.tag]

	bit = var_3

	local var_9_1 = var_3.band(var_9_0, arg_9_0.options[arg_9_1]) > 0
	local var_9_2 = arg_9_0.mode

	CustomIndexLayer = var_5

	local var_9_4

	if var_9_2 == var_5.Mode.AND then
		if var_9_1 then
			arg_9_0.contextData.indexDatas[arg_9_0.tag] = var_9_0 - arg_9_0.options[arg_9_1]
		else
			local var_9_3 = arg_9_0.contextData.indexDatas

			var_9_4 = arg_9_0.tag
			bit = var_1_10006
			var_9_3[var_9_4] = var_1_10006.bxor(var_9_0, arg_9_0.options[arg_9_1])
		end
	else
		local var_9_5 = arg_9_0.mode

		CustomIndexLayer = var_9_4

		if var_9_5 == var_9_4.Mode.OR then
			if var_9_0 ~= arg_9_0.options[1] and var_9_1 then
				arg_9_0.contextData.indexDatas[arg_9_0.tag] = var_9_0 - arg_9_0.options[arg_9_1]
			else
				arg_9_0.contextData.indexDatas[arg_9_0.tag] = arg_9_0.options[arg_9_1]
			end

			if arg_9_0.contextData.indexDatas[arg_9_0.tag] == 0 then
				arg_9_0.contextData.indexDatas[arg_9_0.tag] = arg_9_0.options[1]
			end
		end
	end

	return
end

function var_0_1.UpdateBtnState(arg_10_0)
	local function var_10_0(arg_11_0)
		setText = var_2_10001

		local var_11_0 = arg_10_0.mainTitle

		i18n = var_2_10003

		var_2_10001(var_11_0, var_2_10003(arg_10_0.names[arg_11_0]))

		setText = var_2_10001

		local var_11_1 = arg_10_0.virtualBtnTitle

		i18n = var_3

		var_2_10001(var_11_1, var_3(arg_10_0.names[arg_11_0]))

		return
	end

	local var_10_1 = arg_10_0.mode

	CustomIndexLayer = var_1_10003

	if var_10_1 == var_1_10003.Mode.AND then
		if arg_10_0.contextData.indexDatas[arg_10_0.tag] == arg_10_0.options[1] then
			ipairs = var_2

			for iter_10_0, iter_10_1 in var_2(arg_10_0.btnList) do
				setImageSprite = var_1_10007

				var_1_10007(iter_10_1, arg_10_0.greySprite)
			end
		else
			ipairs = var_2

			for iter_10_2, iter_10_3 in var_2(arg_10_0.btnList) do
				bit = var_1_10007
				var_1_10007 = var_1_10007.band(arg_10_0.contextData.indexDatas[arg_10_0.tag], arg_10_0.options[iter_10_2 + 1])
				var_1_10007 = 0 < var_1_10007
				setImageSprite = var_8

				local var_10_2 = iter_10_3
				local var_10_3

				if not var_1_10007 or not arg_10_0.yellowSprite then
					var_10_3 = arg_10_0.greySprite
				end

				var_8(var_10_2, var_10_3)
			end
		end

		var_10_0(1)
	else
		local var_10_4 = arg_10_0.mode

		CustomIndexLayer = var_3

		if var_10_4 == var_3.Mode.OR then
			local var_10_5 = false

			ipairs = var_3

			for iter_10_4, iter_10_5 in var_3(arg_10_0.btnList) do
				local var_10_6 = arg_10_0.options[iter_10_4 + 1] == arg_10_0.contextData.indexDatas[arg_10_0.tag]

				setImageSprite = var_9

				local var_10_7 = iter_10_5
				local var_10_8

				if not var_10_6 or not arg_10_0.yellowSprite then
					var_10_8 = arg_10_0.greySprite
				end

				var_9(var_10_7, var_10_8)

				if var_10_6 then
					var_10_5 = true

					var_10_0(iter_10_4 + 1)
				end
			end

			if not var_10_5 then
				var_10_0(1)
			end
		end
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
