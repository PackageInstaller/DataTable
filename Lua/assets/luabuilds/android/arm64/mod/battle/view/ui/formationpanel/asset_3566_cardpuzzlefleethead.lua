ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleFleetHead = class("CardPuzzleFleetHead")
ys.Battle.CardPuzzleFleetHead.__name = "CardPuzzleFleetHead"

function ys.Battle.CardPuzzleFleetHead:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = self._go.transform
	self._mainIcon = self._tf:Find("main/icon")
	self._scoutIcon = self._tf:Find("scout/icon")
	self._testAttrContainer = self._tf:Find("test_attr_list")
	self._testAttrTpl = self._tf:Find("test_attr_tpl")
	self._testAttrList = {}
	self._loader = AutoLoader.New()

	return
end

function ys.Battle.CardPuzzleFleetHead:SetCardPuzzleComponent(arg_2_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._info = arg_2_1

	if TEST_ATTR_PANEL then
		self._info:RegisterEventListener(self, var_0_2.UPDATE_FLEET_ATTR, self.onUpdateFleetAttr)
		self:onUpdateFleetAttr()
	end

	return
end

function ys.Battle.CardPuzzleFleetHead.Update(arg_3_0)
	return
end

function ys.Battle.CardPuzzleFleetHead:UpdateShipIcon(arg_4_1)
	local var_4_0
	local var_4_1

	if arg_4_1 == TeamType.TeamPos.FLAG_SHIP then
		var_4_0 = self._info:GetMainUnit()
		var_4_1 = self._mainIcon
	elseif arg_4_1 == TeamType.TeamPos.LEADER then
		var_4_0 = self._info:GetScoutUnit()
		var_4_1 = self._scoutIcon
	end

	self._loader:GetSprite("cardtowerselectships/" .. CardPuzzleShip.getPaintingName(var_4_0:GetTemplate().id) .. "_select", "", var_4_1)

	return
end

function ys.Battle.CardPuzzleFleetHead.UpdateShipBuff(arg_5_0)
	return
end

function ys.Battle.CardPuzzleFleetHead:onUpdateFleetAttr()
	for iter_6_0, iter_6_1 in pairs(self._info:GetAttrManager()._attrList) do
		local var_6_1

		if self._testAttrList[iter_6_0] == nil then
			local var_6_0 = cloneTplTo(self._testAttrTpl, self._testAttrContainer)

			self._testAttrList[iter_6_0] = var_6_0

			setText(var_6_0:Find("name"), iter_6_0)

			var_6_1 = self._info:GetAttrManager():GetCurrent(iter_6_0)
		end

		setText(self._testAttrList[iter_6_0]:Find("value"), var_6_1)
	end

	return
end

function ys.Battle.CardPuzzleFleetHead.updateHPBar(arg_7_0)
	return
end

function ys.Battle.CardPuzzleFleetHead:Dispose()
	self._mainIcon = nil
	self._scoutIcon = nil
	self._testAttrContainer = nil
	self._testAttrTpl = nil
	self._testAttrList = nil

	self._loader:Clear()

	return
end

return
