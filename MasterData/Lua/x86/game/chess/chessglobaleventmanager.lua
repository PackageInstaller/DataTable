local ChessGlobalEventManager = class("ChessGlobalEventManager")

function ChessGlobalEventManager:Ctor(arg_1_1)
	self.globalEventList_ = {}
	self.eventGlobalQueue_ = {}
	self.eventGlobalP_ = 1
	self.globalEventModels = {}
	self.globalEventModels[ChessConst.GLOBAL.AREA] = ChessGlobalAreaModel.New(self)
	self.globalEventModels[ChessConst.GLOBAL.COUNT_STEP] = ChessGlobalCountDownModel.New(self)
	self.globalEventModels[ChessConst.GLOBAL.ORDER_EVENT] = ChessGlobalOrderEventModel.New(self)
	self.globalEventModels[ChessConst.GLOBAL.SEAL] = ChessGlobalSealModel.New(self)
	self.globalEventModels[ChessConst.GLOBAL.CHECK] = ChessGlobalCheckModel.New(self)
	self.handler_ = arg_1_1

	self:CreateGlobalEventList()
end

function ChessGlobalEventManager:CreateGlobalEventList()
	self.globalEventList_ = {}

	for iter_2_0, iter_2_1 in pairs((WarChessData:GetGlobalEventList())) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			if self.globalEventList_[iter_2_2] then
				return
			end

			self.globalEventList_[iter_2_2] = {}

			table.insert(self.globalEventList_[iter_2_2], {
				params = WarchessGlobalCfg[iter_2_2].params,
				eventList = ChessTools.ParseEventPollCfg(WarchessGlobalCfg[iter_2_2].event_list)
			})

			if self.globalEventModels[iter_2_0] then
				self.globalEventModels[iter_2_0]:SetUp(iter_2_2)
			end
		end
	end
end

function ChessGlobalEventManager:InsertGlobalEventList(arg_3_1)
	if self.globalEventList_[arg_3_1] then
		return
	end

	self.globalEventList_[arg_3_1] = {}

	table.insert(self.globalEventList_[arg_3_1], {
		params = WarchessGlobalCfg[arg_3_1].params,
		eventList = ChessTools.ParseEventPollCfg(WarchessGlobalCfg[arg_3_1].event_list)
	})

	if self.globalEventModels[WarchessGlobalCfg[arg_3_1].type] then
		self.globalEventModels[WarchessGlobalCfg[arg_3_1].type]:SetUp(arg_3_1)
	end
end

function ChessGlobalEventManager:ClearGlobalEventByType(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.globalEventList_) do
		if WarchessGlobalCfg[iter_4_0].type == arg_4_1 then
			self.globalEventList_[iter_4_0] = nil

			WarChessData:ClearGlobalEvent(arg_4_1, iter_4_0)
		end
	end
end

function ChessGlobalEventManager:ClearGlobalEventByID(arg_5_1)
	self.globalEventList_[arg_5_1] = nil

	WarChessData:ClearGlobalEvent(WarchessGlobalCfg[arg_5_1].type, arg_5_1)
end

function ChessGlobalEventManager:ExecuteGlobalEvent(arg_6_1)
	self:UpdateEventProgress(arg_6_1)

	for iter_6_0, iter_6_1 in pairs(self.globalEventList_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if self:IsConditionCheck(iter_6_0, iter_6_3.params, arg_6_1) then
				if self.globalEventModels[WarchessGlobalCfg[iter_6_0].type] and self.globalEventModels[WarchessGlobalCfg[iter_6_0].type].ExternExecutePhase then
					local var_6_0 = self.globalEventModels[WarchessGlobalCfg[iter_6_0].type]:ExternExecutePhase(iter_6_0, arg_6_1)

					if var_6_0 then
						self:CreateGlobalEventQueue(var_6_0, "GLOBAL")
					end
				end

				self:CreateGlobalEventQueue(iter_6_3.eventList, "GLOBAL")

				if self.globalEventModels[WarchessGlobalCfg[iter_6_0].type] then
					self.globalEventModels[WarchessGlobalCfg[iter_6_0].type]:ExecutePhase(iter_6_0)
				end

				self.globalEventList_[iter_6_0] = nil

				WarChessData:ClearGlobalEvent(WarchessGlobalCfg[iter_6_0].type, iter_6_0)

				return
			end

			if self.globalEventModels[WarchessGlobalCfg[iter_6_0].type] and self.globalEventModels[WarchessGlobalCfg[iter_6_0].type].ExternExecutePhase then
				local var_6_1 = self.globalEventModels[WarchessGlobalCfg[iter_6_0].type]:ExternExecutePhase(iter_6_0, arg_6_1)

				if var_6_1 then
					self:CreateGlobalEventQueue(var_6_1, "GLOBAL")

					return
				end
			end
		end
	end
end

function ChessGlobalEventManager:IsConditionCheck(arg_7_1, arg_7_2, arg_7_3)
	if WarchessGlobalCfg[arg_7_1].type == ChessConst.GLOBAL.START then
		return true
	elseif self.globalEventModels[WarchessGlobalCfg[arg_7_1].type] then
		return self.globalEventModels[WarchessGlobalCfg[arg_7_1].type]:IsConditionCheck(arg_7_1, arg_7_3)
	else
		local var_7_0 = WarChessData:GetGlobalEventList()[WarchessGlobalCfg[arg_7_1].type][arg_7_1]
		local var_7_1 = (WarchessGlobalCfg[arg_7_1].type == ChessConst.GLOBAL.PROGRESS or WarchessGlobalCfg[arg_7_1].type == ChessConst.GLOBAL.TALLY) and arg_7_2[1] or arg_7_2[2]

		if type(var_7_1) ~= "number" then
			-- block empty
		end

		return var_7_1 <= var_7_0
	end
end

function ChessGlobalEventManager:UpdateEventProgress(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.globalEventList_) do
		if WarchessGlobalCfg[iter_8_0].type == ChessConst.GLOBAL.PROGRESS then
			WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[iter_8_0].type, iter_8_0, (ChessTools.GetProgress(WarChessData:GetCurrentChapter())))
		elseif WarchessGlobalCfg[iter_8_0].type == ChessConst.GLOBAL.EVENT then
			WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[iter_8_0].type, iter_8_0, WarChessData:GetEventExecuteTime(WarchessGlobalCfg[iter_8_0].params[1]) or 0)
		elseif self.globalEventModels[WarchessGlobalCfg[iter_8_0].type] then
			self.globalEventModels[WarchessGlobalCfg[iter_8_0].type]:UpdateProgress(iter_8_0, arg_8_1)
		end
	end
end

function ChessGlobalEventManager:CreateGlobalEventQueue(arg_9_1, arg_9_2)
	self.handler_:InsertEventQueue(arg_9_1, arg_9_2)
end

function ChessGlobalEventManager:Dispose()
	self.globalEventList_ = {}
	self.eventGlobalQueue_ = {}
	self.eventGlobalP_ = 1

	for iter_10_0, iter_10_1 in pairs(self.globalEventModels) do
		iter_10_1:Dispose()
	end
end

return ChessGlobalEventManager
