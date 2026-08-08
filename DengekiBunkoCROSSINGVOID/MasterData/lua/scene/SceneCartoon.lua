local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local m_returnWindow, autoData

function Start()
  local func
  local cartoonId = this:GetData("CartoonInfo/CartoonId")
  m_returnWindow = this:GetData("CartoonInfo/CartoonWindow")
  if m_returnWindow == nil then
    local exParam = this:GetData("CartoonInfo/CartoonExParam")
    if exParam == "endfight" then
      func = EndFight
    elseif exParam == "balance" then
      func = EnterBalance
    elseif exParam == "nextcartoon" then
      func = NextCartoon
    elseif exParam == "TutorialActorGroup" then
      func = TutorialActorGroup
    else
      func = EnterFight
    end
  else
    func = ReturnToCity
  end
  local cartoon = PB.get("CartoonConfig", cartoonId)
  if cartoon ~= nil then
    PlayCartoon(cartoon.id, func)
  else
    func()
  end
  this:SetData("CartoonInfo/CartoonId", nil)
  this:SetData("CartoonInfo/CartoonWindow", nil)
  this:SetData("CartoonDanmu/ShowState", nil)
  this:SetData("CartoonDanmu/SendMessage", nil)
  this:SetData("CartoonDanmu/SwitchState", nil)
  autoData = this:GetData("fci/autoFightSetting/")
  if autoData == nil then
    autoData = {}
  end
  local danmu_val = autoData["3"]
  if danmu_val ~= nil and danmu_val ~= 0 then
    this:SetData("CartoonDanmu/SwitchState", true)
  end
end

function PlayCartoon(id, callback)
  CS.CartoonManager.Instance:PlayCartoon(id, callback, false, true)
end

function EnterFight()
  RecordDanmuState()
  CS.GameGlobal.Instance:LoadGameLevel(tostring(this:GetData("WindowDungeon/DungeonId")))
end

function ReturnToCity()
  RecordDanmuState()
  local s, e = string.find(m_returnWindow, "EventCNYStageChapter")
  if s and e then
    DB:SetData("WelfareTab", "ChineseNewYear")
  end
  local exParam = this:GetData("CartoonInfo/CartoonExParam")
  if exParam then
    local s, e, tab
    s, e = string.find(exParam, "Welfare/")
    if s and e then
      local splits = string.split(exParam, "/")
      tab = splits[2]
      DB:SetData("WelfareTab", tab)
    end
  end
  WU.ReturnCity(m_returnWindow)
end

function EndFight()
  RecordDanmuState()
  WU.ExitStoryDungeon()
end

function EnterBalance()
  RecordDanmuState()
  CS.SoundManager.Instance:StopCurrentMusic()
  CS.GameGlobal.Instance:ChangeLevel("SceneBalance")
end

function RecordDanmuState()
  if autoData == nil then
    autoData = {}
  end
  local switchState = this:GetData("CartoonDanmu/SwitchState")
  if switchState ~= nil then
    if switchState then
      autoData["3"] = 1
    else
      autoData["3"] = 0
    end
  end
  this:SetData("fci/autoFightSetting/", autoData)
  DU.SendAutoFightSetting()
end

function NextCartoon()
  local nextCartoon = DB:GetData("Cartoon/NextCartoon")
  if nextCartoon == nil then
    ReturnToCity()
  else
    WU.EnterCartoonLevel(nextCartoon, "Portal, JourneyStory")
  end
end

function TutorialActorGroup()
  WU.AcquireWindowAsync("ActorGroup", function(win)
    this:SetData("ActorGroup/DungeonId", 2013)
    this:SetData("ActorGroup/ChapterId", 1001)
    _ENV["$"](win)["$$TutorialOnly"]()
  end)
end
