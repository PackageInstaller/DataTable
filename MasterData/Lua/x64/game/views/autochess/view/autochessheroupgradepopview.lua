local AutoChessHeroUpgradePopView = class("AutoChessHeroUpgradePopView", ReduxView)

function AutoChessHeroUpgradePopView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_UpgradePopUI"
end

function AutoChessHeroUpgradePopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessHeroUpgradePopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.upgradeHandler = handler(self, self.OnUpgradeHero)
end

function AutoChessHeroUpgradePopView:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.controllerEx_:GetController("btnStatus")
	self.lastLvController_ = self.controllerEx_:GetController("lastLv")
	self.nowLvController_ = self.controllerEx_:GetController("nowLv")
	self.showController_ = self.controllerEx_:GetController("show")
	self.attrItemList_ = {}
	self.attrItemCout_ = self.attrContain_.childCount

	for iter_4_0 = 1, self.attrItemCout_ do
		table.insert(self.attrItemList_, (AutoChessHeroUpgradePopItem.New(self.attrContain_:GetChild(iter_4_0 - 1).gameObject)))
	end

	self.buffItemList_ = {}
	self.buffItemCout_ = self.buffContain_.childCount

	for iter_4_1 = 1, self.buffItemCout_ do
		table.insert(self.buffItemList_, (AutoChessHeroUpgradePopItem.New(self.buffContain_:GetChild(iter_4_1 - 1).gameObject)))
	end

	self.playerChessItem_ = AutoChessTeamItem.New(self.playerChessGo_)
end

function AutoChessHeroUpgradePopView:AddUIListener()
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		self.upgradeHandler()
	end)
	self:AddBtnListener(self.notEnoughBtn_, nil, function()
		ShowTips("AUTO_CHESS_ADMIN_UPGRADE_CONFIRM")
	end)
	self:AddBtnListener(self.hideBtn_, nil, function()
		if not self.isHide then
			self.isHide = true

			self.showController_:SetSelectedState("hide")
		end
	end)
	self:AddBtnListener(self.showBtn_, nil, function()
		if self.isHide then
			self.isHide = false

			self.showController_:SetSelectedState("show")
		end
	end)
end

function AutoChessHeroUpgradePopView:OnEnter()
	self.info_ = self.params_.heroUpgradeInfo

	self:UpdateUI()
	manager.notify:Invoke(AUTO_CHESS_IS_IN_SKILL_POP, true)
end

function AutoChessHeroUpgradePopView:UpdateUI()
	self.showController_:SetSelectedState("show")
	self.lastLvController_:SetSelectedState(self.info_.oldLevel - 1)
	self.nowLvController_:SetSelectedState(self.info_.newLevel - 1)

	local var_11_0 = AutoChessData:GetPlayerChessData(self.params_.gameType)

	self.playerChessItem_:SetData(var_11_0)

	for iter_11_0 = 1, self.attrItemCout_ do
		if self.info_.heroAttrs[iter_11_0] then
			self.attrItemList_[iter_11_0]:SetData(true, iter_11_0, self.info_.heroAttrs[iter_11_0], self.info_.newLevel, var_11_0)
			self.attrItemList_[iter_11_0]:SetClickCb(handler(self, self.ClickFunc))
			SetActive(self.attrItemList_[iter_11_0].gameObject_, true)
		else
			SetActive(self.attrItemList_[iter_11_0].gameObject_, false)
		end
	end

	for iter_11_1 = 1, self.buffItemCout_ do
		if self.info_.heroBuffs[iter_11_1] then
			self.buffItemList_[iter_11_1]:SetData(false, iter_11_1, self.info_.heroBuffs[iter_11_1], self.info_.newLevel, var_11_0)
			self.buffItemList_[iter_11_1]:SetClickCb(handler(self, self.ClickFunc))
			SetActive(self.buffItemList_[iter_11_1].gameObject_, true)
		else
			SetActive(self.buffItemList_[iter_11_1].gameObject_, false)
		end
	end
end

function AutoChessHeroUpgradePopView:ClickFunc(arg_12_1)
	if arg_12_1.isAttr_ then
		if self.selectedAttrItem then
			self.selectedAttrItem:SetSelect(false)

			if self.selectedAttrItem.index_ == arg_12_1.index_ then
				self.selectedAttrItem = nil

				self.btnController_:SetSelectedState("grey")

				return
			end
		end

		self.selectedAttrItem = arg_12_1

		self.selectedAttrItem:SetSelect(true)
	else
		if self.selectedBuffItem then
			self.selectedBuffItem:SetSelect(false)

			if self.selectedBuffItem.index_ == arg_12_1.index_ then
				self.selectedBuffItem = nil

				self.btnController_:SetSelectedState("grey")

				return
			end
		end

		self.selectedBuffItem = arg_12_1

		self.selectedBuffItem:SetSelect(true)
	end

	self.btnController_:SetSelectedState(self.selectedAttrItem and self.selectedBuffItem and "normal" or "grey")
end

function AutoChessHeroUpgradePopView:OnUpgradeHero()
	if self.selectedAttrItem and self.selectedBuffItem then
		AutoChessTools.PlayerCheesUpgrade(self.params_.gameType, self.selectedAttrItem.index_, self.selectedBuffItem.index_)
	end
end

function AutoChessHeroUpgradePopView:OnExit()
	if self.selectedAttrItem then
		self.selectedAttrItem:SetSelect(false)

		self.selectedAttrItem = nil
	end

	if self.selectedBuffItem then
		self.selectedBuffItem:SetSelect(false)

		self.selectedBuffItem = nil
	end

	self.btnController_:SetSelectedState("grey")
end

function AutoChessHeroUpgradePopView:Dispose()
	if self.playerChessItem_ then
		self.playerChessItem_:Dispose()

		self.playerChessItem_ = nil
	end

	for iter_15_0, iter_15_1 in pairs(self.attrItemList_) do
		iter_15_1:Dispose()
	end

	self.attrItemList_ = {}

	for iter_15_2, iter_15_3 in pairs(self.buffItemList_) do
		iter_15_3:Dispose()
	end

	self.buffItemList_ = {}

	AutoChessHeroUpgradePopView.super.Dispose(self)
end

return AutoChessHeroUpgradePopView
