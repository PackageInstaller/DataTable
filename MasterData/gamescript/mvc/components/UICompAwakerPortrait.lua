local T_Image = typeof(CS.UnityEngine.UI.Image)
local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local ScreenSpaceMaskable = CS.ScreenSpaceMaskable
local T_UIScreenSpaceMask = typeof(CS.UIScreenSpaceMask)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local Texture2D = typeof(CS.UnityEngine.Texture2D)
local PortraitScreenSpaceMaskMatPath = "UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitScreenSpaceMask.mat"
local PortraitMaskMatPath = "UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitMask.mat"
local Name_PortraitScreenSpaceMask_Clone = "Z1_UI_PortraitScreenSpaceMask_Clone"
local Name_PortraitMaskClone = "Z1_UI_PortraitMask_Clone"
local UICompAwakerPortrait, Super = NewViewComponent("UICompAwakerPortrait")

function UICompAwakerPortrait:ctor(container, view, portraitCfg)
  Super.ctor(self, container, view)
  self.container = container
  self.awakerTid = portraitCfg.awakerTid
  self.portraitNoFromParam = portraitCfg.portraitNo
  self.isTestFace = portraitCfg.isTestFace
  self.portraitAlign = portraitCfg.portraitAlign
  self.showAni = portraitCfg.animationMode or false
  self.inputScreenSpaceMask = portraitCfg.inputScreenSpaceMask
  self.portraitType = portraitCfg.portraitType or CommonDefine.PortraitType.Middle
  self.allowFaceChange = portraitCfg.allowFaceChange
  self.faceName = nil
end

function UICompAwakerPortrait:RegisterEvents()
  if self.allowFaceChange then
    self:BindEvent(EventMgr.Instance.AwakerFaceChange, System.fn(self, self._OnAwakerFaceChanged))
  end
  if self.isTestFace then
    self:BindEvent(EventMgr.Instance.TouchBeginEvent, function()
      self:SendFaceEvent()
    end)
  end
end

function UICompAwakerPortrait:OnEnterComponent()
  self.maskImage = self.container:GetComponent(T_Image)
  if self.maskImage then
    self.maskImage.enabled = true
  end
  self:_RefreshPoitrait()
end

function UICompAwakerPortrait:OnExitComponent()
  self:_ClearPortraitObject()
  Super.OnExitComponent(self)
end

function UICompAwakerPortrait:SetAwakerTid(awakerTid)
  self.awakerTid = awakerTid
  self:_RefreshPoitrait()
end

function UICompAwakerPortrait:SetFace(faceName)
  if not self.faceImg then
    return
  end
  if not faceName then
    self:ClearImage(self.faceImg)
  end
  if self.faceName == faceName then
    return
  end
  self.faceName = faceName
  local facePath = PortraitUtils.GetFaceImg(self.portraitNo, faceName)
  if facePath then
    self:SetImageSync(self.faceImg, facePath)
  end
end

function UICompAwakerPortrait:PlayAppearAnim()
  if self.playShowAni then
    self:PlayAnimState("UI_Portrait_Summon_Awaker_Open")
  end
end

function UICompAwakerPortrait:PlayAnimState(state)
  if self.animController then
    self.animController:PlayState(state)
  end
end

function UICompAwakerPortrait:_RefreshPoitrait()
  self:_ClearPortraitObject()
  local awakerTid = self.awakerTid
  local awakerCfg = awakerTid and DT.AwakerConfig[awakerTid]
  self.portraitNo = self.portraitNoFromParam or awakerCfg and awakerCfg.AwakerResNum
  self.animationMode = self.showAni and AwakerDataUtils.IsOriginType(awakerTid)
  local prefabKey = PortraitUtils.GetFullName(self.portraitNo, self.portraitType)
  if not DT.GetPortraitCenter(prefabKey) then
    Logger.Error("找不到 %s 对应的新立绘, prefabKey=%s", self.portraitNo, prefabKey)
    return
  end
  local oriPrefabPath = PortraitUtils.GetAwakerAniPrefabPath(self.portraitNo, self.portraitType)
  local prefabPath = PortraitUtils.GetAwakerPrefabPath(self.portraitNo, self.portraitType)
  local resultPrefabRes = self.animationMode and oriPrefabPath or prefabPath
  local prefabRes = self:LoadAsset(resultPrefabRes)
  if DynamicPortraitCheckFlag.HasRes(self.portraitNo, self.portraitType) then
    local alphaOriTex = PortraitUtils.GetAwakerAlphaPath(self.portraitNo, self.portraitType)
    self.alphaOriTexRes = self:LoadAsset(alphaOriTex, Texture2D)
  end
  if self.animationMode and not prefabRes then
    prefabRes = self:LoadAsset(prefabPath)
    self.animationMode = false
  end
  local go = CS.UnityEngine.GameObject.Instantiate(prefabRes, self.container.transform)
  self.goPortrait = go
  self:_InitPortraitObject()
  self:_ApplyMaterial()
  self:_PositionedPortrait()
  self:SetFace(nil)
  self:PlayAppearAnim()
