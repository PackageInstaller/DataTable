_class("UISeasonStageAwardItemS5", UICustomWidget)
UISeasonStageAwardItemS5 = UISeasonStageAwardItemS5

function UISeasonStageAwardItemS5:OnShow()
  self._trans = self:GetGameObject()
  self:GetComponents()
end

function UISeasonStageAwardItemS5:GetComponents()
  self._trans = self:GetGameObject()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRawImg = self:GetUIComponent("RawImage", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconRectDefaultSize = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.y)
  self._iconGO = self:GetGameObject("icon")
  self._quality = self:GetUIComponent("Image", "quality")
  self._qualityRect = self:GetUIComponent("RectTransform", "quality")
  self._qualityGO = self:GetGameObject("quality")
  self._text1 = self:GetUIComponent("UILocalizationText", "txt1")
  self._text1GO = self:GetGameObject("txt1")
  self._text1BgGO = self:GetGameObject("diban")
  self.atlas = self:GetAsset("UIS5Scene.spriteatlas", LoadType.SpriteAtlas)
  self._awardTxt = self:GetUIComponent("UILocalizationText", "txt3Star")
  self._typeMainBgImg = self:GetUIComponent("Image", "TypeMainBg")
  self._topText = self:GetUIComponent("UILocalizationText", "topText")
  self._topGo = self:GetGameObject("g_topaward")
  self._actGo = self:GetGameObject("g_activity")
  self._actText = self:GetUIComponent("UILocalizationText", "actText")
  self._anim = self:GetUIComponent("Animation", "Base")
  self._rootGo = self:GetGameObject("root")
  self._typeImg = self:GetUIComponent("Image", "typeImg")
end

function UISeasonStageAwardItemS5:Flush(v, levelDiff)
  if not v then
    return
  end
  self._v = v
  local icon = v.icon
  local quality = v.color
  local text1 = v.count
  local strKey = ""
  local textColor = Color(0.878, 0.961, 1, 1)
  self._activityText = ""
  self._topTextStr = UIEnum.ItemRandomStr(v.randomType)
  local awardType = v.type
  local itemId = v.id
  if awardType == StageAwardType.First then
    strKey = "str_season_first_award"
    textColor = Color(0.37254901960784315, 0.5450980392156862, 0.6901960784313725, 1)
  elseif awardType == StageAwardType.Star then
    strKey = "str_season_3star_award"
    textColor = Color(0.8470588235294118, 0.5686274509803921, 0.33725490196078434, 1)
  elseif awardType == StageAwardType.Activity then
    strKey = "str_season_activity_award"
    self._activityText = StringTable.Get("str_item_xianshi")
    textColor = Color(0.47058823529411764, 0.4392156862745098, 0.38823529411764707, 1)
  elseif awardType == StageAwardType.HasGen then
    strKey = "str_season_already_collect"
  else
    strKey = "str_season_normal_award"
    textColor = Color(0.47058823529411764, 0.4392156862745098, 0.38823529411764707, 1)
  end
  self:SetText1(text1)
  self:SetQuality(quality)
  self:SetIcon(icon, itemId)
  self:SetAwardText(StringTable.Get(strKey), textColor)
  self:SetTopAward()
  self:SetAct()
end

function UISeasonStageAwardItemS5:SetIcon(name, itemId)
  if not string.isnullorempty(name) then
    self:ShowIcon(true, itemId)
    self._icon:LoadImage(name)
    local isHead = false
    if 3750000 <= itemId and itemId <= 3759999 then
      isHead = true
    end
    if isHead then
      local whRate = 1
      if 3751000 <= itemId and itemId <= 3751999 then
        whRate = 0.8421052631578947
      elseif 3752000 <= itemId and itemId <= 3752999 then
        whRate = 0.6388888888888888
      elseif 3753000 <= itemId and itemId <= 3753999 then
        whRate = 0.6388888888888888
      end
      self._iconRect.sizeDelta = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.x * whRate)
    else
      self._iconRect.sizeDelta = self._iconRectDefaultSize
    end
  else
    self:ShowIcon(false)
  end
end

function UISeasonStageAwardItemS5:ShowIcon(show, itemId)
  self._iconGO:SetActive(show)
  self:SetIconOffset(itemId)
end

function UISeasonStageAwardItemS5:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(-2, 15)
  else
    self._iconRect.anchoredPosition = Vector2(-2, 15)
  end
end

function UISeasonStageAwardItemS5:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UISeasonStageAwardItemS5:SetQuality(quality)
  if quality <= 0 then
    quality = 1
  end
  local qualityName = "exp_s5_map_daoju_pinji0" .. tostring(quality)
  if qualityName ~= "" then
    self:ShowQuality(true)
    self._quality.sprite = self.atlas:GetSprite(qualityName)
  else
    self:ShowQuality(false)
  end
end

function UISeasonStageAwardItemS5:ShowQuality(show)
  self._qualityGO:SetActive(show)
end

function UISeasonStageAwardItemS5:SetText1(text, showNumber)
  if text ~= nil then
    local show = false
    if type(text) == "number" then
      local num = text
      show = 0 < num or showNumber
      self._text1:SetText(HelperProxy:GetInstance():FormatItemCount(num))
    elseif type(text) == "string" then
      show = not string.isnullorempty(text)
      self._text1:SetText(text)
    end
    self:ShowText1(show)
  else
    self:ShowText1(false)
  end
end

function UISeasonStageAwardItemS5:ShowText1(show)
  self._text1GO:SetActive(show)
  self:SetOffset(show)
end

function UISeasonStageAwardItemS5:SetOffset(showText1)
end

function UISeasonStageAwardItemS5:SetAwardText(awardText, color)
  self._awardTxt:SetText(awardText)
  self._awardTxt.color = color
end

function UISeasonStageAwardItemS5:SetTypeBg(typeBgName)
end

function UISeasonStageAwardItemS5:SetTypeMainBg(typeBgName)
end

function UISeasonStageAwardItemS5:SetTopAward()
  self:SetTopText(self._topTextStr)
end

function UISeasonStageAwardItemS5:SetTopText(text)
  if not string.isnullorempty(text) then
    self:ShowTopText(true)
    self._topText:SetText(text)
  else
    self:ShowTopText(false)
  end
end

function UISeasonStageAwardItemS5:ShowTopText(show)
  self._topGo:SetActive(show)
end

function UISeasonStageAwardItemS5:SetAct()
  if not string.isnullorempty(self._activityText) then
    self:ShowText(true)
    self._actText:SetText(self._activityText)
  else
    self:ShowText(false)
  end
end

function UISeasonStageAwardItemS5:ShowText(show)
  self._actGo:SetActive(show)
end

function UISeasonStageAwardItemS5:BtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._v then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._v.id, self._trans.transform.position)
  end
end

function UISeasonStageAwardItemS5:PlayAnim(totalDelay)
  local curAnimDelay = 0
  if totalDelay then
    curAnimDelay = totalDelay
  end
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
    self._animTimer = nil
  end
  self._animTimer = GameGlobal.Timer():AddEvent(curAnimDelay, function()
    self:_PlayInAnim()
  end)
end

function UISeasonStageAwardItemS5:_PlayInAnim()
  if self._anim then
    self._anim:Play("uieff_UISeasonAwardItem_3Star_in")
    if self._rootGo then
      self._rootGo:SetActive(true)
    end
  end
end

function UISeasonStageAwardItemS5:OnHide()
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
    self._animTimer = nil
  end
end

function UISeasonStageAwardItemS5:SetWaitAnim()
  if self._rootGo then
    self._rootGo:SetActive(false)
  end
end
