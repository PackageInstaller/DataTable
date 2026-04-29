_class("UIGuideCircleModelController", UIController)
UIGuideCircleModelController = UIGuideCircleModelController

function UIGuideCircleModelController:Constructor()
end

function UIGuideCircleModelController:OnShow(uiParams)
  GuideHelper.GuideLoadLock(false, "Circle")
  self.canClick = false
  self.backs = {}
  for i = 1, 4 do
    local back = self:GetUIComponent("RectTransform", "Back" .. i)
    self.backs[i] = back
  end
  self.circle = self:GetUIComponent("RectTransform", "circle")
  self.animation = self:GetUIComponent("Animation", "animation")
  self.ltTitleTxt = self:GetUIComponent("UILocalizationText", "lttitle")
  self.rtTitleTxt = self:GetUIComponent("UILocalizationText", "rttitle")
  self.ldTitleTxt = self:GetUIComponent("UILocalizationText", "ldtitle")
  self.rdTitleTxt = self:GetUIComponent("UILocalizationText", "rdtitle")
  self.ltDescTxt = self:GetUIComponent("UILocalizationText", "ltdesc")
  self.rtDescTxt = self:GetUIComponent("UILocalizationText", "rtdesc")
  self.ldDescTxt = self:GetUIComponent("UILocalizationText", "lddesc")
  self.rdDescTxt = self:GetUIComponent("UILocalizationText", "rddesc")
  self.ltGO = self:GetGameObject("lt")
  self.ltGO:SetActive(false)
  self.rtGO = self:GetGameObject("rt")
  self.rtGO:SetActive(false)
  self.ldGO = self:GetGameObject("ld")
  self.ldGO:SetActive(false)
  self.rdGO = self:GetGameObject("rd")
  self.rdGO:SetActive(false)
  self.ltAllGO = self:GetGameObject("ltall")
  self.ltAllGO:SetActive(false)
  self.rtAllGO = self:GetGameObject("rtall")
  self.rtAllGO:SetActive(false)
  self.ldAllGO = self:GetGameObject("ldall")
  self.ldAllGO:SetActive(false)
  self.rdAllGO = self:GetGameObject("rdall")
  self.rdAllGO:SetActive(false)
  self.continueGO = self:GetGameObject("continue")
  self.maskGO = self:GetGameObject("mask")
  self.maskGO:SetActive(true)
  self.maskRect = self:GetUIComponent("RectTransform", "mask")
  self.continueGO:SetActive(false)
  self._l_t_txt = self:GetUIComponent("RectTransform", "ltdesc")
  self._l_d_txt = self:GetUIComponent("RectTransform", "lddesc")
  self._r_t_txt = self:GetUIComponent("RectTransform", "rtdesc")
  self._r_d_txt = self:GetUIComponent("RectTransform", "rddesc")
  self.p_black = self:GetGameObject("p_black")
  self.p_black_mask = self:GetUIComponent("RectTransform", "p_black_mask")
  self.p_black_masked = self:GetUIComponent("Image", "p_black_masked")
  self.data = uiParams[1]
  self.target = uiParams[2]
  local onShowEnd = uiParams[3]
  self:SetCirclePos()
  self.animation:Play("UIeff_Guide_baha_2")
  self:RefreshShow()
  self._isShow = true
  self:StartTask(function(TT)
    YIELD(TT, 1000)
    if not self._isShow then
      return
    end
    self:RefreshTxt()
    self.animation:Play("UIeff_Guide_baha_1")
    YIELD(TT, 800)
    if not self._isShow then
      return
    end
    self.continueGO:SetActive(true)
    self.canClick = true
  end)
  if onShowEnd then
    onShowEnd()
  end
  self:AttachEvent(GameEventType.UIBlackChange, self.SetCirclePos)
end

