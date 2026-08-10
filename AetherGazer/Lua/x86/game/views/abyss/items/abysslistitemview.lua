local var_0_0 = class("AbyssListItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.status2Controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status2")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.onClick_ ~= nil then
			arg_4_0.onClick_(arg_4_0.layer_)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.index_ = arg_7_1
	arg_7_0.onClick_ = arg_7_3
	arg_7_0.cfg_ = AbyssCfg[arg_7_2]
	arg_7_0.layer_ = arg_7_0.cfg_.level

	arg_7_0:UpdateView()
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	arg_8_0.statusController_:SetSelectedState(arg_8_1 and "Select" or "normal")
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.scoreLabel_.text = AbyssData:GetLayerScore(arg_9_0.layer_)
	arg_9_0.layerLabel_.text = string.format(GetTips("ABYSS_LAYER_LABEL"), arg_9_0.layer_)

	local var_9_0 = AbyssData:GetLayerStatus(arg_9_0.layer_)

	if var_9_0 == 0 then
		arg_9_0.status2Controller_:SetSelectedState("lock")
	elseif var_9_0 == 1 then
		arg_9_0.status2Controller_:SetSelectedState("normal")
	elseif var_9_0 == 2 then
		arg_9_0.status2Controller_:SetSelectedState("Challenge")
	else
		arg_9_0.status2Controller_:SetSelectedState("Select")
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.data_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
