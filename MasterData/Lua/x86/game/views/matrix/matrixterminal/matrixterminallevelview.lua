local MatrixTerminalLevelView = class("MatrixTerminalLevelView", ReduxView)

function MatrixTerminalLevelView:UIName()
	return "UI/Matrix/Terminal/MatrixTerminalLevelUI"
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

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MatrixTerminalLevelItem)
	self.desController_ = ControllerUtil.GetController(self.transform_, "des")
end

function MatrixTerminalLevelView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function MatrixTerminalLevelView:OnEnter()
	self.curLevel = MatrixData:GetTerminalLevel()
	self.selectLevel = self.curLevel
	self.data = self:ReverseTable(MatrixTerminalLevelCfg.all)

	self.list_:StartScroll(#self.data)
	self.list_:ScrollToIndex(table.indexof(self.data, self.curLevel), true, false)
	self:RefreshInfo()
end

function MatrixTerminalLevelView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:Refresh(self.data[arg_8_1], self.curLevel)
	arg_8_2:SetChoice(self.selectLevel)
	arg_8_2:RegistCallBack(handler(self, self.OnItemClick))
end

function MatrixTerminalLevelView:OnItemClick(arg_9_1)
	self.selectLevel = arg_9_1

	for iter_9_0, iter_9_1 in pairs((self.list_:GetItemList())) do
		iter_9_1:SetChoice(self.selectLevel)
	end

	self:RefreshInfo()
end

function MatrixTerminalLevelView:RefreshInfo()
	self.m_levelLab.text = "" .. self.selectLevel

	local var_10_0 = MatrixTerminalLevelCfg[self.selectLevel]

	self.m_giftLab.text = "+" .. var_10_0.point - ((MatrixTerminalLevelCfg[self.selectLevel - 1] or nil) and (MatrixTerminalLevelCfg[self.selectLevel - 1].point or 0))

	if var_10_0.desc and var_10_0.desc ~= "" then
		self.desController_:SetSelectedIndex(1)

		self.m_desLab.text = GetI18NText(var_10_0.desc)
	else
		self.desController_:SetSelectedIndex(0)
	end
end

function MatrixTerminalLevelView:ReverseTable(arg_11_1)
	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_1 do
		var_11_0[iter_11_0] = arg_11_1[#arg_11_1 + 1 - iter_11_0]
	end

	return var_11_0
end

function MatrixTerminalLevelView:Dispose()
	self.list_:Dispose()
	MatrixTerminalLevelView.super.Dispose(self)
end

return MatrixTerminalLevelView
