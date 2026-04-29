_class("UIN33EightPetsStage", UIController)
UIN33EightPetsStage = UIN33EightPetsStage

function UIN33EightPetsStage:Constructor()
end

function UIN33EightPetsStage:LoadDataOnEnter(TT, res, uiParams)
  self._nodeData = uiParams[1]
  self._eightID = self._nodeData.cfgEight.ID
  self._missionID = self._nodeData.cfgMission.MissionID
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N33_EIGHT_PETS)
  self._eightComponent = self._localProcess:GetComponent(ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION)
  local componentInfo = self._eightComponent:GetComponentInfo()
  self._missionFinishInfo = componentInfo.m_pass_mission_info[self._missionID]
end

function UIN33EightPetsStage:OnShow(uiParams)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:UIWidget()
  self:FlushCommon()
  self:FlushBattleSpecific()
  self:FlushTeamCondition()
  self:FlushEnemy()
  self:FlushRewards()
  self:InAnimation()
end

function UIN33EightPetsStage:OnHide()
end

function UIN33EightPetsStage:BtnAnywhereOnClick(go)
  self:OutAnimation()
end

function UIN33EightPetsStage:BtnRestraintOnClick(go)
  self:ShowDialog("UIStageElemTips")
end

function UIN33EightPetsStage:BtnEnterOnClick(go)
  local param = {
    self._missionID,
    self._eightComponent:GetCampaignMissionComponentId(),
    self._eightComponent:GetCampaignMissionParamKeyMap(),
    self._eightID,
    self._eightID
  }
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  ctx:Init(TeamOpenerType.EightPets, param)
  ctx:SetCurrTeamId(self._eightComponent:GetCurrTeamId())
  ctx:ShowDialogUIN33EightPetsTeams()
end

function UIN33EightPetsStage:UIWidget()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtCondition1 = self:GetUIComponent("UILocalizationText", "txtCondition1")
  self._txtCondition2 = self:GetUIComponent("UILocalizationText", "txtCondition2")
  self._txtCondition3 = self:GetUIComponent("UILocalizationText", "txtCondition3")
  self._txtSpecificValue = self:GetUIComponent("UILocalizationText", "txtSpecificValue")
  self._reLv = self:GetUIComponent("UILocalizationText", "reLv")
  self._information = self:GetUIComponent("UISelectObjectPath", "information")
  self._content = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._safeArea = self:GetUIComponent("RectTransform", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._conditions = {
    {
      uiRoot = self._txtCondition1,
      uiValue = self:GetChildComponent(self._txtCondition1, "UILocalizationText", "imgCondition/Text"),
      uiGray = self:GetUIComponent("Image", "imgCondition1")
    },
    {
      uiRoot = self._txtCondition2,
      uiValue = self:GetChildComponent(self._txtCondition2, "UILocalizationText", "imgCondition/Text"),
      uiGray = self:GetUIComponent("Image", "imgCondition2")
    },
    {
      uiRoot = self._txtCondition3,
      uiValue = self:GetChildComponent(self._txtCondition3, "UILocalizationText", "imgCondition/Text"),
      uiGray = self:GetUIComponent("Image", "imgCondition3")
    }
  }
end

function UIN33EightPetsStage:FlushCommon()
  self._txtTitle:SetText(StringTable.Get(self._nodeData.cfgMission.Name))
  local cfgMission = self._nodeData.cfgMission
  local recommendAwaken = cfgMission.RecommendAwaken and cfgMission.RecommendAwaken or 0
  local recommendLV = cfgMission.RecommendLV and cfgMission.RecommendLV or 0
  local tex = StringTable.Get("str_discovery_node_recommend_lv")
  if recommendAwaken and 0 < recommendAwaken then
    tex = tex .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
  end
  if recommendLV then
    tex = tex .. " LV." .. recommendLV
  end
  self._reLv:SetText(tex)
end

function UIN33EightPetsStage:FlushBattleSpecific()
  local specificValue = ""
  local cfgMission = self._nodeData.cfgMission
  local buff = cfgMission.BaseWordBuff
  if buff ~= nil then
    for k, wordId in pairs(buff) do
      local word = Cfg.cfg_word_buff[wordId]
      if not word then
        Log.exception("cfg_word_buff 中找不到词缀:", wordId, "levelId:", cfgMission.MissionID)
      end
      if word.HideUIType ~= 1 then
        specificValue = specificValue .. StringTable.Get(word.Desc) .. "\r\n"
      end
    end
  end
  if string.isnullorempty(specificValue) then
    specificValue = StringTable.Get("str_n33_ep_d_battle_no_specific")
  end
  self._txtSpecificValue:SetText(specificValue)
end

function UIN33EightPetsStage:FlushTeamCondition()
  for k, v in pairs(self._conditions) do
    v.uiRoot.gameObject:SetActive(false)
  end
  local cfgEight = self._nodeData.cfgEight
  local conditionArray = cfgEight.TeamConditionArray
  if conditionArray == nil then
    local ui = self._conditions[1]
    local conditionValue = StringTable.Get("str_n33_ep_d_team_no_condition")
    ui.uiRoot.gameObject:SetActive(true)
    ui.uiRoot:SetText(conditionValue)
    ui.uiValue:SetText(conditionValue)
  else
    local count = math.min(#conditionArray, #self._conditions)
    for i = 1, count do
      local ui = self._conditions[i]
      local conditionValue = StringTable.Get(conditionArray[i])
      ui.uiRoot.gameObject:SetActive(true)
      ui.uiRoot:SetText(conditionValue)
      ui.uiValue:SetText(conditionValue)
    end
  end
  local totalLines = 0
  for i = 1, #self._conditions do
    local ui = self._conditions[i]
    if ui.uiRoot.gameObject.activeSelf then
      local preferredHeight = ui.uiRoot.preferredHeight
      if preferredHeight <= 30 then
        totalLines = totalLines + 1
      elseif preferredHeight <= 75 then
        totalLines = totalLines + 2
      else
        totalLines = totalLines + 3
      end
    end
  end
  totalLines = math.min(totalLines, #self._conditions)
  local loopMax = #self._conditions
  local loopMin = loopMax - totalLines + 1
  for i = loopMax, loopMin, -1 do
    local ui = self._conditions[i]
    ui.uiGray.gameObject:SetActive(false)
  end
end

function UIN33EightPetsStage:FlushEnemy()
  local cfgMission = self._nodeData.cfgMission
  local levelId = cfgMission.LevelID
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(levelId)
  if monsterIDs == nil or #monsterIDs == 0 then
    local cfg_level = Cfg.cfg_level[levelId]
    if cfg_level then
      monsterIDs = cfg_level.MonsterList
    end
    if monsterIDs == nil or #monsterIDs == 0 then
      Log.fatal("[Enemy] 怪物id列表为空")
      return
    end
  end
  local ids = {}
  local count = table.count(monsterIDs)
  if 5 < count then
    count = 5
  end
  for i = 1, count do
    table.insert(ids, monsterIDs[i])
  end
  local items = self._information:SpawnObjects("UIEnemyItem", #ids)
  for idx, value in pairs(ids) do
    local item = items[idx]
    item:SetData(ids[idx], idx, function(idx)
      GameGlobal.UAReportForceGuideEvent("UIStageClick", {
        "EnemyInfo_" .. idx
      }, true)
      self:ShowDialog("UIEnemyTip", ids, idx)
    end)
  end
end

function UIN33EightPetsStage:FlushRewards()
  local cfgMission = self._nodeData.cfgMission
  local awards, len = self:ProcessAward(cfgMission)
  if not awards then
    return
  end
  self._widgetRewards = self._content:SpawnObjects("UIN33EightPetsStageReward", len)
  local widgetIndex = 1
  for k, v in pairs(awards) do
    local awardType = v.awardType
    local dataList = v.dataList
    for tmp, subAwardData in pairs(dataList) do
      local subWidget = self._widgetRewards[widgetIndex]
      widgetIndex = widgetIndex + 1
      subWidget:SetData(subAwardData, awardType, function(rewardItemId, go)
        self:OnShowItemInfo(rewardItemId, go)
      end)
    end
  end
end

function UIN33EightPetsStage:ProcessAward(cfgMission)
  local awards = {}
  local len = 0
  if not self:HasPassThreeStar(cfgMission) then
    local list = UICommonHelper:GetInstance():GetDropByAwardType(AwardType.ThreeStar, cfgMission)
    local cfg = {}
    cfg.awardType = AwardType.ThreeStar
    cfg.dataList = list
    table.insert(awards, cfg)
    len = #list + len
  end
  if not self._missionFinishInfo then
    local list = UICommonHelper:GetInstance():GetDropByAwardType(AwardType.First, cfgMission)
    local cfg = {}
    cfg.awardType = AwardType.First
    cfg.dataList = list
    table.insert(awards, cfg)
    len = #list + len
  end
  return awards, len
end

function UIN33EightPetsStage:HasPassThreeStar(cfgMission)
  if not self._missionFinishInfo then
    return false
  end
  if cfgMission.ThreeStarCondition1 and self._missionFinishInfo.star & 1 == 0 then
    return false
  end
  if cfgMission.ThreeStarCondition2 and self._missionFinishInfo.star & 2 == 0 then
    return false
  end
  if cfgMission.ThreeStarCondition3 and self._missionFinishInfo.star & 4 == 0 then
    return false
  end
  return true
end

function UIN33EightPetsStage:GetSortedArr(awardType, cfg, stageAwardType)
  local list = UICommonHelper:GetInstance():GetDropByAwardType(awardType, cfg)
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, DiscoveryStage._LessComparer)
  if list then
    for i, v in ipairs(list) do
      local award = Award:New()
      award:InitWithCount(v.ItemID, v.Count, v.Type)
      award:FlushType(stageAwardType)
      vecSort:Insert(award)
    end
  end
  return vecSort.elements
end

function UIN33EightPetsStage:OnShowItemInfo(itemId, go)
  if not self._itemInfo then
    local pool = self:GetUIComponent("UISelectObjectPath", "itemInfo")
    self._itemInfo = pool:SpawnObject("UISelectInfo")
  end
  self._itemInfo:SetData(itemId, go.transform.position)
end

function UIN33EightPetsStage:OnActivityCloseEvent(id)
  local componentInfo = self._eightComponent:GetComponentInfo()
  if componentInfo and componentInfo.m_campaign_id == id then
    self:CloseDialog()
  end
end

function UIN33EightPetsStage:InAnimation()
  local lockName = "UIN33EightPetsStage:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("effanim_UIN33EightPetsStage_in")
    YIELD(TT, 400)
    self:UnLock(lockName)
  end)
end

function UIN33EightPetsStage:OutAnimation(cbFinish)
  self:CloseDialog()
  local lockName = "UIN33EightPetsStage:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN33EightPetsStage_out")
    YIELD(TT, 200)
    self:CloseDialog()
    self:UnLock(lockName)
    if cbFinish then
      cbFinish()
    end
  end)
end
