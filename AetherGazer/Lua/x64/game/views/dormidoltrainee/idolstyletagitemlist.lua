local var_0_0 = class("IdolStyleTagItemList", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.styleUIList = {}

	for iter_2_0, iter_2_1 in pairs(IdolTraineeConst.style) do
		local var_2_0 = Object.Instantiate(arg_2_0.styleTag_, arg_2_0.styleTagListContent_)
		local var_2_1 = EnterBattleStyleListItem.New(var_2_0)

		var_2_1:SetData(iter_2_0)

		arg_2_0.styleUIList[iter_2_0] = var_2_1
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.styleUIList) do
		SetActive(iter_3_1.gameObject_, false)
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_1) do
		local var_3_0 = arg_3_0.styleUIList[iter_3_3]

		if var_3_0 then
			SetActive(var_3_0.gameObject_, true)
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.styleUIList) do
		iter_4_1:Dispose()
	end

	arg_4_0.styleUIList = nil
end

return var_0_0
