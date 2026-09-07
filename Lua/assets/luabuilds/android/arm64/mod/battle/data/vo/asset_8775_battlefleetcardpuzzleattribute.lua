ys = ys or {}

local var_0_6 = ys.Battle.BattleCardPuzzleConfig
local BattleFleetCardPuzzleAttribute = class("BattleFleetCardPuzzleAttribute")

ys.Battle.BattleFleetCardPuzzleAttribute = BattleFleetCardPuzzleAttribute
BattleFleetCardPuzzleAttribute.__name = "BattleFleetCardPuzzleAttribute"

function BattleFleetCardPuzzleAttribute:Ctor(arg_1_1)
	self:init()

	self._client = arg_1_1

	return
end

function BattleFleetCardPuzzleAttribute:init()
	self._buffAttr = {}
	self._attrList = {}
	self._clampList = {}

	return
end

function BattleFleetCardPuzzleAttribute:AddBaseAttr(arg_3_1, arg_3_2)
	self._attrList[arg_3_1] = math.max(0, arg_3_2 + (self._attrList[arg_3_1] or 0))
	self._attrList[arg_3_1] = self:checkClamp(arg_3_1)

	self._client:DispatchUpdateAttr(arg_3_1)
	self:specificAttrUpdate(arg_3_1)

	return
end

function BattleFleetCardPuzzleAttribute:SetAttr(arg_4_1, arg_4_2)
	self._attrList[arg_4_1] = arg_4_2
	self._attrList[arg_4_1] = self:checkClamp(arg_4_1)

	self._client:DispatchUpdateAttr(arg_4_1)
	self:specificAttrUpdate(arg_4_1)

	return
end

function BattleFleetCardPuzzleAttribute:specificAttrUpdate(arg_5_1)
	if arg_5_1 == "BaseEnergyBoostRate" or arg_5_1 == "BaseEnergyBoostExtra" then
		self._client:FlushHandOverheat()
	end

	return
end

function BattleFleetCardPuzzleAttribute:checkClamp(arg_6_1)
	if self._attrList[arg_6_1] == nil then
		return
	end

	local var_6_0 = self._attrList[arg_6_1]

	if var_0_6.FleetAttrClamp[arg_6_1] then
		var_6_0 = math.max(var_6_0, self._attrList[var_0_6.FleetAttrClamp[arg_6_1].min] or 0)
		var_6_0 = self._attrList[var_0_6.FleetAttrClamp[arg_6_1].max] and math.min(var_6_0, self._attrList[var_0_6.FleetAttrClamp[arg_6_1].max]) or var_6_0
	end

	return var_6_0
end

function BattleFleetCardPuzzleAttribute:GetCurrent(arg_7_1)
	return self._attrList[arg_7_1] or 0
end

return
