local this = class("timelinePrefabHandle")
local TimelineUtility = CS.Lens.Gameplay.Tools.TimelineExtensions.TimelineUtility
local RenderTexture = CS.UnityEngine.RenderTexture
local TimelineSpliteHelper = CS.Gameplay.Tools.TimelineSplitTool.TimelineSpliteHelper

function this:ctor(createCamera, isUI)
  if isUI == nil then
    isUI = false
  end
  self._timelineName = nil
  self._prefabMap = {}
  self._timelineStateMap = {}
  self._timelineAnimClipMap = {}
  self._handleEnd = handler(self, self.onTimelinePlayEnd)
  self._handlePlayed = handler(self, self.onTimelinePlay)
  self._timelineEventHandle = require("ui.manager.hero.timeline.timelineEventHandle").new(self)
  self.timelineStopHandle = nil
  self.timelinePlayedHandle = nil
  self.timelineLoadedHandle = nil
  self.timelineCustomEventHandle = nil
  self.control = nil
  self._oldRootPosition = nil
  self._root = C_GameObject("[UI_Timeline]")
  self._root:ActiveTrans(true)
  L_Vector3.setLocalPos(self._root.transform, C_UIMgr.SceneLoadDefaultPosition)
  if not isUI then
    self._root.transform.localEulerAngles = C_Vector3.zero
  end
  if createCamera then
    local cameraGo = C_GameObject("camera")
    cameraGo.transform.parent = self._root.transform
    self._camera = cameraGo:AddComponent(typeof(CS.UnityEngine.Camera))
    self._cameraBrain = cameraGo:AddComponent(typeof(C_CinemachineBrain))
    local cameraData = cameraGo:AddComponent(typeof(C_UniversalAdditionalCameraData))
    cameraData.CameraSourceType = CS.UnityEngine.Rendering.Azur.CameraSourceType.UseSceneSettings
    local m_DefaultBlend = self._cameraBrain.m_DefaultBlend
    m_DefaultBlend.m_Style = C_CinemachineBlendType.Cut
    self._cameraBrain.m_DefaultBlend = m_DefaultBlend
    local prefab = L_ResPool:syncGameObject("Program/UIScene/pre_ui_lensflare.prefab")
    prefab.transform.parent = cameraGo.transform
    L_Vector3.setRelativePos(prefab.transform.transform, L_Vector3.getTemp())
    L_Vector3.setRelativeRot(prefab.transform.transform, L_Vector3.getTemp())
  end
end

function this:onTimelineCustomEvent(strParam1, strParam2, strParam3)
  if self.timelineCustomEventHandle then
    self.timelineCustomEventHandle(strParam1, strParam2, strParam3)
  end
end

function this:getRoot()
  return self._root
end

function this:setRootName(timelineName)
  if L_CommonUtil.isValid(self._root) then
    self._root.name = "UI_Timeline_" .. timelineName
  end
end

function this:dispose()
  if self._camera then
    self._camera.targetTexture = nil
    self._camera = nil
  end
  for i, v in pairs(self._timelineAnimClipMap) do
    if v.handle then
      C_LuaUtility.DestroyAnimationClip(v.handle)
    end
  end
  self._timelineAnimClipMap = nil
  self._cameraBrain = nil
  self.timelinePlayedHandle = nil
  self.timelineStopHandle = nil
  self.timelineLoadedHandle = nil
  self.timelineCustomEventHandle = nil
  for i, v in pairs(self._timelineStateMap) do
    TimelineUtility.RemovePlayableDirectorOnStoped(v.director, self._handleEnd)
    TimelineUtility.RemovePlayableDirectorOnPlayed(v.director, self._handlePlayed)
    v.timelineEventHandler = nil
    self._timelineStateMap[i] = nil
  end
  self._handleEnd = nil
  self._handlePlayed = nil
  self._timelineStateMap = nil
  for i, v in pairs(self._prefabMap) do
    C_PrefabManager:RecycleByLoader(v)
    self._prefabMap[i] = nil
  end
  C_GameObject.DestroyImmediate(self._root)
  self._prefabMap = nil
  self._root = nil
  self.control = nil
end

function this:getTimelineState(timelineName)
  return self._timelineStateMap[timelineName]
end

