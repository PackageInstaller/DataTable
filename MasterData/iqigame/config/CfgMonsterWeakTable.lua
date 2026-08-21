-- chunkname: @IQIGame\\Config\\CfgMonsterWeakTable.lua

local CfgMonsterWeakTable = {
	[15000101] = {
		Weaken = 1,
		Type = 1,
		Id = 15000101,
		Name = getI18NValue(180122086),
		Param = {
			0
		}
	},
	[15000102] = {
		Weaken = 1,
		Type = 1,
		Id = 15000102,
		Icon = "Fight_weak_wind",
		Name = getI18NValue(180122087),
		Param = {
			1
		}
	},
	[15000103] = {
		Weaken = 1,
		Type = 1,
		Id = 15000103,
		Icon = "Fight_weak_fire",
		Name = getI18NValue(180122088),
		Param = {
			2
		}
	},
	[15000104] = {
		Weaken = 1,
		Type = 1,
		Id = 15000104,
		Icon = "Fight_weak_thunder",
		Name = getI18NValue(180122089),
		Param = {
			3
		}
	},
	[15000105] = {
		Weaken = 1,
		Type = 1,
		Id = 15000105,
		Icon = "Fight_weak_water",
		Name = getI18NValue(180122090),
		Param = {
			4
		}
	},
	[15000201] = {
		Weaken = 2,
		Type = 2,
		Id = 15000201,
		Icon = "Fight_weak_wei",
		Name = getI18NValue(180122091),
		Param = {
			1
		}
	},
	[15000202] = {
		Weaken = 2,
		Type = 2,
		Id = 15000202,
		Icon = "Fight_weak_ji",
		Name = getI18NValue(180122092),
		Param = {
			2
		}
	},
	[15000203] = {
		Weaken = 2,
		Type = 2,
		Id = 15000203,
		Icon = "Fight_weak_jing",
		Name = getI18NValue(180122093),
		Param = {
			3
		}
	},
	[15000204] = {
		Weaken = 2,
		Type = 2,
		Id = 15000204,
		Icon = "Fight_weak_kuang",
		Name = getI18NValue(180122094),
		Param = {
			4
		}
	},
	[15000205] = {
		Weaken = 2,
		Type = 2,
		Id = 15000205,
		Icon = "Fight_weak_he",
		Name = getI18NValue(180122095),
		Param = {
			5
		}
	},
	[15000206] = {
		Weaken = 2,
		Type = 2,
		Id = 15000206,
		Icon = "Fight_weak_ying",
		Name = getI18NValue(180122096),
		Param = {
			6
		}
	},
	[15000301] = {
		Type = 3,
		Id = 15000301,
		Icon = "mp_empty",
		Name = getI18NValue(180122097),
		Param = {
			1
		}
	},
	[15000302] = {
		Type = 3,
		Id = 15000302,
		Icon = "mp_full",
		Name = getI18NValue(180122098),
		Param = {
			2
		}
	}
}

setmetatable(CfgMonsterWeakTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMonsterWeakTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		Type = 0,
		Weaken = 0,
		Icon = "",
		Param = {}
	}
}

for i, data in pairs(CfgMonsterWeakTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMonsterWeakTable
