local TutorialLevelData = class("TutorialLevelData")
local AdventureModuleHelper = CS.AdventureModuleHelper
local mapEventConfig = {
  UpdateOperationTips = "OnEvent_UpdateTips",
  OpenTutorialCard = "OnEvent_OpenTutorialCard",
  TaskLevel_TaskFinish = "OnEvent_UpdateFinishTaskCount",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  TutorialLevelSuccess = "OnEvent_LevelSuccess",
  TutorialPotentialSelect = "OnEvent_PotentialSelect",
  TutorialRefreshNoteCount = "OnEvent_RefreshNoteCount",
  Trigger_Guide_Index = "OnEvent_GuideStart",
  GuideEnd = "OnEvent_GuideEnd",
  ShowTutorialButtonHint = "OnEvent_ShowButtonHint"
}

function TutorialLevelData:ctor()
end

function TutorialLevelData:InitData()
  self.nlevelId = 0
  self.tbCharId = {}
  self.tbDiscId = {}
  self.CardId = 0
  self.TipsKey = ""
  self.CurQuestCount = 0
  self.MaxQuestCount = 0
  self.levelConfig = nil
  self.floorConfig = nil
end

function TutorialLevelData:InitLevelData(levelId, tbCharId, tbDiscId)
  self:InitData()
  self:BindEvent()
  self.nlevelId = levelId
  self.levelConfig = ConfigTable.GetData("TutorialLevel", self.nlevelId)
  self.floorConfig = ConfigTable.GetData("TutorialLevelFloor", self.levelConfig.FloorId)
  self.mapBuildData = PlayerData.Build:GetTrialBuild(self.levelConfig.TutorialBuild)
  self.tbCharacterPotential = {}
  self.tbCharId, self.tbCharTrialId, self.mapCharData, self.mapTalentAddLevel = {}, {}, {}, {}
  for _, mapChar in ipairs(self.mapBuildData.tbChar) do
    table.insert(self.tbCharId, mapChar.nTid)
    self.tbCharTrialId[mapChar.nTid] = mapChar.nTrialId
    self.mapCharData[mapChar.nTid] = PlayerData.Char:GetTrialCharById(mapChar.nTrialId)
    self.mapTalentAddLevel[mapChar.nTid] = PlayerData.Talent:GetTrialEnhancedPotential(mapChar.nTrialId)
  end
  self.tbDiscId, self.mapDiscData = {}, {}
  for _, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if 0 < nDiscId then
      table.insert(self.tbDiscId, nDiscId)
      local mapCfg = ConfigTable.GetData("TrialDisc", nDiscId)
      if mapCfg then
        self.mapDiscData[mapCfg.DiscId] = PlayerData.Disc:GetTrialDiscById(nDiscId)
      end
    end
  end
  self.MaxQuestCount = #self.floorConfig.QuestFlow
end

function TutorialLevelData:FinishLevel(result)
  self:UnBindEvent()
  local nCurQuestCount = self:GetCurQuestCount() or 0
  local nMaxQuestCount = self:GetMaxQuestCount() or 0
  local tbCharId = self:GetCharList() or {}
  if not result then
    EventManager.Hit(EventId.OpenPanel, PanelId.TutorialResult, 2, self.nlevelId, {}, nCurQuestCount, nMaxQuestCount, tbCharId, {}, false)
    PlayerData.Build:DeleteTrialBuild()
  else
    local tbSkin = {}
    for _, nCharId in ipairs(self.tbCharId) do
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      table.insert(tbSkin, nSkinId)
    end
    
    local function func_SettlementFinish()
    end
    
    local function levelEndCallback()
      EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      local levelConfig = ConfigTable.GetData("TutorialLevel", self.nlevelId)
      if levelConfig == nil then
        return
      end
      local floorConfig = ConfigTable.GetData("TutorialLevelFloor", levelConfig.FloorId)
      if floorConfig == nil then
        return
      end
      local nType = floorConfig.Theme
      local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
      print("sceneName:" .. sName)
      AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
    end
    
    EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    
    local function openBattleResultPanel()
      EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
      EventManager.Hit(EventId.OpenPanel, PanelId.TutorialResult, 1, self.nlevelId, {}, nCurQuestCount, nMaxQuestCount, tbCharId, {}, false)
      PlayerData.Build:DeleteTrialBuild()
    end
    
    EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
    AdventureModuleHelper.LevelStateChanged(true)
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
  end
end

function TutorialLevelData:GetCurDicId()
  return self.CardId
end

function TutorialLevelData:GetCurQuestCount()
  return self.CurQuestCount
end

function TutorialLevelData:GetMaxQuestCount()
  return self.MaxQuestCount
end

function TutorialLevelData:GetCharList()
  return self.tbCharId
end

