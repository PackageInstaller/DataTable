local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivitySkinDiscountEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	local var_1_0 = ActivitySkinDiscountCfg.get_id_list_by_activity_id[arg_1_0.activityID_]

	return ActivitySkinDiscountCfg[var_1_0[1]].ui_path
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "homepage_banner_activity_" .. arg_4_0.activityID_
		})
		JumpTools.GoToSystem("/skinDiscountGiftMain", {
			activityID = arg_4_0.activityID_
		}, ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT)
	end)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)
	arg_6_0:BindRedPoint()
end

function var_0_1.BindRedPoint(arg_7_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT) then
		manager.redPoint:bindUIandKey(arg_7_0.goBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. arg_7_0.activityID_)
	end
end

function var_0_1.UnBindRedPoint(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. arg_8_0.activityID_)
end

function var_0_1.OnExit(arg_9_0)
	arg_9_0:UnBindRedPoint()
	var_0_1.super.OnExit(arg_9_0)
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_1
