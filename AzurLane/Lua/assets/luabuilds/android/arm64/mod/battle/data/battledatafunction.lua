ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle
local var_0_4

if not var_0.Battle.BattleDataFunction then
	var_0_4 = {}
end

var_0_3.BattleDataFunction = var_0_4

local var_0_5 = var_0.Battle.BattleDataFunction

pg = var_0_4

local var_0_6 = var_0_4.puzzle_card_template

pg = var_0_10005

local var_0_7 = var_0_10005.puzzle_ship_template

pg = var_0_10006

local var_0_8 = var_0_10006.puzzle_combat_template

pg = var_0_10007

local var_0_9 = var_0_10007.puzzle_card_affix

function var_0_5.GetDungeonTmpDataByID(arg_1_0)
	require = var_1_10001

	return var_1_10001("GameCfg.dungeon." .. arg_1_0)
end

function var_0_5.ClearDungeonCfg(arg_2_0)
	package = var_1_10001
	var_1_10001.loaded["GameCfg.dungeon." .. arg_2_0] = nil

	return
end

function var_0_5.GetSkillTemplate(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or 1

	local var_3_0 = "skill_" .. arg_3_0

	pg = var_3

	local var_3_1

	if not var_3.ConvertedSkill[var_3_0][arg_3_1] then
		var_3_1 = var_3[0]
	end

	getSkillName = var_1_10005
	var_3_1.name = var_1_10005(arg_3_0)

	return var_3_1
end

function var_0_5.ConvertSkillTemplate()
	pg = var_1_10000
	var_1_10000.ConvertedSkill = {}
	setmetatable = var_1_10000
	pg = var_1_10002

	var_1_10000(var_1_10002.ConvertedSkill, {
		__index = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_1

			pg = var_2_10003

			if var_2_10003.skillCfg[arg_5_1] then
				local var_5_1 = {}
				local var_5_2 = {}

				pairs = var_2_10006

				for iter_5_0, iter_5_1 in var_2_10006(var_3) do
					Clone = var_2_10011
					var_5_2[iter_5_0] = var_2_10011(iter_5_1)
				end

				var_5_1[0] = var_5_2
				ipairs = var_6

				for iter_5_2, iter_5_3 in var_6(var_3) do
					Clone = var_2_10011
					var_2_10011 = var_2_10011(var_5_2)
					pairs = var_2_10012

					for iter_5_4, iter_5_5 in var_2_10012(iter_5_3) do
						var_2_10011[iter_5_4] = iter_5_5
					end

					var_5_1[iter_5_2] = var_2_10011
				end

				pg = var_6
				var_6.ConvertedSkill[var_5_0] = var_5_1

				return var_5_1
			end

			return
		end
	})

	return
end

function var_0_5.GetBuffTemplate(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or 1

	local var_6_0 = "buff_" .. arg_6_0

	pg = var_3

	local var_6_1

	if not var_3.ConvertedBuff[var_6_0][arg_6_1] then
		var_6_1 = var_3[0]
	end

	return var_6_1
end

function var_0_5.ConvertBuffTemplate()
	pg = var_1_10000
	var_1_10000.ConvertedBuff = {}
	setmetatable = var_1_10000
	pg = var_1_10002

	var_1_10000(var_1_10002.ConvertedBuff, {
		__index = function(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_1

			pg = var_2_10003

			if var_2_10003.buffCfg[arg_8_1] then
				local var_8_1 = {}
				local var_8_2 = {}

				pairs = var_2_10006

				for iter_8_0, iter_8_1 in var_2_10006(var_3) do
					Clone = var_2_10011
					var_8_2[iter_8_0] = var_2_10011(iter_8_1)
				end

				var_8_1[0] = var_8_2
				ipairs = var_6

				for iter_8_2, iter_8_3 in var_6(var_3) do
					Clone = var_2_10011
					var_2_10011 = var_2_10011(var_8_2)
					pairs = var_2_10012

					for iter_8_4, iter_8_5 in var_2_10012(iter_8_3) do
						var_2_10011[iter_8_4] = iter_8_5
					end

					var_8_1[iter_8_2] = var_2_10011
				end

				pg = var_6
				var_6.ConvertedBuff[var_8_0] = var_8_1

				return var_8_1
			end

			return
		end
	})

	return
end

function var_0_5.GetBuffBulletRes(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = {}
	local var_9_1 = {}

	arg_9_1 = arg_9_1 or {}

	local var_9_2 = var_0_5.GetPlayerShipModelFromID(arg_9_0)

	local function var_9_3(arg_10_0)
		if not arg_9_4 then
			return arg_10_0
		end

		table = var_1

		if var_1.contains(var_9_2.hide_buff_list, arg_10_0) then
			local var_10_0 = arg_9_4

			return var_1.RemapHiddenSkillId(var_10_0, arg_10_0)
		end

		local var_10_1 = arg_9_4
		local var_10_3

		if var_1.RemapHiddenSkillId(var_10_1, arg_10_0) == arg_10_0 then
			local var_10_2 = arg_9_4

			var_10_3 = var_2.RemapSkillId(var_10_2, arg_10_0)
		end

		return var_10_3
	end

	;(function(arg_11_0)
		ipairs = var_2_10001

		for iter_11_0, iter_11_1 in var_2_10001(arg_11_0) do
			local var_11_0

			if arg_9_1[iter_11_1] then
				var_11_0 = arg_9_1[iter_11_1].level
			else
				var_11_0 = 1
			end

			iter_11_1 = var_9_3(iter_11_1)

			local var_11_1 = var_0_5.SkillTranform(arg_9_2, iter_11_1)
			local var_11_2 = var_0_5.GetResFromBuff(var_11_1, var_11_0, var_9_1, arg_9_3)

			ipairs = var_9

			for iter_11_2, iter_11_3 in var_9(var_11_2) do
				var_9_0[#var_9_0 + 1] = iter_11_3
			end
		end

		return
	end)(var_9_2.buff_list)
	var_9(var_9_2.hide_buff_list)

	local var_9_4 = {}

	pairs = var_1_10011

	for iter_9_0, iter_9_1 in var_1_10011(arg_9_1) do
		table = var_1_10016

		var_1_10016.insert(var_9_4, iter_9_0)
	end

	var_9(var_9_4)

	local var_9_5 = var_9_2.airassist_time

	ipairs = var_12

	for iter_9_2, iter_9_3 in var_12(var_9_5) do
		local var_9_6 = var_0_5.GetResFromSkill(iter_9_3, 1, nil, arg_9_3)

		ipairs = var_1_10018

		for iter_9_4, iter_9_5 in var_1_10018(var_9_6) do
			var_9_0[#var_9_0 + 1] = iter_9_5
		end
	end

	if var_0_5.GetShipTransformDataTemplate(arg_9_0) and var_12.skill_id ~= 0 then
		pg = var_13

		if var_13.transform_data_template[var_12.skill_id].skill_id ~= 0 then
			pg = var_13

			local var_9_7 = var_13.transform_data_template[var_12.skill_id].skill_id
			local var_9_8

			if arg_9_1[var_9_7] then
				var_9_8 = arg_9_1[var_9_7].level
			else
				var_9_8 = 1
			end

			local var_9_9 = var_0_5.GetResFromBuff(var_9_7, var_9_8, var_9_1, arg_9_3)

			ipairs = iter_9_3

			for iter_9_6, iter_9_7 in iter_9_3(var_9_9) do
				var_9_0[#var_9_0 + 1] = iter_9_7
			end
		end
	end

	if var_0_5.GetShipMetaFromDataTemplate(arg_9_0) then
		var_9(var_9_2.buff_list_display)
	end

	return var_9_0
end

function var_0_5.getWeaponResource(arg_12_0, arg_12_1)
	local var_12_0 = var_0.Battle.BattleResourceManager.GetWeaponResource(arg_12_0)

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(var_12_0) do
		arg_12_1[#arg_12_1 + 1] = iter_12_1
	end

	return
end

function var_0_5.GetResFromBuff(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	if arg_13_2[arg_13_0 .. "_" .. arg_13_1] then
		return var_13_0
	else
		arg_13_2[var_5] = true
	end

	if var_0_5.GetBuffTemplate(arg_13_0, arg_13_1).init_effect and var_6.init_effect ~= "" then
		local var_13_1 = var_6.init_effect

		if var_6.skin_adapt then
			var_13_1 = var_0_5.SkinAdaptFXID(var_13_1, arg_13_3)
		end

		var_13_0[#var_13_0 + 1] = var_0.Battle.BattleResourceManager.GetFXPath(var_13_1)
	end

	if var_6.last_effect and var_6.last_effect ~= "" then
		type = var_7

		local var_13_2

		if var_7(var_6.last_effect) ~= "table" or not var_6.last_effect then
			var_13_2 = {
				var_6.last_effect
			}
		end

		ipairs = var_8

		for iter_13_0, iter_13_1 in var_8(var_13_2) do
			var_13_0[#var_13_0 + 1] = var_0.Battle.BattleResourceManager.GetFXPath(iter_13_1)
		end
	end

	if var_6.last_effect_stack_list then
		pairs = var_7

		for iter_13_2, iter_13_3 in var_7(var_6.last_effect_stack_list) do
			var_13_0[#var_13_0 + 1] = var_0.Battle.BattleResourceManager.GetFXPath(iter_13_3)
		end
	end

	ipairs = var_7

	for iter_13_4, iter_13_5 in var_7(var_6.effect_list) do
		if iter_13_5.arg_list.skill_id ~= nil then
			local var_13_3 = var_0_5.GetResFromSkill(var_12, arg_13_1, arg_13_2, arg_13_3)

			ipairs = var_1_10014

			for iter_13_8, iter_13_12 in var_1_10014(var_13_3) do
				var_13_0[#var_13_0 + 1] = iter_13_12
			end
		end

		if iter_13_5.arg_list.skill_id_list ~= nil then
			ipairs = var_1_10014

			for iter_13_8, iter_13_12 in var_1_10014(var_13) do
				local var_13_4 = var_0_5.GetResFromSkill(iter_13_12, arg_13_1, arg_13_2, arg_13_3)

				ipairs = iter_13_16

				for iter_13_20, iter_13_11 in iter_13_16(var_13_4) do
					var_13_0[#var_13_0 + 1] = iter_13_11
				end
			end
		end

		if iter_13_5.arg_list.damage_attr_list ~= nil then
			pairs = var_1_10015

			for iter_13_12, iter_13_13 in var_1_10015(var_1_10014) do
				iter_13_16 = var_0_5.GetResFromSkill(iter_13_13, arg_13_1, arg_13_2, arg_13_3)
				ipairs = iter_13_18

				for iter_13_14, iter_13_15 in iter_13_18(iter_13_16) do
					var_13_0[#var_13_0 + 1] = iter_13_15
				end
			end
		end

		if iter_13_5.arg_list.bullet_id then
			local var_13_5 = var_0.Battle.BattleResourceManager.GetBulletResource(var_1_10015)

			ipairs = iter_13_8

			for iter_13_16, iter_13_18 in iter_13_8(var_13_5) do
				var_13_0[#var_13_0 + 1] = iter_13_18
			end
		end

		if iter_13_5.arg_list.weapon_id then
			var_0_5.getWeaponResource(var_16, var_13_0)
		end

		if iter_13_5.arg_list.aircraft_id_list then
			ipairs = iter_13_12

			for iter_13_18, iter_13_19 in iter_13_12(iter_13_8) do
				var_0_5.getWeaponResource(iter_13_19, var_13_0)
			end
		end

		if iter_13_5.arg_list.skin_id then
			local var_13_6 = var_0.Battle.BattleResourceManager.GetEquipSkinBulletRes(iter_13_12)

			ipairs = iter_13_16

			for iter_13_20, iter_13_21 in iter_13_16(var_13_6) do
				var_13_0[#var_13_0 + 1] = iter_13_21
			end
		end

		if iter_13_5.arg_list.ship_skin_id then
			iter_13_16 = var_0_5.GetPlayerShipSkinDataFromID(var_19)
			var_13_0[#var_13_0 + 1] = var_0.Battle.BattleResourceManager.GetCharacterPath(iter_13_16.prefab)
		end

		if iter_13_5.arg_list.buff_id then
			iter_13_18 = var_0_5.GetResFromBuff(iter_13_16, arg_13_1, arg_13_2, arg_13_3)
			ipairs = iter_13_19

			for iter_13_22, iter_13_23 in iter_13_19(iter_13_18) do
				type = iter_13_27

				if iter_13_27(iter_13_23) == "string" then
					var_13_0[#var_13_0 + 1] = iter_13_23
				else
					type = iter_13_27

					if iter_13_27(iter_13_23) == "table" then
						ipairs = iter_13_27

						for iter_13_24, iter_13_25 in iter_13_27(iter_13_23) do
							var_13_0[#var_13_0 + 1] = iter_13_25
						end
					end
				end
			end
		end

		if iter_13_5.arg_list.buff_skin_id then
			iter_13_19 = var_0_5.GetResFromBuff(iter_13_18, arg_13_1, arg_13_2, arg_13_3)
			ipairs = iter_13_20

			for iter_13_26, iter_13_27 in iter_13_20(iter_13_19) do
				type = var_1_10028

				if var_1_10028(iter_13_27) == "string" then
					var_13_0[#var_13_0 + 1] = iter_13_27
				else
					type = var_1_10028

					if var_1_10028(iter_13_27) == "table" then
						ipairs = var_1_10028

						for iter_13_28, iter_13_29 in var_1_10028(iter_13_27) do
							var_13_0[#var_13_0 + 1] = iter_13_29
						end
					end
				end
			end
		end

		if iter_13_5.arg_list.effect then
			var_13_0[#var_13_0 + 1] = var_0.Battle.BattleResourceManager.GetFXPath(iter_13_19)
		end
	end

	return var_13_0
end

function var_0_5.GetBuffListRes(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = {}

	ipairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(arg_14_0) do
		local var_14_2 = iter_14_1.id
		local var_14_3 = iter_14_1.level

		ipairs = var_1_10012

		for iter_14_2, iter_14_3 in var_1_10012(var_0_5.GetResFromBuff(var_14_2, var_14_3, var_14_1, arg_14_2)) do
			var_14_0[#var_14_0 + 1] = iter_14_3
		end
	end

	return var_14_0
end

function var_0_5.GetResFromSkill(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1 = arg_15_1 or 1

	local var_15_0 = {}
	local var_15_1 = var_0_5.GetSkillTemplate(arg_15_0, arg_15_1)

	local function var_15_2(arg_16_0)
		ipairs = var_2_10001

		for iter_16_0, iter_16_1 in var_2_10001(arg_16_0) do
			if iter_16_1.type == "BattleBuffShieldWall" then
				print = var_6

				var_6(iter_16_1.arg_list.effect)
			end

			if iter_16_1.type == var_0.Battle.BattleSkillGridmanFloat.__name then
				table = var_6

				var_6.insert(var_15_0, "UI/combatgridmanskillfloat")
			end

			if iter_16_1.type == var_0.Battle.BattleSkillFusion.__name then
				local var_16_0 = iter_16_1.arg_list
				local var_16_1 = var_0.Battle.BattleResourceManager.GetShipResource(var_16_0.fusion_id, var_16_0.ship_skin_id)

				ipairs = var_2_10008

				for iter_16_2, iter_16_3 in var_2_10008(var_16_1) do
					table = iter_16_11

					iter_16_11.insert(var_15_0, iter_16_3)
				end

				var_2_10008 = var_16_0.weapon_id_list
				ipairs = var_2_10009

				for iter_16_4, iter_16_11 in var_2_10009(var_2_10008) do
					var_0_5.getWeaponResource(iter_16_11, var_15_0)
				end

				var_2_10009 = var_16_0.buff_list
				ipairs = var_10

				for iter_16_11, iter_16_7 in var_10(var_2_10009) do
					local var_16_2 = var_0_5.GetResFromBuff(iter_16_7, arg_15_1, arg_15_2)

					ipairs = iter_16_14

					for iter_16_8, iter_16_9 in iter_16_14(var_16_2) do
						var_15_0[#var_15_0 + 1] = iter_16_9
					end
				end
			end

			if iter_16_1.arg_list.weapon_id ~= nil then
				var_0_5.getWeaponResource(var_6, var_15_0)
			end

			if iter_16_1.arg_list.buff_id then
				var_2_10008 = var_0_5.GetResFromBuff(var_7, arg_15_1, arg_15_2)
				ipairs = var_2_10009

				for iter_16_10, iter_16_11 in var_2_10009(var_2_10008) do
					var_15_0[#var_15_0 + 1] = iter_16_11
				end
			end

			if iter_16_1.arg_list.damage_buff_id then
				if not iter_16_1.arg_list.damage_buff_lv then
					var_2_10009 = 1
				end

				local var_16_3 = var_0_5.GetResFromBuff(var_2_10008, var_2_10009, arg_15_2)

				ipairs = iter_16_2

				for iter_16_12, iter_16_13 in iter_16_2(var_16_3) do
					iter_16_14 = var_15_0
					iter_16_14[#var_15_0 + 1] = iter_16_13
				end
			end

			if iter_16_1.arg_list.effect then
				var_15_0[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetFXPath(var_2_10009)
			end

			if iter_16_1.arg_list.finale_effect then
				iter_16_2 = var_15_0
				iter_16_2[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetFXPath(var_10)
			end

			if iter_16_1.arg_list.spawnData then
				local var_16_4 = var_0.Battle.BattleResourceManager.GetMonsterRes(iter_16_2)

				ipairs = iter_16_11

				for iter_16_14, iter_16_15 in iter_16_11(var_16_4) do
					var_15_0[#var_15_0 + 1] = iter_16_15
				end
			end
		end

		return
	end

	type = var_7

	if var_7(var_15_1.painting) == "string" then
		var_15_0[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetHrzIcon(var_15_1.painting)
		var_15_0[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetSquareIcon(var_15_1.painting)
	end

	type = var_7

	if var_7(var_15_1.castCV) == "table" then
		local var_15_3 = var_0.Battle.BattleResourceManager.GetInstance()

		var_7.AddPreloadCV(var_15_3, var_15_1.castCV.skinID)
	end

	if var_15_1.focus_duration then
		if var_15_1.cutin_cover then
			var_15_0[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetInstance().GetPaintingPath(var_15_1.cutin_cover)
		elseif var_15_1.cutin_cover_DAL then
			var_15_0[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetInstance().GetPaintingPath(var_15_1.cutin_cover_DAL)
			var_15_0[#var_15_0 + 1] = "UI/SkillPaintingDAL"
		elseif arg_15_3 then
			local var_15_4 = var_0_5.GetPlayerShipSkinDataFromID(arg_15_3).painting

			var_15_0[#var_15_0 + 1] = var_0.Battle.BattleResourceManager.GetInstance().GetPaintingPath(var_15_4)
		end
	end

	var_15_2(var_15_1.effect_list)

	ipairs = var_7

	for iter_15_0, iter_15_1 in var_7(var_15_1) do
		var_15_2(iter_15_1.effect_list)
	end

	return var_15_0
end

function var_0_5.GetShipSkillTriggerCount(arg_17_0, arg_17_1)
	local function var_17_0(arg_18_0)
		local var_18_0 = 0

		pairs = var_2_10002

		for iter_18_0, iter_18_1 in var_2_10002(arg_18_0) do
			local var_18_1 = var_0_5.GetBuffTemplate(iter_18_1.id).effect_list

			ipairs = var_9

			for iter_18_2, iter_18_3 in var_9(var_18_1) do
				local var_18_2 = iter_18_3.trigger

				ipairs = var_2_10015

				for iter_18_4, iter_18_5 in var_2_10015(var_18_2) do
					table = var_2_10020

					if var_2_10020.contains(arg_17_1, iter_18_5) then
						var_18_0 = var_18_0 + 1
					end
				end
			end
		end

		return var_18_0
	end

	local var_17_1 = 0
	local var_17_2

	if not arg_17_0.skills then
		var_17_2 = {}
	end

	local var_17_3 = var_17_1 + var_17_0(var_17_2)
	local var_17_4 = var_0_5.GetEquipSkill(arg_17_0.equipment)
	local var_17_5 = {}

	ipairs = var_7

	for iter_17_0, iter_17_1 in var_7(var_17_4) do
		table = var_1_10012

		var_1_10012.insert(var_17_5, {
			id = iter_17_1.buffID
		})
	end

	return var_17_3 + var_17_0(var_17_5)
end

function var_0_5.GetSongList(arg_19_0)
	local var_19_0 = {
		initList = {},
		otherList = {}
	}

	pairs = var_2

	for iter_19_0, iter_19_1 in var_2(arg_19_0) do
		local var_19_1 = var_0_5.GetBuffTemplate(iter_19_0, 1)

		ipairs = var_1_10008

		for iter_19_2, iter_19_3 in var_1_10008(var_19_1.effect_list) do
			if iter_19_3.type == var_0.Battle.BattleBuffDiva.__name then
				table = var_13

				if var_13.contains(iter_19_3.trigger, "onInitGame") then
					ipairs = var_13

					for iter_19_4, iter_19_5 in var_13(iter_19_3.arg_list.bgm_list) do
						var_19_0.initList[iter_19_5] = true
					end
				end

				table = var_13

				if not var_13.contains(iter_19_3.trigger, "onInitGame") or #iter_19_3.trigger > 1 then
					ipairs = var_13

					for iter_19_6, iter_19_7 in var_13(iter_19_3.arg_list.bgm_list) do
						var_19_0.otherList[iter_19_7] = true
					end
				end
			end
		end
	end

	return var_19_0
end

function var_0_5.GetCardRes(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = var_0.Battle.BattleCardPuzzleCard.GetCardEffectConfig(arg_20_0)

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(var_20_1.effect_list) do
		local var_20_2 = var_0_5.GetCardFXRes(iter_20_1)

		ipairs = var_1_10009

		for iter_20_2, iter_20_3 in var_1_10009(var_20_2) do
			table = var_1_10014

			var_1_10014.insert(var_20_0, iter_20_3)
		end
	end

	pairs = var_3

	for iter_20_4, iter_20_5 in var_3(var_20_1.effect_list) do
		local var_20_3 = var_0_5.GetCardFXRes(iter_20_5)

		ipairs = var_1_10009

		for iter_20_6, iter_20_7 in var_1_10009(var_20_3) do
			table = var_1_10014

			var_1_10014.insert(var_20_0, iter_20_7)
		end
	end

	return var_20_0
end

function var_0_5.GetCardFXRes(arg_21_0)
	local var_21_0 = {}

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0) do
		if iter_21_1.type == "BattleCardPuzzleSkillCreateCard" then
			local var_21_1 = var_0_5.GetCardRes(iter_21_1.arg_list.card_id)

			ipairs = var_1_10008

			for iter_21_2, iter_21_3 in var_1_10008(var_21_1) do
				table = var_1_10013

				var_1_10013.insert(var_21_0, iter_21_3)
			end
		elseif iter_21_1.type == "BattleCardPuzzleSkillFire" then
			local var_21_2 = var_0.Battle.BattleResourceManager.GetWeaponResource(iter_21_1.arg_list.weapon_id)

			ipairs = var_1_10008

			for iter_21_4, iter_21_5 in var_1_10008(var_21_2) do
				table = var_1_10013

				var_1_10013.insert(var_21_0, iter_21_5)
			end
		elseif iter_21_1.type == "BattleCardPuzzleSkillAddBuff" then
			local var_21_3 = var_0_5.GetResFromBuff(iter_21_1.arg_list.buff_id, 1, {})

			ipairs = var_1_10008

			for iter_21_6, iter_21_7 in var_1_10008(var_21_3) do
				table = var_1_10013

				var_1_10013.insert(var_21_0, iter_21_7)
			end
		end
	end

	return var_21_0
end

function var_0_5.NeedSkillPainting(arg_22_0)
	local var_22_0 = false

	if var_0_5.GetSkillTemplate(arg_22_0).focus_duration then
		var_22_0 = true
	end

	return var_22_0
end

function var_0_5.SkinAdaptFXID(arg_23_0, arg_23_1)
	return arg_23_0 .. "_" .. arg_23_1
end

function var_0_5.GetFleetReload(arg_24_0)
	return var_0_2.GetFleetReload(arg_24_0)
end

function var_0_5.GetFleetTorpedoPower(arg_25_0)
	return var_0_2.GetFleetTorpedoPower(arg_25_0)
end

function var_0_5.SortFleetList(arg_26_0, arg_26_1)
	local var_26_0 = {}

	ipairs = var_1_10003

	for iter_26_0, iter_26_1 in var_1_10003(arg_26_0) do
		var_26_0[#var_26_0 + 1] = arg_26_1[iter_26_1]

		local var_26_1 = var_26_0[iter_26_0]

		var_8.SetFormationIndex(var_26_1, iter_26_0)
	end

	return var_26_0
end

function var_0_5.GetLimitAttributeRange(arg_27_0, arg_27_1)
	pg = var_1_10002

	if var_1_10002.battle_attribute_range[arg_27_0] then
		math = var_2

		local var_27_0 = var_2.clamp
		local var_27_1 = arg_27_1

		pg = var_1_10005

		local var_27_2 = var_1_10005.battle_attribute_range[arg_27_0].min / 16

		pg = var_1_10006

		return var_27_0(var_27_1, var_27_2, var_1_10006.battle_attribute_range[arg_27_0].max / 16)
	end

	return arg_27_1
end

function var_0_5.GetPuzzleCardDataTemplate(arg_28_0)
	assert = var_1_10001

	var_1_10001(var_0_6[arg_28_0] ~= nil, ">>puzzle_card_template<< 找不到卡牌配置：" .. arg_28_0)

	return var_0_6[arg_28_0]
end

function var_0_5.GetPuzzleShipDataTemplate(arg_29_0)
	assert = var_1_10001

	var_1_10001(var_0_7[arg_29_0] ~= nil, ">>puzzle_ship_template<< 找不到卡牌舰船配置：" .. arg_29_0)

	return var_0_7[arg_29_0]
end

function var_0_5.GetPuzzleDungeonTemplate(arg_30_0)
	assert = var_1_10001

	var_1_10001(var_0_8[arg_30_0] ~= nil, ">>puzzle_combat_template<< 找不到卡牌关卡配置：" .. arg_30_0)

	return var_0_8[arg_30_0]
end

function var_0_5.GetPuzzleCardAffixDataTemplate(arg_31_0)
	assert = var_1_10001

	var_1_10001(var_0_9[arg_31_0] ~= nil, ">>puzzle_card_affix<< 找不到卡牌关卡配置：" .. arg_31_0)

	return var_0_9[arg_31_0]
end

return
