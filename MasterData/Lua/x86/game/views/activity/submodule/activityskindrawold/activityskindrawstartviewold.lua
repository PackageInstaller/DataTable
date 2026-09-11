local ActivitySkinDrawStartViewOld = class("ActivitySkinDrawStartViewOld", ReduxView)

function ActivitySkinDrawStartViewOld:UIName()
	return ActivitySkinDrawToolsOld.GetDrawStartUIName(self.params_.mainActivityID)
end

function ActivitySkinDrawStartViewOld:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawStartViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawStartViewOld:InitUI()
	self:BindCfgUI()

	self.soundEffect_ = {
		"search_scene_02_blue",
		"search_scene_02_purple",
		"search_scene_02_gold",
		special = "search_scene_02_special"
	}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function ActivitySkinDrawStartViewOld:AddUIListeners()
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

function ActivitySkinDrawStartViewOld:OnEnter()
	self.isPlaying_ = false

	self:RefreshUI()
end

function ActivitySkinDrawStartViewOld:RefreshUI()
	self:RefreshReward()
	self:RefreshAni()
end

function ActivitySkinDrawStartViewOld:RefreshReward()
	self.list_ = {}
	self.maxRare_ = 0
	self.isSkin_ = false
	self.isScene_ = false

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(self.params_.draw_list or {}) do
		local var_11_2 = ActivityLimitedDrawPoolCfg[iter_11_1].reward[1]
		local var_11_3 = ItemCfg[ActivityLimitedDrawPoolCfg[iter_11_1].reward[1][1]]

		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_11_1].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
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
end

function ActivitySkinDrawStartViewOld:RefreshAni()
	if self.isSkin_ or self.isScene_ then
		self.typeCon_:SetSelectedState("special")

		self.animator_ = self.animator_special
		self.effect_ = self.soundEffect_.special
	else
		self.typeCon_:SetSelectedState(self.maxRare_)

		self.animator_ = self["animator_" .. self.maxRare_]
		self.effect_ = self.soundEffect_[self.maxRare_]
	end
end

function ActivitySkinDrawStartViewOld:SkipFunc()
	if #self.list_ > 1 then
		if self.isSkin_ then
			self:AfterTimeline({
				self.skinDropID_
			})
		else
			JumpTools.OpenPageByJump("/activitySkinResultRewardOld", {
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

function ActivitySkinDrawStartViewOld:AfterTimeline(arg_14_1)
	self.isPlaying_ = false

	JumpTools.OpenPageByJump("/activitySkinDrawRewardOld", {
		showList = arg_14_1,
		list = self.list_,
		replaceList = self.params_.replaceList,
		activityID = self.params_.poolActivityID,
		mainActivityID = self.params_.mainActivityID
	})
end

function ActivitySkinDrawStartViewOld:OnTop()
	manager.windowBar:HideBar()
end

function ActivitySkinDrawStartViewOld:OnExit()
	AnimatorTools.Stop()
end

function ActivitySkinDrawStartViewOld:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawStartViewOld
