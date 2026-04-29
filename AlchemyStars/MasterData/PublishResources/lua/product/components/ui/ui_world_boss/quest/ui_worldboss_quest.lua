_class("UIWorldBossQuest", UIController)
UIWorldBossQuest = UIWorldBossQuest

function UIWorldBossQuest:Constructor()
end

function UIWorldBossQuest:LoadDataOnEnter(TT, res, uiParams)
  self._worldBossModule = self:GetModule(WorldBossModule)
  self._worldBossData = self._worldBossModule.m_world_boss_data
end

function UIWorldBossQuest:OnShow(uiParams)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._questContent = self:GetUIComponent("UISelectObjectPath", "questContent")
  self._safeArea = self:GetUIComponent("Animation", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._eff_dissive1 = self:GetUIComponent("RectTransform", "eff_dissive1")
  self:AttachEvent(GameEventType.UIQuestWorldBossRest, self.OnUIQuestWorldBossRest)
  self:InitCommonTopButton()
  self:EnterFullScreenBg(false)
  self:CreateQuestPool()
  self:FlushQuest(true)
  self:InAnimation()
end

function UIWorldBossQuest:OnHide()
  self:CallUIMethod("UIWorldBossController", "FlushRedQuest")
end

function UIWorldBossQuest:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(false, UIStateType.UIActivityN30MainController, UIStateType.UIMain, nil, self._campaign._id)
  end
end

function UIWorldBossQuest:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local lockName = "UIWorldBossQuest:OutAnimation"
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._eff_dissive1:SetSiblingIndex(1)
      self._animation:Play("UIWorldBossQuest_out")
      YIELD(TT, 733)
      self:UnLock(lockName)
      self:CloseDialog()
    end)
  end, fnHelp, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, nil, false, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIWorldBossQuest:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIWorldBossQuest:CreateQuestPool()
  local idMission = self._worldBossData.boss_mission_id
  local cfg_mission = Cfg.cfg_world_boss_mission[idMission]
  local QuestList
  if cfg_mission ~= nil and cfg_mission.QuestList ~= nil then
    QuestList = cfg_mission.QuestList
  else
    QuestList = {}
  end
  self._dataQuestPool = {}
  self._uiQuestPool = {}
  local questModule = self:GetModule(QuestModule)
  for k, v in pairs(QuestList) do
    local quest = questModule:GetQuest(v)
    local qinfo = quest:QuestInfo()
    table.insert(self._dataQuestPool, qinfo)
  end
  local count = #self._dataQuestPool
  self._uiQuestPool = self._questContent:SpawnObjects("UIWorldBossQuestWidget", count)
end

function UIWorldBossQuest:FlushQuest(reorder, recreateId)
  if reorder then
    local canRecv = 1
    local locked = 2
    local recved = 3
    
    local function fnStateId(status)
      if status == QuestStatus.QUEST_Completed then
        return canRecv
      elseif status == QuestStatus.QUEST_NotStart then
        return locked
      elseif status == QuestStatus.QUEST_Accepted then
        return locked
      elseif status == QuestStatus.QUEST_Taken then
        return recved
      end
    end
    
    table.sort(self._dataQuestPool, function(a, b)
      local stateA = fnStateId(a.status)
      local stateB = fnStateId(b.status)
      if stateA ~= stateB then
        return stateA < stateB
      else
        return a.quest_id < b.quest_id
      end
    end)
  end
  if recreateId ~= nil then
    local questModule = self:GetModule(QuestModule)
    for k, v in pairs(self._dataQuestPool) do
      if v.quest_id == recreateId then
        local quest = questModule:GetQuest(recreateId)
        self._dataQuestPool[k] = quest:QuestInfo()
        break
      end
    end
  end
  for k, v in pairs(self._dataQuestPool) do
    local ui = self._uiQuestPool[k]
    ui:SetData(v)
  end
end

function UIWorldBossQuest:BtnReceiveOnClick(go, cfg)
  local questModule = self:GetModule(QuestModule)
  self:StartTask(function(this, TT)
    local lockName = "UIWorldBossQuest:TakeQuestReward"
    this:Lock(lockName)
    local res = questModule:TakeQuestReward(TT, cfg.quest_id)
    if res:GetSucc() then
      this:FlushQuest(false, cfg.quest_id)
      this:ShowDialog("UIGetItemController", cfg.rewards, function()
      end)
    end
    this:UnLock(lockName)
  end, self)
end

function UIWorldBossQuest:OnShowItemInfo(reward, go)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  self:ShowDialog("UICommonItemInfo", reward, deltaPosition)
end

function UIWorldBossQuest:OnUIQuestWorldBossRest()
  self:CloseDialog()
end

