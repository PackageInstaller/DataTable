local AtelierCompositeScene = class("AtelierCompositeScene", import("view.base.BaseUI"))

function AtelierCompositeScene:getUIName()
	return "AtelierCompositeUI"
end

local AtelierFormula = import("model.vo.AtelierFormula")
local AtelierFormulaCircle = import("model.vo.AtelierFormulaCircle")
local PoolPlural = import("Mgr.Pool.PoolPlural")

AtelierCompositeScene.FilterAll = bit.bor(1, 2, 4)

function AtelierCompositeScene:Ctor(...)
	AtelierCompositeScene.super.Ctor(self, ...)

	self.loader = AutoLoader.New()

	return
end

function AtelierCompositeScene:init()
	self.layerEmpty = self._tf:Find("Empty")
	self.layerFormula = self._tf:Find("FormulaList")
	self.painting = self._tf:Find("Painting")
	self.chat = self.painting:Find("Chat")
	self.layerFormulaDetail = self._tf:Find("FormulaDetail")
	self.layerFormulaOverlay = self.layerFormulaDetail:Find("Overlay")
	self.layerMaterialSelect = self.layerFormulaOverlay:Find("AvaliableMaterials")
	self.layerCompositeConfirm = self._tf:Find("CompositeConfirmWindow")
	self.layerCompositeResult = self._tf:Find("CompositeResultWindow")
	self.layerStoreHouse = self._tf:Find("StoreHouseWindow")
	self.layerMaterialsPreview = self._tf:Find("FormulaMaterialsPreview")
	self.top = self._tf:Find("Top")
	self.formulaRect = self.layerFormula:Find("Frame/ScrollView"):GetComponent("LScrollRect")

	setActive(self.layerFormula:Find("Frame/Item"), false)

	function self.formulaRect.onUpdateItem(arg_4_0, arg_4_1)
		self:UpdateFormulaItem(arg_4_0 + 1, arg_4_1)

		return
	end

	self.formulaFilterButtons = _.map({
		1,
		2,
		3
	}, function(arg_5_0)
		return self.layerFormula:Find("Frame/Tabs"):GetChild(arg_5_0 - 1)
	end)
	self.candicatesRect = self.layerMaterialSelect:Find("Frame/List"):GetComponent("LScrollRect")

	local var_3_0 = self.layerMaterialSelect:Find("Frame/Item")

	setActive(var_3_0, false)

	function self.candicatesRect.onUpdateItem(arg_6_0, arg_6_1)
		self:UpdateCandicateItem(arg_6_0 + 1, arg_6_1)

		return
	end

	self.storehouseRect = self.layerStoreHouse:Find("Window/ScrollView"):GetComponent("LScrollRect")

	setActive(self.layerStoreHouse:Find("Window/ScrollView/Item"), false)
	setActive(self.layerFormula, false)
	setActive(self.layerFormulaDetail, false)
	setActive(self.layerMaterialSelect, false)
	setActive(self.layerEmpty, false)
	setActive(self.layerStoreHouse, false)
	setActive(self.chat, false)
	pg.ViewUtils.SetSortingOrder(self._tf:Find("Mask/BG"):GetChild(0), -1)
	setText(self._tf:Find("Empty/Bar/Text"), i18n("ryza_tip_composite_unlock"))
	setText(self.layerFormula:Find("Frame/Filter/Text"), i18n("ryza_toggle_only_composite"))
	setText(self.layerFormula:Find("Frame/Empty"), i18n("ryza_tip_no_recipe"))
	setText(self.layerFormula:Find("Frame/Item/Lock/Text"), i18n("ryza_tip_unlock_all_tools"))
	setText(self.layerFormula:Find("Bar/Text"), i18n("ryza_tip_select_recipe"))
	setText(self.layerStoreHouse:Find("Window/Empty"), i18n("ryza_tip_no_item"))
	setText(self.layerCompositeResult:Find("Window/CountBG/Tip"), i18n("ryza_composite_count"))
	setText(self.layerMaterialsPreview:Find("Frame/Text"), i18n("ryza_tip_item_access"))
	setText(var_3_0:Find("IconBG/Lack/Text"), i18n("ryza_ui_show_acess"))

	return
end

function AtelierCompositeScene:SetEnabled(arg_7_1)
	self.unlockSystem = arg_7_1

	return
end

function AtelierCompositeScene:SetActivity(arg_8_1)
	self.activity = arg_8_1

	return
end

local var_0_4 = "ui/AtelierCompositeUI_atlas"
local var_0_5 = "ui/AtelierCommonUI_atlas"

function AtelierCompositeScene:preload(arg_9_1)
	table.ParallelIpairsAsync({
		var_0_4,
		var_0_5
	}, function(arg_10_0, arg_10_1, arg_10_2)
		self.loader:LoadBundle(arg_10_1, arg_10_2)

		return
	end, arg_9_1)

	return
end

