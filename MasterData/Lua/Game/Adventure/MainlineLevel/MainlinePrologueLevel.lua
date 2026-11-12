local MainlinePrologueLevel = class("MainlinePrologueLevel")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local mapFloor = {
  [1] = "Game.Adventure.MainlineLevel.PrologueFloor.DesertFloor",
  [2] = "Game.Adventure.MainlineLevel.PrologueFloor.BattleFloor"
}
local mapEventConfig = {
  LevelStateChanged = "OnEvent_LevelStateChanged",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  ExitModule = "OnEvent_ExitModule",
  AfterEnterModule = "OnEvent_AfterEnterModule",
  PrologueBattleReload = "OnEvent_PrologueBattleReload",
  PrologueBattleArchive = "OnEvent_PrologueBattleArchive",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  EnterModule = "OnEvent_EnterModule"
}
local enterFloorForTest = 0
local PrologueSceneId = 1200103
local tbAfterDesertFloor = {1200104, 1200106}
local tbTrialCharacter = {
  {
    1200201,
    1200203,
    1200202
  },
  {
    1200201,
    1200203,
    1200202
  }
}
local tbSelectPerks = {
  {
    500501,
    500801,
    500101
  }
}
local mapBoxReward = {
  [1] = {
    500501,
    500801,
    500101
  }
}
local tbTheme = {
  GameEnum.rglTheme.ChainLightning,
  GameEnum.rglTheme.WindBlade,
  GameEnum.rglTheme.FireRing
}

function MainlinePrologueLevel:Init(parent)
  self.curFloor = nil
  self.sAfterBattleAvg = "ST1001"
  local lastAccount = LocalData.GetLocalData("LoginUIData", "LastUserName_All")
  local sJson = LocalData.GetLocalData(lastAccount, "MainlinePrologueLevel")
  if sJson ~= nil then
    local tb = decodeJson(sJson)
    self.isThreePlayer = tb.isThreePlayer
    self.revivalPoint = Vector3(tb.revivalPoint[1], tb.revivalPoint[2], tb.revivalPoint[3])
    self.btnNames = tb.btnNames
    self.tbSelectPerks = tb.tbSelectPerks
    self.curFloorIdx = tb.curFloorIdx
    self.bDesertComplete = tb.bDesertComplete
    self.nCurAvgCmdIdx = tb.nCurAvgCmdIdx
    self.bBattleEnd = tb.bBattleEnd
    self.curCharId = tb.curCharId
    self.curNpcRewardIdx = tb.curNpcRewardIdx
    self.nBoxId = tb.nBoxId
  else
    self.isThreePlayer = false
    self.revivalPoint = Vector3.zero
    self.btnNames = nil
    self.tbSelectPerks = {}
    self.curFloorIdx = 1
    self.bDesertComplete = false
    self.nCurAvgCmdIdx = 0
    self.bBattleEnd = false
    self.curCharId = 0
    self.curNpcRewardIdx = 1
    self.nBoxId = 0
  end
  EventManager.Hit("MainlinePrologueLevelNextModule", self)
  self:BindEvent()
  self.parent = parent
  self.bSettle = false
  self.tbTrialId = {}
  self.tbChar = {}
  if not self.bDesertComplete then
    CS.AdventureModuleHelper.EnterProloguelMap(PrologueSceneId)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  elseif self.bBattleEnd then
    self:OnEvent_LevelStateChanged()
  else
    if #tbTrialCharacter[self.curFloorIdx] > 0 then
      PlayerData.Char:CreateTrialChar(tbTrialCharacter[self.curFloorIdx])
      for _, nTrialId in pairs(tbTrialCharacter[self.curFloorIdx]) do
        if 0 < nTrialId then
          local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
          table.insert(self.tbChar, mapTrialChar.nId)
          table.insert(self.tbTrialId, nTrialId)
        end
      end
    end
    for _, nTrialId in ipairs(self.tbTrialId) do
      if 0 < nTrialId then
        local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
        local tbstInfo, stActorInfo, nHeartStoneLevel = self.CalCharFixedEffectTrial(nTrialId)
        safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, mapTrialChar.nId, stActorInfo)
      end
    end
    self:SetFloor(2)
    CS.AdventureModuleHelper.EnterProloguelBattleMap(tbAfterDesertFloor[self.curFloorIdx], self.tbChar, {}, self.isThreePlayer, self.revivalPoint, self.btnNames)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  end
