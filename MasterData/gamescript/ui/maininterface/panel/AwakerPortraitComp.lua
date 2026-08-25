local Vector3 = CS.UnityEngine.Vector3
local Texture2D = typeof(CS.UnityEngine.Texture2D)
local AwakerPortraitComp, Super = System.NewComponent("AwakerPortraitComp")
local ScreenSpaceMaskable = CS.ScreenSpaceMaskable
local isEditorMode = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor
local T_UI_Distort_Dissolve
if isEditorMode then
  T_UI_Distort_Dissolve = typeof(CS.UI_Distort_Dissolve)
end
local T_UIScreenSpaceMask = typeof(CS.UIScreenSpaceMask)

function AwakerPortraitComp:ctor(container, awakerTid, portraitNo, isTestFace, portraitAlign, extParams)
  Super.ctor(self)
  self.container = container
  self.awakerTid = Vue.ref(awakerTid)
  if portraitNo then
    self.awakerTid.value = nil
  end
  self.portraitNo = Vue.ref(portraitNo)
  self.faceName = Vue.ref(nil)
  self.isTestFace = isTestFace
  self.portraitAlign = portraitAlign
  self.showAni = extParams and extParams.animationMode or false
  self.inputScreenSpaceMask = extParams and extParams.inputScreenSpaceMask
  self.prefabPath = extParams and extParams.prefabPath
  self.allowFaceChange = extParams and extParams.allowFaceChange
end

