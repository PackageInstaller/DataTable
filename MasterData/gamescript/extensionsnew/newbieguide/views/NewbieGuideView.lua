local Quaternion = CS.UnityEngine.Quaternion
local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local Vector4 = CS.UnityEngine.Vector4
local CSImage = typeof(CS.UnityEngine.UI.Image)
local ShaderPropertyToID = CS.UnityEngine.Shader.PropertyToID
local CutoutRectId = ShaderPropertyToID("_CutoutRect")
local _SetLocalScale = CS.Framework.TransformUtil.SetLocalScale
local DefaultPos = {x = 50, y = -394}
local NewbieGuideView, Super = NewClass("NewbieGuideView", BaseView)
NewbieGuideView.uiResCls = UI_Guide_NewbieGuideResource

function NewbieGuideView:ctor(guideTid, guideIndex, guideCfg, closeCb)
  Super.ctor(self)
  self._guideTid = guideTid
  self._guideIndex = guideIndex
  self._guideCfg = guideCfg
  self._closeCb = closeCb
  self._maskMaterial = nil
  self._maskTransform = nil
  self._vec4 = nil
  self._vec2 = nil
  self._animCtr = nil
  self._focusTimerId = nil
  self._checkTouchEnd = false
  self._isClickedMask = nil
end

function NewbieGuideView:OnBuildView()
  self:_InitMaskMaterial()
end

function NewbieGuideView:RegisterNotifications()
end

function NewbieGuideView:RegisterEvents()
  self:AddButtonClickListener(self.ui.ClickMask1, System.fn(self, self._OnTouchMask))
  self:AddButtonClickListener(self.ui.ClickMask2, System.fn(self, self._OnTouchMask))
  self:AddButtonClickListener(self.ui.ClickMask3, System.fn(self, self._OnTouchMask))
  self:AddButtonClickListener(self.ui.ClickMask4, System.fn(self, self._OnTouchMask))
  self:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self._OnTouchBegin))
  self:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self._OnTouchEnd))
end

function NewbieGuideView:OnEnterView()
  Super.OnEnterView(self)
  NewbieGuideModel.Instance:SetGuideData(self._guideTid, self._guideIndex, self._guideCfg)
  self:_BindContent()
  self:_BindDirection()
  self:_PlayHandAnim()
  self:_FocusNodeRect()
  self._focusTimerId = self:BindTimer(0.03, -1, System.fn(self, self._FocusNodeRect))
  self:_BindGuideOffset()
  EventMgr.Instance.CloseClickMask:Dispatch("NewbieGuidePanel")
end

function NewbieGuideView:OnExitView()
  if self._focusTimerId then
    self:StopTimer(self._focusTimerId)
    self._focusTimerId = nil
  end
  self._maskMaterial = nil
  self._maskTransform = nil
  self._vec4 = nil
  self._vec2 = nil
  if self:_IsNeedForbidClick() then
    EventMgr.Instance.OpenClickMask:Dispatch("NewbieGuidePanel", 1.5)
  end
  if self._closeCb then
    self._closeCb()
  end
  Super.OnExitView(self)
end

function NewbieGuideView:_InitMaskMaterial()
  local image = self.ui.Gropu_Mask:GetComponent(CSImage)
  self._maskMaterial = image.material
  self._maskTransform = self.ui.Gropu_Mask.transform
  self._vec4 = Vector4(0, 0, 0, 0)
  self._vec2 = Vector2(0, 0)
end

function NewbieGuideView:IsForceGuide()
  do return NewbieGuideModel.Instance.IsForceGuide end
  return NewbieGuideModel.Instance.IsForceGuide, NewbieGuideModel.Instance
end

function NewbieGuideView:IsClickAnywhereGuide()
  do return NewbieGuideModel.Instance.IsClickAnywhereGuide end
  return NewbieGuideModel.Instance.IsClickAnywhereGuide, NewbieGuideModel.Instance
end

function NewbieGuideView:_IsNeedForbidClick()
  local notForbidClickList = {81502}
  if table.contains(notForbidClickList, self._guideTid) then
    return false
  end
  return true
end

function NewbieGuideView:_BindContent()
  local content = NewbieGuideModel.Instance:GetContent()
  if content then
    self.ui.Group_Desc:SetActive(true)
    self:SetText(self.ui.Text_Desc, content)
  else
    self.ui.Group_Desc:SetActive(false)
  end
end

function NewbieGuideView:_FocusNodeRect()
  local isForce = self:IsForceGuide()
  local isClickAnywhere = self:IsClickAnywhereGuide()
  self.ui.Gropu_Mask:SetActive(isForce)
  self.ui.Group_Frame:SetActive(false)
  self.ui.UI_Guide_Popup_FuncGuide:SetActive(false)
  self.ui.Group_ClickMask:SetActive(isForce)
  local nodeName = self:GetNodeName()
  if nodeName then
    local nodeRect = GuideUtils.GetRectCommon(nodeName)
    if nodeRect then
      self.ui.UI_Guide_Popup_FuncGuide.transform.position = nodeRect.centerPos
      self.ui.UI_Guide_Popup_FuncGuide:SetActive(true)
      if isForce then
        self:_SetFocusRect(nodeRect)
      end
    end
  elseif isClickAnywhere then
    self.ui.UI_Guide_Popup_FuncGuide:SetActive(true)
  end
