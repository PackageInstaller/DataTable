local OasisBuildEffectEntity = class("OasisBuildEffectEntity")
local cs_RenderManager_Ins = CS.RenderManager.Instance
local cs_MeshRenderer = CS.UnityEngine.MeshRenderer

function OasisBuildEffectEntity:ctor(gameObject, effectName)
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.effectName = effectName
  cs_RenderManager_Ins:ApplyEffectObjectLevel(self.transform)
  self.bind = {}
  UIUtil.LuaUIBindingTable(gameObject, self.bind)
end

function OasisBuildEffectEntity:InitOasisBuildEffectEntity(position, parent, returnFunc)
  if position ~= nil then
    self.transform.position = position
  end
  if not IsNull(parent) then
    self.transform:SetParent(parent)
  end
  self.returnFunc = returnFunc
  if self._returnTimerId == nil and returnFunc ~= nil then
    self._returnTimerId = TimerManager:StartTimer(self.bind.duration, self.__ReturnEntity, self, true)
  end
  self.gameObject:SetActive(true)
end

function OasisBuildEffectEntity:SetOasisBuildEffectHeight(height)
  if self.mat == nil then
    for k, particleRenderer in ipairs(self.bind.particleRendererList) do
      if self.mat == nil then
        self.mat = particleRenderer.material
      end
      particleRenderer.sharedMaterial = self.mat
      particleRenderer.trailMaterial = self.mat
    end
  end
  if self.mat ~= nil then
    local heightValue = height / 90
    self.mat:SetFloat("_height", heightValue)
  end
end

function OasisBuildEffectEntity:SetBuildSelectFxValid(valid)
  if self.allSelectRenderList == nil then
    self.allSelectRenderList = self.transform:GetComponentsInChildren(typeof(cs_MeshRenderer))
  end
  for i = 0, self.allSelectRenderList.Length - 1 do
    local renderer = self.allSelectRenderList[i]
    renderer.material = valid and self.bind.mat_valid or self.bind.mat_unvalid
  end
  for k, spriteRender in ipairs(self.bind.arrowList) do
    spriteRender.color = valid and self.bind.arrowColor_Green or self.bind.arrowColor_Red
  end
end

local eAreaFxState = {
  Lock = 1,
  Unlockable = 2,
  Opening = 3
}

function OasisBuildEffectEntity:UpdateOasisAreaFxState(areaId)
  if self._areaFxState == eAreaFxState.Opening then
    return
  end
  local state
  local unlock = PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId)
  if unlock then
    state = eAreaFxState.Opening
  else
    local cfg = ConfigData.oasis_area[areaId]
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      state = eAreaFxState.Unlockable
    else
      state = eAreaFxState.Lock
    end
  end
  self.bind.lock:SetActive(state == eAreaFxState.Lock)
  self.bind.unlockable:SetActive(state == eAreaFxState.Unlockable)
  self.bind.opening:SetActive(state == eAreaFxState.Opening)
  self._areaFxState = state
end

function OasisBuildEffectEntity:__ReturnEntity()
  self._returnTimerId = nil
  if self.returnFunc ~= nil then
    self.returnFunc(self)
  end
end

function OasisBuildEffectEntity:GetOasisBuildEffectEntityName()
  return self.effectName
end

function OasisBuildEffectEntity:OnDelete()
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
  DestroyUnityObject(self.mat)
  self.mat = nil
  if self._returnTimerId ~= nil then
    TimerManager:StopTimer(self._returnTimerId)
    self._returnTimerId = nil
  end
end

return OasisBuildEffectEntity
