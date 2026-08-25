local MeshRenderer = typeof(CS.UnityEngine.MeshRenderer)
local SkinnedMeshRenderer = typeof(CS.UnityEngine.SkinnedMeshRenderer)
local UnityObject = CS.UnityEngine.Object
local Vector4 = CS.UnityEngine.Vector4
local SpineMaterialReplace = CS.Z1Client.SpineMaterialReplace
local TimelineTargetSlashController = System.NewClass("TimelineTargetSlashController")
local SlashFlipPropertyName = "_SlashFlip"
local SlashProgressPropertyName = "_SlashProgress"
local SlashDistancePropertyName = "_SlashDistance"
local SlashDissolveProgressPropertyName = "_SlashDissolveProgress"
local RootOffsetPropertyName = "_RootOffset"
local GoldenBodyPropertyName = "_GoldenBody"
local BodyNodeName = "body"
local ShaderNamesNoInstance = {
  ["Z1/Actor/MonMain-Dissolve-StoneState_Diamond_CodeSix"] = true
}

function TimelineTargetSlashController:ctor()
  self._states = {}
end

function TimelineTargetSlashController:_GetOrAddSpineMaterialReplace(go)
  if not go then
    return nil
  end
  local spineMaterialReplace = go:GetComponent(typeof(SpineMaterialReplace))
  spineMaterialReplace = spineMaterialReplace or go:AddComponent(typeof(SpineMaterialReplace))
  return spineMaterialReplace
end

function TimelineTargetSlashController:_LockTargets(targets)
  if type(targets) ~= "table" then
    return
  end
  for _, ta in ipairs(targets) do
    if ta then
      ta.__tlslashMatLockCount = (ta.__tlslashMatLockCount or 0) + 1
    end
  end
end

function TimelineTargetSlashController:_UnlockTargets(targets)
  if type(targets) ~= "table" then
    return
  end
  for _, ta in ipairs(targets) do
    if ta and ta.__tlslashMatLockCount then
      local c = ta.__tlslashMatLockCount - 1
      ta.__tlslashMatLockCount = c > 0 and c or 0
    end
  end
end

function TimelineTargetSlashController:_GetEaseFunc(easeType)
  local easeFunc = TimelineEaseFunc.GetEaseFunction(easeType)
  return easeFunc or TimelineEaseFunc.Linear
end

function TimelineTargetSlashController:_GetOrCreateState(owner)
  local state = self._states[owner]
  if state then
    return state
  end
  state = {}
  self._states[owner] = state
  return state
end

function TimelineTargetSlashController:_CollectRenderersTryAdd(list, seen, r)
  if not r then
    return
  end
  local id = r:GetInstanceID()
  if seen[id] then
    return
  end
  seen[id] = true
  table.insert(list, r)
end

function TimelineTargetSlashController:_GetRootNodesByTarget(targets)
  local rootNodes = {}
  if type(targets) ~= "table" then
    targets = {targets}
  end
  for i = 1, #targets do
    local target = targets[i]
    if target and target.rootNode then
      table.insert(rootNodes, target.rootNode)
    end
  end
  return rootNodes
end

function TimelineTargetSlashController:_CollectRenderersInHierarchy(rootTfs)
  local list = {}
  local seen = {}
  if type(rootTfs) ~= "table" then
    rootTfs = {rootTfs}
  end
  for i = 1, #rootTfs do
    local rootTf = rootTfs[i]
    local meshes = rootTf:GetComponentsInChildren(MeshRenderer, true)
    local skins = rootTf:GetComponentsInChildren(SkinnedMeshRenderer, true)
    if meshes then
      for j = 0, meshes.Length - 1 do
        self:_CollectRenderersTryAdd(list, seen, meshes[j])
      end
    end
    if skins then
      for j = 0, skins.Length - 1 do
        self:_CollectRenderersTryAdd(list, seen, skins[j])
      end
    end
  end
  return list
end

function TimelineTargetSlashController:_IsRendererUnderTransform(renderer, ancestorTf)
  if not renderer or not ancestorTf then
    return false
  end
  local t = renderer.transform
  while t do
    if t == ancestorTf then
      return true
    end
    t = t.parent
  end
  return false
end

