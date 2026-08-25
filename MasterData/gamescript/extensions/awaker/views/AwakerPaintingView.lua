local OrientaionChangedDuration = 0.5
local DOTween = CS.DG.Tweening.DOTween
local Input = CS.UnityEngine.Input
local T_DragGesture = typeof(CS.Z1Client.General.DragGesture)
local AwakerPaintingView, Super = NewClass("AwakerPaintingView", BaseView)
AwakerPaintingView.uiResCls = UI_Awaker_Popup_Whole_BodyResource
local TransformUtil = CS.Framework.TransformUtil

function AwakerPaintingView:ctor(awakerTid, shopData, previewSkin, isMyAwaker)
  Super.ctor(self)
  self.awakerTid = awakerTid
  self.isMyAwaker = isMyAwaker
  self.hideUI = false
  self.contentTf = nil
  self.contentPosX, self.contentPosY = nil, nil
  self.oriContentPosX, self.oriContentPosY = nil, nil
  self.moveX, self.moveY = 0, 0
  self.minScale = 0.4
  self.maxScale = 1.6
  self._curScale = 1
  self.scaleRange = self.maxScale - self.minScale
  self.mouseDragging = false
  self.isTouchingUI = false
  self.previewSkin = previewSkin
  self.skinTid = self.previewSkin or AwakerSkinUtils.GetAwakerDressedSkin(self.awakerTid) or CommonDefine.DefaultSkinTid
  self.shopData = shopData
  self.shopItemTid = shopData and shopData.tid
  self:_SetAwakerAndSkin()
end

function AwakerPaintingView:OnBuildView()
  self:AddViewComponentOnce(self.ui.uiNode, AwakerSkinView, self.awakerTid, self.shopData, self.previewSkin, self.isMyAwaker)
  self.compBtnClosed = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    if not self.clickClose then
      self:Close()
    end
  end)
  self:_InitContentParams()
  CS.UnityEngine.Input.multiTouchEnabled = true
end

function AwakerPaintingView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAwakerSkinClick, System.fn(self, self._OnSkinClicked))
  self:RegisterNotify(NotifyId.OnInputDeviceOrientationChanged, System.fn(self, self._OnInputDeviceOrientationChanged))
  self:RegisterNotify(NotifyId.OnScreenOrientationChanged, System.fn(self, self._OnScreenOrientationChanged))
end

function AwakerPaintingView:_OnScreenOrientationChanged()
  self:_OnPaintingHorizontal()
end

function AwakerPaintingView:_OnInputDeviceOrientationChanged()
  if CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeRight and CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.LandscapeRight or CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeLeft and CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.LandscapeLeft then
    self:_OnPaintingHorizontal(true)
  elseif CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.Portrait then
    self:_OnPaintingVertical()
  end
end

function AwakerPaintingView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Check, System.fn(self, self._OnClickHideUI))
  self:AddButtonClickListener(self.ui.Btn_Reset, System.fn(self, self._ResetContentPos))
  self:AddUICustomInputlistener(self.ui.uiNode, System.fn(self, self._OnRootCustomInput))
  self:_RegisterAwakerDragGesture()
  self:_RegisterBlockDrag()
  self:AddSliderListener(self.ui.Slider_Telescopic, function(sliderValue)
    local scale = self.minScale + self.scaleRange * sliderValue
    self._curScale = scale
    TransformUtil.SetLocalScale(self.contentTf, self._curScale, self._curScale, self._curScale)
  end)
  self:SetSliderValue(self.ui.Slider_Telescopic, 0.5)
end

function AwakerPaintingView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshAwakerInfo()
  self:_RefreshPortraitComp(self.skinTid)
  LateUpdateBeat.Instance:Add(self.Update, self)
end

function AwakerPaintingView:OnExitView()
  Super.OnExitView(self)
end

function AwakerPaintingView:_OnSkinClicked(skinTid)
  if self.skinTid == skinTid then
    return
  end
  self.skinTid = skinTid
  self:_RefreshPortraitComp(skinTid)
end

function AwakerPaintingView:_RegisterBlockDrag()
  self.blockDragUIList = {
    self.ui.Slider_Telescopic
  }
  for _, go in ipairs(self.blockDragUIList) do
    local gesture = go:GetComponent(T_DragGesture)
    gesture:onPointerDown("+", System.fn(self, self._OnPointerDownUI))
    gesture:onPointerUp("+", System.fn(self, self._OnPointerUpUI))
  end
end

