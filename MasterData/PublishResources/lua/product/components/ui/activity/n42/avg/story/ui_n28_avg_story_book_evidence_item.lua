_class("UIN28AVGStoryBookEvidenceItem", UICustomWidget)
UIN28AVGStoryBookEvidenceItem = UIN28AVGStoryBookEvidenceItem

function UIN28AVGStoryBookEvidenceItem:OnShow()
  self._selectObj = self:GetGameObject("select")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self:AttachEvent(GameEventType.AVGSelectBookEvidenceItem, self.OnSelect)
end

function UIN28AVGStoryBookEvidenceItem:OnHide()
  self:DetachEvent(GameEventType.AVGSelectBookEvidenceItem, self.OnSelect)
end

function UIN28AVGStoryBookEvidenceItem:SetData(evidenceID)
  self._id = evidenceID
  local cfg = self:GetEvidenceCfg(evidenceID)
  self._icon:LoadImage(cfg.EvidenceIcon)
end

function UIN28AVGStoryBookEvidenceItem:GetEvidenceCfg(eid)
  local evidenceCfg = Cfg.cfg_component_avg_evidence({ID = eid})
  if evidenceCfg then
    return evidenceCfg[1]
  end
  return {}
end

function UIN28AVGStoryBookEvidenceItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGSelectBookEvidenceItem, self._id)
end

function UIN28AVGStoryBookEvidenceItem:OnSelect(selectID)
  if selectID == self._id then
    if not self._selectObj.activeSelf then
      self._selectObj:SetActive(true)
      self._anim:Play("uieff_UIN28AVGStoryBookEvidenceItem_select_in")
    end
  elseif self._selectObj.activeSelf then
    self._anim:Play("uieff_UIN28AVGStoryBookEvidenceItem_select_out")
    self:Lock("UIN28AVGStoryBookEvidenceItem_OnSelect")
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, 300)
      self._selectObj:SetActive(false)
      self:UnLock("UIN28AVGStoryBookEvidenceItem_OnSelect")
    end, self)
  end
end