function AtelierCompositeScene:didEnter()
	self.contextData.filterType = AtelierCompositeScene.FilterAll

	table.Foreach(self.formulaFilterButtons, function(arg_12_0, arg_12_1)
		onButton(self, arg_12_1, function()
			if self.contextData.filterType == AtelierCompositeScene.FilterAll then
				self.contextData.filterType = bit.lshift(1, arg_12_0 - 1)
			else
				self.contextData.filterType = bit.bxor(self.contextData.filterType, bit.lshift(1, arg_12_0 - 1))

				if self.contextData.filterType == 0 then
					self.contextData.filterType = AtelierCompositeScene.FilterAll
				end
			end

			self:UpdateFilterButtons()
			self:FilterFormulas()
			self:UpdateFormulaList()

			return
		end, SFX_PANEL)

		return
	end)
	onToggle(self, self.layerFormula:Find("Frame/Filter/Toggle"), function(arg_14_0)
		self.showOnlyComposite = arg_14_0

		self:FilterFormulas()
		self:UpdateFormulaList()

		return
	end)
	onButton(self, self.layerFormulaOverlay:Find("Description/List"), function()
		self:HideFormulaDetail()

		self.contextData.formulaId = nil

		self:ShowFormulaList()

		return
	end)
	onButton(self, self._tf:Find("Top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_composite_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.layerMaterialSelect:Find("BG"), function()
		self:CloseCandicatePanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.layerCompositeConfirm:Find("BG"), function()
		self:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.layerCompositeConfirm:Find("Window/Cancel"), function()
		self:HideCompositeConfirmWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.layerCompositeResult:Find("BG"), function()
		self:HideCompositeResult()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/StoreHouse"), function()
		self.contextData.showStoreHouse = true

		self:ShowStoreHouseWindow()

		return
	end, SFX_PANEL)
	onButton(self, self.layerStoreHouse:Find("Window/Close"), function()
		self:CloseStoreHouseWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.layerStoreHouse:Find("BG"), function()
		self:CloseStoreHouseWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.layerMaterialsPreview:Find("BG"), function()
		self:HideMaterialsPreview()

		return
	end, SFX_CANCEL)
	pg.UIMgr.GetInstance():OverlayPanel(self.top)

	if not self.unlockSystem then
		setActive(self.layerEmpty, true)
		setActive(self.painting, false)
	else
		if self.contextData.formulaId then
			self:ShowFormulaDetail(self.activity:GetFormulas()[self.contextData.formulaId])
		else
			self:DispalyChat({
				"ryza_atellier1"
			})
			self:ShowFormulaList()
		end

		if self.contextData.showStoreHouse then
			self:ShowStoreHouseWindow()
		end
	end

	if self.unlockSystem then
		if PlayerPrefs.GetInt("first_enter_ryza_atelier_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0 then
			triggerButton(self._tf:Find("Top/Help"))
			PlayerPrefs.SetInt("first_enter_ryza_atelier_" .. getProxy(PlayerProxy):getRawData().id, 1)
		end
	end

	return
end

function AtelierCompositeScene:onBackPressed()
	if self.animating then
		return true
	end

	if self:CloseStoreHouseWindow() then
		return true
	end

	if self:HideMaterialsPreview() then
		return true
	end

	if self:HideCompositeResult() then
		return true
	end

	if self:HideCompositeConfirmWindow() then
		return true
	end

	if self:HideCandicatePanel() then
		return true
	end

	if self:HideFormulaDetail() then
		self.contextData.formulaId = nil

		self:ShowFormulaList()

		return true
	end

	self:emit(AtelierCompositeScene.ON_BACK_PRESSED)

	return
end

function AtelierCompositeScene:UpdateFilterButtons()
	table.Foreach(self.formulaFilterButtons, function(arg_29_0, arg_29_1)
		setActive(arg_29_1:Find("Selected"), self.contextData.filterType ~= AtelierCompositeScene.FilterAll and bit.band(self.contextData.filterType, bit.lshift(1, arg_29_0 - 1)) > 0)

		return
	end)

	return
end

function AtelierCompositeScene:AddIdleTimer()
	self:RemoveIdleTimer()

	self.idleTimer = Timer.New(function()
		self:DispalyChat({
			"ryza_atellier1"
		})
		self:AddIdleTimer()

		return
	end, 8 + math.random() * 4)

	self.idleTimer:Start()

	return
end

function AtelierCompositeScene:RemoveIdleTimer()
	if not self.idleTimer then
		return
	end

	self.idleTimer:Stop()

	self.idleTimer = nil

	return
end

function AtelierCompositeScene:ShowFormulaList()
	self:AddIdleTimer()
	setActive(self.layerFormula, true)
	setParent(self.layerFormula, self.top)
	self.layerFormula:SetSiblingIndex(0)
	self:UpdateFilterButtons()
	self:FilterFormulas()
	self:UpdateFormulaList()

	return
end

function AtelierCompositeScene:HideFormulaList()
	if not self.layerFormula then
		return
	end

	self:RemoveIdleTimer()
	setParent(self.layerFormula, self._tf)
	setActive(self.layerFormula, false)

	return true
end

function AtelierCompositeScene:FilterFormulas()
	self.filterFormulas = {}

	local var_35_0 = self.contextData.filterType

	local function var_35_1(arg_36_0)
		if var_35_0 == AtelierCompositeScene.FilterAll then
			return true
		end

		return switch(arg_36_0:GetType(), {
			[AtelierFormula.TYPE.EQUIP] = function()
				return bit.band(var_35_0, 1) > 0
			end,
			[AtelierFormula.TYPE.ITEM] = function()
				return bit.band(var_35_0, 2) > 0
			end,
			[AtelierFormula.TYPE.TOOL] = function()
				return bit.band(var_35_0, 4) > 0
			end,
			[AtelierFormula.TYPE.OTHER] = function()
				return bit.band(var_35_0, 4) > 0
			end
		})
	end

	for iter_35_0, iter_35_1 in ipairs(_.values(self.activity:GetFormulas())) do
		if var_35_1(iter_35_1) and (not self.showOnlyComposite or iter_35_1:IsAvaliable() and AtelierFormula.IsFormualCanComposite(iter_35_1, self.activity)) then
			table.insert(self.filterFormulas, iter_35_1)
		end
	end

	table.sort(self.filterFormulas, function(arg_41_0, arg_41_1)
		for iter_41_0, iter_41_1 in ipairs({
			function(arg_42_0)
				return arg_42_0:IsAvaliable() and 0 or 1
			end,
			function(arg_43_0)
				if arg_43_0:GetType() ~= AtelierFormula.TYPE.TOOL and not self.activity:IsCompleteAllTools() then
					return 1
				else
					return 0
				end

				return
			end,
			function(arg_44_0)
				return arg_44_0:GetConfigID()
			end
		}) do
			local var_41_0 = iter_41_1(arg_41_0)
			local var_41_1 = iter_41_1(arg_41_1)

			if var_41_0 ~= var_41_1 then
				return var_41_0 < var_41_1
			end
		end

		return false
	end)

	return
end

function AtelierCompositeScene:UpdateFormulaList()
	local var_45_0 = #self.filterFormulas == 0

	setActive(self.layerFormula:Find("Frame/Empty"), #self.filterFormulas == 0)
	setActive(self.layerFormula:Find("Frame/ScrollView"), not var_45_0)
	self.formulaRect:SetTotalCount(#self.filterFormulas)

	return
end

local var_0_6 = {
	[AtelierFormula.TYPE.EQUIP] = "ryza_word_equip",
	[AtelierFormula.TYPE.ITEM] = "word_item",
	[AtelierFormula.TYPE.TOOL] = "word_tool",
	[AtelierFormula.TYPE.OTHER] = "word_other"
}

function AtelierCompositeScene:UpdateFormulaItem(arg_46_1, arg_46_2)
	local var_46_0 = tf(arg_46_2)
	local var_46_1 = self.filterFormulas[arg_46_1]
	local var_46_2 = self.filterFormulas[arg_46_1]:GetProduction()

	self:UpdateRyzaDrop(var_46_0:Find("BG/Icon"), {
		type = var_46_2[1],
		id = var_46_2[2]
	}, true)

	local var_46_3 = var_0_6[var_46_1:GetType()]
	local var_46_4 = var_46_1:GetType() ~= AtelierFormula.TYPE.TOOL and not self.activity:IsCompleteAllTools()

	setActive(var_46_0:Find("Lock"), var_46_4)
	setActive(var_46_0:Find("BG"), not var_46_4)
	setText(var_46_0:Find("BG/Type"), i18n(var_46_3))
	setScrollText(var_46_0:Find("BG/Name/Text"), var_46_1:GetName())

	local var_46_5 = var_46_1:GetMaxLimit() > 0 and var_46_1:GetMaxLimit() - var_46_1:GetUsedCount() .. "/" .. var_46_1:GetMaxLimit() or "∞"
	local var_46_6 = var_46_1:IsAvaliable()

	setActive(var_46_0:Find("BG/Count"), var_46_6)
	setActive(var_46_0:Find("Completed"), not var_46_6)

	if var_46_6 then
		setTextColor(var_46_0:Find("BG/Count"), (SummerFeastScene.TransformColor(AtelierFormula.IsFormualCanComposite(var_46_1, self.activity) and "4fb3a3" or "d55a54")))
	end

	setText(var_46_0:Find("BG/Count"), var_46_5)
	onButton(self, var_46_0, function()
		if not var_46_6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

			return
		end

		if var_46_4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

			return
		end

		self:HideFormulaList()
		self:ShowFormulaDetail(var_46_1)
		self:DispalyChat({
			"ryza_atellier2",
			"ryza_atellier3",
			"ryza_atellier4"
		})
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_1")

		return
	end, SFX_PANEL)

	return
end

function AtelierCompositeScene:UpdateRyzaDrop(arg_48_1, arg_48_2, arg_48_3)
	updateDrop(arg_48_1, arg_48_2)
	SetCompomentEnabled(arg_48_1:Find("icon_bg"), typeof(Image), false)
	setActive(arg_48_1:Find("bg"), false)
	setActive(arg_48_1:Find("icon_bg/frame"), false)
	setActive(arg_48_1:Find("icon_bg/stars"), false)

	local var_48_0 = arg_48_2:getConfig("rarity")

	if arg_48_2.type == DROP_TYPE_EQUIP or arg_48_2.type == DROP_TYPE_EQUIPMENT_SKIN then
		var_48_0 = var_48_0 - 1
	end

	local var_48_1 = "icon_frame_" .. var_48_0

	if arg_48_3 then
		var_48_1 = var_48_1 .. "_small"
	end

	self.loader:GetSpriteQuiet(var_0_5, var_48_1, arg_48_1)

	if arg_48_2.type == DROP_TYPE_EQUIP or arg_48_2.type == DROP_TYPE_SPWEAPON then
		onButton(self, arg_48_1, function()
			self:emit(AtelierCompositeScene.ON_DROP, arg_48_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_48_1)
	end

	return
end

local var_0_7 = {
	[AtelierFormulaCircle.TYPE.BASE] = "circle",
	[AtelierFormulaCircle.TYPE.NORMAL] = "hexagon",
	[AtelierFormulaCircle.TYPE.SAIREN] = "doubleHexagon",
	[AtelierFormulaCircle.TYPE.ANY] = "anyHexagon"
}

function AtelierCompositeScene:ShowFormulaDetail(arg_50_1)
	setActive(self.layerFormulaDetail, true)
	setParent(self.layerFormulaOverlay, self.top)
	self.layerFormulaOverlay:SetSiblingIndex(0)
	setParent(self.painting, self.layerFormulaOverlay)
	self.painting:SetSiblingIndex(0)

	if not self.nodePools then
		self.nodePools = {
			circle = PoolPlural.New(self.layerFormulaDetail:Find("CircleNode").gameObject, 100),
			hexagon = PoolPlural.New(self.layerFormulaDetail:Find("HexagonNode").gameObject, 100),
			anyHexagon = PoolPlural.New(self.layerFormulaDetail:Find("AnyHexagonNode").gameObject, 100),
			doubleHexagon = PoolPlural.New(self.layerFormulaDetail:Find("DoubleHexagonNode").gameObject, 100)
		}

		table.Foreach(self.nodePools, function(arg_51_0, arg_51_1)
			setActive(arg_51_1.prefab, false)

			return
		end)
	end

	self.pluralRoot = self.pluralRoot or pg.PoolMgr.GetInstance().root
	self.nodeList = self.nodeList or {}

	_.each(self.nodeList, function(arg_52_0)
		local var_52_0 = tf(arg_52_0.GO)

		SetCompomentEnabled(var_52_0:Find("Item"), typeof(Image), false)
		self.loader:ClearRequest(var_52_0:Find("Ring"))
		table.Foreach(arg_52_0.links, function(arg_53_0)
			self.loader:ClearRequest((var_52_0:Find("Links/" .. arg_53_0)))

			return
		end)
		self.loader:ClearRequest(var_52_0)

		if not self.nodePools[var_0_7[arg_52_0.Data:GetType()]]:Enqueue(go(arg_52_0.GO)) then
			setParent(go(arg_52_0.GO), self.pluralRoot)
			setActive(go(arg_52_0.GO), false)
		end

		return
	end)
	table.clean(self.nodeList)
	self:InitFormula(arg_50_1)

	return
end

function AtelierCompositeScene:HideFormulaDetail()
	if not isActive(self.layerFormulaDetail) then
		return
	end

	self:HideCandicatePanel()
	setParent(self.painting, self._tf)
	self.painting:SetSiblingIndex(1)
	setParent(self.layerFormulaOverlay, self.layerFormulaDetail)
	setActive(self.layerFormulaDetail, false)

	return true
end

local var_0_8 = {
	{
		0,
		1
	},
	{
		-1,
		1
	},
	{
		-1,
		0
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	},
	{
		1,
		0
	}
}
local var_0_9 = {
	[AtelierFormula.TYPE.EQUIP] = "text_equip",
	[AtelierFormula.TYPE.ITEM] = "text_item",
	[AtelierFormula.TYPE.TOOL] = "text_other",
	[AtelierFormula.TYPE.OTHER] = "text_other"
}

function AtelierCompositeScene:InitFormula(arg_55_1)
	self.contextData.formulaId = arg_55_1:GetConfigID()

	local var_55_0 = self.layerFormulaOverlay:Find("Description")

	self.loader:GetSpriteQuiet(var_0_4, var_0_9[arg_55_1:GetType()], var_55_0:Find("Type"))
	self:UpdateRyzaDrop(var_55_0:Find("Icon"), {
		type = arg_55_1:GetProduction()[1],
		id = arg_55_1:GetProduction()[2]
	})
	setText(var_55_0:Find("Name"), arg_55_1:GetName())
	setText(var_55_0:Find("Description/Text"), arg_55_1:GetDesc())

	local var_55_1 = tostring(arg_55_1:GetMaxLimit() - arg_55_1:GetUsedCount())

	setText(var_55_0:Find("RestCount/Text"), i18n("ryza_rest_produce_count", (arg_55_1:GetMaxLimit() < 0 or nil) and "∞"))
	setActive(self.layerMaterialSelect, false)

	local var_55_2 = self.layerFormulaDetail:Find("ScrollView/Content")

	setAnchoredPosition(var_55_2, Vector2.zero)
	_.each(arg_55_1:GetCircleList(), function(arg_56_0)
		local var_56_0 = AtelierFormulaCircle.New({
			configId = arg_56_0
		})
		local var_56_1 = self.nodePools[var_0_7[var_56_0:GetType()]]:Dequeue()

		var_56_1.name = arg_56_0

		setActive(var_56_1, true)
		setParent(tf(var_56_1), var_55_2)
		table.insert(self.nodeList, {
			Change = true,
			Data = var_56_0,
			GO = var_56_1
		})

		return
	end)

	local var_55_3 = 280 * Vector2.New(math.cos(math.deg2Rad * 30), math.sin(math.deg2Rad * 30))
	local var_55_4 = 280 * Vector2(0, 1)
	local var_55_5 = Vector2.zero

	local function var_55_6(arg_57_0, arg_57_1)
		setAnchoredPosition(arg_57_0.GO, arg_57_1)

		arg_57_0.links = {}

		_.each(arg_57_0.Data:GetNeighbors(), function(arg_58_0)
			local var_58_0 = arg_58_0[2]
			local var_58_1 = var_0_8[arg_58_0[1]][1] * var_55_3 + var_0_8[arg_58_0[1]][2] * var_55_4
			local var_58_2 = _.detect(self.nodeList, function(arg_59_0)
				return arg_59_0.Data:GetConfigID() == var_58_0
			end)

			var_58_2.prevLink = {
				(arg_58_0[1] + 2) % 5 + 1,
				arg_57_0
			}
			arg_57_0.links[arg_58_0[1]] = var_58_2

			var_55_6(var_58_2, arg_57_1 + var_58_1)

			var_55_5 = Vector2.Max(var_55_5, -(arg_57_1 + var_58_1))
			var_55_5 = Vector2.Max(var_55_5, arg_57_1 + var_58_1)

			return
		end)

		return
	end

	var_55_6(self.nodeList[1], Vector2.zero)
	setSizeDelta(var_55_2, (Vector2.zero + Vector2.New(280, 280)) * 2)
	onButton(self, self.layerFormulaDetail:Find("Composite"), function()
		if not _.all(self.nodeList, function(arg_61_0)
			return arg_61_0.Instance
		end) then
			self:ShowMaterialsPreview()

			return
		end

		if not self.activity:GetFormulas()[self.contextData.formulaId]:IsAvaliable() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

			return
		end

		self:ShowCompositeConfirmWindow()

		return
	end, SFX_PANEL)
	onButton(self, self.layerFormulaDetail:Find("AutoFill"), function()
		local var_62_0 = {}
		local var_62_1 = self.activity:GetItems()

		local function var_62_2(arg_63_0)
			local var_63_0 = var_62_0[arg_63_0:GetConfigID()] or Clone(var_62_1[arg_63_0:GetConfigID()])

			assert(var_63_0, "Using Unexist material")

			var_63_0.count = var_63_0.count - 1
			var_62_0[arg_63_0:GetConfigID()] = var_63_0

			return
		end

		local var_62_3 = {}

		_.each(self.nodeList, function(arg_64_0)
			if arg_64_0.Instance then
				var_62_2(arg_64_0.Instance)
			else
				table.insert(var_62_3, arg_64_0)
			end

			return
		end)

		if #var_62_3 <= 0 then
			return
		end

		local var_62_4 = true

		local function var_62_5()
			if not var_62_4 then
				return
			end

			self:DispalyChat({
				"ryza_atellier5",
				"ryza_atellier6",
				"ryza_atellier7"
			})

			var_62_4 = false

			return
		end

		local var_62_6 = false
		local var_62_7

		local function var_62_8()
			if var_62_7 and coroutine.status(var_62_7) == "suspended" then
				local var_66_0, var_66_1 = coroutine.resume(var_62_7)

				assert(var_66_0, debug.traceback(var_62_7, var_66_1))
			end

			return
		end

		var_62_7 = coroutine.create(function()
			_.each(var_62_3, function(arg_68_0)
				if arg_68_0.Data:GetType() == AtelierFormulaCircle.TYPE.BASE or arg_68_0.Data:GetType() == AtelierFormulaCircle.TYPE.SAIREN then
					local var_68_0 = arg_68_0.Data:GetLimitItemID()
					local var_68_1 = var_62_0[var_68_0] or var_62_1[var_68_0]

					if var_68_1 and var_68_1.count > 0 then
						var_62_2(var_68_1)
						var_62_5()
						self:FillNodeAndPlayAnim(arg_68_0, AtelierMaterial.New({
							count = 1,
							configId = var_68_0
						}), var_62_8, true)
						coroutine.yield()
					else
						var_62_6 = true
					end
				end

				return
			end)

			if not var_62_6 then
				local var_67_0 = false
				local var_67_1 = false

				self:DisPlayUnlockEffect(function()
					var_67_0 = true

					if var_67_1 then
						var_62_8()
					end

					return
				end)

				if not false then
					var_67_1 = true

					coroutine.yield()
				end

				local var_67_2 = true

				local function var_67_3()
					if not var_67_2 then
						return
					end

					pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_5")

					var_67_2 = false

					return
				end

				local var_67_4 = AtelierMaterial.bindConfigTable()

				local function var_67_5(arg_71_0)
					for iter_71_0, iter_71_1 in ipairs(var_67_4.all) do
						local var_71_0 = var_62_0[iter_71_1] or var_62_1[iter_71_1]

						if var_71_0 and var_71_0.count > 0 and var_71_0:IsNormal() and arg_71_0.Data:CanUseMaterial(var_71_0, arg_55_1) then
							var_62_2(var_71_0)
							var_62_5()
							var_67_3()
							self:FillNodeAndPlayAnim(arg_71_0, AtelierMaterial.New({
								count = 1,
								configId = var_71_0:GetConfigID()
							}), true)

							return
						end
					end

					var_62_6 = true

					return
				end

				_.each(var_62_3, function(arg_72_0)
					if arg_72_0.Data:GetType() == AtelierFormulaCircle.TYPE.NORMAL then
						var_67_5(arg_72_0)
					end

					return
				end)
				_.each(var_62_3, function(arg_73_0)
					if arg_73_0.Data:GetType() == AtelierFormulaCircle.TYPE.ANY then
						var_67_5(arg_73_0)
					end

					return
				end)
			end

			if var_62_6 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_material_not_enough"))
			end

			self:UpdateFormulaDetail()

			return
		end)

		var_62_8()

		return
	end, SFX_PANEL)
	self:UpdateFormulaDetail()

	return
end

function AtelierCompositeScene:CleanNodeInstance()
	local var_74_0 = self.activity:GetFormulas()[self.contextData.formulaId]

	if not var_74_0:IsAvaliable() then
		self:HideFormulaDetail()

		self.contextData.formulaId = nil

		self:ShowFormulaList()

		return
	end

	_.each(self.nodeList, function(arg_75_0)
		arg_75_0.Instance = nil
		arg_75_0.Change = true

		return
	end)
	self:ShowFormulaDetail(var_74_0)

	return
end

function AtelierCompositeScene:UpdateFormulaDetail()
	local var_76_0 = 0
	local var_76_1 = 0

	self.unlockAllBase = true

	_.each(self.nodeList, function(arg_77_0)
		var_76_0 = var_76_0 + 1
		var_76_1 = var_76_1 + (arg_77_0.Instance and 1 or 0)
		self.unlockAllBase = self.unlockAllBase and (arg_77_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.BASE and arg_77_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.SAIREN or arg_77_0.Instance)

		return
	end)
	_.each(self.nodeList, function(arg_78_0)
		local var_78_0 = not self.unlockAllBase and arg_78_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.BASE and arg_78_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.SAIREN
		local var_78_1 = arg_78_0.ChangeLock

		if not arg_78_0.ChangeLock then
			var_78_1 = tobool(arg_78_0.Lock)
			var_78_1 = var_78_1 and not var_78_0
		end

		arg_78_0.ChangeLock = var_78_1
		arg_78_0.Lock = var_78_0

		return
	end)

	local var_76_2 = self.unlockAllBase ~= tobool(self.unlockAllBase)

	_.each(self.nodeList, function(arg_79_0)
		if var_76_2 then
			arg_79_0.Change = true
		end

		self:UpdateNodeView(arg_79_0)

		return
	end)
	setText(self.layerFormulaDetail:Find("Bar/Text"), i18n("ryza_tip_put_materials", var_76_1, 0))
	setGray(self.layerFormulaDetail:Find("AutoFill"), not self.activity:GetFormulas()[self.contextData.formulaId]:IsAvaliable())
	setActive(self.layerFormulaDetail:Find("Composite/Disabled"), var_76_1 < 0)

	return
end

local var_0_10 = {
	[AtelierFormulaCircle.ELEMENT_TYPE.PYRO] = "laisha_ui_huo",
	[AtelierFormulaCircle.ELEMENT_TYPE.CRYO] = "laisha_ui_bing",
	[AtelierFormulaCircle.ELEMENT_TYPE.ELECTRO] = "laisha_ui_lei",
	[AtelierFormulaCircle.ELEMENT_TYPE.ANEMO] = "laisha_ui_feng",
	[AtelierFormulaCircle.ELEMENT_TYPE.SAIREN] = "laisha_ui_sairen"
}
local var_0_11 = "laisha_ui_wupinshanguang"
local var_0_12 = "laisha_ui_jiesuo"
local var_0_13 = {
	"laisha_ui_lianjie01",
	"laisha_ui_lianjie02",
	"laisha_ui_lianjie_qiehuan"
}

function AtelierCompositeScene:UpdateNodeView(arg_80_1)
	local var_80_0 = tf(arg_80_1.GO)

	for iter_80_0 = 1, 6 do
		setActive(var_80_0:Find("Links"):GetChild(iter_80_0 - 1), false)
	end

	local var_80_1 = arg_80_1.Data

	_.each(arg_80_1.Data:GetNeighbors(), function(arg_81_0)
		setActive(var_80_0:Find("Links"):GetChild(arg_81_0[1] - 1), true)

		return
	end)

	local var_80_2 = var_80_1:GetElementName()
	local var_80_3 = arg_80_1.Lock

	setActive(var_80_0:Find("Lock"), arg_80_1.Lock)

	if var_80_3 then
		if var_80_1:GetType() ~= AtelierFormulaCircle.TYPE.ANY then
			self.loader:GetSpriteQuiet(var_0_5, "element_" .. var_80_2, var_80_0:Find("Lock/Require/Icon"))
		end

		setText(var_80_0:Find("Lock/Require/Text"), "X" .. var_80_1:GetLevel())
	end

	for iter_80_1 = 3, var_80_1:GetLevel() + 1, -1 do
		self.loader:GetSpriteQuiet(var_0_4, "slot_BLOCKED", var_80_0:Find("Slots"):GetChild(iter_80_1 - 1):Find("Image"))
	end

	local var_80_4 = arg_80_1.Instance

	if not arg_80_1.Instance then
		if var_80_1:GetType() == AtelierFormulaCircle.TYPE.ANY then
			setActive(var_80_0:Find("All"), true)
		else
			setActive(var_80_0:Find("Icon"), true)
			self.loader:GetSpriteQuiet(var_0_4, "icon_" .. var_80_2, var_80_0:Find("Icon"), true)
		end

		setActive(var_80_0:Find("Item"), false)

		if var_80_1:GetType() == AtelierFormulaCircle.TYPE.BASE or var_80_1:GetType() == AtelierFormulaCircle.TYPE.SAIREN then
			local var_80_5 = AtelierMaterial.New({
				configId = var_80_1:GetLimitItemID()
			})

			setActive(var_80_0:Find("Name"), true)
			setScrollText(var_80_0:Find("Name/Rect/Text"), var_80_5:GetName())
		else
			setActive(var_80_0:Find("Name"), false)
		end

		for iter_80_2 = 1, var_80_1:GetLevel() do
			self.loader:GetSpriteQuiet(var_0_4, "slot_NULL", var_80_0:Find("Slots"):GetChild(iter_80_2 - 1):Find("Image"))
		end
	else
		local var_80_6 = AtelierFormulaCircle.ELEMENT_NAME[var_80_1:GetRingElement(var_80_4)]

		if var_80_1:GetType() == AtelierFormulaCircle.TYPE.ANY then
			setActive(var_80_0:Find("All"), false)
		else
			setActive(var_80_0:Find("Icon"), false)
		end

		setActive(var_80_0:Find("Item"), true)

		local var_80_7 = (var_80_1:GetType() == AtelierFormulaCircle.TYPE.BASE or var_80_1:GetType() == AtelierFormulaCircle.TYPE.SAIREN) and var_80_4:GetBaseCircleTransform() or var_80_4:GetNormalCircleTransform()

		setLocalScale(var_80_0:Find("Item"), Vector3.New(unpack(var_80_7, 1, 3)))
		setAnchoredPosition(var_80_0:Find("Item"), Vector2.New(unpack(var_80_7, 4, 5)))
		self.loader:GetSpriteQuiet(var_80_4:GetIconPath(), "", var_80_0:Find("Item"), true)
		setActive(var_80_0:Find("Name"), true)
		setScrollText(var_80_0:Find("Name/Rect/Text"), var_80_4:GetName())

		for iter_80_3 = 1, var_80_1:GetLevel() do
			self.loader:GetSpriteQuiet(var_0_4, "slot_" .. var_80_6, var_80_0:Find("Slots"):GetChild(iter_80_3 - 1):Find("Image"))
		end
	end

	local var_80_8 = var_80_0:Find("Ring")

	setImageColor(var_80_8, var_80_1:GetElementRingColor(var_80_4))

	if arg_80_1.Change then
		local var_80_9 = arg_80_1.Data:GetRingElement(var_80_4)

		if var_80_3 then
			var_80_9 = nil
		end

		if var_0_10[var_80_9] then
			self.loader:GetPrefab("ui/" .. var_0_10[var_80_9] .. (arg_80_1.Data:GetType() == AtelierFormulaCircle.TYPE.BASE and "_o" or "_6"), "", function(arg_82_0)
				setParent(arg_82_0, var_80_8)
				setAnchoredPosition(arg_82_0, Vector2.zero)

				return
			end, var_80_8)
		else
			self.loader:ClearRequest(var_80_8)
		end

		table.Foreach(arg_80_1.links, function(arg_83_0, arg_83_1)
			local var_83_0 = var_80_0:Find("Links/" .. arg_83_0)
			local var_83_1 = var_0_13[3]

			if arg_83_1.Lock and var_80_3 then
				var_83_1 = var_0_13[1]
			elseif not arg_83_1.Lock and not var_80_3 then
				var_83_1 = var_0_13[2]
			end

			self.loader:GetPrefab("ui/" .. var_83_1, "", function(arg_84_0)
				setParent(arg_84_0, var_83_0:Find("Link"))
				setAnchoredPosition(arg_84_0, Vector2.New(0, -15))

				return
			end, var_83_0)

			return
		end)

		arg_80_1.Change = nil
	end

	if arg_80_1.ChangeInstance then
		local var_80_10 = var_80_0:Find("Item")

		if var_80_4 then
			self.loader:GetPrefab("ui/" .. var_0_11, "", function(arg_85_0)
				setParent(arg_85_0, var_80_10)
				setAnchoredPosition(arg_85_0, Vector2.zero)

				return
			end, var_80_0)
		else
			self.loader:ClearRequest(var_80_0)
		end

		arg_80_1.ChangeInstance = nil
	end

	onButton(self, var_80_0, function()
		if var_80_3 then
			return
		end

		local var_86_0 = self.layerMaterialSelect:Find("TargetBG")

		var_86_0.localRotation = Quaternion.identity

		local var_86_1 = var_80_1:GetType() == AtelierFormulaCircle.TYPE.BASE and 300 or 245

		setSizeDelta(var_86_0, {
			x = var_86_1,
			y = var_86_1
		})

		local var_86_2 = self.layerMaterialSelect:Find("Target")

		self:ShowCandicatePanel()

		local var_86_3 = tf(Instantiate(var_80_0))

		SetCompomentEnabled(var_86_3, typeof(Button), false)
		setParent(var_86_3, var_86_2)
		setAnchoredPosition(var_86_3, Vector2.zero)

		for iter_86_0 = 1, 6 do
			setActive(var_86_3:Find("Links"):GetChild(iter_86_0 - 1), false)
		end

		setAnchoredPosition(self.layerFormulaDetail:Find("ScrollView/Content"), var_86_2.anchoredPosition - (var_80_0.anchoredPosition + self.layerFormulaDetail:Find("ScrollView").anchoredPosition))

		self.candicateTarget = arg_80_1

		GetComponent(var_86_0, typeof(Animator)):SetBool("Selecting", true)
		self:UpdateCandicatePanel()

		return
	end, SFX_PANEL)

	return
end

function AtelierCompositeScene:FillNodeAndPlayAnim(arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	self:LoadingOn()

	arg_87_1.ChangeInstance = arg_87_1.ChangeInstance or tobool(arg_87_1.Instance) ~= tobool(arg_87_2)
	arg_87_1.Instance = arg_87_2
	arg_87_1.Change = true

	local var_87_0 = {}
	local var_87_1 = {}

	seriesAsync({
		function(arg_88_0)
			table.ParallelIpairsAsync({
				"ui/laisha_ui_wupinzhiru",
				"ui/laisha_ui_baoshi"
			}, function(arg_89_0, arg_89_1, arg_89_2)
				var_87_0[arg_89_0] = self.loader:GetPrefab(arg_89_1, "", function(arg_90_0)
					setParent(arg_90_0, tf(arg_87_1.GO))
					setAnchoredPosition(arg_90_0, Vector2.zero)

					var_87_1[arg_89_0] = arg_90_0

					setActive(arg_90_0, false)
					arg_89_2()

					return
				end)

				return
			end, arg_88_0)

			return
		end,
		function(arg_91_0)
			setActive(var_87_1[1], true)
			self:managedTween(LeanTween.delayedCall, function()
				if not arg_87_4 then
					self:UpdateFormulaDetail()
				else
					self:UpdateNodeView(arg_87_1)
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_4")
				arg_91_0()

				return
			end, 0.2, nil)

			return
		end,
		function(arg_93_0)
			setActive(var_87_1[2], true)
			self:managedTween(LeanTween.delayedCall, function()
				arg_93_0()

				return
			end, 0.5, nil)

			return
		end,
		function(arg_95_0)
			self.loader:ClearRequest(var_87_0[1])
			self.loader:ClearRequest(var_87_0[2])
			self:LoadingOff()
			existCall(arg_87_3)

			return
		end
	})

	return
end

function AtelierCompositeScene:DisPlayUnlockEffect(arg_96_1)
	self.unlockAllBase = true

	_.each(self.nodeList, function(arg_97_0)
		self.unlockAllBase = self.unlockAllBase and (arg_97_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.BASE and arg_97_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.SAIREN or arg_97_0.Instance)

		return
	end)
	_.each(self.nodeList, function(arg_98_0)
		local var_98_0 = not self.unlockAllBase and arg_98_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.BASE and arg_98_0.Data:GetType() ~= AtelierFormulaCircle.TYPE.SAIREN
		local var_98_1 = arg_98_0.ChangeLock

		if not arg_98_0.ChangeLock then
			var_98_1 = tobool(arg_98_0.Lock)
			var_98_1 = var_98_1 and not var_98_0
		end

		arg_98_0.ChangeLock = var_98_1
		arg_98_0.Lock = var_98_0

		return
	end)

	if not _.any(self.nodeList, function(arg_99_0)
		return arg_99_0.ChangeLock
	end) then
		existCall(arg_96_1)

		return
	end

	self:LoadingOn()

	local var_96_0 = {}

	_.each(self.nodeList, function(arg_100_0)
		local var_100_0 = tf(arg_100_0.GO)

		if arg_100_0.ChangeLock then
			if arg_100_0.prevLink then
				arg_100_0.prevLink[2].Change = true
			end

			table.insert(var_96_0, (self.loader:GetPrefab("ui/" .. var_0_12, "", function(arg_101_0)
				setParent(arg_101_0, var_100_0)
				setAnchoredPosition(arg_101_0, Vector2.zero)

				return
			end)))

			arg_100_0.ChangeLock = nil
		end

		return
	end)
	self:managedTween(LeanTween.delayedCall, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_3")

		return
	end, 0.7, nil)
	self:managedTween(LeanTween.delayedCall, function()
		_.each(var_96_0, function(arg_104_0)
			self.loader:ClearRequest(arg_104_0)

			return
		end)
		self:LoadingOff()
		existCall(arg_96_1)

		return
	end, 1.7, nil)

	return
end

function AtelierCompositeScene:ShowCandicatePanel()
	self:DispalyChat({
		"ryza_atellier2",
		"ryza_atellier3",
		"ryza_atellier4"
	})
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_1")
	pg.UIMgr.GetInstance():BlurPanel(self.top)
	setActive(self.layerMaterialSelect, true)
	SetCompomentEnabled(self.layerFormulaDetail:Find("ScrollView"), typeof(ScrollRect), false)
	removeAllChildren(self.layerMaterialSelect:Find("Target"))

	return
end

function AtelierCompositeScene:CloseCandicatePanel()
	self:LoadingOn()

	local var_106_0 = GetComponent(self.layerMaterialSelect:Find("TargetBG"), typeof(DftAniEvent))

	var_106_0:SetEndEvent(function()
		self:LoadingOff()
		self:HideCandicatePanel()
		var_106_0:SetEndEvent(nil)

		return
	end)
	GetComponent(self.layerMaterialSelect:Find("TargetBG"), typeof(Animator)):SetBool("Selecting", false)

	return
end

function AtelierCompositeScene:HideCandicatePanel()
	if not isActive(self.layerMaterialSelect) then
		return
	end

	pg.UIMgr.GetInstance():OverlayPanel(self.top)
	self.painting:SetSiblingIndex(1)
	setActive(self.layerMaterialSelect, false)
	removeAllChildren(self.layerMaterialSelect:Find("Target"))
	SetCompomentEnabled(self.layerFormulaDetail:Find("ScrollView"), typeof(ScrollRect), true)

	self.candicateTarget = nil

	return true
end

function AtelierCompositeScene:UpdateCandicatePanel()
	self.candicates = {}

	local var_109_0 = self.activity:GetItems()
	local var_109_1 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_109_2 = _.map(AtelierMaterial.bindConfigTable().all, function(arg_110_0)
		local var_110_0 = var_109_0[arg_110_0] or AtelierMaterial.New({
			configId = arg_110_0
		})

		if self.candicateTarget.Data:CanUseMaterial(var_110_0, var_109_1) then
			if var_109_0[arg_110_0] then
				var_110_0 = AtelierMaterial.New({
					configId = arg_110_0,
					count = var_109_0[arg_110_0].count
				})
				var_110_0.count = _.reduce(self.nodeList, var_110_0.count, function(arg_111_0, arg_111_1)
					if arg_111_1.Instance and arg_111_1.Instance:GetConfigID() == arg_110_0 then
						arg_111_0 = arg_111_0 - 1
					end

					return arg_111_0
				end)
			end

			return var_110_0
		end

		return
	end)

	table.sort(var_109_2, function(arg_112_0, arg_112_1)
		if arg_112_0.count * arg_112_1.count == 0 and arg_112_0.count - arg_112_1.count ~= 0 then
			return arg_112_0.count < arg_112_1.count
		else
			return arg_112_0:GetConfigID() < arg_112_1:GetConfigID()
		end

		return
	end)
	_.each(var_109_2, function(arg_113_0)
		for iter_113_0 = 1, math.max(arg_113_0.count, 1) do
			table.insert(self.candicates, arg_113_0)
		end

		return
	end)
	self.candicatesRect:SetTotalCount(#self.candicates, 0)

	return
end

function AtelierCompositeScene:UpdateCandicateItem(arg_114_1, arg_114_2)
	local var_114_0 = tf(arg_114_2)
	local var_114_1 = self.candicates[arg_114_1]

	self:UpdateRyzaItem(var_114_0:Find("IconBG"), self.candicates[arg_114_1], true)

	local var_114_2 = var_114_1.count <= 0

	setActive(var_114_0:Find("IconBG/Lack"), var_114_1.count <= 0)
	onButton(self, var_114_0, function()
		if var_114_2 then
			var_114_1 = CreateShell(var_114_1)
			var_114_1.count = false

			self:ShowItemDetail(var_114_1)
		else
			self:DispalyChat({
				"ryza_atellier5",
				"ryza_atellier6",
				"ryza_atellier7"
			})
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_2")

			local var_115_0 = self.candicateTarget

			self:HideCandicatePanel()
			seriesAsync({
				function(arg_116_0)
					self:FillNodeAndPlayAnim(var_115_0, AtelierMaterial.New({
						count = 1,
						configId = var_114_1:GetConfigID()
					}), arg_116_0, true)

					return
				end,
				function(arg_117_0)
					self:DisPlayUnlockEffect(arg_117_0)

					return
				end,
				function(arg_118_0)
					self:UpdateFormulaDetail()

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	return
end

function AtelierCompositeScene:UpdateRyzaItem(arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = "icon_frame_" .. arg_119_2:GetRarity()

	if arg_119_3 then
		var_119_0 = var_119_0 .. "_small"
	end

	self.loader:GetSpriteQuiet(var_0_5, var_119_0, arg_119_1)
	self.loader:GetSpriteQuiet(arg_119_2:GetIconPath(), "", arg_119_1:Find("Icon"))

	if not IsNil(arg_119_1:Find("Lv")) then
		setText(arg_119_1:Find("Lv/Text"), arg_119_2:GetLevel())
	end

	local var_119_1 = arg_119_2:GetProps()

	for iter_119_0, iter_119_1 in ipairs((CustomIndexLayer.Clone2Full(arg_119_1:Find("List"), #var_119_1))) do
		self.loader:GetSpriteQuiet(var_0_5, "element_" .. AtelierFormulaCircle.ELEMENT_NAME[var_119_1[iter_119_0]], iter_119_1)
	end

	if not IsNil(arg_119_1:Find("Text")) then
		setText(arg_119_1:Find("Text"), arg_119_2.count)
	end

	return
end

function AtelierCompositeScene:ShowItemDetail(arg_120_1)
	self:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_120_1)

	return
end

local var_0_14 = 41
local var_0_15 = 5

function AtelierCompositeScene:ShowCompositeConfirmWindow()
	setActive(self.layerCompositeConfirm, true)
	pg.UIMgr.GetInstance():BlurPanel(self.layerCompositeConfirm)

	local var_121_0 = 1
	local var_121_1 = {}
	local var_121_2 = {}

	_.each(self.nodeList, function(arg_122_0)
		local var_122_0 = arg_122_0.Instance:GetConfigID()

		table.insert(var_121_1, {
			key = arg_122_0.Data:GetConfigID(),
			value = var_122_0
		})

		var_121_2[var_122_0] = (var_121_2[var_122_0] or 0) + 1

		return
	end)
	onButton(self, self.layerCompositeConfirm:Find("Window/Confirm"), function()
		self:emit(GAME.COMPOSITE_ATELIER_RECIPE, var_121_1, var_121_0)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ryza_atellier_ui_6")

		return
	end, SFX_PANEL)

	local var_121_3 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_121_4 = var_121_3:GetMaxLimit() ~= 1
	local var_121_5 = var_121_3:GetMaxLimit() > 0 and var_121_3:GetMaxLimit() - var_121_3:GetUsedCount() or 10000
	local var_121_6 = self.activity:GetItems()

	for iter_121_0, iter_121_1 in pairs(var_121_2) do
		var_121_5 = math.min(var_121_5, math.floor(((var_121_6[iter_121_0] or nil) and (var_121_6[iter_121_0].count or 0)) / iter_121_1))
	end

	local var_121_7 = {
		1,
		var_121_4 and var_121_5 or 1
	}
	local var_121_8 = Drop.New({
		type = var_121_3:GetProduction()[1],
		id = var_121_3:GetProduction()[2]
	})

	self:UpdateRyzaDrop(self.layerCompositeConfirm:Find("Window/Icon"), var_121_8)

	local var_121_9 = self.layerCompositeConfirm:Find("Window/Counters")
	local var_121_10 = var_121_8:getConfig("name")

	setActive(var_121_9, var_121_4)

	if var_121_4 then
		setAnchoredPosition(self.layerCompositeConfirm:Find("Window/Icon"), {
			y = var_0_14
		})

		local function var_121_11()
			setText(var_121_9:Find("Number"), var_121_0)
			setText(self.layerCompositeConfirm:Find("Window/Text"), i18n("ryza_composite_confirm", var_121_10, var_121_0))

			return
		end

		var_121_11()
		onButton(self, var_121_9:Find("Plus"), function()
			var_121_0 = var_121_0 + 1
			var_121_0 = math.clamp(var_121_0, var_121_7[1], var_121_7[2])

			if var_121_0 == var_121_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_max_composite_count"))

				return
			end

			var_121_11()

			return
		end)
		onButton(self, var_121_9:Find("Minus"), function()
			var_121_0 = var_121_0 - 1
			var_121_0 = math.clamp(var_121_0, var_121_7[1], var_121_7[2])

			var_121_11()

			return
		end)
		onButton(self, var_121_9:Find("Plus10"), function()
			var_121_0 = var_121_0 + 10
			var_121_0 = math.clamp(var_121_0, var_121_7[1], var_121_7[2])

			if var_121_0 == var_121_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_max_composite_count"))

				return
			end

			var_121_11()

			return
		end)
		onButton(self, var_121_9:Find("Minus10"), function()
			var_121_0 = var_121_0 - 10
			var_121_0 = math.clamp(var_121_0, var_121_7[1], var_121_7[2])

			var_121_11()

			return
		end)
	else
		setAnchoredPosition(self.layerCompositeConfirm:Find("Window/Icon"), {
			y = var_0_15
		})
		setText(self.layerCompositeConfirm:Find("Window/Text"), i18n("ryza_composite_confirm_single", var_121_10, var_121_0))
	end

	return
end

function AtelierCompositeScene:HideCompositeConfirmWindow()
	if not isActive(self.layerCompositeConfirm) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self.layerCompositeConfirm, self._tf)
	setActive(self.layerCompositeConfirm, false)

	return true
end

local var_0_16 = "laisha_lianjin"

function AtelierCompositeScene:OnCompositeResult(arg_130_1)
	self:LoadingOn()
	self:DispalyChat({
		"ryza_atellier8",
		"ryza_atellier9"
	})

	local var_130_0 = 1.5
	local var_130_1 = 0.5

	self.loader:GetPrefab("ui/" .. var_0_16, "", function(arg_131_0)
		pg.UIMgr.GetInstance():OverlayPanel(tf(arg_131_0))
		setAnchoredPosition(arg_131_0, Vector2.zero)
		self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self._tf, typeof(CanvasGroup)), 0, var_130_0):setFrom(1)
		self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self.top, typeof(CanvasGroup)), 0, var_130_0):setFrom(1)
		self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self.layerCompositeConfirm, typeof(CanvasGroup)), 0, var_130_0):setFrom(1)
		self:managedTween(LeanTween.delayedCall, function()
			self:HideCompositeConfirmWindow()
			setCanvasGroupAlpha(self.layerCompositeConfirm, 1)
			self:CleanNodeInstance()
			self:ShowCompositeResult(arg_130_1)
			self:DispalyChat({
				"ryza_atellier10",
				"ryza_atellier11"
			})
			self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self._tf, typeof(CanvasGroup)), 1, var_130_1):setFrom(0)
			self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self.top, typeof(CanvasGroup)), 1, var_130_1):setFrom(0)
			self:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(self.layerCompositeResult, typeof(CanvasGroup)), 1, var_130_1):setFrom(0)
			self:managedTween(LeanTween.delayedCall, function()
				self:LoadingOff()
				pg.UIMgr.GetInstance():UnOverlayPanel(tf(arg_131_0), self._tf)
				self.loader:ClearRequest("CompositeResult")

				return
			end, go(self.layerCompositeResult), var_130_1, nil)

			return
		end, go(self.layerCompositeResult), var_130_0, nil)

		return
	end, "CompositeResult")

	return
end

function AtelierCompositeScene:ShowCompositeResult(arg_134_1)
	setActive(self.layerCompositeResult, true)
	pg.UIMgr.GetInstance():BlurPanel(self.layerCompositeResult)

	if arg_134_1[1] == nil then
		return
	end

	self:UpdateRyzaDrop(self.layerCompositeResult:Find("Window/Icon"), arg_134_1[1])
	setScrollText(self.layerCompositeResult:Find("Window/NameBG/Rect/Name"), arg_134_1[1]:getName())
	setText(self.layerCompositeResult:Find("Window/CountBG/Text"), arg_134_1[1].count)

	return
end

function AtelierCompositeScene:HideCompositeResult()
	if not isActive(self.layerCompositeResult) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self.layerCompositeResult, self._tf)
	setActive(self.layerCompositeResult, false)

	if pg.NewStoryMgr.GetInstance():IsPlayed("NG0032") then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0033", {
			2
		})
	end

	return true
