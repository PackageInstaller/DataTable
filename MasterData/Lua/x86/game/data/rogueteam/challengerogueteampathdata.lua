local ChallengeRogueTeamMapData = import(".subClass.ChallengeRogueTeamMapData")
local ChallengeRogueTeamPathData = class("ChallengeRogueTeamPathData")

function ChallengeRogueTeamPathData:ExportMethod()
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

function ChallengeRogueTeamPathData:Init()
	self.currentFloorNum_ = 0
	self.currentFloorState_ = ChallengeRogueTeamConst.FLOOR_STATE.NORMAL
	self.selectedNodeID_ = 0
	self.mapData_ = self.mapData_ or {
		ChallengeRogueTeamMapData.New(),
		(ChallengeRogueTeamMapData.New())
	}

	for iter_2_0, iter_2_1 in ipairs(self.mapData_) do
		iter_2_1:Init()
	end
end

function ChallengeRogueTeamPathData:PathClearData()
	self.exitSecondMapFlag_ = false
end

function ChallengeRogueTeamPathData:PathInitData(arg_4_1)
	self.currentFloorNum_ = arg_4_1.floor_num

	self:PathSetFloorState(arg_4_1.floor_state)

	self.selectedNodeID_ = arg_4_1.select_node_id

	self.mapData_[1]:PathInitData(arg_4_1.map_info)
	self.mapData_[2]:PathInitData(arg_4_1.second_map_info)
	self:CheckFinishNode()
end

function ChallengeRogueTeamPathData:PathUpdateMapNode(arg_5_1)
	self.mapData_[1]:PathUpdateMapNode(arg_5_1.map_info)
	self.mapData_[2]:PathUpdateMapNode(arg_5_1.second_map_info)
	self:CheckFinishNode()
end

function ChallengeRogueTeamPathData:PathGetNodeList()
	return self.mapData_[self.currentMapIndex_]:PathGetNodeList()
end

function ChallengeRogueTeamPathData:PathGetNodePathList()
	return self.mapData_[self.currentMapIndex_]:PathGetNodePathList()
end

function ChallengeRogueTeamPathData:PathGetNodeData(arg_8_1)
	return self.mapData_[self.currentMapIndex_]:PathGetNodeData(arg_8_1)
end

function ChallengeRogueTeamPathData:PathSetSelectedNodeID(arg_9_1)
	self.selectedNodeID_ = arg_9_1
end

function ChallengeRogueTeamPathData:PathGetSelectedNodeID()
	return self.selectedNodeID_
end

function ChallengeRogueTeamPathData:PathGetFinishPath()
	return self.mapData_[self.currentMapIndex_]:PathGetFinishPath()
end

function ChallengeRogueTeamPathData:PathGetFloorState()
	return self.currentFloorState_
end

function ChallengeRogueTeamPathData:PathSetFloorState(arg_13_1)
	self.currentFloorState_ = arg_13_1
end

function ChallengeRogueTeamPathData:PathGetCurrentFloorNum()
	return self.currentFloorNum_
end

function ChallengeRogueTeamPathData:CheckFinishNode()
	for iter_15_0, iter_15_1 in ipairs(self.mapData_) do
		for iter_15_2, iter_15_3 in pairs(iter_15_1:PathGetNodeList()) do
			if iter_15_3.nodeID == self.selectedNodeID_ and iter_15_3.state == ChallengeRogueTeamConst.NODE_STATE.OVER then
				iter_15_1:PathFinishNodeData(iter_15_3.nodeID)

				if self.selectedNodeID_ == iter_15_3.nodeID then
					self:PathSetSelectedNodeID(0)
				end
			end
		end
	end

	self.currentMapIndex_ = 1

	if ChallengeRogueTeamData:GetRefreshMapFlag() == ChallengeRogueTeamConst.MAP_FLOOR_SWTICH.EXIT_HIDDEN then
		self.currentMapIndex_ = #self.mapData_

		return
	end

	if ChallengeRogueTeamData:GetRefreshMapFlag() == ChallengeRogueTeamConst.MAP_FLOOR_SWTICH.ENTER_HIDDEN then
		return
	end

	if self.exitSecondMapFlag_ == true then
		return
	end

	for iter_15_4 = #self.mapData_, 1, -1 do
		if not self.mapData_[iter_15_4]:IsFinishMap() then
			self.currentMapIndex_ = iter_15_4

			break
		end
	end
end

function ChallengeRogueTeamPathData:PathIsNormalMap()
	return self.currentMapIndex_ == 1
end

function ChallengeRogueTeamPathData:PathExitSecondMap()
	self.exitSecondMapFlag_ = true

	self:CheckFinishNode()
end

function ChallengeRogueTeamPathData:PathGetRogueTeamMapID(arg_18_1)
	local var_18_0 = 0

	if ChallengeRogueTeamData:PathIsNormalMap() then
		var_18_0 = self.selectedNodeID_
	end

	if var_18_0 == 0 then
		local var_18_1 = self.mapData_[1]:PathGetFinishPath()

		var_18_0 = var_18_1[#var_18_1]
	end

	return RogueTeamMapCfg.get_id_list_by_temp_id_tier_col[RogueTeamCfg[arg_18_1].map_temp][self.currentFloorNum_][self.mapData_[1]:PathGetNodeData(var_18_0).col][1]
end

return ChallengeRogueTeamPathData
