-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_12010.lua

local Data = {
	["skill.1201009"] = {
		stateName = "skill1201009",
		skillLength = 1.333333,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/12008/efx_12008_battle_attack_basic_01.prefab",
					stringParameter = "Effects/Heros/12008/efx_12008_battle_attack_basic_01.prefab"
				},
				audio2 = {
					functionName = "audio",
					data = "Audios/SFX/Hero/hero_vocal_battle_12008_11_1.ogg",
					stringParameter = "Audios/SFX/Hero/hero_vocal_battle_12008_11_1.ogg"
				},
				atk3 = {
					intParameter = 1,
					time = 0.4717528,
					functionName = "atk"
				},
				supercancel4 = {
					time = 0.9435383,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1201059"] = {
		stateName = "skill1201059",
		skillLength = 1.766667,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					functionName = "atk"
				},
				effect2 = {
					functionName = "effect",
					data = "Effects/Heros/12010/efx_12010_battle_attack_ultra_01.prefab",
					stringParameter = "Effects/Heros/12010/efx_12010_battle_attack_ultra_01.prefab"
				},
				atk3 = {
					intParameter = 1,
					time = 0.8689238,
					functionName = "atk"
				},
				atk4 = {
					intParameter = 5,
					time = 0.9206048,
					functionName = "atk"
				},
				supercancel5 = {
					time = 1.346486,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1201010"] = {
		stateName = "skill1201010",
		skillLength = 1.333333,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/12008/efx_12008_battle_attack_basic_02.prefab",
					stringParameter = "Effects/Heros/12008/efx_12008_battle_attack_basic_02.prefab"
				},
				audio2 = {
					functionName = "audio",
					data = "Audios/SFX/Hero/hero_vocal_battle_12008_12_1.ogg",
					stringParameter = "Audios/SFX/Hero/hero_vocal_battle_12008_12_1.ogg"
				},
				atk3 = {
					intParameter = 1,
					time = 0.4906103,
					functionName = "atk"
				},
				supercancel4 = {
					time = 0.9786701,
					functionName = "supercancel"
				}
			}
		}
	}
}

return Data
