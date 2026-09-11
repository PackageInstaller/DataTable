local ChessGlobalOrderEventModel = class("ChessGlobalOrderEventModel")

function ChessGlobalOrderEventModel:Ctor(arg_1_1)
	self.curIndex_ = nil
	self.curEventID_ = nil
	self.curGridList_ = nil
	self.changeGrid_ = nil
	self.isRight_ = false
end

function ChessGlobalOrderEventModel:SetUp(arg_2_1)
	if self.curEventID_ and self.curEventID_ ~= arg_2_1 then
		self.handler_:ClearGlobalEventByID(self.curEventID_)
	end

	self.curIndex_ = WarChessData:GetGlobalEventProgress(arg_2_1) or 0
	self.curEventID_ = arg_2_1
	self.curGridList_ = {}

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[self.curEventID_].type, arg_2_1, self.curIndex_)

	if WarchessGlobalCfg[self.curEventID_].sub_type == 701 then
		for iter_2_0, iter_2_1 in pairs(WarchessGlobalCfg[self.curEventID_].params) do
			table.insert(self.curGridList_, {
				x = iter_2_1[1],
				z = iter_2_1[2]
			})
		end
	elseif WarchessGlobalCfg[self.curEventID_].sub_type == 702 then
		for iter_2_2, iter_2_3 in pairs(WarchessGlobalCfg[self.curEventID_].params[1]) do
			table.insert(self.curGridList_, {
				x = iter_2_3[1],
				z = iter_2_3[2]
			})
		end

		self.changeGrid_ = WarchessGlobalCfg[self.curEventID_].params[2]

		if #self.changeGrid_ ~= 2 then
			error("配置错误：数量不对" .. self.curEventID_)
		end
	end
end

function ChessGlobalOrderEventModel:IsConditionCheck(arg_3_1, arg_3_2)
	if not self.curEventID_ then
		return
	end

	if arg_3_2 == ChessConst.TIMING_INTERACT and self.curIndex_ >= #self.curGridList_ then
		return true
	end

	return false
end

function ChessGlobalOrderEventModel:ExternExecutePhase(arg_4_1, arg_4_2)
	if arg_4_2 ~= ChessConst.TIMING_INTERACT then
		return
	end

	local var_4_0 = WarchessGlobalCfg[self.curEventID_].sub_type
	local var_4_1 = manager.ChessManager:GetExecutingChess()
	local var_4_2 = false

	for iter_4_0, iter_4_1 in ipairs(self.curGridList_) do
		if iter_4_1.x == var_4_1.x and iter_4_1.z == var_4_1.z then
			var_4_2 = iter_4_0

			break
		end
	end

	if not var_4_2 then
		return false
	end

	local var_4_3 = var_4_1.paramList[0]

	if self.isRight_ then
		if WarchessEventPoolCfg[var_4_3].event_group_second == "" then
			return nil
		end

		local var_4_4 = deepClone(WarchessEventPoolCfg[var_4_3].event_group_second)

		if var_4_0 == 702 then
			if self.curIndex_ == 3 then
				table.insert(var_4_4, {
					10602,
					{
						{
							10304,
							self.curGridList_[1].x,
							self.curGridList_[1].z,
							{
								2
							}
						},
						{
							10304,
							self.curGridList_[2].x,
							self.curGridList_[2].z,
							{
								2
							}
						},
						{
							10304,
							self.curGridList_[3].x,
							self.curGridList_[3].z,
							{
								2
							}
						},
						{
							10304,
							self.changeGrid_[1],
							self.changeGrid_[2],
							{
								1
							}
						}
					}
				})
			elseif self.curIndex_ == 6 then
				table.insert(var_4_4, {
					10602,
					{
						{
							10304,
							self.curGridList_[4].x,
							self.curGridList_[4].z,
							{
								2
							}
						},
						{
							10304,
							self.curGridList_[5].x,
							self.curGridList_[5].z,
							{
								2
							}
						},
						{
							10304,
							self.curGridList_[6].x,
							self.curGridList_[6].z,
							{
								2
							}
						},
						{
							10304,
							self.changeGrid_[1],
							self.changeGrid_[2],
							{
								2
							}
						}
					}
				})
			end
		end

		return ChessTools.ParseEventPollCfg(var_4_4)
	else
		if WarchessEventPoolCfg[var_4_3].event_group_third == "" then
			return nil
		end

		local var_4_5 = deepClone(WarchessEventPoolCfg[var_4_3].event_group_third)

		if var_4_0 == 702 then
			for iter_4_2, iter_4_3 in ipairs(WarchessGlobalCfg[self.curEventID_].event_list2) do
				table.insert(var_4_5, iter_4_3)
			end
		end

		return ChessTools.ParseEventPollCfg(var_4_5)
	end
end

function ChessGlobalOrderEventModel:ExecutePhase(arg_5_1)
	self.curIndex_ = nil
	self.curEventID_ = nil
	self.curGridList_ = nil
end

function ChessGlobalOrderEventModel:UpdateProgress(arg_6_1, arg_6_2)
	if not self.curEventID_ then
		return
	end

	if arg_6_2 == ChessConst.TIMING_INTERACT then
		local var_6_0 = manager.ChessManager:GetExecutingChess()

		if self.curGridList_[self.curIndex_ + 1].x == var_6_0.x and self.curGridList_[self.curIndex_ + 1].z == var_6_0.z then
			self.curIndex_ = self.curIndex_ + 1
			self.isRight_ = true

			WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[arg_6_1].type, arg_6_1, self.curIndex_)
		else
			self.isRight_ = false
		end
	end
end

function ChessGlobalOrderEventModel:Dispose()
	self.curIndex_ = nil
	self.curEventID_ = nil
	self.curGridList_ = nil
end

return ChessGlobalOrderEventModel
