local StrategyMatrixTreasurePage = class("StrategyMatrixTreasurePage", (import("game.views.newHero.HeroPageBase")))

function StrategyMatrixTreasurePage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function StrategyMatrixTreasurePage:Init()
	self:InitUI()
end

function StrategyMatrixTreasurePage:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixTreasureAtlasItem)
end

function StrategyMatrixTreasurePage:OnEnter(arg_4_1, arg_4_2)
	self.heroViewProxy_ = arg_4_1
	self.isHided = true
	self.params_ = arg_4_2

	self:UpdateView()
end

function StrategyMatrixTreasurePage:UpdateView()
	self:SetMatirxHeroInfo(self.params_.matrix_activity_id)
end

function StrategyMatrixTreasurePage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function StrategyMatrixTreasurePage:SetMatirxHeroInfo(arg_7_1, arg_7_2)
	self.matrix_activity_id = arg_7_1
	self.data = self:GetArtifactList()

	table.sort(self.data, function(arg_8_0, arg_8_1)
		if MatrixItemCfg[arg_8_0.id].rare ~= MatrixItemCfg[arg_8_1.id].rare then
			return MatrixItemCfg[arg_8_0.id].rare > MatrixItemCfg[arg_8_1.id].rare
		end

		return arg_8_0.id < arg_8_1.id
	end)
	self.list_:StartScroll(#self.data)
end

function StrategyMatrixTreasurePage:indexItem(arg_9_1, arg_9_2)
	arg_9_2:Refresh(self.data[arg_9_1].id, self.data[arg_9_1].wins)
end

function StrategyMatrixTreasurePage:Hide()
	SetActive(self.gameObject_, false)
end

function StrategyMatrixTreasurePage:Show()
	SetActive(self.gameObject_, true)
end

function StrategyMatrixTreasurePage:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	self.list_:Dispose()
	StrategyMatrixTreasurePage.super.Dispose(self)
end

function StrategyMatrixTreasurePage:GetArtifactList()
	return StrategyMatrixData:GetArtifactList(self.matrix_activity_id)
end

return StrategyMatrixTreasurePage
