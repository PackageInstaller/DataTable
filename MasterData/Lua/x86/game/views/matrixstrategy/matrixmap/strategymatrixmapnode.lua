local StrategyMatrixMapNode = class("StrategyMatrixMapNode", ReduxView)

function StrategyMatrixMapNode:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.node_id = arg_1_2

	self:Init()
end

function StrategyMatrixMapNode:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrategyMatrixMapNode:InitUI()
	self:BindCfgUI()

	self.typeController = ControllerUtil.GetController(self.gameObject_.transform, "event")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function StrategyMatrixMapNode:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		local var_5_0 = self:GetMatrixPhaseData():GetPhase()

		if var_5_0 == 1 and StrategyMatrixConst.NODE_STATE.SELECT == self.state then
			if self.callback_ then
				self.callback_(self.node_id)
			end

			return
		end

		if var_5_0 == 2 and StrategyMatrixConst.NODE_STATE.CURRENT == self.state then
			if self.callback_ then
				self.callback_(self.node_id)
			end

			return
		end
	end)
end

function StrategyMatrixMapNode:SetData(arg_6_1, arg_6_2)
	self.matrix_activity_id = arg_6_1
	self.event_id = arg_6_2.event_id
	self.state = arg_6_2.state

	if StrategyMatrixEventTemplateCfg[self.event_id] then
		self.typeController:SetSelectedIndex(StrategyMatrixEventTemplateCfg[self.event_id].event_type - 1)

		self.m_name.text = GetI18NText(StrategyMatrixEventTemplateCfg[self.event_id].name)
	end

	self.stateController:SetSelectedIndex(self.state - 1)

	if StrategyMatrixConst.NODE_STATE.INVALID == self.state or StrategyMatrixConst.NODE_STATE.STATELESS == self.state then
		manager.effect:SetGrey(self.m_icon, true)
	else
		manager.effect:SetGrey(self.m_icon, false)
	end
end

function StrategyMatrixMapNode:SetSelect(arg_7_1)
	self.selectController:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function StrategyMatrixMapNode:GetNodeId()
	return self.node_id
end

function StrategyMatrixMapNode:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function StrategyMatrixMapNode:Dispose()
	StrategyMatrixMapNode.super.Dispose(self)
end

function StrategyMatrixMapNode:GetMatrixPhaseData()
	return StrategyMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

function StrategyMatrixMapNode:GetTierID()
	return StrategyMatrixData:GetTierID(self.matrix_activity_id)
end

return StrategyMatrixMapNode
