local var_0_0 = class("StrategyMatrixMapView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load("UI/StrategyMatrix/Map/StrategyMatrixMap_" .. arg_1_1)

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.mapId = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.node_list = {}

	local var_3_0 = StrategyMatrixMapCfg.get_id_list_by_map_id[arg_3_0.mapId] or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = arg_3_0.m_nodes:Find(tostring(iter_3_1))

		if var_3_1 == nil then
			print(iter_3_1)
		end

		local var_3_2 = StrategyMatrixMapNode.New(var_3_1, iter_3_1)

		var_3_2:RegistCallBack(handler(arg_3_0, arg_3_0.SetSelectNode))

		arg_3_0.node_list[iter_3_1] = var_3_2
	end

	arg_3_0.animator = arg_3_0:FindCom(typeof(Animator), "", arg_3_0.transform_)
end

function var_0_0.PlayerAnim(arg_4_0, arg_4_1)
	if not arg_4_0.animator then
		return
	end

	if arg_4_1 then
		arg_4_0.animator:Play("StrategyMatrixMap", 0, 0)
	else
		arg_4_0.animator:Play("StrategyMatrixMap", 0, 9999999)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		if arg_5_0:IsOpenSectionInfo() then
			arg_5_0:SetSelectNode(0)
			JumpTools.Back()
		end
	end)
	arg_5_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		if arg_5_0:IsOpenSectionInfo() then
			arg_5_0:SetSelectNode(0)
			JumpTools.Back()
		end
	end))
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.matrix_activity_id = arg_8_1

	local var_8_0
	local var_8_1 = StrategyMatrixData:GetNodeList(arg_8_0.matrix_activity_id)

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		arg_8_0.node_list[iter_8_0]:SetData(arg_8_0.matrix_activity_id, iter_8_1)
		arg_8_0.node_list[iter_8_0]:SetSelect(iter_8_0 == arg_8_0.selectNodeId)

		if iter_8_1.state == StrategyMatrixConst.NODE_STATE.CURRENT then
			var_8_0 = iter_8_0
		end
	end

	if arg_8_0.selectNodeId == nil or arg_8_0.selectNodeId == 0 then
		arg_8_0.selectNodeId = var_8_0
	end

	if arg_8_0.selectNodeId and arg_8_0.selectNodeId ~= 0 then
		local var_8_2 = arg_8_0:GetPosition(arg_8_0.selectNodeId)

		arg_8_0.m_scrollContent.localPosition = Vector3(var_8_2, 0, 0)

		if arg_8_0:IsOpenSectionInfo() then
			arg_8_0.m_scrollCom.horizontal = false
		else
			arg_8_0.m_scrollCom.horizontal = true
		end
	else
		arg_8_0:SetSelectNode(0)

		arg_8_0.m_scrollContent.localPosition = Vector3(0, 0, 0)
	end
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:SetSelectNode(0)
end

function var_0_0.GoBack(arg_10_0)
	if arg_10_0:IsOpenSectionInfo() then
		arg_10_0:SetSelectNode(0)
	end

	JumpTools.Back()
end

function var_0_0.Exit(arg_11_0)
	arg_11_0:RemoveTween()
end

function var_0_0.GetMapId(arg_12_0)
	return arg_12_0.mapId
end

function var_0_0.SetSelectNode(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == nil then
		arg_13_2 = true
	end

	if arg_13_1 == arg_13_0.selectNodeId then
		arg_13_2 = false
	end

	arg_13_0.selectNodeId = arg_13_1

	if arg_13_0.node_list[arg_13_1] then
		local var_13_0 = arg_13_0:GetPosition(arg_13_1)

		arg_13_0.m_scrollCom.horizontal = false

		arg_13_0:RemoveTween()

		if arg_13_2 then
			arg_13_0.tween_ = LeanTween.value(arg_13_0.m_scrollContent.gameObject, arg_13_0.m_scrollContent.localPosition.x, var_13_0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
				arg_13_0.m_scrollContent.localPosition = Vector3(arg_14_0, 0, 0)
			end))
		else
			arg_13_0.m_scrollContent.localPosition = Vector3(var_13_0, 0, 0)
		end
	else
		arg_13_0.m_scrollCom.horizontal = true
	end

	if arg_13_0.selectNodeId ~= 0 then
		arg_13_0:Go("strategyMatrixInfo", {
			nodeId = arg_13_0.selectNodeId,
			matrix_activity_id = arg_13_0.matrix_activity_id
		})
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.node_list) do
		local var_13_1 = iter_13_1:GetNodeId()

		iter_13_1:SetSelect(var_13_1 == arg_13_0.selectNodeId)
	end
end

function var_0_0.GetPosition(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.node_list[arg_15_1]

	if var_15_0 then
		local var_15_1 = var_15_0.transform_.localPosition

		return arg_15_0.m_scrollView.rect.width / 2 - (arg_15_0.m_scrollContent.rect.width / 2 + var_15_1.x)
	else
		return 0
	end
end

function var_0_0.RemoveTween(arg_16_0)
	if arg_16_0.tween_ then
		arg_16_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_16_0.m_scrollContent.gameObject)

		arg_16_0.tween_ = nil
	end
end

function var_0_0.IsOpenSectionInfo(arg_17_0)
	return arg_17_0:IsOpenRoute("strategyMatrixInfo")
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.node_list) do
		iter_18_1:Dispose()
	end

	arg_18_0.m_scrollEvent:RemoveAllListeners()
	var_0_0.super.Dispose(arg_18_0)

	if not isNil(arg_18_0.gameObject_) then
		Object.Destroy(arg_18_0.gameObject_)

		arg_18_0.gameObject_ = nil
		arg_18_0.transform_ = nil
	end
end

function var_0_0.GoBack(arg_19_0)
	arg_19_0:Back()
end

return var_0_0
