_class("UIN29DetectiveSuspectController", UIController)
UIN29DetectiveSuspectController = UIN29DetectiveSuspectController

function UIN29DetectiveSuspectController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._comp = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._info = self._localProcess:GetComponentInfo(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._curDetectiveInfo = self._info.cur_info
  self._clueList = self._curDetectiveInfo.clue_list
  self._psdId = self._curDetectiveInfo.pstid
end

function UIN29DetectiveSuspectController:OnShow(uiParams, TT)
  self:CheckTime()
  self._Id = uiParams[1]
  self._StageId = uiParams[2]
  self:_GetComponent()
  self:InitData(TT, false)
  self:LoadClue()
  self:_Judge()
  self:CheckGuide()
end

function UIN29DetectiveSuspectController:_GetComponent()
  self._rateText = self:GetUIComponent("UILocalizationText", "rateText")
  self._bagText = self:GetUIComponent("UILocalizationText", "bagText")
  self._tipsText = self:GetUIComponent("UILocalizationText", "tipsText")
  self._topTips = self:GetUIComponent("UILocalizationText", "topTips")
  self._suspicious = self:GetUIComponent("UISelectObjectPath", "Suspicious")
  self._bg = self:GetUIComponent("RawImageLoader", "BG")
  self._tipsOn = self:GetGameObject("tipsOn")
  self._tipsOff = self:GetGameObject("tipsOff")
  self._top = self:GetGameObject("top")
  self._center = self:GetGameObject("center")
  self._rightup = self:GetGameObject("rightup")
  self._searchTips = self:GetGameObject("searchTips")
  self._searchTipsAnim = self:GetUIComponent("Animation", "searchTips")
  self._black = self:GetGameObject("Black")
  self._Anim = self:GetUIComponent("Animation", "Anim")
  self._backBtnObj = self:GetGameObject("backBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:SwitchState(UIStateType.UIActivityN29DetectiveMapController)
  end, nil, nil, true, nil)
  self._black:SetActive(false)
end

function UIN29DetectiveSuspectController:_Judge()
  local cfg_stage = Cfg.cfg_component_detective_stage[self._StageId]
  if UIN29DetectiveHelper.Judge(cfg_stage.ClueList, self._clueList) then
    self:ShowDialog("UIStoryController", cfg_stage.IntroPlot, function()
      self:IntroStoryEnd()
    end)
  end
end

function UIN29DetectiveSuspectController:CheckTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
  local closeTime = self._info.m_close_time
  local isOpen
  if curTime < closeTime then
    isOpen = true
  else
    isOpen = false
  end
  if not isOpen then
    ToastManager.ShowToast(StringTable.Get("str_n24_specialtask_close"))
    self:SwitchState(UIStateType.UIActivityN29MainController)
  end
  return isOpen
end

function UIN29DetectiveSuspectController:InitData(TT, StoryEnd)
  local cfg = Cfg.cfg_n29_detective_search_point_detail[self._Id]
  local cfg_waypoint = Cfg.cfg_component_detective_waypoint[self._Id]
  local suspiciousIds = cfg_waypoint.WaypointContent
  local list = self:GetList(suspiciousIds)
  local cluelist = {}
  for index, value in ipairs(list) do
    local id = Cfg.cfg_component_detective_suspicious[value].ClueId
    table.insert(cluelist, id)
  end
  local bg = cfg.BG
  self._bg:LoadImage(bg)
  local bool, have = UIN29DetectiveHelper.Judge(cluelist, self._clueList)
  local havecount = #have
  local needcount = #list
  local tips = StringTable.Get("str_n29_detective_search_progress", havecount, needcount)
  self._rateText:SetText(tips)
  if havecount == needcount then
    self._Anim:Play("uieff_UIN29DetectiveSuspectController_in")
    self._searchTips:SetActive(false)
    self._topTips:SetText(StringTable.Get("str_n29_detective_toptips_finish"))
  else
    self._topTips:SetText(StringTable.Get("str_n29_detective_toptips_not_finish"))
    self._top:SetActive(false)
    self._rightup:SetActive(false)
    self._backBtnObj:SetActive(false)
    self._searchTips:SetActive(true)
    if not StoryEnd then
      self:PlayEnterAnim(TT)
    end
    self:ShowAllUI()
    self._Anim:Play("uieff_UIN29DetectiveSuspectController_in")
  end
end

function UIN29DetectiveSuspectController:PlayEnterAnim(TT)
  self:Lock("UIN29DetectiveSuspectController")
  self._searchTipsAnim:Play("uieff_UIN29DetectiveSuspectController_search01")
  YIELD(TT, 1100)
  self:UnLock("UIN29DetectiveSuspectController")
end

function UIN29DetectiveSuspectController:LoadClue()
  local cfg_waypoint = Cfg.cfg_component_detective_waypoint[self._Id]
  local suspiciousIds = cfg_waypoint.WaypointContent
  local list = self:GetList(suspiciousIds)
  self._suspicious:SpawnObjects("UIN29DetectiveSuspectClueItem", #list)
  self._allWidgets = self._suspicious:GetAllSpawnList()
  for index, item in pairs(self._allWidgets) do
    local talkItem = self._allWidgets[index]
    talkItem:SetData(list[index], self._clueList, self._psdId, function(StoryID, ClueId)
      self:PlayStory(StoryID, ClueId)
    end, function()
      return self:CheckTime()
    end)
    talkItem:SetPivos()
    local cfg = Cfg.cfg_component_detective_suspicious[list[index]]
    local offset = cfg.Offset
    local size = cfg.Size
    talkItem:SetPosition(offset, size)
  end
end

function UIN29DetectiveSuspectController:GetList(suspiciousIds)
  local cfg_waypoint = Cfg.cfg_component_detective_stage[self._StageId]
  local stageClue = cfg_waypoint.ClueList
  local lastStage = self._StageId - 1
  local list = {}
  for index, Id in ipairs(suspiciousIds) do
    local cfg = Cfg.cfg_component_detective_suspicious[Id]
    local CanGetId = cfg.ClueId
    local needclue = cfg.NeedClue
    if needclue then
      for index, value in ipairs(needclue) do
        if UIN29DetectiveHelper.IsInList(value, self._clueList) and UIN29DetectiveHelper.IsInList(CanGetId, stageClue) then
          table.insert(list, Id)
          break
        end
      end
    elseif UIN29DetectiveHelper.IsInList(CanGetId, stageClue) then
      table.insert(list, Id)
    end
  end
  if #list == 0 then
    if lastStage == 0 then
      return list
    end
    local cfg_waypoint_last = Cfg.cfg_component_detective_stage[lastStage]
    local lastStageClue = cfg_waypoint_last.ClueList
    for index, Id in ipairs(suspiciousIds) do
      local cfg = Cfg.cfg_component_detective_suspicious[Id]
      local CanGetId = cfg.ClueId
      local needclue = cfg.NeedClue
      if needclue then
        for index, value in ipairs(needclue) do
          if UIN29DetectiveHelper.IsInList(value, self._clueList) and UIN29DetectiveHelper.IsInList(CanGetId, lastStageClue) then
            table.insert(list, Id)
            break
          end
        end
      elseif UIN29DetectiveHelper.IsInList(CanGetId, lastStageClue) then
        table.insert(list, Id)
      end
    end
  end
  return list
end

function UIN29DetectiveSuspectController:IntroStoryEnd()
  local cfg_stage = Cfg.cfg_component_detective_stage[self._StageId]
  local storyID = cfg_stage.BeforeReasoningPlot
  local db = UIN29DetectiveLocalDb:New()
  CutsceneManager.ExcuteCutsceneIn("UIN29Detective_Common_Switch", function()
    db:GameIdReasoning(UIN29DetectiveLocalDb.Game_Continue_Reasoning)
    self:ShowDialog("UIStoryController", storyID, function()
      self:HideAllUI()
      self._black:SetActive(true)
      self:ShowDialog("UIN29DetectiveReasoningPopController", self._StageId)
    end)
    CutsceneManager.ExcuteCutsceneOut()
  end)
end

function UIN29DetectiveSuspectController:PlayStory(StoryID, suspiciousId)
  self:CheckTime()
  self:SubmitClue(suspiciousId)
  self:HideAllUI()
  self:ShowDialog("UIStoryController", StoryID, function()
    self:StoryEnd(suspiciousId)
  end)
end

function UIN29DetectiveSuspectController:SubmitClue(suspiciousId)
  GameGlobal.TaskManager():StartTask(self.SubmitClueTask, self, suspiciousId)
end

function UIN29DetectiveSuspectController:SubmitClueTask(TT, suspiciousId)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local info = SubmitClueInfo:New()
  info.type = 1
  info.id = suspiciousId
  local list = {}
  table.insert(list, info)
  self._comp:HandleSubmitItem(TT, res, self._StageId, list, {}, {})
  if res:GetSucc() then
    Log.fatal("成功")
    self:RefreshData()
  else
    Log.fatal("请求失败", res:GetResult())
  end
end

function UIN29DetectiveSuspectController:RefreshData()
  self._curDetectiveInfo = self._info.cur_info
  self._clueList = self._curDetectiveInfo.clue_list
  self._psdId = self._curDetectiveInfo.pstid
  self:LoadClue()
  self:_Judge()
  if self._tipsOn.activeSelf then
    for index, item in pairs(self._allWidgets) do
      local talkItem = self._allWidgets[index]
      talkItem:SetTips(true)
    end
  end
end

function UIN29DetectiveSuspectController:StoryEnd(suspiciousId, TT)
  local cfg_suspect = Cfg.cfg_component_detective_suspicious[suspiciousId]
  local ClueId = cfg_suspect.ClueId
  local StoryEnd = true
  self:ShowDialog("UIN29DetectiveCluePopController", ClueId, UIN29DetectiveType.Suspect, function()
    self:_Judge()
    self:ShowAllUI()
    self:InitData(TT, StoryEnd)
  end)
end

function UIN29DetectiveSuspectController:SetTipsState(bool)
  if bool then
    self._tipsOn:SetActive(true)
    self._tipsOff:SetActive(false)
    self._tipsText:SetText("ON")
  else
    self._tipsOn:SetActive(false)
    self._tipsOff:SetActive(true)
    self._tipsText:SetText("OFF")
  end
end

function UIN29DetectiveSuspectController:OnHide()
end

function UIN29DetectiveSuspectController:ShowAllUI()
  self._top:SetActive(true)
  self._center:SetActive(true)
  self._rightup:SetActive(true)
  self._backBtnObj:SetActive(true)
end

function UIN29DetectiveSuspectController:HideAllUI()
  self._top:SetActive(false)
  self._center:SetActive(false)
  self._rightup:SetActive(false)
  self._backBtnObj:SetActive(false)
end

function UIN29DetectiveSuspectController:BagOnClick()
  self:CheckTime()
  self:ShowDialog("UIActivityN29DetectiveBagController", true, self._curDetectiveInfo, true)
end

function UIN29DetectiveSuspectController:BGOnClick()
  self:CheckTime()
  ToastManager.ShowToast(StringTable.Get("str_n29_detective_not_suspicious_item"))
end

function UIN29DetectiveSuspectController:TipsOnClick()
  self:CheckTime()
  if self.state then
    self.state = false
  else
    self.state = true
  end
  self:SetTipsState(self.state)
  for index, item in pairs(self._allWidgets) do
    local talkItem = self._allWidgets[index]
    talkItem:SetTips(self.state)
  end
end

function UIN29DetectiveSuspectController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN29DetectiveSuspectController)
end
