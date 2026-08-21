NewWarChessGlobalEventEntity = class("NewWarChessGlobalEventEntity")

function NewWarChessGlobalEventEntity.Ctor(arg_1_0, arg_1_1)
	arg_1_0.globalEventID_ = arg_1_1
	arg_1_0.active_ = true
end

function NewWarChessGlobalEventEntity.SetServerData(arg_2_0, arg_2_1, arg_2_2)
	return
end

function NewWarChessGlobalEventEntity.Check(arg_3_0, arg_3_1)
	return
end

function NewWarChessGlobalEventEntity.OnSettlement(arg_4_0, arg_4_1)
	return
end

function NewWarChessGlobalEventEntity.Dispose(arg_5_0)
	arg_5_0.globalEventID_ = nil
end

NewWarChessGlobalEventEntity_Type_1 = class("NewWarChessGlobalEventEntity_Type_1", NewWarChessGlobalEventEntity)

function NewWarChessGlobalEventEntity_Type_1.Ctor(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.super:Ctor(arg_6_1)

	local var_6_0 = NewWarChessGlobalCfg[arg_6_1]

	arg_6_0.xzList_ = deepClone(var_6_0.params[1])
	arg_6_0.initExtendObjectID_ = var_6_0.params[2]
	arg_6_0.successAni_ = var_6_0.params[3]
	arg_6_0.faildAni_ = var_6_0.params[4]
	arg_6_0.eventStatus_ = 0

	if not arg_6_2 then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.xzList_) do
			local var_6_1 = iter_6_1[1]
			local var_6_2 = iter_6_1[2]

			manager.NewChessManager:ChangeObjectByExtentID(var_6_1, var_6_2, arg_6_0.initExtendObjectID_)
		end

		if var_6_0.start_event ~= 0 then
			local var_6_3 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
				arg_6_0.globalEventID_
			})

			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_6_3)
			manager.NewChessManager:StartExecuteEvent()
		end
	end
end

function NewWarChessGlobalEventEntity_Type_1.SetServerData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.eventStatus_ = arg_7_1
	arg_7_0.severxzList_ = arg_7_2
end

function NewWarChessGlobalEventEntity_Type_1.Check(arg_8_0, arg_8_1)
	if arg_8_0.eventStatus_ ~= 0 then
		arg_8_0:OnSettlement(arg_8_1)
	end
end

function NewWarChessGlobalEventEntity_Type_1.OnSettlement(arg_9_0, arg_9_1)
	if arg_9_0.active_ == false then
		return
	end

	arg_9_0.active_ = false

	manager.NewChessManager:ClearInteractChess()
	NewChessLuaBridge.StopRoleMoving()

	local var_9_0 = #arg_9_0.severxzList_

	if var_9_0 > 0 then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.severxzList_) do
			local var_9_1 = iter_9_1[1]
			local var_9_2 = iter_9_1[2]
			local var_9_3

			if arg_9_0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
				local var_9_4 = arg_9_0.successAni_

				manager.NewChessManager:PlayGridAnimation(var_9_1, var_9_2, var_9_4, 2, function()
					var_9_0 = var_9_0 - 1

					if var_9_0 <= 0 then
						for iter_10_0, iter_10_1 in pairs(arg_9_0.xzList_) do
							local var_10_0 = iter_10_1[1]
							local var_10_1 = iter_10_1[2]

							manager.NewChessManager:DeleteObject(var_10_0, var_10_1)
						end

						if NewWarChessGlobalCfg[arg_9_0.globalEventID_].success_event ~= 0 then
							local var_10_2 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								arg_9_0.globalEventID_
							})

							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_10_2)
							manager.NewChessManager:StartExecuteEvent()
						end

						if arg_9_1 then
							arg_9_1()
						end
					end
				end)
			elseif arg_9_0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.FAILD then
				local var_9_5 = arg_9_0.faildAni_

				manager.NewChessManager:PlayGridAnimation(var_9_1, var_9_2, var_9_5, 2, function()
					var_9_0 = var_9_0 - 1

					if var_9_0 <= 0 then
						for iter_11_0, iter_11_1 in pairs(arg_9_0.xzList_) do
							local var_11_0 = iter_11_1[1]
							local var_11_1 = iter_11_1[2]

							manager.NewChessManager:DeleteObject(var_11_0, var_11_1)
						end

						if NewWarChessGlobalCfg[arg_9_0.globalEventID_].fail_event ~= 0 then
							local var_11_2 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								arg_9_0.globalEventID_
							})

							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_11_2)
							manager.NewChessManager:StartExecuteEvent()
						end

						if arg_9_1 then
							arg_9_1()
						end
					end
				end)
			end
		end
	else
		for iter_9_2, iter_9_3 in pairs(arg_9_0.xzList_) do
			local var_9_6 = iter_9_3[1]
			local var_9_7 = iter_9_3[2]

			manager.NewChessManager:DeleteObject(var_9_6, var_9_7)
		end

		if arg_9_0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
			if NewWarChessGlobalCfg[arg_9_0.globalEventID_].success_event ~= 0 then
				local var_9_8 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					arg_9_0.globalEventID_
				})

				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_9_8)
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_9_1 then
				arg_9_1()
			end
		else
			if NewWarChessGlobalCfg[arg_9_0.globalEventID_].fail_event ~= 0 then
				local var_9_9 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					arg_9_0.globalEventID_
				})

				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_9_9)
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_9_1 then
				arg_9_1()
			end
		end
	end
