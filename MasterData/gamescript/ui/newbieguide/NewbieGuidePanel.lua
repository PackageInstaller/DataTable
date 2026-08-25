local Quaternion = CS.UnityEngine.Quaternion
local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local Vector4 = CS.UnityEngine.Vector4
local CSImage = typeof(CS.UnityEngine.UI.Image)
local ShaderPropertyToID = CS.UnityEngine.Shader.PropertyToID
local CutoutRectId = ShaderPropertyToID("_CutoutRect")
local _SetLocalScale = CS.Framework.TransformUtil.SetLocalScale
local NewbieGuidePanel, Super = System.NewClass("NewbieGuidePanel", UIBasePanel)
NewbieGuidePanel.uiResCls = UI_Guide_NewbieGuideResource

function NewbieGuidePanel:ctor(guideTid, guideIndex, guideCfg, closeCb)
  Super.ctor(self)
  self.guideTid = guideTid
  self.guideIndex = guideIndex
  self.guideCfg = guideCfg
  self.closeCb = closeCb
end

local DefaultPos = {x = 50, y = -394}

function NewbieGuidePanel:OnBind(binder)
  self.binder = binder
  self:InitMaskMaterial()
  self:BindContent()
  self:BindDirection()
  self:BindEvents()
  self:PlayHandAnim()
  self:FocusNodeRect()
  self.binder:BindTimer(0.03, -1, System.fn(self, self.FocusNodeRect))
  self:BindGuideOffset()
  self:CancelGlobalClickMask()
end

function NewbieGuidePanel:InitMaskMaterial()
  local image = self.ui.Gropu_Mask:GetComponent(CSImage)
  self._maskMaterial = image.material
  self._maskTransform = self.ui.Gropu_Mask.transform
  self._vec4 = Vector4(0, 0, 0, 0)
  self._vec2 = Vector2(0, 0)
end

function NewbieGuidePanel:CancelGlobalClickMask()
  EventMgr.Instance.CloseClickMask:Dispatch("NewbieGuidePanel")
end

function NewbieGuidePanel:IsNeedFobidClick()
  local notForbidClickList = {81502}
  if table.contains(notForbidClickList, self.guideTid) then
    return false
  end
  return true
end

function NewbieGuidePanel:OnUnbind()
  Super.OnUnbind(self)
  self._maskMaterial = nil
  self._maskTransform = nil
  self._vec4 = nil
  self._vec2 = nil
  if self:IsNeedFobidClick() then
    EventMgr.Instance.OpenClickMask:Dispatch("NewbieGuidePanel", 1.5)
  end
  if self.closeCb then
    self.closeCb()
  end
end

function NewbieGuidePanel:BindEvents()
  self.binder:BindButtonClick(self.ui.ClickMask1, System.fn(self, self.OnTouchMask))
  self.binder:BindButtonClick(self.ui.ClickMask2, System.fn(self, self.OnTouchMask))
  self.binder:BindButtonClick(self.ui.ClickMask3, System.fn(self, self.OnTouchMask))
  self.binder:BindButtonClick(self.ui.ClickMask4, System.fn(self, self.OnTouchMask))
  self.binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnTouchBegin))
  self.binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self.OnTouchEnd))
end

function NewbieGuidePanel:BindContent()
  if self.guideCfg.Content then
    self.binder:SetActive(self.ui.Group_Desc, true)
    self.binder:SetText(self.ui.Text_Desc, self.guideCfg.Content)
  else
    self.binder:SetActive(self.ui.Group_Desc, false)
  end
end

function NewbieGuidePanel:FocusNodeRect()
  self.binder:SetActive(self.ui.Gropu_Mask, self:IsForceGuide())
  self.binder:SetActive(self.ui.Group_Frame, false)
  self.binder:SetActive(self.ui.UI_Guide_Popup_FuncGuide, false)
  self.binder:SetActive(self.ui.Group_ClickMask, self:IsForceGuide())
  if self:GetNodeName() then
    local nodeRect = GuideUtils.GetRectCommon(self:GetNodeName())
    if nodeRect then
      self.ui.UI_Guide_Popup_FuncGuide.transform.position = nodeRect.centerPos
      self.binder:SetActive(self.ui.UI_Guide_Popup_FuncGuide, true)
      if self:IsForceGuide() then
        self:SetFocusRect(nodeRect)
      end
    end
  end
end

function NewbieGuidePanel:BindGuideOffset()
  local descOffset = self.guideCfg.ContentOffset or {}
  self.ui.Group_Desc.transform.localPosition = Vector3(DefaultPos.x + (descOffset[1] or 0), DefaultPos.y + (descOffset[2] or 0), 0)
  local descHeight = StrUtils.SetPreferredHeight(self.ui.Text_Desc, 30)
  self.ui.Image_Desc_Bg.transform.sizeDelta = CS.UnityEngine.Vector2(1500, descHeight)
end

function NewbieGuidePanel:BindDirection()
  if self:GetGuideDirection() then
    local rota = self:TransHandRotation(self:GetGuideDirection())
    self.ui.UI_Guide_Popup_FuncGuide.transform.localRotation = Quaternion.Euler(0, 0, rota)
  end
end

function NewbieGuidePanel:GetGuideDirection()
  return self.guideCfg.GuideDirection
end

function NewbieGuidePanel:GetNodeName()
  return self.guideCfg.NodeName
end

function NewbieGuidePanel:IsForceGuide()
  return self.guideCfg.IsForcible == cd.NumberTrue
end

function NewbieGuidePanel:PlayHandAnim()
  if not self.animCtr then
    self.animCtr = self.ui.UI_Guide_Popup_FuncGuide:GetComponent(typeof(UIAnimationController))
  end
  if self:IsForceGuide() then
    self.animCtr:LoopPlayState("UI_Guide_Popup_FuncGuide_Intensity")
  else
    self.animCtr:LoopPlayState("UI_Guide_Popup_FuncGuide_Weak")
  end
end

function NewbieGuidePanel:OnTouchBegin(eventValue)
  if not GuidePanelUtils.IsViewAtTop(self.url) then
    self._checkTouchEnd = false
    return
  end
  self._checkTouchEnd = true
end

function NewbieGuidePanel:OnTouchEnd(eventValue)
  EventMgr.Instance.NewbieGuideClick:Dispatch()
  if not self._isClickedMask and self._checkTouchEnd and self:IsForceGuide() then
    EventMgr.Instance.NewbieGuidePass:Dispatch(self.guideTid, self.guideIndex)
  end
  self._isClickedMask = nil
end

function NewbieGuidePanel:OnTouchMask(eventValue)
  EventMgr.Instance.NewbieGuideClick:Dispatch()
  self.animCtr:StopPlayableGraph()
  self:PlayHandAnim()
  self._isClickedMask = true
end

function NewbieGuidePanel:SetFocusRect(focusRect)
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

function NewbieGuidePanel:TransHandRotation(direction)
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

return NewbieGuidePanel