function TutorialLevelData:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Disc:CalcTrialInfoInBuild(nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function TutorialLevelData:CalCharFixedEffect(nTrialId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Char:CalCharacterTrialAttrBattle(nTrialId, stActorInfo, bMainChar, tbDiscId, self.levelConfig.TutorialBuild)
  return stActorInfo
end

function TutorialLevelData:GetCharIdByBtnName(btnName)
  if self.tbCharId == nil then
    return
  end
  if btnName == "Fire1" or btnName == "Fire2" or btnName == "Fire3" or btnName == "Fire4" then
    return self.tbCharId[1]
  elseif btnName == "ActorSwitch1" or btnName == "SwitchWithUltra1" then
    return self.tbCharId[2]
  elseif btnName == "ActorSwitch2" or btnName == "SwitchWithUltra2" then
    return self.tbCharId[3]
  end
end

function TutorialLevelData:GetByBtnType(btnName)
  if btnName == "Fire1" or btnName == "Fire3" then
    return 1
  elseif btnName == "ActorSwitch1" or btnName == "ActorSwitch2" or btnName == "Fire2" then
    return 2
  else
    if btnName == "SwitchWithUltra1" or btnName ~= "SwitchWithUltra2" then
    end
    return 4
  end
end

function TutorialLevelData:OnEvent_UpdateTips(tipsKey)
  if tipsKey == self.TipsKey then
    return
  end
  self.TipsKey = tipsKey
  EventManager.Hit("Tutorial_UpdateTips", self.TipsKey)
end

function TutorialLevelData:OnEvent_OpenTutorialCard(cardId, bIsLevelStart)
  self.CardId = cardId
  EventManager.Hit("Tutorial_OpenCard", self.CardId, bIsLevelStart)
end

function TutorialLevelData:OnEvent_UpdateFinishTaskCount(isLast)
  self.CurQuestCount = self.CurQuestCount + 1
end

function TutorialLevelData:OnEvent_AdventureModuleEnter()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(self.tbCharTrialId[nCharId], idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
  local tbDisc = {}
  for _, v in ipairs(self.tbDiscId) do
    local mapCfg = ConfigTable.GetData("TrialDisc", v)
    if mapCfg then
      table.insert(tbDisc, mapCfg.DiscId)
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.TutorialPanel, self.tbCharId, tbDisc, self.mapCharData, self.mapDiscData)
end

function TutorialLevelData:OnEvent_LevelSuccess()
  EventManager.Hit("TutorialLevel_Success")
end

function TutorialLevelData:OnEvent_PotentialSelect(potentialData)
  local potentialList = {}
  for _, pot in pairs(potentialData) do
    table.insert(potentialList, pot)
  end
  
  local function callback(index)
    local nPotentialId = potentialList[index]
    local potConfig = ConfigTable.GetData("Potential", nPotentialId)
    if potConfig == nil then
      return
    end
    if self.tbCharacterPotential[potConfig.CharId] == nil then
      self.tbCharacterPotential[potConfig.CharId] = {}
    end
    local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
    stPerkInfo.perkId = nPotentialId
    stPerkInfo.nCount = 1
    local bChange = false
    if #self.tbCharacterPotential[potConfig.CharId] >= 1 then
      bChange = true
    end
    safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, {stPerkInfo}, potConfig.CharId, bChange)
    table.insert(self.tbCharacterPotential[potConfig.CharId], nPotentialId)
  end
  
  EventManager.Hit("Tutorial_PotentialSelect", potentialList, callback)
end

function TutorialLevelData:OnEvent_GuideStart(index)
  self.GuideIndex = index
end

function TutorialLevelData:OnEvent_GuideEnd()
  NovaAPI.DispatchEventWithData("Tutorial_GuideEnd", nil, {
    self.GuideIndex
  })
end

function TutorialLevelData:OnEvent_RefreshNoteCount(note, dropNote, activeSkills)
  local noteList = {}
  local dropNoteList = {}
  local mapChangeSecondarySkill = {}
  for id, count in pairs(note) do
    noteList[id] = count
  end
  for id, count in pairs(dropNote) do
    local bIsNew = count - noteList[id] == 0
    dropNoteList[id] = {
      Tid = id,
      LuckyLevel = 0,
      New = bIsNew,
      Qty = count
    }
  end
  for id, v in pairs(activeSkills) do
    local skillData = {Active = true, SecondaryId = v}
    table.insert(mapChangeSecondarySkill, skillData)
  end
  self:ResetNoteInfo(noteList)
  self:ResetDiscInfo(noteList)
  EventManager.Hit("RefreshNoteCount", noteList, dropNoteList, mapChangeSecondarySkill, false)
end

function TutorialLevelData:OnEvent_ShowButtonHint(btnName, isShow)
  local charId = self:GetCharIdByBtnName(btnName)
  local btnId = self:GetByBtnType(btnName)
  EventManager.Hit("Open_Ultra_Special_FX", charId * 10 + btnId, isShow)
end

function TutorialLevelData:ResetNoteInfo(noteList)
  local tbNoteInfo = {}
  for i, v in pairs(noteList) do
    local noteInfo = CS.Lua2CSharpInfo_NoteInfo()
    noteInfo.noteId = i
    noteInfo.noteCount = v
    table.insert(tbNoteInfo, noteInfo)
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
end

function TutorialLevelData:ResetDiscInfo(noteList)
  local tbDiscInfo = {}
  for nDiscId, mapDiscData in pairs(self.mapDiscData) do
    if table.indexof(self.tbDiscId, nDiscId) <= 3 and mapDiscData ~= nil then
      local discInfo = mapDiscData:GetDiscInfo(noteList)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function TutorialLevelData:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function TutorialLevelData:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

return TutorialLevelData
