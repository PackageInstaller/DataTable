ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local ActivityFactoryMainView = class("ActivityFactoryMainView", ActivityMainBaseView)

function ActivityFactoryMainView:UIName()
	return "UI/MardukUI/main/MarduckMainUI"
end

function ActivityFactoryMainView:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(self.storyGo_, ActivityConst.FACTORY_STORY),
		ActivitySubmoduleItem.New(self.leftBtn2_, ActivityConst.FACTORY_MARDUK),
		ActivitySubmoduleItem.New(self.rightBtn4_, ActivityConst.FACTORY_INFINITY_POOL_TASK),
		ActivitySubmoduleItem.New(self.rightBtn5_, ActivityConst.FACTORY_SEQUENTIAL_BATTLE),
		ActivitySubmoduleItem.New(self.rightBtn6_, ActivityConst.FACTORY_SURVIVE_SOLO),
		ActivitySubmoduleItem.New(self.ptGo_, ActivityConst.FACTORY_PT),
		ActivitySubmoduleItem.New(self.leftBtn1_, ActivityConst.FACTORY_TOWERGAME),
		self:GetHeroTrialItemClass().New(self.heroTrialGo_, ActivityConst.FACTORY_HERO_TRIAL),
		self:GetSkinTrialItemClass().New(self.heroSkinGo_, ActivityConst.FACTORY_SKIN_TRIAL),
		ActivitySubmoduleItem.New(self.soloBtn7_, ActivityConst.FACTORY_SOLO_CHALLENGE)
	}
end

function ActivityFactoryMainView:GetHeroTrialItemClass()
	if not SDKTools.GetIsOverSea() then
		return ActivityHeroTrialItem
	else
		return ActivityFactoryHeroTrialSubmoduleItem
	end
end

function ActivityFactoryMainView:GetSkinTrialItemClass()
	if not SDKTools.GetIsOverSea() then
		return ActivitySkinTrialSubmoduleItem
	else
		return ActivityFactorySkinTrialSubmoduleItem
	end
end

function ActivityFactoryMainView:GetActivityID()
	return ActivityConst.FACTORY_ACTIVITY
end

function ActivityFactoryMainView:RefreshUI()
	local var_6_0 = ActivityData:GetActivityData(self:GetActivityID())

	self.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_6_0.startTime, "!%Y %m.%d"), manager.time:STimeDescS(var_6_0.stopTime, "!%m.%d"))
end

function ActivityFactoryMainView:AddListeners()
	self:AddBtnListener(self.subPlotBtn_, nil, function()
		JumpTools.Jump2SubPlot(6010005, false)
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[self:GetActivityID()].activity_theme]) do
			table.insert(var_9_0, ActivityShopCfg[iter_9_1].shop_id)
		end

		local var_9_1, var_9_2 = ShopTools.IsShopOpen(var_9_0[1])

		if var_9_1 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_9_0[1],
				showShops = var_9_0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_9_2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_9_2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
end

return ActivityFactoryMainView
