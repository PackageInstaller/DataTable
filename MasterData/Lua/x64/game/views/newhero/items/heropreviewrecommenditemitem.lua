local HeroPreviewReCommendItemItem = class("HeroPreviewReCommendItemItem", ReduxView)

function HeroPreviewReCommendItemItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitUI()
end

function HeroPreviewReCommendItemItem:InitUI()
	self.haveController_ = self.controller_:GetController("have")
	self.colorController_ = self.controller_:GetController("color")
end

function HeroPreviewReCommendItemItem:RefreshData(arg_3_1, arg_3_2, arg_3_3)
	self.curHeroID_ = arg_3_3

	for iter_3_0 = 1, 3 do
		if arg_3_2 == iter_3_0 then
			self:RefreshColor(arg_3_1.hero_id[iter_3_0])
			self:RefreshHave(arg_3_1.hero_id[iter_3_0])

			self.posTxt_.text = GetI18NText(arg_3_1.hero_desc[iter_3_0])
			self.roleHead_.sprite = SpritePathCfg.HeroMediumIcon.path .. arg_3_1.hero_id[iter_3_0]

			break
		end
	end
end

function HeroPreviewReCommendItemItem:RefreshColor(arg_4_1)
	if self.curHeroID_ == arg_4_1 then
		self.colorController_:SetSelectedState("true")
	else
		self.colorController_:SetSelectedState("false")
	end
end

function HeroPreviewReCommendItemItem:RefreshHave(arg_5_1)
	if HeroTools.GetHeroIsUnlock(arg_5_1) then
		self.haveController_:SetSelectedState("true")
	else
		self.haveController_:SetSelectedState("false")
	end

	if self.curHeroID_ == arg_5_1 then
		self.haveController_:SetSelectedState("true")
	end
end

return HeroPreviewReCommendItemItem
