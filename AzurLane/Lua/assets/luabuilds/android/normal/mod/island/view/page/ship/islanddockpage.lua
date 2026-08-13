class = var_0_10000

local var_0_0 = "IslandDockPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandDockUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frameTr = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/ships")

	arg_2_0.shipRect = var_1.GetComponent(var_2_2, "LScrollRect")

	local var_2_3 = arg_2_0._tf

	arg_2_0.inputTr = var_1.Find(var_2_3, "frame/filter_panel/search/input")

	local var_2_4 = arg_2_0._tf

	arg_2_0.indexBtn = var_1.Find(var_2_4, "frame/filter_panel/IndexIco")

	local var_2_5 = arg_2_0._tf

	arg_2_0.orderBtn = var_1.Find(var_2_5, "frame/filter_panel/index")

	local var_2_6 = arg_2_0._tf

	arg_2_0.orderIco = var_1.Find(var_2_6, "frame/filter_panel/index/content/icon/icon")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/filter_panel/index/content/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.orderTxt = var_2_9(var_2_8, var_3(var_1_10004))

	function arg_2_0.shipRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	local var_2_10 = arg_2_0.shipRect

	function var_2_10.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	setText = var_2_10

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "frame/title/Text")

	i18n = var_2_11

	var_2_10(var_2_12, var_2_11("island_chara_list"))

	return
end

function var_0_1.AddListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.AddListener

	IslandCharacterAgency = var_1_10003

	var_5_1(var_5_0, var_1_10003.ADD_SHIP, arg_5_0.OnAddShip)

	return
end

function var_0_1.RemoveListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.RemoveListener

	IslandCharacterAgency = var_1_10003

	var_6_1(var_6_0, var_1_10003.ADD_SHIP, arg_6_0.OnAddShip)

	return
end

function var_0_1.OnAddShip(arg_7_0)
	arg_7_0:FlushShips()

	return
end

function var_0_1.OnInit(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._tf

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onInputChanged = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.inputTr, function()
		getInputText = var_2_10000

		local var_10_0 = var_2_10000(arg_8_0.inputTr)

		arg_8_0.searchKey = var_10_0

		local var_10_1 = arg_8_0

		var_1.FlushShips(var_10_1)

		return
	end)

	onToggle = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.indexBtn

	local function var_8_5(arg_11_0)
		if arg_11_0 then
			local var_11_0 = arg_8_0
			local var_11_1 = var_1.emit

			IslandMediator = var_2_10003

			var_11_1(var_11_0, var_2_10003.OPEN_SHIP_INDEX, {
				OnFilter = function(arg_12_0)
					local var_12_0 = arg_8_0

					var_1.OnFilter(var_12_0, arg_12_0)

					return
				end,
				defaultIndex = arg_8_0.sortData
			})
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.orderBtn

	local function var_8_8()
		arg_8_0.selectAsc = not arg_8_0.selectAsc

		local var_13_0 = arg_8_0

		var_0.UpdateSortBtn(var_13_0)

		local var_13_1 = arg_8_0

		var_0.FlushShips(var_13_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	arg_8_0.cards = {}
	arg_8_0.searchKey = ""
	arg_8_0.selectAsc = true

	local var_8_9 = {}

	IslandShipIndexLayer = var_8_6
	var_8_9.sortIndex = var_8_6.SortLevel
	ShipIndexConst = var_2
	var_8_9.campIndex = var_2.CampAll
	ShipIndexConst = var_2
	var_8_9.rarityIndex = var_2.RarityAll
	IslandShipIndexLayer = var_2
	var_8_9.extraIndex = var_2.ExtraALL
	arg_8_0.sortData = var_8_9

	arg_8_0:UpdateSortBtn()

	return
end

function var_0_1.OnFilter(arg_14_0, arg_14_1)
	arg_14_0.sortData = arg_14_1

	arg_14_0:UpdateSortBtn()
	arg_14_0:FlushShips()

	return
end

function var_0_1.Show(arg_15_0, arg_15_1)
	arg_15_0.hideUnlockShip = arg_15_1

	var_0_1.super.Show(arg_15_0)

	pg = var_2

	local var_15_0 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_15_0, arg_15_0.frameTr, {
		pbList = {
			arg_15_0.frameTr
		}
	})

	getProxy = var_2
	IslandProxy = var_15_0

	local var_15_1 = var_2(var_15_0)
	local var_15_2 = var_2.GetIsland(var_15_1)

	arg_15_0.characterAgency = var_2.GetCharacterAgency(var_15_2)

	arg_15_0:FlushShips()

	return