end

function NewWarChessGlobalEventEntity_Type_1.Dispose(arg_12_0)
	arg_12_0.xzList_ = nil
	arg_12_0.initExtendObjectID_ = nil
	arg_12_0.successAni_ = nil
	arg_12_0.faildAni_ = nil
	arg_12_0.severxzList_ = nil
	arg_12_0.eventStatus_ = nil

	arg_12_0.super:Dispose()
end

NewWarChessGlobalEventEntity_Type_2 = class("NewWarChessGlobalEventEntity_Type_2", NewWarChessGlobalEventEntity)

function NewWarChessGlobalEventEntity_Type_2.Ctor(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.super:Ctor(arg_13_1)

	local var_13_0 = NewWarChessGlobalCfg[arg_13_1]

	arg_13_0.hexInfoList_ = deepClone(var_13_0.params[1])
	arg_13_0.successAni_ = var_13_0.params[2]
	arg_13_0.faildAni_ = var_13_0.params[3]
	arg_13_0.eventStatus_ = 0

	if not arg_13_2 then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.hexInfoList_) do
			local var_13_1 = iter_13_1[1]

			for iter_13_2, iter_13_3 in pairs(iter_13_1) do
				if iter_13_2 > 1 then
					local var_13_2 = iter_13_3[1]
					local var_13_3 = iter_13_3[2]

					manager.NewChessManager:ChangeObjectByExtentID(var_13_2, var_13_3, var_13_1)
				end
			end
		end

		if var_13_0.start_event ~= 0 then
			local var_13_4 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
				arg_13_0.globalEventID_
			})

			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_13_4)
			manager.NewChessManager:StartExecuteEvent()
		end
	end
end

function NewWarChessGlobalEventEntity_Type_2.SetServerData(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.eventStatus_ = arg_14_1
	arg_14_0.severxzList_ = arg_14_2
end

function NewWarChessGlobalEventEntity_Type_2.Check(arg_15_0, arg_15_1)
	if arg_15_0.eventStatus_ ~= 0 then
		arg_15_0:OnSettlement(arg_15_1)
	end
end

function NewWarChessGlobalEventEntity_Type_2.OnSettlement(arg_16_0, arg_16_1)
	if arg_16_0.active_ == false then
		return
	end

	arg_16_0.active_ = false

	manager.NewChessManager:ClearInteractChess()
	NewChessLuaBridge.StopRoleMoving()

	local var_16_0 = #arg_16_0.severxzList_

	if var_16_0 > 0 then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.severxzList_) do
			local var_16_1 = iter_16_1[1]
			local var_16_2 = iter_16_1[2]
			local var_16_3

			if arg_16_0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
				local var_16_4 = arg_16_0.successAni_

				manager.NewChessManager:PlayGridAnimation(var_16_1, var_16_2, var_16_4, 2, function()
					var_16_0 = var_16_0 - 1

					if var_16_0 <= 0 then
						for iter_17_0, iter_17_1 in pairs(arg_16_0.hexInfoList_) do
							for iter_17_2, iter_17_3 in pairs(iter_17_1) do
								if iter_17_2 > 1 then
									local var_17_0 = iter_17_3[1]
									local var_17_1 = iter_17_3[2]

									manager.NewChessManager:DeleteObject(var_17_0, var_17_1)
								end
							end
						end

						if NewWarChessGlobalCfg[arg_16_0.globalEventID_].success_event ~= 0 then
							local var_17_2 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								arg_16_0.globalEventID_
							})

							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_17_2)
							manager.NewChessManager:StartExecuteEvent()
						end

						if arg_16_1 then
							arg_16_1()
						end
					end
				end)
			elseif arg_16_0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.FAILD then
				local var_16_5 = arg_16_0.faildAni_

				manager.NewChessManager:PlayGridAnimation(var_16_1, var_16_2, var_16_5, 2, function()
					var_16_0 = var_16_0 - 1

					if var_16_0 <= 0 then
						for iter_18_0, iter_18_1 in pairs(arg_16_0.hexInfoList_) do
							for iter_18_2, iter_18_3 in pairs(iter_18_1) do
								if iter_18_2 > 1 then
									local var_18_0 = iter_18_3[1]
									local var_18_1 = iter_18_3[2]

									manager.NewChessManager:DeleteObject(var_18_0, var_18_1)
								end
							end
						end

						if NewWarChessGlobalCfg[arg_16_0.globalEventID_].fail_event ~= 0 then
							local var_18_2 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								arg_16_0.globalEventID_
							})

							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_18_2)
							manager.NewChessManager:StartExecuteEvent()
						end

						if arg_16_1 then
							arg_16_1()
						end
					end
				end)
			end
		end
	else
		for iter_16_2, iter_16_3 in pairs(arg_16_0.hexInfoList_) do
			for iter_16_4, iter_16_5 in pairs(iter_16_3) do
				if iter_16_4 > 1 then
					local var_16_6 = iter_16_5[1]
					local var_16_7 = iter_16_5[2]

					manager.NewChessManager:DeleteObject(var_16_6, var_16_7)
				end
			end
		end

		if arg_16_0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
			if NewWarChessGlobalCfg[arg_16_0.globalEventID_].success_event ~= 0 then
				local var_16_8 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					arg_16_0.globalEventID_
				})

				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_16_8)
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_16_1 then
				arg_16_1()
			end
		else
			if NewWarChessGlobalCfg[arg_16_0.globalEventID_].fail_event ~= 0 then
				local var_16_9 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					arg_16_0.globalEventID_
				})

				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, var_16_9)
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_16_1 then
				arg_16_1()
			end
		end
	end
