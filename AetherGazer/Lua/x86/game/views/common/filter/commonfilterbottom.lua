local var_0_0 = class("CommonFilterBottom", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.emptyController_ = arg_3_0.emptyCon_:GetController("empty")
	arg_3_0.filterItmeList_ = {}
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.filterInfoList_ = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.filterInfoList_) do
		local var_4_0 = arg_4_0.filterItmeList_[iter_4_0]

		if var_4_0 == nil then
			local var_4_1 = Object.Instantiate(arg_4_0.filterItemGo_, arg_4_0.filterContent_)

			var_4_0 = CommonFilterBottomItem.New(var_4_1)

			var_4_0:RegistCallBack(function(arg_5_0)
				if arg_4_0.itemClickCallback then
					arg_4_0.itemClickCallback(arg_5_0)
				end
			end)

			arg_4_0.filterItmeList_[iter_4_0] = var_4_0
		end

		var_4_0:Refresh(iter_4_1)
	end

	for iter_4_2 = #arg_4_0.filterInfoList_ + 1, #arg_4_0.filterItmeList_ do
		SetActive(arg_4_0.filterItmeList_[iter_4_2].gameObject_, false)
	end

	local var_4_2 = #arg_4_0.filterInfoList_ == 0

	arg_4_0.emptyController_:SetSelectedState(tostring(var_4_2))
	SetActive(arg_4_0.gameObject_, not var_4_2)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.clearBtn_, nil, function()
		local var_7_0 = arg_6_0.clearCallback

		if var_7_0 then
			var_7_0()
		end
	end)
end

function var_0_0.RegisteClearBtnListener(arg_8_0, arg_8_1)
	if not arg_8_0.clearCallback then
		arg_8_0.clearCallback = arg_8_1
	end
end

function var_0_0.RegisteItemClickListener(arg_9_0, arg_9_1)
	if not arg_9_0.itemClickCallback then
		arg_9_0.itemClickCallback = arg_9_1
	end
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.filterItmeList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.filterItmeList_ = nil

	arg_10_0:RemoveAllListeners()
	arg_10_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
