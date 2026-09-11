local var_0_0 = singletonClass("AutoChessBattleRenderer")

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.speed = 1
	arg_1_0.isForceSpeedUp = false
	arg_1_0.blackboard = arg_1_1
	arg_1_0.prepareView = nil
	arg_1_0.battleView = nil
	arg_1_0.playingActionRendererDic = {}
	arg_1_0.waitToClearActionRendererIdList = {}
	arg_1_0.finishedActionRendererIdDic = {}
	arg_1_0.playingRenderControllerDic = {}

	AutoChessActionRendererFactory.GetInstance():Init()
	AutoChessRenderControllerFactory.GetInstance():Init()
end

function var_0_0:Update()
	self.deltaTime = Time.deltaTime

	self:UpdateRenderController()
	self:UpdateActionRenderer()
	self:ClearFinishedActionRenderer()
end

function var_0_0:UpdateRenderController()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self.playingRenderControllerDic) do
		iter_3_1:Update(self.deltaTime)

		if iter_3_1:IsFinish() then
			var_3_0[#var_3_0 + 1] = iter_3_1.id
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		self.playingRenderControllerDic[iter_3_3] = nil

		if self.playingRenderControllerDic[iter_3_3] then
			self.playingRenderControllerDic[iter_3_3]:Reset()
			AutoChessRenderControllerFactory.GetInstance():RetureRenderController(self.playingRenderControllerDic[iter_3_3])
		end
	end
end

function var_0_0:UpdateActionRenderer()
	self.waitToClearActionRendererIdList = {}

	for iter_4_0, iter_4_1 in pairs(self.playingActionRendererDic) do
		if iter_4_1:IsRunning() then
			iter_4_1:Update(self.deltaTime)
		end

		if iter_4_1:IsFinish() then
			table.insert(self.waitToClearActionRendererIdList, iter_4_1.id)

			self.finishedActionRendererIdDic[iter_4_1.id] = true
		end
	end
end

function var_0_0:ClearFinishedActionRenderer()
	for iter_5_0, iter_5_1 in ipairs(self.waitToClearActionRendererIdList) do
		self.playingActionRendererDic[iter_5_1] = nil

		self.playingActionRendererDic[iter_5_1]:Reset()
		AutoChessActionRendererFactory.GetInstance():RetureActionRenderer(self.playingActionRendererDic[iter_5_1])
	end

	self.waitToClearActionRendererIdList = nil
end

function var_0_0:Stop()
	self:ClearActionRenderer()
	self:ClearRenderController()
end

function var_0_0:Dispose()
	self.prepareView = nil
	self.battleView = nil
	self.blackboard = nil

	self:ClearActionRenderer()
	self:ClearRenderController()
	AutoChessActionRendererFactory.GetInstance():Dispose()
	AutoChessRenderControllerFactory.GetInstance():Dispose()
end

function var_0_0:ClearActionRenderer()
	if self.playingActionRendererDic then
		for iter_8_0, iter_8_1 in pairs(self.playingActionRendererDic) do
			iter_8_1:Reset()
			AutoChessActionRendererFactory.GetInstance():RetureActionRenderer(iter_8_1)
		end
	end

	self.playingActionRendererDic = {}
	self.waitToClearActionRendererIdList = {}
	self.finishedActionRendererIdDic = {}
end

function var_0_0:ClearRenderController()
	for iter_9_0, iter_9_1 in pairs(self.playingRenderControllerDic) do
		iter_9_1:Reset()
		AutoChessRenderControllerFactory.GetInstance():RetureRenderController(iter_9_1)
	end

	self.playingRenderControllerDic = {}
end

function var_0_0.SetPrepareView(arg_10_0, arg_10_1)
	arg_10_0.prepareView = arg_10_1
end

function var_0_0:GetIsInPrepareView()
	return self.prepareView and not self.prepareView:GetIsExit()
end

function var_0_0.SetBattleView(arg_12_0, arg_12_1)
	arg_12_0.battleView = arg_12_1
end

function var_0_0:GetBattleView()
	return self.battleView
end

function var_0_0:GetPrepareView()
	return self.prepareView
end

function var_0_0:GetBlackboard()
	return self.blackboard
end

function var_0_0:GetChessItemByUniqueId(arg_16_1)
	if AutoChessTools.IsPrepareStatus(self.blackboard:GetGameStatus()) then
		return self.prepareView:GetChessItemByUniqueId(arg_16_1)
	else
		return self.battleView:GetChessItemByUniqueId(arg_16_1)
	end
end

function var_0_0:GetFormationItemByIndex(arg_17_1, arg_17_2)
	if AutoChessTools.IsPrepareStatus(self.blackboard:GetGameStatus()) then
		-- block empty
	else
		return self.battleView:GetFormationItemByIndex(arg_17_1, arg_17_2)
	end
end

function var_0_0:RemoveChessItemByUniqueId(arg_18_1)
	if AutoChessTools.IsPrepareStatus(self.blackboard:GetGameStatus()) then
		self.prepareView:RemoveChessItemByUniqueId(arg_18_1)
	else
		self.battleView:RemoveChessItemByUniqueId(arg_18_1)
	end
end

function var_0_0:GetShopItemByUniqueId(arg_19_1)
	return self.prepareView:GetShopItemByUniqueId(arg_19_1)
end

function var_0_0:CheckDeathWhisper(arg_20_1)
	if AutoChessTools.IsPrepareStatus(self.blackboard:GetGameStatus()) then
		-- block empty
	else
		return self.battleView:CheckDeathWhisper(arg_20_1)
	end
end

function var_0_0:IsRendererFinish(arg_21_1)
	return self.finishedActionRendererIdDic[arg_21_1] == true
end

function var_0_0:Pause()
	for iter_22_0, iter_22_1 in pairs(self.playingActionRendererDic) do
		if iter_22_1:IsRunning() and not iter_22_1:IsFinish() then
			iter_22_1:Pause()
		end
	end

	for iter_22_2, iter_22_3 in pairs(self.playingRenderControllerDic) do
		if iter_22_3:IsRunning() then
			iter_22_3:Pause()
		end
	end
end

function var_0_0:Resume()
	for iter_23_0, iter_23_1 in pairs(self.playingActionRendererDic) do
		if iter_23_1:IsPaused() then
			iter_23_1:Resume()
		end
	end

	for iter_23_2, iter_23_3 in pairs(self.playingRenderControllerDic) do
		if iter_23_3:IsPaused() then
			iter_23_3:Resume()
		end
	end
end

function var_0_0:SetSpeed(arg_24_1)
	if self.isForceSpeedUp then
		return
	end

	self.speed = arg_24_1

	for iter_24_0, iter_24_1 in pairs(self.playingActionRendererDic) do
		iter_24_1:SetSpeed(arg_24_1)
	end

	for iter_24_2, iter_24_3 in pairs(self.playingRenderControllerDic) do
		iter_24_3:SetSpeed(arg_24_1)
	end
end

function var_0_0:GetSpeed()
	return self.speed
end

function var_0_0.SetIsForceSpeedUp(arg_26_0, arg_26_1)
	arg_26_0.isForceSpeedUp = arg_26_1
end

function var_0_0:RenderAction(arg_27_1)
	local var_27_0 = AutoChessActionRendererFactory.GetInstance():GetActionRenderer(arg_27_1)

	self.playingActionRendererDic[var_27_0.id] = var_27_0
	self.finishedActionRendererIdDic[var_27_0.id] = false

	var_27_0:Play()

	return var_27_0.id
end

function var_0_0:RegistPlayingRenderController(arg_28_1)
	self.playingRenderControllerDic[arg_28_1.id] = arg_28_1
end

function var_0_0:GetBuffDamageEffectItem()
	return self.battleView:GetFreeDamageEffectItem()
end

return var_0_0
