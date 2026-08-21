-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResNewMazeItemType.lua

local Data = {
	{
		{
			type = 1,
			rarity = 1,
			purchase_price = 30,
			selling_price = 15
		},
		{
			type = 1,
			rarity = 2,
			purchase_price = 40,
			selling_price = 20
		},
		{
			type = 1,
			rarity = 3,
			purchase_price = 50,
			selling_price = 25
		}
	},
	{
		{
			type = 2,
			rarity = 1,
			purchase_price = 30,
			selling_price = 10
		},
		{
			type = 2,
			rarity = 2,
			purchase_price = 40,
			selling_price = 20
		},
		{
			type = 2,
			rarity = 3,
			purchase_price = 50,
			selling_price = 30
		}
	},
	{
		{
			type = 3,
			rarity = 1,
			purchase_price = 30,
			selling_price = 15
		}
	},
	[5] = {
		{
			buy_max_count = 1,
			rarity = 1,
			purchase_price = 50,
			type = 5
		}
	},
	[6] = {
		[3] = {
			buy_max_count = 1,
			rarity = 3,
			purchase_price = 50,
			type = 6
		}
	},
	[8] = {
		{
			buy_max_count = 100,
			rarity = 1,
			purchase_price = 30,
			type = 8
		}
	},
	[9] = {
		[3] = {
			buy_max_count = 10,
			rarity = 3,
			purchase_price = 30,
			type = 9
		}
	},
	[10] = {
		{
			buy_max_count = 2,
			rarity = 1,
			purchase_price = 35,
			type = 10
		}
	}
}

return Data