function TimelineTargetSlashController:_GetTransformPath(tf, maxDepth)
  if not tf then
    return "nil"
  end
  local depth = maxDepth or 16
  local parts = {}
  local t = tf
  while t and depth > 0 do
    table.insert(parts, 1, t.name or "nil")
    t = t.parent
    depth = depth - 1
  end
  do return table.concat, parts end
  return table.concat, parts, "/", t.name or "nil"
end

function TimelineTargetSlashController:_ComputeRootOffsetFromBodyChild(target)
  if not target or not target.rootNode then
    return nil
  end
  local bodyTf = CS.Framework.GameObjectUtil.DeepFindChild(target.rootNode.transform, BodyNodeName)
  if not bodyTf then
    return nil
  end
  local lp = bodyTf.localPosition
  local lx = lp.x
  local ly = lp.y
  local rootOffset = Vector4(lx, ly, 0, 0)
  return rootOffset
end

function TimelineTargetSlashController:_MaterialNameHasInstanceSuffix(mat)
  if not mat then
    return false
  end
  local n = mat.name
  if n and "" ~= n then
    if string.find(n, "(Instance)", 1, true) ~= nil then
      return true
    end
    if nil ~= string.find(n, "(Clone)", 1, true) then
      return true
    end
  end
  local sh = mat.shader
  if sh then
    local sn = sh.name
    if sn and "" ~= sn and ShaderNamesNoInstance[sn] then
      return true
    end
  end
  return false
end

function TimelineTargetSlashController:_CloneEntryMaterials(entry)
  local renderer = entry.renderer
  local originalSharedMaterials = renderer.sharedMaterials
  entry.originalSharedMaterials = originalSharedMaterials
  entry.instancedMaterials = nil
  entry.originalGoldenBodyBySlot = {}
  entry.originalRootOffsetBySlot = {}
  entry.cloneBySlot = {}
  if not originalSharedMaterials or originalSharedMaterials.Length <= 0 then
    return
  end
  local matArray = CS.System.Array.CreateInstance(typeof(CS.UnityEngine.Material), originalSharedMaterials.Length)
  for i = 0, originalSharedMaterials.Length - 1 do
    local src = originalSharedMaterials[i]
    if src then
      if self:_MaterialNameHasInstanceSuffix(src) then
        matArray[i] = src
        entry.cloneBySlot[i] = false
        if src:HasProperty(GoldenBodyPropertyName) then
          entry.originalGoldenBodyBySlot[i] = src:GetFloat(GoldenBodyPropertyName)
        end
        if src:HasProperty(RootOffsetPropertyName) then
          entry.originalRootOffsetBySlot[i] = src:GetVector(RootOffsetPropertyName)
        end
      else
        matArray[i] = UnityObject.Instantiate(src)
        entry.cloneBySlot[i] = true
        local inst = matArray[i]
        if inst and inst:HasProperty(GoldenBodyPropertyName) then
          entry.originalGoldenBodyBySlot[i] = inst:GetFloat(GoldenBodyPropertyName)
        end
      end
    end
  end
  renderer.sharedMaterials = matArray
  entry.instancedMaterials = renderer.sharedMaterials
  local smr = self:_GetOrAddSpineMaterialReplace(renderer.gameObject)
  if smr then
    entry.__tlslashSpineMaterialReplace = smr
    local mats = renderer.sharedMaterials
    if mats and mats.Length > 0 then
      smr:SetMaterial(mats[0])
    end
  end
end

function TimelineTargetSlashController:_ApplyRootOffsetForEntry(entry, rootOffsetOverride)
  if not entry.renderer or not entry.instancedMaterials then
    return
  end
  local rootOffset = rootOffsetOverride
  if nil == rootOffset then
    local bounds = entry.renderer.localBounds
    if not bounds then
      return
    end
    local c = bounds.center
    rootOffset = Vector4(c.x, c.y, 0, 0)
  end
  local mats = entry.instancedMaterials
  for i = 0, mats.Length - 1 do
    local mat = mats[i]
    if mat and mat:HasProperty(RootOffsetPropertyName) then
      mat:SetVector(RootOffsetPropertyName, rootOffset)
    end
  end
end