function AwakerPortraitComp:OnBind(binder)
  self.binder = binder
  self:BindAwakerTid()
  binder:BindToRaw(function(childBinder, portraitNo)
    self.faceName.value = nil
    if not portraitNo then
      self.faceImg = nil
      self.awakerImg = nil
      return
    end
    childBinder:SetAssetTarget(childBinder)
    local isOrigin = table.contains(DT.GetOriginalConstant("OriginAwakerList", {}), self.awakerTid.value)
    local isDynamicSkin = AwakerSkinUtils.IsDynamicSkinRes(portraitNo)
    self.animationMode = self.showAni and (isOrigin or isDynamicSkin)
    local oriPrefabPath = PortraitUtils.GetAwakerAniPrefabPath(portraitNo)
    local prefabPath = self.prefabPath or PortraitUtils.GetAwakerPrefabPath(portraitNo)
    local prefabKey = PortraitUtils.GetFullName(portraitNo)
    local alphaOriTex = PortraitUtils.GetAwakerAlphaPath(portraitNo)
    if not DT.GetPortraitCenter(prefabKey) then
      Logger.Error("找不到 %s 对应的新立绘", portraitNo)
      return
    end
    local resultPrefabRes = self.animationMode and oriPrefabPath or prefabPath
    local prefabRes = childBinder:LoadAsset(resultPrefabRes)
    if DynamicPortraitCheckFlag.HasRes(portraitNo) then
      self.alphaOriTexRes = childBinder:LoadAsset(alphaOriTex, Texture2D)
    end
    if self.animationMode and not prefabRes then
      prefabRes = childBinder:LoadAsset(prefabPath)
      self.animationMode = false
    end
    local go = CS.UnityEngine.GameObject.Instantiate(prefabRes, self.container.transform)
    self.portraitGo = go
    local awakerImgTf = go.transform:Find("Image_Awaker")
    local faceTf = go.transform:Find("Image_Awaker/Image_Awaker_Face")
    self.faceImg = faceTf and faceTf.gameObject
    self.awakerImg = go.transform:Find("Image_Awaker")
    self.RT = go.transform:Find("RT")
    self.awakerImgComp = self.awakerImg:GetComponent(typeof(CS.UnityEngine.UI.Image))
    self.UIOverlayingTextureCom = self.awakerImg:GetComponent(typeof(CS.UIOverlayingTexture))
    self.screenSpaceMask = GoUtils.GetComponentInParent(self.awakerImg.gameObject, T_UIScreenSpaceMask)
    if not self.screenSpaceMask then
      self.screenSpaceMask = self.container:GetComponent(T_UIScreenSpaceMask)
    end
    if nil ~= self.inputScreenSpaceMask then
      self.screenSpaceMask = self.inputScreenSpaceMask
    end
    if self.screenSpaceMask then
      self.screenSpaceMask:MaskableGameObject()
      self.screenSpaceMaskable = ScreenSpaceMaskable.Get(self.awakerImg.gameObject)
      if not IsNil(self.screenSpaceMaskable) then
        self.screenSpaceMaskable.enabled = true
      end
    end
    self:SetUseScreenSpaceMask(nil ~= self.screenSpaceMask)
    self:_ChangeMaterialMask()
    if self.faceImg then
      childBinder:ClearImage(self.faceImg)
    end
    childBinder:onDestroy(function()
      if self.maskMat then
        CS.UnityEngine.Object.Destroy(self.maskMat)
        self.maskMat = nil
      end
      CS.UnityEngine.Object.Destroy(go)
      self.alphaOriTexRes = nil
    end)
    if self.portraitAlign == CommonDefine.PortraitAlign.HorizontalCenter then
      PortraitUtils.HorizontalCenter(go.transform, awakerImgTf, self.portraitNo.value)
    elseif self.portraitAlign == CommonDefine.PortraitAlign.VerticalCenter then
      PortraitUtils.VerticalCenter(go.transform, awakerImgTf, self.portraitNo.value)
    elseif self.portraitAlign == CommonDefine.PortraitAlign.Center then
      PortraitUtils.HorizontalCenter(go.transform, awakerImgTf, self.portraitNo.value)
      PortraitUtils.VerticalCenter(go.transform, awakerImgTf, self.portraitNo.value)
    end
    if self.isTestFace then
      childBinder:BindEvent(EventMgr.Instance.TouchBeginEvent, function()
        self:SendFaceEvent()
      end)
    end
    if self.allowFaceChange then
      childBinder:BindEvent(EventMgr.Instance.AwakerFaceChange, function(target, faceName)
        local isValid = self.awakerTid.value == target or portraitNo == target
        if not isValid then
          return
        end
        self:ChangeFace(faceName)
      end)
    end
    if self.playShowAni then
      local UIAnimationController = CS.Z1Client.UIAnimationController
      local animController = self.awakerImg.gameObject:GetComponentInParent(typeof(UIAnimationController))
      animController:PlayState("UI_Portrait_Summon_Awaker_Open")
    end
    if self.animationMode and self:IsPhonePlatform() then
      local posTable = DynamicPortraitCheckFlag.Pos[self.awakerTid.value] or DynamicPortraitCheckFlag.Pos[0]
      local cameraPos = posTable.cameraPos
      local targetImgPos = posTable.targetImgPos
      local targetImgScale = posTable.targetImgScale
      local orthographicSize = posTable.orthographicSize
      local skinCfg = AwakerSkinUtils.GetSkinCfgBySkinRes(portraitNo)
      if skinCfg and skinCfg.DynamicPara then
        cameraPos = Vector3(skinCfg.DynamicPara[1], skinCfg.DynamicPara[2], skinCfg.DynamicPara[3])
        orthographicSize = skinCfg.DynamicPara[4]
      end
      self.LuaBakeRenderTexture = AddLuaCompOnce(self.RT, LuaBakeRenderTexture)
      self.LuaBakeRenderTexture:SetTarget(awakerImgTf)
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
  end, function()
    return self.portraitNo.value
  end, true)
  self.maskImage = self.container:GetComponent(typeof(CS.UnityEngine.UI.Image))
  if self.maskImage then
    self.maskImage.enabled = true
  end
end

function AwakerPortraitComp:BindAwakerTid()
  self.binder:BindToRaw(function(_, awakerTid)
    if not awakerTid then
      return
    end
    local awakerCfg = awakerTid and DT.AwakerConfig[awakerTid]
    local awakerResNum = awakerCfg and awakerCfg.AwakerResNum
    self.portraitNo.value = awakerResNum
    self.faceName.value = nil
  end, function()
    return self.awakerTid.value
  end, true)
