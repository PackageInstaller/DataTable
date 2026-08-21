local var_0_0 = class("ActivitySummerSwimsuitPreheatStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.conEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0.cfgId_)
		end
	end)
end

function var_0_0.SetClickHandler(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.onClickHandler_ = arg_5_1
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.cfgId_ = arg_6_1
	arg_6_0.index_ = arg_6_2
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = ActivitySummerSwimsuitPreheatCfg[arg_7_0.cfgId_]
	local var_7_1 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_7_0)
	local var_7_2 = var_7_0.activity_id
	local var_7_3 = ActivityData:GetActivityData(var_7_2)

	if not var_7_3:IsActivitying() then
		arg_7_0.stateController_:SetSelectedState("lock")

		local var_7_4 = manager.time:DiffDay2(manager.time:GetServerTime(), var_7_3.startTime) + 1

		arg_7_0.lockText_.text = GetTipsF("ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_LOCK_DAY", var_7_4)
	elseif ActivitySummerSwimsuitPreheatData.IsStageClear(var_7_1, var_7_0.id) then
		local var_7_5 = ActivitySummerSwimsuitPreheatData.IsGotStageReward(var_7_1, var_7_0.id)

		arg_7_0.stateController_:SetSelectedState(var_7_5 and "finished" or "finished&award")
	else
		arg_7_0.stateController_:SetSelectedState("unfinished")
	end

	local var_7_6 = ActivitySummerSwimsuitPreheatTools.GetCfgStageImage(var_7_0)

	arg_7_0.img_.sprite = var_7_6
end

function var_0_0.BindRedPoint(arg_8_0, arg_8_1)
	local var_8_0 = ActivitySummerSwimsuitPreheatCfg[arg_8_0.cfgId_]
	local var_8_1 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_8_0)
	local var_8_2 = ActivityTools.GetRedPointKey(var_8_1) .. var_8_1
	local var_8_3 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE, var_8_0.id, var_8_2)

	if arg_8_1 then
		manager.redPoint:bindUIandKey(arg_8_0.btn_.transform, var_8_3)
	else
		manager.redPoint:unbindUIandKey(arg_8_0.btn_.transform, var_8_3)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
