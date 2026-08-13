class = var_0_10000

local var_0_0 = var_0_10000("MetaPTData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.groupID = arg_1_1.group_id
	pg = var_1_10003

	local var_1_0 = var_1_10003.ship_strengthen_meta[var_2]

	assert = var_1_10004

	var_1_10004(var_1_0 ~= nil, "Null MetaShip Strengthen Data, ID:" .. var_2)

	arg_1_0.targets = var_1_0.target
	arg_1_0.dropList = var_1_0.award_display
	arg_1_0.resId = var_1_0.itemid
	arg_1_0.count = 0
	arg_1_0.level = 0
	arg_1_0.curLevel = arg_1_0.level + 1

	return
end

function var_0_0.initFromServerData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.pt then
		var_2_0 = 0
	end

	arg_2_0.count = var_2_0

	local var_2_1 = #arg_2_1.fetch_list

	if 0 < var_2_1 then
		var_2_1 = {}
		ipairs = var_4

		for iter_2_0, iter_2_1 in var_4(var_2) do
			table = var_1_10009

			var_1_10009.insert(var_2_1, iter_2_1)
		end

		table = var_4

		var_4.sort(var_2_1)

		ipairs = var_4

		for iter_2_2, iter_2_3 in var_4(var_2_1) do
			if iter_2_3 == arg_2_0.targets[iter_2_2] then
				arg_2_0.level = iter_2_2
			else
				break
			end
		end
	end

	math = var_2_1
	arg_2_0.curLevel = var_2_1.min(arg_2_0.level + 1, #arg_2_0.targets)

	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_1.pt then
		var_3_0 = arg_3_0.count
	end

	arg_3_0.count = var_3_0

	local var_3_1

	if not arg_3_1.level then
		var_3_1 = arg_3_0.level
	end

	arg_3_0.level = var_3_1
	arg_3_0.curLevel = arg_3_0.level + 1

	return
end

function var_0_0.updateLevel(arg_4_0, arg_4_1)
	arg_4_0.level = arg_4_1
	math = var_1_10002
	arg_4_0.curLevel = var_1_10002.min(arg_4_0.level + 1, #arg_4_0.targets)

	return
end

function var_0_0.addPT(arg_5_0, arg_5_1)
	arg_5_0.count = arg_5_0.count + arg_5_1

	return
end

function var_0_0.GetResProgress(arg_6_0)
	local var_6_0 = arg_6_0.count / arg_6_0.targets[arg_6_0.curLevel]

	return var_1, var_2, var_6_0
end

function var_0_0.GetLevelProgress(arg_7_0)
	local var_7_0 = arg_7_0.curLevel / #arg_7_0.targets

	return var_1, var_2, var_7_0
end

function var_0_0.CanGetAward(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:GetResProgress()
	local var_8_3

	if arg_8_0:CanGetNextAward() then
		var_8_3 = var_8_2 >= 1
	end

	return var_8_3
end

function var_0_0.CanGetNextAward(arg_9_0)
	return arg_9_0.level < #arg_9_0.targets
end

function var_0_0.GetTotalResRequire(arg_10_0)
	return arg_10_0.targets[#arg_10_0.targets]
end

function var_0_0.IsMaxPt(arg_11_0)
	return arg_11_0.count >= arg_11_0:GetTotalResRequire()
end

return var_0_0
