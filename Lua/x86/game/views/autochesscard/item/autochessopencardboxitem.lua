local var_0_0 = class("AutoChessOpenCardBoxItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.normalItem_ = AutoChessOpenCardBoxBaseItem.New(arg_3_0.go_)
	arg_3_0.URItem_ = AutoChessOpenCardBoxBaseItem.New(arg_3_0.urGo_)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.item_ = nil

	if arg_5_1 then
		arg_5_0.URItem_:SetActive(true)
		arg_5_0.normalItem_:SetActive(false)

		arg_5_0.item_ = arg_5_0.URItem_
	else
		arg_5_0.URItem_:SetActive(false)
		arg_5_0.normalItem_:SetActive(true)

		arg_5_0.item_ = arg_5_0.normalItem_
	end
end

function var_0_0.SetGuideState(arg_6_0, arg_6_1)
	if arg_6_0.item_ then
		arg_6_0.item_:SetGuideState(arg_6_1)
	end
end

function var_0_0.PlayAnim(arg_7_0, arg_7_1)
	if arg_7_0.item_ then
		arg_7_0.item_:PlayAnim(arg_7_1)
	end
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetLightState(arg_9_0, arg_9_1)
	arg_9_0.URItem_:SetLightState(arg_9_1)
	arg_9_0.normalItem_:SetLightState(arg_9_1)
end

function var_0_0.OnExit(arg_10_0)
	if arg_10_0.item_ then
		arg_10_0.item_:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.normalItem_:Dispose()
	arg_11_0.URItem_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
