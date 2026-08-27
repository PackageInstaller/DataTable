local FmtFairyEntity = class("FmtFairyEntity")
local CS_ResLoader = CS.ResLoader

function FmtFairyEntity:ctor(fmtCtrl)
  self.fmtCtrl = fmtCtrl
end

function FmtFairyEntity:InitFmtFairyEntity(fairyData, fairyBindPos)
  self.fairyData = fairyData
  self.fairyBindPos = fairyBindPos
  return self:LoadModel()
end

function FmtFairyEntity:LoadModel()
  local modelPath = self.fairyData:GetFairyPrefabResStr()
  if self.modelPath == modelPath then
    return
  else
    if self.resloader ~= nil then
      self.resloader:Put2Pool()
      self.resloader = nil
    end
    self.resloader = CS_ResLoader.Create()
  end
  
  local function coroutineFunc()
    local modelWait = self.resloader:LoadABAssetAsyncAwait(modelPath)
    coroutine.yield(modelWait)
    local prefab = modelWait.Result
    if prefab == nil then
      warn("can't get fairy model!")
      return
    end
    if self.fairyGo ~= nil then
      DestroyUnityObject(self.fairyGo)
    end
    self.modelPath = modelPath
    self.fairyGo = prefab:Instantiate(self.fairyBindPos.transform)
    self.fairyGo.transform.localEulerAngles = Vector3.New(0, 180, 0)
    self.fairyAnimator = self.fairyGo:FindComponent(eUnityComponentID.Animator)
    self.fairyAnimator:Play("Battle_leap")
    return self
  end
  
  return coroutineFunc
end

function FmtFairyEntity:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.fairyGo ~= nil then
    DestroyUnityObject(self.fairyGo)
    self.fairyGo = nil
  end
end

return FmtFairyEntity
