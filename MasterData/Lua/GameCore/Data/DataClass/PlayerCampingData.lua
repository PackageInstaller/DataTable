local PlayerCampingData = class("PlayerCampingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")

function PlayerCampingData:Init()
  EventManager.Add("OnEvent_CampingEnter", self, self.OnEvent_CampingEnter)
  EventManager.Add("OnEvent_CampingLevelLoadComplete", self, self.LevelLoadComplete)
end

function PlayerCampingData:OnEvent_CampingEnter()
  NovaAPI.EnterModule("CampingModuleScene", true)
end

function PlayerCampingData:LevelLoadComplete()
  EventManager.Hit(EventId.OpenPanel, PanelId.CampingJoystick)
end

return PlayerCampingData
