local CS = _ENV.CS
local GameObjectUtil = CS.Framework.GameObjectUtil
local typeof = _ENV.typeof
local UIAnimationController = CS.Z1Client.UIAnimationController
local CSCanvasGroup = CS.UnityEngine.CanvasGroup
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local ScreenSpaceMaskable = CS.ScreenSpaceMaskable
local AvgNormalRoleItem, Super = System.NewComponent("AvgNormalRoleItem")

function AvgNormalRoleItem:ctor(uiNode, roleData, normalPosList, avgModel)
  Super.ctor(self)
  self.ui = UI_Story_Item_NpcResource(uiNode)
  self.roleData = Vue.ref(roleData)
  self.roleCfg = nil
  self.normalPosList = normalPosList
  self.avgModel = avgModel
  self.rootParent = uiNode.transform.parent.gameObject
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.roleType = cd.AvgRoleType.Normal
  self.canvasGroup = self.ui.uiNode:GetComponent(typeof(CSCanvasGroup))
  self.roleCanvasGroup = nil
  self.portraitNo = Vue.ref(nil)
  self.hideAnimCb = nil
  self.exitAnimCb = nil
  self.isEnterDialog = Vue.ref(false)
  uiNode:SetActive(false)
end

function AvgNormalRoleItem:OnBind(binder)
  self.binder = binder
  binder:BindToRaw(function(childBinder, roleId, _)
    self:CreateRoleGO(roleId)
    childBinder:BindToRaw(function(faceBinder, expression, _)
      self:SetRoleFace(expression)
    end, function()
      return self.roleData.value and self.roleData.value.expression
    end)
    childBinder:BindToRaw(function(_, isMirrorFlip, _)
      self:ApplyMirrorFlip(isMirrorFlip)
    end, function()
      return self.roleData.value and self.roleData.value.isMirrorFlip
    end)
  end, function()
    return self.roleData.value and self.roleData.value.roleId
  end, true)
  binder:BindToRaw(function(_, isTalker, _)
    if isTalker then
      self.rootParent.transform:SetAsLastSibling()
    end
  end, function()
    return self.roleData.value and self.roleData.value.isTalker
  end)
end

function AvgNormalRoleItem:CreateRoleGO(roleId)
  self:ClearRoleGO()
  if not roleId then
    self.roleCfg = nil
    return
  end
  local avgRoleCfg = DT.AvgRole[roleId]
  self.roleCfg = avgRoleCfg
  local awakerRes = self:GetAwakerResNo(avgRoleCfg)
  if awakerRes then
    self:SetNewPortrait(awakerRes, avgRoleCfg)
  end
end

function AvgNormalRoleItem:ClearRoleGO()
  if self.rolePrefabGO then
    CS.UnityEngine.Object.Destroy(self.rolePrefabGO)
    self.rolePrefabGO = nil
    self.roleImg = nil
    self.faceImg = nil
    self.renderMat = nil
    self.UIOverlayingTextureCom = nil
  end
end

function AvgNormalRoleItem:GetAwakerResNo(avgRoleCfg)
  if avgRoleCfg.ID == cd.AvgDialogPlayerId or 1 == avgRoleCfg.ShowAsPlayer then
    do return end
    return GenderDataUtils.GetAvgPlayerRes, cd.AvgDialogPlayerId
  end
  return avgRoleCfg.AwakerResource
end

function AvgNormalRoleItem:GetCenterXY(centerData)
  local centerX, centerY = centerData.x, centerData.y
  if (centerX > centerData.width or centerY > centerData.height) and centerData.facePosX and centerData.facePosY then
    centerX = centerData.facePosX + 150.0
    centerY = centerData.facePosY + 150.0
  end
  return centerX, centerY
end

function AvgNormalRoleItem:HorizontalCenter(awakerRootTf, awakerImgTf)
  local portraitKey = string.format("Portrait_Middle_Awaker_%s", self.portraitNo.value)
  local portraitKey2 = string.format("Portrait_Middle_%s", self.portraitNo.value)
  local centerData = DT.GetPortraitCenter(portraitKey) or DT.GetPortraitCenter(portraitKey2) or {}
  if not centerData.pivotX or not centerData.pivotY then
    print(string.format("%s没有PortraitCenter数据", portraitKey))
    return
  end
  local centerX, centerY = self:GetCenterXY(centerData)
  local centerHeadPos = awakerImgTf:TransformPoint(Vector3(centerX, centerY, 0))
  local centerHeadRootPos = awakerRootTf:InverseTransformPoint(centerHeadPos)
  local curImgPos = awakerImgTf.localPosition
  awakerImgTf.localPosition = Vector3(curImgPos.x - centerHeadRootPos.x, curImgPos.y, curImgPos.z)
