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

function NewWarChessGlobalEventEntity_Type_1:Ctor(arg_6_1, arg_6_2)
	self.super:Ctor(arg_6_1)

	self.xzList_ = deepClone(NewWarChessGlobalCfg[arg_6_1].params[1])
	self.initExtendObjectID_ = NewWarChessGlobalCfg[arg_6_1].params[2]
	self.successAni_ = NewWarChessGlobalCfg[arg_6_1].params[3]
	self.faildAni_ = NewWarChessGlobalCfg[arg_6_1].params[4]
	self.eventStatus_ = 0

	if not arg_6_2 then
		for iter_6_0, iter_6_1 in pairs(self.xzList_) do
			manager.NewChessManager:ChangeObjectByExtentID(iter_6_1[1], iter_6_1[2], self.initExtendObjectID_)
		end

		if NewWarChessGlobalCfg[arg_6_1].start_event ~= 0 then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
				self.globalEventID_
			})))
			manager.NewChessManager:StartExecuteEvent()
		end
	end
end

function NewWarChessGlobalEventEntity_Type_1.SetServerData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.eventStatus_ = arg_7_1
	arg_7_0.severxzList_ = arg_7_2
end

function NewWarChessGlobalEventEntity_Type_1:Check(arg_8_1)
	if self.eventStatus_ ~= 0 then
		self:OnSettlement(arg_8_1)
	end
end

function NewWarChessGlobalEventEntity_Type_1:OnSettlement(arg_9_1)
	if self.active_ == false then
		return
	end

	self.active_ = false

	manager.NewChessManager:ClearInteractChess()
	NewChessLuaBridge.StopRoleMoving()

	local var_9_0 = #self.severxzList_

	if #self.severxzList_ > 0 then
		for iter_9_0, iter_9_1 in pairs(self.severxzList_) do
			if self.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
				manager.NewChessManager:PlayGridAnimation(iter_9_1[1], iter_9_1[2], self.successAni_, 2, function()
					var_9_0 = var_9_0 - 1

					if var_9_0 <= 0 then
						for iter_10_0, iter_10_1 in pairs(self.xzList_) do
							manager.NewChessManager:DeleteObject(iter_10_1[1], iter_10_1[2])
						end

						if NewWarChessGlobalCfg[self.globalEventID_].success_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								self.globalEventID_
							})))
							manager.NewChessManager:StartExecuteEvent()
						end

						if arg_9_1 then
							arg_9_1()
						end
					end
				end)
			elseif self.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.FAILD then
				manager.NewChessManager:PlayGridAnimation(iter_9_1[1], iter_9_1[2], self.faildAni_, 2, function()
					var_9_0 = var_9_0 - 1

					if var_9_0 <= 0 then
						for iter_11_0, iter_11_1 in pairs(self.xzList_) do
							manager.NewChessManager:DeleteObject(iter_11_1[1], iter_11_1[2])
						end

						if NewWarChessGlobalCfg[self.globalEventID_].fail_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								self.globalEventID_
							})))
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
		for iter_9_2, iter_9_3 in pairs(self.xzList_) do
			manager.NewChessManager:DeleteObject(iter_9_3[1], iter_9_3[2])
		end

		if self.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
			if NewWarChessGlobalCfg[self.globalEventID_].success_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					self.globalEventID_
				})))
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_9_1 then
				arg_9_1()
			end
		else
			if NewWarChessGlobalCfg[self.globalEventID_].fail_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					self.globalEventID_
				})))
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_9_1 then
				arg_9_1()
			end
		end
	end
end

function NewWarChessGlobalEventEntity_Type_1:Dispose()
	self.xzList_ = nil
	self.initExtendObjectID_ = nil
	self.successAni_ = nil
	self.faildAni_ = nil
	self.severxzList_ = nil
	self.eventStatus_ = nil

	self.super:Dispose()
end

NewWarChessGlobalEventEntity_Type_2 = class("NewWarChessGlobalEventEntity_Type_2", NewWarChessGlobalEventEntity)

function NewWarChessGlobalEventEntity_Type_2:Ctor(arg_13_1, arg_13_2)
	self.super:Ctor(arg_13_1)

	self.hexInfoList_ = deepClone(NewWarChessGlobalCfg[arg_13_1].params[1])
	self.successAni_ = NewWarChessGlobalCfg[arg_13_1].params[2]
	self.faildAni_ = NewWarChessGlobalCfg[arg_13_1].params[3]
	self.eventStatus_ = 0

	if not arg_13_2 then
		for iter_13_0, iter_13_1 in pairs(self.hexInfoList_) do
			for iter_13_2, iter_13_3 in pairs(iter_13_1) do
				if iter_13_2 > 1 then
					manager.NewChessManager:ChangeObjectByExtentID(iter_13_3[1], iter_13_3[2], iter_13_1[1])
				end
			end
		end

		if NewWarChessGlobalCfg[arg_13_1].start_event ~= 0 then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
				self.globalEventID_
			})))
			manager.NewChessManager:StartExecuteEvent()
		end
	end
end

