_class("UILuckLandGameSucPopUp", UIController)
UILuckLandGameSucPopUp = UILuckLandGameSucPopUp

function UILuckLandGameSucPopUp:LoadDataOnEnter(TT, res)
  self._component = LuckLandData:GetInstance():CurLuckLandCmpt()
  local curMoney = LuckLandInnerGameHelper.GetCurMoney()
  local curHp, maxHp = LuckLandInnerGameHelper.GetCurHP()
  local buildsData = LuckLandInnerGameHelper.GetBuildingsData()
  local missionid = LuckLandData:GetInstance():GetCurMissionID()
  local per = curHp / maxHp
  local hpPercent = math.ceil(per * 100)
  if curMoney == 0 then
    curMoney = 1
  end
  self._rewards = {}
  self._result = nil
  local a, firstPassRewards, result, threeStarRewards = self._component:HandleCompleteLuckLandMission(TT, res, missionid, curMoney, curHp, buildsData)
  self._result = result
  if res:GetSucc() then
    if firstPassRewards then
      for i = 1, #firstPassRewards do
        local data = {}
        data.assetid = firstPassRewards[i].assetid
        data.count = firstPassRewards[i].count
        data.type = StageAwardType.First
        self._rewards[#self._rewards + 1] = data
      end
    end
    if threeStarRewards then
      for i = 1, #threeStarRewards do
        local data = {}
        data.assetid = threeStarRewards[i].assetid
        data.count = threeStarRewards[i].count
        data.type = StageAwardType.Star
        self._rewards[#self._rewards + 1] = data
      end
    end
  else
    self:GetModule(CampaignModule):ShowErrorToast(res.m_result, true)
    self:SwitchState(UIStateType.UIMain)
  end
end

function UILuckLandGameSucPopUp:OnShow(uiParams)
  self:InitWidget()
  self:InitUI(self._rewards, self._result)
end

function UILuckLandGameSucPopUp:InitWidget()
  self._animObj = self:GetGameObject("_anim")
  self.titleText = self:GetUIComponent("UILocalizedTMP", "TitleText")
  self.scoreText = self:GetUIComponent("UILocalizedTMP", "ScoreText")
  self.missionNameText = self:GetUIComponent("UILocalizationText", "MissionNameText")
  self.missionStarArea = self:GetUIComponent("UISelectObjectPath", "MissionStarArea")
  self.missionItemArea = self:GetUIComponent("UISelectObjectPath", "MissionItemArea")
  self.missionScoreArea = self:GetUIComponent("UISelectObjectPath", "MissionScoreArea")
  self.missionItemAreaObj = self:GetGameObject("ItemRoot")
  self._anim = self:GetUIComponent("Animation", "_anim")
end

function UILuckLandGameSucPopUp:InitUI(reawards, result)
  local threeCondDesc = LuckLandData:GetInstance():CurThreeDecData()
  local infocmpt = LuckLandData:GetInstance():CurLuckLandInfoCmpt()
  local id = LuckLandData:GetInstance():GetCurMissionID()
  self._missionCfg = Cfg.cfg_luckland_client_mission[id]
  self.missionNameText:SetText(StringTable.Get(self._missionCfg.Name))
  if threeCondDesc then
    local count = table.count(threeCondDesc)
    if 0 < count then
      self._conditionWidgets = UIWidgetHelper.SpawnObjects(self, "MissionStarArea", "UILuckLandConditionItem", count)
      for key, conditionWidget in ipairs(self._conditionWidgets) do
        conditionWidget:SetData(key, threeCondDesc[key], infocmpt.m_pass_mission_info[id], true)
        conditionWidget.view:GetGameObject():SetActive(false)
      end
    end
  end
  for i = 1, #self._conditionWidgets do
    GameGlobal.Timer():AddEvent(50 * (i - 1), function()
      local item = self._conditionWidgets[i]
      item.view:GetGameObject():SetActive(true)
    end)
  end
  self.gameTable = {}
  self.gameTable[1] = "str_luckland_money_score"
  self.gameTable[2] = "str_luckland_build_score"
  self.gameTable[3] = "str_luckland_hp_score"
  local score = {}
  score[1] = "+" .. result.money_score
  score[2] = "+" .. result.build_score
  score[3] = "+" .. result.hp_prop
  local lastScore = result.total_score
  self.scoreText:SetText("" .. lastScore)
  self._gameScoreWidgets = UIWidgetHelper.SpawnObjects(self, "MissionScoreArea", "UILuckLandEndScoreItem", 3)
  for i = 1, #self._gameScoreWidgets do
    local item = self._gameScoreWidgets[i]
    local str = self.gameTable[i]
    item:SetData(str, score[i])
    item.view:GetGameObject():SetActive(false)
  end
  for i = 1, #self._gameScoreWidgets do
    GameGlobal.Timer():AddEvent(50 * (i - 1), function()
      local item = self._gameScoreWidgets[i]
      item.view:GetGameObject():SetActive(true)
    end)
  end
  if 0 < #reawards then
    self._rewardWidgets = UIWidgetHelper.SpawnObjects(self, "MissionItemArea", "UILuckLandRewardItem", #reawards)
    for key, rewardWidget in ipairs(self._rewardWidgets) do
      rewardWidget:SetData(reawards[key], function(id, pos)
        UIWidgetHelper.SetAwardItemTips(self, "ItemTips", id, pos)
      end)
    end
  else
    self.missionItemAreaObj:SetActive(false)
  end
  self._anim:Play("uieff_UILuckLandGameSucPopUp_in")
end

function UILuckLandGameSucPopUp:BgOnClick(go)
  GameGlobal.UIStateManager():CloseDialog("UILuckLandMainGameController")
  GameGlobal.UIStateManager():CloseDialog("UILuckLandLevelInfo")
  self._anim:Play("uieff_UILuckLandGameSucPopUp_out")
  GameGlobal.Timer():AddEvent(270, function()
    self:CloseDialog()
  end)
end

function UILuckLandGameSucPopUp:DetailBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UILuckLandGameSucPopUp")
end
