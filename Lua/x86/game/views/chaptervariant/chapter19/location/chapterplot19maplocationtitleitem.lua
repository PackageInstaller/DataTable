local var_0_0 = class("ChapterPlot19MapLocationTitileItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
end

function var_0_0.Show(arg_2_0, arg_2_1)
	SetActive(arg_2_0.gameObject_, arg_2_1)

	if arg_2_1 then
		arg_2_0.transform_:SetAsLastSibling()
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
