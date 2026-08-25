local typeof = _ENV.typeof
local TYPEOF_ParticleSystem = typeof(CS.UnityEngine.ParticleSystem)
local TYPEOF_TimelineController = typeof(CS.Z1Client.TimelineController)
local GameObject = CS.UnityEngine.GameObject
local PSystemPlaybackSpdCtrl = CS.PSystemPlaybackSpdCtrl
local vectorOne = CS.UnityEngine.Vector3(1, 1, 1)
local BattleSfx, Super = System.NewClass("BattleSfx")

function BattleSfx:ctor(sfxPath, sfxConfig, root)
  self.sfxId = sfxConfig.ID
  self.root = root
  self.speed = 1
  self.configData = sfxConfig
  self.isUsing = false
  xpcall(function()
    local prefab = ResLoadMgr.LoadAsset(sfxPath, self)
    if nil ~= prefab then
      self.rootNode = GameObject.Instantiate(prefab, self.root)
      self.prelocalScale = self.rootNode.transform.localScale
      self.ps = self.rootNode:GetComponent(TYPEOF_ParticleSystem)
      self.timelineController = self.rootNode:GetComponent(TYPEOF_TimelineController)
      self.rootNode:SetActive(false)
    end
  end, debug.traceback)
end

function BattleSfx:Init(parent, pos, lifeTime, worldPositionStays, onExpired, abortSignal, scale)
  self.lifeTime = 0
  if self.rootNode == nil then
    return
  end
  self.isUsing = true
  local stays = true
  if nil ~= worldPositionStays then
    stays = worldPositionStays
  end
  self.isLoop = -1 == lifeTime
  self.rootNode.transform:SetParent(parent, stays)
  if nil ~= pos then
    self.rootNode.transform.position = pos
  end
  if nil ~= scale then
    if type(scale) == "number" then
      self.rootNode.transform.localScale = CS.UnityEngine.Vector3(scale, scale, 1)
    else
      self.rootNode.transform.localScale = scale
    end
  end
  self.rootNode:SetActive(true)
  self.abortSignal = abortSignal
  if abortSignal then
    abortSignal:AddListener(System.fn(self, self.OnAbort))
  end
  SettingManager:ResetParticleSystemLights(self.rootNode)
  self:ResetSpeedByCfg()
  if nil ~= self.timelineController then
    self.timelineController:Play(function()
      self:Expire()
    end)
    self.lifeTime = 0
    self.passTime = 0
  elseif nil ~= self.ps then
    self.ps:Play()
    self.lifeTime = lifeTime
    self.passTime = 0
  else
    self.lifeTime = lifeTime
    self.passTime = 0
  end
  self.onExpired = onExpired
end

function BattleSfx:ResetSpeedByCfg()
  local acceletateSpeed = 1
  if bg.battleRender.gameSpeed > 1 then
    acceletateSpeed = self.configData.AfterAccelerationPlaySpeed or 1
  end
  self:SetSimulateSpeed((bg.battleRender.gameSpeed or 1) * acceletateSpeed)
end

function BattleSfx:SetSimulateSpeed(speed)
  self.speed = speed
  PSystemPlaybackSpdCtrl.SetPSSpeed(self.rootNode, speed)
end

function BattleSfx:Expire()
  if self.abortSignal then
    self.abortSignal:RemoveListener(System.fn(self, self.OnAbort))
    self.abortSignal = nil
  end
  if nil ~= self.onExpired then
    self.onExpired(self)
  end
  self.pool:Free(self)
end

function BattleSfx:Abort()
  self:OnAbort()
end

function BattleSfx:OnAbort()
  self.pool:Free(self)
end

function BattleSfx:OnRecycle()
  self.isUsing = false
  if self.abortSignal then
    self.abortSignal:RemoveListener(System.fn(self, self.OnAbort))
    self.abortSignal = nil
  end
  self.onExpired = nil
  if nil == self.rootNode then
    return
  end
  if IsNil(self.rootNode) then
    self.rootNode = nil
    return
  end
  self.rootNode:SetActive(false)
  self.rootNode.transform:SetParent(self.root, false)
  self.rootNode.transform.localScale = self.prelocalScale or vectorOne
end

function BattleSfx:Dispose()
  ResLoadMgr.UnloadAssetByTarget(self)
  if self.abortSignal then
    self.abortSignal:RemoveListener(System.fn(self, self.OnAbort))
    self.abortSignal = nil
  end
  self.onExpired = nil
  if nil == self.rootNode then
    return
  end
  GameObject.Destroy(self.rootNode)
  self.rootNode = nil
  self.ps = nil
  self.timelineController = nil
  self.root = nil
end

function BattleSfx:Tick(deltaTime)
  if not self.lifeTime or not self.passTime then
    self:Expire()
    return
  end
  if self.lifeTime > 0 then
    self.passTime = self.passTime + deltaTime * self.speed
    if self.passTime >= self.lifeTime then
      self:Expire()
    end
  end
end

return BattleSfx
