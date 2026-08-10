local var_0_0 = class("WindowActivityMatrixCoinItem", import("game.extend.ReduxView"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.currencyType_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()
	arg_2_0:RefreshUI()

	arg_2_0.isCanAdd_ = true
	arg_2_0.isCanClick_ = false
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(nil, nil, "OnClick")
	arg_3_0:AddBtnListener(arg_3_0.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, arg_3_0.currencyType_, arg_3_0.gameObject_)
		arg_3_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_5_0)
	if arg_5_0.materialType_ then
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_5_0.materialType_
		})
	end
end

function var_0_0.SetCanAdd(arg_6_0, arg_6_1)
	if arg_6_0.isCanAdd_ == arg_6_1 then
		return
	end

	arg_6_0.isCanAdd_ = arg_6_1

	SetActive(arg_6_0.add_, arg_6_1)
end

function var_0_0.SetCanClick(arg_7_0, arg_7_1)
	arg_7_0.isCanClick_ = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.materialType_ = nil

	if arg_8_0.activity_id and ActivityCfg[arg_8_0.activity_id] then
		local var_8_0 = ActivityTools.GetActivityType(arg_8_0.activity_id)

		if var_8_0 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
			local var_8_1 = ActivityMatrixTools.GetCoinItem(arg_8_0.activity_id)

			arg_8_0.icon_.sprite = ItemTools.getItemLittleSprite(var_8_1)
			arg_8_0.text_.text = ActivityMatrixData:GetMatrixCoint(arg_8_0.activity_id)
			arg_8_0.materialType_ = var_8_1

			return
		elseif var_8_0 == ActivityTemplateConst.STRATEGY_MATRIX then
			local var_8_2 = StrategyMatrixTools.GetCoinItem(arg_8_0.activity_id)

			arg_8_0.icon_.sprite = ItemTools.getItemLittleSprite(var_8_2)
			arg_8_0.text_.text = StrategyMatrixData:GetMatrixCoint(arg_8_0.activity_id)
			arg_8_0.materialType_ = var_8_2

			return
		end
	end

	arg_8_0.icon_.sprite = nil
	arg_8_0.text_.text = ""
end

function var_0_0.SetActivityId(arg_9_0, arg_9_1)
	arg_9_0.activity_id = arg_9_1

	arg_9_0:RefreshUI()
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 then
		arg_10_0:RegistEventListener(ACTIVITY_MATRIX_PROCESS_CHANGE, handler(arg_10_0, arg_10_0.RefreshUI))
		arg_10_0:RefreshUI()
		arg_10_0.transform_:SetAsLastSibling()
	else
		arg_10_0:RemoveAllEventListener()
	end
end

function var_0_0.UnBindListener(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	arg_12_0.transform_ = nil
	arg_12_0.gameObject_ = nil
end

return var_0_0
