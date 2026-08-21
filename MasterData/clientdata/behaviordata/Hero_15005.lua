-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_15005.lua

local Data = {
	["skill.1500501"] = {
		stateName = "skill1500501",
		skillLength = 1.233333,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/13007/efx_13007_battle_attack_basic_01_hand.prefab",
					stringParameter = "Effects/Heros/13007/efx_13007_battle_attack_basic_01_hand.prefab"
				},
				audio2 = {
					intParameter = 1,
					functionName = "audio",
					time = 0.03532986,
					stringParameter = "Audios/SFX/Hero/hero_vocal_battle_15005_11_1.ogg",
					data = "Audios/SFX/Hero/hero_vocal_battle_15005_11_1.ogg"
				},
				atk3 = {
					intParameter = 1,
					time = 0.4809566,
					functionName = "atk"
				},
				supercancel4 = {
					intParameter = 1,
					time = 0.9795483,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1500551"] = {
		stateName = "skill1500551",
		skillLength = 1.533333,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/15005/efx_15005_battle_attack_ultra_01.prefab",
					stringParameter = "Effects/Heros/15005/efx_15005_battle_attack_ultra_01.prefab"
				},
				atk2 = {
					intParameter = 10,
					functionName = "atk"
				},
				atk3 = {
					intParameter = 1,
					time = 0.7952974,
					functionName = "atk"
				}
			}
		}
	},
	["skill.1500521"] = {
		stateName = "skill1500521",
		skillLength = 2.333333,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/15005/efx_15005_battle_attack_passive_01.prefab",
					stringParameter = "Effects/Heros/15005/efx_15005_battle_attack_passive_01.prefab"
				},
				atk2 = {
					intParameter = 100,
					time = 0.06055363,
					functionName = "atk"
				},
				atk3 = {
					intParameter = 1,
					time = 1.617877,
					functionName = "atk"
				}
			}
		}
	}
}

return Data
