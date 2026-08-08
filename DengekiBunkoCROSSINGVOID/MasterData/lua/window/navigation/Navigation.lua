local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_tutorialMgr = S:Get("TutorialManager")
local m_config, m_backCallback, m_homeCallback
local m_ruleCallback = {}
local m_windowTitle = {}
local m_repeatedContext = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonBack, function()
    WU.RecordButtonClick(997)
    OnBackWindow()
  end)
  WU.BindButtonEvent(REF.ButtonBackHome, function()
    WU.RecordButtonClick(996)
    OnHomeWindow()
  end)
  WU.BindButtonEvent(REF.ButtonRule, function()
    WU.RecordButtonClick(990)
    OnRuleClick()
  end)
  WU.BindKeyEvent(REF.ButtonBack, OnBackWindow)
end

function InitWindow()
  this:RegisterGameEvent("NavigationDisplay", function(flag)
    WU.ToggleRendering(REF["$"], flag)
  end)
  this:Bind("NavigationContext", OnWindowChange)
  this:Bind("WindowRuleCallback", OnRuleChange)
  this:Bind("WindowTitle", OnTitleChange)
end

function Save()
  table.insert(m_repeatedContext, {backCallback = m_backCallback, homeCallback = m_homeCallback})
end

function Load()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    m_backCallback = context.backCallback
    m_homeCallback = context.homeCallback
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnWindowChange(context)
  local have_tex = false
  m_config = nil
  if context and context ~= "" then
    m_config = PB.get("UIWindowConfig", context)
  end
  SetTitle()
  SetRuleIcon()
end

function OnRuleChange(list)
  if list ~= nil then
    m_ruleCallback = list
    SetRuleIcon()
  end
end

function OnTitleChange(list)
  if list ~= nil then
    m_windowTitle = list
    SetTitle()
  end
end

function OnBackWindow()
  if m_backCallback then
    m_backCallback()
  else
    Back()
  end
end

function OnHomeWindow()
  if m_homeCallback then
    m_homeCallback()
  else
    Home()
  end
end

function OnRuleClick()
  if m_ruleCallback[m_config.name] ~= nil then
    m_ruleCallback[m_config.name]()
  else
    Rule()
  end
end

function SetTitle()
  local language = "chs"
  if m_config ~= nil and m_config.showNavigation then
    local path = "Texture/WindowTitle/" .. language .. "/window_title_"
    if m_windowTitle[m_config.name] ~= nil then
      path = path .. m_windowTitle[m_config.name]
    else
      path = path .. m_config.name
    end
    REF.TextureTitle.UITexture.mainTexturePath = path
    REF.TextureTitle.UITexture:MakePixelPerfect()
  else
    REF.TextureTitle.UITexture.mainTexturePath = nil
  end
end

function SetRuleIcon()
  WU.ToggleRendering(REF.SpriteRule, m_config ~= nil and (m_config.ruleWindow ~= "" or m_ruleCallback[m_config.name] ~= nil))
end

function Back()
  this:BroadcastGameEvent("OnNavigation", "Back")
end

function Home()
  local winName = "City"
  if WU.IsStandaloneGame() then
    winName = "StoryMode"
  end
  m_tutorialMgr.SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function Rule()
  if m_config ~= nil and m_config.ruleWindow ~= "" then
    if m_config.ruleWindow == "RuleCommon" then
      WU.AcquireWindowAsync("RuleCommon", function(ui)
        _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_" .. m_config.name))
      end)
    else
      WU.AcquireWindowAsync(m_config.ruleWindow)
    end
  end
end

function SetBackCallback(callback)
  m_backCallback = callback
end

function SetHomeCallback(callback)
  m_homeCallback = callback
end