end

function MainlinePrologueLevel:SetLocalData()
  local mapLocalData = {
    isThreePlayer = self.isThreePlayer,
    revivalPoint = {
      self.revivalPoint.x,
      self.revivalPoint.y,
      self.revivalPoint.z
    },
    btnNames = self.btnNames,
    tbSelectPerks = self.tbSelectPerks,
    curFloorIdx = self.curFloorIdx,
    bDesertComplete = self.bDesertComplete,
    nCurAvgCmdIdx = self.nCurAvgCmdIdx,
    bBattleEnd = self.bBattleEnd,
    curCharId = self.curCharId,
    curNpcRewardIdx = self.curNpcRewardIdx,
    nBoxId = self.nBoxId
  }
  local sJson = RapidJson.encode(mapLocalData)
  local lastAccount = LocalData.GetLocalData("LoginUIData", "LastUserName_All")
  LocalData.SetLocalData(lastAccount, "MainlinePrologueLevel", sJson)
end

function MainlinePrologueLevel:SetFloor(nType)
  if self.curFloor ~= nil then
    self.curFloor:Exit()
  end
  self.curFloor = nil
  local luaPath = mapFloor[nType]
  if luaPath == nil then
    printError("no exist type:" .. nType)
    luaPath = mapFloor[1]
  end
  local luaFile = require(luaPath)
  local luaClass = luaFile.new(self)
  luaClass:Enter()
  self.curFloor = luaClass
end

function MainlinePrologueLevel:UnsetFloor()
  if self.curFloor ~= nil then
    self.curFloor:Exit()
  end
  self.curFloor = nil
end

function MainlinePrologueLevel:BindEvent()
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

function MainlinePrologueLevel:UnBindEvent()
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

function MainlinePrologueLevel.CalCharFixedEffectTrial(nTrialId)
  local tbstInfo = {}
  local tbEffectId = {}
  local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  local nHeartStoneLevel = PlayerData.Char:CalCharacterTrialAttrBattle(nTrialId, tbstInfo, stActorInfo)
  return tbstInfo, stActorInfo, nHeartStoneLevel
end

function MainlinePrologueLevel:SetTheme()
  safe_call_cs_func(CS.AdventureModuleHelper.SetRglTheme, tbTheme)
end

function MainlinePrologueLevel:SetThemePerk()
  local tbThemePerkInfo = {}
  local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
  for _, nPerkId in ipairs(self.tbSelectPerks) do
    stPerkInfo.perkId = nPerkId
    stPerkInfo.nCount = 1
    table.insert(tbThemePerkInfo, stPerkInfo)
  end
  if 0 < #tbThemePerkInfo then
    safe_call_cs_func(CS.AdventureModuleHelper.ChangeThemePerkIds, tbThemePerkInfo)
  end
end

function MainlinePrologueLevel:GetRewardNpc(nNpcId, nNpcUid)
  local function SelectPerkCallBack(_, tbResult)
    EventManager.Remove(EventId.SelectPerk, self, SelectPerkCallBack)
    
    self.curNpcRewardIdx = self.curNpcRewardIdx + 1
    table.insert(self.tbSelectPerks, tbResult[1])
    local tbThemePerkInfo = {}
    local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
    stPerkInfo.perkId = tbResult[1]
    stPerkInfo.nCount = 1
    table.insert(tbThemePerkInfo, stPerkInfo)
    safe_call_cs_func(CS.AdventureModuleHelper.ChangeThemePerkIds, tbThemePerkInfo)
    local mapNpc = ConfigTable.GetData("NPC", nNpcId)
    if mapNpc.completeDestroy then
      safe_call_cs_func(CS.InteractiveManager.Instance.setInteractiveNpcState, CS.InteractiveManager.Instance, nNpcUid)
    end
    NovaAPI.DispatchEventWithData("PROLOGUELEVEL_SELECTPERK")
  end
  
  if tbSelectPerks[self.curNpcRewardIdx] == nil then
    printError(string.format("没有第%d个奖励", self.curNpcRewardIdx))
    return
  end
  local tbPerks = {}
  for _, nPerkId in ipairs(tbSelectPerks[self.curNpcRewardIdx]) do
    table.insert(tbPerks, {
      Id = nPerkId,
      Level = 1,
      nMaxLevel = 3
    })
  end
  local mapBag = {
    mapPerk = {},
    mapItem = {},
    mapSlotPerk = {
      [1] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      },
      [2] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      },
      [3] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      },
      [4] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      }
    }
  }
  EventManager.Add(EventId.SelectPerk, self, SelectPerkCallBack)
  EventManager.Hit(EventId.OpenPanel, PanelId.FRThemePerkSelect, {
    {Perks = tbPerks, Theme = 0}
  }, 0, mapBag, {}, true, true)
