local var_0_0 = class("LuaSlider", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	if not arg_1_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_1_0)
	end

	arg_1_0.ctored_ = true
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:Reset()
end

function var_0_0.Reset(arg_3_0)
	arg_3_0.useNumSlider_.value = 1
	arg_3_0.selectNum_ = 1
end

function var_0_0.InitUI(arg_4_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_4_0, arg_4_0.gameObject_)

	arg_4_0.inputTypeController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "inputType")
	arg_4_0.useNumTriggerListener_ = arg_4_0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	arg_4_0.inputField_ = arg_4_0.numInputGo_:GetComponent("Input")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddPressingByTimeListener(arg_5_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.selectNum_ < arg_5_0:GetMaxBuyNum() then
			arg_5_0.selectNum_ = arg_5_0.selectNum_ + 1

			arg_5_0:RefreshNum()
			arg_5_0:UpdateSliderPosition()

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.selectNum_ > 1 then
			arg_5_0.selectNum_ = arg_5_0.selectNum_ - 1

			arg_5_0:RefreshNum()
			arg_5_0:UpdateSliderPosition()

			return true
		end

		return false
	end)
	arg_5_0.useNumSlider_.onValueChanged:AddListener(function()
		arg_5_0.selectNum_ = arg_5_0.useNumSlider_.value

		if arg_5_0.selectNum_ < 1 then
			arg_5_0.selectNum_ = 1

			arg_5_0:UpdateSliderPositionBySelectNum()
		elseif arg_5_0.selectNum_ > arg_5_0:GetMaxBuyNum() then
			arg_5_0.selectNum_ = arg_5_0:GetMaxBuyNum()
		end

		arg_5_0:RefreshNum()
	end)
	arg_5_0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		arg_5_0:RefreshNum()
		arg_5_0:UpdateSliderPosition()
		OperationRecorder.Record("shop", "shop_number_slide")
	end))
end

function var_0_0.SetNumChangeHandler(arg_10_0, arg_10_1)
	arg_10_0.numChangeHandler_ = arg_10_1
end

function var_0_0.SetData(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 < arg_11_1 then
		arg_11_2 = arg_11_1
	end

	arg_11_0.min_ = arg_11_1
	arg_11_0.max_ = arg_11_2
	arg_11_0.useNumSlider_.minValue = arg_11_1
	arg_11_0.useNumSlider_.maxValue = arg_11_2

	arg_11_0:UpdateSliderPosition()
	arg_11_0:RefreshNum()
	arg_11_0:UpdateSliderPositionBySelectNum()
end

function var_0_0.UpdateSliderPositionBySelectNum(arg_12_0)
	arg_12_0.useNumSlider_.value = arg_12_0.selectNum_
end

function var_0_0.RefreshNum(arg_13_0)
	local var_13_0 = arg_13_0:GetMaxBuyNum()

	if var_13_0 <= arg_13_0.selectNum_ then
		arg_13_0:SetBtnEnable(arg_13_0.addBtn_, false)
	else
		arg_13_0:SetBtnEnable(arg_13_0.addBtn_, true)
	end

	if arg_13_0.selectNum_ <= 1 then
		arg_13_0:SetBtnEnable(arg_13_0.delBtn_, false)
	else
		arg_13_0:SetBtnEnable(arg_13_0.delBtn_, true)
	end

	if var_13_0 == 1 then
		arg_13_0.useNumSlider_.minValue = 0
	else
		arg_13_0.useNumSlider_.minValue = 1
	end

	if arg_13_0.numChangeHandler_ ~= nil then
		arg_13_0.numChangeHandler_(arg_13_0.selectNum_)
	end
end

function var_0_0.UpdateSliderPosition(arg_14_0)
	arg_14_0.useNumSlider_.value = arg_14_0.selectNum_
end

function var_0_0.GetMaxBuyNum(arg_15_0)
	return arg_15_0.max_
end

function var_0_0.AddEventListeners(arg_16_0)
	return
end

function var_0_0.UpdateBar(arg_17_0)
	return
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:AddEventListeners()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_20_0)
	return
end

function var_0_0.GetSelectedNum(arg_21_0)
	return arg_21_0.selectNum_
end

function var_0_0.SetBtnEnable(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1.interactable = arg_22_2
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.useNumSlider_.onValueChanged:RemoveAllListeners()
	arg_23_0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	var_0_0.super.Dispose(arg_23_0)
	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_23_0)
end

return var_0_0
