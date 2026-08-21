local var_0_0 = {
	{
		"S",
		"N"
	},
	{
		"E",
		"W"
	}
}
local var_0_1 = math.sin(math.pi / 8)

;({
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

		switch(arg_1_0, {
			Item = function()
				var_1_0.targetClass = TargetItem
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				var_1_0.targetClass = ObjectBomb
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				var_1_0.targetClass = ObjectBush
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				var_1_0.targetClass = ObjectRockB
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				var_1_0.targetClass = ObjectTreasureN
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				var_1_0.targetClass = ObjectTreasureR
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				var_1_0.targetClass = EffectFire
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				var_1_0.targetClass = EffectImpack
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				var_1_0.targetClass = EffectBullet
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				var_1_0.targetClass = EffectLaser
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				var_1_0.targetClass = MoveRyza
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				var_1_0.targetClass = EnemyScavenger
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				var_1_0.targetClass = EnemyBossScavenger
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				var_1_0.targetClass = EnemyChaser
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				var_1_0.targetClass = EnemyBossChaser
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				var_1_0.targetClass = EnemySmasher
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				var_1_0.targetClass = EnemyBossSmasher
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				var_1_0.targetClass = EnemyConductor
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				var_1_0.targetClass = EnemyBossConductor
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				var_1_0.targetClass = EnemyNavigator
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				var_1_0.targetClass = EnemyBossNavigator
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return ({}).targetClass, ({}).path, ({}).parent
	end
}).GetEightDirMark = function(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs({
		arg_29_0.y,
		arg_29_0.x
	}) do
		if iter_29_1 * iter_29_1 < var_0_1 * var_0_1 then
			iter_29_1 = 0
		end

		if iter_29_1 > 0 then
			({})[iter_29_0] = var_0_0[iter_29_0][1]
		elseif iter_29_1 < 0 then
			({})[iter_29_0] = var_0_0[iter_29_0][2]
		else
			({})[iter_29_0] = ""
		end
	end

	return ({})[1] .. ({})[2]
end
;({
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

		switch(arg_1_0, {
			Item = function()
				var_1_0.targetClass = TargetItem
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				var_1_0.targetClass = ObjectBomb
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				var_1_0.targetClass = ObjectBush
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				var_1_0.targetClass = ObjectRockB
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				var_1_0.targetClass = ObjectTreasureN
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				var_1_0.targetClass = ObjectTreasureR
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				var_1_0.targetClass = EffectFire
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				var_1_0.targetClass = EffectImpack
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				var_1_0.targetClass = EffectBullet
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				var_1_0.targetClass = EffectLaser
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				var_1_0.targetClass = MoveRyza
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				var_1_0.targetClass = EnemyScavenger
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				var_1_0.targetClass = EnemyBossScavenger
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				var_1_0.targetClass = EnemyChaser
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				var_1_0.targetClass = EnemyBossChaser
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				var_1_0.targetClass = EnemySmasher
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				var_1_0.targetClass = EnemyBossSmasher
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				var_1_0.targetClass = EnemyConductor
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				var_1_0.targetClass = EnemyBossConductor
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				var_1_0.targetClass = EnemyNavigator
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				var_1_0.targetClass = EnemyBossNavigator
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return ({}).targetClass, ({}).path, ({}).parent
	end
}).GetFourDirMark = function(arg_30_0)
	if arg_30_0.y * arg_30_0.y < arg_30_0.x * arg_30_0.x then
		local var_30_0 = {
			0,
			arg_30_0.x
		}

		if not {
			0,
			arg_30_0.x
		} then
			var_30_0 = {
				arg_30_0.y,
				0
			}
		end

		for iter_30_0, iter_30_1 in ipairs(var_30_0) do
			if iter_30_1 > 0 then
				({})[iter_30_0] = var_0_0[iter_30_0][1]
			elseif iter_30_1 < 0 then
				({})[iter_30_0] = var_0_0[iter_30_0][2]
			else
				({})[iter_30_0] = ""
			end
		end

		return ({})[1] .. ({})[2]
	end
end
;({
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

		switch(arg_1_0, {
			Item = function()
				var_1_0.targetClass = TargetItem
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				var_1_0.targetClass = ObjectBomb
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				var_1_0.targetClass = ObjectBush
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				var_1_0.targetClass = ObjectRockB
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				var_1_0.targetClass = ObjectTreasureN
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				var_1_0.targetClass = ObjectTreasureR
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				var_1_0.targetClass = EffectFire
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				var_1_0.targetClass = EffectImpack
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				var_1_0.targetClass = EffectBullet
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				var_1_0.targetClass = EffectLaser
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				var_1_0.targetClass = MoveRyza
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				var_1_0.targetClass = EnemyScavenger
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				var_1_0.targetClass = EnemyBossScavenger
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				var_1_0.targetClass = EnemyChaser
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				var_1_0.targetClass = EnemyBossChaser
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				var_1_0.targetClass = EnemySmasher
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				var_1_0.targetClass = EnemyBossSmasher
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				var_1_0.targetClass = EnemyConductor
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				var_1_0.targetClass = EnemyBossConductor
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				var_1_0.targetClass = EnemyNavigator
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				var_1_0.targetClass = EnemyBossNavigator
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return ({}).targetClass, ({}).path, ({}).parent
	end
}).GetDestroyPoint = function(arg_31_0)
	local var_31_0 = 0

	if arg_31_0.class == TargetItem then
		switch(arg_31_0.type, {
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
	elseif isa(arg_31_0, TargetObject) then
		switch(arg_31_0.class, {
			[ObjectBreakable] = function()
				var_31_0 = 20

				return
			end,
			[ObjectRockB] = function()
				var_31_0 = 50

				return
			end,
			[ObjectTreasureN] = function()
				var_31_0 = 200

				return
			end,
			[ObjectTreasureR] = function()
				var_31_0 = 500

				return
			end
		})
	elseif isa(arg_31_0, MoveEnemy) then
		switch(arg_31_0.class, {
			[EnemyScavenger] = function()
				var_31_0 = 100

				return
			end,
			[EnemyBossScavenger] = function()
				var_31_0 = 300

				return
			end,
			[EnemyChaser] = function()
				var_31_0 = 100

				return
			end,
			[EnemyBossChaser] = function()
				var_31_0 = 500

				return
			end,
			[EnemyNavigator] = function()
				var_31_0 = 22

				return
			end,
			[EnemyBossNavigator] = function()
				var_31_0 = 600

				return
			end,
			[EnemySmasher] = function()
				var_31_0 = 22

				return
			end,
			[EnemyBossSmasher] = function()
				var_31_0 = 500

				return
			end,
			[EnemyConductor] = function()
				var_31_0 = 200

				return
			end,
			[EnemyBossConductor] = function()
				var_31_0 = 600

				return
			end
		})
	end

	return 0
end
;({
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

		switch(arg_1_0, {
			Item = function()
				var_1_0.targetClass = TargetItem
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				var_1_0.targetClass = ObjectBomb
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				var_1_0.targetClass = ObjectBush
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				var_1_0.targetClass = ObjectRockB
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				var_1_0.targetClass = ObjectTreasureN
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				var_1_0.targetClass = ObjectTreasureR
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				var_1_0.targetClass = EffectFire
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				var_1_0.targetClass = EffectImpack
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				var_1_0.targetClass = EffectBullet
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				var_1_0.targetClass = EffectLaser
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				var_1_0.targetClass = MoveRyza
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				var_1_0.targetClass = EnemyScavenger
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				var_1_0.targetClass = EnemyBossScavenger
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				var_1_0.targetClass = EnemyChaser
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				var_1_0.targetClass = EnemyBossChaser
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				var_1_0.targetClass = EnemySmasher
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				var_1_0.targetClass = EnemyBossSmasher
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				var_1_0.targetClass = EnemyConductor
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				var_1_0.targetClass = EnemyBossConductor
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				var_1_0.targetClass = EnemyNavigator
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				var_1_0.targetClass = EnemyBossNavigator
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return ({}).targetClass, ({}).path, ({}).parent
	end
}).GetPassGamePoint = function(arg_52_0)
	return math.floor(16 / math.log(arg_52_0))
end
;({
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

		switch(arg_1_0, {
			Item = function()
				var_1_0.targetClass = TargetItem
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				var_1_0.targetClass = ObjectBomb
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				var_1_0.targetClass = ObjectBush
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				var_1_0.targetClass = ObjectRockB
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				var_1_0.targetClass = ObjectTreasureN
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				var_1_0.targetClass = ObjectTreasureR
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				var_1_0.targetClass = EffectFire
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				var_1_0.targetClass = EffectImpack
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				var_1_0.targetClass = EffectBullet
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				var_1_0.targetClass = EffectLaser
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				var_1_0.targetClass = MoveRyza
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				var_1_0.targetClass = EnemyScavenger
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				var_1_0.targetClass = EnemyBossScavenger
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				var_1_0.targetClass = EnemyChaser
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				var_1_0.targetClass = EnemyBossChaser
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				var_1_0.targetClass = EnemySmasher
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				var_1_0.targetClass = EnemyBossSmasher
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				var_1_0.targetClass = EnemyConductor
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				var_1_0.targetClass = EnemyBossConductor
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				var_1_0.targetClass = EnemyNavigator
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				var_1_0.targetClass = EnemyBossNavigator
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return ({}).targetClass, ({}).path, ({}).parent
	end
}).ReSetDir = function(arg_53_0)
	if arg_53_0.x ~= 0 and arg_53_0.y ~= 0 then
		local var_53_0 = math.abs(arg_53_0.x)
		local var_53_1 = math.abs(arg_53_0.y)

		if var_53_1 < var_53_0 then
			arg_53_0.x = math.ceil(var_53_0) * math.sign(arg_53_0.x)
			arg_53_0.y = 0
		else
			arg_53_0.x = 0
			arg_53_0.y = math.ceil(var_53_1) * math.sign(arg_53_0.y)
		end
	end

	return arg_53_0
end

return {
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

		switch(arg_1_0, {
			Item = function()
				var_1_0.targetClass = TargetItem
				var_1_0.path = "object/Item"
				var_1_0.parent = "object"

				return
			end,
			Bomb = function()
				var_1_0.targetClass = ObjectBomb
				var_1_0.path = "object/Bomb"
				var_1_0.parent = "object"

				return
			end,
			Bush = function()
				var_1_0.targetClass = ObjectBush
				var_1_0.path = "object/Bush"
				var_1_0.parent = "object"

				return
			end,
			Box = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Box"
				var_1_0.parent = "object"

				return
			end,
			Grass = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Grass"
				var_1_0.parent = "object"

				return
			end,
			Taru = function()
				var_1_0.targetClass = ObjectBreakable
				var_1_0.path = "object/Taru"
				var_1_0.parent = "object"

				return
			end,
			Rock_A = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Rock_A"
				var_1_0.parent = "object"

				return
			end,
			Rock_B = function()
				var_1_0.targetClass = ObjectRockB
				var_1_0.path = "object/Rock_B"
				var_1_0.parent = "object"

				return
			end,
			Tree_L = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_L"
				var_1_0.parent = "object"

				return
			end,
			Tree_S = function()
				var_1_0.targetClass = TargetObject
				var_1_0.path = "object/Tree_S"
				var_1_0.parent = "object"

				return
			end,
			Treasure_N = function()
				var_1_0.targetClass = ObjectTreasureN
				var_1_0.path = "object/Treasure_N"
				var_1_0.parent = "object"

				return
			end,
			Treasure_R = function()
				var_1_0.targetClass = ObjectTreasureR
				var_1_0.path = "object/Treasure_R"
				var_1_0.parent = "object"

				return
			end,
			Fire = function()
				var_1_0.targetClass = EffectFire
				var_1_0.path = "effect/Fire"
				var_1_0.parent = "effect"
				var_1_0.order = "low"

				return
			end,
			Impack = function()
				var_1_0.targetClass = EffectImpack
				var_1_0.path = "effect/Impack"
				var_1_0.parent = "effect"

				return
			end,
			Bullet = function()
				var_1_0.targetClass = EffectBullet
				var_1_0.path = "effect/Bullet"
				var_1_0.parent = "effect"

				return
			end,
			Laser = function()
				var_1_0.targetClass = EffectLaser
				var_1_0.path = "effect/Laser"
				var_1_0.parent = "effect"

				return
			end,
			Ryza = function()
				var_1_0.targetClass = MoveRyza
				var_1_0.path = "character/Ryza"
				var_1_0.parent = "character"

				return
			end,
			Scavenger = function()
				var_1_0.targetClass = EnemyScavenger
				var_1_0.path = "character/Scavenger"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Scavenger = function()
				var_1_0.targetClass = EnemyBossScavenger
				var_1_0.path = "character/BOSS_Scavenger"
				var_1_0.parent = "character"

				return
			end,
			Chaser = function()
				var_1_0.targetClass = EnemyChaser
				var_1_0.path = "character/Chaser"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Chaser = function()
				var_1_0.targetClass = EnemyBossChaser
				var_1_0.path = "character/BOSS_Chaser"
				var_1_0.parent = "character"

				return
			end,
			Smasher = function()
				var_1_0.targetClass = EnemySmasher
				var_1_0.path = "character/Smasher"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Smasher = function()
				var_1_0.targetClass = EnemyBossSmasher
				var_1_0.path = "character/BOSS_Smasher"
				var_1_0.parent = "character"

				return
			end,
			Conductor = function()
				var_1_0.targetClass = EnemyConductor
				var_1_0.path = "character/Conductor"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Conductor = function()
				var_1_0.targetClass = EnemyBossConductor
				var_1_0.path = "character/BOSS_Conductor"
				var_1_0.parent = "character"

				return
			end,
			Navigator = function()
				var_1_0.targetClass = EnemyNavigator
				var_1_0.path = "character/Navigator"
				var_1_0.parent = "character"

				return
			end,
			BOSS_Navigator = function()
				var_1_0.targetClass = EnemyBossNavigator
				var_1_0.path = "character/BOSS_Navigator"
				var_1_0.parent = "character"

				return
			end
		})

		return ({}).targetClass, ({}).path, ({}).parent
	end
}
