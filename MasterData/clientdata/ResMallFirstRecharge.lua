-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResMallFirstRecharge.lua

local RT = {}

RT[1] = {
	reward = 16031,
	target_args = 10224,
	target_type = 2,
	des = Lang.get(30784)
}
RT[2] = {
	reward = 16032,
	target_args = 2,
	target_type = 1,
	des = Lang.get(99077)
}

local Data = {
	{
		{
			level = 1,
			first_recharge_money_limit = 1,
			append_award = 16033,
			prefab_path = "FirstRechargeGiftPanel4",
			first_recharge_extra_money = 1554,
			first_recharge_unlock_limit = 242,
			id = 1,
			version = 1,
			append_achieve_id = 1971,
			first_recharge_detail = {
				{
					reward = 16022,
					des = Lang.get(30783)
				},
				RT[1],
				RT[2]
			}
		}
	},
	{
		{
			level = 1,
			first_recharge_money_limit = 1,
			append_award = 16080,
			prefab_path = "FirstRechargeGiftPanel1",
			first_recharge_extra_money = 1554,
			first_recharge_unlock_limit = 242,
			id = 2,
			version = 2,
			append_achieve_id = 1971,
			first_recharge_detail = {
				{
					reward = 16071,
					des = Lang.get(30783)
				},
				RT[1],
				RT[2]
			}
		},
		{
			level = 2,
			first_recharge_money_limit = 3000,
			prefab_path = "FirstRechargeGiftPanel2",
			first_recharge_extra_money = 1888,
			first_recharge_unlock_limit = 242,
			id = 2,
			version = 2,
			des = Lang.get(99078),
			first_recharge_detail = {
				{
					reward = 16081,
					des = Lang.get(99079)
				},
				{
					reward = 16082,
					target_args = 10415,
					target_type = 2,
					des = Lang.get(99080)
				},
				{
					reward = 16083,
					target_args = 3,
					target_type = 1,
					des = Lang.get(99081)
				}
			}
		},
		{
			level = 3,
			first_recharge_money_limit = 6800,
			prefab_path = "FirstRechargeGiftPanel3",
			first_recharge_extra_money = 2888,
			first_recharge_unlock_limit = 242,
			id = 2,
			version = 2,
			des = Lang.get(99078),
			first_recharge_detail = {
				{
					reward = 16084,
					des = Lang.get(99079)
				},
				{
					reward = 16085,
					target_args = 10524,
					target_type = 2,
					des = Lang.get(99082)
				},
				{
					reward = 16086,
					target_args = 4,
					target_type = 1,
					des = Lang.get(99083)
				}
			}
		}
	}
}

return Data
