local PolyhedronTerminalLevelView = class("PolyhedronTerminalLevelView", ReduxView)

function PolyhedronTerminalLevelView:UIName()
	return "Widget/System/Polyhedron/Terminal/PolyhedronTerminalpupUI"
end

function PolyhedronTerminalLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronTerminalLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronTerminalLevelView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, PolyhedronTerminalLevelItem)
end

function PolyhedronTerminalLevelView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function PolyhedronTerminalLevelView:OnTop()
	manager.windowBar:SwitchBar({})
end

function PolyhedronTerminalLevelView:OnEnter()
	local var_8_0 = PolyhedronData:GetTerminalLevel()
	local var_8_1 = PolyhedronData:GetTerminalExp()

	self.m_levelLab.text = "" .. var_8_0

	if var_8_0 == #PolyhedronTerminalLevelCfg.all then
		self.m_expSlider.value = 1
		self.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", PolyhedronTerminalLevelCfg[var_8_0].exp - PolyhedronTerminalLevelCfg[var_8_0 - 1].exp, PolyhedronTerminalLevelCfg[var_8_0].exp - PolyhedronTerminalLevelCfg[var_8_0 - 1].exp)
	else
		self.m_expSlider.value = var_8_1 / (PolyhedronTerminalLevelCfg[var_8_0 + 1].exp - PolyhedronTerminalLevelCfg[var_8_0].exp)
		self.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_8_1, PolyhedronTerminalLevelCfg[var_8_0 + 1].exp - PolyhedronTerminalLevelCfg[var_8_0].exp)
	end

	self.list:StartScroll(#PolyhedronTerminalLevelCfg.all, table.indexof(PolyhedronTerminalLevelCfg.all, var_8_0), false)
end

function PolyhedronTerminalLevelView:OnExit()
	manager.windowBar:HideBar()
end

function PolyhedronTerminalLevelView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(PolyhedronTerminalLevelCfg.all[arg_10_1])
end

function PolyhedronTerminalLevelView:Dispose()
	self.list:Dispose()
	PolyhedronTerminalLevelView.super.Dispose(self)
end

return PolyhedronTerminalLevelView
