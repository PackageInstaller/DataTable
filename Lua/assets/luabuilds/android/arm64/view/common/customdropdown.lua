local var_0_0 = class("CustomDropdown", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IndexDropdownUI"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.tag = arg_2_4
	arg_2_0.virtualBtn = arg_2_5
	arg_2_0.virtualBtnTitle = findTF(arg_2_0.virtualBtn, "Image")
	arg_2_0.virtualBtnDropdownSign = findTF(arg_2_0.virtualBtn, "dropdown")
	arg_2_0.setting = arg_2_0.contextData.customPanels[arg_2_0.tag]
	arg_2_0.mode = arg_2_0.setting.mode or CustomIndexLayer.Mode.OR
	arg_2_0.options = arg_2_0.setting.options
	arg_2_0.names = arg_2_0.setting.names

	arg_2_0:UpdateVirtualBtn()

	return
end

function var_0_0.UpdateVirtualBtn(arg_3_0)
	arg_3_0.contextData.indexDatas[arg_3_0.tag] = arg_3_0.contextData.indexDatas[arg_3_0.tag] or arg_3_0.options[1]
	arg_3_0.preIndex = table.indexof(arg_3_0.options, arg_3_0.contextData.indexDatas[arg_3_0.tag])

	setText(arg_3_0.virtualBtnTitle, i18n(arg_3_0.names[arg_3_0.preIndex]))

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.btnTpl = arg_4_0._tf:Find("resource/tpl")
	arg_4_0.btnList = {}
	arg_4_0.greySprite = arg_4_0._tf:Find("resource/grey"):GetComponent(typeof(Image)).sprite
	arg_4_0.yellowSprite = arg_4_0._tf:Find("resource/yellow"):GetComponent(typeof(Image)).sprite
	arg_4_0.mainBtn = tf(instantiate(arg_4_0.btnTpl))
	arg_4_0.mainTitle = arg_4_0.mainBtn:Find("Image")

	setImageSprite(arg_4_0.mainBtn, arg_4_0.yellowSprite)
	setParent(arg_4_0.mainBtn, arg_4_0._tf)
	setActive(arg_4_0.mainBtn, true)

	arg_4_0.mainBtn:Find("dropdown").localEulerAngles = Vector3.New(0, 0, 0)

	onButton(arg_4_0, arg_4_0.mainBtn, function()
		arg_4_0:Hide()

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("mask"), function()
		arg_4_0:Hide()

		return
	end)

	arg_4_0.attrs = arg_4_0._tf:Find("Attrs")

	local var_4_0 = GetComponent(arg_4_0.attrs, typeof(GridLayoutGroup))

	var_4_0.constraintCount = #arg_4_0.options > 6 and 2 or 1

	for iter_4_0 = 1, #arg_4_0.options do
		if iter_4_0 == 1 then
			-- block empty
		else
			local var_4_2 = tf(instantiate(arg_4_0.btnTpl))
			local var_4_3 = var_4_2:Find("Image")

			go(var_4_2).name = i18n(arg_4_0.names[iter_4_0])

			setActive(var_4_2, true)
			setActive(var_4_2:Find("dropdown"), false)
			setText(var_4_3, i18n(arg_4_0.names[iter_4_0]))
			setParent(var_4_2, arg_4_0.attrs)
			onButton(arg_4_0, var_4_2, function()
				arg_4_0:UpdateData(iter_4_0)
				arg_4_0:UpdateBtnState()

				return
			end, SFX_UI_TAG)
			table.insert(arg_4_0.btnList, var_4_2)
		end
	end

	arg_4_0:SelectLast()

	return
end

function var_0_0.SelectLast(arg_8_0)
	arg_8_0:UpdateBtnState()

	return
end

function var_0_0.UpdateData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.contextData.indexDatas[arg_9_0.tag]
	local var_9_1 = bit.band(arg_9_0.contextData.indexDatas[arg_9_0.tag], arg_9_0.options[arg_9_1]) > 0

	if arg_9_0.mode == CustomIndexLayer.Mode.AND then
		arg_9_0.contextData.indexDatas[arg_9_0.tag] = var_9_1 and var_9_0 - arg_9_0.options[arg_9_1] or bit.bxor(var_9_0, arg_9_0.options[arg_9_1])
	elseif arg_9_0.mode == CustomIndexLayer.Mode.OR then
		arg_9_0.contextData.indexDatas[arg_9_0.tag] = var_9_0 ~= arg_9_0.options[1] and var_9_1 and var_9_0 - arg_9_0.options[arg_9_1] or arg_9_0.options[arg_9_1]

		if arg_9_0.contextData.indexDatas[arg_9_0.tag] == 0 then
			arg_9_0.contextData.indexDatas[arg_9_0.tag] = arg_9_0.options[1]
		end
	end

	return
end

function var_0_0.UpdateBtnState(arg_10_0)
	if arg_10_0.mode == CustomIndexLayer.Mode.AND then
		if arg_10_0.contextData.indexDatas[arg_10_0.tag] == arg_10_0.options[1] then
			for iter_10_0, iter_10_1 in ipairs(arg_10_0.btnList) do
				setImageSprite(iter_10_1, arg_10_0.greySprite)
			end
		else
			for iter_10_2, iter_10_3 in ipairs(arg_10_0.btnList) do
				local var_10_1 = iter_10_3

				if bit.band(arg_10_0.contextData.indexDatas[arg_10_0.tag], arg_10_0.options[iter_10_2 + 1]) > 0 then
					local var_10_2 = arg_10_0.yellowSprite or arg_10_0.greySprite

					var_10_0(var_10_1, var_10_2)
				end
			end
		end

		;(function(arg_11_0)
			setText(arg_10_0.mainTitle, i18n(arg_10_0.names[arg_11_0]))
			setText(arg_10_0.virtualBtnTitle, i18n(arg_10_0.names[arg_11_0]))

			return
		end)(1)
	elseif arg_10_0.mode == CustomIndexLayer.Mode.OR then
		local var_10_3 = false

		for iter_10_4, iter_10_5 in ipairs(arg_10_0.btnList) do
			local var_10_4 = arg_10_0.options[iter_10_4 + 1] == arg_10_0.contextData.indexDatas[arg_10_0.tag]
			local var_10_6 = iter_10_5

			if arg_10_0.options[iter_10_4 + 1] == arg_10_0.contextData.indexDatas[arg_10_0.tag] then
				local var_10_7 = arg_10_0.yellowSprite or arg_10_0.greySprite

				var_10_5(var_10_6, var_10_7)

				if var_10_4 then
					var_10_3 = true

					;(function(arg_11_0)
						setText(arg_10_0.mainTitle, i18n(arg_10_0.names[arg_11_0]))
						setText(arg_10_0.virtualBtnTitle, i18n(arg_10_0.names[arg_11_0]))

						return
					end)(iter_10_4 + 1)
				end
			end
		end

		if not var_10_3 then
			(function(arg_11_0)
				setText(arg_10_0.mainTitle, i18n(arg_10_0.names[arg_11_0]))
				setText(arg_10_0.virtualBtnTitle, i18n(arg_10_0.names[arg_11_0]))

				return
			end)(1)
		end
	end

	return
end

function var_0_0.Show(arg_12_0, arg_12_1)
	arg_12_0.attrs.localPosition = arg_12_1
	arg_12_0.mainBtn.anchoredPosition = arg_12_0.attrs.anchoredPosition
	arg_12_0.attrs.anchoredPosition = arg_12_0.attrs.anchoredPosition + Vector2.New(0, -45)

	setActive(arg_12_0._tf, true)
	setActive(arg_12_0.virtualBtnDropdownSign, false)

	return
end

function var_0_0.Hide(arg_13_0)
	var_0_0.super.Hide(arg_13_0)
	setActive(arg_13_0.virtualBtnDropdownSign, true)

	return
end

function var_0_0.OnDestroy(arg_14_0)
	arg_14_0.btnList = nil

	return
end

return var_0_0
