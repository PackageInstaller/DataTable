-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResPetGashaponDrawUp.lua

local RT = {}

RT[1] = {
	"Effects/UI/efx_ui_PetPoolResultGridCanvas_06_01.prefab",
	"Effects/UI/efx_ui_PetPoolResultGridCanvas_06_02.prefab"
}

local Data = {
	[1351] = {
		lib = 3,
		pet_id = 900004,
		id = 1351,
		replace_path = "System/PetPool/PetPoolLinked",
		show = 2,
		slogan = Lang.get(90358)
	},
	[1352] = {
		id = 1352,
		pet_id = 900005,
		show = 3,
		lib = 4,
		replace_path = "System/PetPool/PetPoolLinked01",
		effect_path = {
			"Effects/UI/efx_ui_PetPoolResultGridCanvas_05_01.prefab",
			"Effects/UI/efx_ui_PetPoolResultGridCanvas_05_02.prefab"
		},
		slogan = Lang.get(90359)
	},
	[1353] = {
		id = 1353,
		pet_id = 900006,
		show = 4,
		lib = 5,
		replace_path = "System/PetPool/PetPoolLinked02",
		effect_path = RT[1],
		slogan = Lang.get(90817)
	},
	[1354] = {
		id = 1354,
		pet_id = 900007,
		show = 5,
		lib = 6,
		replace_path = "System/PetPool/PetPoolLinked03",
		effect_path = RT[1],
		slogan = Lang.get(102993)
	},
	[1355] = {
		id = 1355,
		pet_id = 900008,
		show = 6,
		lib = 7,
		replace_path = "System/PetPool/PetPoolLinked04",
		effect_path = {
			"Effects/UI/efx_ui_PetPoolResultGridCanvas_07_01.prefab",
			"Effects/UI/efx_ui_PetPoolResultGridCanvas_07_02.prefab"
		},
		slogan = Lang.get(114965)
	}
}

return Data