function UIWorldBossQuest:InAnimation()
  local lockName = "UIWorldBossQuest:InAnimation - chgLayer"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("UIWorldBossQuest_in")
    YIELD(TT, 700)
    self._eff_dissive1:SetSiblingIndex(0)
    self:UnLock(lockName)
  end)
  local lockName = "UIWorldBossQuest:InAnimation - Widget_in"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(self._dataQuestPool) do
      local ui = self._uiQuestPool[k]
      ui:GetGameObject():SetActive(false)
    end
    for k, v in pairs(self._dataQuestPool) do
      local ui = self._uiQuestPool[k]
      ui:GetGameObject():SetActive(true)
      ui:PlayAnimation("UIWorldBossQuestWidget_in")
      YIELD(TT, 50)
    end
    self:UnLock(lockName)
  end)
end

_class("UIWorldBossQuestWidget", UICustomWidget)
UIWorldBossQuestWidget = UIWorldBossQuestWidget

function UIWorldBossQuestWidget:Constructor()
  self._cfg = nil
end

function UIWorldBossQuestWidget:OnShow(uiParams)
  self._imgBgLoader = self:GetUIComponent("RawImageLoader", "imgBg")
  self._txtCondition = self:GetUIComponent("UILocalizationText", "txtCondition")
  self._pNumerator = self:GetUIComponent("UILocalizationText", "pNumerator")
  self._pDenominator = self:GetUIComponent("UILocalizationText", "pDenominator")
  self._imgProgress = self:GetUIComponent("Image", "imgProgress")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._stateReceive = self:GetUIComponent("RectTransform", "stateReceive")
  self._stateReceived = self:GetUIComponent("RectTransform", "stateReceived")
  self._stateLocked = self:GetUIComponent("RectTransform", "stateLocked")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIWorldBossQuestWidget:OnHide()
end

function UIWorldBossQuestWidget:BtnReceiveOnClick(go)
  self:RootUIOwner():BtnReceiveOnClick(go, self._cfg)
end

function UIWorldBossQuestWidget:ID()
  return self._cfg.quest_id
end

function UIWorldBossQuestWidget:SetData(cfg)
  self._cfg = cfg
  self._txtCondition:SetText(StringTable.Get(cfg.CondDesc))
  self._pNumerator:SetText(self._cfg.cur_progress)
  self._pDenominator:SetText(string.format("/%d", self._cfg.total_progress))
  self._imgProgress.fillAmount = self._cfg.cur_progress / self._cfg.total_progress
  local countReward = 0
  local cfgRewardList = cfg.rewards
  if cfgRewardList ~= nil then
    countReward = #cfgRewardList
  end
  self._uiRewardPool = self._rewardContent:SpawnObjects("UIWorldBossQuestReward", countReward)
  for i = 1, countReward do
    local ui = self._uiRewardPool[i]
    local data = cfgRewardList[i]
    ui:SetData(data)
  end
  self._stateReceive.gameObject:SetActive(false)
  self._stateReceived.gameObject:SetActive(false)
  self._stateLocked.gameObject:SetActive(false)
  if cfg.status == QuestStatus.QUEST_NotStart or cfg.status == QuestStatus.QUEST_Accepted then
    self._stateLocked.gameObject:SetActive(true)
    self._imgBgLoader:LoadImage("gfworld_task_bar02")
    self._txtCondition.color = Color(0.07450980392156863, 0.027450980392156862, 0.0392156862745098, 1)
    self._pNumerator.color = Color(0.07450980392156863, 0.027450980392156862, 0.0392156862745098, 1)
    self._pDenominator.color = Color(0.07450980392156863, 0.027450980392156862, 0.0392156862745098, 1)
  elseif cfg.status == QuestStatus.QUEST_Completed then
    self._stateReceive.gameObject:SetActive(true)
    self._imgBgLoader:LoadImage("gfworld_task_bar01")
    self._txtCondition.color = Color(0.5607843137254902, 0.21568627450980393, 0.1803921568627451, 1)
    self._pNumerator.color = Color(0.5607843137254902, 0.21568627450980393, 0.1803921568627451, 1)
    self._pDenominator.color = Color(0.3843137254901961, 0.3686274509803922, 0.36470588235294116, 1)
  elseif cfg.status == QuestStatus.QUEST_Taken then
    self._stateReceived.gameObject:SetActive(true)
    self._imgBgLoader:LoadImage("gfworld_task_bar03")
    self._txtCondition.color = Color(0.6078431372549019, 0.5098039215686274, 0.4196078431372549, 1)
    self._pNumerator.color = Color(0.5019607843137255, 0.4980392156862745, 0.4980392156862745, 1)
    self._pDenominator.color = Color(0.5019607843137255, 0.4980392156862745, 0.4980392156862745, 1)
  end
end

function UIWorldBossQuestWidget:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIWorldBossQuestReward", UICustomWidget)
UIWorldBossQuestReward = UIWorldBossQuestReward

function UIWorldBossQuestReward:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._iconImg = self:GetUIComponent("RawImage", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIWorldBossQuestReward:SetData(data)
  self._data = data
  local cfgItem = Cfg.cfg_item[data.assetid]
  if cfgItem ~= nil then
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  self._txtName.gameObject:SetActive(false)
  self._txtCount:SetText(string.format("%d", data.count))
end

function UIWorldBossQuestReward:ButtonOnClick(go)
  self:RootUIOwner():OnShowItemInfo(self._data, go)
end
