local NewSkinAtlasLayer = class("NewSkinAtlasLayer", import("...base.BaseUI"))
local var_0_1 = -1
local var_0_2 = 9999

function NewSkinAtlasLayer:getUIName()
	return "NewSkinAtlasUI"
end

function NewSkinAtlasLayer:init()
	self.bg = self._tf:Find("bg")
	self.empty = self._tf:Find("empty")
	self.backBtn = self._tf:Find("adapt/top/closeBtn")
	self.homeBtn = self._tf:Find("adapt/top/homeBtn")
	self.resources = self._tf:Find("adapt/top/resources")
	self.filterBtn = self._tf:Find("adapt/top/filterBtn")
	self.search = self._tf:Find("adapt/top/search")
	self.scrollrect = self._tf:Find("scroll"):GetComponent("LScrollRect")
	self.filterUI = self._tf:Find("subPage/filterUI")
	self.filterContent = self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content")

	setActive(self.filterUI, false)
	setText(self.empty:Find("Text"), i18n("shop_new_unfound"))
	setText(self._tf:Find("adapt/top/title/Text"), i18n("shop_new_shop"))
	setText(self._tf:Find("adapt/top/have/Text"), i18n("shop_new_owned_skin"))
	setText(self.filterBtn:Find("Text"), i18n("shop_new_sort"))
	setText(self.search:Find("holder"), i18n("shop_new_search"))
	setText(self.filterUI:Find("panelMask/panel/title"), i18n("shop_new_sort"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/subTitleFrame/subTitle"), i18n("shop_new_review"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/0/Text"), i18n("shop_new_all"))
	setScrollText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/1/mask/Text"), i18n("shop_new_unused"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle"), i18n("shop_new_type"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/0/Text"), i18n("shop_new_all"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/2/Text"), i18n("shop_new_static"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/3/Text"), i18n("shop_new_dynamic"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/4/Text"), i18n("shop_new_static_bg"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/5/Text"), i18n("shop_new_dynamic_bg"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/6/Text"), i18n("shop_new_bgm"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/subTitleFrame/subTitle"), i18n("shop_new_index"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/0/Text"), i18n("shop_new_all"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/1/Text"), i18n("shop_new_ship_owned"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/2/Text"), i18n("shop_new_ship_havent_owned"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/camp/subTitleFrame/subTitle"), i18n("shop_new_nation"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/rarity/subTitleFrame/subTitle"), i18n("shop_new_rarity"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipType/subTitleFrame/subTitle"), i18n("shop_new_category"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/themeType/subTitleFrame/subTitle"), i18n("shop_new_skin_theme"))
	setText(self.filterUI:Find("panelMask/panel/bottom/ok/Text"), i18n("shop_new_confirm"))
	pg.UIMgr.GetInstance():OverlayPanel(self._tf, {
		pbList = {
			self.bg,
			self.filterUI:Find("panelMask/panel")
		}
	})

	return
end

function NewSkinAtlasLayer:didEnter()
	self:InitData()
	self:SetFilterPanel()
	self:SetResource()
	self:SetSkinScroll()
	self:Refresh()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(NewSkinAtlasLayer.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.filterBtn, function()
		self:OpenFilterPanel()

		return
	end, SFX_PANEL)
	onInputChanged(self, self.search, function()
		self:Refresh()
		setActive(self.search:Find("holder"), getInputText(self.search) == "")

		return
	end)

	return
end

