local StrategyMatrixMapView = class("StrategyMatrixMapView", ReduxView)

function StrategyMatrixMapView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/StrategyMatrix/Map/StrategyMatrixMap_" .. arg_1_1), arg_1_2)
	self.transform_ = self.gameObject_.transform
	self.mapId = arg_1_1

	self:Init()
end

function StrategyMatrixMapView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrategyMatrixMapView:InitUI()
	self:BindCfgUI()

	self.node_list = {}

	for iter_3_0, iter_3_1 in ipairs(StrategyMatrixMapCfg.get_id_list_by_map_id[self.mapId] or {}) do
		local var_3_0 = self.m_nodes:Find(tostring(iter_3_1))

		if var_3_0 == nil then
			print(iter_3_1)
		end

		local var_3_1 = StrategyMatrixMapNode.New(var_3_0, iter_3_1)

		var_3_1:RegistCallBack(handler(self, self.SetSelectNode))

		self.node_list[iter_3_1] = var_3_1
	end

	self.animator = self:FindCom(typeof(Animator), "", self.transform_)
end

function StrategyMatrixMapView:PlayerAnim(arg_4_1)
	if not self.animator then
		return
	end

	if arg_4_1 then
		self.animator:Play("StrategyMatrixMap", 0, 0)
	else
		self.animator:Play("StrategyMatrixMap", 0, 9999999)
	end
end

function StrategyMatrixMapView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		if self:IsOpenSectionInfo() then
			self:SetSelectNode(0)
			JumpTools.Back()
		end
	end)
	self.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		if self:IsOpenSectionInfo() then
			self:SetSelectNode(0)
			JumpTools.Back()
		end
	end))
end

function StrategyMatrixMapView:SetData(arg_8_1)
	self.matrix_activity_id = arg_8_1

	local var_8_0

	for iter_8_0, iter_8_1 in pairs((StrategyMatrixData:GetNodeList(self.matrix_activity_id))) do
		self.node_list[iter_8_0]:SetData(self.matrix_activity_id, iter_8_1)
		self.node_list[iter_8_0]:SetSelect(iter_8_0 == self.selectNodeId)

		if iter_8_1.state == StrategyMatrixConst.NODE_STATE.CURRENT then
			var_8_0 = iter_8_0
		end
	end

	if self.selectNodeId == nil or self.selectNodeId == 0 then
		self.selectNodeId = var_8_0
	end

	if self.selectNodeId and self.selectNodeId ~= 0 then
		self.m_scrollContent.localPosition = Vector3(self:GetPosition(self.selectNodeId), 0, 0)
		self.m_scrollCom.horizontal = not self:IsOpenSectionInfo()
	else
		self:SetSelectNode(0)

		self.m_scrollContent.localPosition = Vector3(0, 0, 0)
	end
end

function StrategyMatrixMapView:OnTop()
	self:SetSelectNode(0)
end

function StrategyMatrixMapView:GoBack()
	if self:IsOpenSectionInfo() then
		self:SetSelectNode(0)
	end

	JumpTools.Back()
end

function StrategyMatrixMapView:Exit()
	self:RemoveTween()
end

function StrategyMatrixMapView:GetMapId()
	return self.mapId
end

function StrategyMatrixMapView:SetSelectNode(arg_13_1, arg_13_2)
	if arg_13_2 == nil then
		arg_13_2 = true
	end

	if arg_13_1 == self.selectNodeId then
		arg_13_2 = false
	end

	self.selectNodeId = arg_13_1

	if self.node_list[arg_13_1] then
		local var_13_0 = self:GetPosition(arg_13_1)

		self.m_scrollCom.horizontal = false

		self:RemoveTween()

		if arg_13_2 then
			self.tween_ = LeanTween.value(self.m_scrollContent.gameObject, self.m_scrollContent.localPosition.x, var_13_0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
				self.m_scrollContent.localPosition = Vector3(arg_14_0, 0, 0)
			end))
		else
			self.m_scrollContent.localPosition = Vector3(var_13_0, 0, 0)
		end
	else
		self.m_scrollCom.horizontal = true
	end

	if self.selectNodeId ~= 0 then
		self:Go("strategyMatrixInfo", {
			nodeId = self.selectNodeId,
			matrix_activity_id = self.matrix_activity_id
		})
	end

	for iter_13_0, iter_13_1 in pairs(self.node_list) do
		iter_13_1:SetSelect(iter_13_1:GetNodeId() == self.selectNodeId)
	end
end

function StrategyMatrixMapView:GetPosition(arg_15_1)
	if self.node_list[arg_15_1] then
		return self.m_scrollView.rect.width / 2 - (self.m_scrollContent.rect.width / 2 + self.node_list[arg_15_1].transform_.localPosition.x)
	else
		return 0
	end
end

function StrategyMatrixMapView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent.gameObject)

		self.tween_ = nil
	end
end

function StrategyMatrixMapView:IsOpenSectionInfo()
	return self:IsOpenRoute("strategyMatrixInfo")
end

function StrategyMatrixMapView:Dispose()
	for iter_18_0, iter_18_1 in ipairs(self.node_list) do
		iter_18_1:Dispose()
	end

	self.m_scrollEvent:RemoveAllListeners()
	StrategyMatrixMapView.super.Dispose(self)

	if not isNil(self.gameObject_) then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil
	end
end

function StrategyMatrixMapView:GoBack()
	self:Back()
end

return StrategyMatrixMapView
