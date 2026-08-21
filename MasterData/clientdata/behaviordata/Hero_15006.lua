-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_15006.lua

local Data = {
	["skill.1500609"] = {
		stateName = "skill1500609",
		skillLength = 1.433333,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					time = 0.04446472,
					functionName = "atk"
				},
				effect2 = {
					functionName = "effect",
					data = "Effects/Heros/15006/efx_15006_battle_attack_basic_01.prefab",
					time = 0.1998754,
					stringParameter = "Effects/Heros/15006/efx_15006_battle_attack_basic_01.prefab"
				},
				atk3 = {
					time = 0.7235094,
					functionName = "atk"
				},
				supercancel4 = {
					time = 1.230113,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1500659"] = {
		stateName = "skill1500659",
		skillLength = 2.366667,
		motion = {
			events = {
				vocal1 = {
					functionName = "vocal",
					data = "Audios/Vocal/skill_zhou.ogg",
					stringParameter = "Audios/Vocal/skill_zhou.ogg"
				},
				atk2 = {
					intParameter = 100,
					time = 0.06046228,
					functionName = "atk"
				},
				VideoPause3 = {
					time = 0.3368613,
					functionName = "VideoPause"
				},
				atk4 = {
					intParameter = 11,
					time = 0.4577859,
					functionName = "atk"
				},
				atk5 = {
					time = 1.307282,
					functionName = "atk"
				},
				atk6 = {
					intParameter = 1,
					time = 1.703644,
					functionName = "atk"
				},
				supercancel7 = {
					time = 2.193496,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1500629"] = {
		stateName = "skill1500629",
		skillLength = 2,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					time = 0.03649635,
					functionName = "atk"
				},
				atk2 = {
					time = 1.207364,
					functionName = "atk"
				},
				atk3 = {
					intParameter = 1,
					time = 1.310456,
					functionName = "atk"
				},
				supercancel4 = {
					time = 1.890244,
					functionName = "supercancel"
				}
			}
		}
	}
}

return Data
