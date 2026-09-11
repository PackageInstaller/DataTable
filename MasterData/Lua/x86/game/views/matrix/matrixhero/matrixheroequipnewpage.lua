local MatrixHeroEquipNewPage = class("MatrixHeroEquipNewPage", (import("game.views.newHero.HeroPageBase")))

function MatrixHeroEquipNewPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function MatrixHeroEquipNewPage:Init()
	self:InitUI()
end

function MatrixHeroEquipNewPage:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixHeroEquipItem)
end

function MatrixHeroEquipNewPage:OnEnter(arg_4_1)
	self.heroViewProxy_ = arg_4_1
end

function MatrixHeroEquipNewPage:SetHeroInfo(arg_5_1)
	self.heroInfo_ = arg_5_1
	self.equipListData_ = StrategyMatrixData:GetEquipDataListNew(arg_5_1.id)
end

function MatrixHeroEquipNewPage:UpdateView()
	self.list_:StartScroll(#self.equipListData_)

	self.m_countLab.text = #self.equipListData_ .. "/" .. self:GetHeroEquipMaxCount()
end

function MatrixHeroEquipNewPage:indexItem(arg_7_1, arg_7_2)
	arg_7_2:Refresh(self.equipListData_[arg_7_1])
end

function MatrixHeroEquipNewPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function MatrixHeroEquipNewPage:Show()
	SetActive(self.gameObject_, true)
	self:UpdateView()
end

function MatrixHeroEquipNewPage:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	self.list_:Dispose()
	MatrixHeroEquipNewPage.super.Dispose(self)
end

function MatrixHeroEquipNewPage:OnExit()
	return
end

function MatrixHeroEquipNewPage:GetHeroEquipMaxCount()
	return StrategyMatrixData:GetHeroEquipMaxCount()
end

return MatrixHeroEquipNewPage
