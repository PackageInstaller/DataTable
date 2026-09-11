local SpringFestivalZumaTalentDescItem = class("SpringFestivalZumaTalentDescItem", ReduxView)

function SpringFestivalZumaTalentDescItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function SpringFestivalZumaTalentDescItem:InitUI()
	self:BindCfgUI()
end

function SpringFestivalZumaTalentDescItem:RefreshUI(arg_3_1)
	if self.titleText_ then
		self.titleText_.text = ActivityZumaTalentCfg[arg_3_1].name
	end

	self.descText_.text = ActivityZumaTalentCfg[arg_3_1].desc
end

function SpringFestivalZumaTalentDescItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SpringFestivalZumaTalentDescItem:Dispose()
	SpringFestivalZumaTalentDescItem.super.Dispose(self)
end

return SpringFestivalZumaTalentDescItem
