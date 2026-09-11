local SailBattleEventView = class("SailBattleEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailBattleEventView:AcceptEvent()
	self:Go("/sectionSelectHero", {
		section = SailGameEventCfg[self.eventID_].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.SAIL_GAME,
		activityID = self.activityID_,
		customBarList = {
			BACK_BAR
		}
	})
end

function SailBattleEventView:RefreshReward()
	local var_2_0 = getRewardFromDropCfg(BattleSailGameStageCfg[SailGameEventCfg[self.eventID_].stage_id].drop_lib_id, true)[1]

	self.rewardIcon_.sprite = ItemTools.getItemSprite(var_2_0.id)
	self.rewardNumText_.text = var_2_0.num
end

return SailBattleEventView
