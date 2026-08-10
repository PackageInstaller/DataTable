local var_0_0 = class("ChallengeRogueTeamMapData")

function var_0_0.Init(arg_1_0)
	arg_1_0.nodeList_ = {}
	arg_1_0.nodePathList_ = {}
	arg_1_0.finishPath_ = {}
end

function var_0_0.PathInitData(arg_2_0, arg_2_1)
	arg_2_0.nodeList_ = {}
	arg_2_0.nodePathList_ = {}

	arg_2_0:PathUpdateMapNode(arg_2_1)
	arg_2_0:SearchFinishPath()
end

function var_0_0.ParseNodeData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.node_id

	arg_3_0.nodeList_[var_3_0] = {
		nodeID = var_3_0,
		col = arg_3_1.col,
		row = arg_3_1.row,
		nodeType = arg_3_1.node_type,
		nextIDList = arg_3_1.next_id_list,
		state = arg_3_1.state,
		param = arg_3_1.param
	}
	arg_3_0.nodePathList_[arg_3_1.col] = arg_3_0.nodePathList_[arg_3_1.col] or {}
	arg_3_0.nodePathList_[arg_3_1.col][arg_3_1.row] = var_3_0
end

function var_0_0.PathUpdateMapNode(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:ParseNodeData(iter_4_1)
	end

	arg_4_0:FixedCol()
end

function var_0_0.FixedCol(arg_5_0)
	local var_5_0 = ChallengeRogueTeamTools.GetMapMaxRowCnt()
	local var_5_1 = (var_5_0 + 1) / 2

	if var_5_0 == 5 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.nodePathList_) do
			local var_5_2 = table.length(iter_5_1)

			if var_5_2 == 1 then
				for iter_5_2 = 1, var_5_0 do
					local var_5_3 = iter_5_1[iter_5_2]

					if var_5_3 then
						arg_5_0.nodeList_[var_5_3].row = var_5_1
					end
				end
			elseif var_5_2 == 2 then
				local var_5_4 = 1

				for iter_5_3 = 1, var_5_0 do
					local var_5_5 = iter_5_1[iter_5_3]

					if var_5_5 then
						arg_5_0.nodeList_[var_5_5].row = 2 * var_5_4
						var_5_4 = var_5_4 + 1
					end
				end
			elseif var_5_2 == var_5_1 then
				local var_5_6 = 0

				for iter_5_4 = 1, var_5_0 do
					local var_5_7 = iter_5_1[iter_5_4]

					if var_5_7 then
						arg_5_0.nodeList_[var_5_7].row = 1 + var_5_6 * 2
						var_5_6 = var_5_6 + 1
					end
				end
			end
		end
	end
end

function var_0_0.SearchFinishPath(arg_6_0)
	arg_6_0.finishPath_ = {}

	for iter_6_0 = 1, #arg_6_0.nodePathList_ do
		for iter_6_1, iter_6_2 in pairs(arg_6_0.nodePathList_[iter_6_0]) do
			if arg_6_0:IsCleanNode(iter_6_2) then
				table.insert(arg_6_0.finishPath_, iter_6_2)

				break
			end
		end

		if iter_6_0 > #arg_6_0.finishPath_ then
			return
		end
	end
end

function var_0_0.PathGetNodeList(arg_7_0)
	return arg_7_0.nodeList_
end

function var_0_0.PathGetNodePathList(arg_8_0)
	return arg_8_0.nodePathList_
end

function var_0_0.PathGetNodeData(arg_9_0, arg_9_1)
	return arg_9_0.nodeList_[arg_9_1]
end

function var_0_0.IsCleanNode(arg_10_0, arg_10_1)
	return arg_10_0.nodeList_[arg_10_1].state == ChallengeRogueTeamConst.NODE_STATE.OVER
end

function var_0_0.PathGetFinishPath(arg_11_0)
	return arg_11_0.finishPath_
end

function var_0_0.PathFinishNodeData(arg_12_0, arg_12_1)
	table.insert(arg_12_0.finishPath_, arg_12_1)
end

function var_0_0.IsFinishMap(arg_13_0)
	local var_13_0 = #arg_13_0.nodePathList_

	if var_13_0 <= 0 then
		return true
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.nodePathList_[var_13_0] or {}) do
		if arg_13_0:IsCleanNode(iter_13_1) then
			return true
		end
	end

	return false
end

return var_0_0
