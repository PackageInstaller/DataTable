class = var_0_10000

local var_0_0 = "CustomIndexLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CustomIndexUI"
end

var_0_1.Mode = {
	OR = 2,
	AND = 1,
	NUM = 3
}

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_0, "index_panel")

	local var_2_1 = arg_2_0.panel

	arg_2_0.layout = var_1.Find(var_2_1, "layout")

	local var_2_2 = arg_2_0.layout

	arg_2_0.contianer = var_1.Find(var_2_2, "container")
	eachChild = var_1

	var_1(arg_2_0.contianer, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, false)

		return
	end)

	local var_2_3 = arg_2_0.layout

	arg_2_0.panelTemplate = var_1.Find(var_2_3, "container/Template")
	arg_2_0.displayList = {}
	arg_2_0.typeList = {}

	local var_2_4 = arg_2_0.panel

	arg_2_0.btnConfirm = var_1.Find(var_2_4, "layout/btns/ok")

	local var_2_5 = arg_2_0.panel

	arg_2_0.btnCancel = var_1.Find(var_2_5, "layout/btns/cancel")
	setText = var_1

	local var_2_6 = arg_2_0.btnConfirm
	local var_2_7 = var_3.Find(var_2_6, "Image")

	i18n = var_4

	var_1(var_2_7, var_4("text_confirm"))

	setText = var_1

	local var_2_8 = arg_2_0.btnCancel
	local var_2_9 = var_3.Find(var_2_8, "Image")

	i18n = var_4

	var_1(var_2_9, var_4("text_cancel"))

	local var_2_10 = arg_2_0.panel
	local var_2_11 = var_1.Find(var_2_10, "resource/grey")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_2_0.greySprite = var_2_12(var_2_11, var_4(var_6)).sprite

	local var_2_13 = arg_2_0.panel
	local var_2_14 = var_1.Find(var_2_13, "resource/blue")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_2_0.blueSprite = var_2_15(var_2_14, var_4(var_6)).sprite

	local var_2_16 = arg_2_0.panel
	local var_2_17 = var_1.Find(var_2_16, "resource/yellow")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_2_0.yellowSprite = var_2_18(var_2_17, var_4(var_6)).sprite

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnConfirm

	local function var_4_2()
		if arg_4_0.contextData.callback then
			arg_4_0.contextData.callback(arg_4_0.contextData.indexDatas)

			arg_4_0.contextData.callback = nil
		end

		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnCancel

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.panel
	local var_4_8 = var_4.Find(var_4_7, "btn")

	local function var_4_9()
		local var_7_0 = arg_4_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_4_7

	var_1_10001(var_4_6, var_4_8, var_4_9, var_4_7)
	arg_4_0:DoEnterAnimation()

	setText = var_1

	local var_4_10 = arg_4_0.panel
	local var_4_11 = var_3.Find(var_4_10, "layout/tip")
	local var_4_12

	if not arg_4_0.contextData.tip then
		var_4_12 = ""
	end

	var_1(var_4_11, var_4_12)
	arg_4_0:InitGroup()
	arg_4_0:BlurPanel()

	return
end

function var_0_1.DoEnterAnimation(arg_8_0)
	local var_8_0 = arg_8_0.panel

	Vector3 = var_1_10002
	var_8_0.localScale = var_1_10002.zero
	LeanTween = var_8_0

	local var_8_1 = var_8_0.scale
	local var_8_2 = arg_8_0.panel

	Vector3 = var_1_10004

	var_8_1(var_8_2, var_1_10004(1, 1, 1), 0.2)

	return
end

function var_0_1.BlurPanel(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_9_0, arg_9_0._tf)

	return
end

function var_0_1.InitGroup(arg_10_0)
	arg_10_0.onInit = true

	local var_10_0 = arg_10_0.contextData
	local var_10_1

	if not arg_10_0.contextData.indexDatas then
		var_10_1 = {}
	end

	var_10_0.indexDatas = var_10_1
	arg_10_0.dropdownDic = {}
	arg_10_0.updateList = {}
	arg_10_0.simpleDropdownDic = {}
	pairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.contextData.groupList) do
		if iter_10_1.dropdown then
			arg_10_0:InitDropdown(iter_10_1)
		else
			arg_10_0:InitCustoms(iter_10_1)
		end
	end

	ipairs = var_1

	for iter_10_2, iter_10_3 in var_1(arg_10_0.updateList) do
		iter_10_3()
	end

	if arg_10_0.contextData.customPanels.minHeight then
		GetOrAddComponent = var_1

		local var_10_2 = arg_10_0.layout

		typeof = iter_10_2
		LayoutElement = var_1_10006
		var_1(var_10_2, iter_10_2(var_1_10006)).minHeight = arg_10_0.contextData.customPanels.minHeight
	end

	if arg_10_0.contextData.customPanels.layoutPos then
		setLocalPosition = var_1

		var_1(arg_10_0.layout, arg_10_0.contextData.customPanels.layoutPos)
	end

	arg_10_0.onInit = false

	return
