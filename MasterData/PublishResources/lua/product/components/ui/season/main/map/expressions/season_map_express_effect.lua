_class("SeasonMapExpressEffect", SeasonMapExpressBase)
SeasonMapExpressEffect = SeasonMapExpressEffect

function SeasonMapExpressEffect:Constructor(cfg, eventPoint)
  self._content = self._cfg.Effect
  self._time = 0
  self._effectReqs = {}
  self._player = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonPlayerManager():GetPlayer()
  self._executing = false
end

function SeasonMapExpressEffect:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and self._executing then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._executing = false
      self:Next()
    end
  end
end

function SeasonMapExpressEffect:Dispose()
  self.super.Dispose(self)
  for _, _req in pairs(self._effectReqs) do
    _req:Dispose()
  end
  table.clear(self._effectReqs)
end

function SeasonMapExpressEffect:OnPlay()
  self._executing = false
  if self._content.length then
    self._time = self._content.length * 1000
  end
  local eventEffect = self._content.eventeffect
  local eventHolder = self._content.eventholder
  local playerEffect = self._content.playereffect
  local playerHolder = self._content.playerholder
  if eventEffect then
    local eventReq = ResourceManager:GetInstance():SyncLoadAsset(eventEffect .. ".prefab", LoadType.GameObject)
    if eventReq and eventReq.Obj then
      local bone = self._eventPoint:GetBoneNode(eventHolder)
      local effect = eventReq.Obj
      effect:SetActive(true)
      effect.transform:SetParent(bone)
      effect.transform.localPosition = Vector3.zero
      effect.transform.localRotation = Quaternion.Euler(0, 0, 0)
      self._effectReqs[eventReq] = eventReq
    end
  end
  if playerEffect then
    local playerReq = ResourceManager:GetInstance():SyncLoadAsset(playerEffect .. ".prefab", LoadType.GameObject)
    if playerReq and playerReq.Obj then
      local bone = self._player:GetBoneNode(playerHolder)
      local effect = playerReq.Obj
      effect:SetActive(true)
      effect.transform:SetParent(bone)
      effect.transform.localPosition = Vector3.zero
      effect.transform.localRotation = Quaternion.Euler(0, 0, 0)
      self._effectReqs[playerReq] = playerReq
    end
  end
  self._state = SeasonExpressState.Playing
end
