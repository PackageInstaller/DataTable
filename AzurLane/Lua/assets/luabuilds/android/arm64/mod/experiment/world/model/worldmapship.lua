local var_0_0 = class("WorldMapShip", import("...BaseEntity"))

var_0_0.Fields = {
	hpRant = "number",
	buffs = "table",
	fleetId = "number",
	triggers = "table",
	id = "number"
}
var_0_0.EventHpRantChange = "WorldMapShip.EventHpRantChange"
var_0_0.EventUpdateBuff = "WorldMapShip.EventUpdateBuff"
var_0_0.EventUpdateBroken = "WorldMapShip.EventUpdateBroken"

function var_0_0.Build(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.hpRant = 10000
	arg_1_0.buffs = {}
	arg_1_0.triggers = {}

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.hpRant = arg_2_1.hp_rant
	arg_2_0.buffs = WorldConst.ParsingBuffs(arg_2_1.buff_list)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_0.GetImportWorldShipVO(arg_4_0)
	return setmetatable({
		triggers = arg_4_0.triggers,
		isBroken = arg_4_0:IsBroken(),
		IsBenefitSkillActive = function(arg_5_0, arg_5_1)
			local var_5_0 = false

			if arg_5_1.type == Ship.BENEFIT_SKILL then
				if not arg_5_0.isBroken and (not arg_5_1.limit[1] or arg_5_1.limit[1] == arg_5_0.triggers.TeamNumbers) then
					var_5_0 = true
				end
			elseif arg_5_1.type == Ship.BENEFIT_EQUIP then
				for iter_5_0, iter_5_1 in ipairs((arg_5_0:getAllEquipments())) do
					if iter_5_1 and table.contains(arg_5_1.limit, iter_5_1:getConfig("id")) then
						var_5_0 = true

						break
					end
				end
			elseif arg_5_1.type == Ship.BENEFIT_MAP_AURA then
				var_5_0 = not arg_5_0.isBroken
			elseif arg_5_1.type == Ship.BENEFIT_AID then
				var_5_0 = not arg_5_0.isBroken
			end

			return var_5_0
		end,
		GetStaminaDiscount = function(arg_6_0, arg_6_1)
			local var_6_0 = 0

			if arg_6_1 == WorldConst.OpReqSub then
				for iter_6_0, iter_6_1 in pairs(arg_6_0:getAllSkills()) do
					local var_6_1 = pg.skill_benefit_template[tonumber(iter_6_0 .. string.format("%.2d", iter_6_1.level))]

					if var_6_1 and arg_6_0:IsBenefitSkillActive(var_6_1) and (var_6_1.type == Ship.BENEFIT_EQUIP or var_6_1.type == Ship.BENEFIT_SKILL) then
						var_6_0 = var_6_0 + defaultValue(var_6_1.world_extra_effect[1], 0)
					end
				end
			end

			return var_6_0
		end
	}, {
		__index = WorldConst.FetchRawShipVO(arg_4_0.id)
	})
end

function var_0_0.UpdateHpRant(arg_7_0, arg_7_1)
	if arg_7_0.hpRant ~= arg_7_1 then
		arg_7_0.hpRant = arg_7_1

		arg_7_0:DispatchEvent(var_0_0.EventHpRantChange)
	end

	return
end

function var_0_0.IsValid(arg_8_0)
	return tobool(WorldConst.FetchRawShipVO(arg_8_0.id))
end

function var_0_0.IsAlive(arg_9_0)
	return arg_9_0.hpRant > 0
end

function var_0_0.IsHpFull(arg_10_0)
	return arg_10_0.hpRant == 16
end

function var_0_0.IsHpSafe(arg_11_0)
	return arg_11_0.hpRant >= 3000
end

function var_0_0.GetBuffList(arg_12_0)
	local var_12_0 = underscore.filter(underscore.values(arg_12_0.buffs), function(arg_13_0)
		return arg_13_0:GetFloor() > 0
	end)
	local var_12_1 = arg_12_0.fleetId and nowWorld():GetFleet(arg_12_0.fleetId):GetDamageBuff()

	if var_12_1 then
		table.insert(var_12_0, var_12_1)
	end

	return var_12_0
end

function var_0_0.GetBuff(arg_14_0, arg_14_1)
	if not arg_14_0.buffs[arg_14_1] then
		arg_14_0.buffs[arg_14_1] = WorldBuff.New()

		arg_14_0.buffs[arg_14_1]:Setup({
			floor = 0,
			id = arg_14_1
		})
	end

	return arg_14_0.buffs[arg_14_1]
end

function var_0_0.AddBuff(arg_15_0, arg_15_1, arg_15_2)
	assert(arg_15_1 and arg_15_2)
	arg_15_0:GetBuff(arg_15_1):AddFloor(arg_15_2)

	if arg_15_1 == WorldConst.BrokenBuffId then
		arg_15_0:DispatchEvent(var_0_0.EventUpdateBroken)
	end

	arg_15_0:DispatchEvent(var_0_0.EventUpdateBuff)

	return
end

function var_0_0.RemoveBuff(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		arg_16_0:GetBuff(arg_16_1):AddFloor(arg_16_2 * -1)
	else
		arg_16_0.buffs[arg_16_1] = nil
	end

	if arg_16_1 == WorldConst.BrokenBuffId then
		arg_16_0:DispatchEvent(var_0_0.EventUpdateBroken)
	end

	arg_16_0:DispatchEvent(var_0_0.EventUpdateBuff)

	return
end

function var_0_0.IsBuffMax(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetBuff(arg_17_1)

	return var_17_0:GetFloor() >= WorldBuff.GetTemplate(arg_17_1).buff_maxfloor
end

function var_0_0.Rebirth(arg_18_0)
	assert(arg_18_0.hpRant <= 0)
	arg_18_0:UpdateHpRant(pg.gameset.world_death_hpfix.key_value)
	arg_18_0:AddBuff(WorldConst.BrokenBuffId, 1)

	return
end

function var_0_0.Repair(arg_19_0)
	arg_19_0:UpdateHpRant(10000)
	arg_19_0:RemoveBuff(WorldConst.BrokenBuffId)

	return
end

function var_0_0.Regenerate(arg_20_0, arg_20_1)
	arg_20_0:UpdateHpRant((math.min(10000, arg_20_0.hpRant + arg_20_1)))

	return
end

function var_0_0.RegenerateValue(arg_21_0, arg_21_1)
	arg_21_0:UpdateHpRant((math.min(10000, arg_21_0.hpRant + math.floor(arg_21_1 / WorldConst.FetchShipVO(arg_21_0.id):getProperties(nil, true, false)[AttributeType.Durability] * 16))))

	return
end

function var_0_0.IsBroken(arg_22_0)
	local var_22_0 = arg_22_0:GetBuff(WorldConst.BrokenBuffId)

	return var_22_0:GetFloor() > 0
end

function var_0_0.GetShipBuffProperties(arg_23_0)
	local var_23_0 = {}

	if arg_23_0.fleetId then
		local var_23_1 = nowWorld():GetFleet(arg_23_0.fleetId):GetBuffList() or {}

		WorldConst.AppendPropertiesFromBuffList({}, var_23_0, var_23_1)

		return {}, var_23_0
	end
end

function var_0_0.GetShipPowerBuffProperties(arg_24_0)
	WorldConst.ExtendPropertiesRatesFromBuffList({}, (arg_24_0:GetBuffList()))

	return {}
end

return var_0_0
