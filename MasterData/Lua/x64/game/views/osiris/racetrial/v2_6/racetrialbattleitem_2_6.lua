local RaceTrialBattleItem_2_6 = class("RaceTrialBattleItem_2_6", (import("game.views.osiris.raceTrial.RaceTrialBattleItem")))

function RaceTrialBattleItem_2_6:RefreshRace()
	self.raceIcon_.sprite = getSprite("Atlas/JapanRegionUI_2_6", tostring(self.cfg_.race))
end

return RaceTrialBattleItem_2_6
