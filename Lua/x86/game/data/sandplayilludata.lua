local var_0_0 = singletonClass("SandplayIlluData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = 0
local var_0_4 = {
	NOT_SEE = 0,
	NOT_REWARD = 1,
	REWARD = 2
}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = 0
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = arg_2_1.activity_id

	local var_2_0 = arg_2_1.data

	if not var_2_0 then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_0.item_list) do
		local var_2_1 = iter_2_1.id
		local var_2_2 = SandplayIlluCfg[var_2_1]

		if var_2_2 == nil then
			Debug.LogError("收藏品ID有误:" .. tostring(var_2_1))

			break
		end

		local var_2_3 = var_2_2.type

		if not var_0_2[var_2_3] then
			var_0_2[var_2_3] = {}
		end

		local var_2_4 = {
			id = iter_2_1.id,
			state = iter_2_1.state
		}

		var_0_1[var_2_1] = var_2_4

		table.insert(var_0_2[var_2_3], var_2_1)
	end
end

function var_0_0.GetActivityID(arg_3_0)
	return var_0_3
end

function var_0_0.SetNewItem(arg_4_0, arg_4_1)
	local var_4_0 = SandplayIlluCfg[arg_4_1]

	if var_4_0 == nil then
		Debug.Log("收藏品ID有误:" .. tostring(arg_4_1))

		return
	end

	local var_4_1 = var_4_0.type

	if var_0_2[var_4_1] == nil then
		var_0_2[var_4_1] = {}
	end

	if var_0_1[arg_4_1] == nil then
		local var_4_2 = {
			id = arg_4_1,
			state = var_0_4.NOT_SEE
		}

		var_0_1[arg_4_1] = var_4_2

		for iter_4_0, iter_4_1 in ipairs(var_0_2[var_4_1]) do
			if iter_4_1 == arg_4_1 then
				return
			end
		end

		table.insert(var_0_2[var_4_1], arg_4_1)
	end
end

function var_0_0.UpdateItemDataSaw(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_1[arg_5_1]

	if var_5_0 then
		var_5_0.state = arg_5_2 and var_0_4.NOT_REWARD or var_0_4.NOT_SEE
	end
end

function var_0_0.UpdateItemDataReward(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_1[arg_6_1]

	if var_6_0 then
		var_6_0.state = arg_6_2 and var_0_4.REWARD or var_0_4.NOT_REWARD
	end
end

function var_0_0.ModifyMainQuestID(arg_7_0, arg_7_1)
	if QWorldQuestTool.IsMainQuestFinish(arg_7_1) then
		local var_7_0 = SandplayIlluCfg.get_id_list_by_task_id[arg_7_1]

		if var_7_0 then
			for iter_7_0, iter_7_1 in ipairs(var_7_0) do
				arg_7_0:SetNewItem(iter_7_1)
				QWorldData:AddItemHint(iter_7_1)
				Debug.Log("sandplayilluTest_____ Gain itemID:" .. tostring(iter_7_1))
			end
		end
	end
end

function var_0_0.GetGroupNum(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(var_0_2) do
		if iter_8_1 and type(iter_8_1) == "table" and #iter_8_1 > 0 then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.GetGroupList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(var_0_2) do
		if iter_9_1 and type(iter_9_1) == "table" and #iter_9_1 > 0 then
			table.insert(var_9_0, iter_9_0)
		end
	end

	table.sort(var_9_0)

	return var_9_0
end

function var_0_0.GetItemNum(arg_10_0, arg_10_1)
	if var_0_2[arg_10_1] then
		return #var_0_2[arg_10_1]
	end

	return 0
end

function var_0_0.IsUnlock(arg_11_0, arg_11_1)
	if var_0_1[arg_11_1] == nil then
		return false
	end

	return true
end

function var_0_0.IsSaw(arg_12_0, arg_12_1)
	local var_12_0 = var_0_1[arg_12_1]

	if var_12_0 and var_12_0.state ~= var_0_4.NOT_SEE then
		return true
	end

	return false
end

function var_0_0.IsReceive(arg_13_0, arg_13_1)
	local var_13_0 = var_0_1[arg_13_1]

	if var_13_0 and var_13_0.state == var_0_4.REWARD then
		return true
	end

	return false
end

function var_0_0.GetAwardID(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs(var_0_1) do
		if iter_14_1.state ~= var_0_4.REWARD then
			table.insert(var_14_0, iter_14_1.id)
		else
			table.insert(var_14_1, iter_14_1.id)
		end
	end

	return var_14_0, var_14_1
end

return var_0_0
