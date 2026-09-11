local ChessGlobalAreaModel = class("ChessGlobalAreaModel")

function ChessGlobalAreaModel:Ctor()
	self.areaMemory_ = {}
end

function ChessGlobalAreaModel:SetUp(arg_2_1)
	self.areaMemory_[arg_2_1] = ChessTools.PhraseArea(WarchessGlobalCfg[arg_2_1].params)
end

function ChessGlobalAreaModel:IsConditionCheck(arg_3_1)
	local var_3_0 = WarChessData:GetCurrentIndex()

	if not self.areaMemory_[arg_3_1] then
		return false
	end

	return self.areaMemory_[arg_3_1][ChessTools.TwoDToOneD(var_3_0.x, var_3_0.z)]
end

function ChessGlobalAreaModel:ExecutePhase(arg_4_1)
	self.areaMemory_[arg_4_1] = nil

	manager.ChessManager:StopMove()
end

function ChessGlobalAreaModel:UpdateProgress()
	return
end

function ChessGlobalAreaModel:Dispose()
	self.areaMemory_ = {}
end

return ChessGlobalAreaModel
