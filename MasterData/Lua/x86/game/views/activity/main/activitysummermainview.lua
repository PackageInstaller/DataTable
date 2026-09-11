ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local ActivitySummerMainView = class("ActivitySummerMainView", ActivityMainBaseView)

function ActivitySummerMainView:UIName()
	return "UI/VersionUI/SummerUI/SummerMainUI"
end

function ActivitySummerMainView:Init()
	ActivitySummerMainView.super.Init(self)
	self:AddBtnListener(self.shopBtn_, nil, function()
		self:ClickShopBtn()
	end)
	self:AddBtnListener(self.shopBtn2_, nil, function()
		self:ClickShopBtn()
	end)
end

function ActivitySummerMainView:ClickShopBtn()
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

function ActivitySummerMainView:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(self.storyGo_, ActivityConst.SUMMER_STORY),
		ActivitySkinTrialSubmoduleItem.New(self.heroSkinGo_, ActivityConst.SUMMER_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(self.challengeGo_, ActivityConst.SUMMER_SOLO_CHALLENGE),
		ActivityHeroTrialItem.New(self.heroTrialGo_, ActivityConst.SCARCATTY_HERO_TRIAL_STAGE_),
		ActivitySubmoduleItem.New(self.artifactGo_, ActivityConst.SUMMER_ARTIFACT),
		ActivitySubmoduleItem.New(self.frontierGo_, ActivityConst.SUMMER_LIMITED_CALCULATION),
		ActivitySubmoduleItem.New(self.fishGo_, ActivityConst.SUMMER_FISHING),
		ActivitySubmoduleItem.New(self.ptGo_, ActivityConst.SUMMER_PT),
		ActivitySubmoduleItem.New(self.leviathanGo_, ActivityConst.SIKADI_GAME),
		ActivitySubmoduleItem.New(self.skinExchangeGo_, ActivityConst.SKIN_EXCHANGE)
	}
end

function ActivitySummerMainView:GetActivityID()
	return ActivityConst.SUMMER_ACTIVITY
end

return ActivitySummerMainView
