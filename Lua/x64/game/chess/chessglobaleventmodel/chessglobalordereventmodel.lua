local var_0_0 = class("ChessGlobalOrderEventModel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.curIndex_ = nil
	arg_1_0.curEventID_ = nil
	arg_1_0.curGridList_ = nil
	arg_1_0.changeGrid_ = nil
	arg_1_0.isRight_ = false
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	if arg_2_0.curEventID_ and arg_2_0.curEventID_ ~= arg_2_1 then
		arg_2_0.handler_:ClearGlobalEventByID(arg_2_0.curEventID_)
	end

	arg_2_0.curIndex_ = WarChessData:GetGlobalEventProgress(arg_2_1) or 0
	arg_2_0.curEventID_ = arg_2_1
	arg_2_0.curGridList_ = {}

	local var_2_0 = WarchessGlobalCfg[arg_2_0.curEventID_].sub_type

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[arg_2_0.curEventID_].type, arg_2_1, arg_2_0.curIndex_)

	if var_2_0 == 701 then
		local var_2_1 = WarchessGlobalCfg[arg_2_0.curEventID_].params

		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			table.insert(arg_2_0.curGridList_, {
				x = iter_2_1[1],
				z = iter_2_1[2]
			})
		end
	elseif var_2_0 == 702 then
		local var_2_2 = WarchessGlobalCfg[arg_2_0.curEventID_].params[1]

		for iter_2_2, iter_2_3 in pairs(var_2_2) do
			table.insert(arg_2_0.curGridList_, {
				x = iter_2_3[1],
				z = iter_2_3[2]
			})
		end

		arg_2_0.changeGrid_ = WarchessGlobalCfg[arg_2_0.curEventID_].params[2]

		if #arg_2_0.changeGrid_ ~= 2 then
			error("配置错误：数量不对" .. arg_2_0.curEventID_)
		end
	end
end

function var_0_0.IsConditionCheck(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.curEventID_ then
		return
	end

	if arg_3_2 == ChessConst.TIMING_INTERACT and arg_3_0.curIndex_ >= #arg_3_0.curGridList_ then
		return true
	end

	return false
end

function var_0_0.ExternExecutePhase(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 ~= ChessConst.TIMING_INTERACT then
		return
	end

	local var_4_0 = WarchessGlobalCfg[arg_4_0.curEventID_].sub_type
	local var_4_1 = manager.ChessManager:GetExecutingChess()
	local var_4_2 = false

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.curGridList_) do
		if iter_4_1.x == var_4_1.x and iter_4_1.z == var_4_1.z then
			var_4_2 = iter_4_0

			break
		end
	end

	if not var_4_2 then
		return false
	end

	local var_4_3 = var_4_1.paramList[0]

	if arg_4_0.isRight_ then
		if WarchessEventPoolCfg[var_4_3].event_group_second == "" then
			return nil
		end

		local var_4_4 = deepClone(WarchessEventPoolCfg[var_4_3].event_group_second)

		if var_4_0 == 702 then
			if arg_4_0.curIndex_ == 3 then
				local var_4_5 = {
					10602,
					{
						{
							10304,
							arg_4_0.curGridList_[1].x,
							arg_4_0.curGridList_[1].z,
							{
								2
							}
						},
						{
							10304,
							arg_4_0.curGridList_[2].x,
							arg_4_0.curGridList_[2].z,
							{
								2
							}
						},
						{
							10304,
							arg_4_0.curGridList_[3].x,
							arg_4_0.curGridList_[3].z,
							{
								2
							}
						},
						{
							10304,
							arg_4_0.changeGrid_[1],
							arg_4_0.changeGrid_[2],
							{
								1
							}
						}
					}
				}

				table.insert(var_4_4, var_4_5)
			elseif arg_4_0.curIndex_ == 6 then
				local var_4_6 = {
					10602,
					{
						{
							10304,
							arg_4_0.curGridList_[4].x,
							arg_4_0.curGridList_[4].z,
							{
								2
							}
						},
						{
							10304,
							arg_4_0.curGridList_[5].x,
							arg_4_0.curGridList_[5].z,
							{
								2
							}
						},
						{
							10304,
							arg_4_0.curGridList_[6].x,
							arg_4_0.curGridList_[6].z,
							{
								2
							}
						},
						{
							10304,
							arg_4_0.changeGrid_[1],
							arg_4_0.changeGrid_[2],
							{
								2
							}
						}
					}
				}

				table.insert(var_4_4, var_4_6)
			end
		end

		return ChessTools.ParseEventPollCfg(var_4_4)
	else
		if WarchessEventPoolCfg[var_4_3].event_group_third == "" then
			return nil
		end

		local var_4_7 = deepClone(WarchessEventPoolCfg[var_4_3].event_group_third)

		if var_4_0 == 702 then
			for iter_4_2, iter_4_3 in ipairs(WarchessGlobalCfg[arg_4_0.curEventID_].event_list2) do
				table.insert(var_4_7, iter_4_3)
			end
		end

		return ChessTools.ParseEventPollCfg(var_4_7)
	end
end

function var_0_0.ExecutePhase(arg_5_0, arg_5_1)
	arg_5_0.curIndex_ = nil
	arg_5_0.curEventID_ = nil
	arg_5_0.curGridList_ = nil
end

function var_0_0.UpdateProgress(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.curEventID_ then
		return
	end

	if arg_6_2 == ChessConst.TIMING_INTERACT then
		local var_6_0 = manager.ChessManager:GetExecutingChess()
		local var_6_1 = arg_6_0.curGridList_[arg_6_0.curIndex_ + 1]

		if var_6_1.x == var_6_0.x and var_6_1.z == var_6_0.z then
			arg_6_0.curIndex_ = arg_6_0.curIndex_ + 1
			arg_6_0.isRight_ = true

			local var_6_2 = WarchessGlobalCfg[arg_6_1].type

			WarChessData:SetGlobalEventProgress(var_6_2, arg_6_1, arg_6_0.curIndex_)
		else
			arg_6_0.isRight_ = false
		end
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.curIndex_ = nil
	arg_7_0.curEventID_ = nil
	arg_7_0.curGridList_ = nil
end

return var_0_0
