_class("UIAttributeCompareItem", UICustomWidget)
UIAttributeCompareItem = UIAttributeCompareItem

function UIAttributeCompareItem:Constructor()
end

function UIAttributeCompareItem:OnShow(uiParams)
  self._uiPetElementAtlas = self:GetAsset("UIPetUpLevel.spriteatlas", LoadType.SpriteAtlas)
  self._attIcon = self:GetUIComponent("Image", "attIcon")
  self._attName = self:GetUIComponent("UILocalizationText", "attName")
  self._nextAttName = self:GetUIComponent("UILocalizationText", "nextAttName")
  self._attValue = self:GetUIComponent("UILocalizationText", "attValue")
  self._arrowImg = self:GetUIComponent("Image", "arrow")
  self._nextAttValue = self:GetUIComponent("UILocalizationText", "nextAttValue")
  self._nextAttValueRect = self:GetUIComponent("RectTransform", "nextAttValue")
  self._addedValue = self:GetUIComponent("UILocalizationText", "addedValue")
  self._addedValueRect = self:GetUIComponent("RectTransform", "addedValue")
  self._animEff = self:GetGameObject("animEff")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._nextValueAlpha = self:GetUIComponent("CanvasGroup", "nextAttValue")
  self._addValueAlpha = self:GetUIComponent("CanvasGroup", "addedValue")
  self._arrowGo = self:GetGameObject("arrow")
  self._nextAttValueGo = self:GetGameObject("nextAttValue")
  self._addedValueGo = self:GetGameObject("addedValue")
  self._changed = false
  self.attInfos = {
    [1] = {
      name = "str_pet_config_attack_full",
      icon = "spirit_xiangqing_icon5"
    },
    [2] = {
      name = "str_pet_config_defence_full",
      icon = "spirit_xiangqing_icon3"
    },
    [3] = {
      name = "str_pet_config_health_full",
      icon = "spirit_xiangqing_icon4"
    }
  }
  self._animFirstName = "uieff_UpLevel_1"
  self._animSecondName = "uieff_UpLevel_2"
  self._animThirdName = "uieff_UpLevel_3"
  self._player = EZTL_Player:New()
  self._reseted = true
  self._timer = 0
  self._animTime = 0.5
end

function UIAttributeCompareItem:OnLevelUpAttValueChanged(rate)
  local curValue = (self._nextValue - self._lastValue) * rate + self._lastValue
  local showValue = math.floor(curValue)
  self._nextAttValue:SetText(showValue)
end

function UIAttributeCompareItem:StartPlayAttributeAmin()
  self._timer = 0
  self:SetAddAttributePanelStatus(false)
end

function UIAttributeCompareItem:UpdateAttributeAnim(deltTime)
  local changeValue = self._nextValue - self._lastValue
  if changeValue <= 0 then
    return true
  end
  local speed = changeValue / self._timer
  self._timer = self._timer + deltTime
  if self._timer >= self._animTime then
    self._attValue.text = self._nextValue
    return true
  end
  self._attValue.text = math.floor(self._lastValue + changeValue * self._timer / self._animTime)
  return false
end

function UIAttributeCompareItem:SetAddAttributePanelStatus(status)
  self._arrowGo:SetActive(status)
  self._nextAttValueGo:SetActive(status)
  self._addedValueGo:SetActive(status)
end

function UIAttributeCompareItem:ResetUIPostion()
end

function UIAttributeCompareItem:SetData(attInfo)
  self:SetAddAttributePanelStatus(true)
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
  end
  local info = self.attInfos[attInfo.attType]
  local name = StringTable.Get(info.name)
  self._attName.text = name
  self._nextAttName.text = name
  self._attIcon.sprite = self._uiPetElementAtlas:GetSprite(info.icon)
  self._lastValue = attInfo.CurAttValue
  self._nextValue = attInfo.NextAttValue
  self._attValue.text = attInfo.CurAttValue
  self._nextAttValue.text = attInfo.NextAttValue
  local added = attInfo.NextAttValue - attInfo.CurAttValue
  if 0 < added then
    self._changed = true
    self._nextAttValue.color = Color(1, 0.9411764705882353, 0.24705882352941178, 1)
    self._addedValue:SetText("+" .. added)
    self._addedValue.gameObject:SetActive(true)
  else
    self._changed = false
    self._nextAttValue.color = Color(1, 1, 1, 1)
    self._addedValue.gameObject:SetActive(false)
  end
  self._nextAtt = attInfo.CurAttValue
  if self._reseted == false then
    self._reseted = true
    self._nextAttValueRect.anchoredPosition = Vector2(602.5, -16)
    self._addedValueRect.anchoredPosition = Vector2(842, -23)
    self._arrowImg.color = Color(1, 1, 1, 1)
    self._nextValueAlpha.alpha = 1
    self._addValueAlpha.alpha = 1
  end
end

function UIAttributeCompareItem:PlayAnimFirst(yieldTime)
  if self._changed then
    self._reseted = false
    local tls = {}
    if yieldTime then
      tls[#tls + 1] = EZTL_Wait:New(yieldTime, "等待动画" .. yieldTime .. "毫秒")
    end
    tls[#tls + 1] = EZTL_PlayAnimation:New(self._anim, self._animFirstName, "升级增加值move")
    self._tl = EZTL_Sequence:New(tls, "升级总时间线-UIAttributeCompareItem-first")
    self._player:Play(self._tl)
  end
end

function UIAttributeCompareItem:PlayAnimSecond(yieldTime)
  if self._changed then
    local tls = {}
    local lastYieldTime = 200 - yieldTime
    if yieldTime and 0 < yieldTime then
      tls[#tls + 1] = EZTL_Wait:New(yieldTime, "等待动画" .. yieldTime .. "毫秒")
    end
    tls[#tls + 1] = EZTL_PlayAnimation:New(self._anim, self._animSecondName, "下级数据抖动")
    if lastYieldTime and 0 < lastYieldTime then
      tls[#tls + 1] = EZTL_Wait:New(lastYieldTime, "等待动画2" .. lastYieldTime .. "毫秒")
    end
    local tls2 = {}
    tls2[#tls2 + 1] = EZTL_PlayAnimation:New(self._anim, self._animThirdName, "下级数据move")
    local tls3 = {}
    tls3[#tls3 + 1] = EZTL_Wait:New(400, "等待时间刷新left值")
    tls3[#tls3 + 1] = EZTL_Callback:New(function()
      self._attValue:SetText(self._nextValue)
    end, "刷新left值")
    local tls_changeValue = EZTL_Sequence:New(tls3)
    tls2[#tls2 + 1] = tls_changeValue
    local tls_par = EZTL_Parallel:New(tls2, EZTL_EndTag.All, nil, "三阶并行动画")
    tls[#tls + 1] = tls_par
    self._tl = EZTL_Sequence:New(tls, "升级总时间线-UIAttributeCompareItem-second")
    self._player:Play(self._tl)
  end
end
