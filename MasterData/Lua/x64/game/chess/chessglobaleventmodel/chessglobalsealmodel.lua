local ChessGlobalSealModel = class("ChessGlobalSealModel")

local function var_0_1(arg_1_0)
	if not arg_1_0 or arg_1_0.paramList.Length == 0 then
		return false
	end

	local var_1_0 = WarchessEventPoolCfg[arg_1_0.paramList[0]].event_group_second

	if WarchessEventPoolCfg[arg_1_0.paramList[0]].event_group_second == "" then
		return false
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1[1] == 15001 then
			return true
		end
	end

	return false
end

function ChessGlobalSealModel:Ctor()
	self.areaMemory_ = {}
	self.isRight_ = false
	self.areaCount_ = 0
	self.defaultState_ = 0
	self.sealState_ = 0
	self.successState_ = 0
end

function ChessGlobalSealModel:SetUp(arg_3_1)
	self.curEventID_ = arg_3_1
	self.areaMemory_ = {}
	self.areaCount_ = 0
	self.sealState_ = WarchessGlobalCfg[arg_3_1].params[4][1]
	self.successState_ = WarchessGlobalCfg[arg_3_1].params[4][2]

	for iter_3_0 = -WarchessGlobalCfg[arg_3_1].params[3], WarchessGlobalCfg[arg_3_1].params[3] do
		for iter_3_1 = math.max(-WarchessGlobalCfg[arg_3_1].params[3], iter_3_0 - WarchessGlobalCfg[arg_3_1].params[3]), math.min(WarchessGlobalCfg[arg_3_1].params[3], iter_3_0 + WarchessGlobalCfg[arg_3_1].params[3]) do
			local var_3_0 = ChessLuaBridge.GetGridData(iter_3_0 + WarchessGlobalCfg[arg_3_1].params[1], iter_3_1 + WarchessGlobalCfg[arg_3_1].params[2])

			if var_0_1(var_3_0) then
				if var_3_0.status == self.defaultState_ then
					self.areaMemory_[ChessTools.TwoDToOneD(iter_3_0 + WarchessGlobalCfg[arg_3_1].params[1], iter_3_1 + WarchessGlobalCfg[arg_3_1].params[2])] = 1
					self.areaCount_ = self.areaCount_ + 1
				else
					self.areaMemory_[ChessTools.TwoDToOneD(iter_3_0 + WarchessGlobalCfg[arg_3_1].params[1], iter_3_1 + WarchessGlobalCfg[arg_3_1].params[2])] = 0
				end
			end
		end
	end

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[self.curEventID_].type, self.curEventID_, self.areaCount_)
end

function ChessGlobalSealModel:IsConditionCheck()
	if self.areaCount_ == 0 then
		return true
	end

	return false
end

function ChessGlobalSealModel:ExecutePhase(arg_5_1)
	self.areaMemory_ = {}

	manager.ChessManager:StopMove()
end

function ChessGlobalSealModel:UpdateProgress(arg_6_1, arg_6_2)
	if arg_6_2 == ChessConst.TIMING_WALK then
		local var_6_0 = manager.ChessManager:GetExecutingChess()
		local var_6_1 = ChessTools.TwoDToOneD(var_6_0.x, var_6_0.z)

		if self.areaMemory_[var_6_1] and var_6_0.status == 0 then
			self.isRight_ = true
			self.areaMemory_[var_6_1] = 0
			self.areaCount_ = self.areaCount_ - 1
		else
			self.isRight_ = false
		end
	end
end

function ChessGlobalSealModel:ExternExecutePhase(arg_7_1, arg_7_2)
	if arg_7_2 == ChessConst.TIMING_WALK then
		if self.isRight_ then
			local var_7_0 = manager.ChessManager:GetExecutingChess()
			local var_7_1 = {
				{
					10309,
					var_7_0.x,
					var_7_0.z,
					{
						self.sealState_
					}
				}
			}

			if self.areaCount_ == 0 then
				for iter_7_0, iter_7_1 in pairs(self.areaMemory_) do
					local var_7_2, var_7_3 = ChessTools.OneDToTwoD(iter_7_0)

					table.insert(var_7_1, {
						10309,
						var_7_2,
						var_7_3,
						{
							self.successState_
						}
					})
				end
			end

			return ChessTools.ParseEventPollCfg(var_7_1)
		else
			local var_7_4 = {}

			for iter_7_2, iter_7_3 in pairs(self.areaMemory_) do
				if iter_7_3 == 0 then
					local var_7_5, var_7_6 = ChessTools.OneDToTwoD(iter_7_2)

					table.insert(var_7_4, {
						10309,
						var_7_5,
						var_7_6,
						{
							self.defaultState_
						}
					})
				end
			end

			for iter_7_4, iter_7_5 in pairs(WarchessGlobalCfg[self.curEventID_].event_list2) do
				table.insert(var_7_4, iter_7_5)
			end

			table.insert(var_7_4, {
				15002,
				9
			})

			return ChessTools.ParseEventPollCfg(var_7_4)
		end
	end
end

function ChessGlobalSealModel:Dispose()
	self.areaMemory_ = {}
	self.isRight_ = false
	self.areaCount_ = 0
	self.defaultState_ = 0
	self.sealState_ = 0
	self.successState_ = 0
end

return ChessGlobalSealModel
