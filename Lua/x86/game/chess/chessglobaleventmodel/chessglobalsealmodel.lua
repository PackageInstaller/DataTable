local var_0_0 = class("ChessGlobalSealModel")

local function var_0_1(arg_1_0)
	if not arg_1_0 or arg_1_0.paramList.Length == 0 then
		return false
	end

	local var_1_0 = WarchessEventPoolCfg[arg_1_0.paramList[0]].event_group_second

	if var_1_0 == "" then
		return false
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1[1] == 15001 then
			return true
		end
	end

	return false
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.areaMemory_ = {}
	arg_2_0.isRight_ = false
	arg_2_0.areaCount_ = 0
	arg_2_0.defaultState_ = 0
	arg_2_0.sealState_ = 0
	arg_2_0.successState_ = 0
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	arg_3_0.curEventID_ = arg_3_1
	arg_3_0.areaMemory_ = {}

	local var_3_0 = WarchessGlobalCfg[arg_3_1].params
	local var_3_1 = var_3_0[1]
	local var_3_2 = var_3_0[2]
	local var_3_3 = var_3_0[3]

	arg_3_0.areaCount_ = 0
	arg_3_0.sealState_ = var_3_0[4][1]
	arg_3_0.successState_ = var_3_0[4][2]

	for iter_3_0 = -var_3_3, var_3_3 do
		for iter_3_1 = math.max(-var_3_3, iter_3_0 - var_3_3), math.min(var_3_3, iter_3_0 + var_3_3) do
			local var_3_4 = ChessLuaBridge.GetGridData(iter_3_0 + var_3_1, iter_3_1 + var_3_2)

			if var_0_1(var_3_4) then
				if var_3_4.status == arg_3_0.defaultState_ then
					arg_3_0.areaMemory_[ChessTools.TwoDToOneD(iter_3_0 + var_3_1, iter_3_1 + var_3_2)] = 1
					arg_3_0.areaCount_ = arg_3_0.areaCount_ + 1
				else
					arg_3_0.areaMemory_[ChessTools.TwoDToOneD(iter_3_0 + var_3_1, iter_3_1 + var_3_2)] = 0
				end
			end
		end
	end

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[arg_3_0.curEventID_].type, arg_3_0.curEventID_, arg_3_0.areaCount_)
end

function var_0_0.IsConditionCheck(arg_4_0)
	if arg_4_0.areaCount_ == 0 then
		return true
	end

	return false
end

function var_0_0.ExecutePhase(arg_5_0, arg_5_1)
	arg_5_0.areaMemory_ = {}

	manager.ChessManager:StopMove()
end

function var_0_0.UpdateProgress(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == ChessConst.TIMING_WALK then
		local var_6_0 = manager.ChessManager:GetExecutingChess()
		local var_6_1 = ChessTools.TwoDToOneD(var_6_0.x, var_6_0.z)

		if arg_6_0.areaMemory_[var_6_1] and var_6_0.status == 0 then
			arg_6_0.isRight_ = true
			arg_6_0.areaMemory_[var_6_1] = 0
			arg_6_0.areaCount_ = arg_6_0.areaCount_ - 1
		else
			arg_6_0.isRight_ = false
		end
	end
end

function var_0_0.ExternExecutePhase(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == ChessConst.TIMING_WALK then
		if arg_7_0.isRight_ then
			local var_7_0 = manager.ChessManager:GetExecutingChess()
			local var_7_1 = {
				{
					10309,
					var_7_0.x,
					var_7_0.z,
					{
						arg_7_0.sealState_
					}
				}
			}

			if arg_7_0.areaCount_ == 0 then
				for iter_7_0, iter_7_1 in pairs(arg_7_0.areaMemory_) do
					local var_7_2, var_7_3 = ChessTools.OneDToTwoD(iter_7_0)

					table.insert(var_7_1, {
						10309,
						var_7_2,
						var_7_3,
						{
							arg_7_0.successState_
						}
					})
				end
			end

			return ChessTools.ParseEventPollCfg(var_7_1)
		else
			local var_7_4 = {}

			for iter_7_2, iter_7_3 in pairs(arg_7_0.areaMemory_) do
				if iter_7_3 == 0 then
					local var_7_5, var_7_6 = ChessTools.OneDToTwoD(iter_7_2)

					table.insert(var_7_4, {
						10309,
						var_7_5,
						var_7_6,
						{
							arg_7_0.defaultState_
						}
					})
				end
			end

			for iter_7_4, iter_7_5 in pairs(WarchessGlobalCfg[arg_7_0.curEventID_].event_list2) do
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

function var_0_0.Dispose(arg_8_0)
	arg_8_0.areaMemory_ = {}
	arg_8_0.isRight_ = false
	arg_8_0.areaCount_ = 0
	arg_8_0.defaultState_ = 0
	arg_8_0.sealState_ = 0
	arg_8_0.successState_ = 0
end

return var_0_0
