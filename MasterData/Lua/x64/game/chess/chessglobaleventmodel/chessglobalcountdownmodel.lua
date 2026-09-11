local ChessGlobalAreaModel = class("ChessGlobalAreaModel")

function ChessGlobalAreaModel:Ctor(arg_1_1)
	self.step = nil
	self.curEventID_ = nil
	self.handler_ = arg_1_1
end

function ChessGlobalAreaModel:SetUp(arg_2_1)
	if self.curEventID_ and self.curEventID_ ~= arg_2_1 then
		self.handler_:ClearGlobalEventByID(self.curEventID_)
	end

	self.curEventID_ = arg_2_1

	local var_2_0 = WarChessData:GetGlobalEventProgress(arg_2_1) or WarchessGlobalCfg[arg_2_1].params[1]

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[self.curEventID_].type, self.curEventID_, var_2_0)

	self.step = var_2_0
end

function ChessGlobalAreaModel:IsConditionCheck(arg_3_1, arg_3_2)
	if arg_3_2 == ChessConst.TIMING_WALK and self.step and self.step < 0 then
		return true
	end

	return false
end

function ChessGlobalAreaModel:ExecutePhase(arg_4_1)
	self.step = nil
	self.curEventID_ = nil
end

function ChessGlobalAreaModel:UpdateProgress(arg_5_1, arg_5_2)
	if arg_5_2 == ChessConst.TIMING_WALK then
		self.step = self.step - 1

		WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[arg_5_1].type, arg_5_1, self.step)
	end
end

function ChessGlobalAreaModel:Dispose()
	self.step = nil
	self.curEventID_ = nil
end

return ChessGlobalAreaModel