end

function AwakerPortraitComp:_ChangeMaterialMask()
end

function AwakerPortraitComp:SetUseScreenSpaceMask(useScreenSpacedMask)
  self.useScreenSpacedMask = useScreenSpacedMask
  local canUse = self.awakerImgComp or self.animationMode
  if not canUse then
    return
  end
  local material = self:GetMat()
  local mat, matName
  if self.useScreenSpacedMask then
    if not material or material.name ~= "Z1_UI_PortraitScreenSpaceMask_Clone" then
      matName = "Z1_UI_PortraitScreenSpaceMask_Clone"
      mat = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitScreenSpaceMask.mat")
    end
  elseif not material or material.name ~= "Z1_UI_PortraitMask_Clone" then
    matName = "Z1_UI_PortraitMask_Clone"
    mat = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitMask.mat")
  end
  if mat then
    self:SetMat(mat)
    self:GetMat().name = matName
    if self.useScreenSpacedMask and not self.screenSpaceMaskable then
      self.screenSpaceMaskable = ScreenSpaceMaskable.Get(self.awakerImg.gameObject)
      if not IsNil(self.screenSpaceMaskable) then
        self.screenSpaceMaskable.enabled = true
      end
    end
    if not IsNil(self.screenSpaceMaskable) and self.screenSpaceMaskable.gameObject.activeInHierarchy and self.screenSpaceMaskable.screenSpaceMask then
      self.screenSpaceMaskable:LateUpdate()
    end
  end
end

function AwakerPortraitComp:ChangeMaterialMask(maskPath)
  self.maskPath = maskPath
  if self.awakerImg then
    self:_ChangeMaterialMask()
  end
end

