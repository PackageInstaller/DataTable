_class("UIQuestTypeBtnItem", UICustomWidget)
UIQuestTypeBtnItem = UIQuestTypeBtnItem

function UIQuestTypeBtnItem:OnShow(uiParams)
  self._state = 0
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] erro --> module id nil !")
    return
  end
  self:AttachEvent(GameEventType.ItemCountChanged, self.CheckQuestRedPoint)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.CampaignComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self.CheckQuestRedPoint)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.CheckQuestRedPoint)
end

function UIQuestTypeBtnItem:SetData(index, cfg, callback)
  self:_GetComponents()
  self._index = index
  self._cfg = cfg
  self._type = self._cfg.ClientType
  self._callback = callback
  self:_OnValue()
end

function UIQuestTypeBtnItem:_OnValue()
  self._typeTex:SetText(StringTable.Get(self._cfg.TypeName))
  self._typeTex_select:SetText(StringTable.Get(self._cfg.TypeName))
  self._typeTex:SetLayoutDirty()
  self._typeTexEn:SetText(self._cfg.TypeNameEn)
  self._icon.sprite = self._atlas:GetSprite(self._cfg.Icon)
  self:CheckQuestRedPoint()
  self._growth:SetActive(false)
end

function UIQuestTypeBtnItem:Time2Str(time)
  local str = math.ceil(time / 60 / 60 / 24) .. StringTable.Get("str_quest_base_growth_time_day_str")
  return str
end

function UIQuestTypeBtnItem:CheckNew(enum)
  return self._module:GetNewPoint(enum)
end

function UIQuestTypeBtnItem:CheckRed(enum)
  local redInfo = self._module:GetRedPoint()
  if redInfo[enum] then
    if type(redInfo[enum]) == "table" then
      if table.count(redInfo[enum]) > 0 then
        return true
      end
    else
      return true
    end
  end
  return false
end

function UIQuestTypeBtnItem:_GetComponents()
  self._typeTex = self:GetUIComponent("UILocalizedTMP", "typeTex")
  self._typeTexEn = self:GetUIComponent("UILocalizationText", "typeTexEn")
  self._icon = self:GetUIComponent("Image", "icon")
  self._red = self:GetGameObject("red")
  self._redRect = self:GetUIComponent("RectTransform", "red")
  self._initRedLocalPos = Vector3(-75, 0, 0)
  self._selectedRedLocalPos = Vector3(-25, 0, 0)
  self._select = self:GetGameObject("select")
  self._growth = self:GetGameObject("growth")
  self._remainingTime = self:GetUIComponent("UILocalizationText", "remainingTime")
  self._remainingImg = self:GetUIComponent("Image", "remainingImg")
  self._redPos = self:GetUIComponent("RectTransform", "redPos")
  self._select:SetActive(false)
  self._typeTex_select = self:GetUIComponent("UILocalizedTMP", "typeTex_select")
  self._typeTex_select.gameObject:SetActive(false)
end

function UIQuestTypeBtnItem:Select(select)
  if select then
    self._icon.sprite = self._atlas:GetSprite(self._cfg.SelectIcon)
    self._redRect.anchoredPosition = self._selectedRedLocalPos
  else
    self._icon.sprite = self._atlas:GetSprite(self._cfg.Icon)
    self._redRect.anchoredPosition = self._initRedLocalPos
  end
  self._select:SetActive(select)
  self._typeTex_select.gameObject:SetActive(select)
end

function UIQuestTypeBtnItem:bgOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._callback then
    self._callback(self._index, self._cfg.ClientType)
  end
end

function UIQuestTypeBtnItem:OnHide()
end

function UIQuestTypeBtnItem:CampaignComponentStepChange()
  if self._type == ClientQuestType.QT_Season then
    self._module:CalcRedPoint()
    self:CheckQuestRedPoint()
  end
end

function UIQuestTypeBtnItem:CheckQuestRedPoint()
  local new = self:CheckNew(self._type)
  local red = self:CheckRed(self._type)
  UIWidgetHelper.SetNewAndReds(self, new, red, "questNew", "red")
  self._red:SetActive(red)
end
