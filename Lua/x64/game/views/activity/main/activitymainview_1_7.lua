ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("ActivityMainView_1_7", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFMainUI/DFMainUI"
end

function var_0_0.InitSubmoduleButton(arg_2_0)
	arg_2_0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(arg_2_0.leftBtn2_, ActivityConst.TYR_PT),
		ActivitySubmoduleItem.New(arg_2_0.leftBtn4_, ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION),
		ActivitySubmoduleItem.New(arg_2_0.leftBtn5_, ActivityConst.TYR_SLAYER),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn2_, ActivityConst.TYR_SOLO),
		ActivityHeroTrialItem.New(arg_2_0.heroTrialGo_, ActivityConst.ACTIVITY_1_7_HERO_TRIAL),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn3_, ActivityConst.ACTIVITY_1_7_AFFIX_SELECT),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn4_, ActivityConst.TYR_SURVIVE_SOLO),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn5_, ActivityConst.TYR_VALENTINE_GAME),
		ActivityShopSubmoduleItem.New(arg_2_0.shopGo_, arg_2_0:GetActivityID())
	}
end

function var_0_0.GetActivityID(arg_3_0)
	return ActivityConst.ACTIVITY_1_7
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(arg_4_0:GetActivityID())
	local var_4_1 = var_4_0.startTime
	local var_4_2 = var_4_0.stopTime

	arg_4_0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_4_1, "!%m/%d %H:%M"), manager.time:STimeDescS(var_4_2, "!%m/%d %H:%M"))
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.leftBtn1_.transform.transform, ActivityTools.GetRedPointKey(ActivityConst.TYR_SUB_PLOT) .. ActivityConst.TYR_SUB_PLOT)
end

function var_0_0.OnExit(arg_6_0)
	var_0_0.super.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.leftBtn1_.transform.transform, ActivityTools.GetRedPointKey(ActivityConst.TYR_SUB_PLOT) .. ActivityConst.TYR_SUB_PLOT)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.leftBtn1_, nil, function()
		local var_8_0 = ActivityConst.TYR_SUB_PLOT
		local var_8_1 = ActivityData:GetActivityData(var_8_0)

		if manager.time:GetServerTime() < var_8_1.startTime then
			local var_8_2 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_8_2, manager.time:GetLostTimeStr(var_8_1.startTime)))

			return
		end

		ActivityTools.JumpToSubmodulePage(var_8_0)
	end)
end

return var_0_0
