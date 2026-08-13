class = var_0_10000

local var_0_0 = var_0_10000("CarWashConst")

var_0_0.DEFAULT_RAY_DISTANCE = 3
var_0_0.DEFAULT_DECAL_RENDER_QUEUE = 2600
var_0_0.CAR_LAYER = 26
bit = var_1
var_0_0.CAR_LAYER_MASK = var_1.lshift(1, var_0_0.CAR_LAYER)
LayerMask = var_1
var_0_0.LADY_LAYER = var_1.NameToLayer("Character3D")
bit = var_1
var_0_0.LADY_LAYER_MASK = var_1.lshift(1, var_0_0.LADY_LAYER)
LayerMask = var_1
var_0_0.PLAYER_LAYER = var_1.NameToLayer("Player")
bit = var_1
var_0_0.PLAYER_LAYER_MASK = var_1.lshift(1, var_0_0.PLAYER_LAYER)
var_0_0.DEFAULT_LADY_DECAL_SIZE = 0.1
bit = var_1
var_0_0.LAYER_MASK = var_1.bor(var_0_0.CAR_LAYER_MASK, var_0_0.LADY_LAYER_MASK)
LayerMask = var_1
var_0_0.DECAL_LAYER = var_1.NameToLayer("CameraRT")
bit = var_1
var_0_0.DECAL_LAYER_MASK = var_1.lshift(1, var_0_0.DECAL_LAYER)
bit = var_1

local var_0_1 = var_1.bnot