end

function MainlinePrologueLevel:GetRewardBox(nBoxId)
  local function SelectPerkCallBack(_, tbResult)
    EventManager.Remove(EventId.SelectPerk, self, SelectPerkCallBack)
    
    self.curNpcRewardIdx = self.curNpcRewardIdx + 1
    table.insert(self.tbSelectPerks, tbResult[1])
    local tbThemePerkInfo = {}
    local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
    stPerkInfo.perkId = tbResult[1]
    stPerkInfo.nCount = 1
    table.insert(tbThemePerkInfo, stPerkInfo)
    safe_call_cs_func(CS.AdventureModuleHelper.ChangeThemePerkIds, tbThemePerkInfo)
    local mapNpc = ConfigTable.GetData("NPC", nNpcId)
    if mapNpc.completeDestroy then
      safe_call_cs_func(CS.InteractiveManager.Instance.setInteractiveNpcState, CS.InteractiveManager.Instance, nNpcUid)
    end
    NovaAPI.DispatchEventWithData("PROLOGUELEVEL_SELECTPERK")
  end
  
  if mapBoxReward[self.nBoxId] == nil then
    printError(string.format("没有配置宝箱id为%d的奖励", self.nBoxId))
    return
  end
  local tbPerks = {}
  for _, nPerkId in ipairs(mapBoxReward[self.nBoxId]) do
    table.insert(tbPerks, {
      Id = nPerkId,
      Level = 1,
      nMaxLevel = 3
    })
  end
  local mapBag = {
    mapPerk = {},
    mapItem = {},
    mapSlotPerk = {
      [1] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      },
      [2] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      },
      [3] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      },
      [4] = {
        nPerkId = 0,
        nQty = 0,
        nMaxLevel = 0
      }
    }
  }
  EventManager.Add(EventId.SelectPerk, self, SelectPerkCallBack)
  EventManager.Hit(EventId.OpenPanel, PanelId.FRThemePerkSelect, {
    {Perks = tbPerks, Theme = 0}
  }, 0, mapBag, {}, true, true)
end

function MainlinePrologueLevel:OnEvent_LevelStateChanged()
  self.bDesertComplete = true
  if 0 < #tbAfterDesertFloor and #tbAfterDesertFloor > self.curFloorIdx and not self.bBattleEnd then
    self:ChangeFloor()
    return
  end
  
  local function func_AvgEnd()
    EventManager.Remove("StoryDialog_DialogEnd", self, func_AvgEnd)
    NovaAPI.EnterModule("MainMenuModuleScene", true)
    self.parent:LevelEnd()
  end
  
  local function UnloadCallback()
    CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    CS.ClientManager.Instance:CloseLoadingView(nil)
    PlayerData.Char:DeleteTrialChar()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, UnloadCallback)
    local ModuleManager = require("GameCore.Module.ModuleManager")
    if ModuleManager.GetIsAdventure() then
      NovaAPI.InputDisable()
    end
    if self.sAfterBattleAvg ~= "" then
      self.bBattleEnd = true
      self:SetLocalData()
      EventManager.Add("StoryDialog_DialogEnd", self, func_AvgEnd)
      EventManager.Hit("StoryDialog_DialogStart", self.sAfterBattleAvg, nil, self.nCurAvgCmdIdx)
    else
      func_AvgEnd()
    end
  end
  
  self:UnsetFloor()
  local ModuleManager = require("GameCore.Module.ModuleManager")
  if ModuleManager.GetIsAdventure() then
    EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, UnloadCallback)
    CS.AdventureModuleHelper.LevelStateChanged(true)
    NovaAPI.InputDisable()
  else
    UnloadCallback()
  end
