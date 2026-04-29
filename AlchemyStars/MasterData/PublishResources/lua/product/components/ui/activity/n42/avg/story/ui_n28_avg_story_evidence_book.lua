_class("UIN28AVGStoryEvidenceBook", UIController)
UIN28AVGStoryEvidenceBook = UIN28AVGStoryEvidenceBook

function UIN28AVGStoryEvidenceBook:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
  self._storyManager = self.data:StoryManager()
end

function UIN28AVGStoryEvidenceBook:OnShow(uiParams)
  self._evidenceListCache = uiParams[1]
  self._poolEvidence = self:GetUIComponent("UISelectObjectPath", "poolEvidence")
  self._poolEvidenceTrans = self:GetUIComponent("RectTransform", "poolEvidence")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._infoText = self:GetUIComponent("UILocalizationText", "infoText")
  self._dialogText = self:GetUIComponent("UILocalizationText", "dialogText")
  self._iconRawImage = self:GetUIComponent("RawImageLoader", "iconRawImage")
  self.poolPartners = self:GetUIComponent("UISelectObjectPath", "partners")
  self._scrollView = self:GetUIComponent("ScrollRect", "scrollView")
  self._content = self:GetUIComponent("RectTransform", "content")
  self._arrow = self:GetGameObject("arrow")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:AttachEvent(GameEventType.AVGSelectBookEvidenceItem, self.OnSelectEvidence)
  self:Flush()
  self:FlushActors()
end

function UIN28AVGStoryEvidenceBook:FlushActors()
  local hp, strategies = 0, {}
  hp, strategies = self.data:CalcCurData()
  local len = table.count(self.data.actorPartners)
  self.poolPartners:SpawnObjects("UIN28AVGActor", len)
  local uis = self.poolPartners:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(i, strategies[i] or 0)
  end
end

function UIN28AVGStoryEvidenceBook:OnHide()
  self:DetachEvent(GameEventType.AVGSelectBookEvidenceItem, self.OnSelectEvidence)
end

function UIN28AVGStoryEvidenceBook:Flush()
  local curEvidences = self._evidenceListCache
  self._poolEvidence:SpawnObjects("UIN28AVGStoryBookEvidenceItem", #curEvidences)
  local spawnList = self._poolEvidence:GetAllSpawnList()
  local first
  local idx = 1
  for _, v in pairs(spawnList) do
    first = idx == 1 and curEvidences[idx] or first
    v:SetData(curEvidences[idx])
    idx = idx + 1
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGSelectBookEvidenceItem, first)
  self._poolEvidenceTrans.anchoredPosition = Vector2(0, 0)
  
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
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has("str_avg_n28_notebook_tips_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  local r = math.random(1, n)
  self._dialogText:SetText(StringTable.Get("str_avg_n28_notebook_tips_" .. r))
  self._content.anchoredPosition = Vector2(0, 0)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28AVGShowPanel)
end

function UIN28AVGStoryEvidenceBook:OnSelectEvidence(evidenceID)
  if self.curSelectEvidenceID == evidenceID then
    return
  end
  local anim = self.curSelectEvidenceID ~= nil
  local isLeft = true
  if anim then
    isLeft = evidenceID < self.curSelectEvidenceID
  end
  self.curSelectEvidenceID = evidenceID
  self:PlayAnim(evidenceID, isLeft, anim)
end

function UIN28AVGStoryEvidenceBook:PlayAnim(evidenceID, isLeft, anim)
  local function showInfo()
    local cfg = self:GetEvidenceCfg(evidenceID)
    
    local intro = self:_DoEscape(StringTable.Get(cfg.EvidenceIntro))
    self._titleText:SetText(StringTable.Get(cfg.EvidenceName))
    self._infoText:SetText(intro)
    self._iconRawImage:LoadImage(cfg.EvidenceIcon)
  end
  
  if anim then
    if isLeft then
      self._anim:Play("uieff_UIN28AVGStoryEvidenceBook_L_out")
      self:StartTask(function(TT)
        self:Lock("UIN28AVGStoryEvidenceBook_PlayAnim")
        YIELD(TT, 200)
        self:UnLock("UIN28AVGStoryEvidenceBook_PlayAnim")
        self._anim:Play("uieff_UIN28AVGStoryEvidenceBook_L_in")
        showInfo()
      end)
    else
      self._anim:Play("uieff_UIN28AVGStoryEvidenceBook_L_out")
      self:StartTask(function(TT)
        self:Lock("UIN28AVGStoryEvidenceBook_PlayAnim")
        YIELD(TT, 200)
        self:UnLock("UIN28AVGStoryEvidenceBook_PlayAnim")
        self._anim:Play("uieff_UIN28AVGStoryEvidenceBook_L_in")
        showInfo()
      end)
    end
  else
    showInfo()
  end
end

function UIN28AVGStoryEvidenceBook:BackBtnOnClick()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIN28AVGStoryEvidenceBook_root_out")
    self:Lock("UIN28AVGStoryEvidenceBook_PlayAnim")
    YIELD(TT, 333)
    self:UnLock("UIN28AVGStoryEvidenceBook_PlayAnim")
    self:CloseDialog()
  end)
end

function UIN28AVGStoryEvidenceBook:GetEvidenceCfg(eid)
  local evidenceCfg = Cfg.cfg_component_avg_evidence({ID = eid})
  if evidenceCfg then
    return evidenceCfg[1]
  end
  return {}
end

function UIN28AVGStoryEvidenceBook:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end
