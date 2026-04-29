_class("UICN16N45SeaNoteLevelDetail", UIController)
UICN16N45SeaNoteLevelDetail = UICN16N45SeaNoteLevelDetail

function UICN16N45SeaNoteLevelDetail:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN16N45SeaNoteLevelDetail:OnShow(uiParams)
  self._ASheepCom = uiParams[1]
  self._ASheeoComInfo = uiParams[2]
  self._id = uiParams[3]
  self._passmission = uiParams[4]
  self._refreshPoint = uiParams[5]
  self._refreshBookRed = uiParams[6]
  self._campaign = uiParams[7]
  self._BestScore = self._ASheeoComInfo.m_info.m_max_score
  self:InitWidget()
  self:SetDetail()
end

function UICN16N45SeaNoteLevelDetail:InitWidget()
  self._SpecialDetail = self:GetGameObject("SpecialDetail")
  self._SpecialContent = self:GetUIComponent("UISelectObjectPath", "SpecialContent")
  self._LevelNameS = self:GetUIComponent("UILocalizationText", "LevelNameS")
  self._BestScoreTxt = self:GetUIComponent("UILocalizationText", "BestScore")
  self._NormalDetail = self:GetGameObject("NormalDetail")
  self._NormalContent = self:GetUIComponent("UISelectObjectPath", "NormalContent")
  self._LevelNameN = self:GetUIComponent("UILocalizationText", "LevelNameN")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UICN16N45SeaNoteLevelDetail:OnHide()
  self.hid = true
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  if self.taskID then
    GameGlobal.TaskManager():KillTask(self.taskID)
    local lockName = "UICN16N45SeaNoteLevelDetail:HandleScore"
    self:UnLock(lockName)
  end
end

function UICN16N45SeaNoteLevelDetail:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UICN16N45SeaNoteLevelDetail:SetDetail()
  self.cfg = Cfg.cfg_component_asheep_mission[self._id]
  local name = self.cfg.MissionName
  self._MissionID = self.cfg.MissionID
  self._LevelNameS:SetText(StringTable.Get(name))
  self._LevelNameN:SetText(StringTable.Get(name))
  if self.cfg.Type == CN9SouthSeaRoadType.Normal then
    self._NormalDetail:SetActive(true)
    self:SetNormal()
  else
    self._BestScoreTxt:SetText(self._BestScore)
    self._SpecialDetail:SetActive(true)
    self:SetSpecial()
  end
end

function UICN16N45SeaNoteLevelDetail:SetNormal()
  self._NormalContent:SpawnObjects("UICN16N45SeaNoteLevelAwardItem", 1)
  local pass
  if not self._passmission then
    pass = false
  else
    for i, v in pairs(self._passmission) do
      if self._MissionID == i then
        pass = true
        break
      else
        pass = false
      end
    end
  end
  self._NormalNodes = self._NormalContent:GetAllSpawnList()
  for i, v in ipairs(self._NormalNodes) do
    v:SetData(CN9SouthSeaRoadType.Normal, self._id, pass, self._MissionID)
  end
end

function UICN16N45SeaNoteLevelDetail:SetSpecial()
  local campaignId = self._ASheepCom:GetComponentCfgId()
  self.SpecialCfg = Cfg.cfg_component_asheep_mission_reward({ComponentID = campaignId})
  self._SpecialContent:SpawnObjects("UICN16N45SeaNoteLevelAwardItem", 3)
  self._SpecialNodes = self._SpecialContent:GetAllSpawnList()
  for i, v in ipairs(self._SpecialNodes) do
    local ScoreLimit = self.SpecialCfg[i].ScoreLimit
    local get
    if ScoreLimit <= self._BestScore then
      get = true
    else
      get = false
    end
    v:SetData(CN9SouthSeaRoadType.Special, i, get, self._MissionID, self._ASheepCom)
  end
end

function UICN16N45SeaNoteLevelDetail:Refresh(score)
  if self._refreshPoint then
    self._refreshPoint()
  end
  if self.cfg.Type == CN9SouthSeaRoadType.Normal then
    for i, v in ipairs(self._NormalNodes) do
      v:SetPass(true)
    end
  else
    if score > self._BestScore then
      self._BestScore = score
      self._BestScoreTxt:SetText(score)
    end
    for i, v in ipairs(self._SpecialNodes) do
      local ScoreLimit = self.SpecialCfg[i].ScoreLimit
      local get
      if score >= ScoreLimit or ScoreLimit <= self._BestScore then
        get = true
      else
        get = false
      end
      v:SetPass(get)
    end
  end
end

function UICN16N45SeaNoteLevelDetail:CloseBtnOnClick(go)
  self._Anim = self:GetUIComponent("Animation", "Anim")
  local LockName = "UICN16N45SeaNoteLevelDetail_AnimOUT"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._Anim:Play("uianim_UICN16N45SeaNoteLevelDetail_out")
    YIELD(TT, 500)
    self:CloseDialog()
    self:UnLock(LockName)
  end)
end

function UICN16N45SeaNoteLevelDetail:CheckActivityEnd()
  local sample = self._campaign:GetSample()
  if sample == nil then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return true
  end
  return false
end

function UICN16N45SeaNoteLevelDetail:CheckClose()
  if not self._campaign:CheckComponentOpen(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP) then
    if GameGlobal.UIStateManager():IsShow("UICN16N45SeaNoteLevelDetail") then
      GameGlobal.UIStateManager():CloseDialog("UICN16N45SeaNoteLevelDetail")
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
end

function UICN16N45SeaNoteLevelDetail:SpecialStartBtnOnClick(go)
  if self:CheckActivityEnd() then
    self:CheckClose()
    return
  end
  self:StartGame()
end

function UICN16N45SeaNoteLevelDetail:NormalStartBtnOnClick(go)
  if self:CheckActivityEnd() then
    self:CheckClose()
    return
  end
  self:StartGame()
end

function UICN16N45SeaNoteLevelDetail:StartGame()
  local bgmid = AudioHelperController.GetCurrentBgm()
  self:ShowDialog("UICN16N45SeaNoteMainGameController", self._MissionID, function(id, score)
    self:OnFinishGame(id, score)
    if self._refreshPoint then
      self._refreshPoint()
    end
  end, bgmid, function()
    if self._refreshPoint then
      self._refreshPoint()
    end
  end)
end

function UICN16N45SeaNoteLevelDetail:OnFinishGame(missionId, score)
  self.taskID = self:StartTask(self.HandleScore, self, missionId, score)
end

function UICN16N45SeaNoteLevelDetail:HandleScore(TT, id, score)
  local lockName = "UICN16N45SeaNoteLevelDetail:HandleScore"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  local ret, rewards = self._ASheepCom:HandleCompleteASheepMission(TT, res, id, score)
  self:UnLock(lockName)
  if res:GetSucc() then
    self:ShowRewards(rewards)
    YIELD(TT, 1000)
    while GameGlobal.UIStateManager():IsShow("UIGetItemController") do
      YIELD(TT)
    end
    self:Lock(lockName)
    YIELD(TT, 500)
    if not self.hid then
      self:Refresh(score)
    end
    self.taskID = nil
  else
    Log.error("###[UICN16N45SeaNoteLevelDetail] HandleScore fail, result:", res:GetResult())
    self.taskID = nil
  end
  YIELD(TT)
  self:UnLock(lockName)
end

function UICN16N45SeaNoteLevelDetail:ShowRewards(rewards)
  if rewards then
    UIActivityHelper.ShowUIGetRewards(rewards, true)
    if self._refreshBookRed then
      self._refreshBookRed()
    end
  end
end
