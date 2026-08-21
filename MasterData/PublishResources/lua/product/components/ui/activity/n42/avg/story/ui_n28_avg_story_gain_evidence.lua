_class("UIN28AVGStoryGainEvidence", UICustomWidget)
UIN28AVGStoryGainEvidence = UIN28AVGStoryGainEvidence

function UIN28AVGStoryGainEvidence:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGStoryGainEvidence:OnShow()
  self._evidenceStateText = self:GetUIComponent("UILocalizationText", "evidenceStateText")
  self._evidenceInfoText = self:GetUIComponent("UILocalizationText", "evidenceInfoText")
  self._evidenceTitleText = self:GetUIComponent("UILocalizationText", "evidenceTitleText")
  self._iconRawImage = self:GetUIComponent("RawImageLoader", "iconRawImage")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._content = self:GetUIComponent("RectTransform", "content")
end

function UIN28AVGStoryGainEvidence:OnHide()
end

function UIN28AVGStoryGainEvidence:Flush(evienceCfg, isAuto, isNewGet, lastEvidenceCfg, callback)
  self._anim:Play("uieff_UIN28AVGStoryGainEvidence_in")
  self.callback = callback
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
  if isNewGet then
    self:Lock("UIN28AVGStoryGainEvidence_GainEvidence")
    self:SetPanel(evienceCfg, "str_avg_n28_evidence_get")
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, 500)
      self:UnLock("UIN28AVGStoryGainEvidence_GainEvidence")
    end, self)
  else
    self:PlayUpdateAnim(evienceCfg, lastEvidenceCfg)
  end
  self._content.anchoredPosition = Vector2(0, 0)
  if isAuto then
    self.callback()
  end
end

function UIN28AVGStoryGainEvidence:SetPanel(cfg, title)
  self._evidenceStateText:SetText(StringTable.Get(title))
  local intro = self:_DoEscape(StringTable.Get(cfg.EvidenceIntro))
  self._evidenceInfoText:SetText(intro)
  self._evidenceTitleText:SetText(StringTable.Get(cfg.EvidenceName))
  self._iconRawImage:LoadImage(cfg.EvidenceIcon)
end

function UIN28AVGStoryGainEvidence:PlayUpdateAnim(evienceCfg, lastEvidenceCfg)
  self:Lock("UIN28AVGStoryGainEvidence_GainEvidence")
  self:SetPanel(lastEvidenceCfg, "str_avg_n28_evidence_update")
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 500)
    self._anim:Play("uieff_UIN28AVGStoryGainEvidence_cut")
    YIELD(TT, 500)
    self:SetPanel(evienceCfg, "str_avg_n28_evidence_update")
    YIELD(TT, 433)
    self:UnLock("UIN28AVGStoryGainEvidence_GainEvidence")
  end, self)
end

function UIN28AVGStoryGainEvidence:BtnOnClick(go)
  self._anim:Play("uieff_UIN28AVGStoryGainEvidence_out")
  self:Lock("UIN28AVGStoryGainEvidence_GainEvidence")
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 933)
    self:UnLock("UIN28AVGStoryGainEvidence_GainEvidence")
    self.callback()
  end, self)
end

function UIN28AVGStoryGainEvidence:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end
