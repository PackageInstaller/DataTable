local MatrixTerminalLevelUpgradeView = class("MatrixTerminalLevelUpgradeView", ReduxView)

function MatrixTerminalLevelUpgradeView:UIName()
	return "UI/Matrix/Terminal/MatrixTerminalLevelUpgradeUI"
end

function MatrixTerminalLevelUpgradeView:UIParent()
	return manager.ui.uiPop.transform
end

function MatrixTerminalLevelUpgradeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixTerminalLevelUpgradeView:InitUI()
	self:BindCfgUI()

	self.desController_ = ControllerUtil.GetController(self.transform_, "state")
end

function MatrixTerminalLevelUpgradeView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function MatrixTerminalLevelUpgradeView:OnEnter()
	self.m_levelLab.text = "" .. self.params_.newLv
	self.m_giftLab.text = MatrixTerminalLevelCfg[self.params_.newLv].point

	if MatrixTerminalLevelCfg[self.params_.newLv].desc and MatrixTerminalLevelCfg[self.params_.newLv].desc ~= "" then
		self.desController_:SetSelectedIndex(1)

		self.m_desLab.text = GetI18NText(MatrixTerminalLevelCfg[self.params_.newLv].desc)
	else
		self.desController_:SetSelectedIndex(0)
	end
end

return MatrixTerminalLevelUpgradeView
