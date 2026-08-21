local var_0_0 = class("ChessBoardBuffManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.ActiveBuffList = {}
end

function var_0_0.SetServerData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.playerEntityID_ = arg_2_1
	arg_2_0.ActiveBuffList = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_2 or {}) do
		local var_2_0 = ChessBoardBuffEntity.New(iter_2_1.id, arg_2_1, iter_2_1.duration, iter_2_1.effectInfoList)

		arg_2_0.ActiveBuffList[iter_2_1.id] = var_2_0
	end
end

function var_0_0.AddBuff(arg_3_0, arg_3_1)
	local var_3_0 = ChessBoardBuffPoolCfg[arg_3_1]
	local var_3_1

	if arg_3_0.playerEntityID_ == 0 then
		var_3_1 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_INVINCIBLE")
	else
		var_3_1 = manager.ChessBoardManager:GetNPCAttribute(arg_3_0.playerEntityID_, "CHESSBOARD_ATTRIBUTE_ID_INVINCIBLE")
	end

	if var_3_1 >= 1 and var_3_0.buff_type == ChessBoardConst.BUFF_TYPE.DEBUFF then
		return
	end

	if arg_3_0.ActiveBuffList[arg_3_1] then
		ShowTips("CHESSBOARD_BUFF_UPDATE")
	end

	if var_3_0.clash == 1 then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.BUFF_TIPS, {
			buffID = arg_3_1,
			playerEntity = arg_3_0.playerEntityID_
		})
		arg_3_0:CheckClashBuff()
	end

	arg_3_0.ActiveBuffList[arg_3_1] = ChessBoardBuffEntity.New(arg_3_1, arg_3_0.playerEntityID_, 0, {})

	arg_3_0.ActiveBuffList[arg_3_1]:OnBuffStart()
	manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
end

function var_0_0.CheckClashBuff(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.ActiveBuffList) do
		local var_4_0 = ChessBoardBuffPoolCfg[iter_4_1:GetBuffPoolID()]

		if var_4_0.clash == 1 then
			arg_4_0:RemoveBuff(var_4_0.id)
		end
	end
end

function var_0_0.GetBuffData(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.ActiveBuffList) do
		local var_5_0 = ChessBoardBuffPoolCfg[iter_5_1:GetBuffPoolID()]

		if var_5_0.clash == 1 then
			return iter_5_1, var_5_0
		end
	end

	return nil, nil
end

function var_0_0.OnBuffUpdateTurn(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.ActiveBuffList) do
		iter_6_1:UpdateTurn()
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0.ActiveBuffList) do
		iter_6_3:OnBuffUpdateTurn()
	end

	if arg_6_0.playerEntityID_ == 0 then
		manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
	end
end

function var_0_0.RemoveBuff(arg_7_0, arg_7_1)
	if arg_7_0.ActiveBuffList[arg_7_1] then
		arg_7_0.ActiveBuffList[arg_7_1]:OnBuffDestroy()
		arg_7_0.ActiveBuffList[arg_7_1]:Dispose()

		arg_7_0.ActiveBuffList[arg_7_1] = nil

		manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
	end
end

function var_0_0.OnBuffEffectTrigger(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.ActiveBuffList) do
		table.insert(var_8_0, iter_8_0)
	end

	for iter_8_2 = 1, #var_8_0 do
		if var_8_0[iter_8_2] and arg_8_0.ActiveBuffList[var_8_0[iter_8_2]] then
			arg_8_0.ActiveBuffList[var_8_0[iter_8_2]]:OnBuffEffectTrigger(arg_8_1, arg_8_2)

			var_8_0[iter_8_2] = nil
		end
	end
end

function var_0_0.ClearDebuff(arg_9_0)
	local var_9_0 = false

	for iter_9_0, iter_9_1 in pairs(arg_9_0.ActiveBuffList) do
		if iter_9_1:IsDebuff() then
			iter_9_1:OnBuffDestroy()
			iter_9_1:Dispose()

			iter_9_1 = nil
			var_9_0 = true
		end
	end

	if var_9_0 then
		manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
	end
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.ActiveBuffList) do
		if iter_10_1 then
			iter_10_1:Dispose()
		end
	end

	arg_10_0.ActiveBuffList = {}
end

return var_0_0
