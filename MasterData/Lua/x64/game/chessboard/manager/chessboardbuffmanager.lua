local ChessBoardBuffManager = class("ChessBoardBuffManager")

function ChessBoardBuffManager:Ctor()
	self.ActiveBuffList = {}
end

function ChessBoardBuffManager:SetServerData(arg_2_1, arg_2_2)
	self.playerEntityID_ = arg_2_1
	self.ActiveBuffList = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_2 or {}) do
		self.ActiveBuffList[iter_2_1.id] = ChessBoardBuffEntity.New(iter_2_1.id, arg_2_1, iter_2_1.duration, iter_2_1.effectInfoList)
	end
end

function ChessBoardBuffManager:AddBuff(arg_3_1)
	local var_3_0 = ChessBoardBuffPoolCfg[arg_3_1]

	if (self.playerEntityID_ == 0 and manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_INVINCIBLE") or manager.ChessBoardManager:GetNPCAttribute(self.playerEntityID_, "CHESSBOARD_ATTRIBUTE_ID_INVINCIBLE")) >= 1 and var_3_0.buff_type == ChessBoardConst.BUFF_TYPE.DEBUFF then
		return
	end

	if self.ActiveBuffList[arg_3_1] then
		ShowTips("CHESSBOARD_BUFF_UPDATE")
	end

	if var_3_0.clash == 1 then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.BUFF_TIPS, {
			buffID = arg_3_1,
			playerEntity = self.playerEntityID_
		})
		self:CheckClashBuff()
	end

	self.ActiveBuffList[arg_3_1] = ChessBoardBuffEntity.New(arg_3_1, self.playerEntityID_, 0, {})

	self.ActiveBuffList[arg_3_1]:OnBuffStart()
	manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
end

function ChessBoardBuffManager:CheckClashBuff()
	for iter_4_0, iter_4_1 in pairs(self.ActiveBuffList) do
		local var_4_0 = ChessBoardBuffPoolCfg[iter_4_1:GetBuffPoolID()]

		if var_4_0.clash == 1 then
			self:RemoveBuff(var_4_0.id)
		end
	end
end

function ChessBoardBuffManager:GetBuffData()
	for iter_5_0, iter_5_1 in pairs(self.ActiveBuffList) do
		local var_5_0 = ChessBoardBuffPoolCfg[iter_5_1:GetBuffPoolID()]

		if var_5_0.clash == 1 then
			return iter_5_1, var_5_0
		end
	end

	return nil, nil
end

function ChessBoardBuffManager:OnBuffUpdateTurn()
	for iter_6_0, iter_6_1 in pairs(self.ActiveBuffList) do
		iter_6_1:UpdateTurn()
	end

	for iter_6_2, iter_6_3 in pairs(self.ActiveBuffList) do
		iter_6_3:OnBuffUpdateTurn()
	end

	if self.playerEntityID_ == 0 then
		manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
	end
end

function ChessBoardBuffManager:RemoveBuff(arg_7_1)
	if self.ActiveBuffList[arg_7_1] then
		self.ActiveBuffList[arg_7_1]:OnBuffDestroy()
		self.ActiveBuffList[arg_7_1]:Dispose()

		self.ActiveBuffList[arg_7_1] = nil

		manager.notify:CallUpdateFunc(CHESSBOARD_BUFF_UPDATE)
	end
end

function ChessBoardBuffManager:OnBuffEffectTrigger(arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.ActiveBuffList) do
		table.insert(var_8_0, iter_8_0)
	end

	for iter_8_2 = 1, #var_8_0 do
		if var_8_0[iter_8_2] and self.ActiveBuffList[var_8_0[iter_8_2]] then
			self.ActiveBuffList[var_8_0[iter_8_2]]:OnBuffEffectTrigger(arg_8_1, arg_8_2)

			var_8_0[iter_8_2] = nil
		end
	end
end

function ChessBoardBuffManager:ClearDebuff()
	local var_9_0 = false

	for iter_9_0, iter_9_1 in pairs(self.ActiveBuffList) do
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

function ChessBoardBuffManager:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.ActiveBuffList) do
		if iter_10_1 then
			iter_10_1:Dispose()
		end
	end

	self.ActiveBuffList = {}
end

return ChessBoardBuffManager
