local var_0_0 = class("ShelfEditItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.levelBgController = ControllerUtil.GetController(arg_2_0.transform_, "itembglevel")
	arg_2_0.selectController = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	local var_3_0 = arg_3_0:FindCom("EventTriggerListener")

	function var_3_0.onPointerDown(arg_4_0, arg_4_1)
		arg_3_0:OnPointerDown(arg_4_0, arg_4_1)
	end

	function var_3_0.onBeginDrag(arg_5_0, arg_5_1)
		arg_3_0:BeginDrag(arg_5_1)
	end

	function var_3_0.onEndDrag(arg_6_0, arg_6_1)
		arg_3_0:EndDrag(arg_6_1)
	end

	function var_3_0.onDrag(arg_7_0, arg_7_1)
		arg_3_0:Drag(arg_7_1)
	end

	arg_3_0:SetListener(var_3_0)
	arg_3_0:AddBtnListener(arg_3_0.infoBtn, nil, function()
		if arg_3_0.itemInfoFunc then
			arg_3_0.itemInfoFunc(arg_3_0.id)
		end
	end)
end

local function var_0_1(arg_9_0)
	local var_9_0 = SimBusinessTools.GetShelfOverrideLevel(arg_9_0)

	return var_9_0 or SimBusinessData:GetShelfLevel(arg_9_0), var_9_0 ~= nil
end

function var_0_0.GetShelfCostText(arg_10_0)
	local var_10_0 = SimBusinessShelfCfg[arg_10_0.cfgID].cost

	if SimBusinessTools.CheckDeployNewShelfCostOver(arg_10_0.cfgID) then
		return "<color=#FF0000>" .. var_10_0 .. "</color>"
	end

	return var_10_0
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.parentView = arg_11_1

	local var_11_0 = arg_11_1.dataList[arg_11_2]

	arg_11_0.cfgID = var_11_0
	arg_11_0.idx = arg_11_2

	arg_11_0.selectController:SetSelectedState(arg_11_1.selIndex == arg_11_2 and "select" or "normal")

	arg_11_0.cfg = SimBusinessShelfCfg[var_11_0]

	if arg_11_0.cfg then
		arg_11_0:RefreshAvailable()

		arg_11_0.name_.text = arg_11_0.cfg.name
		arg_11_0.cost_.text = arg_11_0:GetShelfCostText(var_11_0)
		arg_11_0.costCoinIcon_.sprite = SimBusinessTools.GetCoinIcon()
		arg_11_0.icon_.sprite = SimBusinessTools.GetShelfIcon(var_11_0)
		arg_11_0.level = var_0_1(var_11_0)

		arg_11_0.levelBgController:SetSelectedState(arg_11_0.level)
	else
		Debug.LogError("货柜" .. var_11_0 .. "在activity_sim_business_shelf表内未找到")
	end
end

function var_0_0.RefreshAvailable(arg_12_0)
	local var_12_0 = arg_12_0:IsAvailable()

	arg_12_0.stateController:SetSelectedState(var_12_0 and "normal" or "gray")
end

function var_0_0.IsAvailable(arg_13_0)
	return not SimBusinessTools.CheckDeployNewShelfCostOver(arg_13_0.cfgID)
end

function var_0_0.OnPointerDown(arg_14_0, arg_14_1)
	arg_14_0.parentView:OnShelfItemPointerDown(arg_14_1, arg_14_0)
end

function var_0_0.BeginDrag(arg_15_0, arg_15_1)
	arg_15_0.parentView:OnShelfItemBeginDrag(arg_15_1, arg_15_0)
end

function var_0_0.Drag(arg_16_0, arg_16_1)
	arg_16_0.parentView:OnShelfItemDrag(arg_16_1, arg_16_0)
end

function var_0_0.EndDrag(arg_17_0, arg_17_1)
	arg_17_0.parentView:OnShelfItemEndDrag(arg_17_1, arg_17_0)
end

return var_0_0
