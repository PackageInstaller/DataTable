local var_0_0 = class("StrategyMatrixInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MatrixlUI/StrategyMatrixInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_btn, nil, function()
		arg_5_0:OnEventAction()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.nodeId = arg_7_0.params_.nodeId
	arg_7_0.matrix_activity_id = arg_7_0.params_.matrix_activity_id

	arg_7_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_8_0)
	arg_8_0.nodeId = arg_8_0.params_.nodeId
	arg_8_0.matrix_activity_id = arg_8_0.params_.matrix_activity_id

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = StrategyMatrixData:GetNodeList(arg_9_0.matrix_activity_id)[arg_9_0.nodeId]

	if var_9_0 then
		local var_9_1 = var_9_0.event_id
		local var_9_2 = StrategyMatrixEventTemplateCfg[var_9_1]

		arg_9_0.m_name.text = GetI18NText(var_9_2.name)
		arg_9_0.m_info.text = GetI18NText(var_9_2.op_info)

		SetSpriteWithoutAtlasAsync(arg_9_0.m_bg, SpritePathCfg.Stage.path .. var_9_2.op_bg)
	end
end

function var_0_0.Check(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetMatrixPhaseData():GetPhase()

	if var_10_0 == 1 and StrategyMatrixConst.NODE_STATE.SELECT == arg_10_1 then
		return true
	end

	if var_10_0 == 2 and StrategyMatrixConst.NODE_STATE.CURRENT == arg_10_1 then
		return true
	end

	return false
end

function var_0_0.OnEventAction(arg_11_0)
	local var_11_0 = StrategyMatrixData:GetNodeList(arg_11_0.matrix_activity_id)[arg_11_0.nodeId]

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0.state

	if not arg_11_0:Check(var_11_1) then
		return
	end

	local var_11_2 = var_11_0.event_id
	local var_11_3 = StrategyMatrixEventTemplateCfg[var_11_2]

	if not var_11_3 then
		return
	end

	local var_11_4 = arg_11_0:GetMatrixPhaseData():GetPhase()

	if MatrixConst.EVENT_TYPE.SHOP == var_11_3.event_type or MatrixConst.EVENT_TYPE.INCIDENT == var_11_3.event_type then
		if var_11_4 == 2 then
			StrategyMatrixAction.DoEvent(arg_11_0.matrix_activity_id)
		else
			StrategyMatrixAction.QueryNextProgress(arg_11_0.matrix_activity_id, {
				arg_11_0.nodeId
			})
		end
	else
		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = 0,
			sectionType = BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX,
			eventId = var_11_2,
			matrix_activity_id = arg_11_0.matrix_activity_id,
			activityID = arg_11_0.matrix_activity_id,
			nodeId = arg_11_0.nodeId,
			heroDataType = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX
		})
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.GetMatrixPhaseData(arg_13_0)
	return StrategyMatrixData:GetMatrixPhaseData(arg_13_0.matrix_activity_id)
end

return var_0_0
