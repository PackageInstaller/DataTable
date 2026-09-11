local ActivityHeroEnhanceMainView = class("ActivityHeroEnhanceMainView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivityHeroEnhanceMainView:GetUIName()
	return ActivityHeroEnhanceTools.GetEnterUI(self.activityID_)
end

function ActivityHeroEnhanceMainView:Init()
	ActivityHeroEnhanceMainView.super.Init(self)
end

function ActivityHeroEnhanceMainView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if ActivityTools.GetActivityTheme(self.activityID_) == ActivityConst.THEME.ACTIVITY_4_5 then
			ActivityHeroEnhanceAction.BanActivityRedPoint(self.activityID_, (string.format("%s_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, self.activityID_)))
			JumpTools.OpenPageByJump("/activityHeroEnhanceSection_4_5", {
				activityID = self.activityID_
			})
		else
			JumpTools.GoToSystem("/activityHeroEnhanceHero", {
				activityID = self.activityID_
			})
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_5_0 = HeroTools.GetHeroFullName(ActivityHeroEnhanceTools.GetTutorialCfg(self.activityID_).hero_id)
		local var_5_1 = {
			content = GetTipsF("ACTIVITY_HERO_ENHANCE_DESC")
		}

		var_5_1.key = "ACTIVITY_HERO_ENHANCE_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_5_1)
	end)
end

function ActivityHeroEnhanceMainView:OnEnter()
	ActivityHeroEnhanceMainView.super.OnEnter(self)

	local var_6_0 = ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_

	manager.redPoint:bindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_ENHANCE_HERO_ALL, self.activityID_)))
	self:RefreshUI()
end

function ActivityHeroEnhanceMainView:OnExit()
	ActivityHeroEnhanceMainView.super.OnExit(self)

	local var_7_0 = ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_

	manager.redPoint:unbindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_ENHANCE_HERO_ALL, self.activityID_)))
end

function ActivityHeroEnhanceMainView:RefreshUI()
	self.descText_.text = GetTips("ACTIVITY_HERO_ENHANCE_ENTER_TIP")

	if self.goText_ then
		self.goText_.text = GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_BEGIN")
	end

	if self.itemList_ == nil then
		self.itemList_ = {}

		for iter_8_0, iter_8_1 in pairs((sortReward((ActivityHeroEnhanceTools.GetAllRewardList(self.activityID_))))) do
			local var_8_0 = clone(ItemTemplateData)

			var_8_0.id = iter_8_1.id
			var_8_0.number = iter_8_1.num
			var_8_0.hideBottomRightTextFlag = true

			table.insert(self.itemList_, var_8_0)
		end
	end
end

function ActivityHeroEnhanceMainView:IndexItem(arg_9_1, arg_9_2)
	self.itemList_[arg_9_1].clickFun = function(self)
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_9_2:SetData(self.itemList_[arg_9_1])
end

function ActivityHeroEnhanceMainView:Dispose()
	ActivityHeroEnhanceMainView.super.Dispose(self)
end

return ActivityHeroEnhanceMainView