function NewSkinAtlasLayer:InitData()
	self.skins = getProxy(ShipSkinProxy):GetOwnSkins()

	for iter_8_0 = #self.skins, 1, -1 do
		local var_8_0 = ShipSkin.GetChangeSkinIndex(self.skins[iter_8_0].id)

		if var_8_0 and var_8_0 ~= 1 then
			table.remove(self.skins, iter_8_0)
		end
	end

	self:GetSkinClassify()

	self.filterValues = {
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
	self.filterValuesTemp = Clone(self.filterValues)

	return
end

function NewSkinAtlasLayer:SetResource()
	setText(self.resources:Find("gem/Text"), getProxy(PlayerProxy):getRawData():getTotalGem())
	onButton(self, self.resources:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function NewSkinAtlasLayer:SetSkinScroll()
	self.scrollrect.isNewLoadingMethod = true

	function self.scrollrect.onInitItem(arg_12_0)
		self:OnInitItem(arg_12_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_13_0, arg_13_1)
		self:OnUpdateItem(arg_13_0, arg_13_1)

		return
	end

	function self.scrollrect.onReturnItem(arg_14_0, arg_14_1)
		self:OnReturnItem(arg_14_0, arg_14_1)

		return
	end

	return
end

function NewSkinAtlasLayer:OnInitItem(arg_15_1)
	ClearTweenItemAlphaAndWhite(arg_15_1)

	return
end

function NewSkinAtlasLayer:ReturnIndex(arg_16_1)
	if self.indexDic[arg_16_1] then
		for iter_16_0 = #self.groupDic[self.scrollShowClassifyIds[arg_16_1]], 1, -1 do
			if self.groupDic[self.scrollShowClassifyIds[arg_16_1]][iter_16_0] == arg_16_1 then
				table.remove(self.groupDic[self.scrollShowClassifyIds[arg_16_1]], iter_16_0)
			end
		end
	end

	self.indexDic[arg_16_1] = false

	return
end

function NewSkinAtlasLayer:RegisterIndex(arg_17_1)
	self.indexDic[arg_17_1] = true

	if self.scrollShowClassifyIds[arg_17_1] then
		self.groupDic[self.scrollShowClassifyIds[arg_17_1]] = self.groupDic[self.scrollShowClassifyIds[arg_17_1]] or {}

		table.insert(self.groupDic[self.scrollShowClassifyIds[arg_17_1]], arg_17_1)
	end

	return
end

function NewSkinAtlasLayer:ChangeClassifyName(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0

		for iter_18_2, iter_18_3 in pairs(self.goDic) do
			if iter_18_1 == iter_18_3 then
				var_18_0 = iter_18_2

				break
			end
		end

		if var_18_0 then
			local var_18_1 = self.scrollShowClassifyIds[iter_18_1]
			local var_18_2 = self.classifyNames[table.indexof(self.classifyIds, self.scrollShowClassifyIds[iter_18_1])]
			local var_18_3 = (self.groupDic[self.scrollShowClassifyIds[iter_18_1]] or {})[1] == iter_18_1

			setActive(tf(var_18_0):Find("titleBar"), (self.groupDic[self.scrollShowClassifyIds[iter_18_1]] or {})[1] == iter_18_1)

			if var_18_3 then
				setText(tf(var_18_0):Find("titleBar/title"), var_18_2)

				local var_18_4 = self._tf:Find("scroll/content")
				local var_18_5 = var_18_4:GetComponent(typeof(VerticalLayoutGroup)).spacing
				local var_18_6 = tf(var_18_0).GetComponent(var_18_4, typeof(LayoutElement)).preferredHeight

				setSizeDelta(tf(var_18_0):Find("titleBar"), {
					x = tf(var_18_0):Find("titleBar").rect.width,
					y = var_18_6 * self.scrollClassifyNum[var_18_1] + var_18_5 * (self.scrollClassifyNum[var_18_1] - 1)
				})
				setAnchoredPosition(tf(var_18_0):Find("titleBar"), {
					y = (self.scrollShouldShowName[iter_18_1] - 1) * (var_18_6 + var_18_5)
				})
			end
		end
	end

	return
end

function NewSkinAtlasLayer:GetDisplayIndex(arg_19_1)
	return (self.groupDic[arg_19_1] or {})[1]
end

function NewSkinAtlasLayer:ClickTrigger(arg_20_1, arg_20_2)
	self:emit(NewSkinAtlasMediator.OPEN_SHOW_LAYER, arg_20_2)

	return
end

function NewSkinAtlasLayer:OnUpdateItem(arg_21_1, arg_21_2)
	TweenItemAlphaAndWhite(arg_21_2)

	arg_21_1 = arg_21_1 + 1

	local var_21_0 = self.scrollDisplays[arg_21_1]

	if self.goDic[arg_21_2] and self.goDic[arg_21_2] ~= arg_21_1 then
		local var_21_1 = self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_21_2]])

		self:ReturnIndex(self.goDic[arg_21_2])

		if var_21_1 ~= self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_21_2]]) then
			local var_21_2 = {}

			table.insert(var_21_2, var_21_1)
			table.insert(var_21_2, self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_21_2]]))
			self:ChangeClassifyName(var_21_2)
		end
	end

	self.goDic[arg_21_2] = arg_21_1

	local var_21_3 = self:GetDisplayIndex(self.scrollShowClassifyIds[arg_21_1])

	self:RegisterIndex(arg_21_1)

	local var_21_4 = {}

	if var_21_3 ~= self:GetDisplayIndex(self.scrollShowClassifyIds[arg_21_1]) then
		table.insert(var_21_4, var_21_3)
	end

	table.insert(var_21_4, arg_21_1)
	self:ChangeClassifyName(var_21_4)

	if self.scrollDisplays[arg_21_1] then
		local var_21_5 = UIItemList.New(tf(arg_21_2):Find("skins"), tf(arg_21_2):Find("skins/SkinAtlasCard"))

		var_21_5:make(function(arg_22_0, arg_22_1, arg_22_2)
			if arg_22_0 == UIItemList.EventUpdate then
				local var_22_0 = var_21_0[arg_22_1 + 1]
				local var_22_1 = SkinAtlasCard.New(arg_22_2)

				table.insert(self.cards, var_22_1)
				var_22_1:Update(var_21_0[arg_22_1 + 1], arg_22_1 + 1)
				onButton(self, arg_22_2, function()
					self:ClickTrigger(var_22_1, var_22_0)

					return
				end, SFX_PANEL)
				onButton(self, var_22_1.changeSkinUI, function()
					var_22_1:changeSkinNext()

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_21_5:align(#self.scrollDisplays[arg_21_1])
	end

	return
end

function NewSkinAtlasLayer:OnReturnItem(arg_25_1, arg_25_2)
	ClearTweenItemAlphaAndWhite(arg_25_2)

	if self.exited then
		return
	end

	if self.goDic[arg_25_2] then
		local var_25_0 = self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_25_2]])

		self:ReturnIndex(self.goDic[arg_25_2])

		if var_25_0 ~= self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_25_2]]) then
			local var_25_1 = {}

			table.insert(var_25_1, var_25_0)
			table.insert(var_25_1, self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_25_2]]))
			self:ChangeClassifyName(var_25_1)
		end
	end

	return
