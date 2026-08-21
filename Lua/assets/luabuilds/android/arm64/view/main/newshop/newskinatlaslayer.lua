local var_0_0 = class("NewSkinAtlasLayer", import("...base.BaseUI"))
local var_0_1 = -1
local var_0_2 = 9999

function var_0_0.getUIName(arg_1_0)
	return "NewSkinAtlasUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.empty = arg_2_0._tf:Find("empty")
	arg_2_0.backBtn = arg_2_0._tf:Find("adapt/top/closeBtn")
	arg_2_0.homeBtn = arg_2_0._tf:Find("adapt/top/homeBtn")
	arg_2_0.resources = arg_2_0._tf:Find("adapt/top/resources")
	arg_2_0.filterBtn = arg_2_0._tf:Find("adapt/top/filterBtn")
	arg_2_0.search = arg_2_0._tf:Find("adapt/top/search")
	arg_2_0.scrollrect = arg_2_0._tf:Find("scroll"):GetComponent("LScrollRect")
	arg_2_0.filterUI = arg_2_0._tf:Find("subPage/filterUI")
	arg_2_0.filterContent = arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content")

	setActive(arg_2_0.filterUI, false)
	setText(arg_2_0.empty:Find("Text"), i18n("shop_new_unfound"))
	setText(arg_2_0._tf:Find("adapt/top/title/Text"), i18n("shop_new_shop"))
	setText(arg_2_0._tf:Find("adapt/top/have/Text"), i18n("shop_new_owned_skin"))
	setText(arg_2_0.filterBtn:Find("Text"), i18n("shop_new_sort"))
	setText(arg_2_0.search:Find("holder"), i18n("shop_new_search"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/title"), i18n("shop_new_sort"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/subTitleFrame/subTitle"), i18n("shop_new_review"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/0/Text"), i18n("shop_new_all"))
	setScrollText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/1/mask/Text"), i18n("shop_new_unused"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle"), i18n("shop_new_type"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/0/Text"), i18n("shop_new_all"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/2/Text"), i18n("shop_new_static"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/3/Text"), i18n("shop_new_dynamic"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/4/Text"), i18n("shop_new_static_bg"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/5/Text"), i18n("shop_new_dynamic_bg"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/6/Text"), i18n("shop_new_bgm"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/subTitleFrame/subTitle"), i18n("shop_new_index"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/0/Text"), i18n("shop_new_all"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/1/Text"), i18n("shop_new_ship_owned"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/2/Text"), i18n("shop_new_ship_havent_owned"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/camp/subTitleFrame/subTitle"), i18n("shop_new_nation"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/rarity/subTitleFrame/subTitle"), i18n("shop_new_rarity"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipType/subTitleFrame/subTitle"), i18n("shop_new_category"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/themeType/subTitleFrame/subTitle"), i18n("shop_new_skin_theme"))
	setText(arg_2_0.filterUI:Find("panelMask/panel/bottom/ok/Text"), i18n("shop_new_confirm"))
	pg.UIMgr.GetInstance():OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0.bg,
			arg_2_0.filterUI:Find("panelMask/panel")
		}
	})

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:SetFilterPanel()
	arg_3_0:SetResource()
	arg_3_0:SetSkinScroll()
	arg_3_0:Refresh()
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.filterBtn, function()
		arg_3_0:OpenFilterPanel()

		return
	end, SFX_PANEL)
	onInputChanged(arg_3_0, arg_3_0.search, function()
		arg_3_0:Refresh()
		setActive(arg_3_0.search:Find("holder"), getInputText(arg_3_0.search) == "")

		return
	end)

	return
end

function var_0_0.InitData(arg_8_0)
	arg_8_0.skins = getProxy(ShipSkinProxy):GetOwnSkins()

	for iter_8_0 = #arg_8_0.skins, 1, -1 do
		local var_8_0 = ShipSkin.GetChangeSkinIndex(arg_8_0.skins[iter_8_0].id)

		if var_8_0 and var_8_0 ~= 1 then
			table.remove(arg_8_0.skins, iter_8_0)
		end
	end

	arg_8_0:GetSkinClassify()

	arg_8_0.filterValues = {
		shipHaveType = 0,
		ownType = 0,
		typeType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		themeType = {
			0
		}
	}
	arg_8_0.filterValuesTemp = Clone(arg_8_0.filterValues)

	return
