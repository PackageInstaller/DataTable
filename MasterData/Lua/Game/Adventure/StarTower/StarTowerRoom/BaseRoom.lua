local BaseRoom = class("BaseRoom")
local TimerManager = require("GameCore.Timer.TimerManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance

function BaseRoom:ctor(parentData, tbCases)
  self.EnumCase = {
    Battle = 1,
    OpenDoor = 2,
    PotentialSelect = 3,
    FateCardSelect = 4,
    NoteSelect = 5,
    NpcEvent = 6,
    SelectSpecialPotential = 7,
    RecoveryHP = 8,
    NpcRecoveryHP = 9,
    Hawker = 10,
    StrengthenMachine = 11,
    DoorDanger = 12,
    SyncHP = 13
  }
  self.EnumPopup = {
    Reward = 1,
    Potential = 2,
    StrengthFx = 3,
    Disc = 4,
    Affinity = 5
  }
  self.curRoomType = 0
  self.bBattleEnd = false
  self.nCoinTemp = 0
  self.tbEvent = {}
  self._tbTimer = {}
  self.roomData = {}
  self.parent = parentData
  self.mapCases = {}
  self.bProcessing = true
  self.nTaskType = 0
  self.mapNpc = {}
  self.initCases = tbCases
  self.tbPopup = {}
  self.blockNpcBtn = false
end

function BaseRoom:_BindEventCallback(mapEventConfig)
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
  local callback1 = self.OnEvent_NpcSpawned
  if type(callback1) == "function" then
    EventManager.Add("LevelNpcSpawned", self, callback1)
  end
  local callback2 = self.OnEvent_DiscSkillActive
  if type(callback2) == "function" then
    EventManager.Add("DiscSkillActive", self, callback2)
  end
  local callback3 = self.OnEvent_RewardPopup
  if type(callback3) == "function" then
    EventManager.Add("StarTowerReward", self, callback3)
  end
  local callback4 = self.OnEvent_PotentialPopup
  if type(callback4) == "function" then
    EventManager.Add("PotentialLevelUp", self, callback4)
  end
  local callback5 = self.OnEvent_ShopStrengthFx
  if type(callback5) == "function" then
    EventManager.Add("ShopStrengthFx", self, callback5)
  end
  local callback6 = self.OnEvent_CloseLoadingView
  if type(callback5) == "function" then
    EventManager.Add(EventId.TransAnimOutClear, self, callback6)
  end
end

function BaseRoom:_UnbindEventCallback(mapEventConfig)
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
  local callback1 = self.OnEvent_NpcSpawned
  EventManager.Remove("LevelNpcSpawned", self, callback1)
  local callback2 = self.OnEvent_DiscSkillActive
  EventManager.Remove("DiscSkillActive", self, callback2)
  local callback3 = self.OnEvent_RewardPopup
  EventManager.Remove("StarTowerReward", self, callback3)
  local callback4 = self.OnEvent_PotentialPopup
  EventManager.Remove("PotentialLevelUp", self, callback4)
  local callback5 = self.OnEvent_ShopStrengthFx
  EventManager.Remove("ShopStrengthFx", self, callback5)
  local callback6 = self.OnEvent_CloseLoadingView
  EventManager.Remove(EventId.TransAnimOutClear, self, callback6)
end

function BaseRoom:_RemoveAllTimer()
  for i, timer in ipairs(self._tbTimer) do
    if timer ~= nil then
      TimerManager.Remove(timer, false)
    end
  end
end

function BaseRoom:AddTimer(nTargetCount, nInterval, sCallbackName, bAutoRun, bDestroyWhenComplete, nScaleType, tbParam)
  local callback
  if type(sCallbackName) == "function" then
    callback = sCallbackName
  else
    callback = self[sCallbackName]
  end
  if type(callback) == "function" then
    local timer = TimerManager.Add(nTargetCount, nInterval, self, callback, bAutoRun, bDestroyWhenComplete, nScaleType, tbParam)
    if timer ~= nil then
      table.insert(self._tbTimer, timer)
    end
    return timer
  else
    return nil
  end
end

function BaseRoom:Enter()
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  self:_BindEventCallback(self._mapEventConfig)
  local nLevel = self.parent.nCurLevel
  local nTotalLevel = #self.parent.tbStarTowerAllLevel
  local nType = self.parent.nRoomType
  if self.parent.nTowerId ~= 999 then
    EventManager.Hit("ShowStarTowerLevelTitle", nLevel, nTotalLevel, nType)
  end
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  EventManager.Hit("InitStarTowerNote", self.parent._mapNote)
  self:SaveCase(self.initCases)
  self.initCases = nil
  self.nTime = 0
  if type(self.LevelStart) == "function" then
    self:LevelStart()
  end
  EventManager.Hit("RefreshFateCard", clone(self.parent._mapFateCard))
  if nType == GameEnum.starTowerRoomType.ShopRoom then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_ShopRoom")
    local nVoiceDelay = ConfigTable.GetConfigNumber("StarTowerPlayerVoiceDelay")
    self:AddTimer(1, nVoiceDelay, function()
      EventManager.Hit("PlayEnterShopRoomCharVoice", nLevel, nType)
    end, true, true)
  end
end

function BaseRoom:Exit()
  EventManager.Hit("ShowStarTowerRoomInfo", false)
  EventManager.Hit("FRRoomEnd")
  self:_RemoveAllTimer()
  self:_UnbindEventCallback(self._mapEventConfig)
end

function BaseRoom:ActiveTeleport()
  safe_call_cs_func(CS.AdventureModuleHelper.OpenActiveTeleporter)
  if not self.bShowTeleport then
    self.bShowTeleport = true
    self:ShowTeleportIndicator()
  end
end

function BaseRoom:ShowTeleportIndicator()
  local mapMapData = ConfigTable.GetData("StarTowerMap", self.parent.curMapId)
  if mapMapData ~= nil and mapMapData.OutPortHint then
    local tbTeleports = CS.AdventureModuleHelper.GetLevelTeleporters()
    if tbTeleports ~= nil then
      for i = 0, tbTeleports.Count - 1 do
        EventManager.Hit("SetIndicator", 2, tbTeleports[i], Vector3.zero, nil)
      end
    end
  end
end

function BaseRoom:SaveCase(tbCases)
  if tbCases == nil then
    return
  end
  for _, mapCaseData in ipairs(tbCases) do
    if mapCaseData.BattleCase ~= nil then
      print("BattleCase")
      if self.mapCases[self.EnumCase.Battle] ~= nil then
        printError("战斗事件重复 可能导致房间事件处理无法结束")
      end
      self.mapCases[self.EnumCase.Battle] = {}
      self.mapCases[self.EnumCase.Battle].Id = mapCaseData.Id
      self.mapCases[self.EnumCase.Battle].Data = mapCaseData.BattleCase
      self.mapCases[self.EnumCase.Battle].bFinish = false
    elseif mapCaseData.DoorCase ~= nil then
      if mapCaseData.DoorCase.Type == GameEnum.starTowerRoomType.DangerRoom then
        print("DangerRoomCase")
        local mapStarTower = ConfigTable.GetData("StarTower", self.parent.nTowerId)
        local nNpcId = mapStarTower.DangerNpc
        local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
        local nBoardNpcId = mapNpcCfgData.NPCId
        local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
        self.mapNpc[nNpcId] = mapCaseData.Id
        safe_call_cs_func(CS.AdventureModuleHelper.SpawnNPC, nNpcId, nSkinId)
        if self.mapCases[self.EnumCase.DoorDanger] == nil then
          self.mapCases[self.EnumCase.DoorDanger] = {}
        end
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id] = mapCaseData.DoorCase
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id].bFinish = false
      elseif mapCaseData.DoorCase.Type == GameEnum.starTowerRoomType.HorrorRoom then
        print("HorrorRoomCase")
        local mapStarTower = ConfigTable.GetData("StarTower", self.parent.nTowerId)
        local nNpcId = mapStarTower.HorrorNpc
        local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
        local nBoardNpcId = mapNpcCfgData.NPCId
        local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
        self.mapNpc[nNpcId] = mapCaseData.Id
        safe_call_cs_func(CS.AdventureModuleHelper.SpawnNPC, nNpcId, nSkinId)
        if self.mapCases[self.EnumCase.DoorDanger] == nil then
          self.mapCases[self.EnumCase.DoorDanger] = {}
        end
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id] = mapCaseData.DoorCase
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id].bFinish = false
      else
        print("DoorCase")
        if self.mapCases[self.EnumCase.OpenDoor] == nil then
          self:ActiveTeleport()
          self.mapCases[self.EnumCase.OpenDoor] = {
            mapCaseData.Id,
            mapCaseData.DoorCase.Type
          }
        end
      end
    elseif mapCaseData.SelectPotentialCase ~= nil then
      print("SelectPotentialCase")
      if self.mapCases[self.EnumCase.PotentialSelect] == nil then
        self.mapCases[self.EnumCase.PotentialSelect] = {}
      end
      self.mapCases[self.EnumCase.PotentialSelect][mapCaseData.Id] = mapCaseData.SelectPotentialCase
      self.mapCases[self.EnumCase.PotentialSelect][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectSpecialPotentialCase ~= nil then
      print("SelectSpecialPotentialCase")
      if self.mapCases[self.EnumCase.SelectSpecialPotential] == nil then
        self.mapCases[self.EnumCase.SelectSpecialPotential] = {}
      end
      self.mapCases[self.EnumCase.SelectSpecialPotential][mapCaseData.Id] = mapCaseData.SelectSpecialPotentialCase
      self.mapCases[self.EnumCase.SelectSpecialPotential][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectFateCardCase ~= nil then
      print("SelectFateCardCase")
      if self.mapCases[self.EnumCase.FateCardSelect] == nil then
        self.mapCases[self.EnumCase.FateCardSelect] = {}
      end
      self.mapCases[self.EnumCase.FateCardSelect][mapCaseData.Id] = mapCaseData.SelectFateCardCase
      self.mapCases[self.EnumCase.FateCardSelect][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectNoteCase ~= nil then
      print("SelectNoteCase")
      if self.mapCases[self.EnumCase.NoteSelect] == nil then
        self.mapCases[self.EnumCase.NoteSelect] = {}
      end
      self.mapCases[self.EnumCase.NoteSelect][mapCaseData.Id] = mapCaseData.SelectNoteCase
      self.mapCases[self.EnumCase.NoteSelect][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectOptionsEventCase ~= nil then
      print("SelectOptionsEventCase")
      if self.mapCases[self.EnumCase.NpcEvent] == nil then
        self.mapCases[self.EnumCase.NpcEvent] = {}
      end
      local mapEventCfgData = ConfigTable.GetData("StarTowerEvent", mapCaseData.SelectOptionsEventCase.EvtId)
      if mapEventCfgData ~= nil then
        local nNpcId = mapCaseData.SelectOptionsEventCase.NPCId
        local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
        if mapNpcCfgData ~= nil then
          local nBoardNpcId = mapNpcCfgData.NPCId
          local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
          if self.mapNpc[nNpcId] ~= nil then
            printError("NpcId重复" .. mapCaseData.SelectOptionsEventCase.EvtId)
          end
          self.mapNpc[nNpcId] = mapCaseData.Id
          safe_call_cs_func(CS.AdventureModuleHelper.SpawnNPC, nNpcId, nSkinId)
          local nActionId = mapCaseData.SelectOptionsEventCase.EvtId * 10000 + nNpcId
          if ConfigTable.GetData("StarTowerEventAction", nActionId) ~= nil then
            mapCaseData.SelectOptionsEventCase.nActionId = nActionId
          else
            printError("该事件没有对应的action" .. mapCaseData.SelectOptionsEventCase.EvtId)
            mapCaseData.SelectOptionsEventCase.nActionId = 0
          end
        else
          printError("没有找到对应NPC配置 " .. nNpcId)
        end
      end
      self.mapCases[self.EnumCase.NpcEvent][mapCaseData.Id] = mapCaseData.SelectOptionsEventCase
      self.mapCases[self.EnumCase.NpcEvent][mapCaseData.Id].bFinish = mapCaseData.SelectOptionsEventCase.Done
      self.mapCases[self.EnumCase.NpcEvent][mapCaseData.Id].bFirst = true
    elseif mapCaseData.RecoveryHPCase ~= nil then
      print("RecoveryHPCase")
      if self.mapCases[self.EnumCase.RecoveryHP] == nil then
        self.mapCases[self.EnumCase.RecoveryHP] = {}
      end
      self.mapCases[self.EnumCase.RecoveryHP][mapCaseData.Id] = mapCaseData.RecoveryHPCase
      self.mapCases[self.EnumCase.RecoveryHP][mapCaseData.Id].bFinish = false
    elseif mapCaseData.NpcRecoveryHPCase ~= nil then
      print("NpcRecoveryHPCase")
      local mapStarTower = ConfigTable.GetData("StarTower", self.parent.nTowerId)
      local nNpcId = mapStarTower.ResqueNpc
      local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
      local nBoardNpcId = mapNpcCfgData.NPCId
      local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
      safe_call_cs_func(CS.AdventureModuleHelper.SpawnNPC, nNpcId, nSkinId)
      self.mapNpc[nNpcId] = mapCaseData.Id
      if self.mapCases[self.EnumCase.NpcRecoveryHP] == nil then
        self.mapCases[self.EnumCase.NpcRecoveryHP] = {}
      end
      self.mapCases[self.EnumCase.NpcRecoveryHP][mapCaseData.Id] = mapCaseData.NpcRecoveryHPCase
      self.mapCases[self.EnumCase.NpcRecoveryHP][mapCaseData.Id].bFinish = false
    elseif mapCaseData.HawkerCase ~= nil then
      print("HawkerCase")
      local nType = self.parent.nRoomType
      local mapStarTower = ConfigTable.GetData("StarTower", self.parent.nTowerId)
      local nNpcId = mapStarTower.ShopNpc
      if nType ~= GameEnum.starTowerRoomType.ShopRoom then
        nNpcId = mapStarTower.StandShopNpc
      end
      local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
      local nBoardNpcId = mapNpcCfgData.NPCId
      local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
      self.mapNpc[nNpcId] = mapCaseData.Id
      if self.mapCases[self.EnumCase.Hawker] == nil then
        self.mapCases[self.EnumCase.Hawker] = {}
      end
      self.mapCases[self.EnumCase.Hawker][mapCaseData.Id] = mapCaseData.HawkerCase
      self.mapCases[self.EnumCase.Hawker][mapCaseData.Id].bFinish = false
      safe_call_cs_func(CS.AdventureModuleHelper.SpawnNPC, nNpcId, nSkinId)
    elseif mapCaseData.StrengthenMachineCase ~= nil then
      print("StrengthenMachineCase")
      local mapStarTower = ConfigTable.GetData("StarTower", self.parent.nTowerId)
      local nNpcId = mapStarTower.UpgradeNpc
      local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
      local nBoardNpcId = mapNpcCfgData.NPCId
      local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
      self.mapNpc[nNpcId] = mapCaseData.Id
      if self.mapCases[self.EnumCase.StrengthenMachine] == nil then
        self.mapCases[self.EnumCase.StrengthenMachine] = {}
      end
      self.mapCases[self.EnumCase.StrengthenMachine][mapCaseData.Id] = mapCaseData.StrengthenMachineCase
      self.mapCases[self.EnumCase.StrengthenMachine][mapCaseData.Id].bFinish = false
      safe_call_cs_func(CS.AdventureModuleHelper.SpawnNPC, nNpcId, nSkinId)
    elseif mapCaseData.SyncHPCase ~= nil then
      self.mapCases[self.EnumCase.SyncHP] = mapCaseData.Id
    end
  end
end

function BaseRoom:SaveSelectResp(mapCaseData, nCaseId)
  if not mapCaseData or not nCaseId then
    return
  end
  if mapCaseData.SelectPotentialCase ~= nil then
    self.mapCases[self.EnumCase.PotentialSelect][nCaseId] = mapCaseData.SelectPotentialCase
    self.mapCases[self.EnumCase.PotentialSelect][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.PotentialSelect][nCaseId].bReRoll = true
  elseif mapCaseData.SelectSpecialPotentialCase ~= nil then
    self.mapCases[self.EnumCase.SelectSpecialPotential][nCaseId] = mapCaseData.SelectSpecialPotentialCase
    self.mapCases[self.EnumCase.SelectSpecialPotential][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.SelectSpecialPotential][nCaseId].bReRoll = true
  elseif mapCaseData.SelectFateCardCase ~= nil then
    self.mapCases[self.EnumCase.FateCardSelect][nCaseId] = mapCaseData.SelectFateCardCase
    self.mapCases[self.EnumCase.FateCardSelect][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.FateCardSelect][nCaseId].bReRoll = true
  elseif mapCaseData.HawkerCase ~= nil then
    self.mapCases[self.EnumCase.Hawker][nCaseId] = mapCaseData.HawkerCase
    self.mapCases[self.EnumCase.Hawker][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.Hawker][nCaseId].bReRoll = true
  end
end

function BaseRoom:HandleNpc(nNpcId, nNpcUid)
  if self.blockNpcBtn then
    return
  end
  local nCaseId = self.mapNpc[nNpcId]
  if nCaseId == nil then
    printError("Npc没有对应事件ID:" .. nNpcId)
    return
  end
  local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
  if mapNpcCfgData == nil then
    printError("Npc config missing:" .. nNpcId)
    return
  end
  if mapNpcCfgData.type == GameEnum.npcNewType.Narrate then
    local tbChat = ConfigTable.GetData("NPCConfig", nNpcId).Lines
    local nTalkId = tbChat[math.random(1, #tbChat)]
    if nTalkId == nil then
      nTalkId = 0
    end
    local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcId).NPCId
    local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
    local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 0, 0, {}, nSkinId, 1, {}, {}, nTalkId, 0, true, false, nCoin, self.parent.nTowerId, self.parent._mapNote, self.parent.tbDisc)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Event then
    self:OpenNpcOptionPanel(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Resque then
    self:HandleNpcRecover(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Danger then
    self:HandleNpcDangerRoom(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Horror then
    self:HandleNpcDangerRoom(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Shop then
    self:InteractiveShop(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Upgrade then
    self:InteractiveStrengthMachine(nCaseId, nNpcId)
    return
  else
    printError("待处理事件")
  end
  printError("没有找到可交互的事件:" .. nNpcId)
end

function BaseRoom:GetBattleCase()
  if self.mapCases[self.EnumCase.PotentialSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.PotentialSelect]) do
      if mapData.bFinish ~= true then
        return
      end
    end
  end
  return false
end

function BaseRoom:HandleCases()
  local function wait_case(callback)
    EventManager.Hit(EventId.BlockInput, true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      callback()
    end
    
    cs_coroutine.start(wait)
  end
  
  if self.tbPopup[self.EnumPopup.StrengthFx] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.StrengthFx]) do
      if not mapData.bFinish then
        self:HandleShopStrengthFx(mapData)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Potential] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Potential]) do
      if not mapData.bFinish then
        wait_case(function()
          self:HandlePopupPotential(mapData)
        end)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Reward] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Reward]) do
      if not mapData.bFinish then
        wait_case(function()
          self:HandlePopupReward(mapData)
        end)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.RecoveryHP] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.RecoveryHP]) do
      if mapData.bFinish ~= true then
        self:HandleRecover(nId)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.SelectSpecialPotential] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.SelectSpecialPotential]) do
      if mapData.bFinish ~= true then
        wait_case(function()
          self:OpenSelectPotential(nId, true)
        end)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.PotentialSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.PotentialSelect]) do
      if mapData.bFinish ~= true then
        wait_case(function()
          self:OpenSelectPotential(nId)
        end)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.NoteSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.NoteSelect]) do
      if mapData.bFinish ~= true then
        wait_case(function()
          self:OpenSelectNote(nId)
        end)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.FateCardSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.FateCardSelect]) do
      if mapData.bFinish ~= true then
        wait_case(function()
          self:OpenSelectFateCard(nId)
        end)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Disc] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Disc]) do
      if not mapData.bFinish then
        wait_case(function()
          self:HandlePopupDisc(mapData)
        end)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Affinity] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Affinity]) do
      EventManager.Hit("ShowNPCAffinity", mapData.NPCId, mapData.Increase)
    end
    self.tbPopup[self.EnumPopup.Affinity] = {}
  end
  self.blockNpcBtn = false
  return false
