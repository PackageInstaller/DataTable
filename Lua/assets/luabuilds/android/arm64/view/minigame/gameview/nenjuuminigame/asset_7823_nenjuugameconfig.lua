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
	return setmetatable(var_0_0.STAGE_CONFIG[arg_1_0] or {}, {
		__index = var_0_0.STAGE_CONFIG.BASE_CONFIG
	})
end

function var_0_0:GetCreateConfig()
	local var_2_0 = {}

	switch(self.name, {
		FuShun = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetFuShun)
			table.insert(var_2_0, "character/FuShun")
			table.insert(var_2_0, "character")

			return
		end,
		Nenjuu = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetNenjuu)
			table.insert(var_2_0, "character/Nenjuu")
			table.insert(var_2_0, "character")

			return
		end,
		Nenjuu_Doppelgangers = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetNenjuu)
			table.insert(var_2_0, "character/Nenjuu_Doppelgangers")
			table.insert(var_2_0, "character")

			return
		end,
		Ice = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetIce)
			table.insert(var_2_0, "object/Ice")
			table.insert(var_2_0, "object")

			return
		end,
		Bomb = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetBomb)
			table.insert(var_2_0, "effect/Bomb")
			table.insert(var_2_0, "object")

			return
		end,
		SignWarp = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetTimeEffect)
			table.insert(var_2_0, "effect/SignWarp")
			table.insert(var_2_0, "effect")

			return
		end,
		Rock = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Rock")
			table.insert(var_2_0, "object")

			return
		end,
		BlackHole = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetBlackHole)
			table.insert(var_2_0, "object/BlackHole")
			table.insert(var_2_0, "object")

			return
		end,
		Decoy = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetEffect)
			table.insert(var_2_0, "effect/Decoy")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_bk_Flash_Jump = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetEffect)
			table.insert(var_2_0, "effect/EF_bk_Flash_Jump")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_bk_Flash_Land = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_bk_Flash_Land")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Break_E = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetEffect)
			table.insert(var_2_0, "effect/EF_Break_E")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Break_N = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetEffect)
			table.insert(var_2_0, "effect/EF_Break_N")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Break_S = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetEffect)
			table.insert(var_2_0, "effect/EF_Break_S")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Break_W = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetEffect)
			table.insert(var_2_0, "effect/EF_Break_W")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_E = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_E")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_S = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_S")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_N = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_N")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_W = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_W")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_W_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_Hit_W_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_W_fr = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_Hit_W_fr")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_E_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_Hit_E_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_E_fr = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_Hit_E_fr")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_N = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_Hit_N")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Attack_Hit_S = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_Attack_Hit_S")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_bk_Freeze = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_bk_Freeze")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_bk_overlay_Lantern = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_bk_overlay_Lantern")
			table.insert(var_2_0, "effect")

			return
		end,
		Lamp_A = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Lamp_A")
			table.insert(var_2_0, "object")

			self.hide = true

			return
		end,
		Pine = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Pine")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)

			return
		end,
		Plum = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Plum")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)

			return
		end,
		Pond = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Pond")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)

			return
		end,
		Manjuu_fishing = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Manjuu_fishing")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)

			return
		end,
		Fire = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Fire")
			table.insert(var_2_0, "object")

			self.size = NewPos(3, 3)

			return
		end,
		Building_A = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Building_A")
			table.insert(var_2_0, "object")

			self.size = NewPos(3, 3)
			self.hide = true

			return
		end,
		Item_1 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetItem)
			table.insert(var_2_0, "object/Item")
			table.insert(var_2_0, "object")

			return
		end,
		Item_2 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetItem)
			table.insert(var_2_0, "object/Item")
			table.insert(var_2_0, "object")

			return
		end,
		Item_3 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetItem)
			table.insert(var_2_0, "object/Item")
			table.insert(var_2_0, "object")

			return
		end,
		Item_4 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetItem)
			table.insert(var_2_0, "object/Item")
			table.insert(var_2_0, "object")

			return
		end,
		Item_5 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetItem)
			table.insert(var_2_0, "object/Item")
			table.insert(var_2_0, "object")

			return
		end,
		Item_6 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetItem)
			table.insert(var_2_0, "object/Item")
			table.insert(var_2_0, "object")

			return
		end,
		EF_fr_Inactivate = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetSubEffect)
			table.insert(var_2_0, "effect/EF_fr_Inactivate")
			table.insert(var_2_0, "object")

			return
		end,
		EF_Ghost_E_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Ghost_E_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_N_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Ghost_N_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_N_fr = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Ghost_N_fr")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_S_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Ghost_S_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Ghost_W_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Ghost_W_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_E_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Nenjuu_Ghost_E_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_N_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Nenjuu_Ghost_N_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_N_fr = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Nenjuu_Ghost_N_fr")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_S_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Nenjuu_Ghost_S_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		EF_Nenjuu_Ghost_W_bk = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetRushEffect)
			table.insert(var_2_0, "effect/EF_Nenjuu_Ghost_W_bk")
			table.insert(var_2_0, "effect")

			return
		end,
		Snow_1 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Snow_1")
			table.insert(var_2_0, "object")

			return
		end,
		Snow_2 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Snow_2")
			table.insert(var_2_0, "object")

			return
		end,
		Snow_3 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Snow_3")
			table.insert(var_2_0, "object")

			return
		end,
		Snow_4 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Snow_4")
			table.insert(var_2_0, "object")

			return
		end,
		Snow_5 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Snow_5")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 1)
			self.hide = true

			return
		end,
		Lamp_B1 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Lamp_B1")
			table.insert(var_2_0, "object")

			self.hide = true

			return
		end,
		Lamp_B2 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Lamp_B2")
			table.insert(var_2_0, "object")

			self.hide = true

			return
		end,
		Building_B = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Building_B")
			table.insert(var_2_0, "object")

			self.size = NewPos(4, 3)
			self.hide = true

			return
		end,
		["1_Arbor_1"] = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetArbor)
			table.insert(var_2_0, "object/Arbor")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)
			self.hide = true

			return
		end,
		["1_Arbor_2"] = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetArbor)
			table.insert(var_2_0, "object/Arbor")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)
			self.hide = true

			return
		end,
		["1_Arbor_3"] = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetArbor)
			table.insert(var_2_0, "object/Arbor")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)
			self.hide = true

			return
		end,
		["1_Arbor_4"] = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetArbor)
			table.insert(var_2_0, "object/Arbor")
			table.insert(var_2_0, "object")

			self.size = NewPos(2, 2)
			self.hide = true

			return
		end,
		Dango_1 = function()
			table.insert(var_2_0, NenjuuGameNameSpace.TargetObject)
			table.insert(var_2_0, "object/Dango")
			table.insert(var_2_0, "object")

			return
		end
	}, function()
		warning("name error:" .. self.name)
		table.insert(var_2_0, false)

		return
	end)

	return unpack(var_2_0)
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

function var_0_0:ParsingElements()
	local var_69_0 = {}

	var_69_0.high = self[1] or 0
	var_69_0.count = self[2] or 0

	if self[3] then
		var_69_0.item = var_0_0.ITEM_LIST[self[3]] or nil
	end

	for iter_69_0 = 1, 7 do
		var_69_0["stage_" .. iter_69_0] = self[iter_69_0 + 3] or 0
	end

	var_69_0.level = {}

	for iter_69_1, iter_69_2 in ipairs({
		"bomb",
		"lantern",
		"ice",
		"flash",
		"rush",
		"blessing",
		"decoy"
	}) do
		var_69_0.level[iter_69_2] = self[iter_69_1 + 10] or var_0_0.SKILL_LEVEL_CONFIG[iter_69_2].level
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
