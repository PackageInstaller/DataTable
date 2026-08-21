local var_0_0 = class("CarWashConst")

var_0_0.DEFAULT_RAY_DISTANCE = 3
var_0_0.DEFAULT_DECAL_RENDER_QUEUE = 2600
var_0_0.CAR_LAYER = 26
var_0_0.CAR_LAYER_MASK = bit.lshift(1, var_0_0.CAR_LAYER)
var_0_0.LADY_LAYER = LayerMask.NameToLayer("Character3D")
var_0_0.LADY_LAYER_MASK = bit.lshift(1, var_0_0.LADY_LAYER)
var_0_0.PLAYER_LAYER = LayerMask.NameToLayer("Player")
var_0_0.PLAYER_LAYER_MASK = bit.lshift(1, var_0_0.PLAYER_LAYER)
var_0_0.DEFAULT_LADY_DECAL_SIZE = 0.1
var_0_0.LAYER_MASK = bit.bor(var_0_0.CAR_LAYER_MASK, var_0_0.LADY_LAYER_MASK)
var_0_0.DECAL_LAYER = LayerMask.NameToLayer("CameraRT")
var_0_0.DECAL_LAYER_MASK = bit.lshift(1, var_0_0.DECAL_LAYER)
var_0_0.EFFECT_LAYER_MASK = bit.bnot(bit.bor(var_0_0.DECAL_LAYER_MASK, var_0_0.PLAYER_LAYER_MASK))
var_0_0.HIDDEN_REACTION_TRIGGER_TIME = 2
var_0_0.GAME_DURATION = 300
var_0_0.ORTHOGRAPHIC_SIZE_RANGE = {
	0.3,
	0.4
}
var_0_0.ROTATE_RANGE = {
	0,
	360
}
var_0_0.GUN_TYPE = {
	FOAM_SPRAYER = 2,
	WASHER = 1,
	HIGH_PRESSURE_WASHER = 3
}
var_0_0.GUN_CONFIG = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		var_0_0.InitGunConfig(arg_1_0)

		return rawget(arg_1_0, arg_1_1)
	end
})
var_0_0.GAME_STATE = {
	PHASE_2 = 2,
	END = 4,
	PHASE_1 = 1,
	NONE = 0
}
var_0_0.SCORE_RANK = {
	A = 56,
	S = 90,
	C = 0,
	B = 31
}
var_0_0.SCORE_RANK_ORDER = {
	"S",
	"A",
	"B",
	"C"
}

function var_0_0.GetScoreRank(arg_2_0)
	arg_2_0 = arg_2_0 or 0

	for iter_2_0, iter_2_1 in ipairs(var_0_0.SCORE_RANK_ORDER) do
		if arg_2_0 >= var_0_0.SCORE_RANK[iter_2_1] then
			return iter_2_1
		end
	end

	return "C"
end

var_0_0.DECAL_CONFIG = setmetatable({}, {
	__index = function(arg_3_0, arg_3_1)
		var_0_0.InitDecalConfig(arg_3_0)

		return rawget(arg_3_0, arg_3_1)
	end
})
var_0_0.STAINS_CONFIG = setmetatable({}, {
	__index = function(arg_4_0, arg_4_1)
		var_0_0.InitStainsConfig(arg_4_0)

		return rawget(arg_4_0, arg_4_1)
	end
})

function var_0_0.GetDefaultSystemClasses()
	return table.mergeArray({
		CarWashGameFlowSystem
	}, var_0_0.GetGameplaySystemClasses())
end

function var_0_0.GetGameplaySystemClasses()
	return {
		CarWashTimelineSystem,
		CarWashPovControlSystem,
		CarWashRaycastSystem,
		CarWashMuzzleEffect,
		CarWashDecalSystem,
		CarWashGlassMaterialFix,
		CarWashLadySystem
	}
end

function var_0_0.GetDecalConfig(arg_7_0)
	return var_0_0.DECAL_CONFIG[arg_7_0]
end

function var_0_0.GetStainsConfig(arg_8_0)
	return var_0_0.STAINS_CONFIG[arg_8_0]
end

function var_0_0.GetGunConfig(arg_9_0)
	return var_0_0.GUN_CONFIG[arg_9_0]
end

function var_0_0.InitGunConfig(arg_10_0)
	arg_10_0 = arg_10_0 or var_0_0.GUN_CONFIG

	if rawget(arg_10_0, var_0_0.GUN_TYPE.WASHER) then
		return
	end

	arg_10_0[var_0_0.GUN_TYPE.WASHER] = {
		force = 1,
		name = "pre_db_nozzle_01_group02",
		decalType = {
			onCar = DecalType.WATER,
			onLady = DecalType.WATER_ON_LADY
		}
	}
	arg_10_0[var_0_0.GUN_TYPE.FOAM_SPRAYER] = {
		force = 0.5,
		name = "pre_db_nozzle_01_group01",
		decalType = {
			onCar = DecalType.BUBBLE,
			onLady = DecalType.BUBBLE_ON_LADY
		}
	}
	arg_10_0[var_0_0.GUN_TYPE.HIGH_PRESSURE_WASHER] = {
		force = 2,
		name = "pre_db_nozzle_01a_group01",
		decalType = {
			onCar = DecalType.WATER,
			onLady = DecalType.WATER_ON_LADY
		}
	}

	return
end

function var_0_0.InitDecalConfig(arg_11_0)
	arg_11_0 = arg_11_0 or var_0_0.DECAL_CONFIG

	if rawget(arg_11_0, DecalType.BUBBLE) then
		return
	end

	arg_11_0[DecalType.BUBBLE] = {
		autoFadeStartTime = 10,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 2,
		sourceMaterial = {
			0
		},
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 10,
		decalType = DecalType.BUBBLE
	}
	arg_11_0[DecalType.WATER] = {
		autoFadeStartTime = 8,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 3,
		sourceMaterial = {
			1
		},
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 11,
		decalType = DecalType.WATER
	}
	arg_11_0[DecalType.WATER_ON_LADY] = {
		autoFadeStartTime = 5,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 1,
		sourceMaterial = {
			2,
			3,
			4,
			5
		},
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 11,
		decalType = DecalType.WATER_ON_LADY
	}
	arg_11_0[DecalType.BUBBLE_ON_LADY] = {
		autoFadeStartTime = 5,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 1,
		sourceMaterial = {
			6,
			7,
			8,
			9
		},
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 10,
		decalType = DecalType.BUBBLE_ON_LADY
	}

	return
end

function var_0_0.InitStainsConfig(arg_12_0)
	arg_12_0 = arg_12_0 or var_0_0.STAINS_CONFIG

	if rawget(arg_12_0, DecalType.DIRT) then
		return
	end

	arg_12_0[DecalType.DUST] = {
		fadePerSec = 0.5,
		targetGunType = var_0_0.GUN_TYPE.WASHER
	}
	arg_12_0[DecalType.GRAFFITI] = {
		fadePerSec = 0,
		coverBuff = 0.5,
		targetGunType = var_0_0.GUN_TYPE.HIGH_PRESSURE_WASHER,
		coverDecal = DecalType.BUBBLE
	}
	arg_12_0[DecalType.DIRT] = {
		fadePerSec = 0.5,
		targetGunType = var_0_0.GUN_TYPE.HIGH_PRESSURE_WASHER
	}

	return
end

return var_0_0
