ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleFleetHead = class("CardPuzzleFleetHead")
ys.Battle.CardPuzzleFleetHead.__name = "CardPuzzleFleetHead"

function ys.Battle.CardPuzzleFleetHead.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0._mainIcon = arg_1_0._tf:Find("main/icon")
	arg_1_0._scoutIcon = arg_1_0._tf:Find("scout/icon")
	arg_1_0._testAttrContainer = arg_1_0._tf:Find("test_attr_list")
	arg_1_0._testAttrTpl = arg_1_0._tf:Find("test_attr_tpl")
	arg_1_0._testAttrList = {}
	arg_1_0._loader = AutoLoader.New()

	return
end

function ys.Battle.CardPuzzleFleetHead.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	var_0_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._info = arg_2_1

	if TEST_ATTR_PANEL then
		arg_2_0._info:RegisterEventListener(arg_2_0, var_0_2.UPDATE_FLEET_ATTR, arg_2_0.onUpdateFleetAttr)
		arg_2_0:onUpdateFleetAttr()
	end

	return
end

function ys.Battle.CardPuzzleFleetHead.Update(arg_3_0)
	return
end

function ys.Battle.CardPuzzleFleetHead.UpdateShipIcon(arg_4_0, arg_4_1)
	local var_4_0
	local var_4_1

	if arg_4_1 == TeamType.TeamPos.FLAG_SHIP then
		var_4_0 = arg_4_0._info:GetMainUnit()
		var_4_1 = arg_4_0._mainIcon
	elseif arg_4_1 == TeamType.TeamPos.LEADER then
		var_4_0 = arg_4_0._info:GetScoutUnit()
		var_4_1 = arg_4_0._scoutIcon
	end

	arg_4_0._loader:GetSprite("cardtowerselectships/" .. CardPuzzleShip.getPaintingName(var_4_0:GetTemplate().id) .. "_select", "", var_4_1)

	return
end

function ys.Battle.CardPuzzleFleetHead.UpdateShipBuff(arg_5_0)
	return
end

function ys.Battle.CardPuzzleFleetHead.onUpdateFleetAttr(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._info:GetAttrManager()._attrList) do
		local var_6_1

		if arg_6_0._testAttrList[iter_6_0] == nil then
			local var_6_0 = cloneTplTo(arg_6_0._testAttrTpl, arg_6_0._testAttrContainer)

			arg_6_0._testAttrList[iter_6_0] = var_6_0

			setText(var_6_0:Find("name"), iter_6_0)

			var_6_1 = arg_6_0._info:GetAttrManager():GetCurrent(iter_6_0)
		end

		setText(arg_6_0._testAttrList[iter_6_0]:Find("value"), var_6_1)
	end

	return
end

function ys.Battle.CardPuzzleFleetHead.updateHPBar(arg_7_0)
	return
end

function ys.Battle.CardPuzzleFleetHead.Dispose(arg_8_0)
	arg_8_0._mainIcon = nil
	arg_8_0._scoutIcon = nil
	arg_8_0._testAttrContainer = nil
	arg_8_0._testAttrTpl = nil
	arg_8_0._testAttrList = nil

	arg_8_0._loader:Clear()

	return
end

return
