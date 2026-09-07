local ShipType = class("ShipType")

ShipType.QuZhu = 1
ShipType.QingXun = 2
ShipType.ZhongXun = 3
ShipType.ZhanXun = 4
ShipType.ZhanLie = 5
ShipType.QingHang = 6
ShipType.ZhengHang = 7
ShipType.QianTing = 8
ShipType.HangXun = 9
ShipType.HangZhan = 10
ShipType.LeiXun = 11
ShipType.WeiXiu = 12
ShipType.ZhongPao = 13
ShipType.QianMu = 17
ShipType.ChaoXun = 18
ShipType.Yunshu = 19
ShipType.DaoQuV = 20
ShipType.DaoQuM = 21
ShipType.FengFanS = 22
ShipType.FengFanV = 23
ShipType.FengFanM = 24
ShipType.YuLeiTing = 14
ShipType.JinBi = 15
ShipType.ZiBao = 16
ShipType.WeiZhi = 25
ShipType.AllShipType = {
	1,
	2,
	3,
	18,
	4,
	5,
	6,
	7,
	10,
	17,
	13,
	8,
	12,
	19,
	20,
	21,
	22,
	23,
	24
}
ShipType.SpecificTypeTable = {
	torpedo = "TORP",
	auxiliary = "AUX",
	gunner = "GNR"
}
ShipType.SpecificTableTips = {
	AUX = "breakout_tip_ultimatebonus_aux",
	TORP = "breakout_tip_ultimatebonus_torpedo",
	GNR = "breakout_tip_ultimatebonus_gunner"
}

function ShipType:Type2Name()
	return pg.ship_data_by_type[self].type_name
end

function ShipType:Type2Print()
	ShipType.prints = ShipType.prints or {
		"quzhu",
		"qingxun",
		"zhongxun",
		"zhanlie",
		"zhanlie",
		"hangmu",
		"hangmu",
		"qianting",
		"zhanlie",
		"hangzhan",
		"zhanlie",
		"weixiu",
		"zhongpao",
		"quzhu",
		"battle_jinbi",
		"battle_zibao",
		"qianmu",
		"chaoxun",
		"yunshu",
		"daoquv",
		"daoqum",
		"fengfans",
		"fengfanv",
		"fengfanm",
		"weizhi"
	}

	return ShipType.prints[self]
end

function ShipType:Type2BattlePrint()
	ShipType.bprints = ShipType.bprints or {
		"battle_quzhu",
		"battle_qingxun",
		"battle_zhongxun",
		"battle_zhanlie",
		"battle_zhanlie",
		"battle_hangmu",
		"battle_hangmu",
		"battle_qianting",
		"battle_zhanlie",
		"battle_hangmu",
		"battle_zhanlie",
		"battle_weixiu",
		"battle_zhanlie",
		"battle_quzhu",
		"battle_jinbi",
		"battle_zibao",
		"battle_hangmu",
		"battle_zhanlie",
		"battle_yunshu",
		"battle_daoqu",
		"battle_daoqu",
		"battle_fengfans",
		"battle_fengfanv",
		"battle_fengfanm",
		"battle_weizhi"
	}

	return ShipType.bprints[self]
end

function ShipType:Type2CNLabel()
	ShipType.cnLabel = ShipType.cnLabel or {
		[0] = "label_2",
		"label_3",
		"label_4",
		"label_5",
		"label_6",
		"label_7",
		"label_19",
		"label_3",
		"label_10",
		"label_3",
		"label_20",
		"label_21",
		"label_1",
		"label_1",
		"label_1",
		"label_17",
		"label_18",
		"label_22",
		"label_23",
		"label_23",
		"label_24",
		"label_25",
		"label_26",
		"fengfan",
		"label_27",
		[nil] = "label_1"
	}

	return ShipType.cnLabel[self]
end

ShipType.BundleBattleShip = "zhan"
ShipType.BundleAircraftCarrier = "hang"
ShipType.BundleSubmarine = "qian"
ShipType.BundleLargeCrusier = "zhong"
ShipType.BundleAntiSubmarine = "fanqian"
ShipType.BundleList = {
	zhan = {
		ShipType.ZhanXun,
		ShipType.ZhanLie
	},
	hang = {
		ShipType.QingHang,
		ShipType.ZhengHang
	},
	qian = {
		ShipType.QianTing,
		ShipType.QianMu,
		ShipType.FengFanS
	},
	zhong = {
		ShipType.ZhongXun,
		ShipType.ChaoXun
	},
	fanqian = {
		ShipType.QuZhu,
		ShipType.QingXun,
		ShipType.DaoQuV
	},
	quzhu = {
		ShipType.QuZhu,
		ShipType.DaoQuM,
		ShipType.DaoQuV
	},
	fengfan = {
		ShipType.FengFanS,
		ShipType.FengFanV,
		ShipType.FengFanM
	}
}