function TimelineTargetSlashController:_ApplySlashProgressEntry(entry, value)
  local mats = entry.instancedMaterials
  if not mats then
    return 0
  end
  local wroteCount = 0
  for i = 0, mats.Length - 1 do
    local mat = mats[i]
    if mat and mat:HasProperty(SlashProgressPropertyName) then
      mat:SetFloat(SlashProgressPropertyName, value)
      if mat:HasProperty(GoldenBodyPropertyName) then
        local origGolden = entry.originalGoldenBodyBySlot and entry.originalGoldenBodyBySlot[i]
        if nil == origGolden then
          origGolden = 1
        end
        mat:SetFloat(GoldenBodyPropertyName, (1 - value) * origGolden)
      end
      wroteCount = wroteCount + 1
    end
  end
  return wroteCount
end

function TimelineTargetSlashController:_ApplySlashDistanceAndFlipAll(entries, slashDistance, isFlip)
  if not entries then
    return
  end
  local v = tonumber(slashDistance or 0) or 0
  local f = isFlip or 1
  for _, entry in ipairs(entries) do
    local mats = entry.instancedMaterials
    if mats then
      for i = 0, mats.Length - 1 do
        local mat = mats[i]
        if mat and mat:HasProperty(SlashDistancePropertyName) then
          mat:SetFloat(SlashDistancePropertyName, v)
        end
        if mat and mat:HasProperty(SlashFlipPropertyName) then
          mat:SetFloat(SlashFlipPropertyName, f)
        end
      end
    end
  end
end

function TimelineTargetSlashController:_ApplySlashDissolveProgressEntry(entry, value)
  local mats = entry.instancedMaterials
  if not mats then
    return 0
  end
  local wroteCount = 0
  for i = 0, mats.Length - 1 do
    local mat = mats[i]
    if mat and mat:HasProperty(SlashDissolveProgressPropertyName) then
      mat:SetFloat(SlashDissolveProgressPropertyName, value)
      wroteCount = wroteCount + 1
    end
  end
  return wroteCount
end

function TimelineTargetSlashController:_ApplySlashDissolveProgressAll(entries, value)
  if not entries then
    return 0
  end
  local totalWrote = 0
  for _, entry in ipairs(entries) do
    totalWrote = totalWrote + self:_ApplySlashDissolveProgressEntry(entry, value)
  end
  return totalWrote
end

function TimelineTargetSlashController:_CancelPostSlash(state)
  if not state then
    return
  end
  state.postSlashPhase = nil
  state.postSlashElapsed = nil
  state.postSlashDoRestoreMats = nil
end

function TimelineTargetSlashController:_FinalizeSlashCleanup(owner, state, doDestroyMaterials, finishCb)
  local entries = state.rendererEntries
  local pendingAfter = state.pendingAfterSlashCleanupCb
  state.pendingAfterSlashCleanupCb = nil
  if entries and doDestroyMaterials then
    self:_DestroyRendererEntries(entries)
  end
  if finishCb then
    finishCb()
  end
  if pendingAfter then
    pendingAfter()
  end
  state.rendererEntries = nil
  state.slashEntries = nil
  state.phaseSignature = nil
  state.postSlashPhase = nil
  state.postSlashElapsed = nil
  state.postSlashDoRestoreMats = nil
  state._postSlashFinishCb = nil
  self._states[owner] = nil
  if nil == next(self._states) then
    UpdateBeat.Instance:Remove(self._Update, self)
  end
end

function TimelineTargetSlashController:_PostSlashComplete(state)
  if state.tlslashLockedTargets then
    self:_UnlockTargets(state.tlslashLockedTargets)
    state.tlslashLockedTargets = nil
  end
  state.tlslashParallelActive = nil
  local owner = state.owner
  local finishCb = state.finishCb or state._postSlashFinishCb
  state.finishCb = nil
  state._postSlashFinishCb = nil
  local doDestroy = state.postSlashDoRestoreMats == true
  self:_FinalizeSlashCleanup(owner, state, doDestroy, finishCb)
end

function TimelineTargetSlashController:_DestroyRendererEntries(entries)
  if not entries then
    return
  end
  for _, entry in ipairs(entries) do
    self:_RestoreEntry(entry)
  end
end

function TimelineTargetSlashController:_ApplySlashProgressAll(state, value)
  local entries = state.slashEntries or state.rendererEntries
  if not entries then
    return 0
  end
  local totalWrote = 0
  for _, entry in ipairs(entries) do
    totalWrote = totalWrote + self:_ApplySlashProgressEntry(entry, value)
  end
  state.tlslashDiagWriteCount = (state.tlslashDiagWriteCount or 0) + 1
  return totalWrote