end

function NewbieGuideView:_BindGuideOffset()
  local descOffset = NewbieGuideModel.Instance:GetContentOffset()
  self.ui.Group_Desc.transform.localPosition = Vector3(DefaultPos.x + (descOffset[1] or 0), DefaultPos.y + (descOffset[2] or 0), 0)
  local descHeight = StrUtils.SetPreferredHeight(self.ui.Text_Desc, 30)
  self.ui.Image_Desc_Bg.transform.sizeDelta = CS.UnityEngine.Vector2(1500, descHeight)
end

function NewbieGuideView:_BindDirection()
  local direction = self:GetGuideDirection()
  if direction then
    local rota = self:_TransHandRotation(direction)
    self.ui.UI_Guide_Popup_FuncGuide.transform.localRotation = Quaternion.Euler(0, 0, rota)
  end
end

function NewbieGuideView:GetGuideDirection()
  do return NewbieGuideModel.Instance.GetGuideDirection end
  return NewbieGuideModel.Instance.GetGuideDirection, NewbieGuideModel.Instance
end

function NewbieGuideView:GetNodeName()
  do return NewbieGuideModel.Instance.GetNodeName end
  return NewbieGuideModel.Instance.GetNodeName, NewbieGuideModel.Instance
end

function NewbieGuideView:_PlayHandAnim()
  if not self._animCtr then
    self._animCtr = self.ui.UI_Guide_Popup_FuncGuide:GetComponent(typeof(UIAnimationController))
  end
  if self:IsForceGuide() then
    self._animCtr:LoopPlayState("UI_Guide_Popup_FuncGuide_Intensity")
  else
    self._animCtr:LoopPlayState("UI_Guide_Popup_FuncGuide_Weak")
  end
end

function NewbieGuideView:_OnTouchBegin()
  if not GuidePanelUtils.IsViewAtTop(self.url) then
    self._checkTouchEnd = false
    return
  end
  self._checkTouchEnd = true
end

function NewbieGuideView:_OnTouchEnd()
  EventMgr.Instance.NewbieGuideClick:Dispatch()
  if not self._isClickedMask and self._checkTouchEnd then
    if self:IsClickAnywhereGuide() then
      EventMgr.Instance.NewbieGuidePass:Dispatch(self._guideTid, self._guideIndex)
    elseif self:IsForceGuide() then
      EventMgr.Instance.NewbieGuidePass:Dispatch(self._guideTid, self._guideIndex)
    end
  end
  self._isClickedMask = nil
end

function NewbieGuideView:_OnTouchMask()
  EventMgr.Instance.NewbieGuideClick:Dispatch()
  if self:IsClickAnywhereGuide() then
    EventMgr.Instance.NewbieGuidePass:Dispatch(self._guideTid, self._guideIndex)
  else
    if self._animCtr then
      self._animCtr:StopPlayableGraph()
    end
    self:_PlayHandAnim()
  end
  self._isClickedMask = true
end

function NewbieGuideView:_SetFocusRect(focusRect)
  if not focusRect then
    self.ui.Gropu_Mask:SetActive(false)
    self.ui.Group_Frame:SetActive(false)
    return
  end
  self.ui.Gropu_Mask:SetActive(true)
  self.ui.Group_Frame:SetActive(true)
  local outSize = 20
  local focusRectW = focusRect.width + outSize
  local focusRectH = focusRect.height + outSize
  local localPos = self._maskTransform:InverseTransformPoint(focusRect.centerPos)
  local targetScale = focusRect.lossyScale
  local maskScale = self._maskTransform.lossyScale
  local localHalfW = focusRectW * 0.5 * targetScale.x / maskScale.x
  local localHalfH = focusRectH * 0.5 * targetScale.y / maskScale.y
  if self._maskMaterial then
    self._vec4.x = localPos.x - localHalfW
    self._vec4.y = localPos.y - localHalfH
    self._vec4.z = localPos.x + localHalfW
    self._vec4.w = localPos.y + localHalfH
    self._maskMaterial:SetVector(CutoutRectId, self._vec4)
  end
  local frameW, frameH = 100, 100
  local scaleX = focusRectW / frameW
  local scaleY = focusRectH / frameH
  self.ui.UI_Guide_Frame.transform.position = focusRect.centerPos
  _SetLocalScale(self.ui.UI_Guide_Frame.transform, scaleX, scaleY, 1)
  local frameOutLightSize = 30
  self._vec2.x = focusRectW + frameOutLightSize
  self._vec2.y = focusRectH + frameOutLightSize
  self.ui.Group_Frame_Kuang.transform.sizeDelta = self._vec2
  _SetLocalScale(self.ui.Group_Frame_Kuang.transform, 1 / scaleX, 1 / scaleY, 1)
end

function NewbieGuideView:_TransHandRotation(direction)
  if direction == cd.GuidePos.GO_UP then
    return 180
  elseif direction == cd.GuidePos.GO_DOWN then
    return 0
  elseif direction == cd.GuidePos.GO_LEFT then
    return -90
  elseif direction == cd.GuidePos.GO_RIGHT then
    return 90
  elseif direction == cd.GuidePos.GO_CENTER then
    return 0
  end
  return 0
end

return NewbieGuideView
