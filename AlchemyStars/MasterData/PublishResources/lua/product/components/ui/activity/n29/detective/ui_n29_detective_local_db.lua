_class("UIN29DetectiveLocalDb", Object)
UIN29DetectiveLocalDb = UIN29DetectiveLocalDb

function UIN29DetectiveLocalDb:Constructor()
  self:CreateType()
  self:InitDetectiveComponent()
  self._game = {
    key = self:GetDBGameKey(),
    value = self:DefaultGameValue()
  }
  self._viewed = {
    [self._idEndCG] = {
      key = self:GetDBEndCGKey(),
      value = {}
    },
    [self._idMemory] = {
      key = self:GetDBMemoryKey(),
      value = {}
    },
    [self._idAchieve] = {
      key = self:GetDBAchieveKey(),
      value = {}
    }
  }
  self._enableAchieveTitleReddot = false
end

function UIN29DetectiveLocalDb:CreateType()
  UIN29DetectiveLocalDb._idEndCG = 1
  UIN29DetectiveLocalDb._idMemory = 2
  UIN29DetectiveLocalDb._idAchieve = 3
  UIN29DetectiveLocalDb.Game_Continue = 1
  UIN29DetectiveLocalDb.Game_Continue_Reasoning = 2
  UIN29DetectiveLocalDb.Game_Continue_ReasoningPlot = 3
  UIN29DetectiveLocalDb.Game_Continue_Ending = 4
  UIN29DetectiveLocalDb.Game_New = 10
  UIN29DetectiveLocalDb.Game_Archive = 20
end

function UIN29DetectiveLocalDb:DefaultGameValue()
  return {
    pstid = 0,
    idReasoning = self.Game_Continue
  }
end

function UIN29DetectiveLocalDb:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function UIN29DetectiveLocalDb:InitDetectiveComponent()
  local campaignModule = self:GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N29)
  self._detectiveComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._questComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_QUEST)
end

function UIN29DetectiveLocalDb:DetectiveComponent()
  return self._detectiveComponent
end

function UIN29DetectiveLocalDb:QuestComponent()
  return self._questComponent
end

