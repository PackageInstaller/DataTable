_class("UISummerActivityTwoNormalLevelDetail", UIController)
UISummerActivityTwoNormalLevelDetail = UISummerActivityTwoNormalLevelDetail

function UISummerActivityTwoNormalLevelDetail:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_2, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_3, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_4, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_5, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_6)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._missionComponent = self._localProcess:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
end

function UISummerActivityTwoNormalLevelDetail:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._recommendLV = self:GetUIComponent("UILocalizationText", "recommendLV")
  self._recommendLV2 = self:GetUIComponent("UILocalizationText", "recommendLV2")
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  local enemy = self._enemyMsg:SpawnObject("UIEnemyMsg")
  enemy:SetData(self._levelData:GetFightId())
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self:InitAwards(self._levelData:GetFirstDropId())
  self._ids = {}
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(self._levelData:GetFightId())
  if monsterIDs == nil or #monsterIDs == 0 then
    Log.fatal("[Enemy] 怪物id列表为空")
  else
    local count = table.count(monsterIDs)
    for i = 1, count do
      table.insert(self._ids, monsterIDs[i])
    end
  end
  local type = self._levelData:GetLevelType()
  self._nameLabel.text = self._levelData:GetName()
  self._desLabel.text = self._levelData:GetDes()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:RefreshRecommend()
end

function UISummerActivityTwoNormalLevelDetail:RefreshRecommend()
  local recommendAwaken = self._levelData:GetRecommendAwaken()
  local recommendLV = self._levelData:GetRecommendLV()
  if recommendAwaken == nil or recommendAwaken == 0 then
    self._recommendLV.gameObject:SetActive(false)
  else
    self._recommendLV.gameObject:SetActive(true)
    self._recommendLV:SetText(StringTable.Get("str_pet_config_common_advance") .. "<size=29>" .. recommendAwaken .. "</size>")
  end
  if recommendLV then
    self._recommendLV2:SetText("LV." .. recommendLV)
  end
end

function UISummerActivityTwoNormalLevelDetail:InitAwards(dropId)
  local awards = {}
  local normalArr = self:GetSortedArr(dropId)
  if normalArr then
    for i, v in ipairs(normalArr) do
      awards[#awards + 1] = v
    end
  end
  local count = table.count(awards)
  local sop = self:GetUIComponent("UISelectObjectPath", "Content")
  sop:SpawnObjects("UIAwardItem", count)
  local list = sop:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:Flush(awards[i])
  end
end

function UISummerActivityTwoNormalLevelDetail:GetSortedArr(dropId)
  local list = UICommonHelper:GetInstance():ParseDrop(dropId)
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, UIExtraMissionStageController._LessComparer)
  if list then
    for i, v in ipairs(list) do
      local award = Award:New()
      award:InitWithCount(v.ItemID, v.Count, v.Type)
      award:FlushType(StageAwardType.First)
      vecSort:Insert(award)
    end
  end
  return vecSort.elements
end

function UISummerActivityTwoNormalLevelDetail:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UISummerActivityTwoNormalLevelDetail:MaskOnClick()
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UISummerActivityTwoNormalLevelDetail:StartBattleBtnOnClick()
  local missiontModule = GameGlobal.GetModule(MissionModule)
  local ctx = missiontModule:TeamCtx()
  local param = {
    self._levelData:GetMissionId(),
    self._missionComponent:GetCampaignMissionComponentId(),
    self._missionComponent:GetCampaignMissionParamKeyMap()
  }
  ctx:Init(TeamOpenerType.Campaign, param)
  ctx:ShowDialogUITeams(false)
end

function UISummerActivityTwoNormalLevelDetail:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISummerActivityTwoNormalLevelDetail:CloseCoro(TT)
  self:Lock("UISummerActivityTwoLevelDetail_CloseCoro")
  self._anim:Play("uieff_Summer2_Level_Detail_Out")
  YIELD(TT, 270)
  self:CloseDialog()
  self:UnLock("UISummerActivityTwoLevelDetail_CloseCoro")
end
