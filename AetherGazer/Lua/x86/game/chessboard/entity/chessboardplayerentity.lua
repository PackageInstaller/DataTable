local var_0_0 = class("ChessBoardPlayerEntity")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.id_ = 0
	arg_1_0.playerType_ = nil
	arg_1_0.pos_ = {
		x = 0,
		z = 0
	}
	arg_1_0.direction_ = 0
	arg_1_0.attribute_ = {}
	arg_1_0.buffManager_ = ChessBoardBuffManager.New()
end

function var_0_0.SetServerData(arg_2_0, arg_2_1)
	arg_2_0.id_ = arg_2_1.id
	arg_2_0.playerType_ = arg_2_1.typeID
	arg_2_0.pos_.x = arg_2_1.pos.x
	arg_2_0.pos_.z = arg_2_1.pos.z
	arg_2_0.direction_ = arg_2_1.dir
	arg_2_0.attribute_ = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.attribute) do
		arg_2_0.attribute_[iter_2_0] = iter_2_1
	end

	arg_2_0.buffManager_:SetServerData(arg_2_0.id_, arg_2_1.buffList)
end

function var_0_0.MoveToPos(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.GetAttribute(arg_4_0, arg_4_1)
	local var_4_0
	local var_4_1

	if type(arg_4_1) == "string" then
		var_4_0 = arg_4_1
		var_4_1 = ChessBoardAttributeCfg[var_4_0].id
	elseif type(arg_4_1) == "number" then
		var_4_1 = arg_4_1

		for iter_4_0, iter_4_1 in pairs(ChessBoardAttributeCfg) do
			if iter_4_1.id == arg_4_1 then
				var_4_0 = iter_4_0

				break
			end
		end
	end

	if arg_4_0.attribute_[var_4_1] then
		if arg_4_0.attribute_[var_4_1] < ChessBoardAttributeCfg[var_4_0].min then
			return ChessBoardAttributeCfg[var_4_0].min
		end

		return arg_4_0.attribute_[var_4_1]
	else
		return ChessBoardAttributeCfg[var_4_0].default
	end
end

function var_0_0.SubAttribute(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0
	local var_5_1

	if type(arg_5_1) == "string" then
		var_5_0 = arg_5_1
		var_5_1 = ChessBoardAttributeCfg[var_5_0].id
	elseif type(arg_5_1) == "number" then
		var_5_1 = arg_5_1

		for iter_5_0, iter_5_1 in pairs(ChessBoardAttributeCfg) do
			if iter_5_1.id == arg_5_1 then
				var_5_0 = iter_5_0

				break
			end
		end
	end

	if arg_5_0.attribute_[var_5_1] then
		arg_5_0.attribute_[var_5_1] = arg_5_0.attribute_[var_5_1] + arg_5_2
	else
		arg_5_0.attribute_[var_5_1] = ChessBoardAttributeCfg[var_5_0].default + arg_5_2
	end

	if arg_5_0.attribute_[var_5_1] < 0 then
		arg_5_0.attribute_[var_5_1] = 0
	end

	if arg_5_0.id_ == 0 then
		ChessBoardData:FixHeroAttribute(var_5_1, arg_5_0.attribute_[var_5_1])

		if var_5_0 == "CHESSBOARD_ATTRIBUTE_ID_GOLD" then
			manager.notify:CallUpdateFunc(CHESSBOARD_GOLD_UPDATE, arg_5_2)
		elseif var_5_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" then
			manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
		end
	else
		ChessBoardData:FixNPCAttribute(arg_5_0.id_, var_5_1, arg_5_0.attribute_[var_5_1])

		if var_5_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" then
			manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, arg_5_0.attribute_[var_5_1])
		end
	end
end

function var_0_0.SetAttribute(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1

	if type(arg_6_1) == "string" then
		var_6_0 = arg_6_1
		var_6_1 = ChessBoardAttributeCfg[var_6_0].id
	elseif type(arg_6_1) == "number" then
		var_6_1 = arg_6_1

		for iter_6_0, iter_6_1 in pairs(ChessBoardAttributeCfg) do
			if iter_6_1.id == arg_6_1 then
				var_6_0 = iter_6_0

				break
			end
		end
	end

	arg_6_0.attribute_[var_6_1] = arg_6_2

	if arg_6_0.id_ == 0 then
		ChessBoardData:FixHeroAttribute(var_6_1, arg_6_2)

		if var_6_0 == "CHESSBOARD_ATTRIBUTE_ID_GOLD" then
			manager.notify:CallUpdateFunc(CHESSBOARD_GOLD_UPDATE)
		elseif var_6_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" then
			manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
		end
	else
		ChessBoardData:FixNPCAttribute(arg_6_0.id_, var_6_1, arg_6_2)

		if var_6_0 == "CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM" and arg_6_2 == 0 then
			manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
		end
	end

	return arg_6_0.attribute_[var_6_1]
end

function var_0_0.AddBuff(arg_7_0, arg_7_1)
	arg_7_0.buffManager_:AddBuff(arg_7_1)
end

function var_0_0.RemoveBuff(arg_8_0, arg_8_1)
	arg_8_0.buffManager_:RemoveBuff(arg_8_1)
end

function var_0_0.GetBuffData(arg_9_0)
	return arg_9_0.buffManager_:GetBuffData()
end

function var_0_0.UpdateBuffStep(arg_10_0)
	arg_10_0.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.STEP_UPDATE, -1)
end

function var_0_0.OnBuffUpdateTurn(arg_11_0)
	arg_11_0.buffManager_:OnBuffUpdateTurn()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.buffManager_:Dispose()
end

function var_0_0.GetEntityId(arg_13_0)
	return arg_13_0.id_
end

function var_0_0.GetPosAndDir(arg_14_0)
	return arg_14_0.pos_, arg_14_0.direction_
end

function var_0_0.CheckIsSamePos(arg_15_0, arg_15_1)
	if arg_15_1.x == arg_15_0.pos_.x and arg_15_1.z == arg_15_0.pos_.z then
		return true
	else
		return false
	end
end

return var_0_0
