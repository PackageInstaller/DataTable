local ChessForceBattleModel = class("ChessForceBattleModel")

function ChessForceBattleModel:Ctor()
	self.battleStart_ = false
	self.battleResult_ = 0
	self.battleID_ = nil
end

function ChessForceBattleModel:SetUp(arg_2_1)
	self.width_ = arg_2_1
end

function ChessForceBattleModel:BattleStart(arg_3_1, arg_3_2, arg_3_3)
	self.battleStart_ = true
	self.battleResult_ = 0
	self.battleID_ = arg_3_3

	self:SetBattleIndex(arg_3_1, arg_3_2)

	local var_3_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_3_0 then
		self.originShadowRotationImmediately = var_3_0.shadowRotationImmediately
		var_3_0.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)
end

function ChessForceBattleModel:SetBattleIndex(arg_4_1, arg_4_2)
	WarChessData:SetBattleIndex(arg_4_2 * self.width_ + arg_4_1 + 1)
end

function ChessForceBattleModel:BattleResult(arg_5_1)
	if not self.battleStart_ then
		return
	end

	self.battleResult_ = arg_5_1 and 1 or 2
end

function ChessForceBattleModel:IsForcingBattle()
	return self.battleStart_
end

function ChessForceBattleModel:ForceEnterBossBattle(arg_7_1)
	if arg_7_1 then
		self.battleID_ = arg_7_1
	else
		arg_7_1 = self.battleID_
	end

	if not BattleChessStageCfg[arg_7_1] then
		-- block empty
	end

	local var_7_0 = WarChessData:GetBossPos()
	local var_7_1 = WarChessData:GetGridLua(var_7_0[1], var_7_0[2])

	self:BattleStart(var_7_0[1], var_7_0[2], arg_7_1)
	gameContext:Go("/sectionSelectHero", {
		section = arg_7_1,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
		activityID = WarChessData:GetCurrentActivity(),
		customBarList = {
			BACK_BAR
		}
	})
end

function ChessForceBattleModel:BattleFinish()
	if self.battleStart_ then
		ChessLuaBridge.SetCameraControlEnable(true)

		local var_8_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

		if var_8_0 then
			var_8_0.shadowRotationImmediately = self.originShadowRotationImmediately
		end

		if self.battleResult_ == 0 then
			-- block empty
		elseif self.battleResult_ == 1 then
			WarChessAction.CostShipHp(-30)

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			manager.ChessManager:DoNextEvent()

			self.battleStart_ = false
			self.battleResult_ = 0
		elseif self.battleResult_ == 2 then
			WarChessAction.CostShipHp(-50)

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			manager.ChessManager:DoNextEvent()

			self.battleStart_ = false
			self.battleResult_ = 0
		end
	end
end

function ChessForceBattleModel:Dispose()
	self.battleStart_ = false
	self.battleResult_ = 0
end

return ChessForceBattleModel