function UIN29DetectiveLocalDb:GetDBGameKey()
  local key = "UIN29DetectiveLocalDb::PlayGame"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UIN29DetectiveLocalDb:GetDBEndCGKey()
  local key = "UIN29DetectiveLocalDb::EndCG"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UIN29DetectiveLocalDb:GetDBMemoryKey()
  local key = "UIN29DetectiveLocalDb::Memory"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UIN29DetectiveLocalDb:GetDBAchieveKey()
  local key = "UIN29DetectiveLocalDb::Achieve"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UIN29DetectiveLocalDb:GameLoadDB()
  local content = LocalDB.GetString(self._game.key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  for k, v in pairs(dbData) do
    self._game.value[k] = v
  end
end

function UIN29DetectiveLocalDb:GameSaveDB()
  local content = ""
  for k, v in pairs(self._game.value) do
    content = content .. string.format("%s = %s,", k, v)
  end
  LocalDB.SetString(self._game.key, content)
end

function UIN29DetectiveLocalDb:GameIdReasoning(idReasoning)
  local componentInfo = self._detectiveComponent:GetComponentInfo()
  local pstid = componentInfo.cur_info.pstid
  self._game.value.pstid = pstid
  self._game.value.idReasoning = idReasoning
  self:GameSaveDB()
end

function UIN29DetectiveLocalDb:PrivateViewedLoadDB(sheetID)
  local viewed = self._viewed[sheetID]
  local content = LocalDB.GetString(viewed.key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  for k, v in pairs(dbData) do
    viewed.value[v] = v
  end
end

function UIN29DetectiveLocalDb:PrivateViewedSaveDB(sheetID)
  local viewed = self._viewed[sheetID]
  local content = ""
  for k, v in pairs(viewed.value) do
    content = content .. string.format("%d, ", v)
  end
  LocalDB.SetString(viewed.key, content)
end

function UIN29DetectiveLocalDb:ViewedLoadDB()
  self:FlushUnlocked()
  self:PrivateViewedLoadDB(self._idEndCG)
  self:PrivateViewedLoadDB(self._idMemory)
  self:PrivateViewedLoadDB(self._idAchieve)
end

function UIN29DetectiveLocalDb:ViewedSaveDB()
  self:PrivateViewedSaveDB(self._idEndCG)
  self:PrivateViewedSaveDB(self._idMemory)
  self:PrivateViewedSaveDB(self._idAchieve)
end

function UIN29DetectiveLocalDb:ClearDB()
  for k, v in pairs(self._viewed) do
    v.value = {}
  end
  self:PrivateViewedSaveDB(self._idEndCG)
  self:PrivateViewedSaveDB(self._idMemory)
  self:PrivateViewedSaveDB(self._idAchieve)
  self._game.value = self:DefaultGameValue()
  self:GameSaveDB()
end

function UIN29DetectiveLocalDb:ViewedClearNew()
  local fnUnlock = {
    [self._idEndCG] = self.GetEndCGUnlocked,
    [self._idMemory] = self.GetMemoryUnlocked,
    [self._idAchieve] = self.GetAchieveUnlocked
  }
  for k, v in pairs(self._viewed) do
    local value = v.value
    local unlocked = fnUnlock[k](self)
    for k, v in pairs(unlocked) do
      value[k] = k
    end
  end
  self:PrivateViewedSaveDB(self._idEndCG)
  self:PrivateViewedSaveDB(self._idMemory)
  self:PrivateViewedSaveDB(self._idAchieve)
end

function UIN29DetectiveLocalDb:AddViewed(sheetID, id, autoSaved)
  local viewed = self._viewed[sheetID]
  viewed.value[id] = id
  if autoSaved then
    self:ViewedSaveDB(sheetID)
  end
end

function UIN29DetectiveLocalDb:AddViewedEngCG(id, autoSaved)
  local unlocked = self:GetEndCGUnlocked()
  if unlocked[id] ~= nil then
    self:AddViewed(self._idEndCG, id, autoSaved)
  end
end

function UIN29DetectiveLocalDb:AddViewedMemory(id, autoSaved)
  local unlocked = self:GetMemoryUnlocked()
  if unlocked[id] ~= nil then
    self:AddViewed(self._idMemory, id, autoSaved)
  end
end

function UIN29DetectiveLocalDb:AddViewedAchieve(id, autoSaved)
  local unlocked = self:GetAchieveUnlocked()
  if unlocked[id] ~= nil then
    self:AddViewed(self._idAchieve, id, autoSaved)
  end
end

function UIN29DetectiveLocalDb:FlushUnlocked()
  self._unlockedEnding = {}
  local infoComponent = self._detectiveComponent:GetComponentInfo()
  for k, v in pairs(infoComponent.cg_list) do
    self._unlockedEnding[v] = v
  end
  self._unlockedMemory = {}
  self._unlockedAchieve = {}
  local questModule = self:GetModule(QuestModule)
  local infoComponent = self._questComponent:GetComponentInfo()
  for k, v in pairs(infoComponent.m_accept_cam_quest_list) do
    local quest = questModule:GetQuest(v)
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      self._unlockedAchieve[v] = v
    elseif qinfo.status == QuestStatus.QUEST_Taken then
      self._unlockedAchieve[v] = v
    end
  end
end

function UIN29DetectiveLocalDb:FlushUnlocked_TestCase()
  self._unlockedEnding = {
    [42] = 42
  }
  self._unlockedMemory = {}
  self._unlockedAchieve = {
    [3570054] = 3570054
  }
end

function UIN29DetectiveLocalDb:GetEndCGUnlocked()
  return self._unlockedEnding
end

function UIN29DetectiveLocalDb:GetMemoryUnlocked()
  return self._unlockedMemory
end

function UIN29DetectiveLocalDb:GetAchieveUnlocked()
  return self._unlockedAchieve
end

function UIN29DetectiveLocalDb:GetEndCGReddot()
  local allEnding = self:GetAllEnding()
  for k, v in pairs(allEnding) do
    if self:GetEndCGTitleReddot(v.CgId) then
      return true
    end
  end
  return false
end

function UIN29DetectiveLocalDb:GetMemoryReddot()
  return false
end

function UIN29DetectiveLocalDb:GetAchieveReddot()
  local infoComponent = self._questComponent:GetComponentInfo()
  for k, v in pairs(infoComponent.m_accept_cam_quest_list) do
    if self:GetAchieveTitleReddot(v) then
      return true
    elseif self:GetAchieveRewardReddot(v) then
      return true
    end
  end
  return false
end

function UIN29DetectiveLocalDb:GetEndCGTitleReddot(id)
  local unlocked = self:GetEndCGUnlocked()
  if unlocked[id] == nil then
    return false
  end
  local viewed = self._viewed[self._idEndCG]
  return viewed.value[id] == nil
end

function UIN29DetectiveLocalDb:GetAchieveTitleReddot(id)
  if not self._enableAchieveTitleReddot then
    return false
  end
  local questModule = self:GetModule(QuestModule)
  local quest = questModule:GetQuest(id)
  local unlocked = self:GetAchieveUnlocked()
  if unlocked[id] == nil then
    return false
  elseif quest:Status() == QuestStatus.QUEST_Taken then
    return false
  end
  local viewed = self._viewed[self._idAchieve]
  return viewed.value[id] == nil
end

function UIN29DetectiveLocalDb:GetAchieveRewardReddot(id)
  local questModule = self:GetModule(QuestModule)
  local quest = questModule:GetQuest(id)
  local unlocked = self:GetAchieveUnlocked()
  if unlocked[id] == nil then
    return false
  end
  return quest:Status() == QuestStatus.QUEST_Completed
end

function UIN29DetectiveLocalDb:GetAllStage()
  local idComponent = self._detectiveComponent:GetComponentCfgId()
  local allStage = Cfg.cfg_component_detective_stage({})
  local retCfg = {}
  for k, v in pairs(allStage) do
    if v.ComponentID == idComponent then
      retCfg[k] = v
    end
  end
  return retCfg
end

function UIN29DetectiveLocalDb:GetAllEnding()
  local idComponent = self._detectiveComponent:GetComponentCfgId()
  local allEnding = Cfg.cfg_component_detective_ending({})
  local retCfg = {}
  for k, v in pairs(allEnding) do
    if v.ComponentID == idComponent then
      retCfg[k] = v
    end
  end
  return retCfg
end

function UIN29DetectiveLocalDb:AllClueAndFragment()
  local dicClue = {}
  local dicFragment = {}
  local allStage = self:GetAllStage()
  for k, v in pairs(allStage) do
    if v.ClueFree ~= nil then
      for ks, vs in pairs(v.ClueFree) do
        dicClue[vs] = vs
      end
    end
    if v.ClueList ~= nil then
      for ks, vs in pairs(v.ClueList) do
        dicClue[vs] = vs
      end
    end
    if v.FragmentList ~= nil then
      for ks, vs in pairs(v.FragmentList) do
        dicFragment[vs] = vs
      end
    end
  end
  return dicClue, dicFragment
end

function UIN29DetectiveLocalDb:ArchiveLoadData()
  local loadData = CurDetectiveInfo:New()
  local idEndStage = 0
  local allStage = self:GetAllStage()
  for k, v in pairs(allStage) do
    idEndStage = k
  end
  local allWayPoint = Cfg.cfg_component_detective_waypoint({})
  local selectedWayPoint = {}
  local allStage = self:GetAllStage()
  for k, v in pairs(allStage) do
    if v.ClueFree ~= nil then
      for ks, vs in pairs(v.ClueFree) do
        loadData.clue_list[vs] = vs
      end
    end
    if v.ClueList ~= nil then
      for ks, vs in pairs(v.ClueList) do
        loadData.clue_list[vs] = vs
      end
    end
    if v.FragmentList ~= nil and k ~= idEndStage then
      for ks, vs in pairs(v.FragmentList) do
        loadData.fragment_list[vs] = vs
      end
    end
    if v.Waypoint ~= nil then
      for ks, vs in pairs(v.Waypoint) do
        local cfg = allWayPoint[vs]
        if cfg.Type == 2 then
          selectedWayPoint[vs] = cfg
        end
      end
    end
  end
  local allTalk = Cfg.cfg_component_detective_talk({})
  for k, v in pairs(selectedWayPoint) do
    if v.WaypointContent ~= nil then
      for ks, vs in pairs(v.WaypointContent) do
        local cfg = allTalk[vs]
        if cfg.NeedClue ~= nil then
          loadData.talk_list[vs] = vs
        end
      end
    end
  end
  loadData.clue_list = self:ToList(loadData.clue_list, true)
  loadData.fragment_list = self:ToList(loadData.fragment_list, true)
  loadData.talk_list = self:ToList(loadData.talk_list, true)
  return loadData
end

function UIN29DetectiveLocalDb:ToList(dic, inSort)
  local lst = {}
  for k, v in pairs(dic) do
    table.insert(lst, v)
  end
  if inSort then
    table.sort(lst, function(a, b)
      return a < b
    end)
  end
  return lst
end

function UIN29DetectiveLocalDb:BreakIdStage()
  return self._idStage
end

function UIN29DetectiveLocalDb:BreakIdReasoning()
  return self._idReasoning
end

function UIN29DetectiveLocalDb:BreakPosition()
  local componentInfo = self._detectiveComponent:GetComponentInfo()
  local breakInfo = componentInfo.cur_info
  local dicClue = {}
  for k, v in pairs(breakInfo.clue_list) do
    dicClue[v] = v
  end
  local dicFragment = {}
  for k, v in pairs(breakInfo.fragment_list) do
    dicFragment[v] = v
  end
  local idEndStage = 0
  local allStage = self:GetAllStage()
  for k, v in pairs(allStage) do
    idEndStage = k
  end
  local idStage = 0
  local idReasoning = self.Game_Continue
  local allStage = self:GetAllStage()
  for k, v in pairs(allStage) do
    idStage = k
    local getAllCule = true
    if v.ClueList ~= nil then
      for ks, vs in pairs(v.ClueList) do
        if dicClue[vs] == nil then
          getAllCule = false
          break
        end
      end
    end
    local getAllFragment = true
    if v.FragmentList ~= nil then
      for ks, vs in pairs(v.FragmentList) do
        if dicFragment[vs] == nil then
          getAllFragment = false
          break
        end
      end
    end
    if not getAllCule then
      idReasoning = self.Game_Continue
      break
    elseif getAllCule and not getAllFragment then
      if breakInfo.pstid == self._game.value.pstid then
        idReasoning = math.min(self.Game_Continue_Reasoning, self._game.value.idReasoning)
        break
      end
      idReasoning = self.Game_Continue
      break
    elseif idStage == idEndStage and getAllCule and getAllFragment then
      if breakInfo.pstid == self._game.value.pstid then
        idReasoning = math.max(self.Game_Continue_ReasoningPlot, self._game.value.idReasoning)
      else
        idReasoning = self.Game_Continue_ReasoningPlot
      end
    end
  end
  self._idStage = idStage
  self._idReasoning = idReasoning
  return idStage, idReasoning
end

function UIN29DetectiveLocalDb:ExistBreak()
  if self._idReasoning == nil then
    self:BreakPosition()
  end
  local componentInfo = self._detectiveComponent:GetComponentInfo()
  local breakLoad = componentInfo.cur_info.pstid ~= 0
  if not breakLoad then
    return false
  end
  if self._idReasoning == self.Game_Continue_Ending then
    return false
  end
  return true
end

function UIN29DetectiveLocalDb:ShowDialog(uiName, ...)
  GameGlobal.UIStateManager():ShowDialog(uiName, ...)
end

function UIN29DetectiveLocalDb:StartTask(func, ...)
  return GameGlobal.TaskManager():StartTask(func, ...)
end

function UIN29DetectiveLocalDb:Lock(name)
  GameGlobal.UIStateManager():Lock(name)
end

function UIN29DetectiveLocalDb:UnLock(name)
  GameGlobal.UIStateManager():UnLock(name)
end

function UIN29DetectiveLocalDb:SwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():SwitchState(uiStateType, ...)
end

function UIN29DetectiveLocalDb:AfterReasoningPlot(idPlot, isEndPlot, fnNormal, fnEnd)
  local eventUIOpen, eventChooseOption
  if isEndPlot then
    eventUIOpen = GameHelper:GetInstance():CreateCallback(self.OnStoryUIOpen, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIOpen, eventUIOpen)
    eventChooseOption = GameHelper:GetInstance():CreateCallback(self.OnStoryChooseOption, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.StoryChooseOption, eventChooseOption)
  end
  self:ShowDialog("UIStoryController", idPlot, function()
    if isEndPlot then
      GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIOpen, eventUIOpen)
      GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.StoryChooseOption, eventChooseOption)
      if fnEnd ~= nil then
        fnEnd()
      end
    elseif fnNormal ~= nil then
      fnNormal()
    end
  end)
