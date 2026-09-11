local AutoChessBrahmaUpgradePopView = class("AutoChessBrahmaUpgradePopView", ReduxView)

function AutoChessBrahmaUpgradePopView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_ObtainUpgradePopUI"
end

function AutoChessBrahmaUpgradePopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessBrahmaUpgradePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessBrahmaUpgradePopView:InitUI()
	self:BindCfgUI()

	self.buffItemList_ = {}
	self.buffItemCout_ = self.buffContain_.childCount

	for iter_4_0 = 1, self.buffItemCout_ do
		table.insert(self.buffItemList_, (AutoChessHeroUpgradePopItem.New(self.buffContain_:GetChild(iter_4_0 - 1).gameObject)))
	end
end

function AutoChessBrahmaUpgradePopView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		AutoChessTools.PlayerCheesUpgrade(self.params_.gameType, 0, 1)
	end)
end

function AutoChessBrahmaUpgradePopView:OnEnter()
	self.info_ = self.params_.heroUpgradeInfo

	self:UpdateUI()
end

function AutoChessBrahmaUpgradePopView:UpdateUI()
	for iter_8_0 = 1, self.buffItemCout_ do
		if self.info_.heroBuffs[iter_8_0] then
			self.buffItemList_[iter_8_0]:SetData(false, iter_8_0, self.info_.heroBuffs[iter_8_0], 5, self.params_.gameType)
			self.buffItemList_[iter_8_0]:SetNotClick(false)
			SetActive(self.buffItemList_[iter_8_0].gameObject_, true)
		else
			SetActive(self.buffItemList_[iter_8_0].gameObject_, false)
		end
	end
end

function AutoChessBrahmaUpgradePopView:OnExit()
	return
end

function AutoChessBrahmaUpgradePopView:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.buffItemList_) do
		iter_10_1:Dispose()
	end

	self.buffItemList_ = {}

	AutoChessBrahmaUpgradePopView.super.Dispose(self)
end

return AutoChessBrahmaUpgradePopView
