local SailUpgradeIslandView = class("SailUpgradeIslandView", ReduxView)

function SailUpgradeIslandView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageIslandUpgradeUI"
end

function SailUpgradeIslandView:UIParent()
	return manager.ui.uiPop.transform
end

function SailUpgradeIslandView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailUpgradeIslandView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.premissItemList_ = {}
end

function SailUpgradeIslandView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not self.isEnough_ then
			ShowTips("ACTIVITY_SKADI_SEA_MATERIAL_NUM_NOT_ENOUGH")

			return
		end

		if not self.isComplete_ then
			ShowTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_NOT_ENOUGH")

			return
		end

		SailGameAction.UpgradeIsland(self.activityID_)
	end)
end

function SailUpgradeIslandView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function SailUpgradeIslandView:Dispose()
	for iter_9_0, iter_9_1 in ipairs(self.premissItemList_) do
		iter_9_1:Dispose()
	end

	self.premissItemList = nil

	SailUpgradeIslandView.super.Dispose(self)
end

function SailUpgradeIslandView:RefreshUI()
	self.curLevel_ = SailGameData:GetIslandLevel(self.activityID_)
	self.nextLevel_ = self.curLevel_ + 1

	if #SailGameIslandLevelCfg.get_id_list_by_activity_id[self.activityID_] > self.curLevel_ then
		self.nextLevelText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_TIP"), NumberTools.IntToRomam(self.nextLevel_))
		self.nextLevelCfg_ = SailGameIslandLevelCfg[SailGameIslandLevelCfg.get_id_list_by_activity_id[self.activityID_][self.nextLevel_]]

		self:RefreshPremiss()
		self:RefreshCost()
		self:RefreshStatus()
	end
end

function SailUpgradeIslandView:RefreshPremiss()
	self.premissIDList_ = self.nextLevelCfg_.unlock_level_need

	for iter_11_0, iter_11_1 in ipairs(self.premissIDList_) do
		self.premissItemList_[iter_11_0] = self.premissItemList_[iter_11_0] or SailUpgradeIslandPremissItem.New(self.premissTemplateGo_, self.premissContentTrans_)

		self.premissItemList_[iter_11_0]:SetData(iter_11_1, self.activityID_)
	end

	for iter_11_2 = #self.premissIDList_ + 1, #self.premissItemList_ do
		self.premissItemList_[iter_11_2]:SetActive(false)
	end

	self.isComplete_ = true

	for iter_11_3, iter_11_4 in ipairs(self.premissItemList_) do
		if not iter_11_4:IsComplete() then
			self.isComplete_ = false

			break
		end
	end
end

function SailUpgradeIslandView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.premissIDList_[arg_12_1], self.activityID_)
end

function SailUpgradeIslandView:RefreshCost()
	local var_13_0 = self.nextLevelCfg_.cost[1][1]
	local var_13_1 = self.nextLevelCfg_.cost[1][2]

	self.isEnough_ = self.nextLevelCfg_.cost[1][2] <= ItemTools.getItemNum(self.nextLevelCfg_.cost[1][1])
	self.costNumText_.text = var_13_1
	self.costIcon_.sprite = ItemTools.getItemSprite(var_13_0)
end

function SailUpgradeIslandView:RefreshStatus()
	if self.isEnough_ then
		if self.isComplete_ then
			self.statusController_:SetSelectedState("enough")
		else
			self.statusController_:SetSelectedState("uncomplete")
		end
	else
		self.statusController_:SetSelectedState("not_enough")
	end
end

function SailUpgradeIslandView:OnIslandUpgrade()
	ShowTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_SUCCESS")
	self:Back()
end

return SailUpgradeIslandView