end

function BaseRoom:OpenSelectPotential(nCaseId, bSpecial)
  local function ProcessSpecialPotentialData(nId)
    local mapCaseData = self.mapCases[self.EnumCase.SelectSpecialPotential][nId]
    
    local tbPotential = {}
    local mapPotential = {}
    for _, nPotentialId in ipairs(mapCaseData.Ids) do
      table.insert(tbPotential, {Id = nPotentialId, Count = 1})
      mapPotential[nPotentialId] = 0
      local mapPotentialCfgData = ConfigTable.GetData("Potential", nPotentialId)
      if mapPotentialCfgData == nil then
        printError("PotentialCfgData Missing" .. nPotentialId)
        return
      end
      local nCharId = mapPotentialCfgData.CharId
      if self.parent._mapPotential[nCharId][nPotentialId] ~= nil then
        mapPotential[nPotentialId] = self.parent._mapPotential[nCharId][nPotentialId]
      end
    end
    local nType = 0
    if 0 < mapCaseData.TeamLevel then
      nType = 1
    end
    local mapRoll = {
      CanReRoll = mapCaseData.CanReRoll,
      ReRollPrice = mapCaseData.ReRollPrice
    }
    return tbPotential, mapPotential, nType, mapCaseData.TeamLevel, mapCaseData.NewIds, mapRoll
  end
  
  local function ProcessPotentialData(nId)
    local mapCaseData = self.mapCases[self.EnumCase.PotentialSelect][nId]
    local tbPotential = {}
    local mapPotential = {}
    for _, mapPotentialInfo in ipairs(mapCaseData.Infos) do
      table.insert(tbPotential, {
        Id = mapPotentialInfo.Tid,
        Count = mapPotentialInfo.Level
      })
      mapPotential[mapPotentialInfo.Tid] = 0
      local mapPotentialCfgData = ConfigTable.GetData("Potential", mapPotentialInfo.Tid)
      if mapPotentialCfgData == nil then
        printError("PotentialCfgData Missing" .. mapPotentialInfo.Tid)
        return
      end
      local nCharId = mapPotentialCfgData.CharId
      if self.parent._mapPotential[nCharId][mapPotentialInfo.Tid] ~= nil then
        mapPotential[mapPotentialInfo.Tid] = self.parent._mapPotential[nCharId][mapPotentialInfo.Tid]
      end
    end
    local mapRoll = {
      CanReRoll = mapCaseData.CanReRoll,
      ReRollPrice = mapCaseData.ReRollPrice
    }
    return tbPotential, mapPotential, mapCaseData.Type, mapCaseData.TeamLevel, mapCaseData.NewIds, mapRoll, mapCaseData.LuckyIds
  end
  
  local function GetUnfinishedSelect()
    if self.mapCases[self.EnumCase.SelectSpecialPotential] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.SelectSpecialPotential]) do
        if mapData.bFinish ~= true then
          local tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll = ProcessSpecialPotentialData(nId)
          return nId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll
        end
      end
    end
    if self.mapCases[self.EnumCase.PotentialSelect] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.PotentialSelect]) do
        if mapData.bFinish ~= true then
          local tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, tbLuckyIds = ProcessPotentialData(nId)
          return nId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, tbLuckyIds
        end
      end
    end
    return 0, {}, {}, 0
  end
  
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll)
    if nId == -1 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    if bReRoll then
      msg.SelectReq.ReRoll = true
    else
      msg.SelectReq.Index = nIdx - 1
    end
    
    local function InteractiveCallback(callbackMsg)
      local Id = callbackMsg.Id
      if self.mapCases[self.EnumCase.SelectSpecialPotential] ~= nil and self.mapCases[self.EnumCase.SelectSpecialPotential][Id] ~= nil then
        if self.mapCases[self.EnumCase.SelectSpecialPotential][nId].bReRoll then
          self.mapCases[self.EnumCase.SelectSpecialPotential][nId].bReRoll = false
        else
          self.mapCases[self.EnumCase.SelectSpecialPotential][Id].bFinish = true
        end
      end
      if self.mapCases[self.EnumCase.PotentialSelect] ~= nil and self.mapCases[self.EnumCase.PotentialSelect][Id] ~= nil then
        if self.mapCases[self.EnumCase.PotentialSelect][nId].bReRoll then
          self.mapCases[self.EnumCase.PotentialSelect][nId].bReRoll = false
        else
          self.mapCases[self.EnumCase.PotentialSelect][Id].bFinish = true
        end
      end
      local caseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, tbLuckyIds = GetUnfinishedSelect()
      local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
      if panelCallback ~= nil and type(panelCallback) == "function" then
        local tbRecommend = self.parent:GetRecommondPotential(tbPotential)
        panelCallback(caseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend)
      end
    end
    
    self.parent:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, tbLuckyIds
  if bSpecial then
    tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll = ProcessSpecialPotentialData(nCaseId)
  else
    tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, tbLuckyIds = ProcessPotentialData(nCaseId)
  end
  local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  local tbRecommend = self.parent:GetRecommondPotential(tbPotential)
  EventManager.Hit("StarTowerPotentialSelect", nCaseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, SelectCallback, mapRoll, nCoin, tbLuckyIds, tbRecommend)