end

function AtelierCompositeScene:ShowStoreHouseWindow()
	setActive(self.layerStoreHouse, true)
	pg.UIMgr.GetInstance():BlurPanel(self.layerStoreHouse)

	local var_136_0 = _.filter(_.values(self.activity:GetItems()), function(arg_137_0)
		return arg_137_0.count > 0
	end)

	table.sort(var_136_0, function(arg_138_0, arg_138_1)
		return arg_138_0:GetConfigID() < arg_138_1:GetConfigID()
	end)
	setActive(self.layerStoreHouse:Find("Window/Empty"), #var_136_0 == 0)
	setActive(self.layerStoreHouse:Find("Window/ScrollView"), #var_136_0 > 0)

	if #var_136_0 == 0 then
		return
	end

	function self.storehouseRect.onUpdateItem(arg_139_0, arg_139_1)
		arg_139_0 = arg_139_0 + 1

		local var_139_0 = tf(arg_139_1)
		local var_139_1 = var_136_0[arg_139_0]

		self:UpdateRyzaItem(var_139_0:Find("IconBG"), var_136_0[arg_139_0])
		setScrollText(var_139_0:Find("NameBG/Rect/Name"), var_136_0[arg_139_0]:GetName())
		onButton(self, var_139_0, function()
			self:ShowItemDetail(var_139_1)

			return
		end, SFX_PANEL)

		return
	end

	self.storehouseRect:SetTotalCount(#var_136_0)

	return
end

function AtelierCompositeScene:CloseStoreHouseWindow()
	self.contextData.showStoreHouse = nil

	return self:HideStoreHouseWindow()
end

function AtelierCompositeScene:HideStoreHouseWindow()
	if not isActive(self.layerStoreHouse) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self.layerStoreHouse, self._tf)
	setActive(self.layerStoreHouse, false)

	return true
end

function AtelierCompositeScene:ShowMaterialsPreview()
	setActive(self.layerMaterialsPreview, true)
	pg.UIMgr.GetInstance():BlurPanel(self.layerMaterialsPreview)

	local var_143_0 = self.activity:GetItems()
	local var_143_1 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_143_2 = AtelierMaterial.bindConfigTable()
	local var_143_3 = {}
	local var_143_4 = {}
	local var_143_5 = {}

	local function var_143_6(arg_144_0)
		local var_144_0 = var_143_5[arg_144_0:GetConfigID()] or Clone(var_143_0[arg_144_0:GetConfigID()])

		assert(var_144_0, "Using Unexist material")

		var_144_0.count = var_144_0.count - 1
		var_143_5[arg_144_0:GetConfigID()] = var_144_0

		return
	end

	_.each(self.nodeList, function(arg_145_0)
		if arg_145_0.Data:GetType() == AtelierFormulaCircle.TYPE.BASE or arg_145_0.Data:GetType() == AtelierFormulaCircle.TYPE.SAIREN then
			local var_145_0 = arg_145_0.Data:GetLimitItemID()
			local var_145_1 = var_143_5[var_145_0] or var_143_0[var_145_0]

			if var_145_1 and var_145_1.count > 0 then
				local var_145_2 = AtelierMaterial.New({
					configId = var_145_0
				})

				var_145_2.count = false

				table.insert(var_143_3, var_145_2)
				var_143_6(var_145_1)
			else
				local var_145_3 = AtelierMaterial.New({
					configId = var_145_0
				})

				var_145_3.count = false

				table.insert(var_143_4, var_145_3)
			end
		end

		return
	end)

	local function var_143_7(arg_146_0)
		if arg_146_0.Instance then
			local var_146_0 = AtelierMaterial.New({
				configId = arg_146_0.Instance:GetConfigID()
			})

			var_146_0.count = false

			table.insert(var_143_3, var_146_0)
			var_143_6(arg_146_0.Instance)

			return
		end

		local var_146_1 = arg_146_0.Data
		local var_146_2

		for iter_146_0, iter_146_1 in ipairs(var_143_2.all) do
			local var_146_3 = var_143_5[iter_146_1] or var_143_0[iter_146_1] or AtelierMaterial.New({
				configId = iter_146_1
			})

			if var_146_3:IsNormal() and var_146_1:CanUseMaterial(var_146_3, var_143_1) then
				var_146_2 = var_146_2 or iter_146_1

				if var_146_3.count > 0 then
					local var_146_4 = AtelierMaterial.New({
						configId = iter_146_1
					})

					var_146_4.count = false

					table.insert(var_143_3, var_146_4)
					var_143_6(var_146_3)

					return
				end
			end
		end

		local var_146_5 = AtelierMaterial.New({
			configId = var_146_2
		})

		var_146_5.count = false

		table.insert(var_143_4, var_146_5)

		return
	end

	_.each(self.nodeList, function(arg_147_0)
		if arg_147_0.Data:GetType() == AtelierFormulaCircle.TYPE.NORMAL then
			var_143_7(arg_147_0)
		end

		return
	end)
	_.each(self.nodeList, function(arg_148_0)
		if arg_148_0.Data:GetType() == AtelierFormulaCircle.TYPE.ANY then
			var_143_7(arg_148_0)
		end

		return
	end)

	local function var_143_8(arg_149_0, arg_149_1)
		return arg_149_0:GetConfigID() < arg_149_1:GetConfigID()
	end

	table.sort(var_143_3, var_143_8)
	table.sort(var_143_4, var_143_8)
	;(function()
		local var_150_0 = self.layerMaterialsPreview:Find("Frame/Scroll/Content/Owned/List")

		setActive(var_150_0.parent, #var_143_3 > 0)

		if #var_143_3 == 0 then
			return
		end

		table.Foreach(CustomIndexLayer.Clone2Full(var_150_0, #var_143_3), function(arg_151_0, arg_151_1)
			local var_151_0 = var_143_3[arg_151_0]

			self:UpdateRyzaItem(arg_151_1:Find("IconBG"), var_143_3[arg_151_0], true)
			onButton(self, arg_151_1, function()
				self:ShowItemDetail(var_151_0)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end)()
	;(function()
		local var_153_0 = self.layerMaterialsPreview:Find("Frame/Scroll/Content/Lack/List")

		setActive(var_153_0.parent, #var_143_4 > 0)

		if #var_143_4 == 0 then
			return
		end

		table.Foreach(CustomIndexLayer.Clone2Full(var_153_0, #var_143_4), function(arg_154_0, arg_154_1)
			local var_154_0 = var_143_4[arg_154_0]

			self:UpdateRyzaItem(arg_154_1:Find("IconBG"), var_143_4[arg_154_0], true)
			onButton(self, arg_154_1, function()
				self:ShowItemDetail(var_154_0)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end)()

	return
end

function AtelierCompositeScene:HideMaterialsPreview()
	if not isActive(self.layerMaterialsPreview) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self.layerMaterialsPreview, self._tf)
	setActive(self.layerMaterialsPreview, false)

	return true
end

function AtelierCompositeScene:OnReceiveFormualRequest(arg_157_1)
	self:HideCandicatePanel()
	self:HideCompositeConfirmWindow()
	self:HideCompositeResult()
	self:HideMaterialsPreview()
	self:CloseStoreHouseWindow()
	self:HideFormulaList()
	self:ShowFormulaDetail(self.activity:GetFormulas()[arg_157_1])

	return
end

function AtelierCompositeScene:DispalyChat(arg_158_1)
	self:HideChat()
	setActive(self.chat, true)

	self.chatTween = LeanTween.delayedCall(go(self.chat), 4, System.Action(function()
		self:HideChat()

		return
	end)).uniqueId

	local var_158_0 = arg_158_1[math.random(#arg_158_1)]
	local var_158_1 = _.detect(pg.gametip.ryza_composite_words.tip, function(arg_160_0)
		return arg_160_0[1] == var_158_0
	end)

	setText(self.chat:Find("Text"), var_158_1 and var_158_1[2])
	self:PlaySound("event:/cv/" .. 1090001 .. "/" .. var_158_0)

	return
end

function AtelierCompositeScene:HideChat()
	if self.chatTween then
		LeanTween.cancel(self.chatTween)

		self.chatTween = nil
	end

	setActive(self.chat, false)

	return
end

function AtelierCompositeScene:PlaySound(arg_162_1, arg_162_2)
	if not self.playbackInfo or arg_162_1 ~= self.prevCvPath or self.playbackInfo.channelPlayer == nil then
		self:StopSound()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_162_1, function(arg_163_0)
			if arg_163_0 then
				self.playbackInfo = arg_163_0

				self.playbackInfo:SetIgnoreAutoUnload(true)

				if arg_162_2 then
					arg_162_2(self.playbackInfo.cueInfo)
				end
			elseif arg_162_2 then
				arg_162_2()
			end

			return
		end)

		self.prevCvPath = arg_162_1

		if self.playbackInfo == nil then
			return nil
		end

		return self.playbackInfo.cueInfo
	elseif self.playbackInfo then
		self.playbackInfo:PlaybackStop()
		self.playbackInfo:SetStartTimeAndPlay()

		if arg_162_2 then
			arg_162_2(self.playbackInfo.cueInfo)
		end

		return self.playbackInfo.cueInfo
	elseif arg_162_2 then
		arg_162_2()
	end

	return nil
end

function AtelierCompositeScene:StopSound()
	if self.playbackInfo then
		pg.CriMgr.GetInstance():StopPlaybackInfoForce(self.playbackInfo)
		self.playbackInfo:SetIgnoreAutoUnload(false)
	end

	return
end

function AtelierCompositeScene:ClearSound()
	self:StopSound()

	if self.playbackInfo then
		self.playbackInfo:Dispose()

		self.playbackInfo = nil
	end

	return
end

function AtelierCompositeScene:LoadingOn()
	if self.animating then
		return
	end

	self.animating = true

	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function AtelierCompositeScene:LoadingOff()
	if not self.animating then
		return
	end

	pg.UIMgr.GetInstance():LoadingOff()

	self.animating = false

	return
end

function AtelierCompositeScene:willExit()
	self.loader:Clear()
	self:LoadingOff()
	self:HideChat()
	self:ClearSound()
	self:HideStoreHouseWindow()
	self:HideMaterialsPreview()
	self:HideCompositeResult()
	self:HideCompositeConfirmWindow()
	self:HideCandicatePanel()
	self:HideFormulaDetail()
	self:HideFormulaList()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)

	if self.nodePools then
		for iter_168_0, iter_168_1 in pairs(self.nodePools) do
			iter_168_1:ClearItems()
		end
	end

	return
end

return AtelierCompositeScene