function NewWarChessGlobalEventEntity_Type_2.SetServerData(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.eventStatus_ = arg_14_1
	arg_14_0.severxzList_ = arg_14_2
end

function NewWarChessGlobalEventEntity_Type_2:Check(arg_15_1)
	if self.eventStatus_ ~= 0 then
		self:OnSettlement(arg_15_1)
	end
end

function NewWarChessGlobalEventEntity_Type_2:OnSettlement(arg_16_1)
	if self.active_ == false then
		return
	end

	self.active_ = false

	manager.NewChessManager:ClearInteractChess()
	NewChessLuaBridge.StopRoleMoving()

	local var_16_0 = #self.severxzList_

	if #self.severxzList_ > 0 then
		for iter_16_0, iter_16_1 in pairs(self.severxzList_) do
			if self.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
				manager.NewChessManager:PlayGridAnimation(iter_16_1[1], iter_16_1[2], self.successAni_, 2, function()
					var_16_0 = var_16_0 - 1

					if var_16_0 <= 0 then
						for iter_17_0, iter_17_1 in pairs(self.hexInfoList_) do
							for iter_17_2, iter_17_3 in pairs(iter_17_1) do
								if iter_17_2 > 1 then
									manager.NewChessManager:DeleteObject(iter_17_3[1], iter_17_3[2])
								end
							end
						end

						if NewWarChessGlobalCfg[self.globalEventID_].success_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								self.globalEventID_
							})))
							manager.NewChessManager:StartExecuteEvent()
						end

						if arg_16_1 then
							arg_16_1()
						end
					end
				end)
			elseif self.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.FAILD then
				manager.NewChessManager:PlayGridAnimation(iter_16_1[1], iter_16_1[2], self.faildAni_, 2, function()
					var_16_0 = var_16_0 - 1

					if var_16_0 <= 0 then
						for iter_18_0, iter_18_1 in pairs(self.hexInfoList_) do
							for iter_18_2, iter_18_3 in pairs(iter_18_1) do
								if iter_18_2 > 1 then
									manager.NewChessManager:DeleteObject(iter_18_3[1], iter_18_3[2])
								end
							end
						end

						if NewWarChessGlobalCfg[self.globalEventID_].fail_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								self.globalEventID_
							})))
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
		for iter_16_2, iter_16_3 in pairs(self.hexInfoList_) do
			for iter_16_4, iter_16_5 in pairs(iter_16_3) do
				if iter_16_4 > 1 then
					manager.NewChessManager:DeleteObject(iter_16_5[1], iter_16_5[2])
				end
			end
		end

		if self.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
			if NewWarChessGlobalCfg[self.globalEventID_].success_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					self.globalEventID_
				})))
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_16_1 then
				arg_16_1()
			end
		else
			if NewWarChessGlobalCfg[self.globalEventID_].fail_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					self.globalEventID_
				})))
				manager.NewChessManager:StartExecuteEvent()
			end

			if arg_16_1 then
				arg_16_1()
			end
		end
	end
end

function NewWarChessGlobalEventEntity_Type_2:Dispose()
	self.hexInfoList_ = nil
	self.successAni_ = nil
	self.faildAni_ = nil
	self.severxzList_ = nil
	self.eventStatus_ = nil

	self.super:Dispose()
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

function var_0_0:SetServerData(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		self.ActiveGlobalEventList_[iter_21_1] = var_0_1[NewWarChessGlobalCfg[iter_21_1].type].New(iter_21_1, true)
	end
end

function var_0_0:InsertNextInitGlobalEvent(arg_22_1)
	table.insert(self.NextInitGlobalEventList_, arg_22_1)
end

function var_0_0:InitGlobalEvent(arg_23_1)
	if NewWarChessGlobalCfg[arg_23_1] == nil then
		error("NewWarChessGlobalCfg 中不存在", arg_23_1)

		return
	end

	self.ActiveGlobalEventList_[arg_23_1] = var_0_1[NewWarChessGlobalCfg[arg_23_1].type].New(arg_23_1, false)
end

function var_0_0:UpdateGlobalEventServerData(arg_24_1, arg_24_2, arg_24_3)
	for iter_24_0, iter_24_1 in pairs(self.ActiveGlobalEventList_) do
		if iter_24_1.globalEventID_ == arg_24_1 then
			iter_24_1:SetServerData(arg_24_2, arg_24_3)

			return
		end
	end
end

function var_0_0:CheckStartGlobalEventList()
	for iter_25_0, iter_25_1 in pairs(self.NextInitGlobalEventList_) do
		self.NextInitGlobalEventList_[iter_25_0] = nil

		self:InitGlobalEvent(self.NextInitGlobalEventList_[iter_25_0])
	end

	self.NextInitGlobalEventList_ = {}
end

function var_0_0:CheckSettlementGlobalEventList()
	for iter_26_0, iter_26_1 in pairs(self.ActiveGlobalEventList_) do
		iter_26_1:Check(function()
			self.ActiveGlobalEventList_[iter_26_1.globalEventID_] = nil

			iter_26_1:Dispose()
		end)
	end
end

function var_0_0:Dispose()
	for iter_28_0, iter_28_1 in pairs(self.ActiveGlobalEventList_) do
		iter_28_1:Dispose()
	end

	self.ActiveGlobalEventList_ = {}
	self.NextInitGlobalEventList_ = {}
end

return var_0_0