function ShipType:BundleType2CNLabel()
	ShipType.bundleLabel = ShipType.bundleLabel or {
		zhong = "label_13",
		qian = "label_8",
		zhan = "label_11",
		fanqian = "label_55",
		hang = "label_12",
		quzhu = "label_1"
	}

	return ShipType.bundleLabel[self]
end

function ShipType:GetShipTypesFromLimit()
	if type(self) == "string" then
		return ShipType.BundleList[self]
	elseif type(self) == "number" then
		if self == 0 then
			return "all"
		else
			return {
				self
			}
		end

		return self == 0 or shipType == self
	else
		assert(false)
	end

	return
end

function ShipType:ContainInLimitBundle(arg_7_1)
	local var_7_0 = ShipType.GetShipTypesFromLimit(self)

	if var_7_0 == "all" then
		return true
	else
		return underscore.any(var_7_0, function(arg_8_0)
			return arg_8_0 == arg_7_1
		end)
	end

	return
end

ShipType.CloakShipTypeList = {
	ShipType.QingHang,
	ShipType.ZhengHang,
	ShipType.DaoQuM
}

function ShipType:CloakShipType()
	return table.contains(ShipType.CloakShipTypeList, self)
end

ShipType.QuZhuShipType = {}

for iter_0_0, iter_0_1 in ipairs(ShipType.BundleList.quzhu) do
	ShipType.QuZhuShipType[iter_0_1] = true
end

function ShipType:IsTypeQuZhu()
	return ShipType.QuZhuShipType[self]
end

function ShipType:FilterOverQuZhuType()
	local var_11_0 = false

	return underscore.filter(self, function(arg_12_0)
		if not var_11_0 or not ShipType.IsTypeQuZhu(arg_12_0) then
			var_11_0 = var_11_0 or ShipType.IsTypeQuZhu(arg_12_0)

			return true
		else
			return false
		end

		return
	end)
end

ShipType.FengFanType = {}

for iter_0_2, iter_0_3 in ipairs(ShipType.BundleList.fengfan) do
	ShipType.FengFanType[iter_0_3] = true
end

function ShipType:IsTypeFengFan()
	return ShipType.FengFanType[self]
end

function ShipType:FilterOverFengFanType()
	local var_14_0 = false

	return underscore.filter(self, function(arg_15_0)
		if not var_14_0 or not ShipType.IsTypeFengFan(arg_15_0) then
			var_14_0 = var_14_0 or ShipType.IsTypeFengFan(arg_15_0)

			return true
		else
			return false
		end

		return
	end)
end

function ShipType:MergeFengFanType(arg_16_1, arg_16_2)
	local var_16_0 = ShipType.BundleList.fengfan[1]

	if underscore.all(ShipType.BundleList.fengfan, function(arg_17_0)
		return arg_16_1[var_16_0] == arg_16_1[arg_17_0] and arg_16_2[var_16_0] == arg_16_2[arg_17_0]
	end) then
		self = underscore.filter(self, function(arg_18_0)
			return not table.contains(ShipType.BundleList.fengfan, arg_18_0)
		end)

		table.insert(self, table.indexof(self, ShipType.BundleList.fengfan[1]), "fengfan")

		arg_16_1.fengfan = arg_16_1[ShipType.BundleList.fengfan[1]]
		arg_16_2.fengfan = arg_16_2[ShipType.BundleList.fengfan[1]]
	end

	return self
end

ShipType.VanguardShipType = {
	ShipType.QuZhu,
	ShipType.QingXun,
	ShipType.ZhongXun,
	ShipType.HangXun,
	ShipType.LeiXun,
	ShipType.ChaoXun,
	ShipType.Yunshu,
	ShipType.DaoQuV,
	ShipType.FengFanV
}
ShipType.MainShipType = {
	ShipType.ZhanXun,
	ShipType.ZhanLie,
	ShipType.QingHang,
	ShipType.ZhengHang,
	ShipType.HangZhan,
	ShipType.WeiXiu,
	ShipType.ZhongPao,
	ShipType.DaoQuM,
	ShipType.FengFanM
}
ShipType.SubShipType = {
	ShipType.QianTing,
	ShipType.QianMu,
	ShipType.FengFanS
}

local var_0_1

function ShipType:GetTeamFromShipType()
	if not var_0_1 then
		var_0_1 = {}

		for iter_19_0, iter_19_1 in pairs({
			[TeamType.Vanguard] = ShipType.VanguardShipType,
			[TeamType.Main] = ShipType.MainShipType,
			[TeamType.Submarine] = ShipType.SubShipType
		}) do
			for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
				var_0_1[iter_19_3] = iter_19_0
			end
		end
	end

	return var_0_1[self]
end

return ShipType
