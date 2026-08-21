local var_0_0 = class("EducatePlanIndexConst")

var_0_0.TypeScholl = bit.lshift(1, 0)
var_0_0.TypeInterest = bit.lshift(1, 1)
var_0_0.TypeCommunity = bit.lshift(1, 2)
var_0_0.TypeFreetime = bit.lshift(1, 3)
var_0_0.TypeIndexs = {
	var_0_0.TypeScholl,
	var_0_0.TypeInterest,
	var_0_0.TypeCommunity,
	var_0_0.TypeFreetime
}
var_0_0.TypeAll = IndexConst.BitAll(var_0_0.TypeIndexs)

table.insert(var_0_0.TypeIndexs, 1, var_0_0.TypeAll)

var_0_0.TypeNames = {
	i18n("index_all"),
	i18n("child_plan_type1"),
	i18n("child_plan_type2"),
	i18n("child_plan_type3"),
	i18n("child_plan_type4")
}

function var_0_0.filterByType(arg_1_0, arg_1_1)
	if not arg_1_1 or arg_1_1 == var_0_0.TypeAll then
		return true
	end

	for iter_1_0 = 2, #var_0_0.CONFIG.type do
		if bit.band(bit.lshift(1, iter_1_0 - 2), arg_1_1) > 0 and table.contains(var_0_0.CONFIG.type[iter_1_0].types, arg_1_0:GetType()) then
			return true
		end
	end

	return false
end

var_0_0.CostMoney = bit.lshift(1, 0)
var_0_0.CostMood = bit.lshift(1, 1)
var_0_0.CostIndexs = {
	var_0_0.CostMoney,
	var_0_0.CostMood
}
var_0_0.CostAll = IndexConst.BitAll(var_0_0.CostIndexs)

table.insert(var_0_0.CostIndexs, 1, var_0_0.CostAll)

var_0_0.CostNames = {
	i18n("index_all"),
	pg.child_resource[EducateChar.RES_MONEY_ID].name,
	pg.child_resource[EducateChar.RES_MOOD_ID].name
}

function var_0_0.filterByCost(arg_2_0, arg_2_1)
	if not arg_2_1 or arg_2_1 == var_0_0.CostAll then
		return true
	end

	for iter_2_0 = 2, #var_0_0.CONFIG.cost do
		if bit.band(bit.lshift(1, iter_2_0 - 2), arg_2_1) > 0 then
			for iter_2_1, iter_2_2 in ipairs(var_0_0.CONFIG.cost[iter_2_0].names) do
				if arg_2_0:getConfig(iter_2_2) > 0 then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.AwardRes_Money = bit.lshift(1, 0)
var_0_0.AwardRes_Mood = bit.lshift(1, 1)
var_0_0.AwardResIndexs = {
	var_0_0.AwardRes_Money,
	var_0_0.AwardRes_Mood
}
var_0_0.AwardResAll = IndexConst.BitAll(var_0_0.AwardResIndexs)

table.insert(var_0_0.AwardResIndexs, 1, var_0_0.AwardResAll)

var_0_0.AwardResNames = {
	i18n("child_filter_award_res"),
	pg.child_resource[EducateChar.RES_MONEY_ID].name,
	pg.child_resource[EducateChar.RES_MOOD_ID].name
}

function var_0_0.filterByAwardRes(arg_3_0, arg_3_1)
	if not arg_3_1 or arg_3_1 == var_0_0.AwardResAll then
		return true
	end

	return var_0_0.filterByAward(arg_3_0, arg_3_1, "awardRes")
end

var_0_0.AwardNature_Wukou = bit.lshift(1, 0)
var_0_0.AwardNature_Kailang = bit.lshift(1, 1)
var_0_0.AwardNature_Wenrou = bit.lshift(1, 2)
var_0_0.AwardNatureIndexs = {
	var_0_0.AwardNature_Wukou,
	var_0_0.AwardNature_Kailang,
	var_0_0.AwardNature_Wenrou
}
var_0_0.AwardNatureAll = IndexConst.BitAll(var_0_0.AwardNatureIndexs)

table.insert(var_0_0.AwardNatureIndexs, 1, var_0_0.AwardNatureAll)

var_0_0.AwardNatureNames = {
	i18n("child_filter_award_nature"),
	pg.child_attr[201].name,
	pg.child_attr[202].name,
	pg.child_attr[203].name
}

function var_0_0.filterByAwardNature(arg_4_0, arg_4_1)
	if not arg_4_1 or arg_4_1 == var_0_0.AwardNatureAll then
		return true
	end

	return var_0_0.filterByAward(arg_4_0, arg_4_1, "awardNature")
end

