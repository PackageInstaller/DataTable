_class("UIActivityCN13PerfectPuzzleEntryController", UISideEnterCenterContentBase)
UIActivityCN13PerfectPuzzleEntryController = UIActivityCN13PerfectPuzzleEntryController

function UIActivityCN13PerfectPuzzleEntryController:LoadDataOnEnter(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  if res and res:GetSucc() then
    self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE)
    self.personProcess = self._localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
    self.personProcessInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
    self._questComponent = self._localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
    self.questcmptInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
    self:RefreshRedPoint()
  end
end

function UIActivityCN13PerfectPuzzleEntryController:DoInit()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = self._data
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  self._compoentInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:InitWidget()
  self._lineDatas = {}
  self:_LevelDataClassify()
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self.costId = 3000386
  local curCount = self.itemModule:GetItemCount(self.costId)
  self:AttachEvent(GameEventType.PerfectPuzzleEntryRefresh, self._RefreshUIInfo)
  self.totalPieceCountText:SetText(curCount)
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
    self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE)
    self.personProcess = self._localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
    self.personProcessInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
    self._questComponent = self._localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
    self.questcmptInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
    self:RefreshRedPoint()
  end)
end

function UIActivityCN13PerfectPuzzleEntryController:DoShow(uiParams)
  self.taskId = self:StartTask(function(TT)
    while true do
      self:_OnValue()
      YIELD(TT, 1000)
    end
  end)
end

function UIActivityCN13PerfectPuzzleEntryController:DoHide()
  self:DetachEvent(GameEventType.PerfectPuzzleEntryRefresh)
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UIActivityCN13PerfectPuzzleEntryController:DoDestroy()
  self:DetachEvent(GameEventType.PerfectPuzzleEntryRefresh)
  UIActivityCN13PerfectPuzzleEntryController.super:Dispose()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UIActivityCN13PerfectPuzzleEntryController:InitWidget()
  self.restTimeArea = self:GetGameObject("RestTimeArea")
  self.storyText = self:GetUIComponent("UILocalizationText", "StoryText")
  self.redPoint = self:GetUIComponent("UISelectObjectPath", "RedPoint")
  self.roadPointPool = self:GetUIComponent("UISelectObjectPath", "RoadPointPool")
  self.content = self:GetGameObject("Content")
  self.restTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self.text = self:GetUIComponent("UILocalizationText", "Text")
  self.anim = self:GetGameObject("Anim")
  self.tipGuide = self:GetGameObject("TipGuide")
  self.roadPointGuide = self:GetGameObject("RoadPointGuide")
  self.totalPieceCountText = self:GetUIComponent("UILocalizationText", "TotalPieceCountText")
  self.getPieceRedPointObj = self:GetGameObject("GetPieceRedPoint")
  self.puzzlePlanRedPointObj = self:GetGameObject("PuzzlePlanRedPoint")
  self.rightTop = self:GetUIComponent("RectTransform", "RightTop")
  self.scrollView = self:GetUIComponent("ScrollRect", "Scroll View")
end

function UIActivityCN13PerfectPuzzleEntryController:_OnValue()
  if self.restTimeText then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._endTime
    if curTime < endTime then
      self.restTimeText:SetText(StringTable.Get("str_activity_common_remainingtime_3", "：" .. UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
    else
      self.restTimeText:SetText(StringTable.Get("str_activity_common_state_over"))
    end
    self:_RefreshLevel()
    self:RefreshRedPoint()
  end
end

function UIActivityCN13PerfectPuzzleEntryController:RefreshRedPoint()
  if self._questComponent == nil then
    self.getPieceRedPointObj.gameObject:SetActive(false)
    self.puzzlePlanRedPointObj.gameObject:SetActive(false)
    Log.error("任务组件为空，这种情况不合理吧")
    return
  end
  local questList = self._questComponent:GetQuestInfo()
  local questRed = false
  if self._questComponent:HasQuestCanClaim(questList) then
    questRed = true
  end
  self.getPieceRedPointObj.gameObject:SetActive(questRed)
  local planRed = self.personProcess:HasCanGetReward()
  self.puzzlePlanRedPointObj.gameObject:SetActive(planRed)
end

function UIActivityCN13PerfectPuzzleEntryController:_RefreshUIInfo()
  local curCount = self.itemModule:GetItemCount(self.costId)
  self.totalPieceCountText:SetText(curCount)
  self:_RefreshLevel()
  self:RefreshRedPoint()
  local count = table.count(self._compoentInfo.m_pass_mission_info)
  if count < 1 then
    self.scrollView.horizontalNormalizedPosition = 0
  elseif count == 1 then
    self.scrollView.horizontalNormalizedPosition = 0.46
  elseif count == 2 then
    self.scrollView.horizontalNormalizedPosition = 0.95
  elseif 3 <= count then
    self.scrollView.horizontalNormalizedPosition = 1
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
end

function UIActivityCN13PerfectPuzzleEntryController:AfterUILayerChanged()
  self:_OnValue()
end

function UIActivityCN13PerfectPuzzleEntryController:_LevelDataClassify()
  local cfgs = Cfg.cfg_component_perfect_puzzle({
    ComponentID = self._component:GetComponentCfgId()
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      table.insert(self._lineDatas, cfg)
    end
  end
  table.sort(self._lineDatas, function(a, b)
    return a.MissionID < b.MissionID
  end)
  local count = table.count(self._lineDatas)
  self.roadPointPool:SpawnObjects("UICN13PerfectPuzzleRoadPointItem", count)
  self:_RefreshLevel()
  local count = table.count(self._compoentInfo.m_pass_mission_info)
  if count < 1 then
    self.scrollView.horizontalNormalizedPosition = 0
  elseif count == 1 then
    self.scrollView.horizontalNormalizedPosition = 0.46
  elseif count == 2 then
    self.scrollView.horizontalNormalizedPosition = 0.95
  elseif 3 <= count then
    self.scrollView.horizontalNormalizedPosition = 1
  end
end

function UIActivityCN13PerfectPuzzleEntryController:_RefreshLevel()
  self._nodeWidgets = self.roadPointPool:GetAllSpawnList()
  for i = 1, #self._nodeWidgets do
    self._nodeWidgets[i]:SetData(self._lineDatas[i], i, self._component, self._campaign)
  end
end

function UIActivityCN13PerfectPuzzleEntryController:ActivityTipsbtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    return
  end
  self:ShowDialog("UIIntroLoader", "UIActivityCN13PerfectPuzzleEntryController", MaskType.MT_Default)
end

function UIActivityCN13PerfectPuzzleEntryController:PuzzlePlanBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    return
  end
  self:ShowDialog("UICN13PuzzlePlanPopUp")
end

function UIActivityCN13PerfectPuzzleEntryController:GetPieceBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    return
  end
  self:ShowDialog("UICN13GetPiecePopUp")
end

function UIActivityCN13PerfectPuzzleEntryController:PieceRootOnClick(go)
  local pos = go.transform.position - self.rightTop.transform.position
  UITopTipsContext:PopupTips(self.costId, Vector2(-120, 10), pos)
end
