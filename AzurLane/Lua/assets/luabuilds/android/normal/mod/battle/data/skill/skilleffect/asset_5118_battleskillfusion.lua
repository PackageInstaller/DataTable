ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleAttr
local var_0_2 = var_0.Battle.BattleTargetChoise
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleSkillFusion = var_0_10004("BattleSkillFusion", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillFusion.__name = "BattleSkillFusion"

local var_0_4 = var_0.Battle.BattleSkillFusion
local var_0_5 = {}

Vector3 = var_5
var_0_5[1] = var_5(-10000, 0, 58)
Vector3 = var_5

local var_0_6 = var_5(10000, 0, 58)

var_0_5[-1] = var_0_6
var_0_4.FREEZE_POS = var_0_5

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_4.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fusionUnitTempID = arg_1_0._tempData.arg_list.fusion_id
	arg_1_0._fusionUnitSkinID = arg_1_0._tempData.arg_list.ship_skin_id
	arg_1_0._elementTagList = arg_1_0._tempData.arg_list.element_tag_list
	arg_1_0._attrInheritList = arg_1_0._tempData.arg_list.attr_inherit_list
	arg_1_0._fusionUnitEquipmentList = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_0._tempData.arg_list.weapon_id_list) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0._fusionUnitEquipmentList, {
			id = iter_1_1,
			equipment = {
				weapon_id = {
					iter_1_1
				}
			}
		})
	end

	arg_1_0._fusionUnitSkillList = {}
	ipairs = var_3

	for iter_1_2, iter_1_3 in var_3(arg_1_0._tempData.arg_list.buff_list) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0._fusionUnitSkillList, {
			id = iter_1_3,
			level = arg_1_0._level
		})
	end

	arg_1_0._duration = arg_1_0._tempData.arg_list.duration

	return
end

function var_0_4.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:doFusion(arg_2_1)

	return
end

function var_0_4.DoDataEffectWithoutTarget(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:doFusion(arg_3_1)

	return
end

function var_0_4.doFusion(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2.TargetAllHelp(arg_4_1)
	local var_4_1 = var_0_2.TargetShipTag(arg_4_1, {
		ship_tag_list = arg_4_0._elementTagList
	}, var_4_0)
	local var_4_2 = {}

	ipairs = var_5
	Ship = var_6

	for iter_4_0, iter_4_1 in var_5(var_6.PROPERTIES) do
		var_4_2[iter_4_1] = 1
	end

	local var_4_3 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_4 = {
		shipGS = 1,
		name = "123",
		id = arg_4_1.id,
		tmpID = arg_4_0._fusionUnitTempID,
		skinId = arg_4_0._fusionUnitSkinID,
		level = var_0_1.GetCurrent(arg_4_1, "formulaLevel"),
		equipment = arg_4_0._fusionUnitEquipmentList,
		properties = var_4_2,
		baseProperties = var_4_2,
		proficiency = {
			1,
			1,
			1
		},
		rarity = arg_4_1:GetRarity(),
		intimacy = arg_4_1:GetIntimacy(),
		skills = arg_4_0._fusionUnitSkillList,
		baseList = {
			1,
			1,
			1
		},
		preloasList = {
			0,
			0,
			0
		}
	}
	local var_4_5 = var_4_3:SpawnFusionUnit(arg_4_1, var_4_4, var_4_1, arg_4_0._attrInheritList)
	local var_4_6 = var_7.GetHP(var_4_5)
	local var_4_7 = {}

	ipairs = var_10

	for iter_4_2, iter_4_3 in var_10(var_4_1) do
		if iter_4_3:IsMainFleetUnit() then
			Clone = var_15
			var_4_7[iter_4_3] = var_15(iter_4_3:GetPosition())
		end

		var_4_3:FreezeUnit(iter_4_3)
		iter_4_3:SetPosition(var_0_4.FREEZE_POS[iter_4_3:GetIFF()])
	end

	if arg_4_1:IsMainFleetUnit() then
		Clone = var_10
		var_4_7[arg_4_1] = var_10(arg_4_1:GetPosition())
	end

	var_4_3:FreezeUnit(arg_4_1)

	local var_4_8 = arg_4_1

	arg_4_1.SetPosition(var_4_8, var_0_4.FREEZE_POS[arg_4_1:GetIFF()])

	arg_4_0._fusionTimer = nil

	local function var_4_9()
		local var_5_0 = var_0
		local var_5_1, var_5_2 = var_0.GetHP(var_5_0)
		local var_5_3 = var_5_2 - var_5_1
		local var_5_4 = 0
		local var_5_5 = var_0
		local var_5_6 = var_4.GetPosition(var_5_5)
		local var_5_7 = var_0
		local var_5_8 = var_5.GetAttrByName(var_5_7, "hpProvideRate")
		local var_5_9 = arg_4_1
		local var_5_12

		if var_6.IsMainFleetUnit(var_5_9) then
			local var_5_10 = arg_4_1

			var_5_12.SetPosition(var_5_10, var_4_7[arg_4_1])
		else
			local var_5_11 = arg_4_1

			var_5_12 = var_5_12.SetPosition
			Clone = var_2_10008

			var_5_12(var_5_11, var_2_10008(var_5_6))
		end

		math = var_5_12

		local var_5_13 = var_5_12.floor
		local var_5_14 = arg_4_1
		local var_5_15 = var_5_13(var_5_3 * var_5_8[var_7.GetAttrByName(var_5_14, "id")])
		local var_5_16 = var_4_3

		var_6.HandleDirectDamage(var_5_16, arg_4_1, var_5_15)

		local var_5_17 = var_4_3

		var_6.ActiveFreezeUnit(var_5_17, arg_4_1)

		ipairs = var_6

		for iter_5_0, iter_5_1 in var_6(var_4_1) do
			local var_5_19

			if iter_5_1:IsMainFleetUnit() then
				iter_5_1:SetPosition(var_4_7[iter_5_1])
			else
				local var_5_18 = iter_5_1

				var_5_19 = iter_5_1.SetPosition
				Clone = var_2_10013

				var_5_19(var_5_18, var_2_10013(var_5_6))
			end

			math = var_5_19

			local var_5_20 = var_5_19.floor

			var_2_10013 = iter_5_1

			local var_5_21 = var_5_20(var_5_3 * var_5_8[iter_5_1.GetAttrByName(var_2_10013, "id")])
			local var_5_22 = var_4_3

			var_11.HandleDirectDamage(var_5_22, iter_5_1, var_5_21)

			local var_5_23 = var_4_3

			var_11.ActiveFreezeUnit(var_5_23, iter_5_1)
		end

		local var_5_24 = var_4_3

		var_6.DefusionUnit(var_5_24, var_0)

		pg = var_6

		local var_5_25 = var_6.TimeMgr.GetInstance()

		var_6.RemoveBattleTimer(var_5_25, arg_4_0._fusionTimer)

		return
	end

	pg = var_4_8

	local var_4_10 = var_4_8.TimeMgr.GetInstance()

	arg_4_0._fusionTimer = var_11.AddBattleTimer(var_4_10, "fusionSkillTimer", 0, arg_4_0._duration, var_4_9, true)

	return
end

function var_0_4.Clear(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_6_0, arg_6_0._fusionTimer)
	var_0_4.super.Clear(arg_6_0)

	return
end

return
