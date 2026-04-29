_class("UISeasonMazeCardItem", UICustomWidget)
UISeasonMazeCardItem = UISeasonMazeCardItem

function UISeasonMazeCardItem:OnShow(uiParams)
  self._offsetY = 25
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self:InitWidget()
end

function UISeasonMazeCardItem:InitWidget()
  self._gameObject = self.view:GetGameObject()
  self._quality = self:GetUIComponent("Image", "Quality")
  self._qualityGO = self:GetGameObject("Quality")
  self._qualityTransform = self:GetUIComponent("RectTransform", "Quality")
  self._diceGO = self:GetGameObject("Dice")
  self._diceValue = self:GetUIComponent("UILocalizationText", "DiceValue")
  self._resGO = self:GetGameObject("Res")
  self._resImg = self:GetUIComponent("Image", "ResImg")
  self._resValue = self:GetUIComponent("UILocalizationText", "ResValue")
  self._flagGO = self:GetGameObject("Flag")
  self._playBtnGO = self:GetGameObject("PlayBtn")
  self._mark = self:GetGameObject("Mark")
  self._qualityGO:SetActive(false)
  self._mark:SetActive(false)
  self._animation = self:GetUIComponent("Animation", "Anim")
  self._diceAnimation = self:GetUIComponent("Animation", "DiceValue")
  self._shuaguangAnimation = self:GetUIComponent("Animation", "shuaguang")
  self._resValueAnimation = self:GetUIComponent("Animation", "ResValue")
  self._rootAlpha = self:GetUIComponent("CanvasGroup", "Anim")
  self._playBtnAnimation = self:GetUIComponent("Animation", "PlayBtn")
  self._qualityCanvasGroup = self:GetUIComponent("CanvasGroup", "Quality")
  self._rectTransform = self:GetUIComponent("RectTransform", "Root")
end

function UISeasonMazeCardItem:SetData(index, id, clickCallBack, playCallBack, canDrag, mgr, fromHandCard)
  self._rawPosition = Vector2(0, 0)
  self._index = index
  self._id = id
  self._clickCallBack = clickCallBack
  self._playCallBack = playCallBack
  self._canCard = canDrag
  self._mgr = mgr
  self._formHandCard = fromHandCard
  self._cfg = Cfg.cfg_component_season_maze_hand[self._id]
  self:_SetUIInfo()
  self:_RegisterUIEventListener()
  self:EnableRaycast(clickCallBack ~= nil)
end

function UISeasonMazeCardItem:EnableRaycast(enabled)
  self._quality.raycastTarget = enabled
end

function UISeasonMazeCardItem:PlayAnim(name)
  self._animation:Play(name)
end

function UISeasonMazeCardItem:PlayDelaBagAnim(index)
  local delta = math.ceil(index / 4)
  delta = delta * 70
  if delta == 0 then
    self._animation.gameObject:SetActive(true)
    self._animation:Play("uianim_UISeasonMazeCardItem_bag_in")
  else
    local timerEvent = GameGlobal.Timer():AddEventTimes(delta, TimerTriggerCount.Once, function()
      self._animation.gameObject:SetActive(true)
      self._animation:Play("uianim_UISeasonMazeCardItem_bag_in")
    end)
  end
end

function UISeasonMazeCardItem:StopAnim()
  self._animation:Stop()
  self._shuaguangAnimation:Stop()
  self._diceAnimation:Stop()
  self._resValueAnimation:Stop()
end

function UISeasonMazeCardItem:PlayShuaguang()
  self._shuaguangAnimation:Play("uianim_UISeasonMazeCardItem_shuaguang")
end

function UISeasonMazeCardItem:PlayDiceAnimation()
  self._diceAnimation:Play("uianim_UISeasonMazeCardItem_DiceValue")
end

function UISeasonMazeCardItem:PlayBtnAnimation()
  self._playBtnAnimation:Play("uieff_UISeasonMazeCardItem_PlayBtn_touch")
end

function UISeasonMazeCardItem:_SetUIInfo()
  self._qualityGO:SetActive(true)
  self:ReSet()
  self._quality.sprite = self._atlas:GetSprite(self:_GetCardSprite(self._cfg.Quality))
  self:RefreshDiceValue()
  self:RefreshResValue()
end

function UISeasonMazeCardItem:QualityOnClick(go)
  if self._clickCallBack then
    self._clickCallBack(self._index)
  end
end

