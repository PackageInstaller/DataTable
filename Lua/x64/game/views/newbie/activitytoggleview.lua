local var_0_0 = class("ActivityToggleView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "conName")

	if arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.SIGN then
		manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.NEWBIE_SIGN)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.TASK then
		manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.NEWBIE_TASK)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.UPGRADE then
		manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.NEWBIE_UPGRADE)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.DAILY_TASK then
		manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.NEWBIE_DAILY_TASK)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.RECHARGE then
		manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.NEWBIE_RECHARGE)
	end
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		arg_2_0:Go("/activityNewbie", {
			activityType = arg_2_0.index_
		})
	end)
end

function var_0_0.SetSelect(arg_4_0, arg_4_1)
	if arg_4_0.index_ == arg_4_1 then
		arg_4_0.controller_:SetSelectedState("0")
	else
		arg_4_0.controller_:SetSelectedState("1")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.transform_)
end

return var_0_0
