local ShadersWarmUpMgr = NewClass("ShadersWarmUpMgr")
local WarmUpFramePerShader = 1
local WarmUpNumbersOneTime = 2
local _LuaBehaviour = CS.Z1Client.LuaBehaviour.Instance
local _WarmUpAsync = _LuaBehaviour.WarmUpAsync

function ShadersWarmUpMgr:ctor()
  self._warmUpTimer = nil
  self._curIndex = 0
  self._isLastWarmupFinish = true
  self._curFrameCount = 0
  self._isWarmup = false
  self._isWarmupFinished = false
end

function ShadersWarmUpMgr.IsSupportWarmUp()
  return nil ~= _WarmUpAsync
end

function ShadersWarmUpMgr:StartWarmup()
  if not (not self._isWarmup and _WarmUpAsync) or ApplicationUtils.is_editor_mode() then
    self._isWarmupFinished = true
    return
  end
  self._isWarmup = true
  UpdateBeat.Instance:Add(self._TryWarmupNext, self)
end

function ShadersWarmUpMgr:StopWarmup()
  UpdateBeat.Instance:Remove(self._TryWarmupNext, self)
  ResLoadMgr.UnloadAssetByTarget(self)
end

function ShadersWarmUpMgr:IsShaderWarmupFinish()
  return self._isWarmupFinished
end

function ShadersWarmUpMgr:SetShaderWarmupFinishCB(callback)
  self._finishCb = callback
  WarmUpNumbersOneTime = 50
end

function ShadersWarmUpMgr:_TryWarmupNext()
  if not self._isLastWarmupFinish then
    return
  end
  self._curFrameCount = self._curFrameCount + 1
  if self._curFrameCount < WarmUpFramePerShader then
    return
  end
  for i = 1, WarmUpNumbersOneTime do
    self:_WarmupNext()
    if self._isWarmupFinished then
      break
    end
  end
end

function ShadersWarmUpMgr:_WarmupNext()
  self._curIndex = self._curIndex + 1
  local shaderVariantsPath = string.format("Render/Shader/Warmup/WP_%d.shadervariants", self._curIndex)
  local shaderVariants = ResLoadMgr.LoadAsset(shaderVariantsPath, self)
  if not shaderVariants then
    self._isWarmupFinished = true
    if self._finishCb then
      self._finishCb()
    end
    self:StopWarmup()
    return
  end
  self._curFrameCount = 0
  self._isLastWarmupFinish = false
  shaderVariants:WarmUp()
  self._isLastWarmupFinish = true
end

ShadersWarmUpMgr.Instance = ShadersWarmUpMgr()
return ShadersWarmUpMgr
