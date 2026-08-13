class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseStep")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.script = arg_1_2
	arg_1_0.unitId = 0
	IslandConst = var_3
	arg_1_0.unitType = var_3.UNIT_LIST_OBJ

	local var_1_0

	if not arg_1_1.characterId then
		var_1_0 = 0
	end

	arg_1_0.characterId = var_1_0
	arg_1_0.animation = arg_1_1.animation

	local var_1_1

	if not arg_1_1.say then
		var_1_1 = ""
	end

	arg_1_0.say = var_1_1
	arg_1_0.actorName = arg_1_1.actorName
	defaultValue = var_3
	arg_1_0.withoutName = var_3(arg_1_1.withoutName, false)
	defaultValue = var_3
	arg_1_0.withoutIcon = var_3(arg_1_1.withoutIcon, false)
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
		pg = var_1

		return var_1.island_unit_character[arg_6_0.customIcon].IslandShipIcon
	end

	if arg_6_0:IsPlayer() then
		return "0"
	end

	pg = var_1

	if not var_1.island_unit_character[arg_6_0.characterId] then
		return "mingshi"
	end

	return var_1.IslandShipIcon
end

function var_0_0.GetActorName(arg_7_0)
	if arg_7_0.actorName then
		return arg_7_0.actorName
	end

	local var_7_0 = arg_7_0

	if arg_7_0.IsPlayer(var_7_0) then
		getProxy = var_1
		PlayerProxy = var_7_0

		if var_1(var_7_0) then
			getProxy = var_1
			PlayerProxy = var_7_0

			local var_7_1 = var_1(var_7_0)

			return var_1.getRawData(var_7_1).name
		else
			i18n = var_1

			return var_1("island_commander")
		end
	end

	pg = var_1

	if not var_1.island_unit_character[arg_7_0.characterId] then
		return ""
	end

	HXSet = var_2

	return (var_2.hxLan(var_1.name))
end

function var_0_0.GetUnitData(arg_8_0)
	return arg_8_0:GenUnitData(arg_8_0.unitId, arg_8_0.unitType)
end

function var_0_0.GenUnitData(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		local var_9_0 = {
			id = arg_9_1
		}

		IslandConst = var_1_10004
		var_9_0.type = var_1_10004.UNIT_LIST_PLAYER
		IslandConst = var_4
		var_9_0.key = var_4.UNIT_LIST_PLAYER .. "_" .. arg_9_1

		return var_9_0
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
	HXSet = var_1_10001

	return (var_1_10001.hxLan(arg_12_0.say))
end

return var_0_0