function UIGuideCircleModelController:SetCirclePos()
  local pos = self:ConvertScreentPos(self.target)
  local gaps_x = 200
  local leftRight = 50
  local min = 350
  local max = 700
  local black = self:GetBlackWidth()
  local right_less_x = ResolutionManager.RealWidth() - pos.x - gaps_x - leftRight - black
  if min > right_less_x then
  elseif max < right_less_x then
    right_less_x = max
  end
  local left_less_x = pos.x - gaps_x - leftRight - black
  if min > left_less_x then
  elseif max < left_less_x then
    left_less_x = max
  end
  self._l_t_txt.sizeDelta = Vector2(left_less_x, self._l_t_txt.sizeDelta.y)
  self._l_d_txt.sizeDelta = Vector2(left_less_x, self._l_d_txt.sizeDelta.y)
  self._r_t_txt.sizeDelta = Vector2(right_less_x, self._r_t_txt.sizeDelta.y)
  self._r_d_txt.sizeDelta = Vector2(right_less_x, self._r_d_txt.sizeDelta.y)
  self._l_x = left_less_x
  self._r_x = right_less_x
  self.p_black_mask.anchoredPosition = Vector2(pos.x - self.maskRect.sizeDelta.x * 0.56, pos.y - self.maskRect.sizeDelta.y * 0.56)
  self.p_black_mask.sizeDelta = self.maskRect.sizeDelta
  self.circle.anchoredPosition = pos
  self.maskRect.anchoredPosition = pos
end

function UIGuideCircleModelController:GetBlackWidth()
  local bangWidth = ResolutionManager.BangWidth()
  local configBangWidth = math.ceil(ResolutionManager.ConfigBangWidth())
  if configBangWidth <= 0 then
    configBangWidth = 100
  end
  local r_w = ResolutionManager.RealWidth()
  local r_h = ResolutionManager.RealHeight()
  local j_w = r_h * 16 / 9
  local det_w = (r_w - j_w) * 0.5
  if det_w < 0 then
    det_w = 0
  end
  if configBangWidth > det_w then
    configBangWidth = det_w
  end
  local bangWidthPercent
  if configBangWidth <= 0 then
    bangWidthPercent = 0
  else
    bangWidthPercent = bangWidth / configBangWidth * 100
  end
  if 100 < bangWidthPercent then
    bangWidthPercent = 100
  end
  return bangWidthPercent
end

function UIGuideCircleModelController:ConvertScreentPos(target)
  local screenPos = InnerGameHelperRender.WorldPos2ScreenPos(target.position)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx + self.data.offset[1], sy + self.data.offset[2])
  return screenPos
end

function UIGuideCircleModelController:OnHide()
  self._isShow = false
end

function UIGuideCircleModelController:RefreshShow()
  if self.data.lt then
    self.ltAllGO:SetActive(true)
  else
    self.ltAllGO:SetActive(false)
  end
  if self.data.rt then
    self.rtAllGO:SetActive(true)
  else
    self.rtAllGO:SetActive(false)
  end
  if self.data.lb then
    self.ldAllGO:SetActive(true)
  else
    self.ldAllGO:SetActive(false)
  end
  if self.data.rb then
    self.rdAllGO:SetActive(true)
  else
    self.rdAllGO:SetActive(false)
  end
end

function UIGuideCircleModelController:RefreshTxt()
  if self.data.lt then
    self.ltGO:SetActive(true)
    self.ltTitleTxt:SetText(StringTable.Get(self.data.lttitle))
    self.ltDescTxt:SetText(StringTable.Get(self.data.lt))
  else
    self.ltGO:SetActive(false)
  end
  if self.data.rt then
    self.rtGO:SetActive(true)
    self.rtTitleTxt:SetText(StringTable.Get(self.data.rttitle))
    self.rtDescTxt:SetText(StringTable.Get(self.data.rt))
  else
    self.rtGO:SetActive(true)
  end
  if self.data.lb then
    self.ldGO:SetActive(true)
    self.ldTitleTxt:SetText(StringTable.Get(self.data.lbtitle))
    self.ldDescTxt:SetText(StringTable.Get(self.data.lb))
  else
    self.ldGO:SetActive(false)
  end
  if self.data.rb then
    self.rdGO:SetActive(true)
    self.rdTitleTxt:SetText(StringTable.Get(self.data.rbtitle))
    self.rdDescTxt:SetText(StringTable.Get(self.data.rb))
  else
    self.rdGO:SetActive(false)
  end
end

function UIGuideCircleModelController:btnOnClick()
  self:OnClickBack()
end

function UIGuideCircleModelController:circleOnClick()
  self:OnClickBack()
end

function UIGuideCircleModelController:Back1OnClick()
  self:OnClickBack()
end

function UIGuideCircleModelController:Back2OnClick()
  self:OnClickBack()
end

function UIGuideCircleModelController:Back3OnClick()
  self:OnClickBack()
end

function UIGuideCircleModelController:Back4OnClick()
  self:OnClickBack()
end

function UIGuideCircleModelController:OnClickBack()
  if self.canClick then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Circle)
    self:CloseDialog()
  end
end