function AwakerPaintingView:_UnRegisterBlockDrag()
  self.blockDragUIList = {
    self.ui.Slider_Telescopic
  }
  for _, go in ipairs(self.blockDragUIList) do
    local gesture = go:GetComponent(T_DragGesture)
    gesture:onPointerDown("-", System.fn(self, self._OnPointerDownUI))
    gesture:onPointerUp("-", System.fn(self, self._OnPointerUpUI))
  end
end

function AwakerPaintingView:_RegisterAwakerDragGesture()
  local awakerDragGesture = self.ui.Content_Scale:GetComponent(T_DragGesture)
  awakerDragGesture:onBeginDrag("+", System.fn(self, self._OnBeginDrag))
  awakerDragGesture:onDrag("+", System.fn(self, self._OnDrag))
  awakerDragGesture:onEndDrag("+", System.fn(self, self._OnEndDrag))
end

function AwakerPaintingView:_UnRegisterAwakerDragGesture()
  local awakerDragGesture = self.ui.Content_Scale:GetComponent(T_DragGesture)
  awakerDragGesture:onBeginDrag("-", System.fn(self, self._OnBeginDrag))
  awakerDragGesture:onDrag("-", System.fn(self, self._OnDrag))
  awakerDragGesture:onEndDrag("-", System.fn(self, self._OnEndDrag))
end

function AwakerPaintingView:_SetAwakerAndSkin()
  if self.shopItemTid then
    self.skinTid = AwakerSkinUtils.GetSkinByShopItem(self.shopItemTid)
    local skinCfg = AwakerSkinUtils.GetSkinConfig(self.skinTid)
    self.awakerTid = skinCfg.OwnerAwaker
    return
  end
  if self.previewSkin then
    self.skinTid = self.previewSkin
    self.awakerTid = AwakerSkinUtils.GetAwakerTidBySkin(self.skinTid)
    return
  end
  if self.awakerTid then
    local isOwnAwaker = AwakerDataUtils.HasOwnedAwaker(self.awakerTid)
    if not isOwnAwaker then
      local awakerSkinList = AwakerSkinUtils.GetAwakerSkinList(self.awakerTid)
      if #awakerSkinList > 0 then
        self.skinTid = awakerSkinList[1]
      end
    else
      self.skinTid = AwakerSkinUtils.GetAwakerDressedSkin(self.awakerTid) or CommonDefine.DefaultSkinTid
    end
  end
end

function AwakerPaintingView:_RefreshAwakerInfo()
  local awakerName = AwakerDataUtils.GetAwakerName(self.awakerTid)
  self:SetText(self.ui.Text_Awaker_Name, awakerName)
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(self.awakerTid)
  local schoolIcon = AwakerDataUtils.GetSchoolIcon(awakerConfig.School)
  self:SetImage(self.ui.Image_Awaker_Career_Icon, schoolIcon)
end

function AwakerPaintingView:_RefreshPortraitComp(skinTid)
  local portraitComp = self:AddViewComponentOnce(self.ui.Container_Awaker, UICompAwakerPortrait, {
    awakerTid = self.awakerTid,
    portraitNo = skinTid and AwakerSkinUtils.GetSkinResNum(skinTid),
    portraitAlign = CommonDefine.PortraitAlign.Center,
    portraitType = CommonDefine.PortraitType.Full
  })
  portraitComp:DisableAlphaTexture()
  local scaler = AddLuaCompOnce(self.ui.Content_Scale, UIDoubleFingersScaler)
  scaler:SetScaleLimit(self.minScale, self.maxScale)
  scaler:SetUpdateCallback(System.fn(self, self._OnUpdateScale))
  self:_ResetContentPos()
end

function AwakerPaintingView:_RefreshUIShow(show)
  self.ui.UI_Common_Btn_Back3:SetActive(show)
  self.ui.Btn_Check:SetActive(show)
  self.ui.Text_Awaker_Name:SetActive(show)
  self.ui.Slider_Telescopic:SetActive(show)
  self.ui.Btn_Reset:SetActive(show)
  self.ui.Group_DressInfo:SetActive(show)
  EventMgr.Instance.ShowUserInfoText:Dispatch(show)
end

function AwakerPaintingView:_OnUpdateScale(scale)
  local sliderValue = (scale - self.minScale) / self.scaleRange
  self:SetSliderValue(self.ui.Slider_Telescopic, sliderValue)
end

function AwakerPaintingView:_OnClickHideUI()
  self.hideUI = true
  self:_RefreshUIShow(false)
end

function AwakerPaintingView:_OnClickShowUI()
  self:_OnPaintingHorizontal()
  self.hideUI = false
  self:_RefreshUIShow(true)
end

function AwakerPaintingView:_OnRootCustomInput(hover)
  if hover and self.hideUI then
    self:_OnClickShowUI()
  end
