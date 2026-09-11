local ActivitySkinResultRewardViewOld = class("ActivitySkinResultRewardViewOld", ReduxView)

function ActivitySkinResultRewardViewOld:UIName()
	return ActivitySkinDrawToolsOld.GetDrawResultUIName(self.params_.mainActivityID)
end

function ActivitySkinResultRewardViewOld:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinResultRewardViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinResultRewardViewOld:InitUI()
	self:BindCfgUI()

	self.itemList_ = {}

	for iter_4_0 = 1, 10 do
		self.itemList_[iter_4_0] = ActivitySkinResultRewardItemOld.New(self["item_" .. iter_4_0])
	end
end

function ActivitySkinResultRewardViewOld:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityskinDrawOld", {
			activityID = self.params_.mainActivityID,
			isSceneDrawed = self.isScene_
		})
	end)
end

function ActivitySkinResultRewardViewOld:OnEnter()
	self:RefreshUI()
end

function ActivitySkinResultRewardViewOld:RefreshUI()
	self.list_ = self.params_.list
	self.isScene_ = false

	for iter_8_0, iter_8_1 in ipairs(self.list_) do
		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_8_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE and ActivityLimitedDrawPoolCfg[iter_8_1].reward[1][1] ~= HomeSceneSettingData:GetCurScene() then
			self.isScene_ = true

			break
		end
	end

	self:RefreshItemList()
end

function ActivitySkinResultRewardViewOld:RefreshItemList()
	for iter_9_0 = 1, 10 do
		self.itemList_[iter_9_0]:SetData(self.list_[iter_9_0], iter_9_0, table.indexof(self.params_.replaceList or {}, self.list_[iter_9_0]))
	end
end

function ActivitySkinResultRewardViewOld:OnTop()
	manager.windowBar:HideBar()
end

function ActivitySkinResultRewardViewOld:OnExit()
	self.isScene_ = false
end

function ActivitySkinResultRewardViewOld:Dispose()
	self:RemoveAllListeners()

	for iter_12_0, iter_12_1 in pairs(self.itemList_) do
		iter_12_1:Dispose()
	end

	self.itemList_ = nil

	self.super.Dispose(self)
end

return ActivitySkinResultRewardViewOld
