local var_0_0 = class("SkinDrawInfoContentItemOld", ReduxView)

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

	arg_3_0.item_ = {}
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data_ = arg_5_1
	arg_5_0.activityID_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshTitle()
	arg_6_0:RefreshPool()
end

function var_0_0.RefreshTitle(arg_7_0)
	SetActive(arg_7_0.UpGo_, false)
	arg_7_0:Show(true)

	arg_7_0.labelTxt_.text = GetI18NText(arg_7_0.data_.name)
	arg_7_0.tips01.text = ""
	arg_7_0.tips02.text = ""
end

function var_0_0.RefreshPool(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.data_.list do
		if not arg_8_0.item_[iter_8_0] then
			local var_8_0 = Object.Instantiate(arg_8_0.infoItem_, arg_8_0.contentTrs_)

			arg_8_0.item_[iter_8_0] = SkinDrawInfoItemOld.New(var_8_0)
		end

		local var_8_1 = arg_8_0.data_.list[iter_8_0]
		local var_8_2 = ActivityLimitedDrawPoolCfg[var_8_1]
		local var_8_3 = ActivitySkinDrawDataOld:GetDrawInfo(arg_8_0.activityID_, var_8_1)
		local var_8_4 = var_8_2.total
		local var_8_5 = var_8_3 and var_8_3.num or var_8_4
		local var_8_6 = var_8_2.reward[1][1]
		local var_8_7 = var_8_2.reward[1][2]

		arg_8_0.item_[iter_8_0]:RefreshData(var_8_6, var_8_7)
		arg_8_0.item_[iter_8_0]:SetBottomText(var_8_5 .. "/" .. var_8_4)
	end

	for iter_8_1 = #arg_8_0.data_.list + 1, #arg_8_0.item_ do
		arg_8_0.item_[iter_8_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.contentTrs_)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.item_ do
		arg_10_0.item_[iter_10_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0 = 1, #arg_11_0.item_ do
		arg_11_0.item_[iter_11_0]:Dispose()
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
