local var_0_0 = singletonClass("AntitheticalCoupletData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if not var_0_1[var_2_0] then
		var_0_1[var_2_0] = {}
		var_0_1[var_2_0].id = var_2_0
		var_0_1[var_2_0].isOpen = arg_2_1.select_id ~= 0
	end

	var_0_1[var_2_0].chooseID = arg_2_1.select_id
	var_0_1[var_2_0].isReward = arg_2_1.is_already_receive
end

function var_0_0.GetData(arg_3_0, arg_3_1)
	return var_0_1[arg_3_1]
end

function var_0_0.SetReward(arg_4_0, arg_4_1)
	if var_0_1[arg_4_1] then
		var_0_1[arg_4_1].isReward = true
	end
end

function var_0_0.SetChooseID(arg_5_0, arg_5_1, arg_5_2)
	if var_0_1[arg_5_1] then
		var_0_1[arg_5_1].chooseID = arg_5_2
	end
end

function var_0_0.SetOpen(arg_6_0, arg_6_1)
	if var_0_1[arg_6_1] then
		var_0_1[arg_6_1].isOpen = true

		manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. arg_6_1, 0)
	end
end

function var_0_0.GetLastLevel(arg_7_0, arg_7_1)
	return var_0_2[arg_7_1]
end

function var_0_0.SaveLastSelect(arg_8_0, arg_8_1, arg_8_2)
	var_0_2[arg_8_1] = arg_8_2
end

return var_0_0
