local ActivitySkinResultRewardView = class("ActivitySkinResultRewardView", ReduxView)

function ActivitySkinResultRewardView:UIName()
	return ActivitySkinDrawTools.GetDrawResultUIName(self.params_.mainActivityID)
end

function ActivitySkinResultRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinResultRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinResultRewardView:InitUI()
	self:BindCfgUI()

	self.itemList_ = {}

	for iter_4_0 = 1, 10 do
		self.itemList_[iter_4_0] = ActivitySkinResultRewardItem.New(self["item_" .. iter_4_0])
	end
end

function ActivitySkinResultRewardView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityskinDraw", {
			activityID = self.params_.mainActivityID,
			isSceneDrawed = self.isScene_,
			sceneDrawedId = self.sceneId_
		})
	end)
end

function ActivitySkinResultRewardView:OnEnter()
	self.replaceList_ = self.params_.replaceList

	self:RefreshReplace()
	self:RefreshUI()
end

function ActivitySkinResultRewardView:RefreshReplace()
	self.isReplaceScene_ = false

	for iter_8_0, iter_8_1 in ipairs(self.replaceList_) do
		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_8_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE then
			self.isReplaceScene_ = true
		end
	end
end

function ActivitySkinResultRewardView:RefreshUI()
	self.list_ = self.params_.list
	self.isScene_ = false

	for iter_9_0, iter_9_1 in ipairs(self.list_) do
		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE and ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1] ~= HomeSceneSettingData:GetCurScene() and not self.isReplaceScene_ then
			self.isScene_ = true
			self.sceneId_ = ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]

			break
		end
	end

	self:RefreshItemList()
end

function ActivitySkinResultRewardView:RefreshItemList()
	for iter_10_0 = 1, 10 do
		self.itemList_[iter_10_0]:SetData(self.list_[iter_10_0], iter_10_0, table.indexof(self.params_.replaceList or {}, self.list_[iter_10_0]))
	end
end

function ActivitySkinResultRewardView:OnTop()
	manager.windowBar:HideBar()
end

function ActivitySkinResultRewardView:OnExit()
	self.isScene_ = false
	self.sceneId_ = 0
end

function ActivitySkinResultRewardView:Dispose()
	self:RemoveAllListeners()

	for iter_13_0, iter_13_1 in pairs(self.itemList_) do
		iter_13_1:Dispose()
	end

	self.itemList_ = nil

	self.super.Dispose(self)
end

return ActivitySkinResultRewardView
