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

function var_0_0.Update(arg_2_0)
	arg_2_0.deltaTime = Time.deltaTime

	arg_2_0:UpdateRenderController()
	arg_2_0:UpdateActionRenderer()
	arg_2_0:ClearFinishedActionRenderer()
end

function var_0_0.UpdateRenderController(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.playingRenderControllerDic) do
		iter_3_1:Update(arg_3_0.deltaTime)

		if iter_3_1:IsFinish() then
			var_3_0[#var_3_0 + 1] = iter_3_1.id
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		arg_3_0.playingRenderControllerDic[iter_3_3] = nil

		local var_3_1 = arg_3_0.playingRenderControllerDic[iter_3_3]

		if var_3_1 then
			var_3_1:Reset()
			AutoChessRenderControllerFactory.GetInstance():RetureRenderController(var_3_1)
		end
	end
end

function var_0_0.UpdateActionRenderer(arg_4_0)
	arg_4_0.waitToClearActionRendererIdList = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.playingActionRendererDic) do
		if iter_4_1:IsRunning() then
			iter_4_1:Update(arg_4_0.deltaTime)
		end

		if iter_4_1:IsFinish() then
			table.insert(arg_4_0.waitToClearActionRendererIdList, iter_4_1.id)

			arg_4_0.finishedActionRendererIdDic[iter_4_1.id] = true
		end
	end
end

function var_0_0.ClearFinishedActionRenderer(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.waitToClearActionRendererIdList) do
		local var_5_0 = arg_5_0.playingActionRendererDic[iter_5_1]

		arg_5_0.playingActionRendererDic[iter_5_1] = nil

		var_5_0:Reset()
		AutoChessActionRendererFactory.GetInstance():RetureActionRenderer(var_5_0)
	end

	arg_5_0.waitToClearActionRendererIdList = nil
end

function var_0_0.Stop(arg_6_0)
	arg_6_0:ClearActionRenderer()
	arg_6_0:ClearRenderController()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.prepareView = nil
	arg_7_0.battleView = nil
	arg_7_0.blackboard = nil

	arg_7_0:ClearActionRenderer()
	arg_7_0:ClearRenderController()
	AutoChessActionRendererFactory.GetInstance():Dispose()
	AutoChessRenderControllerFactory.GetInstance():Dispose()
end

function var_0_0.ClearActionRenderer(arg_8_0)
	if arg_8_0.playingActionRendererDic then
		for iter_8_0, iter_8_1 in pairs(arg_8_0.playingActionRendererDic) do
			iter_8_1:Reset()
			AutoChessActionRendererFactory.GetInstance():RetureActionRenderer(iter_8_1)
		end
	end

	arg_8_0.playingActionRendererDic = {}
	arg_8_0.waitToClearActionRendererIdList = {}
	arg_8_0.finishedActionRendererIdDic = {}
end

function var_0_0.ClearRenderController(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.playingRenderControllerDic) do
		iter_9_1:Reset()
		AutoChessRenderControllerFactory.GetInstance():RetureRenderController(iter_9_1)
	end

	arg_9_0.playingRenderControllerDic = {}
end

function var_0_0.SetPrepareView(arg_10_0, arg_10_1)
	arg_10_0.prepareView = arg_10_1
end

function var_0_0.GetIsInPrepareView(arg_11_0)
	return arg_11_0.prepareView and not arg_11_0.prepareView:GetIsExit()
end

function var_0_0.SetBattleView(arg_12_0, arg_12_1)
	arg_12_0.battleView = arg_12_1
end

function var_0_0.GetBattleView(arg_13_0)
	return arg_13_0.battleView
end

function var_0_0.GetPrepareView(arg_14_0)
	return arg_14_0.prepareView
end

function var_0_0.GetBlackboard(arg_15_0)
	return arg_15_0.blackboard
end

function var_0_0.GetChessItemByUniqueId(arg_16_0, arg_16_1)
	if AutoChessTools.IsPrepareStatus(arg_16_0.blackboard:GetGameStatus()) then
		return arg_16_0.prepareView:GetChessItemByUniqueId(arg_16_1)
	else
		return arg_16_0.battleView:GetChessItemByUniqueId(arg_16_1)
	end
end

function var_0_0.GetFormationItemByIndex(arg_17_0, arg_17_1, arg_17_2)
	if AutoChessTools.IsPrepareStatus(arg_17_0.blackboard:GetGameStatus()) then
		-- block empty
	else
		return arg_17_0.battleView:GetFormationItemByIndex(arg_17_1, arg_17_2)
	end
end

function var_0_0.RemoveChessItemByUniqueId(arg_18_0, arg_18_1)
	if AutoChessTools.IsPrepareStatus(arg_18_0.blackboard:GetGameStatus()) then
		arg_18_0.prepareView:RemoveChessItemByUniqueId(arg_18_1)
	else
		arg_18_0.battleView:RemoveChessItemByUniqueId(arg_18_1)
	end
end

function var_0_0.GetShopItemByUniqueId(arg_19_0, arg_19_1)
	return arg_19_0.prepareView:GetShopItemByUniqueId(arg_19_1)
end

function var_0_0.CheckDeathWhisper(arg_20_0, arg_20_1)
	if AutoChessTools.IsPrepareStatus(arg_20_0.blackboard:GetGameStatus()) then
		-- block empty
	else
		return arg_20_0.battleView:CheckDeathWhisper(arg_20_1)
	end
end

function var_0_0.IsRendererFinish(arg_21_0, arg_21_1)
	return arg_21_0.finishedActionRendererIdDic[arg_21_1] == true
end

function var_0_0.Pause(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.playingActionRendererDic) do
		if iter_22_1:IsRunning() and not iter_22_1:IsFinish() then
			iter_22_1:Pause()
		end
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.playingRenderControllerDic) do
		if iter_22_3:IsRunning() then
			iter_22_3:Pause()
		end
	end
end

function var_0_0.Resume(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.playingActionRendererDic) do
		if iter_23_1:IsPaused() then
			iter_23_1:Resume()
		end
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.playingRenderControllerDic) do
		if iter_23_3:IsPaused() then
			iter_23_3:Resume()
		end
	end
end

function var_0_0.SetSpeed(arg_24_0, arg_24_1)
	if arg_24_0.isForceSpeedUp then
		return
	end

	arg_24_0.speed = arg_24_1

	for iter_24_0, iter_24_1 in pairs(arg_24_0.playingActionRendererDic) do
		iter_24_1:SetSpeed(arg_24_1)
	end

	for iter_24_2, iter_24_3 in pairs(arg_24_0.playingRenderControllerDic) do
		iter_24_3:SetSpeed(arg_24_1)
	end
end

function var_0_0.GetSpeed(arg_25_0)
	return arg_25_0.speed
end

function var_0_0.SetIsForceSpeedUp(arg_26_0, arg_26_1)
	arg_26_0.isForceSpeedUp = arg_26_1
end

function var_0_0.RenderAction(arg_27_0, arg_27_1)
	local var_27_0 = AutoChessActionRendererFactory.GetInstance():GetActionRenderer(arg_27_1)

	arg_27_0.playingActionRendererDic[var_27_0.id] = var_27_0
	arg_27_0.finishedActionRendererIdDic[var_27_0.id] = false

	var_27_0:Play()

	return var_27_0.id
end

function var_0_0.RegistPlayingRenderController(arg_28_0, arg_28_1)
	arg_28_0.playingRenderControllerDic[arg_28_1.id] = arg_28_1
end

function var_0_0.GetBuffDamageEffectItem(arg_29_0)
	return arg_29_0.battleView:GetFreeDamageEffectItem()
end

return var_0_0
