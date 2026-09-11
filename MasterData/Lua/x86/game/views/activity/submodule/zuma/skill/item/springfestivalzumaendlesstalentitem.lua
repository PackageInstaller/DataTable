local SpringFestivalZumaEndlessTalentItem = class("SpringFestivalZumaEndlessTalentItem", ReduxView)

function SpringFestivalZumaEndlessTalentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function SpringFestivalZumaEndlessTalentItem:InitUI()
	self:BindCfgUI()

	self.lockController = self.controller_:GetController("lock")
end

function SpringFestivalZumaEndlessTalentItem:SetData(arg_3_1)
	self.talentID = arg_3_1
	self.scoreTxt_.text = ActivityZumaTalentCfg[arg_3_1].need
	self.describeTxt_.text = ActivityZumaTalentCfg[arg_3_1].desc

	self:RefreshUI()
end

function SpringFestivalZumaEndlessTalentItem:RefreshUI()
	if (ZumaData:GetEndlessScore() or 0) >= ActivityZumaTalentCfg[self.talentID].need then
		self.lockController:SetSelectedState("unlock")
	else
		self.lockController:SetSelectedState("lock")
	end
end

function SpringFestivalZumaEndlessTalentItem:Dispose()
	SpringFestivalZumaEndlessTalentItem.super.Dispose(self)
end

return SpringFestivalZumaEndlessTalentItem
