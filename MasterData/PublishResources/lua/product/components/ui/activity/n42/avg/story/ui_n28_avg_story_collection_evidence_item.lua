_class("UIN28AVGStoryCollectionEvidenceItem", UICustomWidget)
UIN28AVGStoryCollectionEvidenceItem = UIN28AVGStoryCollectionEvidenceItem

function UIN28AVGStoryCollectionEvidenceItem:OnShow()
  self._selectObj = self:GetGameObject("select")
  self._newObj = self:GetGameObject("new")
  self._lockObj = self:GetGameObject("lock")
  self._lockSelectObj = self:GetGameObject("lockSelect")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._countImageObj = self:GetGameObject("countImage")
  self._iconObj = self:GetGameObject("icon")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:AttachEvent(GameEventType.AVGSelectCollectionEvidenceItem, self.OnSelect)
end

function UIN28AVGStoryCollectionEvidenceItem:OnHide()
  self:DetachEvent(GameEventType.AVGSelectCollectionEvidenceItem, self.OnSelect)
end

function UIN28AVGStoryCollectionEvidenceItem:SetData(type, evidenceList)
  self._type = type
  self._maxCount = #evidenceList
  self._hasCount = 0
  local hasNew = false
  local lastEvidence
  for _, evidence in pairs(evidenceList) do
    if evidence:HasGot() then
      self._hasCount = self._hasCount + 1
      if evidence:HasNew() then
        hasNew = true
      end
      lastEvidence = evidence
    end
  end
  self._newObj:SetActive(hasNew)
  self._countText:SetText(self._hasCount .. "/" .. self._maxCount)
  self._countImageObj:SetActive(self._maxCount > 1)
  if self._hasCount == 0 then
    self._lockObj:SetActive(true)
  else
    self._iconObj:SetActive(true)
    self._icon:LoadImage(lastEvidence.icon)
  end
end

function UIN28AVGStoryCollectionEvidenceItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGSelectCollectionEvidenceItem, self._type)
end

function UIN28AVGStoryCollectionEvidenceItem:OnSelect(selectType)
  if self._hasCount == 0 then
    self._lockSelectObj:SetActive(selectType == self._type)
  end
  if selectType == self._type then
    if not self._selectObj.activeSelf then
      self._selectObj:SetActive(true)
      self._anim:Play("uieff_UIN28AVGStoryCollectionEvidenceItem_select_in")
    end
  elseif self._selectObj.activeSelf then
    self._anim:Play("uieff_UIN28AVGStoryCollectionEvidenceItem_select_out")
    self:Lock("UIN28AVGStoryCollectionEvidenceItem_UnSelect")
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, 200)
      self._selectObj:SetActive(false)
      self:UnLock("UIN28AVGStoryCollectionEvidenceItem_UnSelect")
    end, self)
  end
end
