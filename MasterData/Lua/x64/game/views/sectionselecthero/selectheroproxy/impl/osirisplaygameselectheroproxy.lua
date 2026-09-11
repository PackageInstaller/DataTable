local OsirisPlayGameSelectHeroProxy = class("OsirisPlayGameSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function OsirisPlayGameSelectHeroProxy:GetHeroInfoItemClass()
	return OsirisPlayGameSelectHeroInfoItem
end

function OsirisPlayGameSelectHeroProxy:GetAdditionalViewClass()
	return OsirisPlayGameSectionAdditionalView
end

function OsirisPlayGameSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/osirisPlayGameHeroTeamInfoView"
end

function OsirisPlayGameSelectHeroProxy:GetSimilarityClass()
	return OsirisPlayGameSimilarityView
end

function OsirisPlayGameSelectHeroProxy:InitCustomParams(arg_5_1)
	self.canHeroDrag = false
	self.needComboSkillPanel = false
	self.canChangeComboSkill = false
	self.needMimirPanel = false
	self.canChangeMimir = false
	self.needReserveProposalPanel = false
	self.canChangeReserveProposal = false
	self.needReorderTeam = false
end

return OsirisPlayGameSelectHeroProxy