end

function UICompAwakerPortrait:_ClearPortraitObject()
  if self.goPortrait then
    Destroy(self.goPortrait)
    self.goPortrait = nil
  end
  if self.maskMat then
    CS.UnityEngine.Object.Destroy(self.maskMat)
    self.maskMat = nil
  end
  self.alphaOriTexRes = nil
end

function UICompAwakerPortrait:_InitPortraitObject()
  if not self.goPortrait then
    return
  end
  local go = self.goPortrait
  self.faceImg = self:FindChild(go, "Image_Awaker/Image_Awaker_Face")
  self.awakerImg = self:FindChild(go, "Image_Awaker")
  self.RT = self:FindChild(go, "RT")
  self.awakerImgComp = self.awakerImg:GetComponent(T_Image)
  if not self.awakerImgComp then
    self.awakerImgComp = self.awakerImg:GetComponent(T_RawImage)
  end
  self.animController = self.awakerImg.gameObject:GetComponentInParent(T_UIAnimationController)
  if self.inputScreenSpaceMask ~= nil then
    self.screenSpaceMask = self.inputScreenSpaceMask
  else
    self.screenSpaceMask = self.gameObject:GetComponentInParent(T_UIScreenSpaceMask)
    if not self.screenSpaceMask then
      self.screenSpaceMask = self.container:GetComponent(T_UIScreenSpaceMask)
    end
  end
  if self.screenSpaceMask then
    self.screenSpaceMask:MaskableGameObject()
    self.screenSpaceMaskable = ScreenSpaceMaskable.Get(self.awakerImg)
    if not IsNil(self.screenSpaceMaskable) then
      self.screenSpaceMaskable.enabled = true
    end
  end
  if self.animationMode then
    local posTable = DynamicPortraitCheckFlag.Pos[self.awakerTid]
    local cameraPos = posTable.cameraPos
    local targetImgPos = posTable.targetImgPos
    local targetImgScale = posTable.targetImgScale
    local orthographicSize = posTable.orthographicSize
    self.LuaBakeRenderTexture = AddLuaCompOnce(self.RT, LuaBakeRenderTexture)
    self.LuaBakeRenderTexture:SetTarget(self.awakerImg)
    self.LuaBakeRenderTexture:SetTargetImageInfo(targetImgPos, targetImgScale, cameraPos, orthographicSize)
  end
  if self.ForceScaleFunc and self.animationMode then
    self.ForceScaleFunc()
  end
  if self.SetForceScaleValueFunc and self.animationMode then
    self.SetForceScaleValueFunc()
  end
  self.ForceScaleFunc = nil
  self.SetForceScaleValueFunc = nil
end

function UICompAwakerPortrait:_ApplyMaterial()
  local canUse = self.awakerImgComp or self.animationMode
  if not canUse then
    return
  end
  local mat, matName = self:_CheckApplyMaterial()
  if not mat then
    return
  end
  local curMat = self:_SetCurMaterial(mat)
  curMat.name = matName
  local screenSpaceMaskable = self.screenSpaceMaskable
  if not IsNil(screenSpaceMaskable) and screenSpaceMaskable.gameObject.activeInHierarchy and screenSpaceMaskable.screenSpaceMask then
    screenSpaceMaskable:LateUpdate()
  end
end

function UICompAwakerPortrait:_CheckApplyMaterial()
  local material = self:_GetCurMaterial()
  local mat, matName
  local useScreenSpacedMask = self.screenSpaceMask ~= nil
  if useScreenSpacedMask then
    if not material or material.name ~= Name_PortraitScreenSpaceMask_Clone then
      matName = Name_PortraitScreenSpaceMask_Clone
      mat = self:LoadAsset(PortraitScreenSpaceMaskMatPath)
    end
  elseif not material or material.name ~= Name_PortraitMaskClone then
    matName = Name_PortraitMaskClone
    mat = self.binder:LoadAsset(PortraitMaskMatPath)
  end
  return mat, matName
end

