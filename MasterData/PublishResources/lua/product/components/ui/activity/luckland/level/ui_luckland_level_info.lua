_class("UILuckLandLevelInfo", UIController)
UILuckLandLevelInfo = UILuckLandLevelInfo

function UILuckLandLevelInfo:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandLevelInfo:OnShow(uiParams)
  self._cfg = uiParams[1]
  self._clientCfg = uiParams[2]
  self._component = uiParams[3]
  self._componentInfo = self._component:GetComponentInfo()
  LuckLandData:GetInstance():Init(self._clientCfg.ID, self._cfg.ThreeCondDesc, self._component, self._componentInfo)
  self:_InitWidget()
  self:_OnValue()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UILuckLandLevelInfo:AfterUILayerChanged()
  self:_OnValue()
end

function UILuckLandLevelInfo:_InitWidget()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._bestScore = self:GetUIComponent("UILocalizationText", "BestScore")
  self._wordList = self:GetUIComponent("UISelectObjectPath", "WordList")
  self._conditionList = self:GetUIComponent("UISelectObjectPath", "ConditionList")
  self._rewardList = self:GetUIComponent("UISelectObjectPath", "RewardList")
  self._rankBtnGO = self:GetGameObject("RankBtn")
  self._introBgGO = self:GetGameObject("IntroBg")
  self._bestScoreBgGO = self:GetGameObject("BestScoreBg")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandLevelInfo:_OnValue()
  self._name:SetText(StringTable.Get(self._clientCfg.Name))
  self._desc:SetText(StringTable.Get(self._clientCfg.Desc))
  local bestScore = 0
  local passInfo = self._componentInfo.m_pass_mission_info[self._clientCfg.ID]
  if passInfo then
    bestScore = passInfo.record_score
  end
  if bestScore <= 0 then
    self._bestScoreBgGO:SetActive(false)
  end
  self._bestScore:SetText(StringTable.Get("str_luckland_levelinfo_bestscore", bestScore))
  self:_CreateWords()
  self:_CreateConditions()
  self:_CreateRewards()
  self._rankBtnGO:SetActive(self._cfg.Type == LuckLandMissionType.LuckLandMissionType_Rank)
  self._introBgGO:SetActive(false)
end

function UILuckLandLevelInfo:CloseOnClick(go)
  self:Lock("UILuckLandLevelInfo")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UILuckLandLevelInfo_out")
    YIELD(TT, 333)
    self:CloseDialog()
    self:UnLock("UILuckLandLevelInfo")
  end, self)
end

function UILuckLandLevelInfo:CardsBtnOnClick(go)
  LuckLandData:GetInstance():CurCardDatas():Reset(true)
  self:ShowDialog("UILuckLandCardBag", false)
end

function UILuckLandLevelInfo:BuildingsBtnOnClick(go)
  LuckLandData:GetInstance():CurBuildingDatas():Reset()
  self:ShowDialog("UILuckLandBuildings")
end

function UILuckLandLevelInfo:RankBtnOnClick(go)
  self:ShowDialog("UILuckLandRank", self._component, self._clientCfg.ID)
end

function UILuckLandLevelInfo:ChallengeBtnOnClick(go)
  LuckLandData:GetInstance():CurCardDatas():Reset(false)
  LuckLandData:GetInstance():CurBuildingDatas():Reset()
  self:ShowDialog("UILuckLandMainGameController", self._clientCfg.ID)
  self:CloseDialog()
end

function UILuckLandLevelInfo:_CreateWords()
  if self._clientCfg.AffixList then
    local count = table.count(self._clientCfg.AffixList)
    if 0 < count then
      self._wordWidgets = UIWidgetHelper.SpawnObjects(self, "WordList", "UILuckLandWordItem", count)
      for key, wordWidget in ipairs(self._wordWidgets) do
        wordWidget:SetData(key, self._clientCfg.AffixList[key])
      end
    end
  end
end

function UILuckLandLevelInfo:_CreateConditions()
  if self._cfg.ThreeCondDesc then
    local count = table.count(self._cfg.ThreeCondDesc)
    if 0 < count then
      self._conditionWidgets = UIWidgetHelper.SpawnObjects(self, "ConditionList", "UILuckLandConditionItem", count)
      for key, conditionWidget in ipairs(self._conditionWidgets) do
        conditionWidget:SetData(key, self._cfg.ThreeCondDesc[key], self._componentInfo.m_pass_mission_info[self._clientCfg.ID])
      end
    end
  end
end

function UILuckLandLevelInfo:_CreateRewards()
  if self._cfg.Rewards or self._cfg.ThreeRewards then
    local count = 0
    local isPass = self._componentInfo.m_pass_mission_info[self._clientCfg.ID] ~= nil
    if self._cfg.Rewards and not isPass then
      count = table.count(self._cfg.Rewards)
    end
    local threePass = false
    if isPass then
      local passInfo = self._componentInfo.m_pass_mission_info[self._clientCfg.ID]
      if passInfo.star >= 7 then
        threePass = true
      end
    end
    if self._cfg.ThreeRewards and not threePass then
      count = count + table.count(self._cfg.ThreeRewards)
    end
    if 0 < count then
      self._rewardWidgets = UIWidgetHelper.SpawnObjects(self, "RewardList", "UILuckLandRewardItem", count)
      local rewards = {}
      if self._cfg.Rewards and not isPass then
        for i = 1, #self._cfg.Rewards do
          local data = {}
          data.assetid = self._cfg.Rewards[i][1]
          data.count = self._cfg.Rewards[i][2]
          data.type = StageAwardType.First
          rewards[#rewards + 1] = data
        end
      end
      if self._cfg.ThreeRewards and not threePass then
        for i = 1, #self._cfg.ThreeRewards do
          local data = {}
          data.assetid = self._cfg.ThreeRewards[i][1]
          data.count = self._cfg.ThreeRewards[i][2]
          data.type = StageAwardType.Star
          rewards[#rewards + 1] = data
        end
      end
      for key, rewardWidget in ipairs(self._rewardWidgets) do
        rewardWidget:SetData(rewards[key], function(id, pos)
          UIWidgetHelper.SetAwardItemTips(self, "ItemTips", id, pos)
        end)
      end
    end
  end
end

function UILuckLandLevelInfo:IntroBtnOnClick(go)
  self._introBgGO:SetActive(true)
end

function UILuckLandLevelInfo:IntroBgOnClick(go)
  self._introBgGO:SetActive(false)
end
