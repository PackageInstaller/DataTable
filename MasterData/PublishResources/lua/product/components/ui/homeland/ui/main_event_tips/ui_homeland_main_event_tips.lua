_class("UIHomelandMainEventTips", UICustomWidget)
UIHomelandMainEventTips = UIHomelandMainEventTips
local UIHomeEventTipsType = {
  Tex = 0,
  PetBody = 1,
  Dairy = 2
}
_enum("UIHomeEventTipsType", UIHomeEventTipsType)

function UIHomelandMainEventTips:OnShow()
  self:GetComponent()
  self:OnValue()
  self:AddListener()
end

function UIHomelandMainEventTips:AddListener()
  self:AttachEvent(GameEventType.OnUIHomeEventTips, self.OnUIHomeEventTips)
end

function UIHomelandMainEventTips:GetComponent()
  self._pos = self:GetUIComponent("RectTransform", "pos")
  self._alpha = self:GetUIComponent("CanvasGroup", "pos")
  self._petBody = self:GetGameObject("petBody")
  self._petBody_icon = self:GetUIComponent("RawImageLoader", "petBody_icon")
  self._petBody_tips = self:GetUIComponent("UILocalizationText", "petBody_tips")
  self._petBody_maskLayout = self:GetUIComponent("LayoutGroup", "petBody_mask")
  self._petBody_layoutElement = self:GetUIComponent("LayoutElement", "petBody_mask")
  self._petBody_txt_icon = self:GetGameObject("petBody_txt_icon")
  self._petBody_txt_icon_heart = self:GetGameObject("petBody_txt_icon_heart")
  self._tex = self:GetGameObject("tex")
  self._tex_tips = self:GetUIComponent("UILocalizationText", "tex_tips")
  self._tex_maskLayout = self:GetUIComponent("LayoutGroup", "tex_mask")
  self._tex_layoutElement = self:GetUIComponent("LayoutElement", "tex_mask")
  self._diary = self:GetGameObject("diary")
  self._diary_tips = self:GetUIComponent("UILocalizationText", "diary_tips")
  self._diary_maskLayout = self:GetUIComponent("LayoutGroup", "diary_mask")
  self._diary_layoutElement = self:GetUIComponent("LayoutElement", "diary_mask")
end

function UIHomelandMainEventTips:OnValue()
  self._moveInTime = 0.5
  self._moveOutTime = 0.5
  self._texMaxWidh = 600
  self._texScrollSpeed = 40
  self:RegisterComponents()
  self._eventQueue = {}
end

function UIHomelandMainEventTips:RegisterComponents()
  self._type2components = {}
  local tex_data = {}
  local type = UIHomeEventTipsType.Tex
  tex_data.tex = self._tex_tips
  tex_data.maskLayout = self._tex_maskLayout
  tex_data.layoutElement = self._tex_layoutElement
  tex_data.startPosX = 0
  self._type2components[type] = tex_data
  local petBody_data = {}
  local type = UIHomeEventTipsType.PetBody
  petBody_data.tex = self._petBody_tips
  petBody_data.maskLayout = self._petBody_maskLayout
  petBody_data.layoutElement = self._petBody_layoutElement
  petBody_data.startPosX = 0
  self._type2components[type] = petBody_data
  local dairy_data = {}
  local type = UIHomeEventTipsType.Dairy
  dairy_data.tex = self._diary_tips
  dairy_data.maskLayout = self._diary_maskLayout
  dairy_data.layoutElement = self._diary_layoutElement
  dairy_data.startPosX = 0
  self._type2components[type] = dairy_data
end

function UIHomelandMainEventTips:OnUIHomeEventTips(type, param)
  local event = {}
  event.type = type
  event.param = param
  table.insert(self._eventQueue, event)
  self:ShowEvent()
end

function UIHomelandMainEventTips:ShowEvent()
  if self._doing then
    return
  end
  self._doing = true
  self:PopEvent()
end