end

function BaseRoom:OpenSelectNote(nCaseId)
  local function ProcessNoteData(nId)
    local mapCaseData = self.mapCases[self.EnumCase.NoteSelect][nId]
    
    local tbNoteSelect = mapCaseData.Info
    local mapNote = self.parent._mapNote
    return tbNoteSelect, mapNote
  end
  
  local function GetUnfinishedSelect()
    if self.mapCases[self.EnumCase.NoteSelect] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.NoteSelect]) do
        if mapData.bFinish ~= true then
          local tbPotential, mapPotential = ProcessNoteData(nId)
          return nId, tbPotential, mapPotential
        end
      end
    end
    return 0, {}, {}
  end
  
  local function SelectCallback(nIdx, nId, panelCallback)
    if nIdx == -1 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    msg.SelectReq.Index = nIdx - 1
    
    local function InteractiveCallback(callbackMsg)
      local Id = callbackMsg.Id
      if self.mapCases[self.EnumCase.NoteSelect] ~= nil and self.mapCases[self.EnumCase.NoteSelect][Id] ~= nil then
        self.mapCases[self.EnumCase.NoteSelect][Id].bFinish = true
      end
      local caseId, tbNoteSelect, mapNote = GetUnfinishedSelect()
      if panelCallback ~= nil and type(panelCallback) == "function" then
        panelCallback(caseId, tbNoteSelect, mapNote)
      end
    end
    
    self.parent:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbNoteSelect, mapNote = ProcessNoteData(nCaseId)
  EventManager.Hit("StarTowerSelectNote", nCaseId, mapNote, tbNoteSelect, SelectCallback)