function UISeasonMazeCardItem:PlayBtnOnClick(go)
  if self._playCallBack then
    self._playCallBack()
  end
end

function UISeasonMazeCardItem:ReSet()
  self._qualityTransform.anchoredPosition = self._rawPosition
  self._playBtnGO:SetActive(false)
  self._mark:SetActive(false)
  self:RootAlpha(1)
end

function UISeasonMazeCardItem:SetOffect(index)
  self._playBtnGO:SetActive(self._index == index)
  self._mark:SetActive(self._index == index)
  if self._index == index then
    self._qualityTransform.anchoredPosition = Vector2(self._rawPosition.x, self._rawPosition.y + self._offsetY)
    self:_PlayClickAnimation()
  else
    self._qualityTransform.anchoredPosition = self._rawPosition
  end
end

function UISeasonMazeCardItem:_PlayClickAnimation()
  self:Lock("UISeasonMazeCardItemPlayClickAnimation")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UISeasonMazeCardItem_touch")
    self._playBtnAnimation:Play("uieff_UISeasonMazeCardItem_PlayBtn_in")
    YIELD(TT, 333)
    self:UnLock("UISeasonMazeCardItemPlayClickAnimation")
  end)
end

function UISeasonMazeCardItem:_GetCardSprite(qualityType)
  if qualityType == SMazeCardQualityType.Blue then
    return "cn14_sjmj_xdp_di01"
  elseif qualityType == SMazeCardQualityType.Purple then
    return "cn14_sjmj_xdp_di02"
  elseif qualityType == SMazeCardQualityType.Orange then
    return "cn14_sjmj_xdp_di03"
  end
  return "cn14_sjmj_xdp_di03"
end

function UISeasonMazeCardItem:_GetTextColor(qualityType)
  if qualityType == SMazeCardQualityType.Blue then
    return Color(0.3764705882352941, 0.4470588235294118, 0.6431372549019608)
  elseif qualityType == SMazeCardQualityType.Purple then
    return Color(0.5882352941176471, 0.34901960784313724, 0.8)
  elseif qualityType == SMazeCardQualityType.Orange then
    return Color(0.611764705882353, 0.41568627450980394, 0.18823529411764706)
  end
  return Color(1, 1, 1)
end

function UISeasonMazeCardItem:_GetResByType(effectList, cfg)
  local spriteName
  local valueStr = ""
  local resType = effectList[1]
  local attType = effectList[2]
  local valueMin = effectList[3]
  local valueMax = effectList[4]
  if valueMin == valueMax then
    if attType == SeasonMazeAttrType.SMAT_Next_Hand_Add then
      valueStr = "+" .. valueMin
    else
      valueStr = tostring(valueMin)
    end
  elseif attType == SeasonMazeAttrType.SMAT_Next_Hand_Add then
    valueStr = "+" .. valueMin .. "~" .. valueMax
  else
    valueStr = valueMin .. "~" .. valueMax
  end
  if resType == SeasonMazeEffectType.SMET_HandStepRaiseReward then
    valueStr = self._diceValue.text
  end
  if resType == SeasonMazeEffectType.SMET_Pro then
    local cfg = Cfg.cfg_season_maze_attribute[attType]
    if cfg then
      spriteName = cfg.CardIcon
    end
  elseif cfg then
    spriteName = cfg.CardIcon
  end
  return spriteName, valueStr
end

function UISeasonMazeCardItem:OnPlayCard(diceValue, resValue)
  self._diceValue:SetText(diceValue)
  self._resValue:SetText(resValue)
end

