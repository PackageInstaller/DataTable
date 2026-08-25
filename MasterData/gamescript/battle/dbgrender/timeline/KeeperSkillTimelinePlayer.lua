local KeeperSkillTimelinePlayer, Super = System.NewClass("KeeperSkillTimelinePlayer", BattleAwakerTimelinePlayer)
local TypeOfSkeletonAnimation = typeof(CS.Spine.Unity.SkeletonAnimation)
local TypeOfTransform = typeof(CS.UnityEngine.Transform)
local TypeOfFollowTargetComp = typeof(CS.AMFollowTarget)
local KeeperGoNameMap = {
  [CommonDefine.GenderID.Boy] = "BUnit_Keeper_Male_TL(Clone)",
  [CommonDefine.GenderID.Girl] = "BUnit_Keeper_Female_TL(Clone)"
}
KeeperSkillTimelinePlayer._keeperGoCache = KeeperSkillTimelinePlayer._keeperGoCache or {}
local KeeperTimelineGap = 0.1
local KeeperTimelineDuraDefault = 3

function KeeperSkillTimelinePlayer:ctor(role)
  self.role = role
  local awaker = role:GetRandomAwaker()
  Super.ctor(self, awaker)
end

function KeeperSkillTimelinePlayer:PlayTimeline(assetPath, gameSpeed, looping, onComplete, onEvent, abortSignal, onStarted)
  self.awaker = self.role:GetRandomAwaker()
  self._timelineDuration = self:_GetTimelineDuration(assetPath)
  self:_EnsureKeeperPortraitActive()
  if bg.battleScene then
    bg.battleScene:SetCurTimelinePlayer(self.role)
  end
  BattleKeeperSkillAssetCache.Instance:PlayKeeperSkill(assetPath)
  Super.PlayTimeline(self, assetPath, gameSpeed, looping, onComplete, onEvent, abortSignal, function()
    self:OnTimelineStart()
    if onStarted then
      onStarted()
    end
  end)
end

function KeeperSkillTimelinePlayer:_GetTimelineDuration(assetPath)
  if not assetPath or not bg.DT.TimelineEventData then
    return KeeperTimelineDuraDefault
  end
  for _, group in pairs(bg.DT.TimelineEventData) do
    if type(group) == "table" then
      for _, data in pairs(group) do
        if type(data) == "table" and data.file == assetPath and data.duration then
          return data.duration
        end
      end
    end
  end
  return KeeperTimelineDuraDefault
end

function KeeperSkillTimelinePlayer:_FindKeeperGo(goName)
  local cached = KeeperSkillTimelinePlayer._keeperGoCache[goName]
  if cached and not IsNil(cached) then
    return cached
  end
  local go = CS.UnityEngine.GameObject.Find(goName)
  if go and not IsNil(go) then
    KeeperSkillTimelinePlayer._keeperGoCache[goName] = go
    return go
  end
  local sceneRoot = CS.UnityEngine.GameObject.Find("SceneRoot")
  if not sceneRoot or IsNil(sceneRoot) then
    return nil
  end
  local transforms = sceneRoot.transform:GetComponentsInChildren(TypeOfTransform, true)
  if not transforms then
    return nil
  end
  for i = 0, transforms.Length - 1 do
    local tf = transforms[i]
    if tf and tf.gameObject and tf.gameObject.name == goName then
      KeeperSkillTimelinePlayer._keeperGoCache[goName] = tf.gameObject
      return tf.gameObject
    end
  end
  return nil
end

function KeeperSkillTimelinePlayer:_EnableKeeperFollowTarget(keeperGo)
  if not keeperGo or IsNil(keeperGo) or not TypeOfFollowTargetComp then
    return
  end
  local followComps = keeperGo:GetComponentsInChildren(TypeOfFollowTargetComp, true)
  if not followComps then
    return
  end
  for i = 0, followComps.Length - 1 do
    local comp = followComps[i]
    if comp and not IsNil(comp) then
      comp.enabled = true
    end
  end
end

function KeeperSkillTimelinePlayer:_EnsureKeeperPortraitActive()
  local gender = bg.battleDataCenter:GetPlayerGender()
  local goName = KeeperGoNameMap[gender]
  if not goName then
    return
  end
  local go = self:_FindKeeperGo(goName)
  if go and not IsNil(go) then
    go:SetActive(true)
    self:_EnableKeeperFollowTarget(go)
  end
end

function KeeperSkillTimelinePlayer:OnTimelineStart()
  local hideNameMap = {
    [CommonDefine.GenderID.Boy] = "Female",
    [CommonDefine.GenderID.Girl] = "Male"
  }
  local gender = bg.battleDataCenter:GetPlayerGender()
  local hideName = hideNameMap[gender]
  self.amPlayer:HideTrack(hideName)
  local findName = KeeperGoNameMap[gender]
  local go = self:_FindKeeperGo(findName)
  if go and not IsNil(go) then
    go:SetActive(true)
    self:_EnableKeeperFollowTarget(go)
    local skeletionAnim = go:GetComponentInChildren(TypeOfSkeletonAnimation, true)
    if skeletionAnim then
      skeletionAnim.timeScale = bg.battleRender.gameSpeed
    end
  end
  local awaiterTime = (self._timelineDuration or KeeperTimelineDuraDefault) + KeeperTimelineGap
  Awaiter.Dispatch("KeeperSkillTimeline", awaiterTime, false)
end

function KeeperSkillTimelinePlayer:OnTLEvent(eventId, eventParam, eventParam1)
  if eventId == rc.TimeLineEvent.ShowAwakerPaintingById then
    if bg.battleScene then
      local awakerId = tonumber(eventParam)
      bg.battleScene:ShowAwakerPaintingById(awakerId, self.skillName)
    end
    return
  end
  Super.OnTLEvent(self, eventId, eventParam)
end

function KeeperSkillTimelinePlayer:SetSkillName(skillName)
  self.skillName = skillName
end

function KeeperSkillTimelinePlayer:OnTimelineComplete()
  Super.OnTimelineComplete(self)
  if self._awaiter then
    self._awaiter:SetCompleted()
    self._awaiter = nil
  end
end

function KeeperSkillTimelinePlayer:Dispose()
  KeeperSkillTimelinePlayer._keeperGoCache = {}
  Super.Dispose(self)
end

return KeeperSkillTimelinePlayer
