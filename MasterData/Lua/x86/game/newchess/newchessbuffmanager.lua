local var_0_0 = singletonClass("NewChessBuffManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.ActiveBuffList = {}
	arg_1_0.EntityCount = 0
end

function var_0_0:SetServerData(arg_2_1)
	self.ActiveBuffList = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		self.EntityCount = self.EntityCount + 1

		table.insert(self.ActiveBuffList, (NewChessBuffConfig[NewWarChessBuffPoolCfg[iter_2_1.buffID].type].New(iter_2_1.buffID, self.EntityCount, NewWarChessBuffPoolCfg[iter_2_1.buffID].updateround, NewWarChessBuffPoolCfg[iter_2_1.buffID].remainround, NewWarChessBuffPoolCfg[iter_2_1.buffID].param, {
			updateRound = NewWarChessBuffPoolCfg[iter_2_1.buffID].updateround - iter_2_1.duration % NewWarChessBuffPoolCfg[iter_2_1.buffID].updateround,
			remainRound = NewWarChessBuffPoolCfg[iter_2_1.buffID].remainround - iter_2_1.duration
		})))
	end
end

function var_0_0:AddBuff(arg_3_1)
	self.EntityCount = self.EntityCount + 1

	local var_3_0 = NewChessBuffConfig[NewWarChessBuffPoolCfg[arg_3_1].type].New(arg_3_1, self.EntityCount, NewWarChessBuffPoolCfg[arg_3_1].updateround, NewWarChessBuffPoolCfg[arg_3_1].remainround, NewWarChessBuffPoolCfg[arg_3_1].param)

	var_3_0:OnBuffAwake()
	table.insert(self.ActiveBuffList, var_3_0)
	var_3_0:OnBuffStart()
	manager.NewChessManager:CreateTips({
		tipsType = NewChessConst.TIPS_TYPE.BUFF,
		tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_BUFF"), NewWarChessBuffPoolCfg[arg_3_1].name),
		tipsBuffEntity = var_3_0
	})
	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)

	return var_3_0
end

function var_0_0:UpdateBuff()
	for iter_4_0, iter_4_1 in pairs(self.ActiveBuffList) do
		iter_4_1:OnBuffUpdate()
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)
end

function var_0_0:RemoveBuff(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.ActiveBuffList) do
		if iter_5_1:GetBuffEntityID() == arg_5_1 then
			iter_5_1:OnBuffDisable()

			self.ActiveBuffList[iter_5_0] = nil

			iter_5_1:OnBuffDestroy()

			return
		end
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)
end

function var_0_0:GetActiveBuffEntityList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.ActiveBuffList) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function var_0_0:GetBuffEntity(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self.ActiveBuffList) do
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
