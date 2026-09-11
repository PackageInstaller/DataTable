local OsirisPlayGameSelectHeroInfoItem = class("OsirisPlayGameSelectHeroInfoItem", (import("game.views.sectionSelectHero.SectionSelectHeroInfoItem")))

function OsirisPlayGameSelectHeroInfoItem:InitController()
	OsirisPlayGameSelectHeroInfoItem.super.InitController(self)

	self.osirisController_ = self.controllerExCollection_:GetController("Osiris")
end

function OsirisPlayGameSelectHeroInfoItem:RefreshUI()
	OsirisPlayGameSelectHeroInfoItem.super.RefreshUI(self)
	self:RefreshOsiris()
end

function OsirisPlayGameSelectHeroInfoItem:RefreshOsiris()
	if self.heroID_ and self.heroID_ ~= 0 then
		self.osirisController_:SetSelectedState(tostring((self:GetValid(self.heroID_, ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.sectionProxy_.stageID][1]].generality))))
	end
end

function OsirisPlayGameSelectHeroInfoItem:GetValid(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(ActivityGeneralityCharactorCfg[arg_4_1].generality) do
		if arg_4_2 == iter_4_1 then
			return true
		end
	end

	return false
end

function OsirisPlayGameSelectHeroInfoItem:RefreshPost()
	self.postController_:SetSelectedState("true")
end

return OsirisPlayGameSelectHeroInfoItem
