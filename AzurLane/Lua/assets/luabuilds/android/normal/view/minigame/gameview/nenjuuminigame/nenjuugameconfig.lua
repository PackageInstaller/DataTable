local var_0_0 = {
	DECOY_RANGE = 5,
	BLACK_HOLE_RANGE = 2,
	LANTERN_RANGE = 3,
	TIME_INTERVAL = 0.016666666666666666,
	STAGE_CONFIG = {
		BASE_CONFIG = {
			base_rate = 1,
			wave = {
				{
					"Item_1",
					5,
					10
				},
				{
					"Item_2",
					5,
					20
				},
				{
					"Item_3",
					5,
					30
				},
				{
					"Item_4",
					5,
					40
				}
			},
			extra_time = {
				120,
				1000
			},
			ability_rate = {
				gravity = 0.5,
				teleport = 0.5,
				doppelgangers = 0.5,
				rush = 0.5,
				delay = 0.5,
				blackhole = 0.5,
				stealth = 0.5,
				breakpassable = 0.5
			},
			ability_config = {
				gravity = true,
				teleport = true,
				doppelgangers = true,
				rush = true,
				delay = true,
				blackhole = true,
				stealth = true,
				breakpassable = true
			}
		},
		Spring23Level_1 = {
			base_rate = 1,
			wave = {
				{
					"Item_1",
					30,
					10
				},
				{
					"Item_2",
					40,
					10
				}
			},
			extra_time = {
				120,
				300
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				rush = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				rush = true
			}
		},
		Spring23Level_2 = {
			base_rate = 1,
			wave = {
				{
					"Item_3",
					20,
					20
				},
				{
					"Item_4",
					30,
					20
				}
			},
			extra_time = {
				120,
				300
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				breakpassable = 0.5,
				rush = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				breakpassable = true,
				rush = true
			}
		},
		Spring23Level_3 = {
			base_rate = 1,
			wave = {
				{
					"Item_6",
					30,
					20
				},
				{
					"Item_5",
					30,
					20
				}
			},
			extra_time = {
				150,
				500
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				doppelgangers = 0.5,
				rush = 0.5,
				breakpassable = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				doppelgangers = true,
				rush = true,
				breakpassable = true
			}
		},
		Spring23Level_4 = {
			base_rate = 1,
			wave = {
				{
					"Item_1",
					30,
					20
				},
				{
					"Item_3",
					30,
					30
				}
			},
			extra_time = {
				150,
				500
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				doppelgangers = 0.5,
				rush = 0.5,
				delay = 0.5,
				breakpassable = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				doppelgangers = true,
				rush = true,
				delay = true,
				breakpassable = true
			}
		},
		Spring23Level_5 = {
			base_rate = 1,
			wave = {
				{
					"Item_2",
					20,
					40
				},
				{
					"Item_4",
					20,
					40
				}
			},
			extra_time = {
				150,
				500
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				doppelgangers = 0.5,
				rush = 0.5,
				delay = 0.5,
				stealth = 0.5,
				breakpassable = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				doppelgangers = true,
				rush = true,
				delay = true,
				stealth = true,
				breakpassable = true
			}
		},
		Spring23Level_6 = {
			base_rate = 1,
			wave = {
				{
					"Item_1",
					30,
					30
				},
				{
					"Item_3",
					30,
					40
				}
			},
			extra_time = {
				150,
				600
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				doppelgangers = 0.5,
				rush = 0.5,
				delay = 0.5,
				stealth = 0.5,
				gravity = 0.5,
				breakpassable = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				doppelgangers = true,
				rush = true,
				delay = true,
				stealth = true,
				gravity = true,
				breakpassable = true
			}
		},
		Spring23Level_7 = {
			base_rate = 1,
			wave = {
				{
					"Item_1",
					5,
					70
				},
				{
					"Item_2",
					5,
					70
				},
				{
					"Item_3",
					5,
					70
				},
				{
					"Item_4",
					5,
					70
				},
				{
					"Item_6",
					5,
					70
				},
				{
					"Item_5",
					5,
					70
				}
			},
			extra_time = {
				120,
				700
			},
			ability_rate = {
				blackhole = 0.5,
				teleport = 0.5,
				doppelgangers = 0.5,
				rush = 0.5,
				delay = 0.5,
				stealth = 0.5,
				gravity = 0.5,
				breakpassable = 0.5
			},
			ability_config = {
				blackhole = true,
				teleport = true,
				doppelgangers = true,
				rush = true,
				delay = true,
				stealth = true,
				gravity = true,
				breakpassable = true
			}
		}
	}
}