end

function var_0_1.UpdateSortBtn(arg_16_0)
	local var_16_0 = arg_16_0.orderIco

	if arg_16_0.selectAsc then
		Vector3 = var_16_1

		local var_16_1

		if not var_16_1(1, 1, 1) then
			Vector3 = var_16_1
			var_16_1 = var_16_1(1, -1, 1)
		end

		var_16_0.localScale = var_16_1
		IslandShipIndexLayer = var_16_0

		local var_16_2, var_16_3 = var_16_0.getSortFuncAndName(arg_16_0.sortData.sortIndex, arg_16_0.selectAsc)
		local var_16_4 = arg_16_0.orderTxt

		i18n = var_1_10004
		var_16_4.text = var_1_10004(var_16_3)

		return
	end
end

function var_0_1.OnInitItem(arg_17_0, arg_17_1)
	IslandShipCard = var_1_10002

	local var_17_0 = var_1_10002.New(arg_17_1)

	onButton = var_3

	local var_17_1 = arg_17_0
	local var_17_2 = var_17_0.go

	local function var_17_3()
		local var_18_0 = arg_17_0

		var_0.ClearSelected(var_18_0, arg_17_0.contextData.selectedId)

		local var_18_1 = arg_17_0
		local var_18_2 = var_0.emit

		IslandShipMainPage = var_2

		var_18_2(var_18_1, var_2.SELECT_SHIP, var_17_0.configId)

		local var_18_3 = var_17_0

		var_0.UpdateSelected(var_18_3, arg_17_0.contextData.selectedId)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_17_1, var_17_2, var_17_3, var_1_10007)

	arg_17_0.cards[arg_17_1] = var_17_0

	return
end

function var_0_1.ClearSelected(arg_19_0, arg_19_1)
	pairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.cards) do
		if iter_19_1.configId == arg_19_1 then
			iter_19_1:UpdateSelected(nil)

			break
		end
	end

	return
end

function var_0_1.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if not arg_20_0.cards[arg_20_2] then
		arg_20_0:OnInitItem(arg_20_2)

		var_20_0 = arg_20_0.cards[arg_20_2]
	end

	local var_20_1 = arg_20_0.displays[arg_20_1 + 1]

	var_20_0:Update(var_20_1, arg_20_0.contextData.selectedId)

	return
end

