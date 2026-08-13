class = var_0_10000

local var_0_0 = "WSMapLeft"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	rtShip = "userdata",
	rtArrow = "userdata",
	delayCallFuncs = "table",
	toggles = "table",
	rtFleet = "userdata",
	rtAmmo = "userdata",
	toggleSelected = "userdata",
	onAgonyClick = "function",
	rtSubBar = "userdata",
	btnCollapse = "userdata",
	rtFleetBar = "userdata",
	toggleMask = "userdata",
	rtBG = "userdata",
	fleet = "table",
	transform = "userdata",
	onAgonyClickEnabled = "boolean",
	world = "table",
	rtVanguard = "userdata",
	rtSalvageList = "userdata",
	toggleList = "userdata",
	onLongPress = "function",
	onClickSalvage = "function",
	rtMain = "userdata"
}
var_0_1.Listeners = {
	onUpdateShipHpRate = "OnUpdateShipHpRate",
	onUpdateFleetOrder = "OnUpdateFleetOrder",
	onUpdateFleetBar = "OnUpdateFleetBar",
	onUpdateCatSalvage = "OnUpdateCatSalvage",
	onUpdateShipBroken = "OnUpdateShipBroken",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}
var_0_1.EventSelectFleet = "WSMapLeft.EventSelectFleet"

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)

	arg_1_0.delayCallFuncs = {}

	arg_1_0:Init()
	arg_1_0:AddWorldListener()
	arg_1_0:UpdateAllCatSalvage()

	return
end

