local CarWashConst = class("CarWashConst")

CarWashConst.DEFAULT_RAY_DISTANCE = 3
CarWashConst.DEFAULT_DECAL_RENDER_QUEUE = 2600
CarWashConst.CAR_LAYER = 26
CarWashConst.CAR_LAYER_MASK = bit.lshift(1, CarWashConst.CAR_LAYER)
CarWashConst.LADY_LAYER = LayerMask.NameToLayer("Character3D")
CarWashConst.LADY_LAYER_MASK = bit.lshift(1, CarWashConst.LADY_LAYER)
CarWashConst.PLAYER_LAYER = LayerMask.NameToLayer("Player")
CarWashConst.PLAYER_LAYER_MASK = bit.lshift(1, CarWashConst.PLAYER_LAYER)
CarWashConst.DEFAULT_LADY_DECAL_SIZE = 0.1
CarWashConst.LAYER_MASK = bit.bor(CarWashConst.CAR_LAYER_MASK, CarWashConst.LADY_LAYER_MASK)
CarWashConst.DECAL_LAYER = LayerMask.NameToLayer("CameraRT")
CarWashConst.DECAL_LAYER_MASK = bit.lshift(1, CarWashConst.DECAL_LAYER)
CarWashConst.EFFECT_LAYER_MASK = bit.bnot(bit.bor(CarWashConst.DECAL_LAYER_MASK, CarWashConst.PLAYER_LAYER_MASK))
CarWashConst.HIDDEN_REACTION_TRIGGER_TIME = 2
CarWashConst.GAME_DURATION = 300
CarWashConst.ORTHOGRAPHIC_SIZE_RANGE = {
	0.3,
	0.4
}
CarWashConst.ROTATE_RANGE = {
	0,
	360
}
CarWashConst.GUN_TYPE = {
	FOAM_SPRAYER = 2,
	WASHER = 1,
	HIGH_PRESSURE_WASHER = 3
}
CarWashConst.GUN_CONFIG = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		CarWashConst.InitGunConfig(arg_1_0)

		return rawget(arg_1_0, arg_1_1)
	end
})
CarWashConst.GAME_STATE = {
	PHASE_2 = 2,
	END = 4,
	PHASE_1 = 1,
	NONE = 0
}
CarWashConst.SCORE_RANK = {
	A = 56,
	S = 90,
	C = 0,
	B = 31
}
CarWashConst.SCORE_RANK_ORDER = {
	"S",
	"A",
	"B",
	"C"
}

function CarWashConst:GetScoreRank()
	self = self or 0

	for iter_2_0, iter_2_1 in ipairs(CarWashConst.SCORE_RANK_ORDER) do
		if self >= CarWashConst.SCORE_RANK[iter_2_1] then
			return iter_2_1
		end
	end

	return "C"
end

CarWashConst.DECAL_CONFIG = setmetatable({}, {
	__index = function(arg_3_0, arg_3_1)
		CarWashConst.InitDecalConfig(arg_3_0)

		return rawget(arg_3_0, arg_3_1)
	end
})
CarWashConst.STAINS_CONFIG = setmetatable({}, {
	__index = function(arg_4_0, arg_4_1)
		CarWashConst.InitStainsConfig(arg_4_0)

		return rawget(arg_4_0, arg_4_1)
	end
})

function CarWashConst.GetDefaultSystemClasses()
	return table.mergeArray({
		CarWashGameFlowSystem
	}, CarWashConst.GetGameplaySystemClasses())
end

function CarWashConst.GetGameplaySystemClasses()
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

function CarWashConst:GetDecalConfig()
	return CarWashConst.DECAL_CONFIG[self]
end

function CarWashConst:GetStainsConfig()
	return CarWashConst.STAINS_CONFIG[self]
end

function CarWashConst:GetGunConfig()
	return CarWashConst.GUN_CONFIG[self]
end

function CarWashConst:InitGunConfig()
	self = self or CarWashConst.GUN_CONFIG

	if rawget(self, CarWashConst.GUN_TYPE.WASHER) then
		return
	end

	self[CarWashConst.GUN_TYPE.WASHER] = {
		force = 1,
		name = "pre_db_nozzle_01_group02",
		decalType = {
			onCar = DecalType.WATER,
			onLady = DecalType.WATER_ON_LADY
		}
	}
	self[CarWashConst.GUN_TYPE.FOAM_SPRAYER] = {
		force = 0.5,
		name = "pre_db_nozzle_01_group01",
		decalType = {
			onCar = DecalType.BUBBLE,
			onLady = DecalType.BUBBLE_ON_LADY
		}
	}
	self[CarWashConst.GUN_TYPE.HIGH_PRESSURE_WASHER] = {
		force = 2,
		name = "pre_db_nozzle_01a_group01",
		decalType = {
			onCar = DecalType.WATER,
			onLady = DecalType.WATER_ON_LADY
		}
	}

	return
end

function CarWashConst:InitDecalConfig()
	self = self or CarWashConst.DECAL_CONFIG

	if rawget(self, DecalType.BUBBLE) then
		return
	end

	self[DecalType.BUBBLE] = {
		autoFadeStartTime = 10,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 2,
		sourceMaterial = {
			0
		},
		renderQueue = CarWashConst.DEFAULT_DECAL_RENDER_QUEUE + 10,
		decalType = DecalType.BUBBLE
	}
	self[DecalType.WATER] = {
		autoFadeStartTime = 8,
		aspectRatio = 1,
		useAutoFade = true,
		autoFadeTime = 3,
		sourceMaterial = {
			1
		},
		renderQueue = CarWashConst.DEFAULT_DECAL_RENDER_QUEUE + 11,
		decalType = DecalType.WATER
	}
	self[DecalType.WATER_ON_LADY] = {
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
		renderQueue = CarWashConst.DEFAULT_DECAL_RENDER_QUEUE + 11,
		decalType = DecalType.WATER_ON_LADY
	}
	self[DecalType.BUBBLE_ON_LADY] = {
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
		renderQueue = CarWashConst.DEFAULT_DECAL_RENDER_QUEUE + 10,
		decalType = DecalType.BUBBLE_ON_LADY
	}

	return
end

function CarWashConst:InitStainsConfig()
	self = self or CarWashConst.STAINS_CONFIG

	if rawget(self, DecalType.DIRT) then
		return
	end

	self[DecalType.DUST] = {
		fadePerSec = 0.5,
		targetGunType = CarWashConst.GUN_TYPE.WASHER
	}
	self[DecalType.GRAFFITI] = {
		fadePerSec = 0,
		coverBuff = 0.5,
		targetGunType = CarWashConst.GUN_TYPE.HIGH_PRESSURE_WASHER,
		coverDecal = DecalType.BUBBLE
	}
	self[DecalType.DIRT] = {
		fadePerSec = 0.5,
		targetGunType = CarWashConst.GUN_TYPE.HIGH_PRESSURE_WASHER
	}

	return
end

return CarWashConst
