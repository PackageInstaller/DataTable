local ChessGlobalCheckModel = class("ChessGlobalCheckModel")

function ChessGlobalCheckModel:Ctor()
	self.curEventIDList_ = {}
	self.curConditionList_ = {}
end

function ChessGlobalCheckModel:SetUp(arg_2_1)
	if self.curEventIDList_[arg_2_1] then
		return
	end

	self.curEventIDList_[arg_2_1] = WarchessGlobalCfg[arg_2_1].params
	self.curConditionList_[arg_2_1] = false
end

function ChessGlobalCheckModel:IsConditionCheck(arg_3_1, arg_3_2)
	if self.curConditionList_[arg_3_1] then
		self.curConditionList_[arg_3_1] = nil

		return true
	end

	return false
end

function ChessGlobalCheckModel:ExecutePhase(arg_4_1)
	return
end

function ChessGlobalCheckModel:UpdateProgress(arg_5_1, arg_5_2)
	local var_5_0 = false
	local var_5_1 = manager.ChessManager:GetExecutingChess()

	if var_5_1 then
		for iter_5_0, iter_5_1 in pairs(self.curEventIDList_[arg_5_1]) do
			if var_5_1.x == iter_5_1[1] and var_5_1.z == iter_5_1[2] then
				var_5_0 = true

				break
			end
		end

		if var_5_0 then
			for iter_5_2, iter_5_3 in pairs(self.curEventIDList_[arg_5_1]) do
				if not WarChessData:GetGridIsChanged(iter_5_3[1], iter_5_3[2]) then
					return
				end
			end

			self.curEventIDList_[arg_5_1] = nil
			self.curConditionList_[arg_5_1] = true

			return
		end
	end
end

function ChessGlobalCheckModel:Dispose()
	self.curEventIDList_ = {}
	self.curConditionList_ = {}
end

return ChessGlobalCheckModel
