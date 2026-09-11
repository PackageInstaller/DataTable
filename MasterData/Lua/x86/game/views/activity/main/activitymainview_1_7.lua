ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local ActivityMainView_1_7 = class("ActivityMainView_1_7", ActivityMainBaseView)

function ActivityMainView_1_7:UIName()
	return "UI/VersionUI/DarkFlameUI/DFMainUI/DFMainUI"
end

function ActivityMainView_1_7:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(self.leftBtn2_, ActivityConst.TYR_PT),
		ActivitySubmoduleItem.New(self.leftBtn4_, ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION),
		ActivitySubmoduleItem.New(self.leftBtn5_, ActivityConst.TYR_SLAYER),
		ActivitySubmoduleItem.New(self.rightBtn2_, ActivityConst.TYR_SOLO),
		ActivityHeroTrialItem.New(self.heroTrialGo_, ActivityConst.ACTIVITY_1_7_HERO_TRIAL),
		ActivitySubmoduleItem.New(self.rightBtn3_, ActivityConst.ACTIVITY_1_7_AFFIX_SELECT),
		ActivitySubmoduleItem.New(self.rightBtn4_, ActivityConst.TYR_SURVIVE_SOLO),
		ActivitySubmoduleItem.New(self.rightBtn5_, ActivityConst.TYR_VALENTINE_GAME),
		ActivityShopSubmoduleItem.New(self.shopGo_, self:GetActivityID())
	}
end

function ActivityMainView_1_7:GetActivityID()
	return ActivityConst.ACTIVITY_1_7
end

function ActivityMainView_1_7:RefreshUI()
	local var_4_0 = ActivityData:GetActivityData(self:GetActivityID())

	self.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_4_0.startTime, "!%m/%d %H:%M"), manager.time:STimeDescS(var_4_0.stopTime, "!%m/%d %H:%M"))
end

function ActivityMainView_1_7:OnEnter()
	ActivityMainView_1_7.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.leftBtn1_.transform.transform, ActivityTools.GetRedPointKey(ActivityConst.TYR_SUB_PLOT) .. ActivityConst.TYR_SUB_PLOT)
end

function ActivityMainView_1_7:OnExit()
	ActivityMainView_1_7.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.leftBtn1_.transform.transform, ActivityTools.GetRedPointKey(ActivityConst.TYR_SUB_PLOT) .. ActivityConst.TYR_SUB_PLOT)
end

function ActivityMainView_1_7:AddListeners()
	self:AddBtnListener(self.leftBtn1_, nil, function()
		local var_8_0 = ActivityData:GetActivityData(ActivityConst.TYR_SUB_PLOT)

		if manager.time:GetServerTime() < var_8_0.startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_8_0.startTime)))

			return
		end

		ActivityTools.JumpToSubmodulePage(ActivityConst.TYR_SUB_PLOT)
	end)
end

return ActivityMainView_1_7