end

function TimelineTargetSlashController:_RestoreEntry(entry)
  local mats = entry.instancedMaterials
  if not (mats and entry.renderer) or not entry.originalSharedMaterials then
    return
  end
  if entry.__tlslashSpineMaterialReplace then
    entry.__tlslashSpineMaterialReplace:SetMaterial(nil)
    entry.__tlslashSpineMaterialReplace = nil
  end
  for i = 0, mats.Length - 1 do
    local mat = mats[i]
    if mat then
      if entry.cloneBySlot[i] == true then
        local origGolden = entry.originalGoldenBodyBySlot and entry.originalGoldenBodyBySlot[i]
        if nil ~= origGolden and mat:HasProperty(GoldenBodyPropertyName) then
          mat:SetFloat(GoldenBodyPropertyName, origGolden)
        end
        print("tlslash _RestoreEntry destroying mat", mat.name)
        UnityObject.Destroy(mat)
      else
        local ro = entry.originalRootOffsetBySlot and entry.originalRootOffsetBySlot[i]
        if nil ~= ro and mat:HasProperty(RootOffsetPropertyName) then
          mat:SetVector(RootOffsetPropertyName, ro)
        end
        local origGolden = entry.originalGoldenBodyBySlot and entry.originalGoldenBodyBySlot[i]
        if nil ~= origGolden and mat:HasProperty(GoldenBodyPropertyName) then
          mat:SetFloat(GoldenBodyPropertyName, origGolden)
        end
      end
    end
  end
  entry.renderer.sharedMaterials = entry.originalSharedMaterials
  local restored = entry.renderer.sharedMaterials
  if restored then
    for i = 0, restored.Length - 1 do
      local m = restored[i]
      if m and m:HasProperty(SlashProgressPropertyName) then
        m:SetFloat(SlashProgressPropertyName, 0)
      end
      if m and m:HasProperty(SlashDissolveProgressPropertyName) then
        m:SetFloat(SlashDissolveProgressPropertyName, 0)
      end
    end
  end
end

function TimelineTargetSlashController:_BindSceneLayerSlashMaterials(state, targets)
  state.rendererEntries = nil
  state.slashEntries = nil
  local bs = bg.battleScene
  local sceneLayer = bs and bs.sceneLayer
  if not sceneLayer then
    return false
  end
  local rootnodes = self:_GetRootNodesByTarget(targets)
  local renderers = self:_CollectRenderersInHierarchy(rootnodes)
  if 0 == #renderers then
    return false
  end
  state.rendererEntries = {}
  for _, r in ipairs(renderers) do
    local entry = {renderer = r}
    self:_CloneEntryMaterials(entry)
    table.insert(state.rendererEntries, entry)
  end
  for _, ta in ipairs(targets) do
    if ta.rootNode then
      local rootOffsetSlash = self:_ComputeRootOffsetFromBodyChild(ta)
      local rootTf = ta.rootNode.transform
      for _, entry in ipairs(state.rendererEntries) do
        if self:_IsRendererUnderTransform(entry.renderer, rootTf) then
          self:_ApplyRootOffsetForEntry(entry, rootOffsetSlash)
        end
      end
    end
  end
  state.slashEntries = {}
  local slashSeen = {}
  for _, entry in ipairs(state.rendererEntries) do
    for _, ta in ipairs(targets) do
      if ta.rootNode and self:_IsRendererUnderTransform(entry.renderer, ta.rootNode.transform) then
        local rid = entry.renderer:GetInstanceID()
        if not slashSeen[rid] then
          slashSeen[rid] = true
          table.insert(state.slashEntries, entry)
        end
        break
      end
    end
  end
  return true
end

