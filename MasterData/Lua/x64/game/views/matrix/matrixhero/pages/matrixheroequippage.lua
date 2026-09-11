local MatrixHeroEquipPage = class("MatrixHeroEquipPage", ReduxView)

function MatrixHeroEquipPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function MatrixHeroEquipPage:Init()
	self:InitUI()
end

function MatrixHeroEquipPage:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixHeroEquipItem)
end

function MatrixHeroEquipPage:SetMatirxHeroInfo(arg_4_1)
	self.heroId_ = arg_4_1
	self.equipListData_ = self:GetHeroData(arg_4_1):GetEquipList()

	self:UpdateView()
end

function MatrixHeroEquipPage:UpdateView()
	self.list_:StartScroll(#self.equipListData_)

	self.m_countLab.text = #self.equipListData_ .. "/" .. self:GetHeroEquipMaxCount()
end

function MatrixHeroEquipPage:indexItem(arg_6_1, arg_6_2)
	arg_6_2:Refresh(self.equipListData_[arg_6_1])
end

function MatrixHeroEquipPage:Hide()
	SetActive(self.gameObject_, false)
end

function MatrixHeroEquipPage:Show()
	SetActive(self.gameObject_, true)
end

function MatrixHeroEquipPage:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	self.list_:Dispose()
	MatrixHeroEquipPage.super.Dispose(self)
end

function MatrixHeroEquipPage:GetHeroData(arg_10_1)
	return MatrixData:GetHeroData(arg_10_1)
end

function MatrixHeroEquipPage:GetHeroEquipMaxCount()
	return MatrixData:GetHeroEquipMaxCount()
end

return MatrixHeroEquipPage
