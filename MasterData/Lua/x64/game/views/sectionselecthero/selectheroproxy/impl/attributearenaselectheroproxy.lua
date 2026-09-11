local AttributeArenaSelectHeroProxy = class("AttributeArenaSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function AttributeArenaSelectHeroProxy:InitCustomParams(arg_1_1)
	self.attribute_arena_id = arg_1_1.attribute_arena_id
end

function AttributeArenaSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/heroTeamInfoAttributeArena"
end

function AttributeArenaSelectHeroProxy:GetCustomeTeamInfoParams(arg_3_1)
	return {
		attribute_arena_id = self.attribute_arena_id
	}
end

function AttributeArenaSelectHeroProxy:GetStageData()
	return BattleActivityAttributeArenaTemplate.New(self.stageID, self.activityID, self.attribute_arena_id)
end

return AttributeArenaSelectHeroProxy