function TimelineTargetSlashController:_ComputePhaseSignature(targets)
  local sceneKey = "0"
  local rCount = 0
  local bs = bg.battleScene
  local sceneLayer = bs and bs.sceneLayer
  if sceneLayer then
    sceneKey = tostring(sceneLayer:GetInstanceID())
    rCount = #self:_CollectRenderersInHierarchy(sceneLayer)
  end
  local parts = {}
  for _, ta in ipairs(targets) do
    local rid = ta.rootNode and ta.rootNode.transform:GetInstanceID() or 0
    local uid = ta.uid or "nil"
    table.insert(parts, string.format("%s:%d", tostring(uid), rid))
  end
  table.sort(parts)
  do return string.format, "%s|%d|%s", sceneKey, rCount, table.concat(parts, ",") end
  return string.format, "%s|%d|%s", sceneKey, rCount, table.concat(parts, ",")
end

function TimelineTargetSlashController:_ParseParam(param)
  local arr = string.split(param or "", ",")
  local isFlip = tonumber(arr[1]) or 0
  local slashDistance = tonumber(arr[2]) or 0
  local fromValue = tonumber(arr[3]) or 0
  local toValue = tonumber(arr[4]) or 1
  local easeType = tonumber(arr[5]) or TimelineEaseType.linear
  local duration = tonumber(arr[6]) or 0
  local middlePause = tonumber(arr[7]) or 0
  local fromValueDissolve = tonumber(arr[8]) or 0
  local toValueDissolve = tonumber(arr[9]) or 0
  local easeTypeDissolve = tonumber(arr[10]) or TimelineEaseType.linear
  local durationDissolve = tonumber(arr[11]) or 0
  print(string.format([[
tlslash param raw=%s isFlip=%.3f slashDist=%.3f from=%.3f to=%.3f ease=%s dur=%.3f 
            dissolveDelay=%.3f dFrom=%.3f dTo=%.3f dEase=%s dDur=%.3f]], tostring(param), isFlip, slashDistance, fromValue, toValue, tostring(easeType), duration, middlePause, fromValueDissolve, toValueDissolve, tostring(easeTypeDissolve), durationDissolve))
  return isFlip, slashDistance, fromValue, toValue, easeType, duration, middlePause, fromValueDissolve, toValueDissolve, easeTypeDissolve, durationDissolve
end

function TimelineTargetSlashController:_ResolveAllTimelineTargets(owner)
  local list = {}
  if not owner then
    return list
  end
  local getFunc = owner.GetTimelineSlashTargets or owner.GetTimelineTargets
  if not getFunc then
    return {owner}
  end
  local i = 0
  while true do
    local target = getFunc(owner, i)
    if not target then
      break
    end
    if target.rootNode then
      table.insert(list, target)
    end
    i = i + 1
  end
  return list
end

function TimelineTargetSlashController:Start(owner, param, cb)
  if not owner then
    error("tlslash start failed!!!: owner nil")
    return
  end
  local prev = self._states[owner]
  if prev and prev.tlslashParallelActive then
    self:Restore(owner)
  end
  local isFlip, slashDistance, fromValue, toValue, easeType, duration, middlePause, fromValueDissolve, toValueDissolve, easeTypeDissolve, durationDissolve = self:_ParseParam(param)
  local targets = self:_ResolveAllTimelineTargets(owner)
  if 0 == #targets then
    error("tlslash start failed: target data invalid")
    return
  end
  local newSig = self:_ComputePhaseSignature(targets)
  local state = self:_GetOrCreateState(owner)
  local needRebind = not state.rendererEntries or state.phaseSignature ~= newSig or "" == newSig
  self:_LockTargets(targets)
  state.tlslashLockedTargets = targets
  if needRebind then
    self:Restore(owner)
    state = self:_GetOrCreateState(owner)
    state.tlslashLockedTargets = targets
    if not self:_BindSceneLayerSlashMaterials(state, targets) then
      self:_UnlockTargets(targets)
      state.tlslashLockedTargets = nil
      return
    end
    state.phaseSignature = newSig
  end
  state.owner = owner
  state.finishCb = nil
  state._postSlashFinishCb = cb
  state.fromValue = fromValue
  state.toValue = toValue
  state.duration = math.max(duration, 0)
  state.elapsed = 0
  state.easeFunc = self:_GetEaseFunc(easeType)
  state.tlslashDiagWriteCount = 0
  state.slashDistance = slashDistance
  state.isFlip = isFlip
  state.middlePause = math.max(middlePause or 0, 0)
  state.fromValueDissolve = fromValueDissolve
  state.toValueDissolve = toValueDissolve
  state.easeFuncDissolve = self:_GetEaseFunc(easeTypeDissolve)
  state.durationDissolve = math.max(durationDissolve or 0, 0)
  local eps = 0.05
  local doRestoreMats = true
  local tv = toValue
  if nil ~= tv and eps <= math.abs(tv) then
    doRestoreMats = false
  end
  state.postSlashDoRestoreMats = doRestoreMats
  local dissolveTargets = state.slashEntries or state.rendererEntries
  self:_ApplySlashProgressAll(state, fromValue)
  self:_ApplySlashDistanceAndFlipAll(state.slashEntries or state.rendererEntries, slashDistance, isFlip)
  self:_ApplySlashDissolveProgressAll(dissolveTargets, fromValueDissolve)
  local slashEnd = state.duration
  local dissolveEnd = state.middlePause + state.durationDissolve
  state.tlslashTotalDuration = math.max(slashEnd, dissolveEnd)
  if state.tlslashTotalDuration <= 0 then
    self:_ApplySlashProgressAll(state, toValue)
    self:_ApplySlashDissolveProgressAll(dissolveTargets, toValueDissolve)
    self:_PostSlashComplete(state)
    return
  end
  state.tlslashParallelActive = true
  self:_CancelPostSlash(state)
  UpdateBeat.Instance:Remove(self._Update, self)
  UpdateBeat.Instance:Add(self._Update, self)
