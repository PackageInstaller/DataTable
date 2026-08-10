local var_0_0 = class("ChessGlobalCheckModel")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.curEventIDList_ = {}
	arg_1_0.curConditionList_ = {}
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	if arg_2_0.curEventIDList_[arg_2_1] then
		return
	end

	arg_2_0.curEventIDList_[arg_2_1] = WarchessGlobalCfg[arg_2_1].params
	arg_2_0.curConditionList_[arg_2_1] = false
end

function var_0_0.IsConditionCheck(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.curConditionList_[arg_3_1] then
		arg_3_0.curConditionList_[arg_3_1] = nil

		return true
	end

	return false
end

function var_0_0.ExecutePhase(arg_4_0, arg_4_1)
	return
end

function var_0_0.UpdateProgress(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false
	local var_5_1 = manager.ChessManager:GetExecutingChess()

	if var_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.curEventIDList_[arg_5_1]) do
			if var_5_1.x == iter_5_1[1] and var_5_1.z == iter_5_1[2] then
				var_5_0 = true

				break
			end
		end

		if var_5_0 then
			for iter_5_2, iter_5_3 in pairs(arg_5_0.curEventIDList_[arg_5_1]) do
				if not WarChessData:GetGridIsChanged(iter_5_3[1], iter_5_3[2]) then
					return
				end
			end

			arg_5_0.curEventIDList_[arg_5_1] = nil
			arg_5_0.curConditionList_[arg_5_1] = true

			return
		end
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.curEventIDList_ = {}
	arg_6_0.curConditionList_ = {}
end

return var_0_0