end

function NewSkinAtlasLayer:Refresh()
	self.showClassifyIds = {}
	self.displays = {}

	local var_26_0 = getInputText(self.search)
	local var_26_1 = Clone(self.classifyIds)

	table.remove(var_26_1, 1)
	table.remove(Clone(self.classifyNames), 1)

	for iter_26_0, iter_26_1 in pairs(self.skins) do
		if self:filterOk(iter_26_1) and self:IsSearchType(var_26_0, iter_26_1) then
			local var_26_2 = self:GetShopTypeIdBySkinId(iter_26_1.id)
			local var_26_3

			if var_26_2 == 0 then
				var_26_3 = var_0_2 or var_26_2
				self.displays[var_26_3] = self.displays[var_26_3] or {}
			end

			table.insert(self.displays[var_26_3], iter_26_1)
		end
	end

	for iter_26_2, iter_26_3 in ipairs(var_26_1) do
		if self.displays[iter_26_3] then
			table.insert(self.showClassifyIds, iter_26_3)
		end
	end

	setActive(self.empty, #self.showClassifyIds == 0)

	self.scrollShowClassifyIds = {}
	self.scrollDisplays = {}
	self.scrollShouldShowName = {}
	self.scrollClassifyNum = {}

	for iter_26_4, iter_26_5 in ipairs(self.showClassifyIds) do
		local var_26_4 = Clone(self.displays[iter_26_5])
		local var_26_5 = false

		self.scrollClassifyNum[iter_26_5] = math.ceil(#var_26_4 / 8)

		local var_26_6 = 1

		while #var_26_4 > 8 do
			table.insert(self.scrollShowClassifyIds, iter_26_5)
			table.insert(self.scrollShouldShowName, var_26_6)

			var_26_6 = var_26_6 + 1
			var_26_5 = var_26_5 or true

			local var_26_7 = {}

			for iter_26_6 = 1, 8 do
				table.insert(var_26_7, table.remove(var_26_4, 1))
			end

			table.insert(self.scrollDisplays, var_26_7)
		end

		if #var_26_4 > 0 then
			table.insert(self.scrollShowClassifyIds, iter_26_5)
			table.insert(self.scrollShouldShowName, var_26_6)

			local var_26_8

			var_26_8 = var_26_5 or true

			table.insert(self.scrollDisplays, var_26_4)
		end
	end

	self.indexDic = {}
	self.groupDic = {}
	self.goDic = {}

	if self.cards then
		for iter_26_7, iter_26_8 in ipairs(self.cards) do
			iter_26_8:Dispose()
		end
	end

	self.cards = {}

	self.scrollrect:SetTotalCount(#self.scrollShowClassifyIds, 0)

	return
end

function NewSkinAtlasLayer:IsSearchType(arg_27_1, arg_27_2)
	local var_27_0

	if not arg_27_1 or arg_27_1 == "" then
		do return true end

		var_27_0 = {}
	end

	var_27_0.id = arg_27_2.id

	return ShipSkin.New(var_27_0):IsMatchKey(arg_27_1)
end

function NewSkinAtlasLayer:SetFilterPanel()
	local var_28_0 = self.filterContent:Find("camp/options")
	local var_28_1 = self.filterContent:Find("rarity/options")
	local var_28_2 = self.filterContent:Find("shipType/options")
	local var_28_3 = self.filterContent:Find("themeType/options")

	self:SetOptionList(var_28_0, ShipIndexConst.CampNames, true)
	self:SetOptionList(var_28_1, ShipIndexConst.RarityNames, true)
	self:SetOptionList(var_28_2, ShipIndexConst.TypeNames, true)
	self:SetOptionList(var_28_3, self.classifyNames)
	self:SetSingleOptions(self.filterContent:Find("own/options"), "ownType")
	self:SetMultiOptions(self.filterContent:Find("type/options"), "typeType")
	self:SetSingleOptions(self.filterContent:Find("shipHave/options"), "shipHaveType")
	self:SetMultiOptions(var_28_0, "campType")
	self:SetMultiOptions(var_28_1, "rarityType")
	self:SetMultiOptions(var_28_2, "shipType")
	self:SetMultiOptions(var_28_3, "themeType")
	onButton(self, self.filterUI:Find("bg"), function()
		for iter_29_0, iter_29_1 in pairs(self.filterValues) do
			self.filterValuesTemp[iter_29_0] = Clone(self.filterValues[iter_29_0])
		end

		setActive(self.filterUI, false)

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("panelMask/panel/closeBtn"), function()
		for iter_30_0, iter_30_1 in pairs(self.filterValues) do
			self.filterValuesTemp[iter_30_0] = Clone(self.filterValues[iter_30_0])
		end

		setActive(self.filterUI, false)

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("panelMask/panel/bottom/ok"), function()
		for iter_31_0, iter_31_1 in pairs(self.filterValues) do
			self.filterValues[iter_31_0] = Clone(self.filterValuesTemp[iter_31_0])
		end

		setActive(self.filterUI, false)
		self:Refresh()

		return
	end, SFX_PANEL)

	return
end

function NewSkinAtlasLayer:OpenFilterPanel()
	setActive(self.filterUI, true)
	self:SetSingleOptions(self.filterContent:Find("own/options"), "ownType", true)
	self:SetMultiOptions(self.filterContent:Find("type/options"), "typeType", true)
	self:SetSingleOptions(self.filterContent:Find("shipHave/options"), "shipHaveType", true)
	self:SetMultiOptions(self.filterContent:Find("camp/options"), "campType", true)
	self:SetMultiOptions(self.filterContent:Find("rarity/options"), "rarityType", true)
	self:SetMultiOptions(self.filterContent:Find("shipType/options"), "shipType", true)
	self:SetMultiOptions(self.filterContent:Find("themeType/options"), "themeType", true)

	return
end

function NewSkinAtlasLayer:SetOptionList(arg_33_1, arg_33_2, arg_33_3)
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

function NewSkinAtlasLayer:SetSingleOptions(arg_35_1, arg_35_2, arg_35_3)
	for iter_35_0 = 0, arg_35_1.childCount - 1 do
		local var_35_0 = arg_35_1:GetChild(iter_35_0)

		self:SetOptionSelect(arg_35_1:GetChild(iter_35_0), iter_35_0 == self.filterValuesTemp[arg_35_2])

		if not arg_35_3 then
			onButton(self, var_35_0, function()
				self.filterValuesTemp[arg_35_2] = iter_35_0

				for iter_36_0 = 0, arg_35_1.childCount - 1 do
					self:SetOptionSelect(arg_35_1:GetChild(iter_36_0), iter_36_0 == iter_35_0)
				end

				return
			end, SFX_PANEL)
		end
	end

	return
end

function NewSkinAtlasLayer:SetMultiOptions(arg_37_1, arg_37_2, arg_37_3)
	for iter_37_0 = 0, arg_37_1.childCount - 1 do
		local var_37_0 = arg_37_1:GetChild(iter_37_0)

		self:SetOptionSelect(arg_37_1:GetChild(iter_37_0), table.contains(self.filterValuesTemp[arg_37_2], iter_37_0))

		if not arg_37_3 then
			onButton(self, var_37_0, function()
				if iter_37_0 == 0 then
					self.filterValuesTemp[arg_37_2] = {
						0
					}

					for iter_38_0 = 0, arg_37_1.childCount - 1 do
						self:SetOptionSelect(arg_37_1:GetChild(iter_38_0), iter_38_0 == 0)
					end
				else
					table.removebyvalue(self.filterValuesTemp[arg_37_2], 0)

					if table.contains(self.filterValuesTemp[arg_37_2], iter_37_0) then
						table.removebyvalue(self.filterValuesTemp[arg_37_2], iter_37_0)
					else
						table.insert(self.filterValuesTemp[arg_37_2], iter_37_0)
					end

					local var_38_0 = true

					for iter_38_1 = 1, arg_37_1.childCount - 1 do
						if not table.contains(self.filterValuesTemp[arg_37_2], iter_38_1) then
							var_38_0 = false

							break
						end
					end

					if (#self.filterValuesTemp[arg_37_2] == 0 or nil) and true then
						self.filterValuesTemp[arg_37_2] = {
							0
						}
					end

					for iter_38_2 = 0, arg_37_1.childCount - 1 do
						self:SetOptionSelect(arg_37_1:GetChild(iter_38_2), table.contains(self.filterValuesTemp[arg_37_2], iter_38_2))
					end
				end

				return
			end, SFX_PANEL)
		end
	end

	return
end

function NewSkinAtlasLayer:SetOptionSelect(arg_39_1, arg_39_2)
	setActive(arg_39_1:Find("selectedFrame"), arg_39_2)

	;(IsNil(arg_39_1:Find("Text")) and arg_39_1:Find("mask/Text"):GetComponent(typeof(Text)) or arg_39_1:Find("Text"):GetComponent(typeof(Text))).color = arg_39_2 and Color.New(1, 1, 1, 1) or Color.New(0, 0, 0, 0.5)

	return
end

function NewSkinAtlasLayer:GetSkinClassify()
	self.classifyIds = Clone(pg.skin_page_template.all)

	table.insert(self.classifyIds, 1, var_0_1)

	self.classifyNames = {}

	for iter_40_0, iter_40_1 in ipairs(self.classifyIds) do
		if iter_40_1 == var_0_1 then
			table.insert(self.classifyNames, i18n("index_all"))
		else
			table.insert(self.classifyNames, pg.skin_page_template[iter_40_1].name)
		end
	end

	return
end

function NewSkinAtlasLayer:filterOk(arg_41_1)
	local var_41_0 = arg_41_1:GetDefaultShipConfig()

	if not var_41_0 then
		return false
	end

	local var_41_1 = self:ToVShip(var_41_0)

	if self.filterValues.ownType ~= 0 then
		if not (self.filterValues.ownType == 1 and getProxy(ShipSkinProxy):hasSkin(arg_41_1.id) and arg_41_1:NoUse()) then
			return false
		end
	end

	if self.filterValues.typeType[1] ~= 0 then
		local var_41_3 = false

		for iter_41_0, iter_41_1 in ipairs(self.filterValues.typeType) do
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

	if self.filterValues.shipHaveType ~= 0 then
		local var_41_4 = false
		local var_41_5 = arg_41_1:CantUse()

		if self.filterValues.shipHaveType == 1 and not var_41_5 then
			var_41_4 = true
		end

		if not ((self.filterValues.shipHaveType == 2 and var_41_5 or nil) and true) then
			return false
		end
	end

	if self.filterValues.campType[1] ~= 0 then
		local var_41_6 = false

		for iter_41_2, iter_41_3 in ipairs(self.filterValues.campType) do
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

	if self.filterValues.rarityType[1] ~= 0 then
		local var_41_7 = false

		for iter_41_6, iter_41_7 in ipairs(self.filterValues.rarityType) do
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

	if self.filterValues.shipType[1] ~= 0 then
		local var_41_8 = false

		for iter_41_8, iter_41_9 in ipairs(self.filterValues.shipType) do
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

	if self.filterValues.themeType[1] ~= 0 then
		local var_41_10 = false

		for iter_41_10, iter_41_11 in ipairs(self.filterValues.themeType) do
			if self.classifyIds[iter_41_11 + 1] == var_0_1 then
				var_41_10 = true
			else
				local var_41_11 = self:GetShopTypeIdBySkinId(arg_41_1.id)

				var_41_10 = ((var_41_11 == 0 or nil) and (var_0_2 or var_41_11)) == self.classifyIds[iter_41_11 + 1]
			end

			if var_41_10 then
				break
			end
		end

		if not var_41_10 then
			return false
		end
	end

	return true
end

function NewSkinAtlasLayer:ToVShip(arg_42_1)
	if not self.vship then
		self.vship = {}

		function self.vship.getNation()
			return self.vship.config.nationality
		end

		function self.vship.getShipType()
			return self.vship.config.type
		end

		function self.vship.getTeamType()
			return ShipType.GetTeamFromShipType(self.vship.config.type)
		end

		function self.vship.getRarity()
			return self.vship.config.rarity
		end
	end

	self.vship.config = arg_42_1

	return self.vship
end

function NewSkinAtlasLayer:GetShopTypeIdBySkinId(arg_47_1)
	self.shopTypeIdList = self.shopTypeIdList or {}

	if self.shopTypeIdList[arg_47_1] then
		return self.shopTypeIdList[arg_47_1]
	end

	for iter_47_0, iter_47_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_47_2, iter_47_3 in ipairs(iter_47_1) do
			self.shopTypeIdList[iter_47_3] = iter_47_0

			if iter_47_3 == arg_47_1 then
				return iter_47_0
			end
		end
	end

	return
end

function NewSkinAtlasLayer:willExit()
	for iter_48_0, iter_48_1 in ipairs(self.cards) do
		iter_48_1:Dispose()
	end

	self.cards = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function NewSkinAtlasLayer:onBackPressed()
	NewSkinAtlasLayer.super.onBackPressed(self)

	return
end

return NewSkinAtlasLayer
