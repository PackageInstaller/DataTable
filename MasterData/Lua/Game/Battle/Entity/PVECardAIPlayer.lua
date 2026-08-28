--
-- Author:luqucheng
-- Date: 2021-10-29 16:02:00
--
local CardController = import('Game.Battle.Entity.CardController')
local PVECardAIPlayer = Class("Player", CardController)

PVECardAIPlayer.inputCallback = nil

function PVECardAIPlayer:OnRequireInput( callback, refInputSkills )
    CardController.OnRequireInput(self, callback, refInputSkills)

    -- self.inputCallback({})
    self:HostOneTurn()
end




return PVECardAIPlayer