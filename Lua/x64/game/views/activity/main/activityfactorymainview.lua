ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("ActivityFactoryMainView", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/main/MarduckMainUI"
end

function var_0_0.InitSubmoduleButton(arg_2_0)
	arg_2_0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(arg_2_0.storyGo_, ActivityConst.FACTORY_STORY),
		ActivitySubmoduleItem.New(arg_2_0.leftBtn2_, ActivityConst.FACTORY_MARDUK),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn4_, ActivityConst.FACTORY_INFINITY_POOL_TASK),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn5_, ActivityConst.FACTORY_SEQUENTIAL_BATTLE),
		ActivitySubmoduleItem.New(arg_2_0.rightBtn6_, ActivityConst.FACTORY_SURVIVE_SOLO),
		ActivitySubmoduleItem.New(arg_2_0.ptGo_, ActivityConst.FACTORY_PT),
		ActivitySubmoduleItem.New(arg_2_0.leftBtn1_, ActivityConst.FACTORY_TOWERGAME),
		arg_2_0:GetHeroTrialItemClass().New(arg_2_0.heroTrialGo_, ActivityConst.FACTORY_HERO_TRIAL),
		arg_2_0:GetSkinTrialItemClass().New(arg_2_0.heroSkinGo_, ActivityConst.FACTORY_SKIN_TRIAL),
		ActivitySubmoduleItem.New(arg_2_0.soloBtn7_, ActivityConst.FACTORY_SOLO_CHALLENGE)
	}
end

function var_0_0.GetHeroTrialItemClass(arg_3_0)
	if not SDKTools.GetIsOverSea() then
		return ActivityHeroTrialItem
	else
		return ActivityFactoryHeroTrialSubmoduleItem
	end
end

function var_0_0.GetSkinTrialItemClass(arg_4_0)
	if not SDKTools.GetIsOverSea() then
		return ActivitySkinTrialSubmoduleItem
	else
		return ActivityFactorySkinTrialSubmoduleItem
	end
end

function var_0_0.GetActivityID(arg_5_0)
	return ActivityConst.FACTORY_ACTIVITY
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ActivityData:GetActivityData(arg_6_0:GetActivityID())
	local var_6_1 = var_6_0.startTime
	local var_6_2 = var_6_0.stopTime

	arg_6_0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_6_1, "!%Y %m.%d"), manager.time:STimeDescS(var_6_2, "!%m.%d"))
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.subPlotBtn_, nil, function()
		JumpTools.Jump2SubPlot(6010005, false)
	end)
	arg_7_0:AddBtnListener(arg_7_0.shopBtn_, nil, function()
		local var_9_0 = ActivityCfg[arg_7_0:GetActivityID()].activity_theme
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_9_0]) do
			table.insert(var_9_1, ActivityShopCfg[iter_9_1].shop_id)
		end

		local var_9_2, var_9_3 = ShopTools.IsShopOpen(var_9_1[1])

		if var_9_2 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_9_1[1],
				showShops = var_9_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_9_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_9_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
end

return var_0_0