end

function AvgNormalRoleItem:VerticalCenter(awakerRootTf, awakerImgTf)
  local portraitKey = string.format("Portrait_Middle_Awaker_%s", self.portraitNo.value)
  local portraitKey2 = string.format("Portrait_Middle_%s", self.portraitNo.value)
  local centerData = DT.GetPortraitCenter(portraitKey) or DT.GetPortraitCenter(portraitKey2) or {}
  if not centerData.pivotX or not centerData.pivotY then
    print(string.format("%s没有PortraitCenter数据", portraitKey))
    return
  end
  local centerX, centerY = self:GetCenterXY(centerData)
  local centerHeadPos = awakerImgTf:TransformPoint(Vector3(centerX, centerY, 0))
  local centerHeadRootPos = awakerRootTf:InverseTransformPoint(centerHeadPos)
  local curImgPos = awakerImgTf.localPosition
  awakerImgTf.localPosition = Vector3(curImgPos.x, curImgPos.y - centerHeadRootPos.y, curImgPos.z)
end

function AvgNormalRoleItem:SetNewPortrait(awakerResource, avgRoleCfg)
  self.ui.Container_Awaker:SetActive(true)
  local binder = self.binder
  local pathPattern = "UI/UI_Portrait/Portrait_Middle_Awaker_%s.prefab"
  if string.contains(awakerResource, "SpChar") then
    pathPattern = "UI/UI_Portrait/Portrait_Middle_%s.prefab"
  end
  self.portraitNo.value = awakerResource
  local prefabPath = string.format(pathPattern, awakerResource)
  local prefabRes = binder:LoadAsset(prefabPath)
  if not prefabRes then
    Alert.ShowStr(string.format("角色 [%s] 找到立绘资源%s", avgRoleCfg.RoleName, prefabPath))
  end
  if prefabRes then
    self.rolePrefabGO = CS.UnityEngine.GameObject.Instantiate(prefabRes, self.ui.Container_Awaker.transform)
    self.roleCanvasGroup = self.rolePrefabGO:GetComponent(typeof(CSCanvasGroup))
    self.binder:SetCanvasGroup(self.ui.Container_Awaker, 1)
    local awakerTf = GameObjectUtil.DeepFindChild(self.rolePrefabGO.transform, "Image_Awaker")
    self.roleImg = awakerTf and awakerTf.gameObject or nil
    local faceTf = GameObjectUtil.DeepFindChild(self.rolePrefabGO.transform, "Image_Awaker_Face")
    self.faceImg = faceTf and faceTf.gameObject or nil
    if self.faceImg then
      self.binder:ClearImage(self.faceImg)
    end
    if self.roleType == cd.AvgRoleType.Horizontal or self.roleType == cd.AvgRoleType.Big then
      self:VerticalCenter(self.rolePrefabGO.transform, awakerTf)
      self:HorizontalCenter(self.rolePrefabGO.transform, awakerTf)
    elseif self.roleType == cd.AvgRoleType.Vertical then
      self:HorizontalCenter(self.rolePrefabGO.transform, awakerTf)
    end
    self.screenSpaceMask = self.ui.Container_Awaker:GetComponent(typeof(CS.UIScreenSpaceMask))
    if self.screenSpaceMask then
      self.screenSpaceMaskable = ScreenSpaceMaskable.Get(self.roleImg.gameObject)
      if not IsNil(self.screenSpaceMaskable) then
        self.screenSpaceMaskable.enabled = true
      end
    end
    self:SetUseScreenSpaceMask(self.screenSpaceMask ~= nil)
  end
end

