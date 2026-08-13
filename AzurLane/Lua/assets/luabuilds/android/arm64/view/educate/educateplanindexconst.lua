class = var_0_10000

local var_0_0 = var_0_10000("EducatePlanIndexConst")

bit = var_0_10001
var_0_0.TypeScholl = var_0_10001.lshift(1, 0)
bit = var_1
var_0_0.TypeInterest = var_1.lshift(1, 1)
bit = var_1
var_0_0.TypeCommunity = var_1.lshift(1, 2)
bit = var_1
var_0_0.TypeFreetime = var_1.lshift(1, 3)
var_0_0.TypeIndexs = {
	var_0_0.TypeScholl,
	var_0_0.TypeInterest,
	var_0_0.TypeCommunity,
	var_0_0.TypeFreetime
}
IndexConst = var_1
var_0_0.TypeAll = var_1.BitAll(var_0_0.TypeIndexs)
table = var_1

var_1.insert(var_0_0.TypeIndexs, 1, var_0_0.TypeAll)

local var_0_1 = {}

i18n = var_2
var_0_1[1] = var_2("index_all")
i18n = var_2
var_0_1[2] = var_2("child_plan_type1")
i18n = var_2
var_0_1[3] = var_2("child_plan_type2")
i18n = var_2
var_0_1[4] = var_2("child_plan_type3")
i18n = var_2
var_0_1[5] = var_2("child_plan_type4")
var_0_0.TypeNames = var_0_1

function var_0_0.filterByType(arg_1_0, arg_1_1)
	if not arg_1_1 or arg_1_1 == var_0_0.TypeAll then
		return true
	end

	for iter_1_0 = 2, #var_0_0.CONFIG.type do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_1_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_1_1)

		if 0 < var_1_10007 then
			var_1_10007 = var_0_0.CONFIG.type[iter_1_0].types
			table = var_8

			if var_8.contains(var_1_10007, arg_1_0:GetType()) then
				return true
			end
		end
	end

	return false
end

bit = var_1
var_0_0.CostMoney = var_1.lshift(1, 0)
bit = var_1
var_0_0.CostMood = var_1.lshift(1, 1)
var_0_0.CostIndexs = {
	var_0_0.CostMoney,
	var_0_0.CostMood
}
IndexConst = var_1
var_0_0.CostAll = var_1.BitAll(var_0_0.CostIndexs)
table = var_1

var_1.insert(var_0_0.CostIndexs, 1, var_0_0.CostAll)

local var_0_2 = {}

i18n = var_2
var_0_2[1] = var_2("index_all")
pg = var_2

local var_0_3 = var_2.child_resource

EducateChar = var_3
var_0_2[2] = var_0_3[var_3.RES_MONEY_ID].name
pg = var_2

local var_0_4 = var_2.child_resource

EducateChar = var_3
var_0_2[3] = var_0_4[var_3.RES_MOOD_ID].name
var_0_0.CostNames = var_0_2

function var_0_0.filterByCost(arg_2_0, arg_2_1)
	if not arg_2_1 or arg_2_1 == var_0_0.CostAll then
		return true
	end

	for iter_2_0 = 2, #var_0_0.CONFIG.cost do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_2_0 - 2)
		bit = var_1_10007
		var_1_10007 = var_1_10007.band(var_1_10006, arg_2_1)

		if 0 < var_1_10007 then
			var_1_10007 = var_0_0.CONFIG.cost[iter_2_0].names
			ipairs = var_8

			for iter_2_1, iter_2_2 in var_8(var_1_10007) do
				if arg_2_0:getConfig(iter_2_2) > 0 then
					return true
				end
			end
		end
	end

	return false
end

bit = var_1
var_0_0.AwardRes_Money = var_1.lshift(1, 0)
bit = var_1
var_0_0.AwardRes_Mood = var_1.lshift(1, 1)
var_0_0.AwardResIndexs = {
	var_0_0.AwardRes_Money,
	var_0_0.AwardRes_Mood
}
IndexConst = var_1
var_0_0.AwardResAll = var_1.BitAll(var_0_0.AwardResIndexs)
table = var_1

