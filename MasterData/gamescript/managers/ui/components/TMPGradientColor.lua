local TMPGradientColor = NewClass("TMPGradientColor")
local TypeOfTMP_Text = typeof(CS.TMPro.TMP_Text)
local T_Vector3 = typeof(CS.UnityEngine.Vector3)
local TMP_Vector4 = CS.UnityEngine.Vector4(0, 0, 0, 0)

function TMPGradientColor:ctor(container)
  self.tmpTextComp = container.gameObject:GetComponent(TypeOfTMP_Text)
  self.rectTrans = container.transform
end

function TMPGradientColor:SetGradientZone(gradientZone)
  self.gradientZone = gradientZone
end

function TMPGradientColor:SetMaterialPath(matPath)
  self:_TryRestoreMaterial()
  self.materialPath = matPath
  self:_UpdateMaterial()
end

function TMPGradientColor:OnEnable()
  LateUpdateBeat.Instance:Add(self.LateUpdate, self)
  self._cornors = CS.System.Array.CreateInstance(T_Vector3, 4)
  self:_UpdateMaterial()
end

function TMPGradientColor:OnDisable()
  self:_TryRestoreMaterial()
  self._cornors = nil
  LateUpdateBeat.Instance:Remove(self.LateUpdate, self)
end

function TMPGradientColor:OnDestroy()
  self._cornors = nil
  self:_TryRestoreMaterial()
end

function TMPGradientColor:LateUpdate()
  if IsNil(self.gradientZone) then
    return
  end
  self.gradientZone:GetWorldCorners(self._cornors)
  local v0 = self._cornors[0]
  local v2 = self._cornors[2]
  TMP_Vector4.x = v2.x - v0.x
  TMP_Vector4.y = v2.y - v0.y
  TMP_Vector4.z = v0.x
  TMP_Vector4.w = v0.y
  self.tmpTextComp.materialForRendering:SetVector("_GraidentMapRect", TMP_Vector4)
end

function TMPGradientColor:_UpdateMaterial()
  if not self.materialPath then
    return
  end
  if not self.fontMaterial then
    local mainAsset = ResLoadMgr.LoadAsset(self.materialPath, self)
    if not mainAsset then
      return
    end
    self.fontMaterial = Instantiate(mainAsset)
  end
  self.saveFontMaterial = self.tmpTextComp.fontMaterial
  self.tmpTextComp.fontMaterial = self.fontMaterial
end

function TMPGradientColor:_TryRestoreMaterial()
  if self.saveFontMaterial then
    self.tmpTextComp.fontMaterial = self.saveFontMaterial
    self.saveFontMaterial = nil
  end
  if self.fontMaterial then
    Destroy(self.fontMaterial)
    self.fontMaterial = nil
  end
  if self.materialPath then
    ResLoadMgr.UnloadAssetByTarget(self)
    self.materialPath = nil
  end
end

return TMPGradientColor
