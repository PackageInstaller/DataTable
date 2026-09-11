local ChallengeRogueTeamMapData = class("ChallengeRogueTeamMapData")

function ChallengeRogueTeamMapData:Init()
	self.nodeList_ = {}
	self.nodePathList_ = {}
	self.finishPath_ = {}
end

function ChallengeRogueTeamMapData:PathInitData(arg_2_1)
	self.nodeList_ = {}
	self.nodePathList_ = {}

	self:PathUpdateMapNode(arg_2_1)
	self:SearchFinishPath()
end

function ChallengeRogueTeamMapData:ParseNodeData(arg_3_1)
	self.nodeList_[arg_3_1.node_id] = {
		nodeID = arg_3_1.node_id,
		col = arg_3_1.col,
		row = arg_3_1.row,
		nodeType = arg_3_1.node_type,
		nextIDList = arg_3_1.next_id_list,
		state = arg_3_1.state,
		param = arg_3_1.param
	}
	self.nodePathList_[arg_3_1.col] = self.nodePathList_[arg_3_1.col] or {}
	self.nodePathList_[arg_3_1.col][arg_3_1.row] = arg_3_1.node_id
end

function ChallengeRogueTeamMapData:PathUpdateMapNode(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self:ParseNodeData(iter_4_1)
	end

	self:FixedCol()
end

function ChallengeRogueTeamMapData:FixedCol()
	local var_5_0 = ChallengeRogueTeamTools.GetMapMaxRowCnt()

	if var_5_0 == 5 then
		for iter_5_0, iter_5_1 in ipairs(self.nodePathList_) do
			local var_5_1 = table.length(iter_5_1)

			if var_5_1 == 1 then
				for iter_5_2 = 1, var_5_0 do
					if iter_5_1[iter_5_2] then
						self.nodeList_[iter_5_1[iter_5_2]].row = (var_5_0 + 1) / 2
					end
				end
			elseif var_5_1 == 2 then
				local var_5_2 = 1

				for iter_5_3 = 1, var_5_0 do
					if iter_5_1[iter_5_3] then
						self.nodeList_[iter_5_1[iter_5_3]].row = 2 * var_5_2
						var_5_2 = var_5_2 + 1
					end
				end
			elseif var_5_1 == (var_5_0 + 1) / 2 then
				local var_5_3 = 0

				for iter_5_4 = 1, var_5_0 do
					if iter_5_1[iter_5_4] then
						self.nodeList_[iter_5_1[iter_5_4]].row = 1 + var_5_3 * 2
						var_5_3 = var_5_3 + 1
					end
				end
			end
		end
	end
end

function ChallengeRogueTeamMapData:SearchFinishPath()
	self.finishPath_ = {}

	for iter_6_0 = 1, #self.nodePathList_ do
		for iter_6_1, iter_6_2 in pairs(self.nodePathList_[iter_6_0]) do
			if self:IsCleanNode(iter_6_2) then
				table.insert(self.finishPath_, iter_6_2)

				break
			end
		end

		if iter_6_0 > #self.finishPath_ then
			return
		end
	end
end

function ChallengeRogueTeamMapData:PathGetNodeList()
	return self.nodeList_
end

function ChallengeRogueTeamMapData:PathGetNodePathList()
	return self.nodePathList_
end

function ChallengeRogueTeamMapData:PathGetNodeData(arg_9_1)
	return self.nodeList_[arg_9_1]
end

function ChallengeRogueTeamMapData:IsCleanNode(arg_10_1)
	return self.nodeList_[arg_10_1].state == ChallengeRogueTeamConst.NODE_STATE.OVER
end

function ChallengeRogueTeamMapData:PathGetFinishPath()
	return self.finishPath_
end

function ChallengeRogueTeamMapData:PathFinishNodeData(arg_12_1)
	table.insert(self.finishPath_, arg_12_1)
end

function ChallengeRogueTeamMapData:IsFinishMap()
	if #self.nodePathList_ <= 0 then
		return true
	end

	for iter_13_0, iter_13_1 in pairs(self.nodePathList_[#self.nodePathList_] or {}) do
		if self:IsCleanNode(iter_13_1) then
			return true
		end
	end

	return false
end

return ChallengeRogueTeamMapData
