local MatrixProcessEquipReplaceView = class("MatrixProcessEquipReplaceView", ReduxView)

function MatrixProcessEquipReplaceView:UIName()
	return "UI/Matrix/Process/MatrixProcessEquipReplaceUI"
end

function MatrixProcessEquipReplaceView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixProcessEquipReplaceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixProcessEquipReplaceView:InitUI()
	self:BindCfgUI()

	self.item_ = MatrixProcessRewardItem.New(self.m_item)
	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixProcessRewardItem)
end

function MatrixProcessEquipReplaceView:AddUIListener()
	self:AddBtnListener(self.m_okBtn, nil, function()
		if self.params_.callback then
			self.params_.callback(self.equipData[self.selectItemIndex])
		end

		self:Back()
	end)
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
end

function MatrixProcessEquipReplaceView:OnEnter()
	self.heroId = self.params_.heroId
	self.equipId = self.params_.equipId
	self.equipData = self:GetHeroData(self.heroId):GetEquipList()

	self:Refresh()
end

function MatrixProcessEquipReplaceView:OnTop()
	manager.windowBar:SwitchBar({})
end

function MatrixProcessEquipReplaceView:OnExit()
	manager.windowBar:HideBar()
end

function MatrixProcessEquipReplaceView:Refresh()
	self.selectItemIndex = 1

	self.item_:Refresh(self.equipId)
	self.list_:StartScroll(#self.equipData)
end

function MatrixProcessEquipReplaceView:indexItem(arg_12_1, arg_12_2)
	arg_12_2:RegistCallBack(handler(self, self.OnItemClick))
	arg_12_2:Refresh(self.equipData[arg_12_1], arg_12_1)
	arg_12_2:SetSelected(arg_12_1 == self.selectItemIndex)
end

function MatrixProcessEquipReplaceView:OnItemClick(arg_13_1)
	if arg_13_1 == self.selectItemIndex then
		return
	end

	self.selectItemIndex = arg_13_1

	for iter_13_0, iter_13_1 in pairs((self.list_:GetItemList())) do
		iter_13_1:SetSelected(iter_13_1:GetIndex() == self.selectItemIndex)
	end
end

function MatrixProcessEquipReplaceView:Dispose()
	self.item_:Dispose()
	self.list_:Dispose()
	MatrixProcessEquipReplaceView.super.Dispose(self)
end

function MatrixProcessEquipReplaceView:GetHeroData(arg_15_1)
	return MatrixData:GetHeroData(arg_15_1)
end

return MatrixProcessEquipReplaceView