end

function BaseRoom:OpenSelectFateCard(nCaseId)
  local function ProcessFateCard(nId)
    local mapCaseData = self.mapCases[self.EnumCase.FateCardSelect][nId]
    
    local tbFateCard = mapCaseData.Ids
    local tbNewIds = mapCaseData.NewIds
    local bReward = mapCaseData.Give
    local mapRoll = {
      CanReRoll = mapCaseData.CanReRoll,
      ReRollPrice = mapCaseData.ReRollPrice
    }
    return tbFateCard, tbNewIds, mapRoll, bReward
  end
  
  local function GetUnfinishedSelect()
    if self.mapCases[self.EnumCase.FateCardSelect] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.FateCardSelect]) do
        if mapData.bFinish ~= true then
          local tbFateCard, tbNewIds, mapRoll, bReward = ProcessFateCard(nId)
          return nId, tbFateCard, tbNewIds, mapRoll, bReward
        end
      end
    end
    return 0, {}, {}
  end
  
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll)
    if nIdx == -1 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    if bReRoll then
      msg.SelectReq.ReRoll = true
    else
      msg.SelectReq.Index = nIdx - 1
    end
    
    local function InteractiveCallback(callbackMsg)
      local Id = callbackMsg.Id
      if self.mapCases[self.EnumCase.FateCardSelect] ~= nil and self.mapCases[self.EnumCase.FateCardSelect][nId] ~= nil then
        if self.mapCases[self.EnumCase.FateCardSelect][nId].bReRoll then
          self.mapCases[self.EnumCase.FateCardSelect][nId].bReRoll = false
        else
          self.mapCases[self.EnumCase.FateCardSelect][nId].bFinish = true
        end
      end
      local caseId, tbFateCard, tbNewIds, mapRoll, bReward = GetUnfinishedSelect()
      local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
      if panelCallback ~= nil and type(panelCallback) == "function" then
        panelCallback(caseId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
      end
    end
    
    self.parent:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbFateCard, tbNewIds, mapRoll, bReward = ProcessFateCard(nCaseId)
  local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  EventManager.Hit("StarTowerSelectFateCard", nCaseId, tbFateCard, tbNewIds, SelectCallback, mapRoll, nCoin, bReward)
end

function BaseRoom:OpenNpcOptionPanel(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.NpcEvent] == nil then
    printError("No NpcOptionCase!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.NpcEvent][nCaseId]
  if mapCase == nil then
    printError("No NpcOptionCase! :" .. nCaseId)
    return
  end
  local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcConfigId).NPCId
  local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
  local mapAffinity = {}
  for _, mapInfo in ipairs(mapCase.Infos) do
    mapAffinity[mapInfo.NPCId] = mapInfo.Affinity
  end
  if mapCase.bFinish then
    local tbLines = ConfigTable.GetData("NPCConfig", nNpcConfigId).Lines
    local tbChat = {}
    for _, nTalkId in ipairs(tbLines) do
      local mapTalkCfg = ConfigTable.GetData("StarTowerTalk", nTalkId)
      if mapTalkCfg ~= nil and mapAffinity[mapTalkCfg.NPCId] ~= nil then
        local nAffinity = mapAffinity[mapTalkCfg.NPCId]
        if #mapTalkCfg.Affinity == 2 and nAffinity ~= nil and nAffinity >= mapTalkCfg.Affinity[1] and nAffinity <= mapTalkCfg.Affinity[2] then
          table.insert(tbChat, nTalkId)
        end
      end
    end
    if #tbChat < 1 then
      table.insert(tbChat, tbLines[1])
    end
    local nCount = #tbChat
    local nTalkId = tbChat[1]
    if 1 < nCount then
      nTalkId = tbChat[math.random(1, #tbChat)]
    end
    if nTalkId == nil then
      nTalkId = 0
    end
    local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 0, 0, {}, nSkinId, 1, {}, {}, nTalkId, 0, true, false, nCoin, self.parent.nTowerId, self.parent._mapNote, self.parent.tbDisc)
    return
  end
  local tbOption = mapCase.Options
  local tbUnabledOption = mapCase.FailedIdxes
  local nTableEvtId = mapCase.EvtId
  local nEventId = nCaseId
  
  local function callback(nIdx, nEvtId)
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId)
    local nOptionId = tbOption[nIdx]
    local mapOptionData = ConfigTable.GetData("EventOptions", nOptionId)
    local bJump = false
    if mapOptionData ~= nil then
      bJump = mapOptionData.IgnoreInterActive
    else
      printError("EventOptions Missing：" .. nOptionId)
    end
    if bJump then
      return
    end
    local msg = {}
    msg.Id = nEvtId
    msg.SelectReq = {}
    msg.SelectReq.Index = nIdx - 1
    
    local function InteractiveCallback(callbackMsg, tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange, mapChangeSecondarySkill)
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      local bSuccess = false
      if callbackMsg.SelectResp ~= nil and callbackMsg.SelectResp.Resp ~= nil then
        bSuccess = callbackMsg.SelectResp.Resp.OptionsResult
      end
      if bSuccess then
        self.mapCases[self.EnumCase.NpcEvent][nCaseId].bFinish = true
        local tbInfo = {}
        if self.tbPopup[self.EnumPopup.Affinity] == nil then
          self.tbPopup[self.EnumPopup.Affinity] = {}
        end
        for _, mapChange in ipairs(callbackMsg.SelectResp.Resp.AffinityChange) do
          table.insert(tbInfo, {
            NPCId = mapChange.NPCId,
            Affinity = mapChange.Affinity
          })
          table.insert(self.tbPopup[self.EnumPopup.Affinity], {
            NPCId = mapChange.NPCId,
            Increase = mapChange.Increase
          })
        end
        self.mapCases[self.EnumCase.NpcEvent][nCaseId].Infos = tbInfo
        EventManager.Hit("StarTowerEventInteract", clone(mapChangeNote), clone(mapItemChange), clone(mapPotentialChange), clone(tbChangeFateCard), clone(mapChangeSecondarySkill))
        cs_coroutine.start(wait)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Startower_EventFailHint"))
        table.insert(mapCase.FailedIdxes, nIdx - 1)
      end
      if callbackMsg.SelectResp ~= nil and callbackMsg.SelectResp.Resp ~= nil and callbackMsg.SelectResp.Resp.OptionsParamId ~= nil and callbackMsg.SelectResp.Resp.OptionsParamId ~= 0 then
        local sTextId = "EventResult_" .. tostring(callbackMsg.SelectResp.Resp.OptionsParamId)
        local sResultHint = ConfigTable.GetUIText(sTextId)
        EventManager.Hit(EventId.OpenMessageBox, sResultHint)
      end
    end
    
    self.parent:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbLines = ConfigTable.GetData("NPCConfig", nNpcConfigId).FirstLines
  local tbChat = {}
  for _, nTalkId in ipairs(tbLines) do
    local mapTalkCfg = ConfigTable.GetData("StarTowerTalk", nTalkId)
    if mapTalkCfg ~= nil and mapAffinity[mapTalkCfg.NPCId] ~= nil then
      local nAffinity = mapAffinity[mapTalkCfg.NPCId]
      if #mapTalkCfg.Affinity == 2 and nAffinity ~= nil and nAffinity >= mapTalkCfg.Affinity[1] and nAffinity <= mapTalkCfg.Affinity[2] then
        table.insert(tbChat, nTalkId)
      end
    end
  end
  if #tbChat < 1 then
    table.insert(tbChat, tbLines[1])
  end
  local nCount = #tbChat
  local nTalkId = tbChat[1]
  if 1 < nCount then
    nTalkId = tbChat[math.random(1, #tbChat)]
  end
  if nTalkId == nil then
    nTalkId = 0
  end
  mapCase.bFirst = false
  local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 1, nEventId, tbOption, nSkinId, callback, tbUnabledOption, nTableEvtId, nTalkId, mapCase.nActionId, false, false, nCoin, self.parent.nTowerId, self.parent._mapNote, self.parent.tbDisc)
end

function BaseRoom:HandleRecover(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.RecoveryHP] == nil then
    printError("No RecoveryHP!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.RecoveryHP][nCaseId]
  if mapCase == nil then
    printError("No RecoveryHP! :" .. nCaseId)
    return
  end
  if mapCase.bFinish then
    printError("Event has finished! :" .. nCaseId)
    return
  end
  local nEftId = mapCase.EffectId
  local nHp = self.parent:RecoverHp(nEftId)
  local msg = {}
  msg.Id = nCaseId
  msg.RecoveryHPReq = {}
  msg.RecoveryHPReq.Hp = nHp
  
  local function callback(_, msgData)
    self.mapCases[self.EnumCase.RecoveryHP][nCaseId].bFinish = true
    self:HandleCases()
  end
  
  self.parent:StarTowerInteract(msg, callback)
end

function BaseRoom:HandleNpcRecover(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.NpcRecoveryHP] == nil then
    printError("No NpcOptionCase!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.NpcRecoveryHP][nCaseId]
  if mapCase == nil then
    printError("No NpcOptionCase! :" .. nCaseId)
    return
  end
  if mapCase.bFinish then
    local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcConfigId).NPCId
    local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
    local tbChat = ConfigTable.GetData("NPCConfig", nNpcConfigId).Lines
    local nCount = #tbChat
    local nTalkId = tbChat[1]
    local tbSelectedChat = {}
    local nAffinity = PlayerData.StarTower:GetNpcAffinityData(9172).nTotalExp
    if 1 < nCount then
      for _, nTalkId in ipairs(tbChat) do
        local mapTalkCfg = ConfigTable.GetData("StarTowerTalk", nTalkId)
        if mapTalkCfg ~= nil and nAffinity ~= nil and #mapTalkCfg.Affinity == 2 and nAffinity ~= nil and nAffinity >= mapTalkCfg.Affinity[1] and nAffinity <= mapTalkCfg.Affinity[2] then
          table.insert(tbSelectedChat, nTalkId)
        end
      end
    end
    if 0 < #tbSelectedChat then
      nTalkId = tbSelectedChat[math.random(1, #tbSelectedChat)]
    end
    local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 0, 0, {}, nSkinId, 1, {}, {}, nTalkId, 0, true, false, nCoin, self.parent.nTowerId, self.parent._mapNote, self.parent.tbDisc)
    return
  end
  local nEftId = mapCase.EffectId
  local nHp = self.parent:RecoverHp(nEftId)
  local WwiseAudioMgr = CS.WwiseAudioManager.Instance
  WwiseAudioMgr:PostEvent("ui_battle_cure")
  local msg = {}
  msg.Id = nCaseId
  msg.RecoveryHPReq = {}
  msg.RecoveryHPReq.Hp = nHp
  
  local function callback(_, msgData)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NpcRecoverTips"))
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId)
    self.mapCases[self.EnumCase.NpcRecoveryHP][nCaseId].bFinish = true
  end
  
  self.parent:StarTowerInteract(msg, callback)
end

function BaseRoom:HandleNpcDangerRoom(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.DoorDanger] == nil then
    printError("No NpcOptionCase!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.DoorDanger][nCaseId]
  if mapCase == nil then
    printError("No NpcOptionCase! :" .. nCaseId)
    return
  end
  local nRoomType = mapCase.Type
  local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcConfigId).NPCId
  local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
  
  local function callback(nIdx, nEvtId)
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId)
    if nIdx == 1 then
      self.parent:EnterRoom(nEvtId, nRoomType)
    else
      return
    end
  end
  
  local tbChat = ConfigTable.GetData("NPCConfig", nNpcConfigId).Lines
  local nTalkId = tbChat[math.random(1, #tbChat)]
  if nTalkId == nil then
    nTalkId = 0
  end
  local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 2, nCaseId, {}, nSkinId, callback, {}, 0, nTalkId, 0, false, false, nCoin, self.parent.nTowerId, self.parent._mapNote, self.parent.tbDisc)
end

function BaseRoom:HandlePopupDisc(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("StarTowerShowDiscSkill", mapData.param, clone(self.parent._mapNote), callback)
end

function BaseRoom:HandlePopupReward(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("StarTowerShowReward", mapData.param, callback)
end

function BaseRoom:HandlePopupPotential(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("ShowPotentialLevelUp", mapData.param, callback)
end

function BaseRoom:HandleShopStrengthFx(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("ShowShopStrengthFx", mapData.param, callback)
end

function BaseRoom:InteractiveShop(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.Hawker] == nil then
    printError("No Hawker Case!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.Hawker][nCaseId]
  if mapCase == nil then
    printError("No Hawker Case! :" .. nCaseId)
    return
  end
  
  local function BuildRollData(case)
    return {
      CanReRoll = case.CanReRoll,
      ReRollPrice = case.ReRollPrice,
      ReRollTimes = case.ReRollTimes
    }
  end
  
  local function BuildShopData(case)
    local tbShopData = {}
    for index, mapGood in ipairs(case.List) do
      tbShopData[index] = {
        Idx = mapGood.Idx,
        bSoldOut = table.indexof(case.Purchase, mapGood.Sid) > 0,
        Price = mapGood.Price,
        nDiscount = mapGood.Discount,
        nCharId = 0 < mapGood.CharPos and self.parent.tbTeam[mapGood.CharPos] or 0,
        nSid = mapGood.Sid,
        nType = mapGood.Type,
        nGoodsId = mapGood.GoodsId
      }
    end
    return tbShopData
  end
  
  local function BuyCallback(nEvtId, nSid, callback, bReRoll)
    local msg = {}
    msg.Id = nEvtId
    msg.HawkerReq = {}
    if bReRoll then
      msg.HawkerReq.ReRoll = true
    else
      msg.HawkerReq.Sid = nSid
    end
    
    local function InteractiveCallback(callbackMsg, tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange)
      if callback ~= nil and type(callback) == "function" then
        local nBagCount = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
        local mapInteractiveCase = self.mapCases[self.EnumCase.Hawker][nEvtId]
        if mapInteractiveCase.bReRoll then
          self.mapCases[self.EnumCase.Hawker][nEvtId].bReRoll = false
          local mapRoll = BuildRollData(mapInteractiveCase)
          local tbShopData = BuildShopData(mapInteractiveCase)
          callback(nBagCount, tbShopData, mapRoll)
        else
          table.insert(mapInteractiveCase.Purchase, nSid)
          callback(nBagCount)
        end
      end
      EventManager.Hit("StarTowerShopInteract", mapChangeNote)
      self:HandleCases()
    end
    
    self.parent:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local mapRoll = BuildRollData(mapCase)
  local tbShopData = BuildShopData(mapCase)
  local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerShop, tbShopData, nCoin, BuyCallback, nCaseId, mapRoll, self.parent.tbDisc, self.parent._mapNote, self.parent.nTowerId, self.parent.nCurLevel)
  WwiseAudioMgr:SetState("combat", "shopIn")
  WwiseAudioMgr:StopDiscMusic(true, function()
    NovaAPI.UnLoadBankByEventName("music_outfit_stop")
  end)
end

function BaseRoom:InteractiveStrengthMachine(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.StrengthenMachine] == nil then
    printError("No StrengthMachine Case!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.StrengthenMachine][nCaseId]
  if mapCase == nil then
    printError("No StrengthMachine Case! :" .. nCaseId)
    return
  end
  local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency]
  if nCoin == nil then
    nCoin = 0
  end
  local nDiscount = mapCase.Discount
  local bFirstFree = mapCase.FirstFree
  local nCost = self.parent.tbStrengthMachineCost[mapCase.Times + 1]
  if nCost == nil then
    nCost = self.parent.tbStrengthMachineCost[#self.parent.tbStrengthMachineCost]
  end
  nCost = nCost - nDiscount
  if bFirstFree then
    nCost = 0
  end
  if nCoin < nCost then
    printError("Not Enough Coin!")
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NotEnoughCoin"))
    return
  end
  
  local function InteractiveCallback(netmsgData)
    if netmsgData.StrengthenMachineResp ~= nil and not netmsgData.StrengthenMachineResp.BuySucceed then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NoPotential"))
      printError("没有可选的潜能")
      return
    end
    if bFirstFree then
      mapCase.FirstFree = false
    else
      mapCase.Times = mapCase.Times + 1
    end
    local nCoinAfter = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency]
    if nCoinAfter == nil then
      nCoinAfter = 0
    end
    local nCostAfter = self.parent.tbStrengthMachineCost[mapCase.Times + 1]
    if nCostAfter == nil then
      nCostAfter = self.parent.tbStrengthMachineCost[#self.parent.tbStrengthMachineCost]
    end
    nCostAfter = nCostAfter - nDiscount
    EventManager.Hit("ShopStrengthFx", {nCost = nCost})
    local WwiseAudioMgr = CS.WwiseAudioManager.Instance
    WwiseAudioMgr:PostEvent("ui_battle_buff_get")
    self:HandleCases()
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId, nCostAfter, nCoinAfter)
  end
  
  local msg = {}
  msg.Id = nCaseId
  self.parent:StarTowerInteract(msg, InteractiveCallback)
end

function BaseRoom:CheckBattleEnd()
  if self.mapCases[self.EnumCase.Battle] == nil then
    return true
  end
  return self.mapCases[self.EnumCase.Battle].bFinish
end

function BaseRoom:SyncHp()
  local nSyncHpCaseId = self.mapCases[self.EnumCase.SyncHP]
  if nSyncHpCaseId ~= nil and 0 < nSyncHpCaseId then
    local mapCharHpInfo = self.parent.GetActorHp()
    local nMainChar = self.parent.tbTeam[1]
    local nHp = -1
    if mapCharHpInfo[nMainChar] ~= nil then
      nHp = mapCharHpInfo[nMainChar]
    end
    local mapCase = {
      Id = nSyncHpCaseId,
      RecoveryHPReq = {Hp = nHp}
    }
    
    local function callback(_, mapNetData)
      self.mapCases[self.EnumCase.SyncHP] = 0
      self:SaveCase(mapNetData.Cases)
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_interact_req, mapCase, nil, callback)
  end
end

function BaseRoom:OnEvent_NpcSpawned(nEntityId, nNpcId, trNpc)
  local nCaseId = self.mapNpc[nNpcId]
  local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
  if nCaseId == nil then
    EventManager.Hit("NPCShow", true, nNpcId, nEntityId)
  elseif mapNpcCfgData ~= nil and mapNpcCfgData.type == GameEnum.npcNewType.Upgrade then
    if self.mapCases[self.EnumCase.StrengthenMachine] == nil then
      EventManager.Hit("NPCShow", true, nNpcId, nEntityId)
      return
    else
      local mapCase = self.mapCases[self.EnumCase.StrengthenMachine][nCaseId]
      if mapCase == nil then
        EventManager.Hit("NPCShow", true, nNpcId, nEntityId)
        return
      end
      local nDiscount = mapCase.Discount or 0
      local bFirstFree = mapCase.FirstFree
      local nTime = mapCase.Times + 1
      local nCost = self.parent.tbStrengthMachineCost[nTime]
      if nCost == nil then
        nCost = self.parent.tbStrengthMachineCost[#self.parent.tbStrengthMachineCost]
      end
      nCost = nCost - nDiscount
      if bFirstFree then
        nCost = 0
      end
      local nCoin = self.parent._mapItem[AllEnum.CoinItemId.FixedRogCurrency]
      if nCoin == nil then
        nCoin = 0
      end
      EventManager.Hit("NPCShow", true, nNpcId, nEntityId, nCost, nCoin)
    end
  else
    EventManager.Hit("NPCShow", true, nNpcId, nEntityId)
  end
  EventManager.Hit("SetIndicator", 3, trNpc, Vector3.zero, mapNpcCfgData.HintIcon)
end

function BaseRoom:OnEvent_DiscSkillActive(tbParam)
  if self.tbPopup[self.EnumPopup.Disc] == nil then
    self.tbPopup[self.EnumPopup.Disc] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.Disc], {bFinish = false, param = tbParam})
end

function BaseRoom:OnEvent_RewardPopup(tbParam)
  if self.tbPopup[self.EnumPopup.Reward] == nil then
    self.tbPopup[self.EnumPopup.Reward] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.Reward], {bFinish = false, param = tbParam})
end

function BaseRoom:OnEvent_PotentialPopup(tbParam)
  if self.tbPopup[self.EnumPopup.Potential] == nil then
    self.tbPopup[self.EnumPopup.Potential] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.Potential], {bFinish = false, param = tbParam})
end

function BaseRoom:OnEvent_ShopStrengthFx(tbParam)
  if self.tbPopup[self.EnumPopup.StrengthFx] == nil then
    self.tbPopup[self.EnumPopup.StrengthFx] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.StrengthFx], {bFinish = false, param = tbParam})
end

function BaseRoom:OnEvent_CloseLoadingView()
  self:HandleCases()
end

function BaseRoom:GetShopGoods()
  local nType = self.parent.nRoomType
  local mapStarTower = ConfigTable.GetData("StarTower", self.parent.nTowerId)
  if not mapStarTower then
    return
  end
  local nNpcId = mapStarTower.ShopNpc
  if nType ~= GameEnum.starTowerRoomType.ShopRoom then
    nNpcId = mapStarTower.StandShopNpc
  end
  if self.mapCases[self.EnumCase.Hawker] and self.mapNpc[nNpcId] then
    return self.mapCases[self.EnumCase.Hawker][self.mapNpc[nNpcId]].List
  end
end

function BaseRoom:GetCaseById(nId)
  for nType, mapCase in pairs(self.mapCases) do
    if type(mapCase) == "table" then
      if mapCase.Id == nil then
        for nCaseId, mapCaseData in pairs(mapCase) do
          if nCaseId == nId then
            return nType, mapCaseData
          end
        end
      elseif mapCase.Id == nId then
        return nType, mapCase
      end
    end
  end
  return nil
end

return BaseRoom
