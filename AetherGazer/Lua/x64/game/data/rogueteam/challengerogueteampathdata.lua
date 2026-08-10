local var_0_0 = import(".subClass.ChallengeRogueTeamMapData")
local var_0_1 = class("ChallengeRogueTeamPathData")

function var_0_1.ExportMethod(arg_1_0)
	return {
		"PathInitData",
		"PathUpdateMapNode",
		"PathGetNodeList",
		"PathGetNodePathList",
		"PathGetNodeData",
		"PathSetSelectedNodeID",
		"PathGetSelectedNodeID",
		"PathGetFinishPath",
		"PathGetFloorState",
		"PathGetCurrentFloorNum",
		"PathSetFloorState",
		"PathIsNormalMap",
		"PathClearData",
		"PathExitSecondMap",
		"PathGetRogueTeamMapID",
		"CheckFinishNode"
	}
end

function var_0_1.Init(arg_2_0)
	arg_2_0.currentFloorNum_ = 0
	arg_2_0.currentFloorState_ = ChallengeRogueTeamConst.FLOOR_STATE.NORMAL
	arg_2_0.selectedNodeID_ = 0

	if not arg_2_0.mapData_ then
		arg_2_0.mapData_ = {
			var_0_0.New(),
			(var_0_0.New())
		}
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.mapData_) do
		iter_2_1:Init()
	end
end

function var_0_1.PathClearData(arg_3_0)
	arg_3_0.exitSecondMapFlag_ = false
end

function var_0_1.PathInitData(arg_4_0, arg_4_1)
	arg_4_0.currentFloorNum_ = arg_4_1.floor_num

	arg_4_0:PathSetFloorState(arg_4_1.floor_state)

	arg_4_0.selectedNodeID_ = arg_4_1.select_node_id

	arg_4_0.mapData_[1]:PathInitData(arg_4_1.map_info)
	arg_4_0.mapData_[2]:PathInitData(arg_4_1.second_map_info)
	arg_4_0:CheckFinishNode()
end

function var_0_1.PathUpdateMapNode(arg_5_0, arg_5_1)
	arg_5_0.mapData_[1]:PathUpdateMapNode(arg_5_1.map_info)
	arg_5_0.mapData_[2]:PathUpdateMapNode(arg_5_1.second_map_info)
	arg_5_0:CheckFinishNode()
end

function var_0_1.PathGetNodeList(arg_6_0)
	return arg_6_0.mapData_[arg_6_0.currentMapIndex_]:PathGetNodeList()
end

function var_0_1.PathGetNodePathList(arg_7_0)
	return arg_7_0.mapData_[arg_7_0.currentMapIndex_]:PathGetNodePathList()
end

function var_0_1.PathGetNodeData(arg_8_0, arg_8_1)
	return arg_8_0.mapData_[arg_8_0.currentMapIndex_]:PathGetNodeData(arg_8_1)
end

function var_0_1.PathSetSelectedNodeID(arg_9_0, arg_9_1)
	arg_9_0.selectedNodeID_ = arg_9_1
end

function var_0_1.PathGetSelectedNodeID(arg_10_0)
	return arg_10_0.selectedNodeID_
end

function var_0_1.PathGetFinishPath(arg_11_0)
	return arg_11_0.mapData_[arg_11_0.currentMapIndex_]:PathGetFinishPath()
end

function var_0_1.PathGetFloorState(arg_12_0)
	return arg_12_0.currentFloorState_
end

function var_0_1.PathSetFloorState(arg_13_0, arg_13_1)
	arg_13_0.currentFloorState_ = arg_13_1
end

function var_0_1.PathGetCurrentFloorNum(arg_14_0)
	return arg_14_0.currentFloorNum_
end

function var_0_1.CheckFinishNode(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.mapData_) do
		for iter_15_2, iter_15_3 in pairs(iter_15_1:PathGetNodeList()) do
			local var_15_0 = iter_15_3.nodeID

			if var_15_0 == arg_15_0.selectedNodeID_ and iter_15_3.state == ChallengeRogueTeamConst.NODE_STATE.OVER then
				iter_15_1:PathFinishNodeData(var_15_0)

				if arg_15_0.selectedNodeID_ == var_15_0 then
					arg_15_0:PathSetSelectedNodeID(0)
				end
			end
		end
	end

	arg_15_0.currentMapIndex_ = 1

	if ChallengeRogueTeamData:GetRefreshMapFlag() == ChallengeRogueTeamConst.MAP_FLOOR_SWTICH.EXIT_HIDDEN then
		arg_15_0.currentMapIndex_ = #arg_15_0.mapData_

		return
	end

	if ChallengeRogueTeamData:GetRefreshMapFlag() == ChallengeRogueTeamConst.MAP_FLOOR_SWTICH.ENTER_HIDDEN then
		return
	end

	if arg_15_0.exitSecondMapFlag_ == true then
		return
	end

	for iter_15_4 = #arg_15_0.mapData_, 1, -1 do
		if not arg_15_0.mapData_[iter_15_4]:IsFinishMap() then
			arg_15_0.currentMapIndex_ = iter_15_4

			break
		end
	end
end

function var_0_1.PathIsNormalMap(arg_16_0)
	return arg_16_0.currentMapIndex_ == 1
end

function var_0_1.PathExitSecondMap(arg_17_0)
	arg_17_0.exitSecondMapFlag_ = true

	arg_17_0:CheckFinishNode()
end

function var_0_1.PathGetRogueTeamMapID(arg_18_0, arg_18_1)
	local var_18_0 = 0

	if ChallengeRogueTeamData:PathIsNormalMap() then
		var_18_0 = arg_18_0.selectedNodeID_
	end

	if var_18_0 == 0 then
		local var_18_1 = arg_18_0.mapData_[1]:PathGetFinishPath()

		var_18_0 = var_18_1[#var_18_1]
	end

	local var_18_2 = arg_18_0.mapData_[1]:PathGetNodeData(var_18_0)
	local var_18_3 = RogueTeamCfg[arg_18_1].map_temp

	return RogueTeamMapCfg.get_id_list_by_temp_id_tier_col[var_18_3][arg_18_0.currentFloorNum_][var_18_2.col][1]
end

return var_0_1
