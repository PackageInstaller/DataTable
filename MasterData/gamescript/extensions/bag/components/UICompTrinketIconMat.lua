local T_Material = typeof(CS.UnityEngine.Material)
local T_Graphic = typeof(CS.UnityEngine.UI.Graphic)
local tagSweepAngle = CS.UnityEngine.Shader.PropertyToID("_SweepAngle")
local CacheMaterials = {}
local UICompTrinketIconMat, Super = NewViewComponent("UICompTrinketIconMat")

function UICompTrinketIconMat.DestroyAllMaterials()
  for _, mat in pairs(CacheMaterials) do
    if not IsNil(mat) then
      Destroy(mat)
    end
  end
  table.clear(CacheMaterials)
end

function UICompTrinketIconMat:ctor(gameObject, view)
  Super.ctor(self, gameObject, view)
  self._isEnableLight = false
  self._isLoading = false
  self._trinketLightMat = nil
  self._lightPartIndex = nil
  self._graphic = gameObject:GetComponent(T_Graphic)
end

function UICompTrinketIconMat:OnEnterComponent()
  self:EnableLight(self._isEnableLight)
end

function UICompTrinketIconMat:OnExitComponent()
  self:_DestroyMaterial()
  self._isEnableLight = false
  Super.OnExitComponent(self)
end

function UICompTrinketIconMat:EnableLight(enabled, partIndex)
  self._lightPartIndex = partIndex
  self._isEnableLight = enabled
  if not enabled then
    self:_DestroyMaterial()
    return
  end
  if self._isLoading then
    return
  end
  if self._trinketLightMat then
    self:_ApplyMaterial()
    return
  end
  self._isLoading = true
  ResLoadMgr.LoadAssetAsync(CommonRes.TrinketIconMat, self, System.fn(self, self._OnMaterialLoadFinish), T_Material)
end

function UICompTrinketIconMat:_OnMaterialLoadFinish(asset)
  self._isLoading = false
  if not self._isEnableLight or not asset then
    return
  end
  local mat = GameObject.Instantiate(asset)
  self._trinketLightMat = mat
  self:_ApplyMaterial()
end

function UICompTrinketIconMat:_ApplyMaterial()
  if IsNil(self._trinketLightMat) then
    return
  end
  if self._graphic then
    self._graphic.material = self._trinketLightMat
  end
  self._trinketLightMat:SetFloat(tagSweepAngle, 300)
end

function UICompTrinketIconMat:_DestroyMaterial()
  self._isLoading = false
  if IsNil(self._trinketLightMat) then
    return
  end
  if self._graphic then
    self._graphic.material = nil
  end
  GameObject.Destroy(self._trinketLightMat)
  self._trinketLightMat = nil
end

return UICompTrinketIconMat