function AvgNormalRoleItem:SetUseScreenSpaceMask(useScreenSpacedMask)
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
  local vxRootTf = self.ui.Container_Awaker.transform.parent and self.ui.Container_Awaker.transform.parent.parent
  if self.roleType == cd.AvgRoleType.Horizontal and vxRootTf then
    local bgTf = GameObjectUtil.DeepFindChild(vxRootTf, "UI_bg_vx")
    local uiMesh = bgTf and bgTf:GetComponent(typeof(CS.UIMesh))
    local bgMat = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Marerial/UI_bg1.mat")
    if uiMesh and bgMat then
      uiMesh:RefreshMeshRender()
      local meshRenderer = bgTf:GetComponentInChildren(typeof(CS.UnityEngine.MeshRenderer))
      if meshRenderer then
        meshRenderer.material = bgMat
      end
    end
  end
  if mat then
    compImage.material = GameObject.Instantiate(mat)
    compImage.material.name = matName
    if self.ui.Container_Awaker.activeInHierarchy then
      if not CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull(self.screenSpaceMaskable) and self.screenSpaceMaskable.gameObject.activeInHierarchy and self.screenSpaceMaskable.screenSpaceMask then
        self.screenSpaceMaskable:LateUpdate()
      end
    else
      self._frameWaiter = FrameWaiter.OnNextFrame(function()
        if self.ui and self.ui.Container_Awaker.activeInHierarchy and not CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull(self.screenSpaceMaskable) and self.screenSpaceMaskable.gameObject.activeInHierarchy and self.screenSpaceMaskable.screenSpaceMask then
          self.screenSpaceMaskable:LateUpdate()
        end
      end)
    end
  end
end

function AvgNormalRoleItem:SetRoleFace(expression)
  if not self.faceImg or not self.roleCfg.AwakerResource then
    return
  end
  local facePath = PortraitUtils.GetFaceImg(self.roleCfg.AwakerResource, expression)
  if facePath then
    self.binder:SetImageSync(self.faceImg, facePath)
  else
    self.binder:ClearImage(self.faceImg)
  end
end

function AvgNormalRoleItem:GetHideAnim(_)
  if self.roleType == cd.AvgRoleType.Normal then
    return "UI_Story_Popup_Role_danchu_vx"
  elseif self.roleType == cd.AvgRoleType.Horizontal then
    return "UI_Story_Popup_Role_horizontal_danchu_vx"
  elseif self.roleType == cd.AvgRoleType.Vertical then
    return "UI_Story_Popup_Role_vertical_danchu_vx"
  end
end

function AvgNormalRoleItem:GetEnterAnim(roleData)
  if self.roleType == cd.AvgRoleType.Normal then
    if roleData.playEnterAnim then
      if roleData.rolePos <= 3 then
        return "UI_Story_Role_From_Left"
      elseif roleData.rolePos > 3 then
        return "UI_Story_Role_From_Right"
      end
    end
    if roleData.isNew then
      return "UI_Story_Popup_Role_danru_vx"
    end
  elseif self.roleType == cd.AvgRoleType.Horizontal then
    if roleData.isNew then
      return "UI_Story_Popup_Role_horizontal_danru_vx"
    end
  elseif self.roleType == cd.AvgRoleType.Vertical and roleData.isNew then
    return "UI_Story_Popup_Role_vertical_danru_vx"
  end
end

function AvgNormalRoleItem:GetShakeAnim(roleData)
  if not roleData.isShake then
    return
  end
  if not roleData.shakeDirection or roleData.shakeDirection == cd.AvgRoleShakeDirection.Horizontal then
    if self.roleType == cd.AvgRoleType.Normal then
      return "UI_Story_Role_Tremble"
    elseif self.roleType == cd.AvgRoleType.Horizontal then
      return "UI_Story_Anim_Cartoon_Tremble_H"
    elseif self.roleType == cd.AvgRoleType.Vertical then
      return "UI_Story_Anim_Cartoon_Tremble_V"
    end
  elseif roleData.shakeDirection == cd.AvgRoleShakeDirection.Vertical then
    if self.roleType == cd.AvgRoleType.Vertical then
      return "UI_Story_Anim_Cartoon_Tremble_V_VDir"
    else
      return "UI_Story_Anim_Cartoon_Tremble_H_VDir"
    end
  end
end

function AvgNormalRoleItem:GetExitAnim(roleData)
  if roleData.exitDirection then
    if self.roleType == cd.AvgRoleType.Normal then
      local anim = "UI_Story_Popup_Role_danchu_vx"
      if 1 == roleData.exitDirection then
        anim = "UI_Story_Role_Exit_To_Left"
      elseif 2 == roleData.exitDirection then
        anim = "UI_Story_Role_Exit_To_Right"
      end
      return anim
    elseif self.roleType == cd.AvgRoleType.Horizontal then
      return "UI_Story_Popup_Role_horizontal_danchu_vx"
    elseif self.roleType == cd.AvgRoleType.Vertical then
      return "UI_Story_Popup_Role_vertical_danchu_vx"
    end
  end
