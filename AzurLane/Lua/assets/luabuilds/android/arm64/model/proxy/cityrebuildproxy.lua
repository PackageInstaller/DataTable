class = var_0_10000

local var_0_0 = "CityRebuildProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.GET_DATA = 1
var_0_1.REBUILD_OR_START_RECRUIT = 2
var_0_1.END_RECRUIT = 3
var_0_1.UPGRADE_BUFF = 4
var_0_1.RESULT = 5
var_0_1.CHOOSE_LEVEL = 6
var_0_1.INIT_TIME = 7
pg = var_1

local var_0_2 = var_1.activity_ninja_building

function var_0_1.register(arg_1_0)
	arg_1_0.cityRebuildDataDic = {}

	return
end

function var_0_1.SetData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.cityRebuildDataDic

	CityRebuildData = var_1_10004
	var_2_0[arg_2_1] = var_1_10004.New(arg_2_2)

	return
end

function var_0_1.GetData(arg_3_0, arg_3_1)
	return arg_3_0.cityRebuildDataDic[arg_3_1]
end

function var_0_1.Adjust(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.cityRebuildDataDic[arg_4_1] then
		return
	end

	var_3:Adjust(arg_4_2)

	return
end

function var_0_1.RebuildOrStartRecruit(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.cityRebuildDataDic[arg_5_1] then
		return
	end

	if var_0_2[arg_5_2].type == 1 then
		var_3:RebuildDone(arg_5_2)
	else
		var_3:StartRecruit(arg_5_2)
	end

	return
end

function var_0_1.RecruitDone(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.cityRebuildDataDic[arg_6_1] then
		return
	end

	var_3:RecruitDone(arg_6_2)

	return
end

function var_0_1.UpgradeBuff(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0.cityRebuildDataDic[arg_7_1] then
		return
	end

	var_4:UpgradeBuff(arg_7_2, arg_7_3)

	return
end

function var_0_1.Result(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.cityRebuildDataDic[arg_8_1] then
		return
	end

	var_3:Result(arg_8_2)

	return
end

function var_0_1.UpdateChooseLevel(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.cityRebuildDataDic[arg_9_1] then
		return
	end

	var_3:UpdateChooseLevel(arg_9_2)

	return
end

function var_0_1.ComsumePt(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.cityRebuildDataDic[arg_10_1] then
		return
	end

	var_3:ConsumePt(arg_10_2)

	return
end

function var_0_1.AddPt(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.cityRebuildDataDic[arg_11_1] then
		return
	end

	var_3:AddPt(arg_11_2)

	return
end

return var_0_1
