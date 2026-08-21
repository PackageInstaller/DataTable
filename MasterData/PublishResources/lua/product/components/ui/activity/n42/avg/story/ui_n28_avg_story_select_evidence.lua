_class("UIN28AVGStorySelectEvidence", UICustomWidget)
UIN28AVGStorySelectEvidence = UIN28AVGStorySelectEvidence

function UIN28AVGStorySelectEvidence:OnShow()
  self._selectObj = self:GetGameObject("select")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self:AttachEvent(GameEventType.AVGSelectEvidenceItem, self.OnSelect)
end

function UIN28AVGStorySelectEvidence:OnHide()
  self:DetachEvent(GameEventType.AVGSelectEvidenceItem, self.OnSelect)
end

function UIN28AVGStorySelectEvidence:SetData(evidence)
  self._id = evidence.ID
  self._icon:LoadImage(evidence.EvidenceIcon)
end

function UIN28AVGStorySelectEvidence:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGSelectEvidenceItem, self._id)
end

function UIN28AVGStorySelectEvidence:OnSelect(selectID, noAnim)
  if noAnim then
    if selectID ~= self._id then
      self._selectObj:SetActive(false)
    end
    self:Lock("UIN28AVGStoryBookEvidenceItem_OnSelectNoAnim")
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, 300)
      self:UnLock("UIN28AVGStoryBookEvidenceItem_OnSelectNoAnim")
      self:PlayAnim(selectID)
    end, self)
  else
    self:PlayAnim(selectID, noAnim)
  end
end

function UIN28AVGStorySelectEvidence:PlayAnim(selectID, noAnim)
  if selectID == self._id then
    if not self._selectObj.activeSelf then
      self._selectObj:SetActive(true)
      self._anim:Play("uieff_UIN28AVGStorySelectEvidence_select_in")
    end
  elseif self._selectObj.activeSelf then
    self._anim:Play("uieff_UIN28AVGStorySelectEvidence_select_out")
    self:Lock("UIN28AVGStoryBookEvidenceItem_OnSelect")
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, 300)
      self._selectObj:SetActive(false)
      self:UnLock("UIN28AVGStoryBookEvidenceItem_OnSelect")
    end, self)
  end
end
