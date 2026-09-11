local ActivityWuluoBuffUnlockPopView = class("ActivityWuluoBuffUnlockPopView", ReduxView)

function ActivityWuluoBuffUnlockPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_UltimateBuffPopUI"
end

function ActivityWuluoBuffUnlockPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityWuluoBuffUnlockPopView:Init()
	self:InitUI()
	self:AddUIListner()
end

function ActivityWuluoBuffUnlockPopView:InitUI()
	self:BindCfgUI()

	self.buffItemList_ = {}
	self.buffItemNameTextList_ = {}

	for iter_4_0 = 1, 2 do
		table.insert(self.buffItemList_, (BilliardGameSmallSkillItemView.New(self["buffItemGo_" .. iter_4_0])))
		table.insert(self.buffItemNameTextList_, self["buffName_" .. iter_4_0])
	end
end

function ActivityWuluoBuffUnlockPopView:AddUIListner()
	self:AddBtnListener(self.goBtn_, nil, function()
		self:Back()
		JumpTools.OpenPageByJump("activityWuluoVehicleIllustratePopView", {
			selectTab = 2,
			selectedBuffId = self.buffIdList_[1]
		})
	end)
end

function ActivityWuluoBuffUnlockPopView:OnEnter()
	self.buffIdList_ = self.params_.buffIDList

	for iter_7_0 = 1, 2 do
		self.buffItemList_[iter_7_0]:SetBuffData(self.buffIdList_[iter_7_0], true)

		if MergeBallBuffCfg[self.buffIdList_[iter_7_0]] then
			self.buffItemNameTextList_[iter_7_0].text = MergeBallBuffCfg[self.buffIdList_[iter_7_0]].name
		end
	end
end

function ActivityWuluoBuffUnlockPopView:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.buffItemList_) do
		iter_8_1:Dispose()
	end

	self.buffItemList_ = {}

	ActivityWuluoBuffUnlockPopView.super.Dispose(self)
end

return ActivityWuluoBuffUnlockPopView
