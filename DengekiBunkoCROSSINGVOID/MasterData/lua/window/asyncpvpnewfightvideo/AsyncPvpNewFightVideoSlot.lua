local WU, DB, REF = require("Common/WindowUtil")(this)
local TPU = require("Common/TopPvpUtil")
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local m_fightInfo
local m_gradeList = {}

function Awake()
  WU.SetActive(REF.ButtonShare, false)
  WU.SetActive(REF.ButtonReview, false)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.AcquireWindowAsync("AsyncPvpNewFightVideoShare", function(window)
      _ENV["$"](window)["$$SetDungeonUid"](m_fightInfo.dungeonUid)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonReview, function()
    if not DU.IsWaitingForJob(WatchVideo) then
      WatchVideo()
    end
  end)
  m_gradeList = PB.all("AsyncPvpRankReward")
end

function SetView(info)
  m_fightInfo = info
  local leftIndex = 1
  local rightIndex = 2
  if info.playerInfos[leftIndex].playerId ~= this:GetData("playerId") then
    local temp = leftIndex
    leftIndex = rightIndex
    rightIndex = temp
  end
  SetPlayerInfo(info.playerInfos[leftIndex], _ENV["$"](REF.Player1), fif(m_fightInfo.winTeam == leftIndex, true, false))
  SetPlayerInfo(info.playerInfos[rightIndex], _ENV["$"](REF.Player2), fif(m_fightInfo.winTeam == rightIndex, true, false))
  local time = CS.GameTime.UtcToLocal(info.balanceTime)
  REF.LabelTime.UILabel.text = WU.GetString("Window_Year_Month_Day", time.Year, time.Month, time.Day)
  REF.LabelTime2.UILabel.text = time.Hour .. ":" .. fif(time.Minute < 10, "0" .. time.Minute, time.Minute)
end

function SetPlayerInfo(playerInfo, refPlayer, win)
  local seg = math.clamp(playerInfo.seg, 1, #m_gradeList)
  refPlayer.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](playerInfo)
  refPlayer.SpriteSeg.UISprite.spriteName = "illusion_level_" .. m_gradeList[seg].segRank
  refPlayer.SpriteSubSeg.UISprite.spriteName = "level_" .. m_gradeList[seg].subSegRank
  WU.SetActive(refPlayer.SpriteWin, win)
  refPlayer.PlayerName.UILabel.text = playerInfo.name
  refPlayer.Score.UILabel.text = WU.GetString("NAsyncPvp_Score") .. ":" .. playerInfo.score
  WU.SetActive(refPlayer.Score, false)
  WU.TraverseChildren(refPlayer.ActorGroup, function(go, i)
    _ENV["$"](go)["$$SetActor"](playerInfo.actorList[i + 1])
  end)
end

function WatchVideo()
  DU.PlayReplay(m_fightInfo.dungeonUid, PB.enum.DungeonType.AsyncPvpV2, "Activity, AsyncPvpNew, AsyncPvpNewFightVideo")
end