function UISeasonMazeCardItem:RefreshDiceValue()
  local shoeStep = 0
  local preStep = 0
  if self._formHandCard then
    shoeStep = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_OnceShoesCnt)
    if self._componentInfo.past_hand then
      local last = self._componentInfo.past_hand[#self._componentInfo.past_hand]
      if last then
        preStep = last.steps
      end
    end
  end
  local min = shoeStep
  local max = shoeStep
  if 0 < self._cfg.CopyLast then
    if preStep == 0 then
      preStep = 1
    end
    min = preStep + shoeStep
    max = preStep + shoeStep
  elseif self._cfg.Steps then
    min = self._cfg.Steps[1] + shoeStep
    max = self._cfg.Steps[2] + shoeStep
  end
  if min ~= max then
    self._diceValue:SetText(min .. "~" .. max)
  else
    self._diceValue:SetText(tostring(min))
  end
  self._diceValue.color = self:_GetTextColor(self._cfg.Quality)
  local showDice = 0 < min + max
  if 0 < self._cfg.CopyLast and not self._formHandCard then
    showDice = false
  end
  self._diceGO:SetActive(showDice)
end

function UISeasonMazeCardItem:RefreshResValue()
  local spriteName
  local valueStr = ""
  if self._cfg.EffectIDs then
    local id = self._cfg.EffectIDs[1]
    if id then
      local effectCfg = Cfg.cfg_component_season_maze_effect[id]
      if effectCfg and effectCfg.EffectList then
        spriteName, valueStr = self:_GetResByType(effectCfg.EffectList[1], self._cfg)
      end
    end
  end
  if self._cfg.CopyLast > 0 and self._componentInfo.past_hand then
    local last = self._componentInfo.past_hand[#self._componentInfo.past_hand]
    if last then
      local copyID = last.id
      if 0 < last.ori_id then
        copyID = last.ori_id
      end
      local copyCfg = Cfg.cfg_component_season_maze_hand[copyID]
      if copyCfg and copyCfg.EffectIDs then
        local copyEffctID = copyCfg.EffectIDs[1]
        if copyEffctID then
          local copyEffectCfg = Cfg.cfg_component_season_maze_effect[copyEffctID]
          if copyEffectCfg and copyEffectCfg.EffectList then
            spriteName, valueStr = self:_GetResByType(copyEffectCfg.EffectList[1], copyCfg)
          end
        end
      end
    end
  end
  if string.isnullorempty(valueStr) then
    self._resImg.gameObject:SetActive(false)
    self._resValue.gameObject:SetActive(false)
  else
    if spriteName then
      self._resImg.sprite = self._atlas:GetSprite(spriteName)
      self._resImg.gameObject:SetActive(true)
    else
      self._resImg.gameObject:SetActive(false)
    end
    self._resValue:SetText(valueStr)
    self._resValue.color = self:_GetTextColor(self._cfg.Quality)
    self._resValue.gameObject:SetActive(true)
  end
  self._flagGO:SetActive(self._cfg.CopyLast > 0)
  local showRes = true
  if self._cfg.CopyLast > 0 and not self._formHandCard then
    showRes = false
  end
  self._resGO:SetActive(showRes)
end

function UISeasonMazeCardItem:_RegisterUIEventListener()
  if self._canCard then
    self._eventListener = UICustomUIEventListener.Get(self._qualityGO)
    self:AddUICustomEventListener(self._eventListener, UIEvent.BeginDrag, function(eventData)
      self:_OnBeginDrag(eventData)
    end)
    self:AddUICustomEventListener(self._eventListener, UIEvent.Drag, function(eventData)
      self:_OnDrag(eventData)
    end)
    self:AddUICustomEventListener(self._eventListener, UIEvent.EndDrag, function(eventData)
      self:_OnEndDrag(eventData)
    end)
    self:AddUICustomEventListener(self._eventListener, UIEvent.Release, function(eventData)
      self:_OnRelease(eventData)
    end)
  end
end

function UISeasonMazeCardItem:_OnBeginDrag(eventData)
  self._mgr:OnBeginDrag(eventData, self)
end

function UISeasonMazeCardItem:_OnDrag(eventData)
  self._mgr:OnDrag(eventData)
end

function UISeasonMazeCardItem:_OnEndDrag(eventData)
  self._mgr:OnDragEnd(eventData)
end

function UISeasonMazeCardItem:_OnRelease()
  self._mgr:OnReleased()
end

function UISeasonMazeCardItem:Index()
  return self._index
end

function UISeasonMazeCardItem:ID()
  return self._id
end

function UISeasonMazeCardItem:GameObject()
  return self._gameObject
end

function UISeasonMazeCardItem:RectTransform()
  return self._rectTransform
end

function UISeasonMazeCardItem:Position()
  return self._gameObject.transform.position
end

function UISeasonMazeCardItem:LocalPosition()
  return self._gameObject.transform.localPosition
end

function UISeasonMazeCardItem:RootAlpha(alpha)
  self._rootAlpha.alpha = alpha
end

function UISeasonMazeCardItem:QualityAlpha(alpha)
  self._qualityCanvasGroup.alpha = alpha
end

function UISeasonMazeCardItem:GetMiddleCardBtnGo()
  return self._qualityGO
end

function UISeasonMazeCardItem:Mark(active)
  self._mark:SetActive(active)
end
