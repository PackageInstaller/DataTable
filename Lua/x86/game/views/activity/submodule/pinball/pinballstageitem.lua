local var_0_0 = class("PinballStageItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	arg_2_0:RemoveAllListeners()
	arg_2_0:RemoveAllEventListener()
end

local function var_0_1(arg_3_0, arg_3_1)
	arg_3_0[arg_3_1 .. "Controller"] = arg_3_0.controllers_:GetController(arg_3_1)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
	var_0_1(arg_4_0, "status")
	var_0_1(arg_4_0, "select")
	var_0_1(arg_4_0, "name")

	arg_4_0.conditions = PinballStageView.InitDetailConditionCom(arg_4_0, arg_4_0.conditionGo_)
end

function var_0_0.IsSelected(arg_5_0)
	return arg_5_0.selectController:GetSelectedState() ~= "false"
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index = arg_6_1
	arg_6_0.stage = arg_6_2

	arg_6_0:Refresh()
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0.index_.text = arg_7_0.index
	arg_7_0.stageName_.text = nullable(PinballStageCfg, arg_7_0.stage, "name") or ""

	arg_7_0:RefreshIcon()
	arg_7_0:RefreshLockState()

	local var_7_0 = PinballTools.StageRedPoint(arg_7_0.stage)

	manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, manager.redPoint:getTipBoolean(var_7_0))

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.conditions) do
		PinballTools.RefreshDetailConditionCom(iter_7_1, arg_7_0.stage, iter_7_0)
	end
end

function var_0_0.RefreshIcon(arg_8_0)
	local var_8_0 = PinballTools.GetBossIconPath(PinballStageCfg[arg_8_0.stage].monster_list[1])

	arg_8_0.icon_.spriteSync = var_8_0
	arg_8_0.iconShadowed_.spriteSync = var_8_0
end

function var_0_0.RefreshLockState(arg_9_0)
	local var_9_0 = PinballData:GetStageState(arg_9_0.stage)

	arg_9_0.statusController:SetSelectedState(var_9_0)
	arg_9_0:UpdateNameState(arg_9_0:IsSelected(), var_9_0 == "lock")
end

function var_0_0.UpdateNameState(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1 = arg_10_1 and (arg_10_2 and "selectlock" or "selectunlock") or arg_10_2 and "lock" or "unlock"

	arg_10_0.nameController:SetSelectedState(var_10_1)
end

function var_0_0.SetSelected(arg_11_0, arg_11_1)
	arg_11_0.selectController:SetSelectedState(arg_11_1 and "true" or "false")
	arg_11_0:UpdateNameState(arg_11_1, PinballData:GetStageState(arg_11_0.stage) == "lock")
end

function var_0_0.SetOnClick(arg_12_0, arg_12_1)
	arg_12_0.onClick = arg_12_1
end

function var_0_0.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.btn_, nil, function()
		if arg_13_0.onClick then
			arg_13_0:onClick()
		end

		PinballTools.MarkStageRedPointViewed(arg_13_0.stage)
		manager.redPoint:SetRedPointIndependent(arg_13_0.transform_, false)
	end)
end

return var_0_0
