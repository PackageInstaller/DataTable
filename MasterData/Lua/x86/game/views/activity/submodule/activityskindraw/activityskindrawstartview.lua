local ActivitySkinDrawStartView = class("ActivitySkinDrawStartView", ReduxView)

function ActivitySkinDrawStartView:UIName()
	return ActivitySkinDrawTools.GetDrawStartUIName(self.params_.mainActivityID)
end

function ActivitySkinDrawStartView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawStartView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawStartView:InitUI()
	self:BindCfgUI()

	self.soundEffect_ = ActivitySkinDrawTools.GetOpenBoxEffect()
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function ActivitySkinDrawStartView:AddUIListeners()
	self:AddBtnListener(self.skipBtn_, nil, function()
		if self.isPlaying_ then
			-- block empty
		else
			self:SkipFunc()
		end
	end)
	self:AddBtnListener(self.drawInteractBtn_, nil, function()
		if self.isPlaying_ then
			return
		end

		self.isPlaying_ = true

		manager.audio:PlayEffect("ui_system_search", self.effect_, "")

		if self.animator_ then
			AnimatorTools.PlayAnimatorWithCallback(self.animator_, "Demo_root", function()
				self:AfterTimeline(self.list_)
			end, false)
		else
			self:AfterTimeline(self.list_)
		end
	end)
end

function ActivitySkinDrawStartView:OnEnter()
	self.isPlaying_ = false

	self:RefreshUI()
end

function ActivitySkinDrawStartView:RefreshUI()
	self:RefreshReward()
	self:RefreshAni()
end

function ActivitySkinDrawStartView:RefreshReward()
	self.list_ = {}
	self.maxRare_ = 0
	self.isSkin_ = false
	self.isScene_ = false

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(self.params_.draw_list or {}) do
		local var_11_2 = ActivityLimitedDrawPoolCfg[iter_11_1].reward[1]
		local var_11_3 = ItemCfg[ActivityLimitedDrawPoolCfg[iter_11_1].reward[1][1]]

		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_11_1].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN or ActivitySkinDrawTools.GetIsSkinGift(ActivityLimitedDrawPoolCfg[iter_11_1].reward[1][1]) then
			self.isSkin_ = true
			self.skinDropID_ = iter_11_1
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_11_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE then
			self.isScene_ = true
		end

		table.insert(self.list_, iter_11_1)
		table.insert(var_11_1, var_11_2)

		if (var_11_3.rare >= 5 and 3 or var_11_3.rare == 4 and 2 or 1) < self.maxRare_ then
			self.maxRare_ = self.maxRare_ or var_11_3.rare >= 5 and 3 or var_11_3.rare == 4 and 2 or 1
		end
	end

	local var_11_5 = ActivitySkinDrawTools.GetEnterDrawEffect()

	if var_11_5 then
		manager.audio:PlayEffect("ui_system_search", var_11_5[self.maxRare_], "")
	end
end

function ActivitySkinDrawStartView:RefreshAni()
	if self.isSkin_ or self.isScene_ then
		self.typeCon_:SetSelectedState("special")

		self.animator_ = self.animator_special
		self.effect_ = self.soundEffect_[4]
	else
		self.typeCon_:SetSelectedState(self.maxRare_)

		self.animator_ = self["animator_" .. self.maxRare_]
		self.effect_ = self.soundEffect_[self.maxRare_]
	end
end

function ActivitySkinDrawStartView:SkipFunc()
	if #self.list_ > 1 then
		if self.isSkin_ then
			self:AfterTimeline({
				self.skinDropID_
			})
		else
			JumpTools.OpenPageByJump("/activitySkinResultReward", {
				list = self.list_,
				replaceList = self.params_.replaceList,
				activityID = self.params_.poolActivityID,
				mainActivityID = self.params_.mainActivityID
			})
		end
	else
		self:AfterTimeline(self.list_)
	end
end

function ActivitySkinDrawStartView:AfterTimeline(arg_14_1)
	self.isPlaying_ = false

	JumpTools.OpenPageByJump("/activitySkinDrawReward", {
		showList = arg_14_1,
		list = self.list_,
		replaceList = self.params_.replaceList,
		activityID = self.params_.poolActivityID,
		mainActivityID = self.params_.mainActivityID
	})
end

function ActivitySkinDrawStartView:OnTop()
	manager.windowBar:HideBar()
end

function ActivitySkinDrawStartView:OnExit()
	if self.animator_ then
		self.animator_:Rebind()
		AnimatorTools.Stop(self.animator_)
	end
end

function ActivitySkinDrawStartView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawStartView
