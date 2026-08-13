pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "island_combo") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_combo"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.island_combo = var_0_2
pg = var_0

local var_0_3 = var_0.island_combo

var_0_3.all = {
	601101,
	601102,
	602101,
	602102,
	602103,
	603101,
	603102,
	603103,
	604101,
	604102,
	901101,
	901102,
	901103
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.island_combo = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_combo

	var_1_0[13] = {
		id = 601101,
		is_hide = 0,
		unlock_condition = {
			{
				601002,
				5
			},
			{
				601004,
				5
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_combo

	var_1_1[14] = {
		id = 601102,
		is_hide = 1,
		unlock_condition = {
			{
				601003,
				5
			},
			{
				601001,
				5
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_combo

	var_1_2[602101] = {
		id = 602101,
		is_hide = 0,
		unlock_condition = {
			{
				602005,
				5
			},
			{
				602001,
				5
			}
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_combo

	var_1_3[602102] = {
		id = 602102,
		is_hide = 0,
		unlock_condition = {
			{
				602002,
				5
			},
			{
				602006,
				5
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_combo

	var_1_4[602103] = {
		id = 602103,
		is_hide = 1,
		unlock_condition = {
			{
				602004,
				5
			},
			{
				602003,
				5
			}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_combo

	var_1_5[603101] = {
		id = 603101,
		is_hide = 0,
		unlock_condition = {
			{
				603004,
				5
			},
			{
				603001,
				5
			}
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_combo

	var_1_6[603102] = {
		id = 603102,
		is_hide = 0,
		unlock_condition = {
			{
				603005,
				5
			},
			{
				603002,
				5
			}
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_combo

	var_1_7[603103] = {
		id = 603103,
		is_hide = 1,
		unlock_condition = {
			{
				603006,
				5
			},
			{
				603003,
				5
			}
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_combo

	var_1_8[604101] = {
		id = 604101,
		is_hide = 0,
		unlock_condition = {
			{
				604001,
				5
			},
			{
				604002,
				5
			}
		}
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.island_combo

	var_1_9[604102] = {
		id = 604102,
		is_hide = 1,
		unlock_condition = {
			{
				604006,
				5
			},
			{
				604004,
				5
			}
		}
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.island_combo

	var_1_10[901101] = {
		id = 901101,
		is_hide = 0,
		unlock_condition = {
			{
				901001,
				5
			},
			{
				901004,
				5
			}
		}
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.island_combo

	var_1_11[901102] = {
		id = 901102,
		is_hide = 0,
		unlock_condition = {
			{
				901002,
				5
			},
			{
				901003,
				5
			}
		}
	}
	pg = var_1_11
	var_1_11.base.island_combo[901103] = {
		id = 901103,
		is_hide = 1,
		unlock_condition = {
			{
				901005,
				5
			},
			{
				901006,
				5
			}
		}
	}

	return
end)()

return
