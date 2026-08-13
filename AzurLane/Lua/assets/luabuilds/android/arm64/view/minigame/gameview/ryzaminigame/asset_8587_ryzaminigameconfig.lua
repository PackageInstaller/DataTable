local var_0_0 = {
	ALL_GAME_TIME = 120,
	GRASS_CHAGNE_RATE = 0.2,
	TIME_INTERVAL = 0.016666666666666666,
	MIN_MAP_SIZE = {
		20,
		20
	},
	SOIL_RANDOM_CONFIG = {
		spacer_rate = 0.25,
		size_rate = {
			0.5,
			0.7
		},
		cancel_rate = {
			0.2,
			0.3
		}
	},
	SOIL_SPRITES_DIC = {
		[55] = "Soil_4",
		[126] = "Soil_2",
		[236] = "Soil_3",
		[205] = "Soil_6",
		[238] = "Soil_2",
		[204] = "Soil_3",
		[239] = "Soil_11",
		[217] = "Soil_9",
		[119] = "Soil_4",
		[102] = "Soil_1",
		[237] = "Soil_6",
		[191] = "Soil_12",
		[118] = "Soil_1",
		[51] = "Soil_7",
		[137] = "Soil_9",
		[153] = "Soil_9",
		[251] = "Soil_8",
		[219] = "Soil_8",
		[187] = "Soil_8",
		[155] = "Soil_8",
		[38] = "Soil_1",
		[255] = "Soil_5",
		[223] = "Soil_13",
		[254] = "Soil_2",
		[54] = "Soil_1",
		[253] = "Soil_6",
		[221] = "Soil_6",
		[127] = "Soil_10",
		[110] = "Soil_2",
		[76] = "Soil_3",
		[179] = "Soil_7",
		[147] = "Soil_7",
		[108] = "Soil_3",
		[247] = "Soil_4",
		[19] = "Soil_7",
		[183] = "Soil_4",
		[201] = "Soil_9"
	},
	ENEMY_TYPE_LIST = {
		"Scavenger",
		"Chaser",
		"Smasher",
		"Conductor",
		"Navigator",
		"BOSS_Scavenger",
		"BOSS_Conductor",
		"BOSS_Chaser",
		"BOSS_Navigator",
		"BOSS_Smasher"
	},
	FREE_MAP_BOSS_LIMIT = {
		2,
		2,
		3,
		3,
		3,
		4,
		4
	},
	CreateInfo = function(arg_1_0)
		local var_1_0 = {}

		switch = var_1_10002

		var_1_10002(arg_1_0, {
			Item = function()
				local var_2_0 = var_1_0

				TargetItem = var_2_10001
				var_2_0.targetClass = var_2_10001
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				local var_3_0 = var_1_0

				ObjectBomb = var_2_10001
				var_3_0.targetClass = var_2_10001
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				local var_4_0 = var_1_0

				ObjectBush = var_2_10001
				var_4_0.targetClass = var_2_10001
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				local var_5_0 = var_1_0

				ObjectBreakable = var_2_10001
				var_5_0.targetClass = var_2_10001
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				local var_6_0 = var_1_0

				ObjectBreakable = var_2_10001
				var_6_0.targetClass = var_2_10001
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				local var_7_0 = var_1_0

				ObjectBreakable = var_2_10001
				var_7_0.targetClass = var_2_10001
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				local var_8_0 = var_1_0

				TargetObject = var_2_10001
				var_8_0.targetClass = var_2_10001
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				local var_9_0 = var_1_0

				ObjectRockB = var_2_10001
				var_9_0.targetClass = var_2_10001
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				local var_10_0 = var_1_0

				TargetObject = var_2_10001
				var_10_0.targetClass = var_2_10001
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				local var_11_0 = var_1_0

				TargetObject = var_2_10001
				var_11_0.targetClass = var_2_10001
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				local var_12_0 = var_1_0

				ObjectTreasureN = var_2_10001
				var_12_0.targetClass = var_2_10001
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				local var_13_0 = var_1_0

				ObjectTreasureR = var_2_10001
				var_13_0.targetClass = var_2_10001
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				local var_14_0 = var_1_0

				EffectFire = var_2_10001
				var_14_0.targetClass = var_2_10001
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				local var_15_0 = var_1_0

				EffectImpack = var_2_10001
				var_15_0.targetClass = var_2_10001
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				local var_16_0 = var_1_0

				EffectBullet = var_2_10001
				var_16_0.targetClass = var_2_10001
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				local var_17_0 = var_1_0

				EffectLaser = var_2_10001
				var_17_0.targetClass = var_2_10001
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				local var_18_0 = var_1_0

				MoveRyza = var_2_10001
				var_18_0.targetClass = var_2_10001
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				local var_19_0 = var_1_0

				EnemyScavenger = var_2_10001
				var_19_0.targetClass = var_2_10001
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				local var_20_0 = var_1_0

				EnemyBossScavenger = var_2_10001
				var_20_0.targetClass = var_2_10001
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				local var_21_0 = var_1_0

				EnemyChaser = var_2_10001
				var_21_0.targetClass = var_2_10001
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				local var_22_0 = var_1_0

				EnemyBossChaser = var_2_10001
				var_22_0.targetClass = var_2_10001
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				local var_23_0 = var_1_0

				EnemySmasher = var_2_10001
				var_23_0.targetClass = var_2_10001
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				local var_24_0 = var_1_0

				EnemyBossSmasher = var_2_10001
				var_24_0.targetClass = var_2_10001
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				local var_25_0 = var_1_0

				EnemyConductor = var_2_10001
				var_25_0.targetClass = var_2_10001
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				local var_26_0 = var_1_0

				EnemyBossConductor = var_2_10001
				var_26_0.targetClass = var_2_10001
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				local var_27_0 = var_1_0

				EnemyNavigator = var_2_10001
				var_27_0.targetClass = var_2_10001
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				local var_28_0 = var_1_0

				EnemyBossNavigator = var_2_10001
				var_28_0.targetClass = var_2_10001
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return var_1_0.targetClass, var_1_0.path, var_1_0.parent
	end
}
local var_0_1 = {
	{
		"S",
		"N"
	},
	{
		"E",
		"W"
	}
}

math = var_2

local var_0_2 = var_2.sin

math = var_0_10004

local var_0_3 = var_0_2(var_0_10004.pi / 8)

function var_0_0.GetEightDirMark(arg_29_0)
	local var_29_0 = {}

	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002({
		arg_29_0.y,
		arg_29_0.x
	}) do
		if iter_29_1 * iter_29_1 < var_0_3 * var_0_3 then
			iter_29_1 = 0
		end

		if iter_29_1 > 0 then
			var_29_0[iter_29_0] = var_0_1[iter_29_0][1]
		elseif iter_29_1 < 0 then
			var_29_0[iter_29_0] = var_0_1[iter_29_0][2]
		else
			var_29_0[iter_29_0] = ""
		end
	end

	return var_29_0[1] .. var_29_0[2]
end

function var_0_0.GetFourDirMark(arg_30_0)
	local var_30_0 = {}
	local var_30_1

	if not (arg_30_0.y * arg_30_0.y < arg_30_0.x * arg_30_0.x) or not {
		0,
		arg_30_0.x
	} then
		var_30_1 = {
			arg_30_0.y,
			0
		}
	end

	ipairs = var_3

	for iter_30_0, iter_30_1 in var_3(var_30_1) do
		if iter_30_1 > 0 then
			var_30_0[iter_30_0] = var_0_1[iter_30_0][1]
		elseif iter_30_1 < 0 then
			var_30_0[iter_30_0] = var_0_1[iter_30_0][2]
		else
			var_30_0[iter_30_0] = ""
		end
	end

	return var_30_0[1] .. var_30_0[2]
end

function var_0_0.GetDestroyPoint(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = arg_31_0.class

	TargetItem = var_1_10003

	if var_31_1 == var_1_10003 then
		switch = var_31_1

		var_31_1(arg_31_0.type, {
			bomb = function()
				var_31_0 = 50

				return
			end,
			power = function()
				var_31_0 = 50

				return
			end,
			speed = function()
				var_31_0 = 50

				return
			end,
			hp1 = function()
				var_31_0 = 100

				return
			end,
			hp2 = function()
				var_31_0 = 200

				return
			end,
			spirit = function()
				var_31_0 = 300

				return
			end
		})
	else
		isa = var_31_1

		local var_31_2 = arg_31_0

		TargetObject = var_1_10005

		if var_31_1(var_31_2, var_1_10005) then
			switch = var_2

			local var_31_3 = arg_31_0.class

			var_1_10005 = {}
			ObjectBreakable = var_1_10006
			var_1_10005[var_1_10006] = function()
				var_31_0 = 20

				return
			end
			ObjectRockB = var_1_10006
			var_1_10005[var_1_10006] = function()
				var_31_0 = 50

				return
			end
			ObjectTreasureN = var_1_10006
			var_1_10005[var_1_10006] = function()
				var_31_0 = 200

				return
			end
			ObjectTreasureR = var_1_10006
			var_1_10005[var_1_10006] = function()
				var_31_0 = 500

				return
			end

			var_2(var_31_3, var_1_10005)
		else
			isa = var_2

			local var_31_4 = arg_31_0

			MoveEnemy = var_1_10005

			if var_2(var_31_4, var_1_10005) then
				switch = var_2

				local var_31_5 = arg_31_0.class
				local var_31_6 = {}

				EnemyScavenger = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 100

					return
				end
				EnemyBossScavenger = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 300

					return
				end
				EnemyChaser = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 100

					return
				end
				EnemyBossChaser = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 500

					return
				end
				EnemyNavigator = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 22

					return
				end
				EnemyBossNavigator = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 600

					return
				end
				EnemySmasher = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 22

					return
				end
				EnemyBossSmasher = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 500

					return
				end
				EnemyConductor = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 200

					return
				end
				EnemyBossConductor = var_1_10006
				var_31_6[var_1_10006] = function()
					var_31_0 = 600

					return
				end

				var_2(var_31_5, var_31_6)
			end
		end
	end

	return var_31_0
end

function var_0_0.GetPassGamePoint(arg_52_0)
	math = var_1_10001

	local var_52_0 = var_1_10001.floor

	math = var_1_10003

	return var_52_0(16 / var_1_10003.log(arg_52_0))
end

function var_0_0.ReSetDir(arg_53_0)
	if arg_53_0.x ~= 0 and arg_53_0.y ~= 0 then
		math = var_1

		local var_53_0 = var_1.sign(arg_53_0.x)

		math = var_1_10002

		local var_53_1 = var_1_10002.sign(arg_53_0.y)

		math = var_3

		local var_53_2 = var_3.abs(arg_53_0.x)

		math = var_4

		if var_4.abs(arg_53_0.y) < var_53_2 then
			math = var_5
			arg_53_0.x = var_5.ceil(var_53_2) * var_53_0
			arg_53_0.y = 0
		else
			arg_53_0.x = 0
			math = var_5
			arg_53_0.y = var_5.ceil(var_4) * var_53_1
		end
	end

	return arg_53_0
end

return var_0_0