end

function MainlinePrologueLevel:OnEvent_ExitModule(_, sEnterModuleName)
end

function MainlinePrologueLevel:OnEvent_AfterEnterModule(sEnterModuleName)
  if sEnterModuleName == "EmptyModuleScene" then
    local function wait()
      self.bDesertComplete = true
      
      self:SetLocalData()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self.tbChar = {}
      self.tbTrialId = {}
      if #tbTrialCharacter[self.curFloorIdx] > 0 then
        PlayerData.Char:CreateTrialChar(tbTrialCharacter[self.curFloorIdx])
        for _, nTrialId in pairs(tbTrialCharacter[self.curFloorIdx]) do
          if 0 < nTrialId then
            local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
            table.insert(self.tbChar, mapTrialChar.nId)
            table.insert(self.tbTrialId, nTrialId)
          end
        end
      end
      for _, nTrialId in ipairs(self.tbTrialId) do
        if 0 < nTrialId then
          local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
          local tbstInfo, stActorInfo, nHeartStoneLevel = self.CalCharFixedEffectTrial(nTrialId)
          safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, mapTrialChar.nId, stActorInfo)
        end
      end
      self:SetFloor(2)
      CS.AdventureModuleHelper.EnterProloguelBattleMap(tbAfterDesertFloor[self.curFloorIdx], self.tbChar, {}, self.isThreePlayer, self.revivalPoint, self.btnNames)
      NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    end
    
    cs_coroutine.start(wait)
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function MainlinePrologueLevel:OnEvent_PrologueBattleReload()
  local function levelUnloadCallback()
    NovaAPI.EnterModule("EmptyModuleScene", true)
    
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
  CS.AdventureModuleHelper.LevelStateChanged(true)
end

function MainlinePrologueLevel:ChangeFloor()
  local function levelUnloadCallback()
    PlayerData.Char:DeleteTrialChar()
    
    self.curFloorIdx = self.curFloorIdx + 1
    NovaAPI.EnterModule("EmptyModuleScene", true)
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
    self.btnNames = {}
    self.revivalPoint = Vector3.zero
    self:SetLocalData()
  end
  
  local id = CS.AdventureModuleHelper.GetCurrentActivePlayer()
  self.curCharId = CS.AdventureModuleHelper.GetCharacterId(id)
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
  self:UnsetFloor()
  CS.AdventureModuleHelper.LevelStateChanged(true)
end

function MainlinePrologueLevel:OnEvent_LoadLevelRefresh()
  if self.curFloorIdx > 0 then
    for _, nTrialId in ipairs(self.tbTrialId) do
      if 0 < nTrialId then
        local tbstInfo, stActorInfo, nHeartStoneLevel = self.CalCharFixedEffectTrial(nTrialId)
      end
    end
  end
end

function MainlinePrologueLevel:OnEvent_PrologueBattleArchive(isThreePlayer, revivalPoint, btnNames, nCmdId, nBoxId)
  if nCmdId == -1 then
    local lastAccount = LocalData.GetLocalData("LoginUIData", "LastUserName_All")
    LocalData.SetLocalData(lastAccount, "MainlinePrologueLevel", "")
  end
  self.nBoxId = nBoxId
  if isThreePlayer == nil then
  end
  self.isThreePlayer = isThreePlayer
  self.revivalPoint = revivalPoint == nil and Vector3.zero or revivalPoint
  btnNames = btnNames == nil and {
    [0] = "",
    Count = 1
  } or btnNames
  self.nCurAvgCmdIdx = nCmdId
  local tbNames = {}
  local nCount = btnNames.Count - 1
  for i = 0, nCount do
    table.insert(tbNames, btnNames[i])
  end
  self.btnNames = tbNames
  self:SetLocalData()
end

function MainlinePrologueLevel:OnEvent_AdventureModuleEnter()
  if self.bDesertComplete then
    self:SetTheme()
    self:SetThemePerk()
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
  end
end

function MainlinePrologueLevel:OnEvent_EnterModule()
  if not self.bDesertComplete then
    EventManager.Hit(EventId.OpenPanel, PanelId.Prologue, self.tbChar)
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.PrologueAdventurePanel, self.tbChar)
  end
end

return MainlinePrologueLevel