function UICompAwakerPortrait:_PositionedPortrait()
  local go = self.goPortrait
  local awakerImgTf = self.awakerImg.transform
  if self.portraitAlign == CommonDefine.PortraitAlign.HorizontalCenter then
    PortraitUtils.HorizontalCenter(go.transform, awakerImgTf, self.portraitNo, self.portraitType)
  elseif self.portraitAlign == CommonDefine.PortraitAlign.VerticalCenter then
    PortraitUtils.VerticalCenter(go.transform, awakerImgTf, self.portraitNo, self.portraitType)
  elseif self.portraitAlign == CommonDefine.PortraitAlign.Center then
    PortraitUtils.HorizontalCenter(go.transform, awakerImgTf, self.portraitNo, self.portraitType)
    PortraitUtils.VerticalCenter(go.transform, awakerImgTf, self.portraitNo, self.portraitType)
  end
end

function UICompAwakerPortrait:_OnAwakerFaceChanged(target, faceName)
  local isValid = self.awakerTid == target or self.portraitNo == target
  if not isValid then
    return
  end
  self:SetFace(faceName)
end

function UICompAwakerPortrait:GetCenterXY(centerData)
  local centerX, centerY = centerData.x, centerData.y
  if (centerX > centerData.width or centerY > centerData.height) and centerData.facePosX and centerData.facePosY then
    centerX = centerData.facePosX + 150.0
    centerY = centerData.facePosY + 150.0
  end
  return centerX, centerY
end

function UICompAwakerPortrait:SendFaceEvent()
  if not self.portraitNo then
    return
  end
  local faceMap = PortraitUtils.GetFaceMap(self.portraitNo, self.portraitType)
  local faceList = table.keys(faceMap)
  if #faceList > 0 then
    EventMgr.Instance.AwakerFaceChange:Dispatch(self.portraitNo, faceList[math.random(1, #faceList)])
  end
end

function UICompAwakerPortrait:_GetCurMaterial()
  return self.awakerImgComp.material
end

function UICompAwakerPortrait:_SetCurMaterial(mat)
  local copyMat = Instantiate(mat)
  self:CheckOpenAlphaTexture(copyMat)
  self.awakerImgComp.material = copyMat
  self.maskMat = copyMat
  return copyMat
end

function UICompAwakerPortrait:CheckOpenAlphaTexture(mat)
  local PFeatureMap = MaterialUtils.FeatureMap
  local propertyId = MaterialUtils.ShderPropertyId.K_OpenAlphaOriTex
  local openAlphaTex = self.alphaOriTexRes == nil and 0 or 1
  local func = 0 == openAlphaTex and "DisableKeyword" or "EnableKeyword"
  mat:SetFloat(propertyId, openAlphaTex)
  mat[func](mat, PFeatureMap[propertyId])
  mat:SetTexture("_AlphaOriTexture", self.alphaOriTexRes)
end

function UICompAwakerPortrait:DisableAlphaTexture()
end

function UICompAwakerPortrait:IsPhonePlatform()
  return true
end

function UICompAwakerPortrait:ResetAniPortraitPos(vec)
  if self.animationMode then
    if self:IsPhonePlatform() then
      self.LuaBakeRenderTexture:ResetAniPortraitPos(vec)
    else
      local com = self.RT:GetComponent(typeof(CS.BakeRenderTexture))
      if com then
        com:ResetAniPortraitPos(vec)
      end
    end
  end
end

function UICompAwakerPortrait:ForceScale(state)
  local function temp()
    if self:IsPhonePlatform() then
      self.LuaBakeRenderTexture:ForceScale(state)
    else
      local com = self.RT:GetComponent(typeof(CS.BakeRenderTexture))
      if com then
        com:ForceScale(state)
      end
    end
  end
  
  if self.animationMode then
    temp()
  else
    self.ForceScaleFunc = temp
  end
end

function UICompAwakerPortrait:SetForceScaleValue(vec)
  local function temp()
    if self:IsPhonePlatform() then
      self.LuaBakeRenderTexture:SetForceScaleValue(vec)
    else
      local com = self.RT:GetComponent(typeof(CS.BakeRenderTexture))
      if com then
        com:SetForceScaleValue(vec)
      end
    end
  end
  
  self.SetForceScaleValueFunc = temp
  if self.animationMode then
    temp()
  end
end

function UICompAwakerPortrait:SetMaterialKeyWord(enableKey)
  local PropertyId = MaterialUtils.PortraitShaderPropertyId
  local mat = self:_GetCurMaterial()
  local map = MaterialUtils.PortraitFeatureMap[PropertyId.CircleKey]
  mat:SetFloat(PropertyId.CircleKey, enableKey)
  for index, feature in ipairs(map) do
    local key = index - 1
    local func = enableKey == key and "EnableKeyword" or "DisableKeyword"
    mat[func](mat, feature)
  end
end

return UICompAwakerPortrait