function this:getTimelinePrefab()
  if self._prefabMap then
    return self._prefabMap[self._timelineName]
  end
  return nil
end

function this:loadTimelinePrefab(timelineName)
  if self._timelineName == timelineName then
    return
  end
  local prefab, helper
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
  else
    local prefabPath = self:getFilePath(timelineName)
    prefab = L_ResPool:syncGameObject(prefabPath)
    prefab.transform.parent = self._root.transform
  end
  L_Vector3.setRelativePos(prefab.transform, L_Vector3.getTemp())
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:asyncloadTimelinePrefab(timelineName)
  if self._timelineName == timelineName then
    return
  end
  local prefab, helper
  self._timelineName = timelineName
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
    L_Vector3.setRelativePos(prefab.transform, L_Vector3.getTemp())
    self:loadTimelinePrefabFinish(timelineName, prefab)
  else
    local prefabPath = self:getFilePath(timelineName)
    C_UIMgr.uiLoader:SpawnAsync(prefabPath, function(uid, obj)
      prefab = obj
      L_Vector3.setRelativePos(prefab.transform, L_Vector3.getTemp())
      self:loadTimelinePrefabFinish(timelineName, prefab)
    end, self._root.transform, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  end
end

function this:onTimelinePlay(director)
  if self._timelineStateMap == nil then
    return
  end
  local state = self._timelineStateMap[self._timelineName]
  if state == nil then
    return
  end
  if state.director ~= director then
    return
  end
  if self.timelinePlayedHandle then
    self.timelinePlayedHandle(self._timelineName, director)
  end
end

function this:onTimelinePlayEnd(director)
  if self._timelineStateMap == nil then
    return
  end
  local state = self._timelineStateMap[self._timelineName]
  if state == nil then
    return
  end
  if state.director ~= director then
    return
  end
  self:onTimelinePlayEndInter(director)
  if self.timelineStopHandle then
    self.timelineStopHandle(self._timelineName, director)
  end
end

function this:onTimelinePlayEndInter(director)
end

function this:getTimelineStateComponent(prefab)
  return prefab:GetComponent(typeof(CS.Gameplay.Tools.TimelineSplitTool.TimelineState))
end

function this:loadTimelinePrefabFinish(timelineName, prefab)
  if self._prefabMap == nil then
    return
  end
  self._timelineName = timelineName
  if not self._prefabMap[timelineName] then
    self._prefabMap[timelineName] = prefab
  end
  local state = self._timelineStateMap[timelineName]
  if state == nil then
    state = self:getTimelineStateComponent(prefab)
    self._timelineStateMap[timelineName] = state
    TimelineUtility.RemovePlayableDirectorOnPlayed(state.director, self._handlePlayed)
    TimelineUtility.AddPlayableDirectorOnPlayed(state.director, self._handlePlayed)
    TimelineUtility.RemovePlayableDirectorOnStoped(state.director, self._handleEnd)
    TimelineUtility.AddPlayableDirectorOnStoped(state.director, self._handleEnd)
    state.timelineEventHandler = handler(self, self.timelineEventHandler)
  end
  if self._prefabMap[self._timelineName] then
    self._prefabMap[self._timelineName]:ActiveTrans(true)
  end
  if self.timelineLoadedHandle then
    self.timelineLoadedHandle(timelineName, state)
  end
end

function this:getFilePath(timelineName)
  errorf("timelinePrefabHandle 未实现 getFilePath")
  return ""
end

function this:timelineEventHandler(eventData)
  if eventData == nil then
    return
  end
  if self._timelineEventHandle == nil then
    return
  end
  self._timelineEventHandle:onTimelineEventHandler(eventData)
end

function this:getTimelineName()
  return self._timelineName
end

function this:playTimelineAsset(timelineAsset)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    state.director:Play()
  end
end

function this:replayTimeline()
  local state = self._timelineStateMap[self._timelineName]
  if state then
    state.director:Stop()
    state.director:Play()
  end
end

function this:stopTimeline()
  local state = self._timelineStateMap[self._timelineName]
  if state then
    state.director:Stop()
  end
end

function this:bindTargetFollowDatas(state, dynamicBinds)
  local followTargetDatas = state.followTargetDatas
  for i, v in pairs(followTargetDatas) do
    local heroTrans
    if dynamicBinds and dynamicBinds[v.actorPath] then
      heroTrans = dynamicBinds[v.actorPath].transform
    else
      heroTrans = state.transform:Find(v.actorPath)
    end
    local node
    if heroTrans ~= nil then
      node = heroTrans:Find(v.nodePath)
    end
    if node ~= nil then
      local followTargetTrans = state.transform:Find(v.path)
      if followTargetTrans ~= nil then
        if v.followTargetType == 0 then
          local followTarget = followTargetTrans:GetComponent(typeof(CS.Lens.Gameplay.Tools.FollowTarget))
          if followTarget ~= nil then
            followTarget.target = node
          end
        elseif v.followTargetType == 1 then
          local followTarget = followTargetTrans:GetComponent(typeof(CS.Lens.Gameplay.Tools.FollowTargetList))
          if followTarget ~= nil then
            followTarget.targets[v.index] = node
          end
        end
      end
    end
  end
end

function this:bindAttachEffectDatas(state, timelineAsset, dynamicBinds)
  local attachEffectDatas = state.attachEffectDatas
  if attachEffectDatas == nil then
    return
  end
  local datas = {}
  for i, v in pairs(attachEffectDatas) do
    local heroTrans
    if dynamicBinds and dynamicBinds[v.actorPath] then
      heroTrans = dynamicBinds[v.actorPath].transform
    else
      heroTrans = state.transform:Find(v.actorPath)
    end
    local node
    if heroTrans ~= nil then
      node = heroTrans:Find(v.nodePath)
    end
    if node ~= nil then
      datas[v.streamName] = node.gameObject
    end
  end
  state:SetAttachEffectBindings(timelineAsset, datas)
end

function this:replaceAnimationByPet(state, petInfo, actorPath, animId)
  local pet = petInfo:getGameObject()
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), pet)
  print("dbg replaceAnimationByPet 1")
  if biologyData == nil then
    return
  end
  print("dbg replaceAnimationByPet 2")
  local partList = biologyData:GetListPart()
  for _, v in pairs(state.timelineBindDatas) do
    local director = v:GetDirector()
    if director then
      for ii = 0, v.playableBindingInfo.Count - 1 do
        local bindInfo = v.playableBindingInfo[ii]
        if bindInfo and bindInfo.actorPath == actorPath then
          local track = TimelineSpliteHelper.GetAvatarAnimationTrack(director, director.playableAsset, v.playableBindingName[ii])
          if track then
            local clips = track:GetClips()
            if clips then
              local length = clips:GetLength()
              for i = 1, length do
                local clip = clips[i - 1]
                local playableAsset = clip.asset
                if playableAsset ~= nil then
                  local selectBodyClipName = playableAsset.selectBodyClipName
                  local names = string.split(selectBodyClipName, "@")
                  local firstIndex = string.find(names[1], "_")
                  local numStr = string.sub(names[1], firstIndex + 1, names[1]:len())
                  local name = ""
                  for i, v in pairs(partList) do
                    if string.find(v.partName, "_body_") then
                      name = v
                      break
                    end
                  end
                  if not string.isEmpty(name) then
                    local offsetAniItem = C_OffsetAniIndexer.Instance:GetOffsetByName(name)
                    if offsetAniItem ~= nil then
                      track.m_OffsetClip = offsetAniItem:GetItem()
                    end
                  end
                  local replaceClips = {}
                  local aniName = petInfo:getAniname(names[2])
                  print("dbg replaceAnimationByPet 3")
                  local clipPath = C_CustomAniIndexer.Instance:GetBaseAniClipPath(biologyData.raceType, tostring(animId), aniName)
                  print("dbg replaceAnimationByPet 4 clipPath is " .. tostring(clipPath) .. " biologyData.raceType " .. tostring(biologyData.raceType) .. " animId " .. tostring(animId) .. " aniName " .. tostring(aniName))
                  if not string.isEmpty(clipPath) then
                    print("dbg replaceAnimationByPet 5")
                    self._timelineAnimClipMap[clipPath] = self._timelineAnimClipMap[clipPath] or {}
                    if self._timelineAnimClipMap[clipPath].obj then
                      print("dbg replaceAnimationByPet 6")
                      table.insert(replaceClips, self._timelineAnimClipMap[clipPath].obj)
                    else
                      print("dbg replaceAnimationByPet 7")
                      local handle
                      handle = C_LuaUtility.LoadAnimationClip(clipPath, function(_animClip)
                        print("dbg replaceAnimationByPet 8 " .. tostring(_animClip))
                        if _animClip then
                          self._timelineAnimClipMap[clipPath].obj = _animClip
                          table.insert(replaceClips, _animClip)
                          print("dbg replaceAnimationByPet 9")
                        end
                      end)
                      self._timelineAnimClipMap[clipPath].handle = handle
                    end
                  end
                  for i, part in pairs(partList) do
                    local clipPath = C_CustomAniIndexer.Instance:GetAniClipPath(part.partName, tostring(animId), aniName)
                    if not string.isEmpty(clipPath) then
                      self._timelineAnimClipMap[clipPath] = self._timelineAnimClipMap[clipPath] or {}
                      if self._timelineAnimClipMap[clipPath].obj then
                        table.insert(replaceClips, self._timelineAnimClipMap[clipPath].obj)
                      else
                        do
                          local handle
                          handle = C_LuaUtility.LoadAnimationClip(clipPath, function(_animClip)
                            if _animClip then
                              self._timelineAnimClipMap[clipPath].obj = _animClip
                              table.insert(replaceClips, _animClip)
                            end
                          end)
                          self._timelineAnimClipMap[clipPath].handle = handle
                        end
                      end
                    end
                  end
                  print("dbg replaceAnimationByPet 10")
                  playableAsset.clips = replaceClips
                end
              end
            end
          end
        end
      end
    end
  end