function UIHomelandMainEventTips:PopEvent()
  if #self._eventQueue > 0 then
    self._yieldTime = 3000
    local event = self._eventQueue[1]
    table.remove(self._eventQueue, 1)
    local width = self:SetEventData(event)
    if width < self._texMaxWidh then
      self._posZeroX = -width - 300
    else
      self._posZeroX = -self._texMaxWidh - 300
    end
    self:MoveIn()
  else
    self._doing = false
  end
end

function UIHomelandMainEventTips:SetEventData(event)
  local type = event.type
  self._petBody:SetActive(false)
  self._tex:SetActive(false)
  self._diary:SetActive(false)
  if type == UIHomeEventTipsType.Tex then
    self._tex:SetActive(true)
    local content = event.param[1]
    self._tex_tips:SetText(content)
  elseif type == UIHomeEventTipsType.PetBody then
    self._petBody:SetActive(true)
    local icon = event.param[1]
    local content = event.param[2]
    local showHeart = event.param[3] or false
    self._petBody_icon:LoadImage(icon)
    self._petBody_tips:SetText(content)
    self._petBody_txt_icon:SetActive(not showHeart)
    self._petBody_txt_icon_heart:SetActive(showHeart)
  elseif type == UIHomeEventTipsType.Dairy then
    self._diary:SetActive(true)
    local content = event.param[1]
    self._diary_tips:SetText(content)
  end
  return self:CalcTexWidth(type)
end

function UIHomelandMainEventTips:CalcTexWidth(type)
  local _width
  if type then
    local tex = self._type2components[type].tex
    self._moveTex = tex
    local startPosX = self._type2components[type].startPosX
    tex.rectTransform.anchoredPosition = Vector2(startPosX, tex.rectTransform.anchoredPosition.y)
    local maskLayout = self._type2components[type].maskLayout
    local layoutElement = self._type2components[type].layoutElement
    local texWidth = tex.preferredWidth
    _width = texWidth
    if texWidth > self._texMaxWidh then
      maskLayout.enabled = false
      layoutElement.enabled = true
      layoutElement.preferredWidth = self._texMaxWidh
      local gaps = texWidth - self._texMaxWidh
      local tweenTime = gaps / self._texScrollSpeed
      local costTime = tweenTime * 1000
      if costTime > self._yieldTime then
        self._yieldTime = costTime
      end
      self._yieldTime = self._yieldTime + 500
      if self._rollingEvent then
        GameGlobal.Timer():CancelEvent(self._rollingEvent)
        self._rollingEvent = nil
      end
      self._rollingEvent = GameGlobal.Timer():AddEvent(500, function()
        if self._moveTex then
          self._moveTex.rectTransform:DOAnchorPosX(self._moveTex.rectTransform.anchoredPosition.x - gaps, tweenTime, false):SetEase(DG.Tweening.Ease.Linear)
        end
      end)
    else
      layoutElement.enabled = false
      maskLayout.enabled = true
    end
  end
  return _width
end

function UIHomelandMainEventTips:MoveIn()
  self._alpha.alpha = 0
  self._pos.anchoredPosition = Vector2(self._posZeroX, 0)
  self._alpha:DOFade(1, self._moveInTime)
  self._tweener = self._pos:DOAnchorPosX(0, self._moveInTime):OnComplete(function()
    self:StartTimeDown()
  end)
end

function UIHomelandMainEventTips:OnHide()
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  if self._rollingEvent then
    GameGlobal.Timer():CancelEvent(self._rollingEvent)
    self._rollingEvent = nil
  end
end

function UIHomelandMainEventTips:StartTimeDown()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  self._timer = GameGlobal.Timer():AddEvent(self._yieldTime, function()
    self:MoveOut()
  end)
end

function UIHomelandMainEventTips:MoveOut()
  if self._tweener then
    self._tweener:Kill(true)
    self._tweener = nil
  end
  self._tweener = self._alpha:DOFade(0, self._moveOutTime):OnComplete(function()
    self:PopEvent()
  end)
end
