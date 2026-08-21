_class("UIHomeLandDiaryItem", UICustomWidget)
UIHomeLandDiaryItem = UIHomeLandDiaryItem

function UIHomeLandDiaryItem:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomeLandDiaryItem:_InitWidget()
  self._pageText = self:GetUIComponent("UILocalizationText", "pageText")
  self._petText = self:GetUIComponent("UILocalizationText", "petText")
  self._contentText = self:GetUIComponent("UILocalizationText", "contentText")
  self._tipText = self:GetUIComponent("UILocalizationText", "tipText")
  self._headImageLoader = self:GetUIComponent("RawImageLoader", "headImage")
  self._newGo = self:GetGameObject("new")
  self._maskImg = self:GetGameObject("maskImg")
end

function UIHomeLandDiaryItem:InitData(data, callback, index, isnew, islock, eventcfg, len)
  self._data = data
  self._callback = callback
  self._index = index
  self._isNew = isnew
  self._isLock = islock
  self._eventData = eventcfg[self._data.EventId]
  self._petimgId = self._eventData.PetID == nil and "head1_1300821" or "head1_" .. self._eventData.PetID
  self._totleLen = len
  self:Refresh()
end

function UIHomeLandDiaryItem:OnShow(uiParams)
  self:_InitWidget()
end

function UIHomeLandDiaryItem:Refresh()
  self._headImageLoader:LoadImage(self._petimgId)
  self._newGo:SetActive(self._isNew and not self._isLock)
  self._maskImg:SetActive(self._isLock)
  local pet = Cfg.cfg_pet[self._eventData.PetID]
  pet = pet or self:GetNpcInfo(self._eventData.PetID)
  if not pet then
    return
  end
  local name = pet.Name
  if self._isLock then
    self._pageText:SetText("")
    self._petText:SetText("")
    self._contentText:SetText("")
    self._tipText:SetText(StringTable.Get(self._data.Condition))
  else
    self._pageText:SetText("- " .. self._index .. " -")
    self._petText:SetText(StringTable.Get(name))
    self._contentText:SetText(StringTable.Get(self._data.DairyTitle))
    self._tipText:SetText("")
  end
end

function UIHomeLandDiaryItem:GetNpcInfo(petId)
  local data = Cfg.cfg_homeland_task_npc({})
  for key, value in pairs(data) do
    if value.NpcId == petId then
      return value
    end
  end
end

function UIHomeLandDiaryItem:OnHide()
end

function UIHomeLandDiaryItem:_AttachEvents()
end

function UIHomeLandDiaryItem:_DetachEvents()
end

function UIHomeLandDiaryItem:BtnOnClick()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  GameGlobal.UIStateManager():Lock("UIHomeLandDiaryItem:BtnOnClick")
  self:StartTask(function(TT)
    self._newGo:SetActive(false)
    local res = homelandModule:HandleHomelandReadedDairyReq(TT, self._data.ID)
    if res:GetSucc() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeLandDiaryGotoPage, self._data.ID)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeStoryFinish, "")
    else
    end
    GameGlobal.UIStateManager():UnLock("UIHomeLandDiaryItem:BtnOnClick")
  end, self)
end