end

function AvgNormalRoleItem:DoEnterDialog()
  local roleData = self.roleData.value
  local isPureVideoDialog = self.avgModel:IsPureVideoDialog()
  if not roleData or isPureVideoDialog then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  local roleId = self.roleData.value and self.roleData.value.roleId
  if roleId and not self.roleImg then
    self:CreateRoleGO(roleId)
    self:SetRoleFace(self.roleData.value and self.roleData.value.expression)
  end
  if self._needClearAnimCb then
    self.uiAnimationController:ClearCompleteCb()
  end
  self._needClearAnimCb = nil
  self.uiAnimationController:StopPlayableGraph()
  self:ResetRoleAlpha()
  self:SetExitAnimCb(System.fn(self, self.ResetRoleAlpha))
  self:SetHideAnimCb(System.fn(self, self.ResetRoleAlpha))
  self:MoveToNewPos(roleData)
  self:PlayRoleHideAnim(roleData)
  if roleData.isNew and not roleData.playEnterAnim then
    self:ResetRolePos()
    self:ResetRoleAlpha()
  end
  self:PlayRoleEnterAnim(roleData)
  self:SetRoleColorAndMat(roleData)
  self:PlayRoleScaleAnim(roleData)
end

function AvgNormalRoleItem:MoveToNewPos(roleData)
  if roleData.oldPos and self.roleType == cd.AvgRoleType.Normal then
    local posVector3 = self.normalPosList[roleData.oldPos]
    self.rootParent.transform:DOLocalMove(posVector3, 0.4):From()
  end
end

function AvgNormalRoleItem:PlayRoleHideAnim(roleData)
  if roleData.isHide then
    if self.avgModel.isForbidHideRoleAnim or roleData.isNew then
      self:ClearRoleGO()
      self:SetNodeInAcitve()
    else
      self:SetHideAnimCb(System.fn(self, self.SetNodeInAcitve))
      local hideAnim = self:GetHideAnim(roleData)
      if hideAnim then
        self._needClearAnimCb = true
        self:PlayState(hideAnim, function()
          self:ClearRoleGO()
          if self.hideAnimCb then
            self.hideAnimCb()
          end
        end)
      end
    end
  end
end

function AvgNormalRoleItem:PlayRoleEnterAnim(roleData)
  local enterAnim = self:GetEnterAnim(roleData)
  local ShakeAnim = self:GetShakeAnim(roleData)
  if enterAnim or ShakeAnim then
    local multiState = AddClipToPlay(enterAnim or "", ShakeAnim or "")
    self:PlayState(multiState, nil, true)
  end
end

function AvgNormalRoleItem:SetRoleColorAndMat(roleData)
  local roleImgColor = {
    1,
    1,
    1,
    1
  }
  if not roleData.isTalker then
    roleImgColor = {
      0.35294117647058826,
      0.35294117647058826,
      0.35294117647058826,
      1
    }
  end
  if roleData.isBlackOutLine then
    roleImgColor = {
      0,
      0,
      0,
      1
    }
  end
  if roleData.isLightRole then
    roleImgColor = {
      1,
      1,
      1,
      1
    }
  end
  self:SetRoleMat(roleData)
  if self.roleImg then
    self.binder:SetImageColor(self.roleImg, table.unpack(roleImgColor))
  end
  if self.faceImg then
    self.binder:SetImageColor(self.faceImg, table.unpack(roleImgColor))
  end
end

function AvgNormalRoleItem:SetRoleMat(roleData)
  if self.roleImg then
    self.renderMat = self.roleImg:GetComponent(typeof(CS.UnityEngine.UI.Image)).material
    self.UIOverlayingTextureCom = self.roleImg:GetComponent(typeof(CS.UIOverlayingTexture))
  else
    self.renderMat = nil
  end
  self.keywordsData = {}
  table.insert(self.keywordsData, {
    name = "_HEIGHTRAMPKEY_ON",
    enabled = roleData.isFadeDark
  })
  table.insert(self.keywordsData, {
    name = "_WATERRGBKEY_ON",
    enabled = nil ~= roleData.waterColorOffset,
    func = function(mat)
      if mat and roleData.waterColorOffset then
        local st = mat:GetVector("_WaterRGB_ST")
        st.z = roleData.waterColorOffset.x or 0
        st.w = roleData.waterColorOffset.y or 0
        mat:SetVector("_WaterRGB_ST", st)
      end
    end
  })
  self:_EnableMatKeyword()