function var_0_1.Dispose(arg_2_0)
	local function var_2_0(arg_3_0)
		LeanTween = var_2_10001

		local var_3_0 = var_2_10001.cancel

		go = var_2_10002

		var_3_0(var_2_10002(arg_3_0))

		LeanTween = var_3_0

		local var_3_1 = var_3_0.cancel

		go = var_2

		var_3_1(var_2(arg_3_0:Find("text")))

		return
	end

	eachChild = var_1_10002

	var_1_10002(arg_2_0.rtMain, function(arg_4_0)
		local var_4_0 = arg_4_0:Find("HP_POP")

		var_2_0(var_4_0:Find("heal"))
		var_2_0(var_4_0:Find("normal"))

		return
	end)

	eachChild = var_1_10002

	var_1_10002(arg_2_0.rtVanguard, function(arg_5_0)
		local var_5_0 = arg_5_0:Find("HP_POP")

		var_2_0(var_5_0:Find("heal"))
		var_2_0(var_5_0:Find("normal"))

		return
	end)
	arg_2_0:RemoveWorldListener()
	arg_2_0:RemoveFleetListener(arg_2_0.fleet)
	arg_2_0:RemoveMapListener()

	pg = var_2

	var_2.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_6_0)
	local var_6_0 = arg_6_0.transform

	arg_6_0.rtBG = var_1.Find(var_6_0, "bg")

	local var_6_1 = arg_6_0.rtBG

	arg_6_0.rtFleet = var_2.Find(var_6_1, "fleet")

	local var_6_2 = arg_6_0.rtFleet

	arg_6_0.rtMain = var_2.Find(var_6_2, "main")

	local var_6_3 = arg_6_0.rtFleet

	arg_6_0.rtVanguard = var_2.Find(var_6_3, "vanguard")

	local var_6_4 = arg_6_0.rtFleet

	arg_6_0.rtShip = var_2.Find(var_6_4, "shiptpl")

	local var_6_5 = arg_6_0.rtBG

	arg_6_0.btnCollapse = var_2.Find(var_6_5, "collapse")

	local var_6_6 = arg_6_0.btnCollapse

	arg_6_0.rtArrow = var_2.Find(var_6_6, "arrow")
	arg_6_0.rtFleetBar = var_1:Find("other/fleet_bar")
	arg_6_0.toggleMask = var_1:Find("mask")

	local var_6_7 = arg_6_0.toggleMask

	arg_6_0.toggleList = var_2.Find(var_6_7, "list")
	arg_6_0.toggles = {}

	for iter_6_0 = 0, arg_6_0.toggleList.childCount - 1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_6_8 = arg_6_0.toggles
		local var_6_9 = arg_6_0.toggleList

		var_1_10006(var_6_8, var_8.GetChild(var_6_9, iter_6_0))
	end

	arg_6_0.rtSubBar = var_1:Find("other/sub_bar")

	local var_6_10 = arg_6_0.rtSubBar

	arg_6_0.rtAmmo = var_2.Find(var_6_10, "text")
	arg_6_0.rtSalvageList = var_1:Find("other/salvage_list")
	setActive = var_2

	var_2(arg_6_0.rtShip, false)

	setActive = var_2

	var_2(arg_6_0.toggleMask, false)

	setActive = var_2

	var_2(arg_6_0.rtSubBar, false)

	onButton = var_2

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.btnCollapse

	local function var_6_13()
		local var_7_0 = arg_6_0

		var_0.Collpase(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_6_11, var_6_12, var_6_13, var_1_10006)

	onButton = var_2

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.rtFleetBar

	local function var_6_16()
		local var_8_0 = arg_6_0

		var_0.ShowToggleMask(var_8_0, function(arg_9_0)
			local var_9_0 = arg_6_0

			var_1.DispatchEvent(var_9_0, var_0_1.EventSelectFleet, arg_9_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_6_14, var_6_15, var_6_16, var_1_10006)

	onButton = var_2

	local var_6_17 = arg_6_0
	local var_6_18 = arg_6_0.toggleMask

	local function var_6_19()
		local var_10_0 = arg_6_0

		var_0.HideToggleMask(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_6_17, var_6_18, var_6_19, var_1_10006)

	return
end

function var_0_1.AddWorldListener(arg_11_0)
	underscore = var_1_10001

	local var_11_0 = var_1_10001.each

	nowWorld = var_1_10002

	local var_11_1 = var_1_10002()

	var_11_0(var_2.GetNormalFleets(var_11_1), function(arg_12_0)
		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_0.AddListener

		WorldMapFleet = var_2_10003

		var_12_1(var_12_0, var_2_10003.EventUpdateCatSalvage, arg_11_0.onUpdateCatSalvage)

		return
	end)

	return
end

function var_0_1.RemoveWorldListener(arg_13_0)
	underscore = var_1_10001

	local var_13_0 = var_1_10001.each

	nowWorld = var_1_10002

	local var_13_1 = var_1_10002()

	var_13_0(var_2.GetNormalFleets(var_13_1), function(arg_14_0)
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.RemoveListener

		WorldMapFleet = var_2_10003

		var_14_1(var_14_0, var_2_10003.EventUpdateCatSalvage, arg_13_0.onUpdateCatSalvage)

		return
	end)

	return
end

function var_0_1.UpdateMap(arg_15_0, arg_15_1)
	arg_15_0:RemoveMapListener()

	arg_15_0.map = arg_15_1

	arg_15_0:AddMapListener()
	arg_15_0:OnUpdateSelectedFleet()
	arg_15_0:OnUpdateSubmarineSupport()

	return
end

function var_0_1.AddMapListener(arg_16_0)
	if arg_16_0.map then
		local var_16_0 = arg_16_0.map
		local var_16_1 = var_1.AddListener

		WorldMap = var_1_10003

		var_16_1(var_16_0, var_1_10003.EventUpdateFIndex, arg_16_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.RemoveMapListener(arg_17_0)
	if arg_17_0.map then
		local var_17_0 = arg_17_0.map
		local var_17_1 = var_1.RemoveListener

		WorldMap = var_1_10003

		var_17_1(var_17_0, var_1_10003.EventUpdateFIndex, arg_17_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.AddFleetListener(arg_18_0, arg_18_1)
	if arg_18_1 then
		local var_18_0 = arg_18_1
		local var_18_1 = arg_18_1.AddListener

		WorldMapFleet = var_1_10004

		var_18_1(var_18_0, var_1_10004.EventUpdateShipOrder, arg_18_0.onUpdateFleetOrder)

		local var_18_2 = arg_18_1
		local var_18_3 = arg_18_1.AddListener

		WorldMapFleet = var_4

		var_18_3(var_18_2, var_4.EventUpdateBuff, arg_18_0.onUpdateFleetBar)

		_ = var_18_3

		var_18_3.each(arg_18_1:GetShips(true), function(arg_19_0)
			local var_19_0 = arg_19_0
			local var_19_1 = arg_19_0.AddListener

			WorldMapShip = var_2_10003

			var_19_1(var_19_0, var_2_10003.EventHpRantChange, arg_18_0.onUpdateShipHpRate)

			local var_19_2 = arg_19_0
			local var_19_3 = arg_19_0.AddListener

			WorldMapShip = var_3

			var_19_3(var_19_2, var_3.EventUpdateBroken, arg_18_0.onUpdateShipBroken)

			return
		end)
	end

	return
end

function var_0_1.RemoveFleetListener(arg_20_0, arg_20_1)
	if arg_20_1 then
		local var_20_0 = arg_20_1
		local var_20_1 = arg_20_1.RemoveListener

		WorldMapFleet = var_1_10004

		var_20_1(var_20_0, var_1_10004.EventUpdateShipOrder, arg_20_0.onUpdateFleetOrder)

		local var_20_2 = arg_20_1
		local var_20_3 = arg_20_1.RemoveListener

		WorldMapFleet = var_4

		var_20_3(var_20_2, var_4.EventUpdateBuff, arg_20_0.onUpdateFleetBar)

		_ = var_20_3

		var_20_3.each(arg_20_1:GetShips(true), function(arg_21_0)
			local var_21_0 = arg_21_0
			local var_21_1 = arg_21_0.RemoveListener

			WorldMapShip = var_2_10003

			var_21_1(var_21_0, var_2_10003.EventHpRantChange, arg_20_0.onUpdateShipHpRate)

			local var_21_2 = arg_21_0
			local var_21_3 = arg_21_0.RemoveListener

			WorldMapShip = var_3

			var_21_3(var_21_2, var_3.EventUpdateBroken, arg_20_0.onUpdateShipBroken)

			return
		end)
	end

	return
end

function var_0_1.OnUpdateSelectedFleet(arg_22_0)
	local var_22_0 = arg_22_0.map
	local var_22_1 = var_1.GetFleet(var_22_0)

	if arg_22_0.fleet ~= var_22_1 then
		arg_22_0:RemoveFleetListener(arg_22_0.fleet)

		arg_22_0.fleet = var_22_1

		arg_22_0:AddFleetListener(arg_22_0.fleet)

		arg_22_0.delayCallFuncs = {}

		local var_22_2 = arg_22_0
		local var_22_3 = arg_22_0.UpdateShipList
		local var_22_4 = arg_22_0.rtMain
		local var_22_5 = arg_22_0.fleet
		local var_22_6 = var_5.GetTeamShips

		TeamType = var_1_10007

		var_22_3(var_22_2, var_22_4, var_22_6(var_22_5, var_1_10007.Main, true))

		local var_22_7 = arg_22_0
		local var_22_8 = arg_22_0.UpdateShipList
		local var_22_9 = arg_22_0.rtVanguard
		local var_22_10 = arg_22_0.fleet
		local var_22_11 = var_5.GetTeamShips

		TeamType = var_7

		var_22_8(var_22_7, var_22_9, var_22_11(var_22_10, var_7.Vanguard, true))

		setImageSprite = var_22_8

		local var_22_12 = arg_22_0.rtFleetBar
		local var_22_13 = var_3.Find(var_22_12, "text_selected/x")

		getImageSprite = var_22_12

		local var_22_14 = arg_22_0.toggles[var_22_1.index]

		var_22_8(var_22_13, var_22_12(var_5.Find(var_22_14, "text_selected/x")))
		arg_22_0:OnUpdateFleetBar(nil, var_22_1)
	end

	return
end

function var_0_1.UpdateAllCatSalvage(arg_23_0)
	nowWorld = var_1_10001

	local var_23_0 = var_1_10001()
	local var_23_1 = var_1.GetNormalFleets(var_23_0)
	local var_23_2 = arg_23_0.rtSalvageList
	local var_23_3 = var_2.GetChild(var_23_2, 0)

	for iter_23_0 = arg_23_0.rtSalvageList.childCount + 1, #var_23_1 do
		cloneTplTo = var_1_10007

		var_1_10007(var_23_3, arg_23_0.rtSalvageList, var_23_3.name)
	end

	for iter_23_1 = #var_23_1 + 1, arg_23_0.rtSalvageList.childCount do
		setActive = var_1_10007

		local var_23_4 = arg_23_0.rtSalvageList

		var_1_10007(var_8.GetChild(var_23_4, iter_23_1 - 1), false)
	end

	underscore = var_3

	var_3.each(var_23_1, function(arg_24_0)
		local var_24_0 = arg_23_0

		var_1.OnUpdateCatSalvage(var_24_0, nil, arg_24_0)

		return
	end)

	return
end

function var_0_1.OnUpdateCatSalvage(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2:IsCatSalvage()
	local var_25_1 = arg_25_0.rtSalvageList
	local var_25_2 = var_4.GetChild(var_25_1, arg_25_2.index - 1)

	setActive = var_25_1

	var_25_1(var_25_2, var_25_0)

	if var_25_0 then
		local var_25_3 = arg_25_2:GetDisplayCommander()
		local var_25_4 = var_25_1.getPainting(var_25_3)

		GetImageSpriteFromAtlasAsync = var_25_3

		var_25_3("commandericon/" .. var_25_4, "", var_25_2:Find("icon"))

		setActive = var_25_3
		var_1_10009 = var_25_2

		local var_25_5 = var_25_2.Find(var_1_10009, "rarity")

		var_1_10009 = arg_25_2:GetRarityState() > 0

		var_25_3(var_25_5, var_1_10009)

		setActive = var_25_3
		var_1_10009 = var_25_2

		local var_25_6 = var_25_2.Find(var_1_10009, "doing")

		var_1_10009 = arg_25_2.catSalvageStep < #arg_25_2.catSalvageList

		var_25_3(var_25_6, var_1_10009)

		setSlider = var_25_3
		var_1_10009 = var_25_2

		var_25_3(var_25_2.Find(var_1_10009, "doing/Slider"), 0, #arg_25_2.catSalvageList, arg_25_2.catSalvageStep)

		setActive = var_25_3
		var_1_10009 = var_25_2

		local var_25_7 = var_25_2.Find(var_1_10009, "finish")

		var_1_10009 = arg_25_2.catSalvageStep == #arg_25_2.catSalvageList

		var_25_3(var_25_7, var_1_10009)
	end

	onButton = var_25_1

	local var_25_8 = arg_25_0
	local var_25_9 = var_25_2

	local function var_25_10()
		arg_25_0.onClickSalvage(arg_25_2.id)

		return
	end

	SFX_PANEL = var_1_10009

	var_25_1(var_25_8, var_25_9, var_25_10, var_1_10009)

	return
end

function var_0_1.OnUpdateSubmarineSupport(arg_27_0)
	nowWorld = var_1_10001

	local var_27_0 = var_1_10001()

	setActive = var_1_10002

	local var_27_1 = arg_27_0.rtSubBar
	local var_27_2 = var_27_0

	var_1_10002(var_27_1, var_27_0.IsSubmarineSupporting(var_27_2))

	if var_27_0:GetSubmarineFleet() then
		local var_27_3, var_27_4 = var_2:GetAmmo()

		setText = var_27_2

		var_27_2(arg_27_0.rtAmmo, var_27_3 .. "/" .. var_27_4)

		setGray = var_27_2

		var_27_2(arg_27_0.rtSubBar, var_2:GetAmmo() <= 0, true)
	end

	return
end

function var_0_1.OnUpdateFleetOrder(arg_28_0)
	arg_28_0.delayCallFuncs = {}

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.UpdateShipList
	local var_28_2 = arg_28_0.rtMain
	local var_28_3 = arg_28_0.fleet
	local var_28_4 = var_4.GetTeamShips

	TeamType = var_1_10006

	var_28_1(var_28_0, var_28_2, var_28_4(var_28_3, var_1_10006.Main, true))

	local var_28_5 = arg_28_0
	local var_28_6 = arg_28_0.UpdateShipList
	local var_28_7 = arg_28_0.rtVanguard
	local var_28_8 = arg_28_0.fleet
	local var_28_9 = var_4.GetTeamShips

	TeamType = var_6

	var_28_6(var_28_5, var_28_7, var_28_9(var_28_8, var_6.Vanguard, true))

	return
end

function var_0_1.GetShipObject(arg_29_0, arg_29_1)
	local var_29_0 = {}

	TeamType = var_1_10003
	var_29_0[var_1_10003.Main] = arg_29_0.rtMain
	TeamType = var_3
	var_29_0[var_3.Vanguard] = arg_29_0.rtVanguard
	pairs = var_3

	for iter_29_0, iter_29_1 in var_3(var_29_0) do
		local var_29_1 = arg_29_0.fleet
		local var_29_2 = var_8.GetTeamShips(var_29_1, iter_29_0, true)

		ipairs = var_29_1

		for iter_29_2, iter_29_3 in var_29_1(var_29_2) do
			if arg_29_1.id == iter_29_3.id then
				return iter_29_1:GetChild(iter_29_2 - 1)
			end
		end
	end

	return
end

function var_0_1.OnUpdateShipHpRate(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.GetShipObject(var_30_0, arg_30_2)

	assert = var_30_0

	var_30_0(var_30_1, "can not find this ship in display fleet: " .. arg_30_2.id)

	table = var_30_0

	var_30_0.insert(arg_30_0.delayCallFuncs[arg_30_2.id], function()
		local var_31_0 = arg_30_0

		var_0.ShipDamageDisplay(var_31_0, arg_30_2, var_30_1, true)

		return
	end)

	if not arg_30_0.delayCallFuncs[arg_30_2.id].isDoing then
		table = var_4

		var_4.remove(arg_30_0.delayCallFuncs[arg_30_2.id], 1)()
	end

	return
end

function var_0_1.OnUpdateShipBroken(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.GetShipObject(var_32_0, arg_32_2)

	setActive = var_32_0

	var_32_0(var_32_1:Find("broken"), arg_32_2:IsBroken())

	return
end

function var_0_1.OnUpdateFleetBar(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2
	local var_33_1 = arg_33_2.GetWatchingBuff(var_33_0)

	setActive = var_33_0

	local var_33_2 = arg_33_0.rtFleetBar

	var_33_0(var_5.Find(var_33_2, "watching_buff"), var_33_1)

	if var_33_1 then
		if #var_33_1.config.icon > 0 then
			GetImageSpriteFromAtlasAsync = var_4

			local var_33_3 = "world/watchingbuff/" .. var_33_1.config.icon
			local var_33_4 = ""
			local var_33_5 = arg_33_0.rtFleetBar

			var_4(var_33_3, var_33_4, var_7.Find(var_33_5, "watching_buff"))
		else
			setImageSprite = var_4

			local var_33_6 = arg_33_0.rtFleetBar

			var_4(var_5.Find(var_33_6, "watching_buff"), nil)
		end
	end

	return
end

function var_0_1.UpdateShipList(arg_34_0, arg_34_1, arg_34_2)
	UIItemList = var_1_10003

	local var_34_0 = var_1_10003.New(arg_34_1, arg_34_0.rtShip)

	var_3.make(var_34_0, function(arg_35_0, arg_35_1, arg_35_2)
		UIItemList = var_2_10003

		if arg_35_0 == var_2_10003.EventUpdate then
			local var_35_0 = arg_34_2[arg_35_1 + 1]

			updateShip = var_4

			local var_35_1 = arg_35_2

			WorldConst = var_2_10006

			var_4(var_35_1, var_2_10006.FetchShipVO(var_35_0.id))

			onButton = var_4

			local var_35_2 = arg_34_0
			local var_35_3 = arg_35_2:Find("agony")

			local function var_35_4()
				if arg_34_0.onAgonyClickEnabled then
					arg_34_0.onAgonyClick()
				end

				return
			end

			SFX_PANEL = var_8

			var_4(var_35_2, var_35_3, var_35_4, var_8)

			arg_34_0.delayCallFuncs[var_35_0.id] = {}

			local var_35_5 = arg_34_0

			var_4.ShipDamageDisplay(var_35_5, var_35_0, arg_35_2)

			GetOrAddComponent = var_4

			local var_35_6 = var_4(arg_35_2, "UILongPressTrigger").onLongPressed

			pg = var_5

			var_5.DelegateInfo.Add(arg_34_0, var_35_6)
			var_35_6:RemoveAllListeners()
			var_35_6:AddListener(function()
				arg_34_0.onLongPress(var_35_0)

				return
			end)
		end

		return
	end)
	var_3:align(#arg_34_2)

	return
end

function var_0_1.ShipDamageDisplay(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_2
	local var_38_1 = arg_38_2.Find(var_38_0, "HP_POP")

	setActive = var_38_0

	var_38_0(var_38_1, true)

	setActive = var_38_0

	var_38_0(var_38_1:Find("heal"), false)

	setActive = var_38_0

	var_38_0(var_38_1:Find("normal"), false)

	local var_38_2 = arg_38_2:Find("blood")

	if arg_38_3 then
		local var_38_3 = var_38_2
		local var_38_4 = var_38_2.GetComponent

		typeof = var_8
		Slider = var_1_10009

		local var_38_5 = var_38_4(var_38_3, var_8(var_1_10009)).value

		WorldConst = var_38_3

		local var_38_6 = var_38_3.FetchShipVO(arg_38_1.id)
		local var_38_7 = var_7.getShipProperties(var_38_6)

		calcFloor = var_38_6

		local var_38_8 = (arg_38_1.hpRant - var_38_5) / 16

		AttributeType = var_1_10010

		local var_38_9 = var_38_6(var_38_8 * var_38_7[var_1_10010.Durability])

		local function var_38_10(arg_39_0, arg_39_1)
			setActive = var_2_10002

			var_2_10002(arg_39_0, true)

			setText = var_2_10002
			findTF = var_3

			var_2_10002(var_3(arg_39_0, "text"), arg_39_1)

			setTextAlpha = var_2_10002
			findTF = var_3

			var_2_10002(var_3(arg_39_0, "text"), 0)

			local var_39_0 = arg_38_0.delayCallFuncs[arg_38_1.id]

			var_39_0.isDoing = true
			parallelAsync = var_39_0

			var_39_0({
				function(arg_40_0)
					LeanTween = var_3_10001

					local var_40_0 = var_3_10001.moveY(arg_39_0, 60, 1)
					local var_40_1 = var_1.setOnComplete

					System = var_3

					var_40_1(var_40_0, var_3.Action(arg_40_0))

					return
				end,
				function(arg_41_0)
					LeanTween = var_3_10001

					local var_41_0 = var_3_10001.textAlpha

					findTF = var_3_10002

					local var_41_1 = var_41_0(var_3_10002(arg_39_0, "text"), 1, 0.3)
					local var_41_2 = var_1.setOnComplete

					System = var_3

					var_41_2(var_41_1, var_3.Action(function()
						LeanTween = var_4_10000

						local var_42_0 = var_4_10000.textAlpha

						findTF = var_4_10001

						local var_42_1 = var_42_0(var_4_10001(arg_39_0, "text"), 0, 0.5)
						local var_42_2 = var_0.setDelay(var_42_1, 0.4)
						local var_42_3 = var_0.setOnComplete

						System = var_2

						var_42_3(var_42_2, var_2.Action(arg_41_0))

						return
					end))

					return
				end
			}, function()
				local var_43_0 = arg_39_0

				Vector3 = var_3_10001
				var_43_0.localPosition = var_3_10001(0, 0, 0)

				if not arg_38_0.delayCallFuncs[arg_38_1.id] then
					return
				end

				arg_38_0.delayCallFuncs[arg_38_1.id].isDoing = false

				if #arg_38_0.delayCallFuncs[arg_38_1.id] > 0 then
					table = var_0

					var_0.remove(arg_38_0.delayCallFuncs[arg_38_1.id], 1)()
				end

				return
			end)

			return
		end

		local function var_38_11(arg_44_0)
			local var_44_0 = arg_44_0.transform.localPosition.x

			LeanTween = var_2_10002

			local var_44_1 = var_2_10002.moveX(arg_44_0, var_44_0, 0.05)
			local var_44_2 = var_2.setEase

			LeanTweenType = var_4

			local var_44_3 = var_44_2(var_44_1, var_4.easeInOutSine)

			var_2.setLoopPingPong(var_44_3, 4)

			LeanTween = var_2

			local var_44_4 = var_2.alpha

			findTF = var_44_3

			var_44_4(var_44_3(arg_44_0, "red"), 0.5, 0.4)

			LeanTween = var_44_4

			local var_44_5 = var_44_4.alpha

			findTF = var_3

			local var_44_6 = var_44_5(var_3(arg_44_0, "red"), 0, 0.4)

			var_2.setDelay(var_44_6, 0.4)

			return
		end

		if var_38_9 > 0 then
			local var_38_12 = var_38_10

			findTF = var_1_10012

			var_38_12(var_1_10012(var_38_1, "heal"), var_38_9)
		elseif var_38_9 < 0 then
			var_38_11(arg_38_2)

			local var_38_13 = var_38_10

			findTF = var_1_10012

			var_38_13(var_1_10012(var_38_1, "normal"), var_38_9)
		end
	end

	local var_38_14 = var_38_2:Find("fillarea/green")
	local var_38_15 = var_38_2:Find("fillarea/red")
	local var_38_16 = arg_38_1
	local var_38_17 = not arg_38_1.IsHpSafe(var_38_16)

	setActive = var_38_16

	var_38_16(var_38_14, not var_38_17)

	setActive = var_38_16

	var_38_16(var_38_15, var_38_17)

	local var_38_18 = var_38_2
	local var_38_19 = var_38_2.GetComponent

	typeof = var_11
	Slider = var_1_10012

	local var_38_20 = var_38_19(var_38_18, var_11(var_1_10012))

	var_38_20.fillRect = var_38_17 and var_38_15 or var_38_14
	setSlider = var_38_20

	var_38_20(var_38_2, 0, 10000, arg_38_1.hpRant)

	local var_38_21 = arg_38_2
	local var_38_22 = arg_38_2.Find(var_38_21, "agony")

	setActive = var_38_21

	var_38_21(var_38_22, var_38_17)

	local var_38_23 = arg_38_2
	local var_38_24 = arg_38_2.Find(var_38_23, "broken")

	setActive = var_38_23

	var_38_23(var_38_24, arg_38_1:IsBroken())

	return
end

function var_0_1.ShowToggleMask(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.toggleList.position

	var_45_0.x = arg_45_0.rtFleetBar.position.x

	local var_45_1 = arg_45_0.toggleList

	var_45_1.position = var_45_0
	setActive = var_45_1

	var_45_1(arg_45_0.toggleMask, true)

	local var_45_2 = arg_45_0.map
	local var_45_3 = var_3.GetNormalFleets(var_45_2)

	ipairs = var_45_2

	for iter_45_0, iter_45_1 in var_45_2(arg_45_0.toggles) do
		local var_45_4 = var_45_3[iter_45_0]

		setActive = var_1_10010

		var_1_10010(iter_45_1, var_45_4)

		if var_45_4 then
			var_1_10010 = iter_45_0 == arg_45_0.map.findex

			local var_45_5 = var_45_4
			local var_45_6 = var_45_4.GetWatchingBuff(var_45_5)

			setActive = var_45_5

			var_45_5(iter_45_1:Find("selected"), var_1_10010)

			setActive = var_45_5

			var_45_5(iter_45_1:Find("text"), not var_1_10010)

			setActive = var_45_5

			var_45_5(iter_45_1:Find("text_selected"), var_1_10010)

			setActive = var_45_5

			var_45_5(iter_45_1:Find("watching_buff"), var_45_6)

			if var_45_6 then
				if #var_45_6.config.icon > 0 then
					GetImageSpriteFromAtlasAsync = var_45_5

					local var_45_7 = "world/watchingbuff/" .. var_45_6.config.icon
					local var_45_8 = ""

					var_1_10016 = iter_45_1

					var_45_5(var_45_7, var_45_8, iter_45_1.Find(var_1_10016, "watching_buff"))
				else
					setImageSprite = var_45_5

					var_45_5(iter_45_1:Find("watching_buff"), nil)
				end
			end

			onButton = var_45_5

			local var_45_9 = arg_45_0
			local var_45_10 = iter_45_1

			local function var_45_11()
				local var_46_0 = arg_45_0

				var_0.HideToggleMask(var_46_0)
				arg_45_1(var_45_4)

				return
			end

			SFX_UI_TAG = var_1_10016

			var_45_5(var_45_9, var_45_10, var_45_11, var_1_10016)
		end
	end

	return
end

function var_0_1.HideToggleMask(arg_47_0)
	setActive = var_1_10001

	var_1_10001(arg_47_0.toggleMask, false)

	return
end

function var_0_1.Collpase(arg_48_0)
	setActive = var_1_10001

	local var_48_0 = arg_48_0.rtFleet

	isActive = var_1_10003

	var_1_10001(var_48_0, not var_1_10003(arg_48_0.rtFleet))

	var_1.x = -arg_48_0.rtArrow.localScale.x
	arg_48_0.rtArrow.localScale = var_1

	return
end

return var_0_1
