local BattleTimelinedeprecated = System.NewClass("BattleTimelinedeprecated")
local GameObject = CS.UnityEngine.GameObject
local TimelineController = CS.Z1Client.TimelineController
local AbilityTimelineController = CS.Z1Client.AbilityTimelineController

function BattleTimelinedeprecated.SimplePlay(assetPath, onComplete, abortSignal)
  local timeline = BattleTimelinedeprecated.Get(assetPath)
  timeline:SetParent(bg.battleScene.sceneLayer)
  timeline:Play(onComplete, nil, abortSignal)
end

function BattleTimelinedeprecated.Preload(assetPath, poolRoot)
  Pool.CreateWithTag(BattleTimelinedeprecated, assetPath, 1, poolRoot)
end

function BattleTimelinedeprecated.Get(assetPath)
  do return Pool.GetWithTag, BattleTimelinedeprecated, assetPath end
  return Pool.GetWithTag, BattleTimelinedeprecated, assetPath, bg.battleScene.factoryLayer
end

function BattleTimelinedeprecated.Clear(assetPath)
  Pool.ClearWithTag(BattleTimelinedeprecated, assetPath)
end

function BattleTimelinedeprecated:ctor(assetPath, poolRoot)
  self.assetPath = assetPath
  self.poolRoot = poolRoot
  local prefab = ResLoadMgr.LoadAsset(assetPath, self)
  if nil ~= prefab then
    self.rootNode = GameObject.Instantiate(prefab, self.poolRoot)
    self.timelineController = self.rootNode:GetComponent(typeof(TimelineController))
    self.abilityController = self.rootNode:GetComponent(typeof(AbilityTimelineController))
    self.rootNode:SetActive(false)
  else
    Logger.Error("prefab is nil, assetPath =" .. assetPath)
  end
end

function BattleTimelinedeprecated:SetParent(parent)
  if self.rootNode == nil then
    return self
  end
  self.rootNode.transform:SetParent(parent)
  return self
end

function BattleTimelinedeprecated:SetTarget(caster, ace)
  if self.rootNode == nil then
    return self
  end
  if self.abilityController then
    self.abilityController:SetTarget(caster, ace)
  end
  return self
end

function BattleTimelinedeprecated:SetSpeed(gameSpeed)
  self.gameSpeed = gameSpeed
  return self
end

function BattleTimelinedeprecated:Play(onComplete, onEvent, abortSignal, scheme)
  if self.rootNode == nil then
    onComplete()
    return self
  end
  if abortSignal then
    abortSignal:AddListener(System.fn(self, self.OnAbort))
  end
  self.gameSpeed = self.gameSpeed or 1
  self.rootNode:SetActive(true)
  self.onComplete = onComplete
  self.timelineController:Play(function()
    if abortSignal then
      abortSignal:RemoveListener(System.fn(self, self.OnAbort))
    end
    if self.onComplete then
      self.onComplete()
    end
    self.pool:Free(self)
  end, self.gameSpeed, onEvent, scheme)
  return self
end

function BattleTimelinedeprecated:OnAbort()
  self.pool:Free(self)
end

function BattleTimelinedeprecated:Pause()
  if self.timelineController then
    self.timelineController:SetPause(true)
  end
end

function BattleTimelinedeprecated:Resume()
  if self.timelineController then
    self.timelineController:SetPause(false)
  end
end

function BattleTimelinedeprecated:OnRecycle()
  if self.rootNode == nil then
    return
  end
  self.rootNode:SetActive(false)
  self.onComplete = nil
  if nil ~= bg.battleScene then
    self.rootNode.transform:SetParent(self.poolRoot, false)
  end
end

function BattleTimelinedeprecated:Dispose()
  self.onComplete = nil
  if nil == self.rootNode then
    return
  end
  GameObject.Destroy(self.rootNode)
  self.rootNode = nil
  self.timelineController = nil
  self.abilityController = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

return BattleTimelinedeprecated