end

function AvgNormalRoleItem:_EnableMatKeyword()
  if not self.renderMat or not self.UIOverlayingTextureCom then
    return
  end
  self.UIOverlayingTextureCom:LateUpdateCallLuaFunc(function()
    if not self.keywordsData then
      return
    end
    local mat = self.UIOverlayingTextureCom:GetMaterial()
    if mat then
      for i = 1, #self.keywordsData do
        local name = self.keywordsData[i].name
        local enabled = self.keywordsData[i].enabled
        local func = self.keywordsData[i].func
        if enabled then
          mat:EnableKeyword(name)
        else
          mat:DisableKeyword(name)
        end
        if func then
          func(mat)
        end
      end
    end
    self.keywordsData = nil
  end)
end

function AvgNormalRoleItem:PlayRoleScaleAnim(roleData)
  if not self.rolePrefabGO then
    return
  end
  local baseScale = roleData.roleScale or 1
  local mirrorX = roleData.isMirrorFlip and -1 or 1
  local toScale = Vector3(mirrorX * baseScale, baseScale, 1)
  if not roleData.roleScaleDura then
    self.rolePrefabGO.transform.localScale = toScale
  else
    self._scaleTw = self.rolePrefabGO.transform:DOScale(toScale, roleData.roleScaleDura)
  end
end

function AvgNormalRoleItem:ApplyMirrorFlip(isMirrorFlip)
  if not self.rolePrefabGO then
    return
  end
  local roleData = self.roleData.value
  if not roleData then
    return
  end
  local baseScale = roleData.roleScale or 1
  local mirrorX = isMirrorFlip and -1 or 1
  self.rolePrefabGO.transform.localScale = Vector3(mirrorX * baseScale, baseScale, 1)
end

function AvgNormalRoleItem:SetRoleDark()
  local roleImgColor = {
    0.35294117647058826,
    0.35294117647058826,
    0.35294117647058826,
    1
  }
  if self.roleImg then
    self.binder:SetImageColor(self.roleImg, table.unpack(roleImgColor))
  end
  if self.faceImg then
    self.binder:SetImageColor(self.faceImg, table.unpack(roleImgColor))
  end
end

function AvgNormalRoleItem:DoExitDialog(callback)
  callback = callback or function()
  end
  local roleData = self.roleData.value
  if not roleData then
    callback()
    return
  end
  if self.avgModel:IsCaption() then
    callback()
    return
  end
  local exitAnim = self:GetExitAnim(roleData)
  if exitAnim then
    self:SetExitAnimCb(System.fn(self, self.SetNodeInAcitve))
    self:PlayState(exitAnim, function()
      self.ui.Group.transform.anchoredPosition = Vector2.zero
      if self.exitAnimCb then
        self.exitAnimCb()
      end
      callback()
    end)
  else
    callback()
  end
end

function AvgNormalRoleItem:PlayState(anim, callback, isMulti)
  callback = callback or function()
  end
  if not anim then
    callback()
  end
  self.uiAnimationController:StopPlayableGraph()
  if not isMulti then
    self.uiAnimationController:PlayState(anim, callback)
  else
    self.uiAnimationController:PlayMultiState(anim, callback)
  end
end

function AvgNormalRoleItem:SetHideAnimCb(cb)
  self.hideAnimCb = cb
end

function AvgNormalRoleItem:SetExitAnimCb(cb)
  self.exitAnimCb = cb
end

function AvgNormalRoleItem:ResetRoleAlpha()
  if self.canvasGroup then
    self.canvasGroup.alpha = 1
  end
  if self.roleCanvasGroup then
    self.roleCanvasGroup.alpha = 1
  end
  self.ui.uiNode:SetActive(true)
end

function AvgNormalRoleItem:ResetRolePos()
  if self.ui.Group then
    self.ui.Group.transform.localPosition = Vector3.zero
  end
end

function AvgNormalRoleItem:SetNodeInAcitve()
  self.ui.uiNode:SetActive(false)
end

function AvgNormalRoleItem:OnUnbind()
  if self._frameWaiter then
    FrameWaiter.RemoveWaiter(self._frameWaiter)
  end
  self:ClearRoleGO()
  Super.OnUnbind(self)
end

return AvgNormalRoleItem