end

function TimelineTargetSlashController:_Update(deltaTime)
  if not bg.battleRender then
    self:RestoreAll()
    return
  end
  local hasRunning = false
  local speed = bg.battleRender.gameSpeed or 1
  for _, state in pairs(self._states) do
    if not state then
      goto lbl_123
    elseif state.tlslashParallelActive then
      state.elapsed = (state.elapsed or 0) + speed * deltaTime
      local e = state.elapsed
      local total = state.tlslashTotalDuration or 0
      local dissolveTargets = state.slashEntries or state.rendererEntries
      local dur = state.duration or 0
      local slashVal
      if dur <= 0 then
        slashVal = state.toValue
      else
        local ts = math.min(1, e / dur)
        slashVal = state.easeFunc(state.fromValue, state.toValue, ts)
      end
      self:_ApplySlashProgressAll(state, slashVal)
      local mp = state.middlePause or 0
      local durD = state.durationDissolve or 0
      local disVal
      if e < mp then
        disVal = state.fromValueDissolve
      elseif durD <= 0 then
        disVal = state.toValueDissolve
      else
        local te = e - mp
        local td = math.min(1, te / durD)
        if td >= 1 then
          disVal = state.toValueDissolve
        else
          disVal = state.easeFuncDissolve(state.fromValueDissolve, state.toValueDissolve, td)
        end
      end
      self:_ApplySlashDissolveProgressAll(dissolveTargets, disVal)
      if e >= total then
        self:_ApplySlashProgressAll(state, state.toValue)
        self:_ApplySlashDissolveProgressAll(dissolveTargets, state.toValueDissolve)
        self:_PostSlashComplete(state)
      else
        hasRunning = true
      end
    end
    ::lbl_123::
  end
  if not hasRunning then
    UpdateBeat.Instance:Remove(self._Update, self)
  end
end

function TimelineTargetSlashController:OnTimelinePlayFinished(owner, onComplete)
  if not onComplete then
    return
  end
  local state = self._states[owner]
  if not state then
    onComplete()
    return
  end
  state.pendingAfterSlashCleanupCb = onComplete
end

function TimelineTargetSlashController:Restore(owner)
  local state = self._states[owner]
  if not state then
    return
  end
  if state.tlslashLockedTargets then
    self:_UnlockTargets(state.tlslashLockedTargets)
    state.tlslashLockedTargets = nil
  end
  local finishCb = state.finishCb or state._postSlashFinishCb
  state.finishCb = nil
  state._postSlashFinishCb = nil
  state.pendingAfterSlashCleanupCb = nil
  self:_CancelPostSlash(state)
  self:_FinalizeSlashCleanup(owner, state, true, finishCb)
end

function TimelineTargetSlashController:RestoreAll()
  for owner, _ in pairs(self._states) do
    self:Restore(owner)
  end
  UpdateBeat.Instance:Remove(self._Update, self)
end

TimelineTargetSlashController.Instance = TimelineTargetSlashController()
return TimelineTargetSlashController