bit = var_3
var_0_0.EFFECT_LAYER_MASK = var_0_1(var_3.bor(var_0_0.DECAL_LAYER_MASK, var_0_0.PLAYER_LAYER_MASK))
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
setmetatable = var_1
var_0_0.GUN_CONFIG = var_1({}, {
	__index = function(arg_1_0, arg_1_1)
		var_0_0.InitGunConfig(arg_1_0)

		rawget = var_2

		return var_2(arg_1_0, arg_1_1)
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
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(var_0_0.SCORE_RANK_ORDER) do
		if arg_2_0 >= var_0_0.SCORE_RANK[iter_2_1] then
			return iter_2_1
		end
	end

	return "C"
end

setmetatable = var_1
var_0_0.DECAL_CONFIG = var_1({}, {
	__index = function(arg_3_0, arg_3_1)
		var_0_0.InitDecalConfig(arg_3_0)

		rawget = var_2

		return var_2(arg_3_0, arg_3_1)
	end
})
setmetatable = var_1
var_0_0.STAINS_CONFIG = var_1({}, {
	__index = function(arg_4_0, arg_4_1)
		var_0_0.InitStainsConfig(arg_4_0)

		rawget = var_2

		return var_2(arg_4_0, arg_4_1)
	end
})

function var_0_0.GetDefaultSystemClasses()
	table = var_1_10000

	local var_5_0 = var_1_10000.mergeArray
	local var_5_1 = {}

	CarWashGameFlowSystem = var_1_10003
	var_5_1[1] = var_1_10003

	return var_5_0(var_5_1, var_0_0.GetGameplaySystemClasses())
end

function var_0_0.GetGameplaySystemClasses()
	local var_6_0 = {}

	CarWashTimelineSystem = var_1_10001
	var_6_0[1] = var_1_10001
	CarWashPovControlSystem = var_1_10001
	var_6_0[2] = var_1_10001
	CarWashRaycastSystem = var_1_10001
	var_6_0[3] = var_1_10001
	CarWashMuzzleEffect = var_1_10001
	var_6_0[4] = var_1_10001
	CarWashDecalSystem = var_1_10001
	var_6_0[5] = var_1_10001
	CarWashGlassMaterialFix = var_1_10001
	var_6_0[6] = var_1_10001
	CarWashLadySystem = var_1_10001
	var_6_0[7] = var_1_10001

	return var_6_0
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
	rawget = var_1_10001

	if var_1_10001(arg_10_0, var_0_0.GUN_TYPE.WASHER) then
		return
	end

	local var_10_0 = var_0_0.GUN_TYPE.WASHER
	local var_10_1 = {
		force = 1,
		name = "pre_db_nozzle_01_group02"
	}
	local var_10_2 = {}

	DecalType = var_4
	var_10_2.onCar = var_4.WATER
	DecalType = var_4
	var_10_2.onLady = var_4.WATER_ON_LADY
	var_10_1.decalType = var_10_2
	arg_10_0[var_10_0] = var_10_1

	local var_10_3 = var_0_0.GUN_TYPE.FOAM_SPRAYER
	local var_10_4 = {
		force = 0.5,
		name = "pre_db_nozzle_01_group01"
	}
	local var_10_5 = {}

	DecalType = var_4
	var_10_5.onCar = var_4.BUBBLE
	DecalType = var_4
	var_10_5.onLady = var_4.BUBBLE_ON_LADY
	var_10_4.decalType = var_10_5
	arg_10_0[var_10_3] = var_10_4

	local var_10_6 = var_0_0.GUN_TYPE.HIGH_PRESSURE_WASHER
	local var_10_7 = {
		force = 2,
		name = "pre_db_nozzle_01a_group01"
	}
	local var_10_8 = {}

	DecalType = var_4
	var_10_8.onCar = var_4.WATER
	DecalType = var_4
	var_10_8.onLady = var_4.WATER_ON_LADY
	var_10_7.decalType = var_10_8
	arg_10_0[var_10_6] = var_10_7

	return
end

function var_0_0.InitDecalConfig(arg_11_0)
	arg_11_0 = arg_11_0 or var_0_0.DECAL_CONFIG
	rawget = var_1_10001

	local var_11_0 = arg_11_0

	DecalType = var_1_10004

	if var_1_10001(var_11_0, var_1_10004.BUBBLE) then
		return
	end

	DecalType = var_1

	local var_11_1 = var_1.BUBBLE
	local var_11_2 = {
		autoFadeStartTime = 10,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 2,
		sourceMaterial = {
			0
		},
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 10
	}

	DecalType = var_3
	var_11_2.decalType = var_3.BUBBLE
	arg_11_0[var_11_1] = var_11_2
	DecalType = var_11_1

	local var_11_3 = var_11_1.WATER
	local var_11_4 = {
		autoFadeStartTime = 8,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 3,
		sourceMaterial = {
			1
		},
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 11
	}

	DecalType = var_3
	var_11_4.decalType = var_3.WATER
	arg_11_0[var_11_3] = var_11_4
	DecalType = var_11_3

	local var_11_5 = var_11_3.WATER_ON_LADY
	local var_11_6 = {
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
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 11
	}

	DecalType = var_3
	var_11_6.decalType = var_3.WATER_ON_LADY
	arg_11_0[var_11_5] = var_11_6
	DecalType = var_11_5

	local var_11_7 = var_11_5.BUBBLE_ON_LADY
	local var_11_8 = {
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
		renderQueue = var_0_0.DEFAULT_DECAL_RENDER_QUEUE + 10
	}

	DecalType = var_3
	var_11_8.decalType = var_3.BUBBLE_ON_LADY
	arg_11_0[var_11_7] = var_11_8

	return
end

function var_0_0.InitStainsConfig(arg_12_0)
	arg_12_0 = arg_12_0 or var_0_0.STAINS_CONFIG
	rawget = var_1_10001

	local var_12_0 = arg_12_0

	DecalType = var_1_10004

	if var_1_10001(var_12_0, var_1_10004.DIRT) then
		return
	end

	DecalType = var_1
	arg_12_0[var_1.DUST] = {
		fadePerSec = 0.5,
		targetGunType = var_0_0.GUN_TYPE.WASHER
	}
	DecalType = var_1

	local var_12_1 = var_1.GRAFFITI
	local var_12_2 = {
		fadePerSec = 0,
		coverBuff = 0.5,
		targetGunType = var_0_0.GUN_TYPE.HIGH_PRESSURE_WASHER
	}

	DecalType = var_3
	var_12_2.coverDecal = var_3.BUBBLE
	arg_12_0[var_12_1] = var_12_2
	DecalType = var_12_1
	arg_12_0[var_12_1.DIRT] = {
		fadePerSec = 0.5,
		targetGunType = var_0_0.GUN_TYPE.HIGH_PRESSURE_WASHER
	}

	return
end

return var_0_0
