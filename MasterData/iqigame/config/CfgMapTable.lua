-- chunkname: @IQIGame\\Config\\CfgMapTable.lua

local CfgMapTable = {
	[0] = {
		Id = 0,
		Name = getI18NValue(180014546),
		MapType = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[15201] = {
		Id = 15201,
		Name = getI18NValue(180039470),
		MapType = {
			0,
			0,
			0,
			0,
			1520,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[15202] = {
		Id = 15202,
		Name = getI18NValue(180039471),
		MapType = {
			0,
			0,
			0,
			0,
			1520,
			0,
			1520,
			0,
			1520,
			0,
			0,
			0
		}
	},
	[15203] = {
		Id = 15203,
		Name = getI18NValue(180039472),
		MapType = {
			0,
			0,
			0,
			0,
			0,
			0,
			1520,
			1520,
			1520,
			0,
			0,
			0
		}
	},
	[15204] = {
		Id = 15204,
		Name = getI18NValue(180039473),
		MapType = {
			0,
			0,
			0,
			0,
			0,
			0,
			1520,
			1520,
			1520,
			0,
			0,
			0
		}
	},
	[15205] = {
		Id = 15205,
		Name = getI18NValue(180039474),
		MapType = {
			1520,
			0,
			1520,
			0,
			0,
			0,
			1520,
			1520,
			1520,
			0,
			0,
			0
		}
	},
	[300011] = {
		Id = 300011,
		Name = getI18NValue(180039475),
		MapType = {
			30001,
			0,
			30001,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[300301] = {
		Id = 300301,
		Name = getI18NValue(180039476),
		MapType = {
			30030,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[8054] = {
		Id = 8054,
		Name = getI18NValue(180039477),
		MapType = {
			1900,
			1900,
			1900,
			1900,
			1900,
			1900,
			1900,
			1900,
			1900,
			0,
			0,
			0
		}
	},
	[8067] = {
		Id = 8067,
		Name = getI18NValue(180039478),
		MapType = {
			1800,
			1800,
			1800,
			1800,
			1800,
			1800,
			1800,
			1800,
			1800,
			0,
			0,
			0
		}
	}
}

setmetatable(CfgMapTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMapTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		MapType = {}
	}
}

for i, data in pairs(CfgMapTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMapTable
