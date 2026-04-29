_class("UIBossBuffItem", UICustomWidget)
UIBossBuffItem = UIBossBuffItem

function UIBossBuffItem:OnShow()
  self._buffIcon = self:GetUIComponent("RawImageLoader", "buffIcon")
  self._describeText = self:GetUIComponent("UILocalizationText", "describeText")
  self._textRect = self:GetUIComponent("RectTransform", "describeText")
  self._go = self:GetGameObject()
  self._layout = self._go:GetComponent("HorizontalLayoutGroup")
  self._countDownRoot = self:GetGameObject("countDownRoot")
  if self._countDownRoot then
    self._countDownNum = self:GetUIComponent("UILocalizationText", "countDownNum")
    self._countDownRoot:SetActive(false)
  end
end

function UIBossBuffItem:OnHide()
end

function UIBossBuffItem:InitBuff(index, buffViewInstance)
  if not buffViewInstance then
    return
  end
  self._buffIcon.gameObject:SetActive(true)
  self._buffIcon:LoadImage(buffViewInstance:GetBuffIcon())
  local strRound = buffViewInstance:GetRoundCountOrLayerText()
  local strDesc = StringTable.Get(buffViewInstance:GetBuffDesc(), buffViewInstance:GetShowBuffDescParams())
  if string.isnullorempty(strRound) then
    self._describeText.text = strDesc
  else
    self._describeText.text = strRound .. "·" .. strDesc
  end
  self._textRect.sizeDelta = Vector2(450, self._textRect.sizeDelta.y)
  self._layout.padding.left = 70
  local countDown = buffViewInstance:GetCountDown()
  if countDown and self._countDownRoot then
    self._countDownRoot:SetActive(0 < countDown)
    self._countDownNum.text = countDown
  end
end

function UIBossBuffItem:InitElite(index, eliteID)
  local cfgElite = Cfg.cfg_monster_elite[eliteID]
  if not cfgElite then
    return
  end
  self._buffIcon.gameObject:SetActive(false)
  self._describeText.text = StringTable.Get(cfgElite.Name) .. " : " .. StringTable.Get(cfgElite.Desc)
  self._textRect.sizeDelta = Vector2(580, self._textRect.sizeDelta.y)
  self._layout.padding.left = -25
end