end

function this:replaceAnimationByHero(state, petInfo, actorPath, heroId)
  local pet = petInfo:getGameObject()
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), pet)
  if biologyData == nil then
    return
  end
  local partList = biologyData:GetListPart()
  local addition = state:GetComponent(typeof(CS.Gameplay.Tools.TimelineSplitTool.TimelineHeroAddition))
  for _, v in pairs(state.timelineBindDatas) do
    local director = v:GetDirector()
    if director then
      for ii = 0, v.playableBindingInfo.Count - 1 do
        local bindInfo = v.playableBindingInfo[ii]
        if bindInfo and bindInfo.actorPath == actorPath then
          local track = TimelineSpliteHelper.GetAvatarAnimationTrack(director, director.playableAsset, v.playableBindingName[ii])
          if track then
            local clips = track:GetClips()
            if clips then
              local length = clips:GetLength()
              for i = 1, length do
                local clip = clips[i - 1]
                local playableAsset = clip.asset
                if playableAsset ~= nil then
                  local name = ""
                  for i, v in pairs(partList) do
                    if string.find(v.partName, "_cloth_") then
                      name = v
                      break
                    end
                  end
                  if not string.isEmpty(name) then
                    local offsetAniItem = C_OffsetAniIndexer.Instance:GetOffsetByName(name)
                    if offsetAniItem ~= nil then
                      track.m_OffsetClip = offsetAniItem:GetItem()
                    end
                  end
                  local selectBodyClipName = playableAsset.selectBodyClipName
                  if string.isEmpty(selectBodyClipName) then
                    break
                  end
                  local names = string.split(selectBodyClipName, "@")
                  local firstIndex = string.find(names[1], "_")
                  local numStr = string.sub(names[1], firstIndex + 1, names[1]:len())
                  local additionAnimClipNames = {}
                  if addition ~= nil then
                    local clipNames = addition:GetAdditionAnimationClipNames(selectBodyClipName)
                    if clipNames ~= nil then
                      for i = 0, clipNames.Length - 1 do
                        local arr = string.split(clipNames[i], "@")
                        if 1 < #arr then
                          local arr2 = string.split(arr[2], "_")
                          if 1 < #arr2 then
                            additionAnimClipNames[arr2[2]] = clipNames[i]
                          end
                        end
                      end
                    end
                  end
                  local replaceClips = {}
                  
                  local function addToReplaceClips(clip)
                    if clip == nil then
                      return
                    end
                    local findClip = table.ipairsFind(replaceClips, function(v)
                      return v == clip
                    end)
                    if not findClip then
                      table.insert(replaceClips, clip)
                    end
                  end
                  
                  if playableAsset.clips then
                    for i = 0, playableAsset.clips.Length - 1 do
                      local clipI = playableAsset.clips[i]
                      addToReplaceClips(clipI)
                    end
                  end
                  local aniName = petInfo:getAniname(names[2])
                  for i, part in pairs(partList) do
                    local partName = part.partName
                    local clipPath = C_CustomAniIndexer.Instance:GetAniClipPath(partName, numStr, aniName, nil, true)
                    if not string.isEmpty(clipPath) then
                      self._timelineAnimClipMap[clipPath] = self._timelineAnimClipMap[clipPath] or {}
                      if self._timelineAnimClipMap[clipPath].obj then
                        addToReplaceClips(self._timelineAnimClipMap[clipPath].obj)
                        local partNameArr = string.split(partName, "_")
                        local part = partNameArr[#partNameArr - 1]
                        additionAnimClipNames[part] = nil
                      else
                        do
                          local handle
                          handle = C_LuaUtility.LoadAnimationClip(clipPath, function(_animClip)
                            if _animClip then
                              self._timelineAnimClipMap[clipPath].obj = _animClip
                              addToReplaceClips(_animClip)
                              local partNameArr = string.split(partName, "_")
                              local part = partNameArr[#partNameArr - 1]
                              additionAnimClipNames[part] = nil
                            end
                          end)
                          self._timelineAnimClipMap[clipPath].handle = handle
                        end
                      end
                    end
                  end
                  for part, clipName in pairs(additionAnimClipNames) do
                    if clipName ~= nil then
                      local clipPath = C_CustomAniIndexer.Instance:GetAniClipPath(clipName)
                      if not string.isEmpty(clipPath) then
                        self._timelineAnimClipMap[clipPath] = self._timelineAnimClipMap[clipPath] or {}
                        if self._timelineAnimClipMap[clipPath].obj then
                          addToReplaceClips(self._timelineAnimClipMap[clipPath].obj)
                        else
                          do
                            local handle
                            handle = C_LuaUtility.LoadAnimationClip(clipPath, function(_animClip)
                              if _animClip then
                                self._timelineAnimClipMap[clipPath].obj = _animClip
                                addToReplaceClips(_animClip)
                              end
                            end)
                            self._timelineAnimClipMap[clipPath].handle = handle
                          end
                        end
                      end
                    end
                  end
                  local faceName
                  if heroId == L_GameConstTpl:getData("AVATAR_HERO_ID_MALE", L_Const.GameTplType.int) then
                    faceName = "bigboy"
                  elseif heroId == L_GameConstTpl:getData("AVATAR_HERO_ID_FEMALE", L_Const.GameTplType.int) then
                    faceName = "biggirl"
                  end
                  if faceName ~= nil and not string.isEmpty(biologyData.raceType) then
                    local clipPath = C_CustomAniIndexer.Instance:GetFaceAniClipPath(biologyData.raceType, faceName, aniName)
                    if not string.isEmpty(clipPath) then
                      self._timelineAnimClipMap[clipPath] = self._timelineAnimClipMap[clipPath] or {}
                      if self._timelineAnimClipMap[clipPath].obj then
                        addToReplaceClips(self._timelineAnimClipMap[clipPath].obj)
                      else
                        do
                          local handle
                          handle = C_LuaUtility.LoadAnimationClip(clipPath, function(_animClip)
                            if _animClip then
                              self._timelineAnimClipMap[clipPath].obj = _animClip
                              addToReplaceClips(_animClip)
                            end
                          end)
                          self._timelineAnimClipMap[clipPath].handle = handle
                        end
                      end
                    end
                  end
                  playableAsset.clips = replaceClips
                end
              end
            end
          end
        end
      end
    end
  end
end

function this:bindMainPlayerByPrefab(name, dynamicBinds)
  local state = self:getTimelineState(name)
  if state == nil then
    return
  end
  for i, v in pairs(dynamicBinds) do
    local hero = v.actor
    local bindingPath = i
    if not string.isEmpty(bindingPath) then
      local paths = string.split(bindingPath, "/")
      local path = ""
      for i, v in ipairs(paths) do
        if i ~= #paths then
          if i == 1 then
            path = v
          else
            path = path .. "/" .. v
          end
        end
      end
      local parent = state.transform:Find(path, true)
      if parent == nil then
        return
      end
      local heroTrans = hero.transform
      local reset = heroTrans.parent ~= parent
      heroTrans.parent = parent
      if reset then
        L_Vector3.setLocalPos(heroTrans.transform, L_Vector3.getTemp())
        L_Vector3.setLocalRot(heroTrans.transform, L_Vector3.getTemp())
      end
    end
  end
end

function this:bindMainPlayer(name, dynamicBinds)
  local state = self:getTimelineState(name)
  if state == nil then
    return
  end
  local actorBinds = {}
  for i, v in pairs(dynamicBinds) do
    actorBinds[i] = v.actor
  end
  state:ReplaceActors(actorBinds)
  for i, v in pairs(dynamicBinds) do
    if v.heroId then
      self:replaceAnimationByHero(state, v, i, v.heroId)
    elseif v.animId then
      self:replaceAnimationByPet(state, v, i, v.animId)
    end
  end
  local dynamicBindDatas = state.dynamicBindDatas
  for i, v in pairs(dynamicBindDatas) do
    local heroTrans
    if dynamicBinds and dynamicBinds[v.actorPath] then
      heroTrans = dynamicBinds[v.actorPath].actor
    end
    local node
    if heroTrans ~= nil then
      node = TimelineSpliteHelper.GetActorNodeByBindingInfo(heroTrans, v)
    end
    if node ~= nil then
      local followTargetTrans = state.transform:Find(v.path)
      if not L_CommonUtil.isValid(followTargetTrans) then
        error("timelinePrefabHandle：不存在的内容:：" .. v.path)
        return
      end
      if L_Const.timelineDynamicBindType.EffectMaterialHelper == v.scriptType then
        local followTarget = followTargetTrans:GetComponent(typeof(CS.EffectMaterialHelper))
        if followTarget ~= nil then
          followTarget.characterRoot = node.gameObject
          followTarget.gameObject:ActiveTrans(false)
          followTarget.gameObject:ActiveTrans(true)
        end
      elseif L_Const.timelineDynamicBindType.EffectCommonHelper == v.scriptType then
        local followTarget = followTargetTrans:GetComponent(typeof(CS.EffectCommonHelper))
        if followTarget ~= nil then
          followTarget.characterRoot = node.gameObject
          followTarget.gameObject:ActiveTrans(false)
          followTarget.gameObject:ActiveTrans(true)
        end
      elseif L_Const.timelineDynamicBindType.EffectCommonHelper2 == v.scriptType then
        local followTarget = followTargetTrans:GetComponent(typeof(CS.EffectCommonHelper2))
        if followTarget ~= nil then
          followTarget.characterRoot = node.gameObject
          followTarget.gameObject:ActiveTrans(false)
          followTarget.gameObject:ActiveTrans(true)
        end
      elseif L_Const.timelineDynamicBindType.FollowTarget == v.scriptType then
        local followTarget = followTargetTrans:GetComponent(typeof(CS.Lens.Gameplay.Tools.FollowTarget))
        if followTarget ~= nil then
          followTarget.target = node.transform
        end
      elseif L_Const.timelineDynamicBindType.FollowTargetList == v.scriptType then
        local followTarget = followTargetTrans:GetComponent(typeof(CS.Lens.Gameplay.Tools.FollowTargetList))
        if followTarget ~= nil then
          followTarget.targets[v.intParam1] = node.transform
        end
      end
    end
  end
  for _, bindData in pairs(state.timelineBindDatas) do
    local director = bindData:GetDirector()
    if director then
      local datas = {}
      for i, v in pairs(bindData.trackBindingInfo) do
        local heroTrans
        if dynamicBinds and dynamicBinds[v.actorPath] then
          heroTrans = dynamicBinds[v.actorPath].actor
        end
        local node
        if heroTrans ~= nil then
          node = TimelineSpliteHelper.GetActorNodeByBindingInfo(heroTrans, v)
        end
        if node ~= nil then
          datas[v.streamName] = node
        end
      end
      bindData:SetAttachEffectBindings(datas)
    end
  end
end

return this
