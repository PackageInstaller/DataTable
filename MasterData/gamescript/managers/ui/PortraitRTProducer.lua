local PortraitRTProducer = System.NewClass("PortraitRTProducer")
local RenderTexture = CS.UnityEngine.RenderTexture
local T_Camera = typeof(CS.UnityEngine.Camera)
local T_SkeletonAnimation = typeof(CS.Spine.Unity.SkeletonAnimation)

function PortraitRTProducer:ctor()
  self.rtsPool = {}
  self.rtUserStack = {}
end

function PortraitRTProducer:ActivePortrait(spineNode, cameraNode, width, height)
  local key = self:_GetREKey(width, height)
  local rt = self.rtsPool[key]
  if not rt then
    rt = RenderTexture.GetTemporary(width, height)
    self.rtsPool[key] = rt
  end
  self.rtUserStack[key] = self.rtUserStack[key] or {}
  local nodeKey = self:_GetNodeKey(spineNode, cameraNode)
  local nodeCfg = self:_GetNodeCfg(key, nodeKey)
  local nodeCfgs = self.rtUserStack[key]
  if not nodeCfg then
    nodeCfg = {
      nodeKey = nodeKey,
      spineNode = spineNode,
      camera = cameraNode:GetComponent(T_Camera),
      rtKey = key,
      skeletonAnimation = spineNode:GetComponent(T_SkeletonAnimation)
    }
    table.insert(nodeCfgs, nodeCfg)
  end
  for i = 1, #nodeCfgs - 1 do
    self:_SetDeactiveByCfg(nodeCfgs[i])
  end
  self:_SetActiveByCfg(nodeCfg)
  return rt
end

function PortraitRTProducer:RemovePortrait(spineNode, cameraNode)
  local nodeKey = self:_GetNodeKey(spineNode, cameraNode)
  if nodeKey then
    local nodeCfg = self:_GetNodeCfg(nil, nodeKey)
    if not nodeCfg then
      return
    end
    local animTime = self:_GetSkeletionAnimationTime(nodeCfg.skeletonAnimation)
    self:_SetDeactiveByCfg(nodeCfg)
    local nodeCfgs = self.rtUserStack[nodeCfg.rtKey]
    if nodeCfgs and #nodeCfgs > 0 then
      self:_SetActiveByCfg(nodeCfgs[#nodeCfgs])
      self:_SetSkeletionAnimationTime(nodeCfgs[#nodeCfgs].skeletonAnimation, animTime)
    end
  end
  self:_ReleaseUnusedRTs()
end

function PortraitRTProducer:_GetSkeletionAnimationTime(skeletonAnimation)
  if IsNil(skeletonAnimation) then
    return 0
  end
  local spineAnimationState = skeletonAnimation.AnimationState
  if not spineAnimationState then
    return 0
  end
  local track = spineAnimationState:GetCurrent(0)
  if track then
    return track.TrackTime
  end
  return 0
end

function PortraitRTProducer:_SetSkeletionAnimationTime(skeletonAnimation, time)
  if IsNil(skeletonAnimation) then
    return
  end
  local spineAnimationState = skeletonAnimation.AnimationState
  if not spineAnimationState then
    return
  end
  local track = spineAnimationState:GetCurrent(0)
  if track then
    track.TrackTime = time or 0
    skeletonAnimation:Update(0)
    skeletonAnimation:LateUpdate()
  end
end

function PortraitRTProducer:_ReleaseUnusedRTs()
  local unusedKeys
  for k, v in pairs(self.rtsPool) do
    local isUsed = false
    local nodeCfgs = self.rtUserStack[k]
    if nodeCfgs then
      for i = 1, #nodeCfgs do
        local sNode = nodeCfgs[i].spineNode
        local camera = nodeCfgs[i].camera
        if not IsNil(camera) and not IsNil(sNode) then
          isUsed = true
          break
        end
      end
    end
    if not isUsed then
      self.rtUserStack[k] = {}
      unusedKeys = unusedKeys or {}
      table.insert(unusedKeys, k)
    end
  end
  if not unusedKeys then
    return
  end
  for i = 1, #unusedKeys do
    local rt = self.rtsPool[unusedKeys[i]]
    if not IsNil(rt) then
      RenderTexture.ReleaseTemporary(rt)
    end
    self.rtsPool[unusedKeys[i]] = nil
  end
end

function PortraitRTProducer:_SetActiveByCfg(nodeCfg)
  local rt = self.rtsPool[nodeCfg.rtKey]
  local curNode = nodeCfg.spineNode
  local curCam = nodeCfg.camera
  if not IsNil(curCam) then
    curCam.targetTexture = rt
    curCam.gameObject:SetActive(true)
  end
  if not IsNil(curNode) then
    curNode:SetActive(true)
  end
end

function PortraitRTProducer:_SetDeactiveByCfg(nodeCfg)
  local sNode = nodeCfg.spineNode
  local camera = nodeCfg.camera
  if not IsNil(camera) then
    camera.targetTexture = nil
    camera.gameObject:SetActive(false)
  end
  if not IsNil(sNode) then
    sNode:SetActive(false)
  end
end

function PortraitRTProducer:_GetREKey(width, height)
  return width .. "_" .. height
end

function PortraitRTProducer:_GetNodeKey(spineNode, cameraNode)
  if IsNil(spineNode) or IsNil(cameraNode) then
    return
  end
  local hashCodeSpine = spineNode:GetHashCode()
  local hashCodeCamera = cameraNode:GetHashCode()
  return hashCodeSpine .. "_" .. hashCodeCamera
end

function PortraitRTProducer:_GetNodeCfg(rtKey, nodeKey)
  if not rtKey then
    for k1, v1 in pairs(self.rtUserStack) do
      for i = 1, #v1 do
        if v1[i].nodeKey == nodeKey then
          local nodeCfg = v1[i]
          table.remove(v1, i)
          return nodeCfg
        end
      end
    end
  else
    local nodeCfgs = self.rtUserStack[rtKey]
    if nodeCfgs then
      for i = 1, #nodeCfgs do
        if nodeCfgs[i].nodeKey == nodeKey then
          local nodeCfg = nodeCfgs[i]
          table.remove(nodeCfgs, i)
          return nodeCfg
        end
      end
    end
  end
end

PortraitRTProducer.Instance = PortraitRTProducer()
return PortraitRTProducer
