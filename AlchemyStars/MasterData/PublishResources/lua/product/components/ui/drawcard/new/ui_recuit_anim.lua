_class("UIRecruitAnim", Object)
UIRecruitAnim = UIRecruitAnim
local Params = {
  DragBgMove = 3,
  DragSnapDuration = 100,
  DragLayer1Move = 0.3,
  DragLayer2Move = 1,
  DragLayer3Move = 0.3,
  DragLayer1Alpha = 0.0033333333333333335,
  DragLayer2Alpha = 0.005,
  DragLayer3Alpha = 0.005,
  SwitchViewpotRate = 0.3,
  DragClampScaleRate = 0.4,
  DragClampMaxScale = 1.06,
  DragClampSnapDuration = 350,
  DragClampMinAlpha = 0.3,
  LongPressTime = 100,
  LongPressScaleTime = 800,
  LongPressMaxScaleLayer1 = 1,
  LongPressMaxScaleLayer1_l1 = 1.02,
  LongPressMaxScaleLayer1_l2 = 1.06,
  LongPressMaxScaleLayer1_l3 = 1.04,
  LongPressMaxScaleLayer2 = 1,
  LongPressMaxScaleLayer3 = 1.0,
  LongPressSnapDuration = 100
}

function UIRecruitAnim:Constructor(ui)
  self._ui = ui
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._eft = self._ui:GetGameObject("Effect")
  self._eftBgRoot = self._ui:GetUIComponent("RectTransform", "BGRoot")
  local safeArea = self._ui:GetUIComponent("RectTransform", "SafeArea")
  self._height = safeArea.rect.height
  self._bgRect = self._ui:GetUIComponent("RectTransform", "EftBG")
  self._bgImage = self._ui:GetUIComponent("Image", "EftBG")
  self._layer1Rect = self._ui:GetUIComponent("RectTransform", "Layer1")
  self._layer1_l1 = self._ui:GetUIComponent("RectTransform", "pool_l1")
  self._layer1_l2 = self._ui:GetUIComponent("RectTransform", "pool_l2")
  self._layer1_l3 = self._ui:GetUIComponent("RectTransform", "pool_l3")
  self._layer2Rect = self._ui:GetUIComponent("RectTransform", "Layer2")
  self._layer3Rect = self._ui:GetUIComponent("RectTransform", "Layer3")
  self._layer1CanvasGroup = self._ui:GetUIComponent("CanvasGroup", "Layer1")
  self._layer2CanvasGroup = self._ui:GetUIComponent("CanvasGroup", "Layer2")
  self._layer3CanvasGroup = self._ui:GetUIComponent("CanvasGroup", "Layer3")
  self._flashAnim = self._ui:GetUIComponent("Animation", "Effect")
  self._rootAnim = self._ui:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._flashAnims = {
    "uieff_Recruit_SwitchPool_1",
    "uieff_Recruit_SwitchPool_2",
    "uieff_Recruit_SwitchPool_3",
    "uieff_Recruit_SwitchPool_4"
  }
  self._clampTL = EZTL_Sequence:New({
    EZTL_Parallel:New({
      EZTL_LocalScale:New(self._layer1Rect, 1, Params.DragClampSnapDuration, "边缘回弹缩放"),
      EZTL_CanvasGroupAlpha:New(self._layer2CanvasGroup, 1, Params.DragClampSnapDuration, "二层边缘回弹透明度"),
      EZTL_CanvasGroupAlpha:New(self._layer3CanvasGroup, 1, Params.DragClampSnapDuration, "三层边缘回弹透明度")
    }, EZTL_EndTag.All, "边缘回弹并行动画"),
    EZTL_Callback:New(function()
      self:_SnapEnd()
    end)
  }, "边缘回弹动画")
  self._scaleSnapTl = EZTL_Parallel:New({
    EZTL_LocalScale:New(self._layer1_l1, 1, Params.LongPressSnapDuration, "一层长按回弹位移"),
    EZTL_LocalScale:New(self._layer1_l2, 1, Params.LongPressSnapDuration, "二层长按回弹位移"),
    EZTL_LocalScale:New(self._layer1_l3, 1, Params.LongPressSnapDuration, "三层长按回弹位移")
  }, EZTL_EndTag.All, "长按回弹并行动画")
  self._longPressSnapTl = EZTL_Sequence:New({
    self._scaleSnapTl,
    EZTL_Callback:New(function()
      self:_LongPressSnapEnd()
    end, "长按回弹结束回调")
  })
  self._dragSnapTL = EZTL_Sequence:New({
    EZTL_Parallel:New({
      self._scaleSnapTl,
      EZTL_AnchorMove:New(self._bgRect, Vector2(0, -self._height * 0.5), Params.DragSnapDuration, "背景回弹位移"),
      EZTL_AnchorMove:New(self._layer1Rect, Vector2.zero, Params.DragSnapDuration, "一层回弹位移"),
      EZTL_AnchorMove:New(self._layer2Rect, Vector2.zero, Params.DragSnapDuration, "二层回弹位移"),
      EZTL_AnchorMove:New(self._layer3Rect, Vector2.zero, Params.DragSnapDuration, "三层回弹位移"),
      EZTL_CanvasGroupAlpha:New(self._layer1CanvasGroup, 1, Params.DragSnapDuration, "一层回弹透明度"),
      EZTL_CanvasGroupAlpha:New(self._layer2CanvasGroup, 1, Params.DragSnapDuration, "二层回弹透明度"),
      EZTL_CanvasGroupAlpha:New(self._layer3CanvasGroup, 1, Params.DragSnapDuration, "三层回弹透明度")
    }, EZTL_EndTag.All, "回弹并行动画"),
    EZTL_Callback:New(function()
      self:_SnapEnd()
    end, "回弹结束回调")
  })
  self._tl = nil
