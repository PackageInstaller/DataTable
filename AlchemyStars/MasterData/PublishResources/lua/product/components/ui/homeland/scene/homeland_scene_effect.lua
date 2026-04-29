_class("HomelandSceneEffect", Object)
HomelandSceneEffect = HomelandSceneEffect

function HomelandSceneEffect:Constructor(ids, effectName, inAni, loopAni, outAni)
  self._Ids = ids
  self._Req = ResourceManager:GetInstance():SyncLoadAsset(effectName, LoadType.GameObject)
  if self._Req == nil then
    Log.error("HomelandSceneEffect SyncLoadAsset error ", effectName)
  end
  self._Obj = self._Req.Obj
  self._visible = false
  self._Obj:SetActive(self._visible)
  self._InAni = inAni
  self._LoopAni = loopAni
  self._OutAni = outAni
  self._EftAni = self._Obj:GetComponent("Animation")
  self._InTimer = nil
  self._LoopTimer = nil
  self._OutTimer = nil
end

function HomelandSceneEffect:SetScale(value)
  self._Obj.transform.localScale = value
end

function HomelandSceneEffect:SetVisible(value)
  if self._visible == value then
    return
  end
  self._visible = value
  self._Obj:SetActive(self._visible)
end

function HomelandSceneEffect:UpdatePosRota(pos, rota)
  if self._visible == false then
    return
  end
  self._Obj.transform.position = pos
  self._Obj.transform.rotation = rota
end

function HomelandSceneEffect:SetPos(pos)
  self._Obj.transform.position = pos
end

function HomelandSceneEffect:SetRota(rota)
  self._Obj.transform.rotation = rota
end

function HomelandSceneEffect:Execute()
  self:SetVisible(true)
  self:PlayIn()
end

function HomelandSceneEffect:Exit()
  if self:PlayOut() == false then
    self:KillSelf()
  end
end

function HomelandSceneEffect:KillSelf()
  local homeModule = GameGlobal.GetUIModule(HomelandModule)
  local homeClient = homeModule:GetClient()
  local effMng = homeClient:GetHomelandSceneEffectManager()
  effMng:DeletEffect(self._Ids)
end

function HomelandSceneEffect:Dispose()
  if self._InTimer ~= nil then
    GameGlobal.Timer():CancelEvent(self._InTimer)
  end
  if self._LoopTimer ~= nil then
    GameGlobal.Timer():CancelEvent(self._LoopTimer)
  end
  if self._OutTimer ~= nil then
    GameGlobal.Timer():CancelEvent(self._OutTimer)
  end
  if self._Req ~= nil then
    self._Obj:SetActive(false)
    self._Req:Dispose()
  end
  self._visible = false
  self._Obj = nil
  self._Req = nil
end

function HomelandSceneEffect:PlayIn()
  if self._EftAni ~= nil and self._InAni ~= nil and self._InAni ~= "" and self._EftAni:Play(self._InAni) == true then
    local tt = self._EftAni:GetClip(self._InAni).length * 1000
    self._InTimer = GameGlobal.Timer():AddEvent(tt, function()
      self._InTimer = nil
      self:PlayLoop()
    end)
  end
end

function HomelandSceneEffect:PlayLoop()
  if self._EftAni ~= nil and self._LoopAni ~= nil and self._LoopAni ~= "" and self._EftAni:Play(self._LoopAni) == true then
    local tt = self._EftAni:GetClip(self._LoopAni).length * 1000
    self._LoopTimer = GameGlobal.Timer():AddEvent(tt, function()
      self._LoopTimer = nil
    end)
  end
end

function HomelandSceneEffect:PlayOut()
  if self._EftAni == nil then
    return false
  end
  if self._OutAni ~= nil and self._OutAni ~= "" and self._EftAni:Play(self._OutAni) == true then
    local tt = self._EftAni:GetClip(self._OutAni).length * 1000
    self._OutTimer = GameGlobal.Timer():AddEvent(tt, function()
      self._OutTimer = nil
      self:KillSelf()
    end)
    return true
  end
  self._EftAni:Stop()
  return false
end
