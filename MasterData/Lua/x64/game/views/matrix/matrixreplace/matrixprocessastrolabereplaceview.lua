local MatrixProcessAstrolabeReplaceView = class("MatrixProcessAstrolabeReplaceView", ReduxView)

function MatrixProcessAstrolabeReplaceView:UIName()
	return "UI/Matrix/Process/MatrixProcessAstrolabeReplaceUI"
end

function MatrixProcessAstrolabeReplaceView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixProcessAstrolabeReplaceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixProcessAstrolabeReplaceView:InitUI()
	self:BindCfgUI()

	self.item_ = MatrixProcessRewardItem.New(self.m_item)
	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixProcessAstrolabeRewardItem)
end

function MatrixProcessAstrolabeReplaceView:AddUIListener()
	self:AddBtnListener(self.m_okBtn, nil, function()
		if self.params_.callback then
			self.params_.callback(self.astrolabeList[self.selectItemIndex])
		end

		self:Back()
	end)
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
end

function MatrixProcessAstrolabeReplaceView:OnEnter()
	self.heroId = self.params_.heroId
	self.astrolabeId = self.params_.astrolabeId

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs((self:GetHeroData(self.heroId):GetAstrolabeList())) do
		if MatrixItemCfg[iter_8_1].params[1] ~= MatrixItemCfg[self.astrolabeId].params[1] then
			var_8_0[MatrixItemCfg[iter_8_1].params[1]] = iter_8_1
		end
	end

	self.astrolabeList = {}

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		table.insert(self.astrolabeList, iter_8_3)
	end

	self:Refresh()
end

function MatrixProcessAstrolabeReplaceView:OnTop()
	manager.windowBar:SwitchBar({})
end

function MatrixProcessAstrolabeReplaceView:OnExit()
	manager.windowBar:HideBar()
end

function MatrixProcessAstrolabeReplaceView:Refresh()
	self.selectItemIndex = 1

	self.item_:Refresh(self.astrolabeId)
	self.list_:StartScroll(#self.astrolabeList)
end

function MatrixProcessAstrolabeReplaceView:indexItem(arg_12_1, arg_12_2)
	arg_12_2:RegistCallBack(handler(self, self.OnItemClick))
	arg_12_2:Refresh(self.astrolabeList[arg_12_1], arg_12_1, self.astrolabeId)
	arg_12_2:SetSelected(arg_12_1 == self.selectItemIndex)
end

function MatrixProcessAstrolabeReplaceView:OnItemClick(arg_13_1)
	if arg_13_1 == self.selectItemIndex then
		return
	end

	self.selectItemIndex = arg_13_1

	for iter_13_0, iter_13_1 in pairs((self.list_:GetItemList())) do
		iter_13_1:SetSelected(iter_13_1:GetIndex() == self.selectItemIndex)
	end
end

function MatrixProcessAstrolabeReplaceView:Dispose()
	self.item_:Dispose()
	self.list_:Dispose()
	MatrixProcessAstrolabeReplaceView.super.Dispose(self)
end

function MatrixProcessAstrolabeReplaceView:GetHeroData(arg_15_1)
	return MatrixData:GetHeroData(arg_15_1)
end

return MatrixProcessAstrolabeReplaceView