end

function UIRecruitAnim:Update(dtMS)
  if self._tl then
    self._tl:Update(dtMS)
    if self._tl:Over() then
      self._tl = nil
    else
    end
  end
end

function UIRecruitAnim:Dispose()
  if self._tl and not self._tl:Over() then
    self._tl:Stop()
    self._tl = nil
  end
end

function UIRecruitAnim:_OnLongPressBegin()
  self._longPressBeginTime = self._timeModule:GetServerTime()
end

function UIRecruitAnim:_OnLongPress()
  local dtMS = self._timeModule:GetServerTime() - self._longPressBeginTime
  local t = Mathf.Clamp01(dtMS / Params.LongPressScaleTime)
  self._layer1_l1.localScale = Vector3.one * self:_OutCubic(1, Params.LongPressMaxScaleLayer1_l1, t)
  self._layer1_l2.localScale = Vector3.one * self:_OutCubic(1, Params.LongPressMaxScaleLayer1_l2, t)
  self._layer1_l3.localScale = Vector3.one * self:_OutCubic(1, Params.LongPressMaxScaleLayer1_l3, t)
end

function UIRecruitAnim:_OnLongPressEnd()
  self._longPressBeginTime = nil
  if not self._gesture:IsDragging() and self._gesture:IsLongPressing() then
    self:_LongPressSnapStart()
  end
end

function UIRecruitAnim:_OnDragBegin()
  self._dragging = true
  self._dragDown = false
  self._dragUp = false
  self._dragClamp = false
end

function UIRecruitAnim:_OnDrag(event)
  if not self._gesture:IsDragging() then
    return
  end
  local delta = event.position - event.pressPosition
  if delta.y < 0 then
    if self._ui:IsTheFirst() then
      self:_OnClampDrag(delta.y)
      return
    end
    if not self._down then
      self._dragDown = true
      self._dragUp = false
      self._dragClamp = false
      self:_ResetBg(true)
    end
  elseif delta.y > 0 then
    if self._ui:IsTheLast() then
      self:_OnClampDrag(delta.y)
      return
    end
    if not self._dragUp then
      self._dragUp = true
      self._dragDown = false
      self._dragClamp = false
      self:_ResetBg(false)
    end
  end
  local distance = math.abs(delta.y)
  local bgMoveDistance = distance * Params.DragBgMove
  self._layer1Rect.anchoredPosition = Vector2(0, delta.y * Params.DragLayer1Move)
  self._layer2Rect.anchoredPosition = Vector2(0, delta.y * Params.DragLayer2Move)
  self._layer3Rect.anchoredPosition = Vector2(0, delta.y * Params.DragLayer3Move)
  self._layer1CanvasGroup.alpha = Mathf.Clamp01(1 - distance * Params.DragLayer1Alpha)
  self._layer2CanvasGroup.alpha = Mathf.Clamp01(1 - distance * Params.DragLayer2Alpha)
  self._layer3CanvasGroup.alpha = Mathf.Clamp01(1 - distance * Params.DragLayer3Alpha)
  if bgMoveDistance / self._height > Params.SwitchViewpotRate then
    local cur = self._ui:CurrentIdx()
    local idx
    if self._dragDown then
      idx = cur - 1
    elseif self._dragUp then
      idx = cur + 1
    end
    if idx then
      self:_SwitchStart(cur, idx)
    end
  end
end

function UIRecruitAnim:_OnDragEnd()
  if self._gesture:IsDragging() then
    self._dragDown = false
    self._dragUp = false
    self:_SnapStart()
    self._dragClamp = false
  end
end

function UIRecruitAnim:_OnRelease()
end

function UIRecruitAnim:_SnapStart()
  if self._dragClamp then
    self:_LongPressSnapStart()
  else
    self._ui:Lock("UIRecruitAnim_DragSnap")
    self._tl = self._dragSnapTL
    self._tl:Start()
  end
end

function UIRecruitAnim:_SnapEnd()
  self._ui:UnLock("UIRecruitAnim_DragSnap")
end

