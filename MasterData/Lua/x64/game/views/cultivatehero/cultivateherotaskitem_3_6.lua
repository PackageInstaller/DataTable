local CultivateHeroTaskItem_3_6 = class("CultivateHeroTaskItem_3_6", (import("game.views.cultivateHero.CultivateHeroTaskItem")))

function CultivateHeroTaskItem_3_6:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardState_ = self.controllerEx_:GetController("status")
end

return CultivateHeroTaskItem_3_6
