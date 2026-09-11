local PushBoxSelectHeroProxy = class("PushBoxSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function PushBoxSelectHeroProxy:InitCustomParams(arg_1_1)
	self.destID = arg_1_1.dest_id
end

function PushBoxSelectHeroProxy:GetStageData()
	return BattleActivityPushBoxTemplate.New(self.stageID, self.activityID, self.destID)
end

return PushBoxSelectHeroProxy
