_class("UIN28AVGStoryShowEvidence", UICustomWidget)
UIN28AVGStoryShowEvidence = UIN28AVGStoryShowEvidence

function UIN28AVGStoryShowEvidence:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
  self.curSelectEvidenceID = nil
end

function UIN28AVGStoryShowEvidence:OnShow()
  self._poolEvidence = self:GetUIComponent("UISelectObjectPath", "poolEvidence")
  self._poolEvidenceTrans = self:GetUIComponent("RectTransform", "poolEvidence")
  self._dialogText = self:GetUIComponent("UILocalizationText", "dialogText")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._infoText = self:GetUIComponent("UILocalizationText", "infoText")
  self._iconRawImage = self:GetUIComponent("RawImageLoader", "iconRawImage")
  self._scrollView = self:GetUIComponent("ScrollRect", "scrollView")
  self._content = self:GetUIComponent("RectTransform", "content")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._arrow = self:GetGameObject("arrow")
  self:AttachEvent(GameEventType.AVGSelectEvidenceItem, self.OnSelectEvidenceItem)
end

function UIN28AVGStoryShowEvidence:OnHide()
  self:DetachEvent(GameEventType.AVGSelectEvidenceItem, self.OnSelectEvidenceItem)
end

function UIN28AVGStoryShowEvidence:Flush(hint, curEvidences, callback)
  self._callback = callback
  local spawnList = self._poolEvidence:SpawnObjects("UIN28AVGStorySelectEvidence", #curEvidences)
  local idx = 1
  local firstEid
  for _, v in pairs(spawnList) do
    local eid = curEvidences[idx]
    firstEid = idx == 1 and eid or firstEid
    local cfg = self:GetEvidenceCfg(eid)
    v:SetData(cfg)
    idx = idx + 1
  end
  self._dialogText:SetText(StringTable.Get(hint))
  self._poolEvidenceTrans.anchoredPosition = Vector2(0, 0)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGSelectEvidenceItem, firstEid, true)
  
  local function flushCallback()
    if 6 < #curEvidences then
      if math.abs(self._poolEvidenceTrans.anchoredPosition.x) > self._poolEvidenceTrans.sizeDelta.x then
        self._arrow:SetActive(false)
      else
        self._arrow:SetActive(true)
      end
    else
      self._arrow:SetActive(false)
    end
  end
  
  self._scrollView.onValueChanged:AddListener(flushCallback)
  flushCallback()
  self:Lock("UIN28AVGStoryShowEvidence_Flush")
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UIN28AVGStoryShowEvidence_Flush")
  end, self)
end

function UIN28AVGStoryShowEvidence:OnSelectEvidenceItem(evidenceID, noAnim)
  if noAnim then
    self._content.anchoredPosition = Vector2(0, 0)
  end
  if self.curSelectEvidenceID == evidenceID then
    return
  end
  local anim = self.curSelectEvidenceID ~= nil and not noAnim
  local isLeft = true
  if anim then
    isLeft = evidenceID < self.curSelectEvidenceID
  end
  self.curSelectEvidenceID = evidenceID
  self:PlayAnim(evidenceID, isLeft, anim)
  self._content.anchoredPosition = Vector2(0, 0)
end

function UIN28AVGStoryShowEvidence:PlayAnim(evidenceID, isLeft, anim)
  local function showInfo()
    local cfg = self:GetEvidenceCfg(evidenceID)
    
    local intro = self:_DoEscape(StringTable.Get(cfg.EvidenceIntro))
    self._titleText:SetText(StringTable.Get(cfg.EvidenceName))
    self._infoText:SetText(intro)
    self._iconRawImage:LoadImage(cfg.EvidenceIcon)
  end
  
  if anim then
    if isLeft then
      self._anim:Play("uieff_UIN28AVGStoryShowEvidence_L_out")
      self:StartTask(function(TT)
        self:Lock("UIN28AVGStoryShowEvidence_PlayAnim")
        YIELD(TT, 200)
        self:UnLock("UIN28AVGStoryShowEvidence_PlayAnim")
        self._anim:Play("uieff_UIN28AVGStoryShowEvidence_L_in")
        showInfo()
      end)
    else
      self._anim:Play("uieff_UIN28AVGStoryShowEvidence_L_out")
      self:StartTask(function(TT)
        self:Lock("UIN28AVGStoryShowEvidence_PlayAnim")
        YIELD(TT, 200)
        self:UnLock("UIN28AVGStoryShowEvidence_PlayAnim")
        self._anim:Play("uieff_UIN28AVGStoryShowEvidence_L_in")
        showInfo()
      end)
    end
  else
    showInfo()
  end
end

function UIN28AVGStoryShowEvidence:BtnOnClick()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIN28AVGStoryShowEvidence_click")
    self:Lock("UIN28AVGStoryShowEvidence_PlayAnim")
    YIELD(TT, 467)
    self:UnLock("UIN28AVGStoryShowEvidence_PlayAnim")
    self._callback(self.curSelectEvidenceID)
  end)
end

function UIN28AVGStoryShowEvidence:GetEvidenceCfg(eid)
  local evidenceCfg = Cfg.cfg_component_avg_evidence({ID = eid})
  if evidenceCfg then
    return evidenceCfg[1]
  end
  return {}
end

function UIN28AVGStoryShowEvidence:GetEvidenceManualCfg(mid)
  local evidenceManualCfg = Cfg.cfg_component_avg_evidence_manual({ID = mid})
  if evidenceManualCfg then
    return evidenceManualCfg[1]
  end
  return {}
end

function UIN28AVGStoryShowEvidence:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end
