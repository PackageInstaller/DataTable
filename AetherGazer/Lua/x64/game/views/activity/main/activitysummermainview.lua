ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("ActivitySummerMainView", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerMainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.shopBtn_, nil, function()
		arg_2_0:ClickShopBtn()
	end)
	arg_2_0:AddBtnListener(arg_2_0.shopBtn2_, nil, function()
		arg_2_0:ClickShopBtn()
	end)
end

function var_0_0.ClickShopBtn(arg_5_0)
	local var_5_0, var_5_1 = ShopTools.IsShopOpen(26)

	if var_5_0 then
		JumpTools.GoToSystem("/activityShop", {
			shopId = ShopConst.SHOP_ID.SUMMER_SHOP1,
			showShops = {
				ShopConst.SHOP_ID.SUMMER_SHOP1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	elseif var_5_1 == 2 then
		ShowTips("SHOP_EXPIRED")
	elseif var_5_1 == 3 then
		ShowTips("SHOP_NOT_OPEN")
	end
end

function var_0_0.InitSubmoduleButton(arg_6_0)
	arg_6_0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(arg_6_0.storyGo_, ActivityConst.SUMMER_STORY),
		ActivitySkinTrialSubmoduleItem.New(arg_6_0.heroSkinGo_, ActivityConst.SUMMER_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(arg_6_0.challengeGo_, ActivityConst.SUMMER_SOLO_CHALLENGE),
		ActivityHeroTrialItem.New(arg_6_0.heroTrialGo_, ActivityConst.SCARCATTY_HERO_TRIAL_STAGE_),
		ActivitySubmoduleItem.New(arg_6_0.artifactGo_, ActivityConst.SUMMER_ARTIFACT),
		ActivitySubmoduleItem.New(arg_6_0.frontierGo_, ActivityConst.SUMMER_LIMITED_CALCULATION),
		ActivitySubmoduleItem.New(arg_6_0.fishGo_, ActivityConst.SUMMER_FISHING),
		ActivitySubmoduleItem.New(arg_6_0.ptGo_, ActivityConst.SUMMER_PT),
		ActivitySubmoduleItem.New(arg_6_0.leviathanGo_, ActivityConst.SIKADI_GAME),
		ActivitySubmoduleItem.New(arg_6_0.skinExchangeGo_, ActivityConst.SKIN_EXCHANGE)
	}
end

function var_0_0.GetActivityID(arg_7_0)
	return ActivityConst.SUMMER_ACTIVITY
end

return var_0_0