end

function NewWarChessGlobalEventEntity_Type_2.Dispose(arg_19_0)
	arg_19_0.hexInfoList_ = nil
	arg_19_0.successAni_ = nil
	arg_19_0.faildAni_ = nil
	arg_19_0.severxzList_ = nil
	arg_19_0.eventStatus_ = nil

	arg_19_0.super:Dispose()
end

local var_0_0 = singletonClass("NewWarChessGlobalManager")
local var_0_1 = {
	NewWarChessGlobalEventEntity_Type_1,
	NewWarChessGlobalEventEntity_Type_2
}

function var_0_0.Ctor(arg_20_0)
	arg_20_0.ActiveGlobalEventList_ = {}
	arg_20_0.NextInitGlobalEventList_ = {}
end

function var_0_0.SetServerData(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		local var_21_0 = NewWarChessGlobalCfg[iter_21_1]
		local var_21_1 = var_0_1[var_21_0.type].New(iter_21_1, true)

		arg_21_0.ActiveGlobalEventList_[iter_21_1] = var_21_1
	end
end

function var_0_0.InsertNextInitGlobalEvent(arg_22_0, arg_22_1)
	table.insert(arg_22_0.NextInitGlobalEventList_, arg_22_1)
end

function var_0_0.InitGlobalEvent(arg_23_0, arg_23_1)
	local var_23_0 = NewWarChessGlobalCfg[arg_23_1]

	if var_23_0 == nil then
		error("NewWarChessGlobalCfg 中不存在", arg_23_1)

		return
	end

	local var_23_1 = var_0_1[var_23_0.type].New(arg_23_1, false)

	arg_23_0.ActiveGlobalEventList_[arg_23_1] = var_23_1
end

function var_0_0.UpdateGlobalEventServerData(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.ActiveGlobalEventList_) do
		if iter_24_1.globalEventID_ == arg_24_1 then
			iter_24_1:SetServerData(arg_24_2, arg_24_3)

			return
		end
	end
end

function var_0_0.CheckStartGlobalEventList(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.NextInitGlobalEventList_) do
		local var_25_0 = arg_25_0.NextInitGlobalEventList_[iter_25_0]

		arg_25_0.NextInitGlobalEventList_[iter_25_0] = nil

		arg_25_0:InitGlobalEvent(var_25_0)
	end

	arg_25_0.NextInitGlobalEventList_ = {}
end

function var_0_0.CheckSettlementGlobalEventList(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.ActiveGlobalEventList_) do
		iter_26_1:Check(function()
			arg_26_0.ActiveGlobalEventList_[iter_26_1.globalEventID_] = nil

			iter_26_1:Dispose()
		end)
	end
end

function var_0_0.Dispose(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.ActiveGlobalEventList_) do
		iter_28_1:Dispose()
	end

	arg_28_0.ActiveGlobalEventList_ = {}
	arg_28_0.NextInitGlobalEventList_ = {}
end

return var_0_0
