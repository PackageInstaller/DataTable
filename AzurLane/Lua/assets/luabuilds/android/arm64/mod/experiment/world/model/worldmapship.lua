class = var_0_10000

local var_0_0 = "WorldMapShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	hpRant = "number",
	buffs = "table",
	fleetId = "number",
	triggers = "table",
	id = "number"
}
var_0_1.EventHpRantChange = "WorldMapShip.EventHpRantChange"
var_0_1.EventUpdateBuff = "WorldMapShip.EventUpdateBuff"
var_0_1.EventUpdateBroken = "WorldMapShip.EventUpdateBroken"

function var_0_1.Build(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.hpRant = 10000
	arg_1_0.buffs = {}
	arg_1_0.triggers = {}

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.hpRant = arg_2_1.hp_rant
	WorldConst = var_2
	arg_2_0.buffs = var_2.ParsingBuffs(arg_2_1.buff_list)

	return
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_1.GetImportWorldShipVO(arg_4_0)
	setmetatable = var_1_10001

	local var_4_0 = {
		triggers = arg_4_0.triggers,
		isBroken = arg_4_0:IsBroken(),
		IsBenefitSkillActive = function(arg_5_0, arg_5_1)
			local var_5_0 = false
			local var_5_1 = arg_5_1.type

			Ship = var_2_10004

			if var_5_1 == var_2_10004.BENEFIT_SKILL then
				if not arg_5_0.isBroken and (not arg_5_1.limit[1] or arg_5_1.limit[1] == arg_5_0.triggers.TeamNumbers) then
					var_5_0 = true
				end
			else
				local var_5_2 = arg_5_1.type

				Ship = var_4

				local var_5_4

				if var_5_2 == var_4.BENEFIT_EQUIP then
					local var_5_3 = arg_5_1.limit

					var_5_4 = arg_5_0:getAllEquipments()
					ipairs = var_2_10005

					for iter_5_0, iter_5_1 in var_2_10005(var_5_4) do
						if iter_5_1 then
							table = var_2_10010

							if var_2_10010.contains(var_5_3, iter_5_1:getConfig("id")) then
								var_5_0 = true

								break
							end
						end
					end
				else
					local var_5_5 = arg_5_1.type

					Ship = var_5_4

					if var_5_5 == var_5_4.BENEFIT_MAP_AURA then
						var_5_0 = not arg_5_0.isBroken
					else
						local var_5_6 = arg_5_1.type

						Ship = var_4

						if var_5_6 == var_4.BENEFIT_AID then
							var_5_0 = not arg_5_0.isBroken
						end
					end
				end
			end

			return var_5_0
		end,
		GetStaminaDiscount = function(arg_6_0, arg_6_1)
			local var_6_0 = 0

			WorldConst = var_2_10003

			if arg_6_1 == var_2_10003.OpReqSub then
				pairs = var_3

				for iter_6_0, iter_6_1 in var_3(arg_6_0:getAllSkills()) do
					tonumber = var_2_10008

					local var_6_1 = iter_6_0

					string = var_2_10011
					var_2_10008 = var_2_10008(var_6_1 .. var_2_10011.format("%.2d", iter_6_1.level))
					pg = var_2_10009

					if var_2_10009.skill_benefit_template[var_2_10008] and arg_6_0:IsBenefitSkillActive(var_2_10009) then
						local var_6_2 = var_2_10009.type

						Ship = var_2_10011

						if var_6_2 ~= var_2_10011.BENEFIT_EQUIP then
							var_6_2 = var_2_10009.type
							Ship = var_2_10011

							if var_6_2 == var_2_10011.BENEFIT_SKILL then
								defaultValue = var_6_2
								var_6_0 = var_6_0 + var_6_2(var_2_10009.world_extra_effect[1], 0)
							end
						end
					end
				end
			end

			return var_6_0
		end
	}
	local var_4_1 = {}

	WorldConst = var_1_10005
	var_4_1.__index = var_1_10005.FetchRawShipVO(arg_4_0.id)

	return var_1_10001(var_4_0, var_4_1)
end

function var_0_1.UpdateHpRant(arg_7_0, arg_7_1)
	if arg_7_0.hpRant ~= arg_7_1 then
		arg_7_0.hpRant = arg_7_1

		arg_7_0:DispatchEvent(var_0_1.EventHpRantChange)
	end

	return
end

function var_0_1.IsValid(arg_8_0)
	tobool = var_1_10001
	WorldConst = var_1_10003

	return var_1_10001(var_1_10003.FetchRawShipVO(arg_8_0.id))
end

function var_0_1.IsAlive(arg_9_0)
	return arg_9_0.hpRant > 0
end

function var_0_1.IsHpFull(arg_10_0)
	return arg_10_0.hpRant == 16
end

function var_0_1.IsHpSafe(arg_11_0)
	return arg_11_0.hpRant >= 3000
end

function var_0_1.GetBuffList(arg_12_0)
	underscore = var_1_10001

	local var_12_0 = var_1_10001.filter

	underscore = var_1_10003

	local var_12_1 = var_12_0(var_1_10003.values(arg_12_0.buffs), function(arg_13_0)
		return arg_13_0:GetFloor() > 0
	end)
	local var_12_4

	if arg_12_0.fleetId then
		nowWorld = var_12_4

		local var_12_2 = var_12_4()
		local var_12_3 = var_12_4.GetFleet(var_12_2, arg_12_0.fleetId)

		var_12_4 = var_12_4.GetDamageBuff(var_12_3)
	end

	if var_12_4 then
		table = var_3

		var_3.insert(var_12_1, var_12_4)
	end

	return var_12_1
end

function var_0_1.GetBuff(arg_14_0, arg_14_1)
	if not arg_14_0.buffs[arg_14_1] then
		local var_14_0 = arg_14_0.buffs

		WorldBuff = var_1_10003
		var_14_0[arg_14_1] = var_1_10003.New()

		local var_14_1 = arg_14_0.buffs[arg_14_1]

		var_2.Setup(var_14_1, {
			floor = 0,
			id = arg_14_1
		})
	end

	return arg_14_0.buffs[arg_14_1]
end

function var_0_1.AddBuff(arg_15_0, arg_15_1, arg_15_2)
	assert = var_1_10003

	var_1_10003(arg_15_1 and arg_15_2)

	local var_15_0 = arg_15_0:GetBuff(arg_15_1)

	var_3.AddFloor(var_15_0, arg_15_2)

	WorldConst = var_4

	if arg_15_1 == var_4.BrokenBuffId then
		arg_15_0:DispatchEvent(var_0_1.EventUpdateBroken)
	end

	arg_15_0:DispatchEvent(var_0_1.EventUpdateBuff)

	return
end

function var_0_1.RemoveBuff(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:GetBuff(arg_16_1)

	if arg_16_2 then
		var_16_0:AddFloor(arg_16_2 * -1)
	else
		var_1_10004 = arg_16_0.buffs
		var_1_10004[arg_16_1] = nil
	end

	WorldConst = var_1_10004

	if arg_16_1 == var_1_10004.BrokenBuffId then
		arg_16_0:DispatchEvent(var_0_1.EventUpdateBroken)
	end

	arg_16_0:DispatchEvent(var_0_1.EventUpdateBuff)

	return
end

function var_0_1.IsBuffMax(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetBuff(arg_17_1)
	local var_17_1 = var_2.GetFloor(var_17_0)

	WorldBuff = var_1_10003

	return var_17_1 >= var_1_10003.GetTemplate(arg_17_1).buff_maxfloor
end

function var_0_1.Rebirth(arg_18_0)
	assert = var_1_10001

	var_1_10001(arg_18_0.hpRant <= 0)

	pg = var_1_10001

	local var_18_0 = var_1_10001.gameset.world_death_hpfix.key_value

	arg_18_0:UpdateHpRant(var_18_0)

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.AddBuff

	WorldConst = var_5

	var_18_2(var_18_1, var_5.BrokenBuffId, 1)

	return
end

function var_0_1.Repair(arg_19_0)
	arg_19_0:UpdateHpRant(10000)

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.RemoveBuff

	WorldConst = var_4

	var_19_1(var_19_0, var_4.BrokenBuffId)

	return
end

function var_0_1.Regenerate(arg_20_0, arg_20_1)
	math = var_1_10002

	local var_20_0 = var_1_10002.min(10000, arg_20_0.hpRant + arg_20_1)

	arg_20_0:UpdateHpRant(var_20_0)

	return
end

function var_0_1.RegenerateValue(arg_21_0, arg_21_1)
	math = var_1_10002

	local var_21_0 = var_1_10002.floor

	WorldConst = var_1_10004

	local var_21_1 = var_1_10004.FetchShipVO(arg_21_0.id)
	local var_21_2 = var_4.getProperties(var_21_1, nil, true, false)

	AttributeType = var_1_10005

	local var_21_3 = var_21_0(arg_21_1 / var_21_2[var_1_10005.Durability] * 16)

	math = var_1_10003

	local var_21_4 = var_1_10003.min(10000, arg_21_0.hpRant + var_21_3)

	arg_21_0:UpdateHpRant(var_21_4)

	return
end

function var_0_1.IsBroken(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.GetBuff

	WorldConst = var_1_10004

	local var_22_2 = var_22_1(var_22_0, var_1_10004.BrokenBuffId)

	return var_1.GetFloor(var_22_2) > 0
end

function var_0_1.GetShipBuffProperties(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = {}

	if arg_23_0.fleetId then
		nowWorld = var_3

		local var_23_2 = var_3()
		local var_23_3 = var_3.GetFleet(var_23_2, arg_23_0.fleetId)
		local var_23_4

		if not var_3.GetBuffList(var_23_3) then
			var_23_4 = {}
		end

		WorldConst = var_1_10004

		var_1_10004.AppendPropertiesFromBuffList(var_23_0, var_23_1, var_23_4)

		return var_23_0, var_23_1
	end
end

function var_0_1.GetShipPowerBuffProperties(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = arg_24_0:GetBuffList()

	WorldConst = var_1_10003

	var_1_10003.ExtendPropertiesRatesFromBuffList(var_24_0, var_24_1)

	return var_24_0
end

return var_0_1
