local EducatePlanIndexConst = class("EducatePlanIndexConst")

EducatePlanIndexConst.TypeScholl = bit.lshift(1, 0)
EducatePlanIndexConst.TypeInterest = bit.lshift(1, 1)
EducatePlanIndexConst.TypeCommunity = bit.lshift(1, 2)
EducatePlanIndexConst.TypeFreetime = bit.lshift(1, 3)
EducatePlanIndexConst.TypeIndexs = {
	EducatePlanIndexConst.TypeScholl,
	EducatePlanIndexConst.TypeInterest,
	EducatePlanIndexConst.TypeCommunity,
	EducatePlanIndexConst.TypeFreetime
}
EducatePlanIndexConst.TypeAll = IndexConst.BitAll(EducatePlanIndexConst.TypeIndexs)

table.insert(EducatePlanIndexConst.TypeIndexs, 1, EducatePlanIndexConst.TypeAll)

EducatePlanIndexConst.TypeNames = {
	i18n("index_all"),
	i18n("child_plan_type1"),
	i18n("child_plan_type2"),
	i18n("child_plan_type3"),
	i18n("child_plan_type4")
}

function EducatePlanIndexConst:filterByType(arg_1_1)
	if not arg_1_1 or arg_1_1 == EducatePlanIndexConst.TypeAll then
		return true
	end

	for iter_1_0 = 2, #EducatePlanIndexConst.CONFIG.type do
		if bit.band(bit.lshift(1, iter_1_0 - 2), arg_1_1) > 0 and table.contains(EducatePlanIndexConst.CONFIG.type[iter_1_0].types, self:GetType()) then
			return true
		end
	end

	return false
end

EducatePlanIndexConst.CostMoney = bit.lshift(1, 0)
EducatePlanIndexConst.CostMood = bit.lshift(1, 1)
EducatePlanIndexConst.CostIndexs = {
	EducatePlanIndexConst.CostMoney,
	EducatePlanIndexConst.CostMood
}
EducatePlanIndexConst.CostAll = IndexConst.BitAll(EducatePlanIndexConst.CostIndexs)

table.insert(EducatePlanIndexConst.CostIndexs, 1, EducatePlanIndexConst.CostAll)

EducatePlanIndexConst.CostNames = {
	i18n("index_all"),
	pg.child_resource[EducateChar.RES_MONEY_ID].name,
	pg.child_resource[EducateChar.RES_MOOD_ID].name
}

function EducatePlanIndexConst:filterByCost(arg_2_1)
	if not arg_2_1 or arg_2_1 == EducatePlanIndexConst.CostAll then
		return true
	end

	for iter_2_0 = 2, #EducatePlanIndexConst.CONFIG.cost do
		if bit.band(bit.lshift(1, iter_2_0 - 2), arg_2_1) > 0 then
			for iter_2_1, iter_2_2 in ipairs(EducatePlanIndexConst.CONFIG.cost[iter_2_0].names) do
				if self:getConfig(iter_2_2) > 0 then
					return true
				end
			end
		end
	end

	return false
end

EducatePlanIndexConst.AwardRes_Money = bit.lshift(1, 0)
EducatePlanIndexConst.AwardRes_Mood = bit.lshift(1, 1)
EducatePlanIndexConst.AwardResIndexs = {
	EducatePlanIndexConst.AwardRes_Money,
	EducatePlanIndexConst.AwardRes_Mood
}
EducatePlanIndexConst.AwardResAll = IndexConst.BitAll(EducatePlanIndexConst.AwardResIndexs)

table.insert(EducatePlanIndexConst.AwardResIndexs, 1, EducatePlanIndexConst.AwardResAll)

EducatePlanIndexConst.AwardResNames = {
	i18n("child_filter_award_res"),
	pg.child_resource[EducateChar.RES_MONEY_ID].name,
	pg.child_resource[EducateChar.RES_MOOD_ID].name
}

function EducatePlanIndexConst:filterByAwardRes(arg_3_1)
	if not arg_3_1 or arg_3_1 == EducatePlanIndexConst.AwardResAll then
		return true
	end

	return EducatePlanIndexConst.filterByAward(self, arg_3_1, "awardRes")
end

EducatePlanIndexConst.AwardNature_Wukou = bit.lshift(1, 0)
EducatePlanIndexConst.AwardNature_Kailang = bit.lshift(1, 1)
EducatePlanIndexConst.AwardNature_Wenrou = bit.lshift(1, 2)
EducatePlanIndexConst.AwardNatureIndexs = {
	EducatePlanIndexConst.AwardNature_Wukou,
	EducatePlanIndexConst.AwardNature_Kailang,
	EducatePlanIndexConst.AwardNature_Wenrou
}
EducatePlanIndexConst.AwardNatureAll = IndexConst.BitAll(EducatePlanIndexConst.AwardNatureIndexs)