function UIRecruitAnim:_OnClampDrag(delta)
  if not self._dragClamp then
    self._dragClamp = true
    self._dragDown = false
    self._dragUp = false
    self._bgRect.anchoredPosition = Vector2(0, -self._height * 0.5)
    self._layer1Rect.anchoredPosition = Vector2.zero
    self._layer2Rect.anchoredPosition = Vector2.zero
    self._layer3Rect.anchoredPosition = Vector2.zero
    self._layer1CanvasGroup.alpha = 1
    self._layer2CanvasGroup.alpha = 1
    self._layer3CanvasGroup.alpha = 1
  end
end

function UIRecruitAnim:_OutCubic(from, to, value)
  value = value - 1
  local delta = to - from
  return delta * (value ^ 3 + 1) + from
end

function UIRecruitAnim:_SwitchStart(from, to)
  local isDown = to < self._ui:CurrentIdx()
  local count = self._ui:GetPoolPetCount(to)
  if not count or count == 0 then
    count = 1
  end
  local fadeInAnim
  if isDown then
    fadeInAnim = "uieff_Recruit_switchpool_up_in"
  else
    fadeInAnim = "uieff_Recruit_in"
  end
  
  local function cb_playthumbfadeout()
    self._ui:PlayThumbItemFadeoutAnim(from)
  end
  
  local function cb_refreshpanel()
    self:_ResetLayers()
    self._ui:SwitchToPool(to)
  end
  
  local function cb_playfadeinanim()
    if self._rootAnim:IsPlaying(fadeInAnim) then
      self._rootAnim:Stop(fadeInAnim)
    end
    self._rootAnim:Play(fadeInAnim)
  end
  
  local function cb_playthumbfadein()
    self._ui:PlayThumbItemFadeinAnim(to)
  end
  
  self._tl = EZTL_Sequence:New({
    EZTL_Parallel:New({
      EZTL_Callback:New(cb_playthumbfadeout, "缩略图淡出"),
      EZTL_Sequence:New({
        EZTL_Wait:New(70, "延迟70毫秒"),
        EZTL_PlayAnimation:New(self._flashAnim, self._flashAnims[count], "切换Aniamtion动画")
      }, "延迟播放切换动效"),
      EZTL_Sequence:New({
        EZTL_Callback:New(cb_refreshpanel, "刷新卡池界面")
      }, "延迟刷新卡池"),
      EZTL_Sequence:New({
        EZTL_Callback:New(cb_playfadeinanim, "播淡入动画")
      }, "延迟播放淡入动画"),
      EZTL_Sequence:New({
        EZTL_Wait:New(70, "延迟 90 毫秒"),
        EZTL_Callback:New(cb_playthumbfadein, "缩略图淡入")
      }, "延迟播放淡入动画"),
      EZTL_Wait:New(200, "延迟1100ms")
    }, EZTL_EndTag.SomeOne, 6, "切换动画并行"),
    EZTL_Callback:New(function()
      self:_SwitchEnd()
    end, "切换动画结束回调")
  }, "切换动画总时间线")
  self._ui:Lock("UIRecruitAnim_Switch")
  self._ui:SetPoolPetLogo(to)
  self._tl:Start()
end

function UIRecruitAnim:_SwitchEnd()
  self._ui:UnLock("UIRecruitAnim_Switch")
  self:_ResetLayers()
end

function UIRecruitAnim:_ResetLayers()
  self._layer1Rect.anchoredPosition = Vector2.zero
  self._layer2Rect.anchoredPosition = Vector2.zero
  self._layer3Rect.anchoredPosition = Vector2.zero
  self._layer1_l1.localScale = Vector3.one
  self._layer1_l2.localScale = Vector3.one
  self._layer1_l3.localScale = Vector3.one
  self._layer1CanvasGroup.alpha = 1
  self._layer2CanvasGroup.alpha = 1
  self._layer3CanvasGroup.alpha = 1
end

function UIRecruitAnim:_ResetBg(isDown)
  if isDown then
    self._bgImage.color = Color(0.1607843137254902, 0.23137254901960785, 0.4666666666666667)
    self._eftBgRoot.localEulerAngles = Vector3(180, 0, 0)
    self._bgRect.anchoredPosition = Vector2(0, -self._height * 0.5)
  else
    self._bgImage.color = Color(1, 0.403921568627451, 0)
    self._eftBgRoot.localEulerAngles = Vector3.zero
    self._bgRect.anchoredPosition = Vector2(0, -self._height * 0.5)
  end
end

function UIRecruitAnim:_LongPressSnapStart()
  self._ui:Lock("UIRecruitAnim_LongPressSnap")
  self._tl = self._longPressSnapTl
  self._tl:Start()
end

function UIRecruitAnim:_LongPressSnapEnd()
  self._ui:UnLock("UIRecruitAnim_LongPressSnap")
end

function UIRecruitAnim:SwitchTo(from, to)
  if to > self._ui:CurrentIdx() then
    self:_ResetBg(false)
  else
    self:_ResetBg(true)
  end
  self:_SwitchStart(from, to)
end