function AwakerPortraitComp:SendFaceEvent()
  if not self.portraitNo.value then
    return
  end
  local faceMap = PortraitUtils.GetFaceMap(self.portraitNo.value)
  local faceList = table.keys(faceMap)
  if #faceList > 0 then
    EventMgr.Instance.AwakerFaceChange:Dispatch(self.portraitNo.value, faceList[math.random(1, #faceList)])
  end
end

function AwakerPortraitComp:ChangeAwakerTid(awakerTid)
  if not awakerTid then
    return
  end
  self.awakerTid.value = awakerTid
end

function AwakerPortraitComp:ChangeAwakerWithResNum(awakerTid, resNum)
  if not awakerTid then
    return
  end
  self.awakerTid.value = awakerTid
  if resNum then
    self.portraitNo.value = resNum
  end
end

function AwakerPortraitComp:ChangeFace(faceName)
  self.faceName.value = faceName
  if not faceName and self.faceImg then
    self.binder:ClearImage(self.faceImg)
  end
  local facePath = PortraitUtils.GetFaceImg(self.portraitNo.value, faceName)
  if facePath and self.faceImg then
    self.binder:SetImageSync(self.faceImg, facePath)
  end
end

function AwakerPortraitComp:PlayShowAni()
  self.playShowAni = true
end

function AwakerPortraitComp:ShowEffect(effectId, time)
  local DOTween = CS.DG.Tweening.DOTween
  local PropertyId = MaterialUtils.PortraitShaderPropertyId
  local enableKey = effectId
  local mat = self:GetMat()
  self:SetMaterialKeyWord(enableKey)
  if effectId == MaterialUtils.AwakerPortraitEffect.Revert then
    mat:SetFloat(PropertyId.AMax, 0)
  elseif effectId == MaterialUtils.AwakerPortraitEffect.ToBase then
    DOTween.To(function()
      return -5
    end, function(newV)
      mat:SetFloat(PropertyId.BackMin1, newV)
    end, 1, time or 0.53, self)
  elseif effectId == MaterialUtils.AwakerPortraitEffect.ToDark then
    DOTween.To(function()
      return 1
    end, function(newV)
      mat:SetFloat(PropertyId.LightDarkD, newV)
    end, 0, time or 0.3, self)
  elseif effectId == MaterialUtils.AwakerPortraitEffect.ToOrigin1 then
    DOTween.To(function()
      return 0
    end, function(newV)
      mat:SetFloat(PropertyId.AMax, newV)
    end, 1, time or 5, self)
  elseif effectId == MaterialUtils.AwakerPortraitEffect.ToOrigin2 then
    DOTween.To(function()
      return 1
    end, function(newV)
      mat:SetFloat(PropertyId.BackMin1, newV)
    end, -2, time, self)
  end
end

function AwakerPortraitComp:GetMat()
  if self.animationMode then
    return self.maskMat
  else
    return self.awakerImgComp.material
  end
end

function AwakerPortraitComp:SetAlpha(alpha)
  if self.animationMode then
    local rawImg = self.awakerImg:GetComponent(typeof(CS.UnityEngine.UI.RawImage))
    if rawImg then
      local color = rawImg.color
      color.a = alpha or 1
      rawImg.color = color
    end
  elseif self.awakerImgComp then
    local color = self.awakerImgComp.color
    color.a = alpha or 1
    self.awakerImgComp.color = color
  end
end

function AwakerPortraitComp:SetDissolveKeyOn(isOn)
  if isEditorMode and self.awakerImg then
    local comps = self.awakerImg.gameObject:GetComponents(T_UI_Distort_Dissolve)
    if 0 == comps.Length then
      Logger.Error(self.portraitGo.name .. "的Image_Awaker节点缺少UI_Distort_Dissolve组件！！！")
      return
    elseif comps.Length > 1 then
      Logger.Error(self.portraitGo.name .. "的Image_Awaker节点挂了多个UI_Distort_Dissolve组件！请删除多余的，只保留一个")
      return
    end
  end
  local mat = self:GetMat()
  if mat then
    if isOn then
      mat:EnableKeyword("_DISSOLVEKEY_ON")
    else
      mat:DisableKeyword("_DISSOLVEKEY_ON")
    end
  end
end

function AwakerPortraitComp:CheckOpenAlphaTexture(mat)
  local PFeatureMap = MaterialUtils.FeatureMap
  local propertyId = MaterialUtils.ShderPropertyId.K_OpenAlphaOriTex
  local openAlphaTex = self.alphaOriTexRes == nil and 0 or 1
  local func = 0 == openAlphaTex and "DisableKeyword" or "EnableKeyword"
  mat:SetFloat(propertyId, openAlphaTex)
  mat[func](mat, PFeatureMap[propertyId])
  mat:SetTexture("_AlphaOriTexture", self.alphaOriTexRes)
end

function AwakerPortraitComp:SetMat(mat)
  local copyMat = GameObject.Instantiate(mat)
  self:CheckOpenAlphaTexture(copyMat)
  if self.animationMode then
    local rawImg = self.awakerImg:GetComponent(typeof(CS.UnityEngine.UI.RawImage))
    self:PreSetMaterialWithMask(rawImg, copyMat)
  else
    self.awakerImgComp.material = copyMat
  end
end

function AwakerPortraitComp:PreSetMaterialWithMask(rawImg, maskMat)
  rawImg.material = maskMat
  self.maskMat = maskMat
end

function AwakerPortraitComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerPortraitComp:IsPhonePlatform()
  return true
end

function AwakerPortraitComp:ResetAniPortraitPos(vec)
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

function AwakerPortraitComp:ForceScale(state)
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

function AwakerPortraitComp:SetForceScaleValue(vec)
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

function AwakerPortraitComp:SetMaterialKeyWord(enableKey)
  local PropertyId = MaterialUtils.PortraitShaderPropertyId
  local mat = self:GetMat()
  local map = MaterialUtils.PortraitFeatureMap[PropertyId.CircleKey]
  mat:SetFloat(PropertyId.CircleKey, enableKey)
  for index, feature in ipairs(map) do
    local key = index - 1
    local func = enableKey == key and "EnableKeyword" or "DisableKeyword"
    mat[func](mat, feature)
  end
end

return AwakerPortraitComp
