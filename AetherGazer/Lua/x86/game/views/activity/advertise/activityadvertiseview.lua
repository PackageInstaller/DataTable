local var_0_0 = class("ActvitiyAdvertiseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity/ActivityAdvertiseParentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	if #ActivityAdvertiseTools.GetOpenActivityCfgIDList() <= 0 then
		arg_4_0:Back()

		return
	end

	arg_4_0:CreateItem()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:DestroyItem()
end

function var_0_0.CreateItem(arg_6_0)
	arg_6_0.itemView_ = ActivityAdvertiseItem.New(arg_6_0.itemParent_)
end

function var_0_0.DestroyItem(arg_7_0)
	if arg_7_0.itemView_ then
		arg_7_0.itemView_:Dispose()

		arg_7_0.itemView_ = nil
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.closeBtn_, nil, function()
		local var_10_0 = 0

		if arg_9_0.itemView_ and arg_9_0.itemView_.cfgID_ then
			local var_10_1 = ActivityAdvertiseCfg[arg_9_0.itemView_.cfgID_]

			var_10_0 = var_10_1 and var_10_1.activity_id
		end

		SDKTools.SendMessageToSDK("activity_publicize_page_jump", {
			opt = 2,
			activity_id = var_10_0
		})

		if ActivityAdvertiseTools.NeedShowAdvertise() then
			arg_9_0:DestroyItem()
			arg_9_0:CreateItem()
		else
			arg_9_0:Back()
		end
	end)
end

function var_0_0.Cacheable(arg_11_0)
	return false
end

return var_0_0
