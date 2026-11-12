local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local TimerManager = require("GameCore.Timer.TimerManager")
local AvgManager = {}
local objAvgPanel, objAvgBubblePanel
local nTransitionType = 0
local bInAvg = false
local bKeepEndTransition = false

local function OnEvent_AvgBBEnd(_)
  if objAvgBubblePanel ~= nil then
    objAvgBubblePanel:_PreExit()
    objAvgBubblePanel:_Exit()
    objAvgBubblePanel:_Destroy()
    objAvgBubblePanel = nil
  end
end

local function OnEvent_AvgBBStart(_, sAvgId, sGroupId, sLanguage, sVoLan)
  OnEvent_AvgBBEnd(_)
  local AvgBubblePanel = require("Game.UI.AvgBubble.AvgBubblePanel")
  if sLanguage == nil then
    sLanguage = Settings.sCurrentTxtLanguage
  end
  if sVoLan == nil then
    sVoLan = Settings.sCurrentVoLanguage
  end
  objAvgBubblePanel = AvgBubblePanel.new(AllEnum.UI_SORTING_ORDER.AVG_Bubble, PanelId.AvgBB, {
    sAvgId,
    sGroupId,
    sLanguage,
    sVoLan
  })
  objAvgBubblePanel:_PreEnter()
  objAvgBubblePanel:_Enter()
end

local function OnEvent_AvgSTStart(_, sAvgId, sLanguage, sVoLan, sGroupId, nStartCMDID, sTransStyle, bKeepTransitionOnEnd)
  local nStyle = 11
  bKeepEndTransition = bKeepTransitionOnEnd == true
  if type(sTransStyle) == "string" and sTransStyle ~= "" then
    local sStyle = string.gsub(sTransStyle, "style_", "")
    local _n = tonumber(sStyle)
    if type(_n) == "number" then
      nStyle = _n
    end
  end
  bInAvg = true
  
  local function func_DoStart()
    if sLanguage == nil then
      sLanguage = Settings.sCurrentTxtLanguage
    end
    if sVoLan == nil then
      sVoLan = Settings.sCurrentVoLanguage
    end
    OnEvent_AvgBBEnd(_)
    local AvgPanel = require("Game.UI.Avg.AvgPanel")
    objAvgPanel = AvgPanel.new(AllEnum.UI_SORTING_ORDER.AVG_ST, PanelId.AvgST, {
      sAvgId,
      sLanguage,
      sVoLan,
      sGroupId,
      nStartCMDID
    })
    objAvgPanel:_PreEnter()
    objAvgPanel:_Enter()
    if nTransitionType == 12 then
      nTransitionType = 0
    end
  end
  
  local function func_OnEvent_TransAnimInClear()
    EventManager.Hit(EventId.SetTransition)
    func_DoStart()
  end
  
  if AVG_EDITOR == true then
    func_DoStart()
  elseif sAvgId == Settings.sPrologueAvgId1 or sAvgId == Settings.sPrologueAvgId2 then
    EventManager.Hit(EventId.HideProloguePanle, false)
    EventManager.Hit("__CloseLoadingView", nil, nil, 0.5)
    func_DoStart()
  else
    local sAvgIdHead = string.sub(sAvgId, 1, 2)
    if sAvgIdHead == "ST" or sAvgIdHead == "CG" or sAvgIdHead == "DP" then
      nTransitionType = sAvgIdHead == "DP" and 12 or nStyle
      EventManager.Hit(EventId.SetTransition, nTransitionType, func_OnEvent_TransAnimInClear)
    else
      func_DoStart()
    end
  end
end

local function OnEvent_AvgSTEnd(_)
  local function func_AvgSTEnd()
    EventManager.Hit("AvgSTEnd")
  end
  
  local function func_DoEnd()
    NovaAPI.DispatchEventWithData("StoryDialog_DialogEnd")
    if objAvgPanel ~= nil then
      objAvgPanel:_PreExit()
      objAvgPanel:_Exit()
      objAvgPanel:_Destroy()
      objAvgPanel = nil
      NovaAPI.SetScreenSleepTimeout(false)
    end
    bInAvg = false
  end
  
  local function func_OnEvent_TransAnimInClear()
    if bKeepEndTransition ~= true then
      EventManager.Hit(EventId.SetTransition)
    end
    bKeepEndTransition = false
    func_DoEnd()
    func_AvgSTEnd()
  end
  
  if nTransitionType ~= 0 then
    EventManager.Hit(EventId.SetTransition, nTransitionType, func_OnEvent_TransAnimInClear)
    nTransitionType = 0
  else
    bKeepEndTransition = false
    func_DoEnd()
    func_AvgSTEnd()
  end
end

function AvgManager.ForceCloseAll(_)
  if objAvgPanel ~= nil then
    objAvgPanel:_PreExit()
    objAvgPanel:_Exit()
    objAvgPanel:_Destroy()
    objAvgPanel = nil
  end
  OnEvent_AvgBBEnd(_)
  bInAvg = false
  nTransitionType = 0
  bKeepEndTransition = false
  NovaAPI.SetScreenSleepTimeout(false)
end

local function Uninit(_)
  if objAvgPanel ~= nil then
    OnEvent_AvgSTEnd(_)
  end
  EventManager.Remove("StoryDialog_DialogStart", AvgManager, OnEvent_AvgSTStart)
  EventManager.Remove("StoryDialog_DialogEnd", AvgManager, OnEvent_AvgSTEnd)
  OnEvent_AvgBBEnd(_)
  EventManager.Remove(EventId.AvgBubbleShow, AvgManager, OnEvent_AvgBBStart)
  EventManager.Remove(EventId.AvgBubbleExit, AvgManager, OnEvent_AvgBBEnd)
  EventManager.Remove("ForceCloseAllBeforeBackLogin", AvgManager, AvgManager.ForceCloseAll)
  EventManager.Remove(EventId.CSLuaManagerShutdown, AvgManager, Uninit)
end

function AvgManager.Init()
  EventManager.Add("StoryDialog_DialogStart", AvgManager, OnEvent_AvgSTStart)
  EventManager.Add("StoryDialog_DialogEnd", AvgManager, OnEvent_AvgSTEnd)
  EventManager.Add(EventId.AvgBubbleShow, AvgManager, OnEvent_AvgBBStart)
  EventManager.Add(EventId.AvgBubbleExit, AvgManager, OnEvent_AvgBBEnd)
  EventManager.Add("ForceCloseAllBeforeBackLogin", AvgManager, AvgManager.ForceCloseAll)
  EventManager.Add(EventId.CSLuaManagerShutdown, AvgManager, Uninit)
end

function AvgManager.CheckInAvg()
  return bInAvg
end

return AvgManager
