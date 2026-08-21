local var_0_0 = singletonClass("NewChessBuffManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.ActiveBuffList = {}
	arg_1_0.EntityCount = 0
end

function var_0_0.SetServerData(arg_2_0, arg_2_1)
	arg_2_0.ActiveBuffList = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		arg_2_0.EntityCount = arg_2_0.EntityCount + 1

		local var_2_0 = NewWarChessBuffPoolCfg[iter_2_1.buffID]
		local var_2_1 = var_2_0.updateround - iter_2_1.duration % var_2_0.updateround
		local var_2_2 = var_2_0.remainround - iter_2_1.duration
		local var_2_3 = NewChessBuffConfig[var_2_0.type].New(iter_2_1.buffID, arg_2_0.EntityCount, var_2_0.updateround, var_2_0.remainround, var_2_0.param, {
			updateRound = var_2_1,
			remainRound = var_2_2
		})

		table.insert(arg_2_0.ActiveBuffList, var_2_3)
	end
end

function var_0_0.AddBuff(arg_3_0, arg_3_1)
	arg_3_0.EntityCount = arg_3_0.EntityCount + 1

	local var_3_0 = NewWarChessBuffPoolCfg[arg_3_1]
	local var_3_1 = NewChessBuffConfig[var_3_0.type].New(arg_3_1, arg_3_0.EntityCount, var_3_0.updateround, var_3_0.remainround, var_3_0.param)

	var_3_1:OnBuffAwake()
	table.insert(arg_3_0.ActiveBuffList, var_3_1)
	var_3_1:OnBuffStart()

	local var_3_2 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_BUFF"), var_3_0.name)
	local var_3_3 = {
		tipsType = NewChessConst.TIPS_TYPE.BUFF,
		tipsText = var_3_2,
		tipsBuffEntity = var_3_1
	}

	manager.NewChessManager:CreateTips(var_3_3)
	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)

	return var_3_1
end

function var_0_0.UpdateBuff(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.ActiveBuffList) do
		iter_4_1:OnBuffUpdate()
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)
end

function var_0_0.RemoveBuff(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.ActiveBuffList) do
		if iter_5_1:GetBuffEntityID() == arg_5_1 then
			local var_5_0 = iter_5_1

			var_5_0:OnBuffDisable()

			arg_5_0.ActiveBuffList[iter_5_0] = nil

			var_5_0:OnBuffDestroy()

			return
		end
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)
end

function var_0_0.GetActiveBuffEntityList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.ActiveBuffList) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function var_0_0.GetBuffEntity(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.ActiveBuffList) do
		if iter_7_1.buffPoolID == arg_7_1 then
			return iter_7_1
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.ActiveBuffList = {}
	arg_8_0.EntityCount = 0
end

return var_0_0
