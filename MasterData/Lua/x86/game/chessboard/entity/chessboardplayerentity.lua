local ChessBoardPlayerEntity = class("ChessBoardPlayerEntity")

function ChessBoardPlayerEntity:Ctor()
	self.id_ = 0
	self.playerType_ = nil
	self.pos_ = {
		x = 0,
		z = 0
	}
	self.direction_ = 0
	self.attribute_ = {}
	self.buffManager_ = ChessBoardBuffManager.New()
end

function ChessBoardPlayerEntity:SetServerData(arg_2_1)
	self.id_ = arg_2_1.id
	self.playerType_ = arg_2_1.typeID
	self.pos_.x = arg_2_1.pos.x
	self.pos_.z = arg_2_1.pos.z
	self.direction_ = arg_2_1.dir
	self.attribute_ = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.attribute) do
		self.attribute_[iter_2_0] = iter_2_1
	end

	self.buffManager_:SetServerData(self.id_, arg_2_1.buffList)
end

function ChessBoardPlayerEntity:MoveToPos(arg_3_1, arg_3_2)
	return
end

function ChessBoardPlayerEntity:GetAttribute(arg_4_1)
	local var_4_0
	local var_4_1

	if type(arg_4_1) == "string" then
		var_4_0 = arg_4_1
		var_4_1 = ChessBoardAttributeCfg[arg_4_1].id
	elseif type(arg_4_1) == "number" then
		var_4_1 = arg_4_1

		for iter_4_0, iter_4_1 in pairs(ChessBoardAttributeCfg) do
			if iter_4_1.id == arg_4_1 then
				var_4_0 = iter_4_0

				break
			end
		end
	end

	if self.attribute_[var_4_1] then
		if self.attribute_[var_4_1] < ChessBoardAttributeCfg[var_4_0].min then
			return ChessBoardAttributeCfg[var_4_0].min
		end

		return self.attribute_[var_4_1]
	else
		return ChessBoardAttributeCfg[var_4_0].default
	end
end

function ChessBoardPlayerEntity:SubAttribute(arg_5_1, arg_5_2)
	local var_5_0
	local var_5_1

	if type(arg_5_1) == "string" then
		var_5_0 = arg_5_1
		var_5_1 = ChessBoardAttributeCfg[arg_5_1].id
	elseif type(arg_5_1) == "number" then
		var_5_1 = arg_5_1

		for iter_5_0, iter_5_1 in pairs(ChessBoardAttributeCfg) do
			if iter_5_1.id == arg_5_1 then
				var_5_0 = iter_5_0

				break
			end
		end
	end

	self.attribute_[var_5_1] = self.attribute_[var_5_1] and self.attribute_[var_5_1] + arg_5_2 or ChessBoardAttributeCfg[var_5_0].default + arg_5_2

	if self.attribute_[var_5_1] < 0 then
		self.attribute_[var_5_1] = 0
	end

	if self.id_ == 0 then
		ChessBoardData:FixHeroAttribute(var_5_1, self.attribute_[var_5_1])

		if var_5_0 == "CHESSBOARD_ATTRIBUTE_ID_GOLD" then
			manager.notify:CallUpdateFunc(CHESSBOARD_GOLD_UPDATE, arg_5_2)
		elseif var_5_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" then
			manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
		end
	else
		ChessBoardData:FixNPCAttribute(self.id_, var_5_1, self.attribute_[var_5_1])

		if var_5_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" then
			manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, self.attribute_[var_5_1])
		end
	end
end

function ChessBoardPlayerEntity:SetAttribute(arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1

	if type(arg_6_1) == "string" then
		var_6_0 = arg_6_1
		var_6_1 = ChessBoardAttributeCfg[arg_6_1].id
	elseif type(arg_6_1) == "number" then
		var_6_1 = arg_6_1

		for iter_6_0, iter_6_1 in pairs(ChessBoardAttributeCfg) do
			if iter_6_1.id == arg_6_1 then
				var_6_0 = iter_6_0

				break
			end
		end
	end

	self.attribute_[var_6_1] = arg_6_2

	if self.id_ == 0 then
		ChessBoardData:FixHeroAttribute(var_6_1, arg_6_2)

		if var_6_0 == "CHESSBOARD_ATTRIBUTE_ID_GOLD" then
			manager.notify:CallUpdateFunc(CHESSBOARD_GOLD_UPDATE)
		elseif var_6_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" then
			manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
		end
	else
		ChessBoardData:FixNPCAttribute(self.id_, var_6_1, arg_6_2)

		if var_6_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" and arg_6_2 == 0 then
			manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
		end
	end

	return self.attribute_[var_6_1]
end

function ChessBoardPlayerEntity:AddBuff(arg_7_1)
	self.buffManager_:AddBuff(arg_7_1)
end

function ChessBoardPlayerEntity:RemoveBuff(arg_8_1)
	self.buffManager_:RemoveBuff(arg_8_1)
end

function ChessBoardPlayerEntity:GetBuffData()
	return self.buffManager_:GetBuffData()
end

function ChessBoardPlayerEntity:UpdateBuffStep()
	self.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.STEP_UPDATE, -1)
end

function ChessBoardPlayerEntity:OnBuffUpdateTurn()
	self.buffManager_:OnBuffUpdateTurn()
end

function ChessBoardPlayerEntity:Dispose()
	self.buffManager_:Dispose()
end

function ChessBoardPlayerEntity:GetEntityId()
	return self.id_
end

function ChessBoardPlayerEntity:GetPosAndDir()
	return self.pos_, self.direction_
end

function ChessBoardPlayerEntity:CheckIsSamePos(arg_15_1)
	if arg_15_1.x == self.pos_.x and arg_15_1.z == self.pos_.z then
		return true
	else
		return false
	end
end

return ChessBoardPlayerEntity
