local var_0_0 = class("TagViewPanel", ReduxView)

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

	arg_3_0.tagItem_ = {}
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.RefreshData(arg_6_0, arg_6_1)
	arg_6_0.list_ = arg_6_1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.list_) do
		if not arg_6_0.tagItem_[iter_6_0] then
			local var_6_0 = Object.Instantiate(arg_6_0.tagTemplate_, arg_6_0.transform_)

			arg_6_0.tagItem_[iter_6_0] = TagItem.New(var_6_0)

			arg_6_0.tagItem_[iter_6_0]:RegisterClickFunction(function(arg_7_0)
				if arg_6_0.callback_ then
					arg_6_0.callback_(arg_7_0)
				end
			end)
		end

		arg_6_0.tagItem_[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #arg_6_0.list_ + 1, #arg_6_0.tagItem_ do
		arg_6_0.tagItem_[iter_6_2]:Show(false)
	end
end

function var_0_0.RefreshSelect(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tagItem_) do
		iter_8_1:RefreshSelect(arg_8_1[iter_8_1.id_] == true)
	end
end

function var_0_0.RegisterClickFunction(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.tagItem_) do
		iter_10_1:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllEventListener()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.tagItem_) do
		iter_11_1:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
