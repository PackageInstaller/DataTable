local AdventureModuleHelper = CS.AdventureModuleHelper
local ModuleManager = {}
local bAdventure, curModuleName
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local actor2dManager = require("Game.Actor2D.Actor2DManager")

local function OnEvent_EnterModule(moduleMgr, sExitModuleName, sEnterModuleName)
  bAdventure = false
  if sEnterModuleName == "MainMenuModuleScene" then
    if PlayerData.back2Login then
      PlayerData.back2Login = false
      PanelManager.OnConfirmBackToLogIn()
    elseif PlayerData.back2Home then
      PlayerData.back2Home = false
      PanelManager.Home()
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.MainView)
    end
    PlayerData.Base:OnBackToMainMenuModule()
  elseif sEnterModuleName == "AdventureModuleScene" then
    NovaAPI.ShutdownDirtyWords()
    bAdventure = true
    PanelManager.Release()
    actor2dManager.ClearAll()
    PanelManager.ClearInputState()
  end
end

local function OnEvent_ExitModule(moduleMgr, sExitModuleName, sEnterModuleName)
  if sExitModuleName == "AdventureModuleScene" then
    EventManager.Hit(EventId.ClosePanel, PanelId.Hud)
  end
end

local function OnEvent_AfterEnterModule(moduleMgr, sEnterModuleName)
  curModuleName = sEnterModuleName
  if sEnterModuleName == "LoginModuleScene" then
    EventManager.Hit(EventId.OpenPanel, PanelId.Login)
  elseif sEnterModuleName == "MainMenuModuleScene" then
    EventManager.Hit(EventId.AfterEnterMain)
    CS.WwiseAudioManager.Instance:PostEvent("ui_loading_combatSFX_active", nil, false)
  elseif sEnterModuleName == "AdventureModuleScene" then
    if PlayerData.nCurGameType == AllEnum.WorldMapNodeType.Mainline then
      EventManager.Hit(EventId.EnterMainline)
    elseif PlayerData.nCurGameType == AllEnum.WorldMapNodeType.Roguelike then
      EventManager.Hit(EventId.EnterRoguelike)
    end
  end
  collectgarbage("collect")
end

local function OnEvent_AdventureModuleEnter()
end

local function Uninit(moduleMgr)
  EventManager.Remove(EventId.CSLuaManagerShutdown, ModuleManager, Uninit)
  EventManager.Remove("ExitModule", ModuleManager, OnEvent_ExitModule)
  EventManager.Remove("EnterModule", ModuleManager, OnEvent_EnterModule)
  EventManager.Remove("AfterEnterModule", ModuleManager, OnEvent_AfterEnterModule)
  EventManager.Remove("AdventureModuleEnter", ModuleManager, OnEvent_AdventureModuleEnter)
end

function ModuleManager.Init()
  EventManager.Add(EventId.CSLuaManagerShutdown, ModuleManager, Uninit)
  EventManager.Add("ExitModule", ModuleManager, OnEvent_ExitModule)
  EventManager.Add("EnterModule", ModuleManager, OnEvent_EnterModule)
  EventManager.Add("AfterEnterModule", ModuleManager, OnEvent_AfterEnterModule)
  EventManager.Add("AdventureModuleEnter", ModuleManager, OnEvent_AdventureModuleEnter)
end

function ModuleManager.GetIsAdventure()
  return bAdventure
end

function ModuleManager.GetCurModuleName()
  return curModuleName
end

return ModuleManager
