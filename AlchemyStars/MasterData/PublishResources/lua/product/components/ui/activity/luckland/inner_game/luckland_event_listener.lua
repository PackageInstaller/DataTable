require("game_event_type")
_class("LuckLandEventListener", Object)
LuckLandEventListener = LuckLandEventListener

function LuckLandEventListener:Constructor(luckLandGame)
  self._game = luckLandGame
  self._autoBinder = AutoEventBinder:New(self._game:EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.LuckLandRoundStart, self, self._RoundStart)
  self._autoBinder:BindEvent(GameEventType.LuckLandMonsterTurn, self, self._MonsterTurn)
  self._autoBinder:BindEvent(GameEventType.LuckLandRoundEnd, self, self._RoundEnd)
  self._autoBinder:BindEvent(GameEventType.LuckLandSelectCard, self, self._SelectCard)
  self._autoBinder:BindEvent(GameEventType.LuckLandSkip, self, self._Skip)
  self._autoBinder:BindEvent(GameEventType.LuckLandReDraw, self, self._ReDraw)
  self._autoBinder:BindEvent(GameEventType.LuckLandUpgrade, self, self._Upgrade)
  self._autoBinder:BindEvent(GameEventType.LuckLandDeleteCard, self, self._DeleteCard)
end

function LuckLandEventListener:Dispose()
  self._autoBinder:UnBindAllEvents()
end

function LuckLandEventListener:_RoundStart()
  local llModule = self._game:GetLuckLandModule()
  llModule:RoundStart()
end

function LuckLandEventListener:_MonsterTurn()
  local llModule = self._game:GetLuckLandModule()
  llModule:MonsterTurn()
end

function LuckLandEventListener:_RoundEnd()
  local llModule = self._game:GetLuckLandModule()
  llModule:RoundEnd()
end

function LuckLandEventListener:_SelectCard(petTemplateID, pos)
  local llModule = self._game:GetLuckLandModule()
  llModule:SelectCard(petTemplateID, pos)
end

function LuckLandEventListener:_Skip()
  local llModule = self._game:GetLuckLandModule()
  llModule:SkipSelectCard()
end

function LuckLandEventListener:_ReDraw()
  local llModule = self._game:GetLuckLandModule()
  llModule:ReDrawCard()
end

function LuckLandEventListener:_Upgrade(buildingID)
  local llModule = self._game:GetLuckLandModule()
  llModule:BuildingUpgrade(buildingID)
end

function LuckLandEventListener:_DeleteCard(petID)
  local llModule = self._game:GetLuckLandModule()
  llModule:DeleteCard(petID)
end