end

function UIN29DetectiveLocalDb:OnStoryUIOpen(uiName)
  local uiStateManager = GameGlobal.UIStateManager()
  local uiController = uiStateManager:GetController(uiName)
  if uiController ~= nil then
    uiController:SetSkipToOptions(true)
  end
end

function UIN29DetectiveLocalDb:OnStoryChooseOption(index, storyManager)
  local idEndPlot = 0
  local allStage = self:GetAllStage()
  for k, v in pairs(allStage) do
    idEndPlot = v.AfterReasoningPlot
  end
  if idEndPlot ~= storyManager:GetCurStoryID() then
    return
  end
  local cfgEnding
  local allEnding = self:GetAllEnding()
  for k, v in pairs(allEnding) do
    if v.StoryParagraph == storyManager:GetCurParagraphID() and v.StoryOptionIndex == index then
      cfgEnding = v
      break
    end
  end
  if cfgEnding ~= nil then
    self:GameIdReasoning(self.Game_Continue_Ending)
    self:StartTask(self.SubmitEndingTask, self, cfgEnding.ID)
  end
end

function UIN29DetectiveLocalDb:SubmitEndingTask(TT, idEnding)
  self:Lock("UIN29DetectiveLogin:SubmitEndingTask")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._detectiveComponent:HandleSubmitEnding(TT, res, idEnding)
  self:UnLock("UIN29DetectiveLogin:SubmitEndingTask")
end

function UIN29DetectiveLocalDb:PlayEndingPlot(branchEnding)
  if branchEnding then
    self:SwitchState(UIStateType.UIN29DetectiveLogin)
  else
    local allEnding = self:GetAllEnding()
    local idEnding = self._detectiveComponent:GetCurrentEndingId()
    local idCg = allEnding[idEnding].CgId
    local allItem = Cfg.cfg_component_detective_item({})
    idCg = allItem[idCg].CG
    self:ShowDialog("UIStoryController", idCg, function()
      self:SwitchState(UIStateType.UIN29DetectiveLogin)
    end)
  end
end
