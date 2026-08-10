local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivitySkinDrawEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return T0SkinDrawCfg[arg_1_0.activityID_].activity_UI
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
		ActivitySkinDrawTools.OnJumpToSkinDraw(arg_4_0.activityID_)
	end)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)
	arg_6_0:BindRedPointUI()
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)
	arg_7_0:UnbindRedPointUI()
end

function var_0_1.BindRedPointUI(arg_8_0)
	if ActivityData:GetActivityIsOpen(arg_8_0.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and arg_8_0.goBtn_ then
		manager.redPoint:bindUIandKey(arg_8_0.goBtn_.transform, RedPointConst.ACTIVITY_DRAW .. "_" .. arg_8_0.activityID_)
	end
end

function var_0_1.UnbindRedPointUI(arg_9_0)
	if ActivityData:GetActivityIsOpen(arg_9_0.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and arg_9_0.goBtn_ then
		manager.redPoint:unbindUIandKey(arg_9_0.goBtn_.transform, RedPointConst.ACTIVITY_DRAW .. "_" .. arg_9_0.activityID_)
	end
end

return var_0_1