table.insert(EducatePlanIndexConst.AwardNatureIndexs, 1, EducatePlanIndexConst.AwardNatureAll)

EducatePlanIndexConst.AwardNatureNames = {
	i18n("child_filter_award_nature"),
	pg.child_attr[201].name,
	pg.child_attr[202].name,
	pg.child_attr[203].name
}

function EducatePlanIndexConst:filterByAwardNature(arg_4_1)
	if not arg_4_1 or arg_4_1 == EducatePlanIndexConst.AwardNatureAll then
		return true
	end

	return EducatePlanIndexConst.filterByAward(self, arg_4_1, "awardNature")
end

EducatePlanIndexConst.AwardAttr1_Meili = bit.lshift(1, 0)
EducatePlanIndexConst.AwardAttr1_Tineng = bit.lshift(1, 1)
EducatePlanIndexConst.AwardAttr1_Zhishi = bit.lshift(1, 2)
EducatePlanIndexConst.AwardAttr1_Ganzhi = bit.lshift(1, 3)
EducatePlanIndexConst.AwardAttr1Indexs = {
	EducatePlanIndexConst.AwardAttr1_Meili,
	EducatePlanIndexConst.AwardAttr1_Tineng,
	EducatePlanIndexConst.AwardAttr1_Zhishi,
	EducatePlanIndexConst.AwardAttr1_Ganzhi
}
EducatePlanIndexConst.AwardAttr1All = IndexConst.BitAll(EducatePlanIndexConst.AwardAttr1Indexs)

table.insert(EducatePlanIndexConst.AwardAttr1Indexs, 1, EducatePlanIndexConst.AwardAttr1All)

EducatePlanIndexConst.AwardAttr1Names = {
	i18n("child_filter_award_attr1"),
	pg.child_attr[101].name,
	pg.child_attr[102].name,
	pg.child_attr[103].name,
	pg.child_attr[104].name
}

function EducatePlanIndexConst:filterByAwardAttr1(arg_5_1)
	if not arg_5_1 or arg_5_1 == EducatePlanIndexConst.AwardAttr1All then
		return true
	end

	return EducatePlanIndexConst.filterByAward(self, arg_5_1, "awardAttr1")
end

EducatePlanIndexConst.AwardAttr2_Biaoxianli = bit.lshift(1, 0)
EducatePlanIndexConst.AwardAttr2_Xiangxiang = bit.lshift(1, 1)
EducatePlanIndexConst.AwardAttr2_Yinyue = bit.lshift(1, 2)
EducatePlanIndexConst.AwardAttr2_Xixin = bit.lshift(1, 3)
EducatePlanIndexConst.AwardAttr2_Yundong = bit.lshift(1, 4)
EducatePlanIndexConst.AwardAttr2_Shijian = bit.lshift(1, 5)
EducatePlanIndexConst.AwardAttr2Indexs = {
	EducatePlanIndexConst.AwardAttr2_Biaoxianli,
	EducatePlanIndexConst.AwardAttr2_Xiangxiang,
	EducatePlanIndexConst.AwardAttr2_Yinyue,
	EducatePlanIndexConst.AwardAttr2_Xixin,
	EducatePlanIndexConst.AwardAttr2_Yundong,
	EducatePlanIndexConst.AwardAttr2_Shijian
}
EducatePlanIndexConst.AwardAttr2All = IndexConst.BitAll(EducatePlanIndexConst.AwardAttr2Indexs)

table.insert(EducatePlanIndexConst.AwardAttr2Indexs, 1, EducatePlanIndexConst.AwardAttr2All)

EducatePlanIndexConst.AwardAttr2Names = {
	i18n("child_filter_award_attr2"),
	pg.child_attr[301].name,
	pg.child_attr[302].name,
	pg.child_attr[303].name,
	pg.child_attr[304].name,
	pg.child_attr[305].name,
	pg.child_attr[306].name
}

function EducatePlanIndexConst:filterByAwardAttr2(arg_6_1)
	if not arg_6_1 or arg_6_1 == EducatePlanIndexConst.AwardAttr2All then
		return true
	end

	return EducatePlanIndexConst.filterByAward(self, arg_6_1, "awardAttr2")
end

function EducatePlanIndexConst:filterByAward(arg_7_1, arg_7_2)
	for iter_7_0 = 2, #EducatePlanIndexConst.CONFIG[arg_7_2] do
		if bit.band(bit.lshift(1, iter_7_0 - 2), arg_7_1) > 0 then
			for iter_7_1, iter_7_2 in ipairs(EducatePlanIndexConst.CONFIG[arg_7_2][iter_7_0].ids) do
				if self:CheckResult(EducatePlanIndexConst.CONFIG[arg_7_2][iter_7_0].type, iter_7_2) then
					return true
				end
			end
		end
	end

	return false
end

EducatePlanIndexConst.CONFIG = {
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

return EducatePlanIndexConst
