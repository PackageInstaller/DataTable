class = var_0_10000

local var_0_0 = var_0_10000("ShipType")

var_0_0.QuZhu = 1
var_0_0.QingXun = 2
var_0_0.ZhongXun = 3
var_0_0.ZhanXun = 4
var_0_0.ZhanLie = 5
var_0_0.QingHang = 6
var_0_0.ZhengHang = 7
var_0_0.QianTing = 8
var_0_0.HangXun = 9
var_0_0.HangZhan = 10
var_0_0.LeiXun = 11
var_0_0.WeiXiu = 12
var_0_0.ZhongPao = 13
var_0_0.QianMu = 17
var_0_0.ChaoXun = 18
var_0_0.Yunshu = 19
var_0_0.DaoQuV = 20
var_0_0.DaoQuM = 21
var_0_0.FengFanS = 22
var_0_0.FengFanV = 23
var_0_0.FengFanM = 24
var_0_0.YuLeiTing = 14
var_0_0.JinBi = 15
var_0_0.ZiBao = 16
var_0_0.WeiZhi = 25
var_0_0.AllShipType = {
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
var_0_0.SpecificTypeTable = {
	torpedo = "TORP",
	auxiliary = "AUX",
	gunner = "GNR"
}
var_0_0.SpecificTableTips = {
	AUX = "breakout_tip_ultimatebonus_aux",
	TORP = "breakout_tip_ultimatebonus_torpedo",
	GNR = "breakout_tip_ultimatebonus_gunner"
}

function var_0_0.Type2Name(arg_1_0)
	pg = var_1_10001

	return var_1_10001.ship_data_by_type[arg_1_0].type_name
end

function var_0_0.Type2Print(arg_2_0)
	if not var_0_0.prints then
		var_0_0.prints = {
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
	end

	return var_0_0.prints[arg_2_0]
end

function var_0_0.Type2BattlePrint(arg_3_0)
	if not var_0_0.bprints then
		var_0_0.bprints = {
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
	end

	return var_0_0.bprints[arg_3_0]
end

function var_0_0.Type2CNLabel(arg_4_0)
	if not var_0_0.cnLabel then
		var_0_0.cnLabel = {
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
	end

	return var_0_0.cnLabel[arg_4_0]
end

var_0_0.BundleBattleShip = "zhan"
var_0_0.BundleAircraftCarrier = "hang"
var_0_0.BundleSubmarine = "qian"
var_0_0.BundleLargeCrusier = "zhong"
var_0_0.BundleAntiSubmarine = "fanqian"
var_0_0.BundleList = {
	zhan = {
		var_0_0.ZhanXun,
		var_0_0.ZhanLie
	},
	hang = {
		var_0_0.QingHang,
		var_0_0.ZhengHang
	},
	qian = {
		var_0_0.QianTing,
		var_0_0.QianMu,
		var_0_0.FengFanS
	},
	zhong = {
		var_0_0.ZhongXun,
		var_0_0.ChaoXun
	},
	fanqian = {
		var_0_0.QuZhu,
		var_0_0.QingXun,
		var_0_0.DaoQuV
	},
	quzhu = {
		var_0_0.QuZhu,
		var_0_0.DaoQuM,
		var_0_0.DaoQuV
	},
	fengfan = {
		var_0_0.FengFanS,
		var_0_0.FengFanV,
		var_0_0.FengFanM
	}
}

function var_0_0.BundleType2CNLabel(arg_5_0)
	if not var_0_0.bundleLabel then
		var_0_0.bundleLabel = {
			zhong = "label_13",
			qian = "label_8",
			zhan = "label_11",
			fanqian = "label_55",
			hang = "label_12",
			quzhu = "label_1"
		}
	end

	return var_0_0.bundleLabel[arg_5_0]
end

function var_0_0.GetShipTypesFromLimit(arg_6_0)
	type = var_1_10001

	if var_1_10001(arg_6_0) == "string" then
		return var_0_0.BundleList[arg_6_0]
	else
		type = var_1

		local var_6_0

		if var_1(arg_6_0) == "number" then
			if arg_6_0 == 0 then
				return "all"
			else
				return {
					arg_6_0
				}
			end

			if arg_6_0 ~= 0 then
				shipType = var_6_0

				if var_6_0 ~= arg_6_0 then
					var_6_0 = false

					goto label_6_0
				end
			end

			var_6_0 = true

			::label_6_0::

			return var_6_0
		else
			assert = var_6_0

			var_6_0(false)
		end
	end

	return
end

function var_0_0.ContainInLimitBundle(arg_7_0, arg_7_1)
	if var_0_0.GetShipTypesFromLimit(arg_7_0) == "all" then
		return true
	else
		underscore = var_1_10003

		return var_1_10003.any(var_2, function(arg_8_0)
			return arg_8_0 == arg_7_1
		end)
	end

	return
end

var_0_0.CloakShipTypeList = {
	var_0_0.QingHang,
	var_0_0.ZhengHang,
	var_0_0.DaoQuM
}

function var_0_0.CloakShipType(arg_9_0)
	table = var_1_10001

	return var_1_10001.contains(var_0_0.CloakShipTypeList, arg_9_0)
end

var_0_0.QuZhuShipType = {}
ipairs = var_1

for iter_0_0, iter_0_1 in var_1(var_0_0.BundleList.quzhu) do
	var_0_0.QuZhuShipType[iter_0_1] = true
end

function var_0_0.IsTypeQuZhu(arg_10_0)
	return var_0_0.QuZhuShipType[arg_10_0]
end

function var_0_0.FilterOverQuZhuType(arg_11_0)
	local var_11_0 = false

	underscore = var_1_10002

	return var_1_10002.filter(arg_11_0, function(arg_12_0)
		if not var_11_0 or not var_0_0.IsTypeQuZhu(arg_12_0) then
			local var_12_0

			if not var_11_0 then
				var_12_0 = var_0_0.IsTypeQuZhu(arg_12_0)
			end

			var_11_0 = var_12_0

			return true
		else
			return false
		end

		return
	end)
end

var_0_0.FengFanType = {}
ipairs = var_1

for iter_0_2, iter_0_3 in var_1(var_0_0.BundleList.fengfan) do
	var_0_0.FengFanType[iter_0_3] = true
end

function var_0_0.IsTypeFengFan(arg_13_0)
	return var_0_0.FengFanType[arg_13_0]
end

function var_0_0.FilterOverFengFanType(arg_14_0)
	local var_14_0 = false

	underscore = var_1_10002

	return var_1_10002.filter(arg_14_0, function(arg_15_0)
		if not var_14_0 or not var_0_0.IsTypeFengFan(arg_15_0) then
			local var_15_0

			if not var_14_0 then
				var_15_0 = var_0_0.IsTypeFengFan(arg_15_0)
			end

			var_14_0 = var_15_0

			return true
		else
			return false
		end

		return
	end)
end

function var_0_0.MergeFengFanType(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_0.BundleList.fengfan[1]

	underscore = var_1_10004

	if var_1_10004.all(var_0_0.BundleList.fengfan, function(arg_17_0)
		return arg_16_1[var_16_0] == arg_16_1[arg_17_0] and arg_16_2[var_16_0] == arg_16_2[arg_17_0]
	end) then
		table = var_4

		local var_16_1 = var_4.indexof(arg_16_0, var_16_0)

		underscore = var_1_10005
		arg_16_0 = var_1_10005.filter(arg_16_0, function(arg_18_0)
			table = var_2_10001

			return not var_2_10001.contains(var_0_0.BundleList.fengfan, arg_18_0)
		end)
		table = var_5

		var_5.insert(arg_16_0, var_16_1, "fengfan")

		arg_16_1.fengfan = arg_16_1[var_16_0]
		arg_16_2.fengfan = arg_16_2[var_16_0]
	end

	return arg_16_0
end

var_0_0.VanguardShipType = {
	var_0_0.QuZhu,
	var_0_0.QingXun,
	var_0_0.ZhongXun,
	var_0_0.HangXun,
	var_0_0.LeiXun,
	var_0_0.ChaoXun,
	var_0_0.Yunshu,
	var_0_0.DaoQuV,
	var_0_0.FengFanV
}
var_0_0.MainShipType = {
	var_0_0.ZhanXun,
	var_0_0.ZhanLie,
	var_0_0.QingHang,
	var_0_0.ZhengHang,
	var_0_0.HangZhan,
	var_0_0.WeiXiu,
	var_0_0.ZhongPao,
	var_0_0.DaoQuM,
	var_0_0.FengFanM
}
var_0_0.SubShipType = {
	var_0_0.QianTing,
	var_0_0.QianMu,
	var_0_0.FengFanS
}

local var_0_1

function var_0_0.GetTeamFromShipType(arg_19_0)
	if not var_0_1 then
		var_0_1 = {}
		pairs = var_1

		local var_19_0 = {}

		TeamType = var_1_10004
		var_19_0[var_1_10004.Vanguard] = var_0_0.VanguardShipType
		TeamType = var_4
		var_19_0[var_4.Main] = var_0_0.MainShipType
		TeamType = var_4
		var_19_0[var_4.Submarine] = var_0_0.SubShipType

		for iter_19_0, iter_19_1 in var_1(var_19_0) do
			ipairs = var_1_10006

			for iter_19_2, iter_19_3 in var_1_10006(iter_19_1) do
				var_0_1[iter_19_3] = iter_19_0
			end
		end
	end

	return var_0_1[arg_19_0]
end

return var_0_0