var_1.insert(var_0_0.AwardResIndexs, 1, var_0_0.AwardResAll)

local var_0_5 = {}

i18n = var_2
var_0_5[1] = var_2("child_filter_award_res")
pg = var_2

local var_0_6 = var_2.child_resource

EducateChar = var_3
var_0_5[2] = var_0_6[var_3.RES_MONEY_ID].name
pg = var_2

local var_0_7 = var_2.child_resource

EducateChar = var_3
var_0_5[3] = var_0_7[var_3.RES_MOOD_ID].name
var_0_0.AwardResNames = var_0_5

function var_0_0.filterByAwardRes(arg_3_0, arg_3_1)
	if not arg_3_1 or arg_3_1 == var_0_0.AwardResAll then
		return true
	end

	return var_0_0.filterByAward(arg_3_0, arg_3_1, "awardRes")
end

bit = var_1
var_0_0.AwardNature_Wukou = var_1.lshift(1, 0)
bit = var_1
var_0_0.AwardNature_Kailang = var_1.lshift(1, 1)
bit = var_1
var_0_0.AwardNature_Wenrou = var_1.lshift(1, 2)
var_0_0.AwardNatureIndexs = {
	var_0_0.AwardNature_Wukou,
	var_0_0.AwardNature_Kailang,
	var_0_0.AwardNature_Wenrou
}
IndexConst = var_1
var_0_0.AwardNatureAll = var_1.BitAll(var_0_0.AwardNatureIndexs)
table = var_1

var_1.insert(var_0_0.AwardNatureIndexs, 1, var_0_0.AwardNatureAll)

local var_0_8 = {}

i18n = var_2
var_0_8[1] = var_2("child_filter_award_nature")
pg = var_2
var_0_8[2] = var_2.child_attr[201].name
pg = var_2
var_0_8[3] = var_2.child_attr[202].name
pg = var_2
var_0_8[4] = var_2.child_attr[203].name
var_0_0.AwardNatureNames = var_0_8

function var_0_0.filterByAwardNature(arg_4_0, arg_4_1)
	if not arg_4_1 or arg_4_1 == var_0_0.AwardNatureAll then
		return true
	end

	return var_0_0.filterByAward(arg_4_0, arg_4_1, "awardNature")
end

bit = var_1
var_0_0.AwardAttr1_Meili = var_1.lshift(1, 0)
bit = var_1
var_0_0.AwardAttr1_Tineng = var_1.lshift(1, 1)
bit = var_1
var_0_0.AwardAttr1_Zhishi = var_1.lshift(1, 2)
bit = var_1
var_0_0.AwardAttr1_Ganzhi = var_1.lshift(1, 3)
var_0_0.AwardAttr1Indexs = {
	var_0_0.AwardAttr1_Meili,
	var_0_0.AwardAttr1_Tineng,
	var_0_0.AwardAttr1_Zhishi,
	var_0_0.AwardAttr1_Ganzhi
}
IndexConst = var_1
var_0_0.AwardAttr1All = var_1.BitAll(var_0_0.AwardAttr1Indexs)
table = var_1

var_1.insert(var_0_0.AwardAttr1Indexs, 1, var_0_0.AwardAttr1All)

local var_0_9 = {}

i18n = var_2
var_0_9[1] = var_2("child_filter_award_attr1")
pg = var_2
var_0_9[2] = var_2.child_attr[101].name
pg = var_2
var_0_9[3] = var_2.child_attr[102].name
pg = var_2
var_0_9[4] = var_2.child_attr[103].name
pg = var_2
var_0_9[5] = var_2.child_attr[104].name
var_0_0.AwardAttr1Names = var_0_9

