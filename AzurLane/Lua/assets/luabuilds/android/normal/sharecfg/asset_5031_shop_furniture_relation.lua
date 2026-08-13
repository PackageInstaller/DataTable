pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "shop_furniture_relation") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "shop_furniture_relation"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.shop_furniture_relation = var_0_2
pg = var_0

local var_0_3 = var_0.shop_furniture_relation

var_0_3.__namecode__ = true
pg = var_0_3

local var_0_4 = var_0_3.shop_furniture_relation

var_0_4.all = {
	70626,
	70633,
	70629,
	70671,
	70700,
	70715,
	70921
}
pg = var_0_4

local var_0_5 = var_0_4.shop_furniture_relation

var_0_5.get_id_list_by_fur_id = {
	[200001] = {
		70633
	},
	[200002] = {
		70629
	},
	[200003] = {
		70626
	},
	[200004] = {
		70671
	},
	[200005] = {
		70700
	},
	[200006] = {
		70715
	},
	[200009] = {
		70921
	}
}
pg = var_0_5
pg = var_1

local var_0_6

if not var_1.base then
	var_0_6 = {}
end

var_0_5.base = var_0_6
pg = var_0_5
var_0_5.base.shop_furniture_relation = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.shop_furniture_relation

	var_1_0[70626] = {
		fur_id = 200003,
		id = 70626,
		desc = "鲪——“不情愿”的圣夜祭",
		scale = {
			0.65,
			0.7
		},
		position = {
			[2] = {
				0,
				-40
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.shop_furniture_relation

	var_1_1[70633] = {
		fur_id = 200001,
		id = 70633,
		desc = "奥古斯特·冯·帕塞瓦尔——女仆魔女",
		scale = {
			1.1,
			1.1
		},
		position = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.shop_furniture_relation

	var_1_2[70629] = {
		fur_id = 200002,
		id = 70629,
		desc = "阿达尔伯特亲王——闭店后的特别时光",
		scale = {
			0.75,
			0.75
		},
		position = {
			[2] = {
				-39,
				-24
			}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.shop_furniture_relation

	var_1_3[15] = {
		fur_id = 200004,
		id = 70671,
		desc = "阿尔汉格尔斯克——择日而航",
		scale = {
			0.75,
			0.75
		},
		position = {
			[2] = {
				-10,
				-41
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.shop_furniture_relation

	var_1_4[70700] = {
		fur_id = 200005,
		id = 70700,
		desc = "{namecode:427}——沉醉于夜",
		scale = {
			0.65,
			0.75
		},
		position = {
			[2] = {
				30,
				-50
			}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.shop_furniture_relation

	var_1_5[70715] = {
		fur_id = 200006,
		id = 70715,
		desc = "{namecode:97}——放学后的甜蜜时光",
		scale = {
			1,
			0.9
		},
		position = {
			{
				-65,
				-165
			},
			{
				-54,
				-20
			}
		}
	}
	pg = var_1_5
	var_1_5.base.shop_furniture_relation[9] = {
		fur_id = 200009,
		id = 70921,
		desc = "金鹿号——古堡中的恐怖淑女",
		scale = {
			1,
			0.9
		},
		position = {
			{
				-65,
				-165
			},
			{
				-15,
				-20
			}
		}
	}

	return
end)()

return
