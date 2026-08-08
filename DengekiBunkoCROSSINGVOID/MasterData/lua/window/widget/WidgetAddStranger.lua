local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local m_gameObject, m_aura, m_timeout

function Awake()
  WU.BindButtonEvent(REF.AddStranger, OnButtonAddStranger)
  WU.BindButtonEvent(REF.ButtonApply, OnButtonApply)
  this:RegisterGameEvent("AddAuraStranger", AddAuraStrangerAsync)
  m_gameObject = REF.AddStrangerTips.gameObject
  m_gameObject:SetActive(false)
  REF.AddStranger.gameObject:SetActive(true)
  REF.root.gameObject:SetActive(false)
end

function OnButtonAddStranger()
  if m_timeout ~= nil then
    this:StopCoroutine(m_timeout)
    m_timeout = nil
  end
  m_gameObject:SetActive(not m_gameObject.activeSelf)
end

function AddAuraStrangerAsync()
  local preferences = m_configDataManager.GetPreferences()
  if preferences.auraHintControl then
    local dungeonType = this:GetData("FightDungeonType")
    if not (dungeonType ~= PB.enum.DungeonType.Normal or this:GetData("IsCultivationPVPMode")) or dungeonType == PB.enum.DungeonType.WeekActivity or dungeonType == PB.enum.DungeonType.Gold or dungeonType == PB.enum.DungeonType.Triggered or dungeonType == PB.enum.DungeonType.SemiFixed then
      local aura = this:GetData("Assistant/Aura")
      local preferences = m_configDataManager.GetPreferences()
      this:SetData("Assistant/Aura", nil)
      if aura and aura.stranger then
        REF.root.gameObject:SetActive(true)
        m_aura = aura
        REF.LabelRoleName.UIHtmlLabel.text = WU.GetString("Window_AddStrangerTips", m_aura.name)
        m_gameObject:SetActive(true)
        m_timeout = this:DelayInvokeInSeconds(5, OnButtonAddStranger)
      end
    end
  end
  this:BroadcastGameEvent("RePosAddStrangerGrid")
end

function OnButtonApply()
  if m_timeout ~= nil then
    this:StopCoroutine(m_timeout)
    m_timeout = nil
  end
  local playerId = DB:GetData("playerId")
  local hideFirsMessage = WU.GetGameDataCache("ShowHelpMessage" .. playerId)
  if hideFirsMessage == nil then
    WU.SetGameDataCache("ShowHelpMessage" .. playerId, true)
    WU.AcquireWindowAsync("AddStrangerTips", function(UI)
      _ENV["$"](UI)["$$SetCallBack"](OnButtonApply)
    end)
  else
    if m_aura ~= nil then
      WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
      this:GameRequest("fci/applyfriend/"):Post({
        targetId = m_aura.playerId
      }, function(result)
        WU.RecycleWindow(this)
      end)
    end
    REF.root.gameObject:SetActive(false)
    this:BroadcastGameEvent("RePosAddStrangerGrid")
  end
end
