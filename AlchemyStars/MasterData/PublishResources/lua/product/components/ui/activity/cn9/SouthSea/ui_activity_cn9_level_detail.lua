local CN9SouthSeaRoadType = {Normal = 1, Special = 2}
_enum("CN9SouthSeaRoadType", CN9SouthSeaRoadType)
_class("UIActivityCN9LevelDetail", UIController)
UIActivityCN9LevelDetail = UIActivityCN9LevelDetail

function UIActivityCN9LevelDetail:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityCN9LevelDetail:OnShow(uiParams)
  self._ASheepCom = uiParams[1]
  self._ASheeoComInfo = uiParams[2]
  self._id = uiParams[3]
  self._passmission = uiParams[4]
  self._refreshPoint = uiParams[5]
  self._refreshBookRed = uiParams[6]
  self._BestScore = self._ASheeoComInfo.m_info.m_max_score
  self:InitWidget()
  self:SetDetail()
end

function UIActivityCN9LevelDetail:InitWidget()
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

function UIActivityCN9LevelDetail:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIActivityCN9LevelDetail:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIActivityCN9LevelDetail:SetDetail()
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

function UIActivityCN9LevelDetail:SetNormal()
  self._NormalContent:SpawnObjects("UIACtivityCN9LevelAwardItem", 1)
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
    v:SetData(CN9SouthSeaRoadType.Normal, self._id, pass)
  end
end

function UIActivityCN9LevelDetail:SetSpecial()
  self.SpecialCfg = Cfg.cfg_component_asheep_mission_reward
  self._SpecialContent:SpawnObjects("UIACtivityCN9LevelAwardItem", 3)
  self._SpecialNodes = self._SpecialContent:GetAllSpawnList()
  for i, v in ipairs(self._SpecialNodes) do
    local ScoreLimit = self.SpecialCfg[i].ScoreLimit
    local get
    if ScoreLimit <= self._BestScore then
      get = true
    else
      get = false
    end
    v:SetData(CN9SouthSeaRoadType.Special, i, get)
  end
end

function UIActivityCN9LevelDetail:Refresh(score)
  if self._refreshPoint then
    self._refreshPoint()
  end
  if self.cfg.Type == CN9SouthSeaRoadType.Normal then
    for i, v in ipairs(self._NormalNodes) do
      v:SetPass(true)
    end
  else
    if score > self._BestScore then
      self._BestScoreTxt:SetText(score)
    end
    for i, v in ipairs(self._SpecialNodes) do
      local ScoreLimit = self.SpecialCfg[i].ScoreLimit
      local get
      if score >= ScoreLimit then
        get = true
      else
        get = false
      end
      v:SetPass(get)
    end
  end
end

function UIActivityCN9LevelDetail:CloseBtnOnClick(go)
  self._Anim = self:GetUIComponent("Animation", "Anim")
  local LockName = "UIActivityCN9LevelDetail_AnimOUT"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._Anim:Play("uianim_UIActivityCN9LevelDetail_out")
    YIELD(TT, 500)
    self:CloseDialog()
    self:UnLock(LockName)
  end)
end

function UIActivityCN9LevelDetail:SpecialStartBtnOnClick(go)
  self:StartGame()
end

function UIActivityCN9LevelDetail:NormalStartBtnOnClick(go)
  self:StartGame()
end

function UIActivityCN9LevelDetail:StartGame()
  local bgmid = AudioHelperController.GetCurrentBgm()
  self:ShowDialog(UIStateType.UICN9MainGame, self._MissionID, function(id, score)
    self:OnFinishGame(id, score)
    self:Refresh(score)
  end, bgmid)
end

function UIActivityCN9LevelDetail:OnFinishGame(missionId, score)
  self:StartTask(self.HandleScore, self, missionId, score)
end

function UIActivityCN9LevelDetail:HandleScore(TT, id, score)
  local lockName = "UIActivityCN9LevelDetail:HandleScore"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  local ret, rewards = self._ASheepCom:HandleCompleteASheepMission(TT, res, id, score)
  self:UnLock(lockName)
  if res:GetSucc() then
    self:ShowRewards(rewards)
  else
    Log.error("###[UIActivityCN9LevelDetail] HandleScore fail, result:", res:GetResult())
  end
end

function UIActivityCN9LevelDetail:ShowRewards(rewards)
  if rewards then
    UIActivityHelper.ShowUIGetRewards(rewards, true)
    if self._refreshBookRed then
      self._refreshBookRed()
    end
  end
end
