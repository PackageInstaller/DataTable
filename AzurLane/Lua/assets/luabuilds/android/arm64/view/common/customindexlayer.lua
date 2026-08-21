local var_0_0 = class("CustomIndexLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CustomIndexUI"
end

var_0_0.Mode = {
	OR = 2,
	AND = 1,
	NUM = 3
}

function var_0_0.init(arg_2_0)
	arg_2_0.panel = arg_2_0._tf:Find("index_panel")
	arg_2_0.layout = arg_2_0.panel:Find("layout")
	arg_2_0.contianer = arg_2_0.layout:Find("container")

	eachChild(arg_2_0.contianer, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	arg_2_0.panelTemplate = arg_2_0.layout:Find("container/Template")
	arg_2_0.displayList = {}
	arg_2_0.typeList = {}
	arg_2_0.btnConfirm = arg_2_0.panel:Find("layout/btns/ok")
	arg_2_0.btnCancel = arg_2_0.panel:Find("layout/btns/cancel")

	setText(arg_2_0.btnConfirm:Find("Image"), i18n("text_confirm"))
	setText(arg_2_0.btnCancel:Find("Image"), i18n("text_cancel"))

	arg_2_0.greySprite = arg_2_0.panel:Find("resource/grey"):GetComponent(typeof(Image)).sprite
	arg_2_0.blueSprite = arg_2_0.panel:Find("resource/blue"):GetComponent(typeof(Image)).sprite
	arg_2_0.yellowSprite = arg_2_0.panel:Find("resource/yellow"):GetComponent(typeof(Image)).sprite

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0.btnConfirm, function()
		if arg_4_0.contextData.callback then
			arg_4_0.contextData.callback(arg_4_0.contextData.indexDatas)

			arg_4_0.contextData.callback = nil
		end

		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, arg_4_0.btnCancel, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.panel:Find("btn"), function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	arg_4_0:DoEnterAnimation()

	local var_4_0 = arg_4_0.contextData.tip or ""

	setText(arg_4_0.panel:Find("layout/tip"), var_4_0)
	arg_4_0:InitGroup()
	arg_4_0:BlurPanel()

	return
end

function var_0_0.DoEnterAnimation(arg_8_0)
	arg_8_0.panel.localScale = Vector3.zero

	LeanTween.scale(arg_8_0.panel, Vector3(1, 1, 1), 0.2)

	return
end

function var_0_0.BlurPanel(arg_9_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	return
end

function var_0_0.InitGroup(arg_10_0)
	arg_10_0.onInit = true
	arg_10_0.contextData.indexDatas = arg_10_0.contextData.indexDatas or {}
	arg_10_0.dropdownDic = {}
	arg_10_0.updateList = {}
	arg_10_0.simpleDropdownDic = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.contextData.groupList) do
		if iter_10_1.dropdown then
			arg_10_0:InitDropdown(iter_10_1)
		else
			arg_10_0:InitCustoms(iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.updateList) do
		iter_10_3()
	end

	if arg_10_0.contextData.customPanels.minHeight then
		GetOrAddComponent(arg_10_0.layout, typeof(LayoutElement)).minHeight = arg_10_0.contextData.customPanels.minHeight
	end

	if arg_10_0.contextData.customPanels.layoutPos then
		setLocalPosition(arg_10_0.layout, arg_10_0.contextData.customPanels.layoutPos)
	end

	arg_10_0.onInit = false

	return
end

function var_0_0.InitDropdown(arg_11_0, arg_11_1)
	local var_11_0 = tf(Instantiate(arg_11_0.panelTemplate))

	setParent(var_11_0, arg_11_0.contianer, false)
	setActive(var_11_0, true)

	local var_11_1 = var_0_0.Clone2Full(var_11_0:Find("bg"), #arg_11_1.tags)

	go(var_11_0).name = arg_11_1.titleTxt

	setText(var_11_0:Find("title/Image"), i18n(arg_11_1.titleTxt))
	setText(var_11_0:Find("title/Image/Image_en"), i18n(arg_11_1.titleENTxt))

	var_11_0:Find("bg"):GetComponent(typeof(ScrollRect)).enabled = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.tags) do
		local var_11_2 = var_11_1[iter_11_0]

		setActive(var_11_1[iter_11_0]:Find("dropdown"), true)

		local var_11_3 = CustomDropdown.New(arg_11_0.panel, arg_11_0.event, arg_11_0.contextData, iter_11_1, var_11_1[iter_11_0])

		onButton(arg_11_0, var_11_1[iter_11_0], function()
			if not var_11_3:GetLoaded() then
				var_11_3:Load()
			end

			var_11_3:ActionInvoke("Show", (arg_11_0.panel:InverseTransformPoint(var_11_2.position)))

			return
		end)

		arg_11_0.dropdownDic[iter_11_1] = var_11_3
	end

	return
end

function var_0_0.InitCustoms(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.tags[1]
	local var_13_1 = arg_13_0.contextData.customPanels[arg_13_1.tags[1]]
	local var_13_2 = tf(Instantiate(arg_13_0.panelTemplate))

	setParent(var_13_2, arg_13_0.contianer, false)
	setActive(var_13_2, true)

	go(var_13_2).name = arg_13_1.titleTxt

	setText(var_13_2:Find("title/Image"), i18n(arg_13_1.titleTxt))
	setText(var_13_2:Find("title/Image/Image_en"), i18n(arg_13_1.titleENTxt))

	var_13_2:Find("bg"):GetComponent(typeof(ScrollRect)).enabled = false

	local var_13_3 = var_13_1.options
	local var_13_4 = var_13_1.mode or var_0_0.Mode.OR
	local var_13_5 = 0
	local var_13_6 = var_13_1.blueSeleted and arg_13_0.blueSprite or arg_13_0.yellowSprite

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		var_13_5 = bit.bor(iter_13_1, var_13_5)
	end

	arg_13_0.contextData.indexDatas[var_13_0] = arg_13_0.contextData.indexDatas[var_13_0] or var_13_3[1]

	local var_13_7

	for iter_13_2, iter_13_3 in ipairs((var_0_0.Clone2Full(var_13_2:Find("bg"), #var_13_3))) do
		local var_13_8 = var_13_3[iter_13_2]

		setText(findTF(iter_13_3, "Image"), i18n(var_13_1.names[iter_13_2]))
		arg_13_0:UpdateBtnStyle(iter_13_3, arg_13_0.greySprite)
		onButton(arg_13_0, iter_13_3, function()
			switch(var_13_4, {
				[var_0_0.Mode.AND] = function()
					arg_13_0.contextData.indexDatas[var_13_0] = (iter_13_2 == 1 or arg_13_0.contextData.indexDatas[var_13_0] == var_13_3[1]) and var_13_8 or bit.bxor(arg_13_0.contextData.indexDatas[var_13_0], var_13_8)

					if arg_13_0.contextData.indexDatas[var_13_0] == 0 or arg_13_0.contextData.indexDatas[var_13_0] == var_13_5 then
						arg_13_0.contextData.indexDatas[var_13_0] = var_13_3[1]
					end

					return
				end,
				[var_0_0.Mode.OR] = function()
					local var_16_0, var_16_1

					if var_13_1.isSort then
						arg_13_0.contextData.indexDatas[var_13_0] = var_13_8

						goto label_16_0

						var_16_0 = arg_13_0.contextData.indexDatas
						var_16_1 = var_13_0
					end

					::label_16_0::

					if var_13_8 == arg_13_0.contextData.indexDatas[var_13_0] then
						var_16_0[var_16_1] = var_13_3[1] or var_13_8

						return
					end
				end,
				[var_0_0.Mode.NUM] = function()
					local var_17_0 = 0

					while arg_13_0.contextData.indexDatas[var_13_0] > 0 do
						var_17_0 = var_17_0 + 1

						local var_17_1 = bit.band(arg_13_0.contextData.indexDatas[var_13_0], arg_13_0.contextData.indexDatas[var_13_0] - 1)
					end

					if var_17_0 < var_13_1.num or bit.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_8) > 0 then
						arg_13_0.contextData.indexDatas[var_13_0] = bit.bxor(arg_13_0.contextData.indexDatas[var_13_0], var_13_8)
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_share_exceedlimit"))
					end

					return
				end
			})
			var_13_7()

			return
		end, SFX_UI_TAG)
	end

	function var_13_7()
		switch(var_13_4, {
			[var_0_0.Mode.AND] = function()
				if arg_13_0.contextData.indexDatas[var_13_0] == var_13_3[1] then
					for iter_19_0, iter_19_1 in ipairs(var_0) do
						local var_19_0 = findTF(iter_19_1, "Image")
						local var_19_1 = arg_13_0
						local var_19_3 = iter_19_1

						if var_13_3[iter_19_0] == var_13_3[1] then
							local var_19_4 = var_13_6 or arg_13_0.greySprite

							var_19_2(var_19_1, var_19_3, var_19_4)
						end
					end
				else
					for iter_19_2, iter_19_3 in ipairs(var_0) do
						local var_19_5 = findTF(iter_19_3, "Image")
						local var_19_6 = arg_13_0
						local var_19_8 = iter_19_3

						if var_13_3[iter_19_2] ~= var_13_3[1] and bit.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_3[iter_19_2]) > 0 then
							local var_19_9 = var_13_6 or arg_13_0.greySprite

							var_19_7(var_19_6, var_19_8, var_19_9)
						end
					end
				end

				return
			end,
			[var_0_0.Mode.OR] = function()
				for iter_20_0, iter_20_1 in ipairs(var_0) do
					local var_20_0 = findTF(iter_20_1, "Image")
					local var_20_1 = arg_13_0
					local var_20_3 = iter_20_1

					if var_13_3[iter_20_0] == arg_13_0.contextData.indexDatas[var_13_0] then
						local var_20_4 = var_13_6 or arg_13_0.greySprite

						var_20_2(var_20_1, var_20_3, var_20_4)
					end
				end

				return
			end,
			[var_0_0.Mode.NUM] = function()
				for iter_21_0, iter_21_1 in ipairs(var_0) do
					local var_21_0 = findTF(iter_21_1, "Image")
					local var_21_1 = arg_13_0
					local var_21_3 = iter_21_1

					if bit.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_3[iter_21_0]) > 0 then
						local var_21_4 = var_13_6 or arg_13_0.greySprite

						var_21_2(var_21_1, var_21_3, var_21_4)
					end
				end

				return
			end
		})
		arg_13_0:OnDatasChange(var_13_0)

		if arg_13_0.simpleDropdownDic[var_13_0] then
			for iter_18_0, iter_18_1 in pairs(arg_13_0.simpleDropdownDic[var_13_0]) do
				iter_18_1:UpdateVirtualBtn()
			end
		end

		return
	end

	table.insert(arg_13_0.updateList, function()
		switch(var_13_4, {
			[var_0_0.Mode.AND] = function()
				if arg_13_0.contextData.indexDatas[var_13_0] == var_13_3[1] then
					for iter_19_0, iter_19_1 in ipairs(var_0) do
						local var_19_0 = findTF(iter_19_1, "Image")
						local var_19_1 = arg_13_0
						local var_19_3 = iter_19_1

						if var_13_3[iter_19_0] == var_13_3[1] then
							local var_19_4 = var_13_6 or arg_13_0.greySprite

							var_19_2(var_19_1, var_19_3, var_19_4)
						end
					end
				else
					for iter_19_2, iter_19_3 in ipairs(var_0) do
						local var_19_5 = findTF(iter_19_3, "Image")
						local var_19_6 = arg_13_0
						local var_19_8 = iter_19_3

						if var_13_3[iter_19_2] ~= var_13_3[1] and bit.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_3[iter_19_2]) > 0 then
							local var_19_9 = var_13_6 or arg_13_0.greySprite

							var_19_7(var_19_6, var_19_8, var_19_9)
						end
					end
				end

				return
			end,
			[var_0_0.Mode.OR] = function()
				for iter_20_0, iter_20_1 in ipairs(var_0) do
					local var_20_0 = findTF(iter_20_1, "Image")
					local var_20_1 = arg_13_0
					local var_20_3 = iter_20_1

					if var_13_3[iter_20_0] == arg_13_0.contextData.indexDatas[var_13_0] then
						local var_20_4 = var_13_6 or arg_13_0.greySprite

						var_20_2(var_20_1, var_20_3, var_20_4)
					end
				end

				return
			end,
			[var_0_0.Mode.NUM] = function()
				for iter_21_0, iter_21_1 in ipairs(var_0) do
					local var_21_0 = findTF(iter_21_1, "Image")
					local var_21_1 = arg_13_0
					local var_21_3 = iter_21_1

					if bit.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_3[iter_21_0]) > 0 then
						local var_21_4 = var_13_6 or arg_13_0.greySprite

						var_21_2(var_21_1, var_21_3, var_21_4)
					end
				end

				return
			end
		})
		arg_13_0:OnDatasChange(var_13_0)

		if arg_13_0.simpleDropdownDic[var_13_0] then
			for iter_18_0, iter_18_1 in pairs(arg_13_0.simpleDropdownDic[var_13_0]) do
				iter_18_1:UpdateVirtualBtn()
			end
		end

		return
	end)

	if arg_13_1.simpleDropdown then
		assert(var_13_4 == var_0_0.Mode.OR, "simpleDropdown目前只支持OR模式")

		local var_13_9 = var_13_2:Find("bg"):GetChild(0)

		for iter_13_4, iter_13_5 in ipairs(arg_13_1.simpleDropdown) do
			local var_13_10 = cloneTplTo(var_13_9, var_13_2:Find("bg"))

			var_13_10.name = iter_13_5 .. "_simple"

			local var_13_11 = SimpleDropdown.New(arg_13_0.panel, arg_13_0.event, arg_13_0.contextData, var_13_0, var_13_10, arg_13_0.contextData.customPanels[iter_13_5], var_13_7, arg_13_0.greySprite, arg_13_0.yellowSprite)

			setActive(var_13_10:Find("dropdown"), true)
			onButton(arg_13_0, var_13_10, function()
				if not var_13_11:GetLoaded() then
					var_13_11:Load()
				end

				var_13_11:ActionInvoke("Show", (arg_13_0.panel:InverseTransformPoint(var_13_10.position)))

				return
			end)

			arg_13_0.simpleDropdownDic[var_13_0] = arg_13_0.simpleDropdownDic[var_13_0] or {}
			arg_13_0.simpleDropdownDic[var_13_0][iter_13_5] = var_13_11
		end
	end

	return
end

function var_0_0.UpdateBtnStyle(arg_23_0, arg_23_1, arg_23_2)
	setImageSprite(arg_23_1, arg_23_2)

	return
end

function var_0_0.OnDatasChange(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.contextData.dropdownLimit or {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0.dropdownDic) do
		if var_24_0[iter_24_0] ~= nil then
			if var_24_0[iter_24_0].exclude[arg_24_1] ~= nil or var_24_0[iter_24_0].include[arg_24_1] ~= nil then
				local var_24_1 = arg_24_0.contextData.indexDatas[arg_24_1]
				local var_24_2 = false

				if var_24_0[iter_24_0].exclude[arg_24_1] ~= nil and var_24_1 == var_24_0[iter_24_0].exclude[arg_24_1] then
					var_24_2 = false
				elseif var_24_0[iter_24_0].include[arg_24_1] ~= nil then
					var_24_2 = bit.band(var_24_1, var_24_0[iter_24_0].include[arg_24_1]) > 0
				end

				setActive(arg_24_0.dropdownDic[iter_24_0].virtualBtn, var_24_2)

				if not arg_24_0.onInit then
					arg_24_0.contextData.indexDatas[iter_24_0] = arg_24_0.contextData.customPanels[iter_24_0].options[1]
				end

				arg_24_0.dropdownDic[iter_24_0]:UpdateVirtualBtn()
				arg_24_0.dropdownDic[iter_24_0]:ActionInvoke("SelectLast")
			end
		end
	end

	return
end

function var_0_0.willExit(arg_25_0)
	LeanTween.cancel(go(arg_25_0.panel))

	for iter_25_0, iter_25_1 in pairs(arg_25_0.dropdownDic) do
		iter_25_1:Destroy()
	end

	for iter_25_2, iter_25_3 in pairs(arg_25_0.simpleDropdownDic) do
		for iter_25_4, iter_25_5 in pairs(iter_25_3) do
			iter_25_5:Destroy()
		end
	end

	arg_25_0.updateList = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_25_0._tf)

	return
end

function var_0_0.Clone2Full(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetChild(0)

	for iter_26_0 = 0, arg_26_0.childCount - 1 do
		table.insert({}, arg_26_0:GetChild(iter_26_0))
	end

	for iter_26_1 = arg_26_0.childCount, arg_26_1 - 1 do
		local var_26_1 = cloneTplTo(var_26_0, arg_26_0)

		var_26_1.name = iter_26_1

		table.insert({}, tf(var_26_1))
	end

	for iter_26_2 = 0, arg_26_0.childCount - 1 do
		setActive(arg_26_0:GetChild(iter_26_2), iter_26_2 < arg_26_1)
	end

	for iter_26_3 = arg_26_0.childCount, arg_26_1 + 1, -1 do
		table.remove({})
	end

	return {}
end

return var_0_0
