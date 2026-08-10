local var_0_0 = class("NewHeroBreakMaterialItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.enoughController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "enough")
	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.gameObject_)
end

function var_0_0.SetInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.materialId_ = arg_4_1
	arg_4_0.count_ = arg_4_2

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	local var_5_0 = arg_5_0.commonItem_:GetData()

	arg_5_0.data = clone(ItemTemplateData)

	function arg_5_0.data.clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_5_0.materialId_,
			arg_5_0.count_
		})
	end

	arg_5_0.data.id = arg_5_0.materialId_
	arg_5_0.data.number = arg_5_0.count_

	arg_5_0.commonItem_:SetData(arg_5_0.data)

	local var_5_1 = ItemTools.getItemNum(arg_5_0.materialId_)

	arg_5_0.commonItem_:RefreshBottomText({
		var_5_1,
		arg_5_0.count_
	})
end

function var_0_0.IsEnough(arg_7_0)
	return ItemTools.getItemNum(arg_7_0.materialId_) >= arg_7_0.count_
end

function var_0_0.GetMaterialId(arg_8_0)
	return arg_8_0.materialId_
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	if arg_9_0.commonItem_ then
		arg_9_0.commonItem_:Dispose()

		arg_9_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
