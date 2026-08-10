local var_0_0 = class("GameKeyBindingContent", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.items_ = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	SetActive(arg_3_0.templateItem_, false)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.groupData_.items[arg_4_1]

	arg_4_2:SetData(arg_4_0.layoutName_, var_4_0, arg_4_0.gamepadType_, arg_4_0.controlType_)
	arg_4_2:RefreshUI()
	arg_4_2:SetKeyChangedCallback(function(arg_5_0, arg_5_1)
		arg_5_1.controlType = arg_4_0.groupData_.controlType
		arg_5_1.conflictGroup = arg_4_0.groupData_.conflictGroup

		if arg_4_0.onKeyChanged_ then
			arg_4_0.onKeyChanged_(arg_4_0, arg_5_0, arg_5_1)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.layoutName_ = arg_6_1
	arg_6_0.title_ = arg_6_2
	arg_6_0.groupData_ = arg_6_3
	arg_6_0.gamepadType_ = arg_6_4
	arg_6_0.controlType_ = arg_6_3.controlType
end

function var_0_0.SetKeyChangedCallback(arg_7_0, arg_7_1)
	arg_7_0.onKeyChanged_ = arg_7_1
end

function var_0_0.OnExit(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.items_) do
		iter_8_1:OnExit()
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items_) do
		iter_9_1:Dispose()
	end

	arg_9_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = #arg_10_0.groupData_.items

	SetActive(arg_10_0.gameObject_, var_10_0 ~= 0)

	if var_10_0 == 0 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.items_) do
		SetActive(iter_10_1.gameObject_, iter_10_0 <= var_10_0)
	end

	for iter_10_2 = 1, var_10_0 do
		local var_10_1 = arg_10_0.items_[iter_10_2]

		if not var_10_1 then
			local var_10_2 = Object.Instantiate(arg_10_0.templateItem_, arg_10_0.contentTrans_)

			SetActive(var_10_2, true)

			var_10_1 = GameKeyBindingItem.New(var_10_2)
			arg_10_0.items_[iter_10_2] = var_10_1
		end

		arg_10_0:IndexItem(iter_10_2, var_10_1)
	end
end

return var_0_0
