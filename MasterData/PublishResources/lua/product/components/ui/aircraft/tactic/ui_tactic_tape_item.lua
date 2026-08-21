_class("UITacticTapeItem", UICustomWidget)
UITacticTapeItem = UITacticTapeItem

function UITacticTapeItem:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.AircraftTacticOnSelectItemChanged, self.onSelect)
  self:AttachEvent(GameEventType.AircraftTacticTapeCancelNew, self.cancelNew)
  self._timerHolder = UITimerHolder:New()
end

function UITacticTapeItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.tape = self:GetGameObject("tape")
  self.pack = self:GetGameObject("pack")
  self.select = self:GetGameObject("select")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.new = self:GetGameObject("new")
  self._root = self:GetUIComponent("RectTransform", "tape")
  self._quality = self:GetUIComponent("UILocalizationText", "quality")
  self._shadow = self:GetUIComponent("UILocalizationText", "name_shadow")
  self._icon_eff = self:GetUIComponent("RawImageLoader", "icon_eff")
  self._quality_eff = self:GetUIComponent("UILocalizationText", "quality_eff")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._selectState = self._anim:get_Item("uieff_Tape_Select")
  self._cancelState = self._anim:get_Item("uieff_Tape_Select_Cancel")
end

function UITacticTapeItem:OnHide()
  self._timerHolder:Dispose()
  self._timerHolder = nil
end

function UITacticTapeItem:SetData(tapeData, index, onClick, selected, isInit)
  self._data = tapeData
  self._index = index
  self._onClick = onClick
  if self._data then
    self.icon:LoadImage(self._data:GetTemplate().Icon)
    self._icon_eff:LoadImage(self._data:GetTemplate().Icon)
    self.pack:SetActive(false)
    self.tape:SetActive(true)
    self.select:SetActive(selected)
    local name = StringTable.Get(self._data:GetTemplate().Name)
    self.name:SetText(name)
    self._shadow:SetText(name)
    self.new:SetActive(self._data:IsNewOverlay())
    local cfg = Cfg.cfg_item_cartridge[self._data:GetTemplateID()]
    self._quality:SetText(cfg.Quality)
    self._quality_eff:SetText(cfg.Quality)
    if selected then
      self._anim:Play("uieff_Tape_Select")
      self._selectState.normalizedTime = 1
      self._anim:Sample()
      self._anim:Stop()
      self._isSelect = true
    else
      self._anim:Play("uieff_Tape_Select_Cancel")
      self._cancelState.normalizedTime = 1
      self._anim:Sample()
      self._anim:Stop()
      self._isSelect = false
    end
  else
    self.pack:SetActive(true)
    self.tape:SetActive(false)
    self.select:SetActive(false)
    self.new:SetActive(false)
  end
  if isInit then
    self._anim:Stop()
    self:GetGameObject():SetActive(false)
    self._timerHolder:StartTimer("uieff_Tape_In", 33 * (index - 1) + 1066, function()
      self:GetGameObject():SetActive(true)
      self._anim:Play("uieff_Tape_In")
    end)
  end
end

function UITacticTapeItem:itemOnClick(go)
  self._onClick(self._data, self._index)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
end

function UITacticTapeItem:onSelect(data)
  if self._data then
    self.select:SetActive(self._data == data)
    if self._data == data then
      self._anim:Stop()
      self._anim:Play("uieff_Tape_Select")
      self._isSelect = true
    else
      if self._isSelect then
        self._anim:Stop()
        self._anim:Play("uieff_Tape_Select_Cancel")
      end
      self._isSelect = false
    end
  end
end

function UITacticTapeItem:cancelNew(pstID)
  if self._data and self._data:GetID() == pstID then
    self.new:SetActive(false)
  end
end
