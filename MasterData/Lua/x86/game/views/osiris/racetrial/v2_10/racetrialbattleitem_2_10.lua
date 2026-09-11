local RaceTrialBattleItem_2_10 = class("RaceTrialBattleItem_2_10", (import("game.views.osiris.raceTrial.RaceTrialBattleItem")))

function RaceTrialBattleItem_2_10:RefreshRace()
	self.raceIcon_.sprite = getSprite("Atlas/JapanRegionUI_2_10", tostring(self.cfg_.race))
end

return RaceTrialBattleItem_2_10
