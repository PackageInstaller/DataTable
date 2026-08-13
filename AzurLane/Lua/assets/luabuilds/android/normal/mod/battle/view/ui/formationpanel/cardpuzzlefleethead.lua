ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleFleetHead = var_0_10004("CardPuzzleFleetHead")

local var_0_4 = var_0.Battle.CardPuzzleFleetHead

var_0_4.__name = "CardPuzzleFleetHead"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._mainIcon = var_2.Find(var_1_0, "main/icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0._scoutIcon = var_2.Find(var_1_1, "scout/icon")

	local var_1_2 = arg_1_0._tf

	arg_1_0._testAttrContainer = var_2.Find(var_1_2, "test_attr_list")

	local var_1_3 = arg_1_0._tf

	arg_1_0._testAttrTpl = var_2.Find(var_1_3, "test_attr_tpl")
	arg_1_0._testAttrList = {}
	AutoLoader = var_2
	arg_1_0._loader = var_2.New()

	return
end

function var_0_4.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	var_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._info = arg_2_1
	TEST_ATTR_PANEL = var_2

	if var_2 then
		local var_2_0 = arg_2_0._info

		var_2.RegisterEventListener(var_2_0, arg_2_0, var_0_2.UPDATE_FLEET_ATTR, arg_2_0.onUpdateFleetAttr)
		arg_2_0:onUpdateFleetAttr()
	end

	return
end

function var_0_4.Update(arg_3_0)
	return
end

function var_0_4.UpdateShipIcon(arg_4_0, arg_4_1)
	local var_4_0
	local var_4_1

	TeamType = var_1_10004

	if arg_4_1 == var_1_10004.TeamPos.FLAG_SHIP then
		local var_4_2 = arg_4_0._info

		var_4_0 = var_4.GetMainUnit(var_4_2)
		var_4_1 = arg_4_0._mainIcon
	else
		TeamType = var_4

		if arg_4_1 == var_4.TeamPos.LEADER then
			local var_4_3 = arg_4_0._info

			var_4_0 = var_4.GetScoutUnit(var_4_3)
			var_4_1 = arg_4_0._scoutIcon
		end
	end

	CardPuzzleShip = var_4

	local var_4_4 = var_4.getPaintingName(var_4_0:GetTemplate().id)
	local var_4_5 = arg_4_0._loader

	var_5.GetSprite(var_4_5, "cardtowerselectships/" .. var_4_4 .. "_select", "", var_4_1)

	return
end

function var_0_4.UpdateShipBuff(arg_5_0)
	return
end

function var_0_4.onUpdateFleetAttr(arg_6_0)
	local var_6_0 = arg_6_0._info
	local var_6_1 = var_1.GetAttrManager(var_6_0)._attrList

	pairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		if arg_6_0._testAttrList[iter_6_0] == nil then
			cloneTplTo = var_7

			local var_6_2 = var_7(arg_6_0._testAttrTpl, arg_6_0._testAttrContainer)
			local var_6_3 = arg_6_0._testAttrList

			var_6_3[iter_6_0] = var_6_2
			setText = var_6_3

			var_6_3(var_6_2:Find("name"), iter_6_0)
		end

		local var_6_4 = arg_6_0._testAttrList[iter_6_0]
		local var_6_5 = arg_6_0._info
		local var_6_6 = var_8.GetAttrManager(var_6_5)
		local var_6_7 = var_8.GetCurrent(var_6_6, iter_6_0)

		setText = var_6_6

		var_6_6(var_6_4:Find("value"), var_6_7)
	end

	return
end

function var_0_4.updateHPBar(arg_7_0)
	return
end

function var_0_4.Dispose(arg_8_0)
	arg_8_0._mainIcon = nil
	arg_8_0._scoutIcon = nil
	arg_8_0._testAttrContainer = nil
	arg_8_0._testAttrTpl = nil
	arg_8_0._testAttrList = nil

	local var_8_0 = arg_8_0._loader

	var_1.Clear(var_8_0)

	return
end

return
