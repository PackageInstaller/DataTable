_class("SeasonPlayerManager", Object)
SeasonPlayerManager = SeasonPlayerManager

function SeasonPlayerManager:Constructor()
end

function SeasonPlayerManager:OnInit()
  self._seasonPlayer = SeasonPlayer:New()
end

function SeasonPlayerManager:OnAfterInit()
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local enterParam = uiSeasonModule:GetEnterSeasonParam()
  if enterParam then
    self._seasonPlayer:HandleEnter(enterParam)
  end
end

function SeasonPlayerManager:Update(deltaTime)
  self._seasonPlayer:Update(deltaTime)
end

function SeasonPlayerManager:Dispose(isExit)
  self._seasonPlayer:Dispose(isExit)
  self._seasonPlayer = nil
end

function SeasonPlayerManager:GetPlayer()
  return self._seasonPlayer
end
