local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local SDU = require("Common/SoundUtil")
local m_kAll, m_kNowActor, m_kNowSelectedGoRef, m_nowTheActorAudioSource, defaultSignboardId

function SetupWindow()
  local _, defaultConfig = table.find(PB.all("Signboard"), function(_, v)
    return v.type == PB.enum.SignboardType.Virtual
  end)
  defaultSignboardId = defaultConfig.signboardId
  WU.BindButtonEvent(REF.BtnClose, function()
    WU.RecordButtonClick(100134203)
    WU.DestroyWindow(this)
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = OnInitBoarditem
  })
  WU.BindButtonEvent(REF.ButtonDefault, function()
    if this:GetData("BoardActor/RoleId") ~= defaultSignboardId then
      RequestSetSignboard(defaultSignboardId)
    end
  end)
end

function InitWindow()
  this:Bind("BoardActor/RoleId", function(boardId)
    local xlsxConfig = PB.get("Signboard", boardId)
    if xlsxConfig.type == PB.enum.SignboardType.Virtual then
      REF.LabelDefault.UILabel.text = WU.GetString("Window_Signboard_Button_Default")
    else
      REF.LabelDefault.UILabel.text = WU.GetString("Window_Signboard_Button_RestoreDefault")
    end
  end)
  if this:GetData("BoardActor/RoleId") ~= defaultSignboardId then
    WU.TriggerUnforcedTutorial(1123)
  end
end

function SetActor(actor)
  m_kNowActor = actor
end

function InitData()
  m_kAll = {}
  local all = PB.all("Signboard")
  for _, v in pairs(all) do
    if v.roleId == m_kNowActor.roleId then
      local now = CS.GameTime.serverUtc
      local showTime = 0
      if v.activeTime and v.activeTime ~= "" then
        showTime = CS.GameTime.ServerTimeStrToUtc(v.activeTime)
      end
      if now > showTime then
        local tab = {}
        tab.signboardId = v.signboardId
        tab.roleId = v.roleId
        tab.type = v.type
        tab.emote = v.BoardOfEmote
        tab.unlocked = false
        tab.favourLevel = v.FavourLevel
        tab.unlockType = v.unlockType
        tab.roleNotepadRes = v.roleNotepadRes
        tab.checkResUnlock = v.checkResUnlock
        tab.checkRes = v.checkRes
        tab.unlocked = GetSignboardStatus(tab)
        if v.type == 1 then
          tab.res = v.BoardOfEmote
        elseif v.type == 2 then
          tab.res = v.BoardOfAnimRes
        end
        table.insert(m_kAll, tab)
      end
    end
  end
  local len = #m_kAll
  if len < 6 then
    REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
  else
    REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
  end
  LU.Set(REF.WrapContent, len)
end

function GetSignboardStatus(tab)
  if tab.unlockType ~= PB.enum.SignboardUnlockType.ActorSignboardGift and tab.unlockType ~= PB.enum.SignboardUnlockType.ActorEverGotAndFavourLevel then
    if tab.favourLevel <= m_kNowActor.favourLevel then
      return true
    end
  else
    local unlockedSignboard = DB:GetData("BoardActor/AllUnlocked") or _ENV["!"]({})
    local _, v = table.find(unlockedSignboard, function(k, v)
      return v == tab.signboardId
    end)
    return v ~= nil
  end
end

function OnInitBoarditem(goRef, wrapIndex, realIndex)
  if m_kAll and realIndex < #m_kAll then
    local data = m_kAll[realIndex + 1]
    goRef["$$SetData"](data)
    goRef["$$SetClickCallback"](function(go)
      WU.RecordButtonClick(100134201)
      if not data.unlocked then
        local tab = PB.get("Signboard", data.signboardId)
        local type = tab.unlockType
        if type == PB.enum.SignboardUnlockType.ActorEverGotAndFavourLevel then
          WU.ShowHintText(WU.GetString("Notepad_required", data.favourLevel))
        else
          WU.ShowHintText(WU.GetString("Error_SignboardLocked"))
        end
        return
      end
      if data.signboardId ~= this:GetData("BoardActor/RoleId") then
        RequestSetSignboard(data.signboardId)
      end
    end)
  end
end

function UninitWindow()
  if m_nowTheActorAudioSource ~= nil then
    m_nowTheActorAudioSource:Stop()
    m_nowTheActorAudioSource = nil
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001342, on)
end

function RequestSetSignboard(signboardId)
  this:GameRequest("fci/Signboard/"):Put({signboard = signboardId}, function(result)
    local xlsxConfig = PB.get("Signboard", result.signboard)
    this:BroadcastGameEvent("BoardActorChanged", result.signboard)
    if m_nowTheActorAudioSource ~= nil then
      m_nowTheActorAudioSource:Stop()
      m_nowTheActorAudioSource = nil
    end
    if xlsxConfig.type == PB.enum.SignboardType.Virtual then
      WU.ShowHintText(WU.GetString("Window_Signboard_Hint_SetDefault"))
      m_nowTheActorAudioSource = SDU.PlaySaku()
    else
      WU.ShowHintText(WU.GetString("Window_Signboard_Hint_SetActor", WU.GetString("RoleName_" .. xlsxConfig.roleId)))
      m_nowTheActorAudioSource = SDU.PlayActorNotePad(m_kNowActor.roleId, true, signboardId)
    end
    this:SetData("BoardActor/RoleId", result.signboard)
    InitData()
  end)
end