function var_0_0.filterByAwardAttr1(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == var_0_0.AwardAttr1All then
		return true
	end

	return var_0_0.filterByAward(arg_5_0, arg_5_1, "awardAttr1")
end

bit = var_1
var_0_0.AwardAttr2_Biaoxianli = var_1.lshift(1, 0)
bit = var_1
var_0_0.AwardAttr2_Xiangxiang = var_1.lshift(1, 1)
bit = var_1
var_0_0.AwardAttr2_Yinyue = var_1.lshift(1, 2)
bit = var_1
var_0_0.AwardAttr2_Xixin = var_1.lshift(1, 3)
bit = var_1
var_0_0.AwardAttr2_Yundong = var_1.lshift(1, 4)
bit = var_1
var_0_0.AwardAttr2_Shijian = var_1.lshift(1, 5)
var_0_0.AwardAttr2Indexs = {
	var_0_0.AwardAttr2_Biaoxianli,
	var_0_0.AwardAttr2_Xiangxiang,
	var_0_0.AwardAttr2_Yinyue,
	var_0_0.AwardAttr2_Xixin,
	var_0_0.AwardAttr2_Yundong,
	var_0_0.AwardAttr2_Shijian
}
IndexConst = var_1
var_0_0.AwardAttr2All = var_1.BitAll(var_0_0.AwardAttr2Indexs)
table = var_1

var_1.insert(var_0_0.AwardAttr2Indexs, 1, var_0_0.AwardAttr2All)

local var_0_10 = {}

i18n = var_2
var_0_10[1] = var_2("child_filter_award_attr2")
pg = var_2
var_0_10[2] = var_2.child_attr[301].name
pg = var_2
var_0_10[3] = var_2.child_attr[302].name
pg = var_2
var_0_10[4] = var_2.child_attr[303].name
pg = var_2
var_0_10[5] = var_2.child_attr[304].name
pg = var_2
var_0_10[6] = var_2.child_attr[305].name
pg = var_2
var_0_10[7] = var_2.child_attr[306].name
var_0_0.AwardAttr2Names = var_0_10

function var_0_0.filterByAwardAttr2(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 == var_0_0.AwardAttr2All then
		return true
	end

	return var_0_0.filterByAward(arg_6_0, arg_6_1, "awardAttr2")
end

function var_0_0.filterByAward(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0 = 2, #var_0_0.CONFIG[arg_7_2] do
		bit = var_1_10007
		var_1_10007 = var_1_10007.lshift(1, iter_7_0 - 2)
		bit = var_1_10008
		var_1_10008 = var_1_10008.band(var_1_10007, arg_7_1)

		if 0 < var_1_10008 then
			var_1_10008 = var_0_0.CONFIG[arg_7_2][iter_7_0]
			ipairs = var_9

			for iter_7_1, iter_7_2 in var_9(var_1_10008.ids) do
				if arg_7_0:CheckResult(var_1_10008.type, iter_7_2) then
					return true
				end
			end
		end
	end

	return false
end

local var_0_11 = {}
local var_0_12 = {
	{
		types = {}
	}
}
local var_0_13 = {}
local var_0_14 = {}

EducatePlan = var_5
var_0_14[1] = var_5.TYPE_SCHOOL
var_0_13.types = var_0_14
var_0_12[2] = var_0_13

local var_0_15 = {}
local var_0_16 = {}

EducatePlan = var_5
var_0_16[1] = var_5.TYPE_INTEREST
var_0_15.types = var_0_16
var_0_12[3] = var_0_15

local var_0_17 = {}
local var_0_18 = {}

EducatePlan = var_5
var_0_18[1] = var_5.TYPE_COMMUNITY
var_0_17.types = var_0_18
var_0_12[4] = var_0_17

local var_0_19 = {}
local var_0_20 = {}

EducatePlan = var_5
var_0_20[1] = var_5.TYPE_FREETIME
var_0_19.types = var_0_20
var_0_12[5] = var_0_19
var_0_11.type = var_0_12
var_0_11.cost = {
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
}

local var_0_21 = {}
local var_0_22 = {}

EducateConst = var_4
var_0_22.type = var_4.DROP_TYPE_RES

local var_0_23 = {}

EducateChar = var_5
var_0_23[1] = var_5.RES_MONEY_ID
EducateChar = var_5
var_0_23[2] = var_5.RES_MOOD_ID
EducateChar = var_5
var_0_23[3] = var_5.RES_FAVOR_ID
var_0_22.ids = var_0_23
var_0_21[1] = var_0_22

local var_0_24 = {}

EducateConst = var_0_23
var_0_24.type = var_0_23.DROP_TYPE_RES

local var_0_25 = {}

EducateChar = var_5
var_0_25[1] = var_5.RES_MONEY_ID
var_0_24.ids = var_0_25
var_0_21[2] = var_0_24

local var_0_26 = {}

EducateConst = var_0_25
var_0_26.type = var_0_25.DROP_TYPE_RES

local var_0_27 = {}

EducateChar = var_5
var_0_27[1] = var_5.RES_MOOD_ID
var_0_26.ids = var_0_27
var_0_21[3] = var_0_26
var_0_11.awardRes = var_0_21

local var_0_28 = {}
local var_0_29 = {}

EducateConst = var_0_27
var_0_29.type = var_0_27.DROP_TYPE_ATTR
var_0_29.ids = {
	201,
	202,
	203
}
var_0_28[1] = var_0_29

local var_0_30 = {}

EducateConst = var_4
var_0_30.type = var_4.DROP_TYPE_ATTR
var_0_30.ids = {
	201
}
var_0_28[2] = var_0_30

local var_0_31 = {}

EducateConst = var_4
var_0_31.type = var_4.DROP_TYPE_ATTR
var_0_31.ids = {
	202
}
var_0_28[3] = var_0_31

local var_0_32 = {}

EducateConst = var_4
var_0_32.type = var_4.DROP_TYPE_ATTR
var_0_32.ids = {
	203
}
var_0_28[4] = var_0_32
var_0_11.awardNature = var_0_28

local var_0_33 = {}
local var_0_34 = {}

EducateConst = var_4
var_0_34.type = var_4.DROP_TYPE_ATTR
var_0_34.ids = {
	101,
	102,
	103,
	104
}
var_0_33[1] = var_0_34

local var_0_35 = {}

EducateConst = var_4
var_0_35.type = var_4.DROP_TYPE_ATTR
var_0_35.ids = {
	101
}
var_0_33[2] = var_0_35

local var_0_36 = {}

EducateConst = var_4
var_0_36.type = var_4.DROP_TYPE_ATTR
var_0_36.ids = {
	102
}
var_0_33[3] = var_0_36

local var_0_37 = {}

EducateConst = var_4
var_0_37.type = var_4.DROP_TYPE_ATTR
var_0_37.ids = {
	103
}
var_0_33[4] = var_0_37

local var_0_38 = {}

EducateConst = var_4
var_0_38.type = var_4.DROP_TYPE_ATTR
var_0_38.ids = {
	104
}
var_0_33[5] = var_0_38
var_0_11.awardAttr1 = var_0_33

local var_0_39 = {}
local var_0_40 = {}

EducateConst = var_4
var_0_40.type = var_4.DROP_TYPE_ATTR
var_0_40.ids = {
	301,
	302,
	303,
	304,
	305,
	306
}
var_0_39[1] = var_0_40

local var_0_41 = {}

EducateConst = var_4
var_0_41.type = var_4.DROP_TYPE_ATTR
var_0_41.ids = {
	301
}
var_0_39[2] = var_0_41

local var_0_42 = {}

EducateConst = var_4
var_0_42.type = var_4.DROP_TYPE_ATTR
var_0_42.ids = {
	302
}
var_0_39[3] = var_0_42

local var_0_43 = {}

EducateConst = var_4
var_0_43.type = var_4.DROP_TYPE_ATTR
var_0_43.ids = {
	303
}
var_0_39[4] = var_0_43

local var_0_44 = {}

EducateConst = var_4
var_0_44.type = var_4.DROP_TYPE_ATTR
var_0_44.ids = {
	304
}
var_0_39[5] = var_0_44

local var_0_45 = {}

EducateConst = var_4
var_0_45.type = var_4.DROP_TYPE_ATTR
var_0_45.ids = {
	305
}
var_0_39[6] = var_0_45

local var_0_46 = {}

EducateConst = var_4
var_0_46.type = var_4.DROP_TYPE_ATTR
var_0_46.ids = {
	306
}
var_0_39[7] = var_0_46
var_0_11.awardAttr2 = var_0_39
var_0_0.CONFIG = var_0_11

return var_0_0
