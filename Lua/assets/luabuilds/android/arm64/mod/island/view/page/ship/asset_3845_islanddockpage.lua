local IslandDockPage = class("IslandDockPage", import("...base.IslandBasePage"))

function IslandDockPage:getUIName()
	return "IslandDockUI"
end

function IslandDockPage:OnLoaded()
	self.frameTr = self._tf:Find("frame")
	self.shipRect = self._tf:Find("frame/ships"):GetComponent("LScrollRect")
	self.inputTr = self._tf:Find("frame/filter_panel/search/input")
	self.indexBtn = self._tf:Find("frame/filter_panel/IndexIco")
	self.orderBtn = self._tf:Find("frame/filter_panel/index")
	self.orderIco = self._tf:Find("frame/filter_panel/index/content/icon/icon")
	self.orderTxt = self._tf:Find("frame/filter_panel/index/content/Text"):GetComponent(typeof(Text))

	function self.shipRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.shipRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	setText(self._tf:Find("frame/title/Text"), i18n("island_chara_list"))

	return
end

function IslandDockPage:AddListeners()
	self:AddListener(IslandCharacterAgency.ADD_SHIP, self.OnAddShip)

	return
end

function IslandDockPage:RemoveListeners()
	self:RemoveListener(IslandCharacterAgency.ADD_SHIP, self.OnAddShip)

	return
end

function IslandDockPage:OnAddShip()
	self:FlushShips()

	return
end

function IslandDockPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onInputChanged(self, self.inputTr, function()
		self.searchKey = getInputText(self.inputTr)

		self:FlushShips()

		return
	end)
	onToggle(self, self.indexBtn, function(arg_11_0)
		if arg_11_0 then
			self:emit(IslandMediator.OPEN_SHIP_INDEX, {
				OnFilter = function(arg_12_0)
					self:OnFilter(arg_12_0)

					return
				end,
				defaultIndex = self.sortData
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.orderBtn, function()
		self.selectAsc = not self.selectAsc

		self:UpdateSortBtn()
		self:FlushShips()

		return
	end, SFX_PANEL)

	self.cards = {}
	self.searchKey = ""
	self.selectAsc = true
	self.sortData = {
		sortIndex = IslandShipIndexLayer.SortLevel,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = IslandShipIndexLayer.ExtraALL
	}

	self:UpdateSortBtn()

	return
end

function IslandDockPage:OnFilter(arg_14_1)
	self.sortData = arg_14_1

	self:UpdateSortBtn()
	self:FlushShips()

	return
end

function IslandDockPage:Show(arg_15_1)
	self.hideUnlockShip = arg_15_1

	IslandDockPage.super.Show(self)
	pg.UIMgr.GetInstance():OverlayPanel(self.frameTr, {
		pbList = {
			self.frameTr
		}
	})

	self.characterAgency = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	self:FlushShips()

	return
end

function IslandDockPage:UpdateSortBtn()
	self.orderIco.localScale = self.selectAsc and Vector3(1, 1, 1) or Vector3(1, -1, 1)

	local var_16_0, var_16_1 = IslandShipIndexLayer.getSortFuncAndName(self.sortData.sortIndex, self.selectAsc)

	self.orderTxt.text = i18n(var_16_1)

	return
end

function IslandDockPage:OnInitItem(arg_17_1)
	local var_17_0 = IslandShipCard.New(arg_17_1)

	onButton(self, var_17_0.go, function()
		self:ClearSelected(self.contextData.selectedId)
		self:emit(IslandShipMainPage.SELECT_SHIP, var_17_0.configId)
		var_17_0:UpdateSelected(self.contextData.selectedId)

		return
	end, SFX_PANEL)

	self.cards[arg_17_1] = var_17_0

	return
end

function IslandDockPage:ClearSelected(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self.cards) do
		if iter_19_1.configId == arg_19_1 then
			iter_19_1:UpdateSelected(nil)

			break
		end
	end

	return
end

function IslandDockPage:OnUpdateItem(arg_20_1, arg_20_2)
	if not self.cards[arg_20_2] then
		self:OnInitItem(arg_20_2)
	end

	self.cards[arg_20_2]:Update(self.displays[arg_20_1 + 1], self.contextData.selectedId)

	return
end

function IslandDockPage:FlushShips()
	self.displays = self:GetShips()

	self.shipRect:SetTotalCount(#self.displays)

	return
end

local function var_0_1(arg_22_0, arg_22_1)
	if not arg_22_1 or arg_22_1 == "" then
		return true
	end

	return string.find(string.lower((IslandShip.StaticGetName(arg_22_0))), (string.lower(string.gsub(arg_22_1, "%.", "%%."))))
end

function IslandDockPage:ToVShip(arg_23_1)
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

	self.vship.config = arg_23_1

	return self.vship
end

local function var_0_2(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:ToVShip((ShipGroup.getDefaultShipConfig(arg_28_1)))

	if ShipIndexConst.filterByCamp(var_28_0, arg_28_2.campIndex) and ShipIndexConst.filterByRarity(var_28_0, arg_28_2.rarityIndex) and IslandShipIndexLayer.filterByExtra(arg_28_0.characterAgency:GetShipById(arg_28_1), arg_28_2.extraIndex) then
		return true
	end

	return false
end

function IslandDockPage:GetShips()
	local var_29_0 = {}
	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs((self.characterAgency:GetUnlockOrCanUnlockShipConfigIds())) do
		if var_0_1(iter_29_1, self.searchKey) and var_0_2(self, iter_29_1, self.sortData) then
			local var_29_2 = self.characterAgency:GetShipById(iter_29_1)

			if var_29_2 then
				table.insert(var_29_1, var_29_2)
			else
				table.insert(var_29_1, {
					isInvite = true,
					configId = iter_29_1
				})
			end
		end
	end

	table.sort(var_29_1, CompareFuncs((IslandShipIndexLayer.getSortFuncAndName(self.sortData.sortIndex, self.selectAsc))))

	for iter_29_2, iter_29_3 in ipairs(var_29_1) do
		table.insert(var_29_0, iter_29_3.configId)
	end

	if self.hideUnlockShip then
		for iter_29_4 = #var_29_0, 1, -1 do
			if var_29_0[iter_29_4] then
				if getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_29_0[iter_29_4]) == nil then
					table.remove(var_29_0, iter_29_4)
				end
			end
		end
	end

	return var_29_0
end

function IslandDockPage:Hide()
	IslandDockPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.frameTr, self._tf)
	self:emit(IslandShipMainPage.CLOSE_DOCK)

	return
end

function IslandDockPage:OnDestroy()
	ClearLScrollrect(self.shipRect)

	for iter_31_0, iter_31_1 in pairs(self.cards) do
		iter_31_1:Dispose()
	end

	self.cards = nil

	return
end

return IslandDockPage
