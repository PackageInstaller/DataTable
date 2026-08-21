local var_0_0 = class("MetaPTData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.groupID = arg_1_1.group_id

	local var_1_0 = pg.ship_strengthen_meta[arg_1_1.group_id]

	assert(pg.ship_strengthen_meta[arg_1_1.group_id] ~= nil, "Null MetaShip Strengthen Data, ID:" .. arg_1_1.group_id)

	arg_1_0.targets = var_1_0.target
	arg_1_0.dropList = var_1_0.award_display
	arg_1_0.resId = var_1_0.itemid
	arg_1_0.count = 0
	arg_1_0.level = 0
	arg_1_0.curLevel = arg_1_0.level + 1

	return
end

function var_0_0.initFromServerData(arg_2_0, arg_2_1)
	arg_2_0.count = arg_2_1.pt or 0

	if #arg_2_1.fetch_list > 0 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.fetch_list) do
			table.insert({}, iter_2_1)
		end

		table.sort({})

		for iter_2_2, iter_2_3 in ipairs({}) do
			if iter_2_3 == arg_2_0.targets[iter_2_2] then
				arg_2_0.level = iter_2_2
			else
				break
			end
		end
	end

	arg_2_0.curLevel = math.min(arg_2_0.level + 1, #arg_2_0.targets)

	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.count = arg_3_1.pt or arg_3_0.count
	arg_3_0.level = arg_3_1.level or arg_3_0.level
	arg_3_0.curLevel = arg_3_0.level + 1

	return
end

function var_0_0.updateLevel(arg_4_0, arg_4_1)
	arg_4_0.level = arg_4_1
	arg_4_0.curLevel = math.min(arg_4_0.level + 1, #arg_4_0.targets)

	return
end

function var_0_0.addPT(arg_5_0, arg_5_1)
	arg_5_0.count = arg_5_0.count + arg_5_1

	return
end

function var_0_0.GetResProgress(arg_6_0)
	return arg_6_0.count, arg_6_0.targets[arg_6_0.curLevel], arg_6_0.count / arg_6_0.targets[arg_6_0.curLevel]
end

function var_0_0.GetLevelProgress(arg_7_0)
	return arg_7_0.curLevel, #arg_7_0.targets, arg_7_0.curLevel / #arg_7_0.targets
end

function var_0_0.CanGetAward(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:GetResProgress()

	return arg_8_0:CanGetNextAward() and var_8_2 >= 1
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
