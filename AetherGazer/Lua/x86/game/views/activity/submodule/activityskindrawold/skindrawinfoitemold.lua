local var_0_0 = class("SkinDrawInfoItemOld", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.commonItemGo_, true)
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:Show(true)

	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = arg_5_1
	var_5_0.number = arg_5_2
	var_5_0.bottomText = arg_5_2

	function var_5_0.clickFun(arg_6_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_6_0.id,
			arg_6_0.number
		})
	end

	arg_5_0.commonItem_:SetData(var_5_0)
end

function var_0_0.SetBottomText(arg_7_0, arg_7_1)
	arg_7_0.text_.text = arg_7_1
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.commonItem_:OnExit()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.commonItem_:Dispose()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