var_0_0.AwardAttr1_Meili = bit.lshift(1, 0)
var_0_0.AwardAttr1_Tineng = bit.lshift(1, 1)
var_0_0.AwardAttr1_Zhishi = bit.lshift(1, 2)
var_0_0.AwardAttr1_Ganzhi = bit.lshift(1, 3)
var_0_0.AwardAttr1Indexs = {
	var_0_0.AwardAttr1_Meili,
	var_0_0.AwardAttr1_Tineng,
	var_0_0.AwardAttr1_Zhishi,
	var_0_0.AwardAttr1_Ganzhi
}
var_0_0.AwardAttr1All = IndexConst.BitAll(var_0_0.AwardAttr1Indexs)

table.insert(var_0_0.AwardAttr1Indexs, 1, var_0_0.AwardAttr1All)

var_0_0.AwardAttr1Names = {
	i18n("child_filter_award_attr1"),
	pg.child_attr[101].name,
	pg.child_attr[102].name,
	pg.child_attr[103].name,
	pg.child_attr[104].name
}

function var_0_0.filterByAwardAttr1(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == var_0_0.AwardAttr1All then
		return true
	end

	return var_0_0.filterByAward(arg_5_0, arg_5_1, "awardAttr1")
end

var_0_0.AwardAttr2_Biaoxianli = bit.lshift(1, 0)
var_0_0.AwardAttr2_Xiangxiang = bit.lshift(1, 1)
var_0_0.AwardAttr2_Yinyue = bit.lshift(1, 2)
var_0_0.AwardAttr2_Xixin = bit.lshift(1, 3)
var_0_0.AwardAttr2_Yundong = bit.lshift(1, 4)
var_0_0.AwardAttr2_Shijian = bit.lshift(1, 5)
var_0_0.AwardAttr2Indexs = {
	var_0_0.AwardAttr2_Biaoxianli,
	var_0_0.AwardAttr2_Xiangxiang,
	var_0_0.AwardAttr2_Yinyue,
	var_0_0.AwardAttr2_Xixin,
	var_0_0.AwardAttr2_Yundong,
	var_0_0.AwardAttr2_Shijian
}
var_0_0.AwardAttr2All = IndexConst.BitAll(var_0_0.AwardAttr2Indexs)

table.insert(var_0_0.AwardAttr2Indexs, 1, var_0_0.AwardAttr2All)

var_0_0.AwardAttr2Names = {
	i18n("child_filter_award_attr2"),
	pg.child_attr[301].name,
	pg.child_attr[302].name,
	pg.child_attr[303].name,
	pg.child_attr[304].name,
	pg.child_attr[305].name,
	pg.child_attr[306].name
}

function var_0_0.filterByAwardAttr2(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 == var_0_0.AwardAttr2All then
		return true
	end

	return var_0_0.filterByAward(arg_6_0, arg_6_1, "awardAttr2")
end

function var_0_0.filterByAward(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0 = 2, #var_0_0.CONFIG[arg_7_2] do
		if bit.band(bit.lshift(1, iter_7_0 - 2), arg_7_1) > 0 then
			for iter_7_1, iter_7_2 in ipairs(var_0_0.CONFIG[arg_7_2][iter_7_0].ids) do
				if arg_7_0:CheckResult(var_0_0.CONFIG[arg_7_2][iter_7_0].type, iter_7_2) then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.CONFIG = {
	type = {
		{
			types = {}
		},
		{
			types = {
				EducatePlan.TYPE_SCHOOL
			}
		},
		{
			types = {
				EducatePlan.TYPE_INTEREST
			}
		},
		{
			types = {
				EducatePlan.TYPE_COMMUNITY
			}
		},
		{
			types = {
				EducatePlan.TYPE_FREETIME
			}
		}
	},
	cost = {
		{
			names = {}
		},
		{
			names = {
				"cost_resource1"
			}
		},
		{
			names = {
				"cost_resource2"
			}
		}
	},
	awardRes = {
		{
			type = EducateConst.DROP_TYPE_RES,
			ids = {
				EducateChar.RES_MONEY_ID,
				EducateChar.RES_MOOD_ID,
				EducateChar.RES_FAVOR_ID
			}
		},
		{
			type = EducateConst.DROP_TYPE_RES,
			ids = {
				EducateChar.RES_MONEY_ID
			}
		},
		{
			type = EducateConst.DROP_TYPE_RES,
			ids = {
				EducateChar.RES_MOOD_ID
			}
		}
	},
	awardNature = {
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				201,
				202,
				203
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				201
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				202
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				203
			}
		}
	},
	awardAttr1 = {
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				101,
				102,
				103,
				104
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				101
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				102
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				103
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				104
			}
		}
	},
	awardAttr2 = {
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				301,
				302,
				303,
				304,
				305,
				306
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				301
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				302
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				303
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				304
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				305
			}
		},
		{
			type = EducateConst.DROP_TYPE_ATTR,
			ids = {
				306
			}
		}
	}
}

return var_0_0
