local RaceTrialBattleItem_2_1 = class("RaceTrialBattleItem_2_1", (import("game.views.osiris.raceTrial.RaceTrialBattleItem")))

function RaceTrialBattleItem_2_1:RefreshRace()
	self.raceNameIcon_.sprite = getSprite("Atlas/XuHeng2ndUI", string.format("name_%d", self.cfg_.race))
	self.raceIcon_.sprite = getSprite("Atlas/XuHeng2ndUI", tostring(self.cfg_.race))
end

return RaceTrialBattleItem_2_1
