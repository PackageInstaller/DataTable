local var_0_0 = class("IslandBaseStep")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.script = arg_1_2
	arg_1_0.unitId = 0
	arg_1_0.unitType = IslandConst.UNIT_LIST_OBJ
	arg_1_0.characterId = arg_1_1.characterId or 0
	arg_1_0.animation = arg_1_1.animation
	arg_1_0.say = arg_1_1.say or ""
	arg_1_0.actorName = arg_1_1.actorName
	arg_1_0.withoutName = defaultValue(arg_1_1.withoutName, false)
	arg_1_0.withoutIcon = defaultValue(arg_1_1.withoutIcon, false)
	arg_1_0.customIcon = arg_1_1.actorIcon

	return
end

function var_0_0.IsHideIcon(arg_2_0)
	return arg_2_0.withoutIcon
end

function var_0_0.IsHideName(arg_3_0)
	return arg_3_0.withoutName
end

function var_0_0.IsSameBranch(arg_4_0, arg_4_1)
	return true
end

function var_0_0.IsPlayer(arg_5_0)
	return not arg_5_0.unitId or arg_5_0.unitId == 0
end

function var_0_0.GetActorIcon(arg_6_0)
	if arg_6_0.customIcon then
		return pg.island_unit_character[arg_6_0.customIcon].IslandShipIcon
	end

	if arg_6_0:IsPlayer() then
		return "0"
	end

	local var_6_0 = pg.island_unit_character[arg_6_0.characterId]

	if not pg.island_unit_character[arg_6_0.characterId] then
		return "mingshi"
	end

	return var_6_0.IslandShipIcon
end

function var_0_0.GetActorName(arg_7_0)
	if arg_7_0.actorName then
		return arg_7_0.actorName
	end

	if arg_7_0:IsPlayer() then
		if getProxy(PlayerProxy) then
			return getProxy(PlayerProxy):getRawData().name
		else
			return i18n("island_commander")
		end
	end

	local var_7_0 = pg.island_unit_character[arg_7_0.characterId]

	if not pg.island_unit_character[arg_7_0.characterId] then
		return ""
	end

	return (HXSet.hxLan(var_7_0.name))
end

function var_0_0.GetUnitData(arg_8_0)
	return arg_8_0:GenUnitData(arg_8_0.unitId, arg_8_0.unitType)
end

function var_0_0.GenUnitData(arg_9_0, arg_9_1, arg_9_2)
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

function var_0_0.GetAnimation(arg_10_0)
	return arg_10_0.animation
end

function var_0_0.ExistAnimation(arg_11_0)
	return arg_11_0.animation ~= nil and arg_11_0.animation ~= ""
end

function var_0_0.GetSay(arg_12_0)
	return (HXSet.hxLan(arg_12_0.say))
end

return var_0_0
