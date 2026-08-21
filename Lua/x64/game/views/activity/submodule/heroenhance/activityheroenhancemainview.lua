local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivityHeroEnhanceMainView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return ActivityHeroEnhanceTools.GetEnterUI(arg_1_0.activityID_)
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		if ActivityTools.GetActivityTheme(arg_3_0.activityID_) == ActivityConst.THEME.ACTIVITY_4_5 then
			local var_4_0 = string.format("%s_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, arg_3_0.activityID_)

			ActivityHeroEnhanceAction.BanActivityRedPoint(arg_3_0.activityID_, var_4_0)
			JumpTools.OpenPageByJump("/activityHeroEnhanceSection_4_5", {
				activityID = arg_3_0.activityID_
			})
		else
			JumpTools.GoToSystem("/activityHeroEnhanceHero", {
				activityID = arg_3_0.activityID_
			})
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.descBtn_, nil, function()
		local var_5_0 = "ACTIVITY_HERO_ENHANCE_DESC"
		local var_5_1 = ActivityHeroEnhanceTools.GetTutorialCfg(arg_3_0.activityID_)
		local var_5_2 = HeroTools.GetHeroFullName(var_5_1.hero_id)

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTipsF(var_5_0),
			key = var_5_0
		})
	end)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)

	local var_6_0 = arg_6_0.activityID_
	local var_6_1 = ActivityTools.GetRedPointKey(var_6_0) .. var_6_0
	local var_6_2 = string.format("%s_%s", RedPointConst.ACTIVITY_ENHANCE_HERO_ALL, var_6_0)

	manager.redPoint:bindUIandKey(arg_6_0.goBtn_.transform, var_6_2)
	arg_6_0:RefreshUI()
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)

	local var_7_0 = arg_7_0.activityID_
	local var_7_1 = ActivityTools.GetRedPointKey(var_7_0) .. var_7_0
	local var_7_2 = string.format("%s_%s", RedPointConst.ACTIVITY_ENHANCE_HERO_ALL, var_7_0)

	manager.redPoint:unbindUIandKey(arg_7_0.goBtn_.transform, var_7_2)
end

function var_0_1.RefreshUI(arg_8_0)
	arg_8_0.descText_.text = GetTips("ACTIVITY_HERO_ENHANCE_ENTER_TIP")

	if arg_8_0.goText_ then
		arg_8_0.goText_.text = GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_BEGIN")
	end

	if arg_8_0.itemList_ == nil then
		local var_8_0 = ActivityHeroEnhanceTools.GetAllRewardList(arg_8_0.activityID_)
		local var_8_1 = sortReward(var_8_0)

		arg_8_0.itemList_ = {}

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			local var_8_2 = clone(ItemTemplateData)

			var_8_2.id = iter_8_1.id
			var_8_2.number = iter_8_1.num
			var_8_2.hideBottomRightTextFlag = true

			table.insert(arg_8_0.itemList_, var_8_2)
		end
	end
end

function var_0_1.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.itemList_[arg_9_1].clickFun = function(arg_10_0)
		ShowPopItem(POP_ITEM, {
			arg_10_0.id,
			arg_10_0.number
		})
	end

	arg_9_2:SetData(arg_9_0.itemList_[arg_9_1])
end

function var_0_1.Dispose(arg_11_0)
	var_0_1.super.Dispose(arg_11_0)
end

return var_0_1