end

function var_0_0.SetResource(arg_9_0)
	setText(arg_9_0.resources:Find("gem/Text"), getProxy(PlayerProxy):getRawData():getTotalGem())
	onButton(arg_9_0, arg_9_0.resources:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetSkinScroll(arg_11_0)
	arg_11_0.scrollrect.isNewLoadingMethod = true

	function arg_11_0.scrollrect.onInitItem(arg_12_0)
		arg_11_0:OnInitItem(arg_12_0)

		return
	end

	function arg_11_0.scrollrect.onUpdateItem(arg_13_0, arg_13_1)
		arg_11_0:OnUpdateItem(arg_13_0, arg_13_1)

		return
	end

	function arg_11_0.scrollrect.onReturnItem(arg_14_0, arg_14_1)
		arg_11_0:OnReturnItem(arg_14_0, arg_14_1)

		return
	end

	return
end

function var_0_0.OnInitItem(arg_15_0, arg_15_1)
	ClearTweenItemAlphaAndWhite(arg_15_1)

	return
end

function var_0_0.ReturnIndex(arg_16_0, arg_16_1)
	if arg_16_0.indexDic[arg_16_1] then
		for iter_16_0 = #arg_16_0.groupDic[arg_16_0.scrollShowClassifyIds[arg_16_1]], 1, -1 do
			if arg_16_0.groupDic[arg_16_0.scrollShowClassifyIds[arg_16_1]][iter_16_0] == arg_16_1 then
				table.remove(arg_16_0.groupDic[arg_16_0.scrollShowClassifyIds[arg_16_1]], iter_16_0)
			end
		end
	end

	arg_16_0.indexDic[arg_16_1] = false

	return
end

function var_0_0.RegisterIndex(arg_17_0, arg_17_1)
	arg_17_0.indexDic[arg_17_1] = true

	if arg_17_0.scrollShowClassifyIds[arg_17_1] then
		arg_17_0.groupDic[arg_17_0.scrollShowClassifyIds[arg_17_1]] = arg_17_0.groupDic[arg_17_0.scrollShowClassifyIds[arg_17_1]] or {}

		table.insert(arg_17_0.groupDic[arg_17_0.scrollShowClassifyIds[arg_17_1]], arg_17_1)
	end

	return
end

function var_0_0.ChangeClassifyName(arg_18_0, arg_18_1)
	local var_18_9001
	local var_18_9000

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0

		for iter_18_2, iter_18_3 in pairs(arg_18_0.goDic) do
			if iter_18_1 == iter_18_3 then
				var_18_0 = iter_18_2

				break
			end
		end

		if var_18_0 then
			local var_18_1 = arg_18_0.scrollShowClassifyIds[iter_18_1]
			local var_18_2 = arg_18_0.classifyNames[table.indexof(arg_18_0.classifyIds, arg_18_0.scrollShowClassifyIds[iter_18_1])]
			local var_18_3 = arg_18_0.groupDic[arg_18_0.scrollShowClassifyIds[iter_18_1]] or {}
			local var_18_4 = var_18_3[1] == iter_18_1
			local var_18_5 = tf(var_18_0)

			setActive(var_18_5:Find("titleBar"), var_18_3[1] == iter_18_1)

			if var_18_4 then
				local var_18_6 = tf(var_18_0)

				setText(var_18_6:Find("titleBar/title"), var_18_2)

				local var_18_7 = arg_18_0._tf:Find("scroll/content")
				local var_18_8 = var_18_7.GetComponent(var_18_9001, typeof(VerticalLayoutGroup)).spacing
				local var_18_9 = tf(var_18_0).GetComponent(var_18_7, typeof(LayoutElement)).preferredHeight
				local var_18_10 = tf(var_18_0)
				local var_18_11 = {
					x = tf(var_18_0):Find("titleBar").rect.width,
					y = var_18_9 * arg_18_0.scrollClassifyNum[var_18_1] + var_18_8 * (arg_18_0.scrollClassifyNum[var_18_1] - 1)
				}

				setSizeDelta(var_18_10.Find(var_18_9000, "titleBar"), var_18_11)

				local var_18_12 = tf(var_18_0)

				setAnchoredPosition(var_18_12:Find("titleBar"), {
					y = (arg_18_0.scrollShouldShowName[iter_18_1] - 1) * (var_18_9 + var_18_8)
				})
			end
		end
	end

	return
end

function var_0_0.GetDisplayIndex(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.groupDic[arg_19_1] or {}

	return var_19_0[1]
end

function var_0_0.ClickTrigger(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:emit(NewSkinAtlasMediator.OPEN_SHOW_LAYER, arg_20_2)

	return
end

function var_0_0.OnUpdateItem(arg_21_0, arg_21_1, arg_21_2)
	TweenItemAlphaAndWhite(arg_21_2)

	arg_21_1 = arg_21_1 + 1

	local var_21_0 = arg_21_0.scrollDisplays[arg_21_1]

	if arg_21_0.goDic[arg_21_2] and arg_21_0.goDic[arg_21_2] ~= arg_21_1 then
		local var_21_1 = arg_21_0:GetDisplayIndex(arg_21_0.scrollShowClassifyIds[arg_21_0.goDic[arg_21_2]])

		arg_21_0:ReturnIndex(arg_21_0.goDic[arg_21_2])

		if var_21_1 ~= arg_21_0:GetDisplayIndex(arg_21_0.scrollShowClassifyIds[arg_21_0.goDic[arg_21_2]]) then
			table.insert({}, var_21_1)
			table.insert({}, arg_21_0:GetDisplayIndex(arg_21_0.scrollShowClassifyIds[arg_21_0.goDic[arg_21_2]]))
			arg_21_0:ChangeClassifyName({})
		end
	end

	arg_21_0.goDic[arg_21_2] = arg_21_1

	local var_21_2 = arg_21_0:GetDisplayIndex(arg_21_0.scrollShowClassifyIds[arg_21_1])

	arg_21_0:RegisterIndex(arg_21_1)

	if var_21_2 ~= arg_21_0:GetDisplayIndex(arg_21_0.scrollShowClassifyIds[arg_21_1]) then
		table.insert({}, var_21_2)
	end

	table.insert({}, arg_21_1)
	arg_21_0:ChangeClassifyName({})

	if arg_21_0.scrollDisplays[arg_21_1] then
		local var_21_3 = UIItemList.New(tf(arg_21_2):Find("skins"), tf(arg_21_2):Find("skins/SkinAtlasCard"))

		var_21_3:make(function(arg_22_0, arg_22_1, arg_22_2)
			if arg_22_0 == UIItemList.EventUpdate then
				local var_22_0 = var_21_0[arg_22_1 + 1]
				local var_22_1 = SkinAtlasCard.New(arg_22_2)

				table.insert(arg_21_0.cards, var_22_1)
				var_22_1:Update(var_21_0[arg_22_1 + 1], arg_22_1 + 1)
				onButton(arg_21_0, arg_22_2, function()
					arg_21_0:ClickTrigger(var_22_1, var_22_0)

					return
				end, SFX_PANEL)
				onButton(arg_21_0, var_22_1.changeSkinUI, function()
					var_22_1:changeSkinNext()

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_21_3:align(#arg_21_0.scrollDisplays[arg_21_1])
	end

	return
end

function var_0_0.OnReturnItem(arg_25_0, arg_25_1, arg_25_2)
	ClearTweenItemAlphaAndWhite(arg_25_2)

	if arg_25_0.exited then
		return
	end

	if arg_25_0.goDic[arg_25_2] then
		local var_25_0 = arg_25_0:GetDisplayIndex(arg_25_0.scrollShowClassifyIds[arg_25_0.goDic[arg_25_2]])

		arg_25_0:ReturnIndex(arg_25_0.goDic[arg_25_2])

		if var_25_0 ~= arg_25_0:GetDisplayIndex(arg_25_0.scrollShowClassifyIds[arg_25_0.goDic[arg_25_2]]) then
			table.insert({}, var_25_0)
			table.insert({}, arg_25_0:GetDisplayIndex(arg_25_0.scrollShowClassifyIds[arg_25_0.goDic[arg_25_2]]))
			arg_25_0:ChangeClassifyName({})
		end
	end

	return
end

function var_0_0.Refresh(arg_26_0)
	arg_26_0.showClassifyIds = {}
	arg_26_0.displays = {}

	local var_26_0 = getInputText(arg_26_0.search)
	local var_26_1 = Clone(arg_26_0.classifyIds)

	table.remove(var_26_1, 1)
	table.remove(Clone(arg_26_0.classifyNames), 1)

	for iter_26_0, iter_26_1 in pairs(arg_26_0.skins) do
		if arg_26_0:filterOk(iter_26_1) and arg_26_0:IsSearchType(var_26_0, iter_26_1) then
			local var_26_2 = arg_26_0:GetShopTypeIdBySkinId(iter_26_1.id)

			if var_26_2 == 0 then
				local var_26_3 = var_0_2 or var_26_2

				arg_26_0.displays[var_26_3] = arg_26_0.displays[var_26_3] or {}

				table.insert(arg_26_0.displays[var_26_3], iter_26_1)
			end
		end
	end

	for iter_26_2, iter_26_3 in ipairs(var_26_1) do
		if arg_26_0.displays[iter_26_3] then
			table.insert(arg_26_0.showClassifyIds, iter_26_3)
		end
	end

	setActive(arg_26_0.empty, #arg_26_0.showClassifyIds == 0)

	arg_26_0.scrollShowClassifyIds = {}
	arg_26_0.scrollDisplays = {}
	arg_26_0.scrollShouldShowName = {}
	arg_26_0.scrollClassifyNum = {}

	for iter_26_4, iter_26_5 in ipairs(arg_26_0.showClassifyIds) do
		local var_26_4 = Clone(arg_26_0.displays[iter_26_5])
		local var_26_5 = false

		arg_26_0.scrollClassifyNum[iter_26_5] = math.ceil(#var_26_4 / 8)

		local var_26_6 = 1

		while #var_26_4 > 8 do
			table.insert(arg_26_0.scrollShowClassifyIds, iter_26_5)
			table.insert(arg_26_0.scrollShouldShowName, var_26_6)

			var_26_6 = var_26_6 + 1
			var_26_5 = var_26_5 or true

			local var_26_7 = {}

			for iter_26_6 = 1, 8 do
				table.insert(var_26_7, table.remove(var_26_4, 1))
			end

			table.insert(arg_26_0.scrollDisplays, var_26_7)
		end

		if #var_26_4 > 0 then
			table.insert(arg_26_0.scrollShowClassifyIds, iter_26_5)
			table.insert(arg_26_0.scrollShouldShowName, var_26_6)

			local var_26_8

			var_26_8 = var_26_5 or true

			table.insert(arg_26_0.scrollDisplays, var_26_4)
		end
	end

	arg_26_0.indexDic = {}
	arg_26_0.groupDic = {}
	arg_26_0.goDic = {}

	if arg_26_0.cards then
		for iter_26_7, iter_26_8 in ipairs(arg_26_0.cards) do
			iter_26_8:Dispose()
		end
	end

	arg_26_0.cards = {}

	arg_26_0.scrollrect:SetTotalCount(#arg_26_0.scrollShowClassifyIds, 0)

	return
end

function var_0_0.IsSearchType(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1 or arg_27_1 == "" then
		return true
	end

	;({}).id = arg_27_2.id

	return ShipSkin.New({}):IsMatchKey(arg_27_1)
end

function var_0_0.SetFilterPanel(arg_28_0)
	local var_28_0 = arg_28_0.filterContent:Find("camp/options")
	local var_28_1 = arg_28_0.filterContent:Find("rarity/options")
	local var_28_2 = arg_28_0.filterContent:Find("shipType/options")
	local var_28_3 = arg_28_0.filterContent:Find("themeType/options")

	arg_28_0:SetOptionList(var_28_0, ShipIndexConst.CampNames, true)
	arg_28_0:SetOptionList(var_28_1, ShipIndexConst.RarityNames, true)
	arg_28_0:SetOptionList(var_28_2, ShipIndexConst.TypeNames, true)
	arg_28_0:SetOptionList(var_28_3, arg_28_0.classifyNames)
	arg_28_0:SetSingleOptions(arg_28_0.filterContent:Find("own/options"), "ownType")
	arg_28_0:SetMultiOptions(arg_28_0.filterContent:Find("type/options"), "typeType")
	arg_28_0:SetSingleOptions(arg_28_0.filterContent:Find("shipHave/options"), "shipHaveType")
	arg_28_0:SetMultiOptions(var_28_0, "campType")
	arg_28_0:SetMultiOptions(var_28_1, "rarityType")
	arg_28_0:SetMultiOptions(var_28_2, "shipType")
	arg_28_0:SetMultiOptions(var_28_3, "themeType")
	onButton(arg_28_0, arg_28_0.filterUI:Find("bg"), function()
		for iter_29_0, iter_29_1 in pairs(arg_28_0.filterValues) do
			arg_28_0.filterValuesTemp[iter_29_0] = Clone(arg_28_0.filterValues[iter_29_0])
		end

		setActive(arg_28_0.filterUI, false)

		return
	end, SFX_PANEL)
	onButton(arg_28_0, arg_28_0.filterUI:Find("panelMask/panel/closeBtn"), function()
		for iter_30_0, iter_30_1 in pairs(arg_28_0.filterValues) do
			arg_28_0.filterValuesTemp[iter_30_0] = Clone(arg_28_0.filterValues[iter_30_0])
		end

		setActive(arg_28_0.filterUI, false)

		return
	end, SFX_PANEL)
	onButton(arg_28_0, arg_28_0.filterUI:Find("panelMask/panel/bottom/ok"), function()
		for iter_31_0, iter_31_1 in pairs(arg_28_0.filterValues) do
			arg_28_0.filterValues[iter_31_0] = Clone(arg_28_0.filterValuesTemp[iter_31_0])
		end

		setActive(arg_28_0.filterUI, false)
		arg_28_0:Refresh()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OpenFilterPanel(arg_32_0)
	setActive(arg_32_0.filterUI, true)
	arg_32_0:SetSingleOptions(arg_32_0.filterContent:Find("own/options"), "ownType", true)
	arg_32_0:SetMultiOptions(arg_32_0.filterContent:Find("type/options"), "typeType", true)
	arg_32_0:SetSingleOptions(arg_32_0.filterContent:Find("shipHave/options"), "shipHaveType", true)
	arg_32_0:SetMultiOptions(arg_32_0.filterContent:Find("camp/options"), "campType", true)
	arg_32_0:SetMultiOptions(arg_32_0.filterContent:Find("rarity/options"), "rarityType", true)
	arg_32_0:SetMultiOptions(arg_32_0.filterContent:Find("shipType/options"), "shipType", true)
	arg_32_0:SetMultiOptions(arg_32_0.filterContent:Find("themeType/options"), "themeType", true)

	return
end

function var_0_0.SetOptionList(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = UIItemList.New(arg_33_1, arg_33_1:GetChild(0))

	var_33_0:make(function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			local var_34_0 = arg_33_2[arg_34_1 + 1]

			if arg_33_3 then
				var_34_0 = i18n(var_34_0)
			end

			arg_34_2.name = arg_34_1

			setScrollText(arg_34_2:Find("mask/Text"), var_34_0)
		end

		return
	end)
	var_33_0:align(#arg_33_2)

	return
end

function var_0_0.SetSingleOptions(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	for iter_35_0 = 0, arg_35_1.childCount - 1 do
		local var_35_0 = arg_35_1:GetChild(iter_35_0)

		arg_35_0:SetOptionSelect(arg_35_1:GetChild(iter_35_0), iter_35_0 == arg_35_0.filterValuesTemp[arg_35_2])

		if not arg_35_3 then
			onButton(arg_35_0, var_35_0, function()
				arg_35_0.filterValuesTemp[arg_35_2] = iter_35_0

				for iter_36_0 = 0, arg_35_1.childCount - 1 do
					arg_35_0:SetOptionSelect(arg_35_1:GetChild(iter_36_0), iter_36_0 == iter_35_0)
				end

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.SetMultiOptions(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	for iter_37_0 = 0, arg_37_1.childCount - 1 do
		local var_37_0 = arg_37_1:GetChild(iter_37_0)

		arg_37_0:SetOptionSelect(arg_37_1:GetChild(iter_37_0), table.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0))

		if not arg_37_3 then
			onButton(arg_37_0, var_37_0, function()
				if iter_37_0 == 0 then
					arg_37_0.filterValuesTemp[arg_37_2] = {
						0
					}

					for iter_38_0 = 0, arg_37_1.childCount - 1 do
						arg_37_0:SetOptionSelect(arg_37_1:GetChild(iter_38_0), iter_38_0 == 0)
					end
				else
					table.removebyvalue(arg_37_0.filterValuesTemp[arg_37_2], 0)

					if table.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0) then
						table.removebyvalue(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0)
					else
						table.insert(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0)
					end

					local var_38_0 = true

					for iter_38_1 = 1, arg_37_1.childCount - 1 do
						if not table.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_38_1) then
							var_38_0 = false

							break
						end
					end

					if #arg_37_0.filterValuesTemp[arg_37_2] == 0 then
						var_38_0 = true
					end

					if var_38_0 then
						arg_37_0.filterValuesTemp[arg_37_2] = {
							0
						}
					end

					for iter_38_2 = 0, arg_37_1.childCount - 1 do
						arg_37_0:SetOptionSelect(arg_37_1:GetChild(iter_38_2), table.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_38_2))
					end
				end

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.SetOptionSelect(arg_39_0, arg_39_1, arg_39_2)
	setActive(arg_39_1:Find("selectedFrame"), arg_39_2)

	local var_39_0 = IsNil(arg_39_1:Find("Text")) and arg_39_1:Find("mask/Text"):GetComponent(typeof(Text)) or arg_39_1:Find("Text"):GetComponent(typeof(Text))

	var_39_0.color = arg_39_2 and Color.New(1, 1, 1, 1) or Color.New(0, 0, 0, 0.5)

	return
end

function var_0_0.GetSkinClassify(arg_40_0)
	arg_40_0.classifyIds = Clone(pg.skin_page_template.all)

	table.insert(arg_40_0.classifyIds, 1, var_0_1)

	arg_40_0.classifyNames = {}

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.classifyIds) do
		if iter_40_1 == var_0_1 then
			table.insert(arg_40_0.classifyNames, i18n("index_all"))
		else
			table.insert(arg_40_0.classifyNames, pg.skin_page_template[iter_40_1].name)
		end
	end

	return
end

function var_0_0.filterOk(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1:GetDefaultShipConfig()

	if not var_41_0 then
		return false
	end

	local var_41_1 = arg_41_0:ToVShip(var_41_0)

	if arg_41_0.filterValues.ownType ~= 0 then
		local var_41_2 = false

		if arg_41_0.filterValues.ownType == 1 and getProxy(ShipSkinProxy):hasSkin(arg_41_1.id) and arg_41_1:NoUse() then
			var_41_2 = true
		end

		if not var_41_2 then
			return false
		end
	end

	if arg_41_0.filterValues.typeType[1] ~= 0 then
		local var_41_3 = false

		for iter_41_0, iter_41_1 in ipairs(arg_41_0.filterValues.typeType) do
			if iter_41_1 == 1 and (arg_41_1:IsLive2d() or arg_41_1:IsLive2dPlus()) then
				var_41_3 = true
			end

			if iter_41_1 == 2 and not arg_41_1:IsLive2d() and not arg_41_1:IsLive2dPlus() and not arg_41_1:IsSpine() and not arg_41_1:IsSpinePlus() then
				var_41_3 = true
			end

			if iter_41_1 == 3 and (arg_41_1:IsSpine() or arg_41_1:IsSpinePlus()) then
				var_41_3 = true
			end

			if iter_41_1 == 4 and arg_41_1:IsBG() then
				var_41_3 = true
			end

			if iter_41_1 == 5 and arg_41_1:IsDbg() then
				var_41_3 = true
			end

			if iter_41_1 == 6 and arg_41_1:isBgm() then
				var_41_3 = true
			end

			if var_41_3 then
				break
			end
		end

		if not var_41_3 then
			return false
		end
	end

	if arg_41_0.filterValues.shipHaveType ~= 0 then
		local var_41_4 = false
		local var_41_5 = arg_41_1:CantUse()

		if arg_41_0.filterValues.shipHaveType == 1 and not var_41_5 then
			var_41_4 = true
		end

		if arg_41_0.filterValues.shipHaveType == 2 and var_41_5 then
			var_41_4 = true
		end

		if not var_41_4 then
			return false
		end
	end

	if arg_41_0.filterValues.campType[1] ~= 0 then
		local var_41_6 = false

		for iter_41_2, iter_41_3 in ipairs(arg_41_0.filterValues.campType) do
			for iter_41_4, iter_41_5 in ipairs(ShipIndexCfg.camp[iter_41_3 + 1].types) do
				if iter_41_5 == Nation.LINK then
					if var_41_1:getNation() >= Nation.LINK then
						var_41_6 = true
					end
				elseif iter_41_5 == var_41_1:getNation() then
					var_41_6 = true
				end
			end

			if var_41_6 then
				break
			end
		end

		if not var_41_6 then
			return false
		end
	end

	if arg_41_0.filterValues.rarityType[1] ~= 0 then
		local var_41_7 = false

		for iter_41_6, iter_41_7 in ipairs(arg_41_0.filterValues.rarityType) do
			if table.contains(ShipIndexCfg.rarity[iter_41_7 + 1].types, var_41_1:getRarity()) then
				var_41_7 = true
			end

			if var_41_7 then
				break
			end
		end

		if not var_41_7 then
			return false
		end
	end

	if arg_41_0.filterValues.shipType[1] ~= 0 then
		local var_41_8 = false

		for iter_41_8, iter_41_9 in ipairs(arg_41_0.filterValues.shipType) do
			if iter_41_9 + 1 < 4 then
				if table.contains(ShipIndexCfg.type[iter_41_9 + 1].types, var_41_1:getShipType()) then
					var_41_8 = true
				end

				if table.contains(ShipIndexCfg.type[iter_41_9 + 1].types, var_41_1:getTeamType()) then
					var_41_8 = true
				end
			elseif table.contains(ShipIndexCfg.type[iter_41_9 + 1].types, var_41_1:getShipType()) then
				var_41_8 = true
			end

			if var_41_8 then
				break
			end
		end

		if not var_41_8 then
			return false
		end
	end

	if arg_41_0.filterValues.themeType[1] ~= 0 then
		local var_41_10 = false

		for iter_41_10, iter_41_11 in ipairs(arg_41_0.filterValues.themeType) do
			local var_41_11 = arg_41_0.classifyIds[iter_41_11 + 1]
			local var_41_12 = arg_41_0:GetShopTypeIdBySkinId(arg_41_1.id)

			if arg_41_0.classifyIds[iter_41_11 + 1] == var_0_1 then
				var_41_10 = true

				goto label_41_0
			end

			::label_41_0::

			if var_41_12 == 0 then
				do
					local var_41_13 = var_0_2 or var_41_12

					var_41_10 = var_41_13 == var_41_11
				end

				if var_41_10 then
					break
				end
			end
		end

		if not var_41_10 then
			return false
		end
	end

	return true
end

function var_0_0.ToVShip(arg_42_0, arg_42_1)
	if not arg_42_0.vship then
		arg_42_0.vship = {}

		function arg_42_0.vship.getNation()
			return arg_42_0.vship.config.nationality
		end

		function arg_42_0.vship.getShipType()
			return arg_42_0.vship.config.type
		end

		function arg_42_0.vship.getTeamType()
			return ShipType.GetTeamFromShipType(arg_42_0.vship.config.type)
		end

		function arg_42_0.vship.getRarity()
			return arg_42_0.vship.config.rarity
		end
	end

	arg_42_0.vship.config = arg_42_1

	return arg_42_0.vship
end

function var_0_0.GetShopTypeIdBySkinId(arg_47_0, arg_47_1)
	arg_47_0.shopTypeIdList = arg_47_0.shopTypeIdList or {}

	if arg_47_0.shopTypeIdList[arg_47_1] then
		return arg_47_0.shopTypeIdList[arg_47_1]
	end

	for iter_47_0, iter_47_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_47_2, iter_47_3 in ipairs(iter_47_1) do
			arg_47_0.shopTypeIdList[iter_47_3] = iter_47_0

			if iter_47_3 == arg_47_1 then
				return iter_47_0
			end
		end
	end

	return
end

function var_0_0.willExit(arg_48_0)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0.cards) do
		iter_48_1:Dispose()
	end

	arg_48_0.cards = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_48_0._tf)

	return
end

function var_0_0.onBackPressed(arg_49_0)
	var_0_0.super.onBackPressed(arg_49_0)

	return
end

return var_0_0
