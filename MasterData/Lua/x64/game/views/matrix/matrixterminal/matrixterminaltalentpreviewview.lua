local MatrixTerminalLevelView = class("MatrixTerminalLevelView", ReduxView)

function MatrixTerminalLevelView:UIName()
	return "UI/Matrix/Terminal/MatrixTerminalTalentPreviewUI"
end

function MatrixTerminalLevelView:UIParent()
	return manager.ui.uiPop.transform
end

function MatrixTerminalLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixTerminalLevelView:InitUI()
	self:BindCfgUI()
end

function MatrixTerminalLevelView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function MatrixTerminalLevelView:OnEnter()
	self.id = self.params_.id
	self.lv = self.params_.lv
	self.m_nameLab.text = GetI18NText(MatrixTerminalGiftCfg[self.id].name)
	self.m_curLevel.text = self.lv
	self.m_nextLevel.text = self.lv + 1
	self.m_desLab.text = MatrixDescCfg[MatrixTerminalGiftCfg[self.id].desc_list[self.lv + 1]] and GetI18NText(MatrixDescCfg[MatrixTerminalGiftCfg[self.id].desc_list[self.lv + 1]].desc) or ""
end

return MatrixTerminalLevelView