function var_0_0.GetStageConfig(arg_1_0)
	setmetatable = var_1_10001

	local var_1_0

	if not var_0_0.STAGE_CONFIG[arg_1_0] then
		var_1_0 = {}
	end

	return var_1_10001(var_1_0, {
		__index = var_0_0.STAGE_CONFIG.BASE_CONFIG
	})
end

function var_0_0.GetCreateConfig(arg_2_0)
	local var_2_0 = {}

	switch = var_1_10002

	var_1_10002(arg_2_0.name, {
		FuShun = function()
			table = var_2_10000

			local var_3_0 = var_2_10000.insert
			local var_3_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_3_0(var_3_1, var_2_10002.TargetFuShun)

			table = var_3_0

			var_3_0.insert(var_2_0, "character/FuShun")

			table = var_0

			var_0.insert(var_2_0, "character")

			return
		end,
		Nenjuu = function()
			table = var_2_10000

			local var_4_0 = var_2_10000.insert
			local var_4_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_4_0(var_4_1, var_2_10002.TargetNenjuu)

			table = var_4_0

			var_4_0.insert(var_2_0, "character/Nenjuu")

			table = var_0

			var_0.insert(var_2_0, "character")

			return
		end,
		Nenjuu_Doppelgangers = function()
			table = var_2_10000

			local var_5_0 = var_2_10000.insert
			local var_5_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_5_0(var_5_1, var_2_10002.TargetNenjuu)

			table = var_5_0

			var_5_0.insert(var_2_0, "character/Nenjuu_Doppelgangers")

			table = var_0

			var_0.insert(var_2_0, "character")

			return
		end,
		Ice = function()
			table = var_2_10000

			local var_6_0 = var_2_10000.insert
			local var_6_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_6_0(var_6_1, var_2_10002.TargetIce)

			table = var_6_0

			var_6_0.insert(var_2_0, "object/Ice")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Bomb = function()
			table = var_2_10000

			local var_7_0 = var_2_10000.insert
			local var_7_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_7_0(var_7_1, var_2_10002.TargetBomb)

			table = var_7_0

			var_7_0.insert(var_2_0, "effect/Bomb")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		SignWarp = function()
			table = var_2_10000

			local var_8_0 = var_2_10000.insert
			local var_8_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_8_0(var_8_1, var_2_10002.TargetTimeEffect)

			table = var_8_0

			var_8_0.insert(var_2_0, "effect/SignWarp")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		Rock = function()
			table = var_2_10000

			local var_9_0 = var_2_10000.insert
			local var_9_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_9_0(var_9_1, var_2_10002.TargetObject)

			table = var_9_0

			var_9_0.insert(var_2_0, "object/Rock")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		BlackHole = function()
			table = var_2_10000

			local var_10_0 = var_2_10000.insert
			local var_10_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_10_0(var_10_1, var_2_10002.TargetBlackHole)

			table = var_10_0

			var_10_0.insert(var_2_0, "object/BlackHole")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Decoy = function()
			table = var_2_10000

			local var_11_0 = var_2_10000.insert
			local var_11_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_11_0(var_11_1, var_2_10002.TargetEffect)

			table = var_11_0

			var_11_0.insert(var_2_0, "effect/Decoy")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_bk_Flash_Jump = function()
			table = var_2_10000

			local var_12_0 = var_2_10000.insert
			local var_12_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_12_0(var_12_1, var_2_10002.TargetEffect)

			table = var_12_0

			var_12_0.insert(var_2_0, "effect/EF_bk_Flash_Jump")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_bk_Flash_Land = function()
			table = var_2_10000

			local var_13_0 = var_2_10000.insert
			local var_13_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_13_0(var_13_1, var_2_10002.TargetSubEffect)

			table = var_13_0

			var_13_0.insert(var_2_0, "effect/EF_bk_Flash_Land")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Break_E = function()
			table = var_2_10000

			local var_14_0 = var_2_10000.insert
			local var_14_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_14_0(var_14_1, var_2_10002.TargetEffect)

			table = var_14_0

			var_14_0.insert(var_2_0, "effect/EF_Break_E")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Break_N = function()
			table = var_2_10000

			local var_15_0 = var_2_10000.insert
			local var_15_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_15_0(var_15_1, var_2_10002.TargetEffect)

			table = var_15_0

			var_15_0.insert(var_2_0, "effect/EF_Break_N")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Break_S = function()
			table = var_2_10000

			local var_16_0 = var_2_10000.insert
			local var_16_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_16_0(var_16_1, var_2_10002.TargetEffect)

			table = var_16_0

			var_16_0.insert(var_2_0, "effect/EF_Break_S")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Break_W = function()
			table = var_2_10000

			local var_17_0 = var_2_10000.insert
			local var_17_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_17_0(var_17_1, var_2_10002.TargetEffect)

			table = var_17_0

			var_17_0.insert(var_2_0, "effect/EF_Break_W")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_E = function()
			table = var_2_10000

			local var_18_0 = var_2_10000.insert
			local var_18_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_18_0(var_18_1, var_2_10002.TargetSubEffect)

			table = var_18_0

			var_18_0.insert(var_2_0, "effect/EF_Attack_E")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_S = function()
			table = var_2_10000

			local var_19_0 = var_2_10000.insert
			local var_19_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_19_0(var_19_1, var_2_10002.TargetSubEffect)

			table = var_19_0

			var_19_0.insert(var_2_0, "effect/EF_Attack_S")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_N = function()
			table = var_2_10000

			local var_20_0 = var_2_10000.insert
			local var_20_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_20_0(var_20_1, var_2_10002.TargetSubEffect)

			table = var_20_0

			var_20_0.insert(var_2_0, "effect/EF_Attack_N")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_W = function()
			table = var_2_10000

			local var_21_0 = var_2_10000.insert
			local var_21_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_21_0(var_21_1, var_2_10002.TargetSubEffect)

			table = var_21_0

			var_21_0.insert(var_2_0, "effect/EF_Attack_W")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_W_bk = function()
			table = var_2_10000

			local var_22_0 = var_2_10000.insert
			local var_22_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_22_0(var_22_1, var_2_10002.TargetSubEffect)

			table = var_22_0

			var_22_0.insert(var_2_0, "effect/EF_Attack_Hit_W_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_W_fr = function()
			table = var_2_10000

			local var_23_0 = var_2_10000.insert
			local var_23_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_23_0(var_23_1, var_2_10002.TargetSubEffect)

			table = var_23_0

			var_23_0.insert(var_2_0, "effect/EF_Attack_Hit_W_fr")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_E_bk = function()
			table = var_2_10000

			local var_24_0 = var_2_10000.insert
			local var_24_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_24_0(var_24_1, var_2_10002.TargetSubEffect)

			table = var_24_0

			var_24_0.insert(var_2_0, "effect/EF_Attack_Hit_E_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_E_fr = function()
			table = var_2_10000

			local var_25_0 = var_2_10000.insert
			local var_25_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_25_0(var_25_1, var_2_10002.TargetSubEffect)

			table = var_25_0

			var_25_0.insert(var_2_0, "effect/EF_Attack_Hit_E_fr")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_N = function()
			table = var_2_10000

			local var_26_0 = var_2_10000.insert
			local var_26_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_26_0(var_26_1, var_2_10002.TargetSubEffect)

			table = var_26_0

			var_26_0.insert(var_2_0, "effect/EF_Attack_Hit_N")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_S = function()
			table = var_2_10000

			local var_27_0 = var_2_10000.insert
			local var_27_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_27_0(var_27_1, var_2_10002.TargetSubEffect)

			table = var_27_0

			var_27_0.insert(var_2_0, "effect/EF_Attack_Hit_S")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_bk_Freeze = function()
			table = var_2_10000

			local var_28_0 = var_2_10000.insert
			local var_28_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_28_0(var_28_1, var_2_10002.TargetSubEffect)

			table = var_28_0

			var_28_0.insert(var_2_0, "effect/EF_bk_Freeze")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_bk_overlay_Lantern = function()
			table = var_2_10000

			local var_29_0 = var_2_10000.insert
			local var_29_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_29_0(var_29_1, var_2_10002.TargetSubEffect)

			table = var_29_0

			var_29_0.insert(var_2_0, "effect/EF_bk_overlay_Lantern")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		Lamp_A = function()
			table = var_2_10000

			local var_30_0 = var_2_10000.insert
			local var_30_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_30_0(var_30_1, var_2_10002.TargetObject)

			table = var_30_0

			var_30_0.insert(var_2_0, "object/Lamp_A")

			table = var_0

			var_0.insert(var_2_0, "object")

			arg_2_0.hide = true

			return
		end,
		Pine = function()
			table = var_2_10000

			local var_31_0 = var_2_10000.insert
			local var_31_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_31_0(var_31_1, var_2_10002.TargetObject)

			table = var_31_0

			var_31_0.insert(var_2_0, "object/Pine")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_31_2 = arg_2_0

			NewPos = var_1
			var_31_2.size = var_1(2, 2)

			return
		end,
		Plum = function()
			table = var_2_10000

			local var_32_0 = var_2_10000.insert
			local var_32_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_32_0(var_32_1, var_2_10002.TargetObject)

			table = var_32_0

			var_32_0.insert(var_2_0, "object/Plum")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_32_2 = arg_2_0

			NewPos = var_1
			var_32_2.size = var_1(2, 2)

			return
		end,
		Pond = function()
			table = var_2_10000

			local var_33_0 = var_2_10000.insert
			local var_33_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_33_0(var_33_1, var_2_10002.TargetObject)

			table = var_33_0

			var_33_0.insert(var_2_0, "object/Pond")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_33_2 = arg_2_0

			NewPos = var_1
			var_33_2.size = var_1(2, 2)

			return
		end,
		Manjuu_fishing = function()
			table = var_2_10000

			local var_34_0 = var_2_10000.insert
			local var_34_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_34_0(var_34_1, var_2_10002.TargetObject)

			table = var_34_0

			var_34_0.insert(var_2_0, "object/Manjuu_fishing")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_34_2 = arg_2_0

			NewPos = var_1
			var_34_2.size = var_1(2, 2)

			return
		end,
		Fire = function()
			table = var_2_10000

			local var_35_0 = var_2_10000.insert
			local var_35_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_35_0(var_35_1, var_2_10002.TargetObject)

			table = var_35_0

			var_35_0.insert(var_2_0, "object/Fire")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_35_2 = arg_2_0

			NewPos = var_1
			var_35_2.size = var_1(3, 3)

			return
		end,
		Building_A = function()
			table = var_2_10000

			local var_36_0 = var_2_10000.insert
			local var_36_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_36_0(var_36_1, var_2_10002.TargetObject)

			table = var_36_0

			var_36_0.insert(var_2_0, "object/Building_A")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_36_2 = arg_2_0

			NewPos = var_1
			var_36_2.size = var_1(3, 3)
			arg_2_0.hide = true

			return
		end,
		Item_1 = function()
			table = var_2_10000

			local var_37_0 = var_2_10000.insert
			local var_37_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_37_0(var_37_1, var_2_10002.TargetItem)

			table = var_37_0

			var_37_0.insert(var_2_0, "object/Item")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Item_2 = function()
			table = var_2_10000

			local var_38_0 = var_2_10000.insert
			local var_38_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_38_0(var_38_1, var_2_10002.TargetItem)

			table = var_38_0

			var_38_0.insert(var_2_0, "object/Item")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Item_3 = function()
			table = var_2_10000

			local var_39_0 = var_2_10000.insert
			local var_39_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_39_0(var_39_1, var_2_10002.TargetItem)

			table = var_39_0

			var_39_0.insert(var_2_0, "object/Item")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Item_4 = function()
			table = var_2_10000

			local var_40_0 = var_2_10000.insert
			local var_40_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_40_0(var_40_1, var_2_10002.TargetItem)

			table = var_40_0

			var_40_0.insert(var_2_0, "object/Item")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Item_5 = function()
			table = var_2_10000

			local var_41_0 = var_2_10000.insert
			local var_41_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_41_0(var_41_1, var_2_10002.TargetItem)

			table = var_41_0

			var_41_0.insert(var_2_0, "object/Item")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Item_6 = function()
			table = var_2_10000

			local var_42_0 = var_2_10000.insert
			local var_42_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_42_0(var_42_1, var_2_10002.TargetItem)

			table = var_42_0

			var_42_0.insert(var_2_0, "object/Item")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		EF_fr_Inactivate = function()
			table = var_2_10000

			local var_43_0 = var_2_10000.insert
			local var_43_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_43_0(var_43_1, var_2_10002.TargetSubEffect)

			table = var_43_0

			var_43_0.insert(var_2_0, "effect/EF_fr_Inactivate")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		EF_Ghost_E_bk = function()
			table = var_2_10000

			local var_44_0 = var_2_10000.insert
			local var_44_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_44_0(var_44_1, var_2_10002.TargetRushEffect)

			table = var_44_0

			var_44_0.insert(var_2_0, "effect/EF_Ghost_E_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_N_bk = function()
			table = var_2_10000

			local var_45_0 = var_2_10000.insert
			local var_45_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_45_0(var_45_1, var_2_10002.TargetRushEffect)

			table = var_45_0

			var_45_0.insert(var_2_0, "effect/EF_Ghost_N_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_N_fr = function()
			table = var_2_10000

			local var_46_0 = var_2_10000.insert
			local var_46_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_46_0(var_46_1, var_2_10002.TargetRushEffect)

			table = var_46_0

			var_46_0.insert(var_2_0, "effect/EF_Ghost_N_fr")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_S_bk = function()
			table = var_2_10000

			local var_47_0 = var_2_10000.insert
			local var_47_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_47_0(var_47_1, var_2_10002.TargetRushEffect)

			table = var_47_0

			var_47_0.insert(var_2_0, "effect/EF_Ghost_S_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_W_bk = function()
			table = var_2_10000

			local var_48_0 = var_2_10000.insert
			local var_48_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_48_0(var_48_1, var_2_10002.TargetRushEffect)

			table = var_48_0

			var_48_0.insert(var_2_0, "effect/EF_Ghost_W_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_E_bk = function()
			table = var_2_10000

			local var_49_0 = var_2_10000.insert
			local var_49_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_49_0(var_49_1, var_2_10002.TargetRushEffect)

			table = var_49_0

			var_49_0.insert(var_2_0, "effect/EF_Nenjuu_Ghost_E_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_N_bk = function()
			table = var_2_10000

			local var_50_0 = var_2_10000.insert
			local var_50_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_50_0(var_50_1, var_2_10002.TargetRushEffect)

			table = var_50_0

			var_50_0.insert(var_2_0, "effect/EF_Nenjuu_Ghost_N_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_N_fr = function()
			table = var_2_10000

			local var_51_0 = var_2_10000.insert
			local var_51_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_51_0(var_51_1, var_2_10002.TargetRushEffect)

			table = var_51_0

			var_51_0.insert(var_2_0, "effect/EF_Nenjuu_Ghost_N_fr")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_S_bk = function()
			table = var_2_10000

			local var_52_0 = var_2_10000.insert
			local var_52_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_52_0(var_52_1, var_2_10002.TargetRushEffect)

			table = var_52_0

			var_52_0.insert(var_2_0, "effect/EF_Nenjuu_Ghost_S_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_W_bk = function()
			table = var_2_10000

			local var_53_0 = var_2_10000.insert
			local var_53_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_53_0(var_53_1, var_2_10002.TargetRushEffect)

			table = var_53_0

			var_53_0.insert(var_2_0, "effect/EF_Nenjuu_Ghost_W_bk")

			table = var_0

			var_0.insert(var_2_0, "effect")

			return
		end,
		Snow_1 = function()
			table = var_2_10000

			local var_54_0 = var_2_10000.insert
			local var_54_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_54_0(var_54_1, var_2_10002.TargetObject)

			table = var_54_0

			var_54_0.insert(var_2_0, "object/Snow_1")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Snow_2 = function()
			table = var_2_10000

			local var_55_0 = var_2_10000.insert
			local var_55_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_55_0(var_55_1, var_2_10002.TargetObject)

			table = var_55_0

			var_55_0.insert(var_2_0, "object/Snow_2")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Snow_3 = function()
			table = var_2_10000

			local var_56_0 = var_2_10000.insert
			local var_56_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_56_0(var_56_1, var_2_10002.TargetObject)

			table = var_56_0

			var_56_0.insert(var_2_0, "object/Snow_3")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Snow_4 = function()
			table = var_2_10000

			local var_57_0 = var_2_10000.insert
			local var_57_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_57_0(var_57_1, var_2_10002.TargetObject)

			table = var_57_0

			var_57_0.insert(var_2_0, "object/Snow_4")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end,
		Snow_5 = function()
			table = var_2_10000

			local var_58_0 = var_2_10000.insert
			local var_58_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_58_0(var_58_1, var_2_10002.TargetObject)

			table = var_58_0

			var_58_0.insert(var_2_0, "object/Snow_5")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_58_2 = arg_2_0

			NewPos = var_1
			var_58_2.size = var_1(2, 1)
			arg_2_0.hide = true

			return
		end,
		Lamp_B1 = function()
			table = var_2_10000

			local var_59_0 = var_2_10000.insert
			local var_59_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_59_0(var_59_1, var_2_10002.TargetObject)

			table = var_59_0

			var_59_0.insert(var_2_0, "object/Lamp_B1")

			table = var_0

			var_0.insert(var_2_0, "object")

			arg_2_0.hide = true

			return
		end,
		Lamp_B2 = function()
			table = var_2_10000

			local var_60_0 = var_2_10000.insert
			local var_60_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_60_0(var_60_1, var_2_10002.TargetObject)

			table = var_60_0

			var_60_0.insert(var_2_0, "object/Lamp_B2")

			table = var_0

			var_0.insert(var_2_0, "object")

			arg_2_0.hide = true

			return
		end,
		Building_B = function()
			table = var_2_10000

			local var_61_0 = var_2_10000.insert
			local var_61_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_61_0(var_61_1, var_2_10002.TargetObject)

			table = var_61_0

			var_61_0.insert(var_2_0, "object/Building_B")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_61_2 = arg_2_0

			NewPos = var_1
			var_61_2.size = var_1(4, 3)
			arg_2_0.hide = true

			return
		end,
		["1_Arbor_1"] = function()
			table = var_2_10000

			local var_62_0 = var_2_10000.insert
			local var_62_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_62_0(var_62_1, var_2_10002.TargetArbor)

			table = var_62_0

			var_62_0.insert(var_2_0, "object/Arbor")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_62_2 = arg_2_0

			NewPos = var_1
			var_62_2.size = var_1(2, 2)
			arg_2_0.hide = true

			return
		end,
		["1_Arbor_2"] = function()
			table = var_2_10000

			local var_63_0 = var_2_10000.insert
			local var_63_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_63_0(var_63_1, var_2_10002.TargetArbor)

			table = var_63_0

			var_63_0.insert(var_2_0, "object/Arbor")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_63_2 = arg_2_0

			NewPos = var_1
			var_63_2.size = var_1(2, 2)
			arg_2_0.hide = true

			return
		end,
		["1_Arbor_3"] = function()
			table = var_2_10000

			local var_64_0 = var_2_10000.insert
			local var_64_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_64_0(var_64_1, var_2_10002.TargetArbor)

			table = var_64_0

			var_64_0.insert(var_2_0, "object/Arbor")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_64_2 = arg_2_0

			NewPos = var_1
			var_64_2.size = var_1(2, 2)
			arg_2_0.hide = true

			return
		end,
		["1_Arbor_4"] = function()
			table = var_2_10000

			local var_65_0 = var_2_10000.insert
			local var_65_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_65_0(var_65_1, var_2_10002.TargetArbor)

			table = var_65_0

			var_65_0.insert(var_2_0, "object/Arbor")

			table = var_0

			var_0.insert(var_2_0, "object")

			local var_65_2 = arg_2_0

			NewPos = var_1
			var_65_2.size = var_1(2, 2)
			arg_2_0.hide = true

			return
		end,
		Dango_1 = function()
			table = var_2_10000

			local var_66_0 = var_2_10000.insert
			local var_66_1 = var_2_0

			NenjuuGameNameSpace = var_2_10002

			var_66_0(var_66_1, var_2_10002.TargetObject)

			table = var_66_0

			var_66_0.insert(var_2_0, "object/Dango")

			table = var_0

			var_0.insert(var_2_0, "object")

			return
		end
	}, function()
		warning = var_2_10000

		var_2_10000("name error:" .. arg_2_0.name)

		table = var_2_10000

		var_2_10000.insert(var_2_0, false)

		return
	end)

	unpack = var_1_10002

	return var_1_10002(var_2_0)
end

var_0_0.SKILL_LEVEL_CONFIG = {
	ice = {
		level = 1,
		cost = {
			0,
			1000,
			1000
		},
		param = {
			7,
			9,
			11
		}
	},
	flash = {
		level = 0,
		cost = {
			2000,
			2000,
			2000
		},
		param = {
			30,
			25,
			20
		}
	},
	rush = {
		level = 0,
		cost = {
			2000,
			2000,
			2000
		},
		param = {
			{
				5,
				1.2
			},
			{
				5,
				1.3
			},
			{
				7,
				1.3
			}
		}
	},
	blessing = {
		level = 0,
		cost = {
			2000,
			1000,
			1000
		},
		param = {
			1.03,
			1.06,
			1.1
		}
	},
	decoy = {
		level = 0,
		cost = {
			5000
		}
	},
	bomb = {
		level = 0,
		cost = {
			1000
		}
	},
	lantern = {
		level = 0,
		cost = {
			1000
		}
	}
}

function var_0_0.GetSkillParam(arg_68_0, arg_68_1)
	return var_0_0.SKILL_LEVEL_CONFIG[arg_68_0].param[arg_68_1]
end

var_0_0.ITEM_LIST = {
	"bomb",
	"lantern"
}

function var_0_0.ParsingElements(arg_69_0)
	local var_69_0 = {}
	local var_69_1

	if not arg_69_0[1] then
		var_69_1 = 0
	end

	var_69_0.high = var_69_1

	local var_69_2

	if not arg_69_0[2] then
		var_69_2 = 0
	end

	var_69_0.count = var_69_2

	local var_69_3

	if not arg_69_0[3] or not var_0_0.ITEM_LIST[arg_69_0[3]] then
		var_69_3 = nil
	end

	var_69_0.item = var_69_3

	for iter_69_0 = 1, 7 do
		local var_69_4 = "stage_" .. iter_69_0
		local var_69_5

		if not arg_69_0[iter_69_0 + 3] then
			var_69_5 = 0
		end

		var_69_0[var_69_4] = var_69_5
	end

	var_69_0.level = {}
	ipairs = var_2

	for iter_69_1, iter_69_2 in var_2({
		"bomb",
		"lantern",
		"ice",
		"flash",
		"rush",
		"blessing",
		"decoy"
	}) do
		local var_69_6 = var_69_0.level
		local var_69_7

		if not arg_69_0[iter_69_1 + 10] then
			var_69_7 = var_0_0.SKILL_LEVEL_CONFIG[iter_69_2].level
		end

		var_69_6[iter_69_2] = var_69_7
	end

	return var_69_0
end

var_0_0.ABILITY_LIST = {
	"teleport",
	"rush",
	"breakpassable",
	"gravity",
	"doppelgangers",
	"delay",
	"blackhole",
	"stealth"
}

return var_0_0
