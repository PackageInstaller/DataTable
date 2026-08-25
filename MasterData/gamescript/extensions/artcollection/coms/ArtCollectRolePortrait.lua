local ArtCollectRolePortrait, Super = NewViewComponent("ArtCollectRolePortrait")
local GameObjectUtil = CS.Framework.GameObjectUtil
local ScreenSpaceMaskable = CS.ScreenSpaceMaskable

function ArtCollectRolePortrait:ctor(container, view, cfgId)
  Super.ctor(self, container, view)
  self.container = container
  self.cfgId = cfgId
  self.roleType = CommonDefine.AvgRoleType.Normal
end

function ArtCollectRolePortrait:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:ResetPortrait(self.cfgId)
end

function ArtCollectRolePortrait:ClearRoleGO()
  if self.rolePrefabGO then
    CS.UnityEngine.Object.Destroy(self.rolePrefabGO)
    self.rolePrefabGO = nil
    self.roleImg = nil
  end
end

function ArtCollectRolePortrait:ResetPortrait(cfgId)
  self:ClearRoleGO()
  local cfg = DT.CollectionHall[cfgId]
  local charPath = cfg.Picture
  local prefabPath = charPath and PortraitUtils.GetAwakerPrefabPath(charPath) or nil
  local prefabRes = self:LoadAsset(prefabPath)
  if not prefabRes and charPath then
    Alert.ShowStr(string.format("图鉴 [%s] 找不到立绘资源%s", LT.Text(cfg.Title), prefabPath))
  end
  if prefabRes then
    self.rolePrefabGO = CS.UnityEngine.GameObject.Instantiate(prefabRes, self.container.transform)
    local awakerTf = GameObjectUtil.DeepFindChild(self.rolePrefabGO.transform, "Image_Awaker")
    self.roleImg = awakerTf and awakerTf.gameObject or nil
    local faceTf = awakerTf and awakerTf:Find("Image_Awaker_Face")
    local faceImg = faceTf and faceTf.gameObject
    if faceImg then
      self.binder:ClearImage(faceImg)
    end
    if self.roleType == CommonDefine.AvgRoleType.Horizontal then
      self:VerticalCenter(self.rolePrefabGO.transform, awakerTf)
      self:HorizontalCenter(self.rolePrefabGO.transform, awakerTf)
    elseif self.roleType == CommonDefine.AvgRoleType.Vertical then
      self:HorizontalCenter(self.rolePrefabGO.transform, awakerTf)
    end
    self.screenSpaceMask = self.container:GetComponent(typeof(CS.UIScreenSpaceMask))
    if self.screenSpaceMask then
      self.screenSpaceMaskable = ScreenSpaceMaskable.Get(self.roleImg.gameObject)
      if not IsNil(self.screenSpaceMaskable) then
        self.screenSpaceMaskable.enabled = true
      end
    end
    self:SetUseScreenSpaceMask(self.screenSpaceMask ~= nil)
  end
end

function ArtCollectRolePortrait:SetUseScreenSpaceMask(useScreenSpacedMask)
  if not self.roleImg then
    return
  end
  local compImage = self.roleImg:GetComponent(typeof(CS.UnityEngine.UI.Image))
  local material = compImage.material
  local mat, matName
  if useScreenSpacedMask then
    if not material or material.name ~= "Z1_UI_PortraitScreenSpaceMask_Clone" then
      matName = "Z1_UI_PortraitScreenSpaceMask_Clone"
      mat = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitScreenSpaceMask_Avg.mat")
    end
  elseif not material or material.name ~= "Z1_UI_PortraitMask_Clone" then
    matName = "Z1_UI_PortraitMask_Clone"
    mat = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitMask_Avg.mat")
  end
  if mat then
    compImage.material = GameObject.Instantiate(mat)
    compImage.material.name = matName
    if not CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull(self.screenSpaceMaskable) and self.screenSpaceMaskable.gameObject.activeInHierarchy and self.screenSpaceMaskable.screenSpaceMask then
      self.screenSpaceMaskable:LateUpdate()
    end
  end
end

return ArtCollectRolePortrait