end

function AwakerPaintingView:_ResetContentPos()
  self.contentPosX = self.oriContentPosX
  self.contentPosY = self.oriContentPosY
  TransformUtil.SetAnchoredPos(self.contentTf, self.oriContentPosX, self.oriContentPosY)
  self._curScale = 1
  TransformUtil.SetLocalScale(self.contentTf, self._curScale, self._curScale, self._curScale)
  self:_OnUpdateScale(self._curScale)
end

function AwakerPaintingView:_OnBeginDrag(pointerData)
  local position = pointerData.position
  self.oldTouchPosX = position.x
  self.oldTouchPosY = position.y
end

function AwakerPaintingView:_OnDrag(pointerData)
  if self.isTouchingUI then
    return
  end
  if not self.oldTouchPosX or not self.oldTouchPosY then
    return
  end
  if 0 ~= self.moveX or 0 ~= self.moveY then
    self.contentPosX = self.contentPosX + self.moveX
    self.contentPosY = self.contentPosY + self.moveY
    TransformUtil.SetAnchoredPos(self.contentTf, self.contentPosX, self.contentPosY)
    self.moveX = 0
    self.moveY = 0
  end
  local curPos = pointerData.position
  local curX, curY = curPos.x, curPos.y
  self.moveX = curX - self.oldTouchPosX
  self.moveY = curY - self.oldTouchPosY
  self.oldTouchPosX = curX
  self.oldTouchPosY = curY
end

function AwakerPaintingView:_OnEndDrag()
  self.oldTouchPosX = nil
  self.oldTouchPosY = nil
end

function AwakerPaintingView:_OnPointerDownUI()
  self.isTouchingUI = true
  self.mouseDragging = false
  self.oldTouchPosX = nil
  self.oldTouchPosY = nil
  self.moveX = 0
  self.moveY = 0
  Logger.Debug("[touch] _OnPointerDownUI self.isTouchingUI=%s", self.isTouchingUI)
end

function AwakerPaintingView:_OnPointerUpUI()
  self.isTouchingUI = false
  Logger.Debug("[touch] _OnPointerDownUI self.isTouchingUI=%s", self.isTouchingUI)
end

function AwakerPaintingView:_InitContentParams()
  self.contentTf = self.ui.Content_Scale.transform
  self.contentPosX, self.contentPosY = TransformUtil.GetAnchoredPos(self.contentTf)
  self.oriContentPosX, self.oriContentPosY = self.contentPosX, self.contentPosY
end

function AwakerPaintingView:Update()
  if Input.touchCount >= 2 then
    self.moveX = 0
    self.moveY = 0
    self.oldTouchPosX = nil
    self.oldTouchPosY = nil
  end
end

function AwakerPaintingView:_OnPaintingVertical()
  if not self.hideUI then
    return
  end
  DOTween.To(function()
    return 0
  end, function(newV)
    TransformUtil.SetRotation(self.contentTf, 0, 0, newV)
  end, self:_GetRotation(), OrientaionChangedDuration, self)
  TransformUtil.SetAnchoredPos(self.contentTf, 0, 0)
  TransformUtil.SetLocalScale(self.contentTf, 1, 1, 1)
end

function AwakerPaintingView:_OnPaintingHorizontal(withAnim)
  if not self.hideUI then
    return
  end
  if withAnim then
    DOTween.To(function()
      do return self._GetRotation end
      return self._GetRotation, self
    end, function(newV)
      TransformUtil.SetRotation(self.contentTf, 0, 0, newV)
    end, 0, OrientaionChangedDuration, self)
  else
    TransformUtil.SetRotation(self.contentTf, 0, 0, 0)
  end
  TransformUtil.SetAnchoredPos(self.contentTf, self.contentPosX, self.contentPosY)
  TransformUtil.SetLocalScale(self.contentTf, self._curScale, self._curScale, self._curScale)
end

function AwakerPaintingView:_GetRotation()
  local rotation = 90
  if CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeRight then
    rotation = -rotation
  end
  return rotation
end

function AwakerPaintingView:Close()
  self.clickClose = true
  self.compBtnClosed:PlayCloseAnim()
  CS.UnityEngine.Input.multiTouchEnabled = false
  LateUpdateBeat.Instance:Remove(self.Update, self)
  EventMgr.Instance.ShowUserInfoText:Dispatch(true)
  self:_ResetContentPos()
  self:_UnRegisterAwakerDragGesture()
  self:_UnRegisterBlockDrag()
  self.ui.Group_DressInfo:SetActive(false)
  Super.Close(self)
end

return AwakerPaintingView