end

function var_0_1.InitDropdown(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.tags

	tf = var_1_10003
	Instantiate = var_1_10005

	local var_11_1 = var_1_10003(var_1_10005(arg_11_0.panelTemplate))

	setParent = var_1_10004

	var_1_10004(var_11_1, arg_11_0.contianer, false)

	setActive = var_1_10004

	var_1_10004(var_11_1, true)

	local var_11_2 = var_0_1.Clone2Full
	local var_11_3 = var_11_1
	local var_11_4 = var_11_2(var_11_1.Find(var_11_3, "bg"), #var_11_0)

	go = var_5

	local var_11_5 = var_5(var_11_1)

	var_11_5.name = arg_11_1.titleTxt
	setText = var_11_5

	local var_11_6 = var_11_1:Find("title/Image")

	i18n = var_11_3

	var_11_5(var_11_6, var_11_3(arg_11_1.titleTxt))

	setText = var_11_5

	local var_11_7 = var_11_1:Find("title/Image/Image_en")

	i18n = var_8

	var_11_5(var_11_7, var_8(arg_11_1.titleENTxt))

	local var_11_8 = var_11_1:Find("bg")
	local var_11_9 = var_5.GetComponent

	typeof = var_8
	ScrollRect = var_10
	var_11_9(var_11_8, var_8(var_10)).enabled = false
	ipairs = var_6

	for iter_11_0, iter_11_1 in var_6(var_11_0) do
		local var_11_10 = var_11_4[iter_11_0]

		setActive = var_1_10012

		var_1_10012(var_11_10:Find("dropdown"), true)

		CustomDropdown = var_1_10012
		var_1_10012 = var_1_10012.New(arg_11_0.panel, arg_11_0.event, arg_11_0.contextData, iter_11_1, var_11_10)
		onButton = var_1_10013

		var_1_10013(arg_11_0, var_11_10, function()
			local var_12_0 = arg_11_0.panel
			local var_12_1 = var_0.InverseTransformPoint(var_12_0, var_11_10.position)
			local var_12_2 = var_1_10012

			if not var_1.GetLoaded(var_12_2) then
				local var_12_3 = var_1_10012

				var_1.Load(var_12_3)
			end

			local var_12_4 = var_1_10012

			var_1.ActionInvoke(var_12_4, "Show", var_12_1)

			return
		end)

		var_1_10013 = arg_11_0.dropdownDic
		var_1_10013[iter_11_1] = var_1_10012
	end

	return
end

function var_0_1.InitCustoms(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.tags[1]
	local var_13_1 = arg_13_0.contextData.customPanels[var_13_0]

	tf = var_1_10004
	Instantiate = var_1_10006

	local var_13_2 = var_1_10004(var_1_10006(arg_13_0.panelTemplate))

	setParent = var_1_10005

	var_1_10005(var_13_2, arg_13_0.contianer, false)

	setActive = var_1_10005

	var_1_10005(var_13_2, true)

	go = var_1_10005

	local var_13_3 = var_1_10005(var_13_2)

	var_13_3.name = arg_13_1.titleTxt
	setText = var_13_3

	local var_13_4 = var_13_2:Find("title/Image")

	i18n = var_8

	var_13_3(var_13_4, var_8(arg_13_1.titleTxt))

	setText = var_13_3

	local var_13_5 = var_13_2:Find("title/Image/Image_en")

	i18n = var_8

	var_13_3(var_13_5, var_8(arg_13_1.titleENTxt))

	local var_13_6 = var_13_2:Find("bg")
	local var_13_7 = var_5.GetComponent

	typeof = var_8
	ScrollRect = var_10
	var_13_7(var_13_6, var_8(var_10)).enabled = false

	local var_13_8 = var_13_1.options
	local var_13_9

	if not var_13_1.mode then
		var_13_9 = var_0_1.Mode.OR
	end

	local var_13_10 = 0
	local var_13_11

	if not var_13_1.blueSeleted or not arg_13_0.blueSprite then
		var_13_11 = arg_13_0.yellowSprite
	end

	ipairs = var_10

	for iter_13_0, iter_13_1 in var_10(var_13_8) do
		bit = var_1_10015
		var_13_10 = var_1_10015.bor(iter_13_1, var_13_10)
	end

	local var_13_12 = arg_13_0.contextData.indexDatas
	local var_13_13

	if not arg_13_0.contextData.indexDatas[var_13_0] then
		var_13_13 = var_13_8[1]
	end

	var_13_12[var_13_0] = var_13_13

	local var_13_14
	local var_13_15 = var_0_1.Clone2Full(var_13_2:Find("bg"), #var_13_8)

	ipairs = var_12

	for iter_13_2, iter_13_3 in var_12(var_13_15) do
		local var_13_16 = var_13_8[iter_13_2]

		setText = var_1_10018
		findTF = var_1_10020
		var_1_10020 = var_1_10020(iter_13_3, "Image")
		i18n = var_1_10021

		var_1_10018(var_1_10020, var_1_10021(var_13_1.names[iter_13_2]))

		var_1_10020 = arg_13_0

		arg_13_0.UpdateBtnStyle(var_1_10020, iter_13_3, arg_13_0.greySprite)

		onButton = var_1_10018
		var_1_10020 = arg_13_0
		var_1_10021 = iter_13_3

		local function var_13_17()
			switch = var_2_10000

			var_2_10000(var_13_9, {
				[var_0_1.Mode.AND] = function()
					if iter_13_2 == 1 or arg_13_0.contextData.indexDatas[var_13_0] == var_13_8[1] then
						arg_13_0.contextData.indexDatas[var_13_0] = var_13_16
					else
						local var_15_0 = arg_13_0.contextData.indexDatas
						local var_15_1 = var_13_0

						bit = var_3_10002
						var_15_0[var_15_1] = var_3_10002.bxor(arg_13_0.contextData.indexDatas[var_13_0], var_13_16)
					end

					if arg_13_0.contextData.indexDatas[var_13_0] == 0 or arg_13_0.contextData.indexDatas[var_13_0] == var_13_10 then
						arg_13_0.contextData.indexDatas[var_13_0] = var_13_8[1]
					end

					return
				end,
				[var_0_1.Mode.OR] = function()
					if var_13_1.isSort then
						arg_13_0.contextData.indexDatas[var_13_0] = var_13_16
					else
						local var_16_0 = arg_13_0.contextData.indexDatas[var_13_0]
						local var_16_1 = arg_13_0.contextData.indexDatas
						local var_16_2 = var_13_0
						local var_16_3

						if var_13_16 ~= var_16_0 or not var_13_8[1] then
							var_16_3 = var_13_16
						end

						var_16_1[var_16_2] = var_16_3
					end

					return
				end,
				[var_0_1.Mode.NUM] = function()
					local var_17_0 = arg_13_0.contextData.indexDatas[var_13_0]
					local var_17_1 = 0

					while 0 < var_17_0 do
						var_17_1 = var_17_1 + 1
						bit = var_2
						var_17_0 = var_2.band(var_17_0, var_17_0 - 1)
					end

					if not (var_17_1 < var_13_1.num) then
						bit = var_17_2

						local var_17_2

						if var_17_2.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_16) > 0 then
							var_17_2 = arg_13_0.contextData.indexDatas

							local var_17_3 = var_13_0

							bit = var_3_10004
							var_17_2[var_17_3] = var_3_10004.bxor(arg_13_0.contextData.indexDatas[var_13_0], var_13_16)
						else
							pg = var_17_2

							local var_17_4 = var_17_2.TipsMgr.GetInstance()
							local var_17_5 = var_2.ShowTips

							i18n = var_3_10005

							var_17_5(var_17_4, var_3_10005("equipcode_share_exceedlimit"))
						end

						return
					end
				end
			})
			var_13_14()

			return
		end

		SFX_UI_TAG = var_23

		var_1_10018(var_1_10020, var_1_10021, var_13_17, var_23)
	end

	function var_13_14()
		switch = var_2_10000

		var_2_10000(var_13_9, {
			[var_0_1.Mode.AND] = function()
				if arg_13_0.contextData.indexDatas[var_13_0] == var_13_8[1] then
					ipairs = var_0

					for iter_19_0, iter_19_1 in var_0(var_13_15) do
						local var_19_0 = var_13_8[iter_19_0] == var_13_8[1]

						findTF = var_6

						local var_19_1 = var_6(iter_19_1, "Image")
						local var_19_2 = arg_13_0
						local var_19_3 = var_7.UpdateBtnStyle
						local var_19_4 = iter_19_1
						local var_19_5

						if not var_19_0 or not var_13_11 then
							var_19_5 = arg_13_0.greySprite
						end

						var_19_3(var_19_2, var_19_4, var_19_5)
					end
				else
					ipairs = var_0

					for iter_19_2, iter_19_3 in var_0(var_13_15) do
						if var_13_8[iter_19_2] ~= var_13_8[1] then
							bit = var_5

							local var_19_6 = var_5.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_8[iter_19_2])
							local var_19_7

							if not (0 < var_19_6) then
								var_19_7 = false
							else
								var_19_7 = true
							end

							findTF = var_6

							local var_19_8 = var_6(iter_19_3, "Image")
							local var_19_9 = arg_13_0
							local var_19_10 = var_7.UpdateBtnStyle
							local var_19_11 = iter_19_3
							local var_19_12

							if not var_19_7 or not var_13_11 then
								var_19_12 = arg_13_0.greySprite
							end

							var_19_10(var_19_9, var_19_11, var_19_12)
						end
					end
				end

				return
			end,
			[var_0_1.Mode.OR] = function()
				ipairs = var_3_10000

				for iter_20_0, iter_20_1 in var_3_10000(var_13_15) do
					local var_20_0 = var_13_8[iter_20_0] == arg_13_0.contextData.indexDatas[var_13_0]

					findTF = var_6

					local var_20_1 = var_6(iter_20_1, "Image")
					local var_20_2 = arg_13_0
					local var_20_3 = var_7.UpdateBtnStyle
					local var_20_4 = iter_20_1
					local var_20_5

					if not var_20_0 or not var_13_11 then
						var_20_5 = arg_13_0.greySprite
					end

					var_20_3(var_20_2, var_20_4, var_20_5)
				end

				return
			end,
			[var_0_1.Mode.NUM] = function()
				ipairs = var_3_10000

				for iter_21_0, iter_21_1 in var_3_10000(var_13_15) do
					bit = var_3_10005
					var_3_10005 = var_3_10005.band(arg_13_0.contextData.indexDatas[var_13_0], var_13_8[iter_21_0])
					var_3_10005 = 0 < var_3_10005
					findTF = var_6

					local var_21_0 = var_6(iter_21_1, "Image")
					local var_21_1 = arg_13_0
					local var_21_2 = var_7.UpdateBtnStyle
					local var_21_3 = iter_21_1
					local var_21_4

					if not var_3_10005 or not var_13_11 then
						var_21_4 = arg_13_0.greySprite
					end

					var_21_2(var_21_1, var_21_3, var_21_4)
				end

				return
			end
		})

		local var_18_0 = arg_13_0

		var_0.OnDatasChange(var_18_0, var_13_0)

		if arg_13_0.simpleDropdownDic[var_13_0] then
			pairs = var_0

			for iter_18_0, iter_18_1 in var_0(arg_13_0.simpleDropdownDic[var_13_0]) do
				iter_18_1:UpdateVirtualBtn()
			end
		end

		return
	end

	table = var_12

	var_12.insert(arg_13_0.updateList, var_13_14)

	if arg_13_1.simpleDropdown then
		assert = var_12

		var_12(var_13_9 == var_0_1.Mode.OR, "simpleDropdown目前只支持OR模式")

		local var_13_18 = var_13_2:Find("bg")
		local var_13_19 = var_12.GetChild(var_13_18, 0)

		ipairs = var_13

		for iter_13_4, iter_13_5 in var_13(arg_13_1.simpleDropdown) do
			local var_13_20 = arg_13_0.contextData.customPanels[iter_13_5]

			cloneTplTo = var_1_10019
			var_1_10019 = var_1_10019(var_13_19, var_13_2:Find("bg"))
			var_1_10019.name = iter_13_5 .. "_simple"
			SimpleDropdown = var_20

			local var_13_21 = var_20.New(arg_13_0.panel, arg_13_0.event, arg_13_0.contextData, var_13_0, var_1_10019, var_13_20, var_13_14, arg_13_0.greySprite, arg_13_0.yellowSprite)

			setActive = var_21

			var_21(var_1_10019:Find("dropdown"), true)

			onButton = var_21

			var_21(arg_13_0, var_1_10019, function()
				local var_22_0 = arg_13_0.panel
				local var_22_1 = var_0.InverseTransformPoint(var_22_0, var_1_10019.position)
				local var_22_2 = var_13_21

				if not var_1.GetLoaded(var_22_2) then
					local var_22_3 = var_13_21

					var_1.Load(var_22_3)
				end

				local var_22_4 = var_13_21

				var_1.ActionInvoke(var_22_4, "Show", var_22_1)

				return
			end)

			local var_13_22 = arg_13_0.simpleDropdownDic
			local var_13_23

			if not arg_13_0.simpleDropdownDic[var_13_0] then
				var_13_23 = {}
			end

			var_13_22[var_13_0] = var_13_23
			arg_13_0.simpleDropdownDic[var_13_0][iter_13_5] = var_13_21
		end
	end

	return
end

function var_0_1.UpdateBtnStyle(arg_23_0, arg_23_1, arg_23_2)
	setImageSprite = var_1_10003

	var_1_10003(arg_23_1, arg_23_2)

	return
end

function var_0_1.OnDatasChange(arg_24_0, arg_24_1)
	local var_24_0

	if not arg_24_0.contextData.dropdownLimit then
		var_24_0 = {}
	end

	pairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.dropdownDic) do
		if var_24_0[iter_24_0] ~= nil then
			local var_24_1 = var_24_0[iter_24_0].include

			if var_24_0[iter_24_0].exclude[arg_24_1] ~= nil or var_24_1[arg_24_1] ~= nil then
				local var_24_2 = arg_24_0.contextData.indexDatas[arg_24_1]
				local var_24_3 = false

				if var_9[arg_24_1] ~= nil and var_24_2 == var_9[arg_24_1] then
					var_24_3 = false
				elseif var_24_1[arg_24_1] ~= nil then
					bit = var_12
					var_24_3 = var_12.band(var_24_2, var_24_1[arg_24_1]) > 0
				end

				setActive = var_12

				var_12(arg_24_0.dropdownDic[iter_24_0].virtualBtn, var_24_3)

				if not arg_24_0.onInit then
					arg_24_0.contextData.indexDatas[iter_24_0] = arg_24_0.contextData.customPanels[iter_24_0].options[1]
				end

				local var_24_4 = arg_24_0.dropdownDic[iter_24_0]

				var_12.UpdateVirtualBtn(var_24_4)

				local var_24_5 = arg_24_0.dropdownDic[iter_24_0]

				var_12.ActionInvoke(var_24_5, "SelectLast")
			end
		end
	end

	return
end

function var_0_1.willExit(arg_25_0)
	LeanTween = var_1_10001

	local var_25_0 = var_1_10001.cancel

	go = var_1_10003

	var_25_0(var_1_10003(arg_25_0.panel))

	pairs = var_25_0

	for iter_25_0, iter_25_1 in var_25_0(arg_25_0.dropdownDic) do
		iter_25_1:Destroy()
	end

	pairs = var_1

	for iter_25_2, iter_25_3 in var_1(arg_25_0.simpleDropdownDic) do
		pairs = var_1_10006

		for iter_25_4, iter_25_5 in var_1_10006(iter_25_3) do
			iter_25_5:Destroy()
		end
	end

	arg_25_0.updateList = nil
	pg = var_1

	local var_25_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_1, arg_25_0._tf)

	return
end

function var_0_1.Clone2Full(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = arg_26_0:GetChild(0)
	local var_26_2 = arg_26_0.childCount

	for iter_26_0 = 0, var_26_2 - 1 do
		table = var_1_10009

		var_1_10009.insert(var_26_0, arg_26_0:GetChild(iter_26_0))
	end

	for iter_26_1 = var_26_2, arg_26_1 - 1 do
		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(var_26_1, arg_26_0)
		var_1_10009.name = iter_26_1
		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_26_3 = var_26_0

		tf = var_1_10013

		var_1_10010(var_26_3, var_1_10013(var_1_10009))
	end

	local var_26_4 = arg_26_0.childCount

	for iter_26_2 = 0, var_26_4 - 1 do
		setActive = var_1_10009

		var_1_10009(arg_26_0:GetChild(iter_26_2), iter_26_2 < arg_26_1)
	end

	for iter_26_3 = var_26_4, arg_26_1 + 1, -1 do
		table = var_1_10009

		var_1_10009.remove(var_26_0)
	end

	return var_26_0
end

return var_0_1
