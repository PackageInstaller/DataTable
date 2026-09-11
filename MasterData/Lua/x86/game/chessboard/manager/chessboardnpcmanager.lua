local var_0_0 = singletonClass("ChessBoardNPCManager")

function var_0_0.Init(arg_1_0)
	arg_1_0.NPCEntityList_ = {}
	arg_1_0.curMovingNPC_ = -1
	arg_1_0.waitingToMoveNPCList_ = {}
end

function var_0_0:SetServerData(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		self.NPCEntityList_[iter_2_1.id] = ChessBoardNPCEntity.New()

		self.NPCEntityList_[iter_2_1.id]:SetServerData(iter_2_1)
	end
end

function var_0_0:AddNPC(arg_3_1)
	self.NPCEntityList_[arg_3_1.id] = ChessBoardNPCEntity.New()

	self.NPCEntityList_[arg_3_1.id]:SetServerData(arg_3_1)
end

function var_0_0:DeleteNPC(arg_4_1)
	self.NPCEntityList_[arg_4_1] = nil
end

function var_0_0:FindEntity(arg_5_1)
	if self.NPCEntityList_[arg_5_1] then
		return self.NPCEntityList_[arg_5_1]
	end
end

function var_0_0:SetNPCMoveListServerData(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = {}

		for iter_6_2, iter_6_3 in ipairs(iter_6_1.path) do
			table.insert(var_6_0, {
				x = iter_6_3.x,
				z = iter_6_3.z
			})
		end

		self.NPCEntityList_[iter_6_1.npc_id]:SetMovePosList(var_6_0, iter_6_1.move_num)
	end
end

function var_0_0:StartNPCTurn()
	manager.ChessBoardManager.blockerManager_:ShowBlocker()

	local var_7_0 = false

	for iter_7_0, iter_7_1 in pairs(self.NPCEntityList_) do
		if iter_7_1:GetNPCIsReadyToMove() then
			var_7_0 = true

			break
		end
	end

	if var_7_0 then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.ENEMY_TURN_TIPS, {
			callback = function()
				self:StartNpc()
			end
		})
	else
		self:EndNPCTurn()
	end
end

function var_0_0:GetNPCNum()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(self.NPCEntityList_) do
		var_9_0 = var_9_0 + 1
	end

	return var_9_0
end

function var_0_0:StartNpc()
	self.curMovingNPC_ = -1
	self.waitingToMoveNPCList_ = {}

	for iter_10_0, iter_10_1 in pairs(self.NPCEntityList_) do
		if iter_10_1:GetNPCIsReadyToMove() then
			table.insert(self.waitingToMoveNPCList_, iter_10_0)
		end
	end

	table.sort(self.waitingToMoveNPCList_, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)
	self:MoveNextNPC()
end

function var_0_0:MoveNextNPC()
	if #self.waitingToMoveNPCList_ > 0 then
		self.curMovingNPC_ = self.waitingToMoveNPCList_[#self.waitingToMoveNPCList_]
		self.waitingToMoveNPCList_[#self.waitingToMoveNPCList_] = nil

		self.NPCEntityList_[self.curMovingNPC_]:OnMoveStart()
		manager.notify:CallUpdateFunc(CHESSBOARD_PLAY_NPC_DICE_ANI, self.curMovingNPC_, self.NPCEntityList_[self.curMovingNPC_]:GetMoveStep())
	else
		self:EndNPCTurn()
	end
end

function var_0_0:MoveCurNPCNextStep()
	if self.curMovingNPC_ < 0 then
		error("当前不存在移动中的NPC")
	elseif self.NPCEntityList_[self.curMovingNPC_] == nil then
		self:MoveNextNPC()
	elseif self.NPCEntityList_[self.curMovingNPC_]:GetIsMoveEnd() then
		self.curMovingNPC_ = -1

		manager.ChessBoardManager:AddDelayTimer(self.NPCEntityList_[self.curMovingNPC_]:OnMoveEnd(), function()
			self:MoveNextNPC()
		end)
	else
		self.NPCEntityList_[self.curMovingNPC_]:MoveToNextPos()
	end
end

function var_0_0.EndNPCTurn(arg_15_0)
	ChessBoardLuaBridge.LookAtPlayer()
	manager.ChessBoardManager.blockerManager_:HideBlocker()

	arg_15_0.curMovingNPC_ = -1

	manager.ChessBoardManager:UpdateMapTurn()
end

function var_0_0:GetAllNpcPos()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.NPCEntityList_) do
		table.insert(var_16_0, iter_16_1.pos_)
	end

	return var_16_0
end

function var_0_0:FindTargetPosNPCEntity(arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in pairs(self.NPCEntityList_) do
		if arg_17_2 ~= iter_17_1:GetEntityId() and iter_17_1:CheckIsSamePos(arg_17_1) then
			return iter_17_1
		end
	end

	return nil
end

function var_0_0:SetNPCAttribute(arg_18_1, arg_18_2, arg_18_3)
	return self.NPCEntityList_[arg_18_1]:SetAttribute(arg_18_2, arg_18_3)
end

function var_0_0:SubNPCAttribute(arg_19_1, arg_19_2, arg_19_3)
	return self.NPCEntityList_[arg_19_1]:SubAttribute(arg_19_2, arg_19_3)
end

function var_0_0:GetNPCAttribute(arg_20_1, arg_20_2)
	return self.NPCEntityList_[arg_20_1]:GetAttribute(arg_20_2)
end

function var_0_0:TelePortNPCToPosition(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	if self.NPCEntityList_[arg_21_1] == nil then
		error("触发传送不存在的NPC！NPCID = ", arg_21_1)

		return
	end

	self.NPCEntityList_[arg_21_1]:TelePortNPCToPosition(arg_21_2, arg_21_3, arg_21_4, arg_21_5)
end

function var_0_0:FindNPCWithPos(arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in pairs(self.NPCEntityList_) do
		local var_22_0, var_22_1 = iter_22_1:GetPosAndDir()

		if var_22_0.x == arg_22_1 and var_22_0.z == arg_22_2 then
			return iter_22_1:GetEntityId()
		end
	end

	return nil
end

function var_0_0:FindPosAllNPC(arg_23_1, arg_23_2)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.NPCEntityList_) do
		local var_23_1, var_23_2 = iter_23_1:GetPosAndDir()

		if var_23_1.x == arg_23_1 and var_23_1.z == arg_23_2 then
			table.insert(var_23_0, iter_23_1:GetEntityId())
		end
	end

	return var_23_0
end

function var_0_0:GetNPCPosAndDir(arg_24_1)
	return self.NPCEntityList_[arg_24_1]:GetPosAndDir()
end

function var_0_0:CheckNPCIsActive(arg_25_1)
	if self.NPCEntityList_[arg_25_1] then
		return true
	else
		return false
	end
end

function var_0_0:GetNPCTypeAndPosList()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.NPCEntityList_) do
		local var_26_1 = {
			NPCtype = iter_26_1:GetNPCType()
		}
		local var_26_2, var_26_3 = iter_26_1:GetPosAndDir()

		var_26_1.Pos = var_26_2

		table.insert(var_26_0, var_26_1)
	end

	return var_26_0
end

function var_0_0:ClearNPCDebuff(arg_27_1)
	if self.NPCEntityList_[arg_27_1] then
		self.NPCEntityList_[arg_27_1].buffManager_:ClearDebuff()
	end
end

function var_0_0:GetMovingNPC()
	return self.curMovingNPC_
end

function var_0_0:Dispose()
	for iter_29_0, iter_29_1 in pairs(self.NPCEntityList_) do
		iter_29_1:Dispose()
	end

	self.NPCEntityList_ = {}
	self.curMovingNPC_ = -1
	self.waitingToMoveNPCList_ = {}
end

return var_0_0
