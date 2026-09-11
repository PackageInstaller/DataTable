local VolumeDownRaceTrialBattleItem = class("VolumeDownRaceTrialBattleItem", (import("game.views.osiris.raceTrial.RaceTrialBattleItem")))

function VolumeDownRaceTrialBattleItem:RefreshRace()
	if self.raceCon_ then
		self.raceCon_:SetSelectedState(tostring(self.cfg_.race))
	end

	self.raceIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/VolumeIIIDownChellgeUI/" .. self.cfg_.race)
end

return VolumeDownRaceTrialBattleItem