function var_0_1.FlushShips(arg_21_0)
	arg_21_0.displays = arg_21_0:GetShips()

	local var_21_0 = arg_21_0.shipRect

	var_1.SetTotalCount(var_21_0, #arg_21_0.displays)

	return
end

local function var_0_2(arg_22_0, arg_22_1)
	if not arg_22_1 or arg_22_1 == "" then
		return true
	end

	string = var_1_10002

	local var_22_0 = var_1_10002.lower

	string = var_1_10003

	local var_22_1 = var_22_0(var_1_10003.gsub(arg_22_1, "%.", "%%."))

	IslandShip = var_3

	local var_22_2 = var_3.StaticGetName(arg_22_0)

	string = var_4

	local var_22_3 = var_4.find

	string = var_5

	return var_22_3(var_5.lower(var_22_2), var_22_1)
end

function var_0_1.ToVShip(arg_23_0, arg_23_1)
	if not arg_23_0.vship then
		arg_23_0.vship = {}

		function arg_23_0.vship.getNation()
			return arg_23_0.vship.config.nationality
		end

		function arg_23_0.vship.getShipType()
			return arg_23_0.vship.config.type
		end

		function arg_23_0.vship.getTeamType()
			ShipType = var_2_10000

			return var_2_10000.GetTeamFromShipType(arg_23_0.vship.config.type)
		end

		function arg_23_0.vship.getRarity()
			return arg_23_0.vship.config.rarity
		end
	end

	arg_23_0.vship.config = arg_23_1

	return arg_23_0.vship
end

local function var_0_3(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1

	ShipGroup = var_1_10004

	local var_28_1 = var_1_10004.getDefaultShipConfig(var_28_0)
	local var_28_2 = arg_28_0:ToVShip(var_28_1)
	local var_28_3 = arg_28_0.characterAgency
	local var_28_4 = var_6.GetShipById(var_28_3, arg_28_1)

	ShipIndexConst = var_28_3

	if var_28_3.filterByCamp(var_28_2, arg_28_2.campIndex) then
		ShipIndexConst = var_7

		if var_7.filterByRarity(var_28_2, arg_28_2.rarityIndex) then
			IslandShipIndexLayer = var_7

			if var_7.filterByExtra(var_28_4, arg_28_2.extraIndex) then
				return true
			end
		end
	end

	return false
end

function var_0_1.GetShips(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = {}
	local var_29_2 = arg_29_0.characterAgency
	local var_29_3 = var_3.GetUnlockOrCanUnlockShipConfigIds(var_29_2)

	ipairs = var_29_2

	for iter_29_0, iter_29_1 in var_29_2(var_29_3) do
		if var_0_2(iter_29_1, arg_29_0.searchKey) and var_0_3(arg_29_0, iter_29_1, arg_29_0.sortData) then
			var_1_10010 = arg_29_0.characterAgency

			if var_9.GetShipById(var_1_10010, iter_29_1) then
				table = var_1_10010

				var_1_10010.insert(var_29_1, var_9)
			else
				table = var_1_10010

				var_1_10010.insert(var_29_1, {
					isInvite = true,
					configId = iter_29_1
				})
			end
		end
	end

	IslandShipIndexLayer = var_4

	local var_29_4 = var_4.getSortFuncAndName(arg_29_0.sortData.sortIndex, arg_29_0.selectAsc)

	table = var_5

	local var_29_5 = var_5.sort
	local var_29_6 = var_29_1

	CompareFuncs = iter_29_0

	var_29_5(var_29_6, iter_29_0(var_29_4))

	ipairs = var_29_5

	for iter_29_2, iter_29_3 in var_29_5(var_29_1) do
		table = var_1_10010

		var_1_10010.insert(var_29_0, iter_29_3.configId)
	end

	if arg_29_0.hideUnlockShip then
		for iter_29_4 = #var_29_0, 1, -1 do
			if var_29_0[iter_29_4] then
				getProxy = var_1_10010
				IslandProxy = var_1_10011
				var_1_10011 = var_1_10010(var_1_10011)
				var_1_10011 = var_1_10010.GetIsland(var_1_10011)
				var_1_10011 = var_1_10010.GetCharacterAgency(var_1_10011)

				if var_1_10010.GetShipById(var_1_10011, var_9) == nil then
					table = var_1_10011

					var_1_10011.remove(var_29_0, iter_29_4)
				end
			end
		end
	end

	return var_29_0
end

function var_0_1.Hide(arg_30_0)
	var_0_1.super.Hide(arg_30_0)

	pg = var_1

	local var_30_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_30_0, arg_30_0.frameTr, arg_30_0._tf)

	local var_30_1 = arg_30_0
	local var_30_2 = arg_30_0.emit

	IslandShipMainPage = var_3

	var_30_2(var_30_1, var_3.CLOSE_DOCK)

	return
end

function var_0_1.OnDestroy(arg_31_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_31_0.shipRect)

	pairs = var_1_10001

	for iter_31_0, iter_31_1 in var_1_10001(arg_31_0.cards) do
		iter_31_1:Dispose()
	end

	arg_31_0.cards = nil

	return
end

return var_0_1
