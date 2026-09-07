local IslandBaseStep = class("IslandBaseStep")

function IslandBaseStep:Ctor(arg_1_1, arg_1_2)
	self.script = arg_1_2
	self.unitId = 0
	self.unitType = IslandConst.UNIT_LIST_OBJ
	self.characterId = arg_1_1.characterId or 0
	self.animation = arg_1_1.animation
	self.say = arg_1_1.say or ""
	self.actorName = arg_1_1.actorName
	self.withoutName = defaultValue(arg_1_1.withoutName, false)
	self.withoutIcon = defaultValue(arg_1_1.withoutIcon, false)
	self.customIcon = arg_1_1.actorIcon

	return
end

function IslandBaseStep:IsHideIcon()
	return self.withoutIcon
end

function IslandBaseStep:IsHideName()
	return self.withoutName
end

function IslandBaseStep:IsSameBranch(arg_4_1)
	return true
end

function IslandBaseStep:IsPlayer()
	return not self.unitId or self.unitId == 0
end

function IslandBaseStep:GetActorIcon()
	if self.customIcon then
		return pg.island_unit_character[self.customIcon].IslandShipIcon
	end

	if self:IsPlayer() then
		return "0"
	end

	local var_6_0 = pg.island_unit_character[self.characterId]

	if not pg.island_unit_character[self.characterId] then
		return "mingshi"
	end

	return var_6_0.IslandShipIcon
end

function IslandBaseStep:GetActorName()
	if self.actorName then
		return self.actorName
	end

	if self:IsPlayer() then
		if getProxy(PlayerProxy) then
			return getProxy(PlayerProxy):getRawData().name
		else
			return i18n("island_commander")
		end
	end

	local var_7_0 = pg.island_unit_character[self.characterId]

	if not pg.island_unit_character[self.characterId] then
		return ""
	end

	return (HXSet.hxLan(var_7_0.name))
end

function IslandBaseStep:GetUnitData()
	return self:GenUnitData(self.unitId, self.unitType)
end

function IslandBaseStep:GenUnitData(arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		return {
			id = arg_9_1,
			type = IslandConst.UNIT_LIST_PLAYER,
			key = IslandConst.UNIT_LIST_PLAYER .. "_" .. arg_9_1
		}
	else
		return {
			id = arg_9_1,
			type = arg_9_2,
			key = arg_9_2 .. "_" .. arg_9_1
		}
	end

	return
end

function IslandBaseStep:GetAnimation()
	return self.animation
end

function IslandBaseStep:ExistAnimation()
	return self.animation ~= nil and self.animation ~= ""
end

function IslandBaseStep:GetSay()
	return (HXSet.hxLan(self.say))
end

return IslandBaseStep
