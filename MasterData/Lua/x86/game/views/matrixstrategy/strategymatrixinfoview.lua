local StrategyMatrixInfoView = class("StrategyMatrixInfoView", ReduxView)

function StrategyMatrixInfoView:UIName()
	return "Widget/System/MatrixlUI/StrategyMatrixInfoUI"
end

function StrategyMatrixInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function StrategyMatrixInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrategyMatrixInfoView:InitUI()
	self:BindCfgUI()
end

function StrategyMatrixInfoView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		self:OnEventAction()
	end)
end

function StrategyMatrixInfoView:OnEnter()
	self.nodeId = self.params_.nodeId
	self.matrix_activity_id = self.params_.matrix_activity_id

	self:RefreshUI()
end

function StrategyMatrixInfoView:OnUpdate()
	self.nodeId = self.params_.nodeId
	self.matrix_activity_id = self.params_.matrix_activity_id

	self:RefreshUI()
end

function StrategyMatrixInfoView:RefreshUI()
	local var_9_0 = StrategyMatrixData:GetNodeList(self.matrix_activity_id)[self.nodeId]

	if var_9_0 then
		self.m_name.text = GetI18NText(StrategyMatrixEventTemplateCfg[var_9_0.event_id].name)
		self.m_info.text = GetI18NText(StrategyMatrixEventTemplateCfg[var_9_0.event_id].op_info)

		SetSpriteWithoutAtlasAsync(self.m_bg, SpritePathCfg.Stage.path .. StrategyMatrixEventTemplateCfg[var_9_0.event_id].op_bg)
	end
end

function StrategyMatrixInfoView:Check(arg_10_1)
	local var_10_0 = self:GetMatrixPhaseData():GetPhase()

	if var_10_0 == 1 and StrategyMatrixConst.NODE_STATE.SELECT == arg_10_1 then
		return true
	end

	if var_10_0 == 2 and StrategyMatrixConst.NODE_STATE.CURRENT == arg_10_1 then
		return true
	end

	return false
end

function StrategyMatrixInfoView:OnEventAction()
	local var_11_0 = StrategyMatrixData:GetNodeList(self.matrix_activity_id)[self.nodeId]

	if not var_11_0 then
		return
	end

	if not self:Check(var_11_0.state) then
		return
	end

	local var_11_1 = var_11_0.event_id

	if not StrategyMatrixEventTemplateCfg[var_11_0.event_id] then
		return
	end

	if MatrixConst.EVENT_TYPE.SHOP == StrategyMatrixEventTemplateCfg[var_11_0.event_id].event_type or MatrixConst.EVENT_TYPE.INCIDENT == StrategyMatrixEventTemplateCfg[var_11_0.event_id].event_type then
		if self:GetMatrixPhaseData():GetPhase() == 2 then
			StrategyMatrixAction.DoEvent(self.matrix_activity_id)
		else
			StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
				self.nodeId
			})
		end
	else
		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = 0,
			sectionType = BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX,
			eventId = var_11_1,
			matrix_activity_id = self.matrix_activity_id,
			activityID = self.matrix_activity_id,
			nodeId = self.nodeId,
			heroDataType = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX
		})
	end
end

function StrategyMatrixInfoView:Dispose()
	StrategyMatrixInfoView.super.Dispose(self)
end

function StrategyMatrixInfoView:GetMatrixPhaseData()
	return StrategyMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

return StrategyMatrixInfoView
