local HeroPreviewReCommendItem = class("HeroPreviewReCommendItem", ReduxView)

function HeroPreviewReCommendItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitUI()
end

function HeroPreviewReCommendItem:InitUI()
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, HeroPreviewReCommendItemItem)
end

function HeroPreviewReCommendItem:indexItem(arg_3_1, arg_3_2)
	arg_3_2:RefreshData(self.cfg, arg_3_1, self.curHeroID_)
end

function HeroPreviewReCommendItem:RefreshData(arg_4_1, arg_4_2)
	self:Show(true)

	self.curHeroID_ = arg_4_2
	self.cfg = RecommandTeamCfg[arg_4_1]

	self.uiList_:StartScroll(3)
end

function HeroPreviewReCommendItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function HeroPreviewReCommendItem:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	HeroPreviewReCommendItem.super.Dispose(self)
end

return HeroPreviewReCommendItem
