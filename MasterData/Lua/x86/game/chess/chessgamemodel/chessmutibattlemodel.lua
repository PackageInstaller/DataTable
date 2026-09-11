local ChessForceBattleModel = class("ChessForceBattleModel")

function ChessForceBattleModel:Ctor()
	self.battleProgress_ = false
	self.battleResult_ = 0
	self.battleTimes_ = 0
	self.battleList_ = {}
end

function ChessForceBattleModel:SetUp(arg_2_1)
	self.width_ = arg_2_1
end

function ChessForceBattleModel:SetBattleIndex()
	local var_3_0 = manager.ChessManager:GetExecutingChess()

	WarChessData:SetBattleIndex(var_3_0.z * self.width_ + var_3_0.x + 1)
end

function ChessForceBattleModel:BattleResult(arg_4_1)
	if not self.battleProgress_ then
		return
	end

	self.battleResult_ = arg_4_1 and 1 or 2
end

function ChessForceBattleModel:IsMutiBattle()
	return not not self.battleProgress_
end

function ChessForceBattleModel:EnterMutiBattle(arg_6_1, arg_6_2)
	if not self.battleProgress_ then
		self.battleTimes_ = arg_6_1
		self.battleList_ = arg_6_2
		self.battleProgress_ = 0

		local var_6_0 = manager.ChessManager:GetExecutingChess()
	end

	if not BattleChessStageCfg[self.battleList_[self.battleProgress_ + 1]] then
		-- block empty
	end

	self:BattleStart(self.battleList_[self.battleProgress_ + 1])
end

function ChessForceBattleModel:BattleStart(arg_7_1)
	self.battleProgress_ = self.battleProgress_ or 0
	self.battleResult_ = 0
	self.battleID_ = arg_7_1

	self:SetBattleIndex()

	local var_7_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_7_0 then
		self.originShadowRotationImmediately = var_7_0.shadowRotationImmediately
		var_7_0.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)
end

function ChessForceBattleModel:ExitMutiBattle()
	self.battleProgress_ = false
	self.battleResult_ = 0

	manager.ChessManager:EventsEnd()
end

function ChessForceBattleModel:Dispose()
	self.battleProgress_ = false
	self.battleResult_ = 0
	self.battleTimes_ = 0
	self.battleList_ = {}
end

return ChessForceBattleModel
