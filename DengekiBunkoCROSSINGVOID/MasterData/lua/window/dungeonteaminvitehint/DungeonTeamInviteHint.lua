local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local m_data

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonJoin, function()
    local function Join()
      DU.IsInDungeonTeamPrepare(function()
        DU.SetDungeonTeamUrl(m_data.url)
        
        WU.AcquireWindowAsync("DungeonTeamPrepare", function(ui)
          _ENV["$"](ui)["$$JoinRoom"](m_data.roomId, m_data.activityId, m_data.dungeonId)
          _ENV["$"](ui)["$$InitBackAndHomeCallback"]()
        end)
      end)
      WU.RecycleWindow(this)
    end
    
    if m_data and not DU.IsWaitingForJob(Join) then
      Join()
    end
  end)
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  this:DelayInvokeInSeconds(3, function()
    WU.RecycleWindow(this)
  end)
  REF.Content.gameObject:SetActive(false)
  this:Bind("fci/teamdungeongroups/", SetTitle)
end

function SetData(data)
  m_data = data
  REF.DungeonLabel.gameObject:SetActive(false)
  local activityId2GroupId = this:GetData("fci/teamdungeongroups/")
  if activityId2GroupId == nil then
    DB:SyncRemote(DB:GameRequest("fci/teamdungeongroups/"):SyncInput(false))
  else
    SetTitle(activityId2GroupId)
  end
  REF.PlayerName.UILabel.text = data.name
  REF.Content.gameObject:SetActive(true)
end

function SetTitle(activityId2GroupId)
  if activityId2GroupId ~= nil and m_data ~= nil then
    local dungeonReward = PB.get("DungeonReward", tonumber(m_data.dungeonId))
    local level = 0
    if dungeonReward then
      level = dungeonReward.difficultLevelLow
    else
      warning("DungeonTeam", "DungeonReward.xlsx no dungeonId : " .. tostring(m_data.dungeonId))
    end
    local activityName = WU.GetString("DungeonTeamName_" .. activityId2GroupId[tostring(m_data.activityId)])
    REF.DungeonLabel.UIHtmlLabel.text = "<l width=100%><c width=60% align=left>" .. HU.ApplyFontStyle(activityName, nil, "#FFFFFFFF", 36) .. "</c><c width=40% align=right>" .. WU.GetString("DungeonTeam_DifficultLevel", level) .. "</c></l>"
    REF.DungeonLabel.gameObject:SetActive(true)
  end
end
