local var_0_0 = class("ChessGlobalEventManager")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.globalEventList_ = {}
	arg_1_0.eventGlobalQueue_ = {}
	arg_1_0.eventGlobalP_ = 1
	arg_1_0.globalEventModels = {}
	arg_1_0.globalEventModels[ChessConst.GLOBAL.AREA] = ChessGlobalAreaModel.New(arg_1_0)
	arg_1_0.globalEventModels[ChessConst.GLOBAL.COUNT_STEP] = ChessGlobalCountDownModel.New(arg_1_0)
	arg_1_0.globalEventModels[ChessConst.GLOBAL.ORDER_EVENT] = ChessGlobalOrderEventModel.New(arg_1_0)
	arg_1_0.globalEventModels[ChessConst.GLOBAL.SEAL] = ChessGlobalSealModel.New(arg_1_0)
	arg_1_0.globalEventModels[ChessConst.GLOBAL.CHECK] = ChessGlobalCheckModel.New(arg_1_0)
	arg_1_0.handler_ = arg_1_1

	arg_1_0:CreateGlobalEventList()
end

function var_0_0.CreateGlobalEventList(arg_2_0)
	arg_2_0.globalEventList_ = {}

	local var_2_0 = WarChessData:GetGlobalEventList()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			if arg_2_0.globalEventList_[iter_2_2] then
				return
			end

			arg_2_0.globalEventList_[iter_2_2] = {}

			table.insert(arg_2_0.globalEventList_[iter_2_2], {
				params = WarchessGlobalCfg[iter_2_2].params,
				eventList = ChessTools.ParseEventPollCfg(WarchessGlobalCfg[iter_2_2].event_list)
			})

			if arg_2_0.globalEventModels[iter_2_0] then
				arg_2_0.globalEventModels[iter_2_0]:SetUp(iter_2_2)
			end
		end
	end
end

function var_0_0.InsertGlobalEventList(arg_3_0, arg_3_1)
	local var_3_0 = WarchessGlobalCfg[arg_3_1].type

	if arg_3_0.globalEventList_[arg_3_1] then
		return
	end

	arg_3_0.globalEventList_[arg_3_1] = {}

	table.insert(arg_3_0.globalEventList_[arg_3_1], {
		params = WarchessGlobalCfg[arg_3_1].params,
		eventList = ChessTools.ParseEventPollCfg(WarchessGlobalCfg[arg_3_1].event_list)
	})

	if arg_3_0.globalEventModels[var_3_0] then
		arg_3_0.globalEventModels[var_3_0]:SetUp(arg_3_1)
	end
end

function var_0_0.ClearGlobalEventByType(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.globalEventList_) do
		if WarchessGlobalCfg[iter_4_0].type == arg_4_1 then
			arg_4_0.globalEventList_[iter_4_0] = nil

			WarChessData:ClearGlobalEvent(arg_4_1, iter_4_0)
		end
	end
end

function var_0_0.ClearGlobalEventByID(arg_5_0, arg_5_1)
	arg_5_0.globalEventList_[arg_5_1] = nil

	local var_5_0 = WarchessGlobalCfg[arg_5_1].type

	WarChessData:ClearGlobalEvent(var_5_0, arg_5_1)
end

function var_0_0.ExecuteGlobalEvent(arg_6_0, arg_6_1)
	arg_6_0:UpdateEventProgress(arg_6_1)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.globalEventList_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			local var_6_0 = WarchessGlobalCfg[iter_6_0].type

			if arg_6_0:IsConditionCheck(iter_6_0, iter_6_3.params, arg_6_1) then
				if arg_6_0.globalEventModels[var_6_0] and arg_6_0.globalEventModels[var_6_0].ExternExecutePhase then
					local var_6_1 = arg_6_0.globalEventModels[var_6_0]:ExternExecutePhase(iter_6_0, arg_6_1)

					if var_6_1 then
						arg_6_0:CreateGlobalEventQueue(var_6_1, "GLOBAL")
					end
				end

				arg_6_0:CreateGlobalEventQueue(iter_6_3.eventList, "GLOBAL")

				if arg_6_0.globalEventModels[var_6_0] then
					arg_6_0.globalEventModels[var_6_0]:ExecutePhase(iter_6_0)
				end

				arg_6_0.globalEventList_[iter_6_0] = nil

				WarChessData:ClearGlobalEvent(var_6_0, iter_6_0)

				return
			end

			if arg_6_0.globalEventModels[var_6_0] and arg_6_0.globalEventModels[var_6_0].ExternExecutePhase then
				local var_6_2 = arg_6_0.globalEventModels[var_6_0]:ExternExecutePhase(iter_6_0, arg_6_1)

				if var_6_2 then
					arg_6_0:CreateGlobalEventQueue(var_6_2, "GLOBAL")

					return
				end
			end
		end
	end
end

function var_0_0.IsConditionCheck(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = WarchessGlobalCfg[arg_7_1].type

	if var_7_0 == ChessConst.GLOBAL.START then
		return true
	elseif arg_7_0.globalEventModels[var_7_0] then
		return arg_7_0.globalEventModels[var_7_0]:IsConditionCheck(arg_7_1, arg_7_3)
	else
		local var_7_1 = WarChessData:GetGlobalEventList()[var_7_0][arg_7_1]
		local var_7_2

		if var_7_0 == ChessConst.GLOBAL.PROGRESS or var_7_0 == ChessConst.GLOBAL.TALLY then
			var_7_2 = arg_7_2[1]
		else
			var_7_2 = arg_7_2[2]
		end

		if type(var_7_2) ~= "number" then
			-- block empty
		end

		return var_7_2 <= var_7_1
	end
end

function var_0_0.UpdateEventProgress(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.globalEventList_) do
		local var_8_0 = WarchessGlobalCfg[iter_8_0].type
		local var_8_1
		local var_8_2 = WarchessGlobalCfg[iter_8_0].params

		if var_8_0 == ChessConst.GLOBAL.PROGRESS then
			local var_8_3 = ChessTools.GetProgress(WarChessData:GetCurrentChapter())

			WarChessData:SetGlobalEventProgress(var_8_0, iter_8_0, var_8_3)
		elseif var_8_0 == ChessConst.GLOBAL.EVENT then
			local var_8_4 = var_8_2[1]
			local var_8_5 = WarChessData:GetEventExecuteTime(var_8_4) or 0

			WarChessData:SetGlobalEventProgress(var_8_0, iter_8_0, var_8_5)
		elseif arg_8_0.globalEventModels[var_8_0] then
			arg_8_0.globalEventModels[var_8_0]:UpdateProgress(iter_8_0, arg_8_1)
		end
	end
end

function var_0_0.CreateGlobalEventQueue(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.handler_:InsertEventQueue(arg_9_1, arg_9_2)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.globalEventList_ = {}
	arg_10_0.eventGlobalQueue_ = {}
	arg_10_0.eventGlobalP_ = 1

	for iter_10_0, iter_10_1 in pairs(arg_10_0.globalEventModels) do
		iter_10_1:Dispose()
	end
end

return var_0_0
