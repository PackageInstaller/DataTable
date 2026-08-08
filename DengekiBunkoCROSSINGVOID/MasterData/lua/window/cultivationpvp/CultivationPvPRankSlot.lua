local WU, DB, REF = require("Common/WindowUtil")(this)
local mPlayerRankInfo
local mChanged = false

function SetView(info)
  mChanged = true
  mPlayerRankInfo = info
  WU.ToggleRendering(REF["$"], mPlayerRankInfo ~= nil)
  if info == nil then
    return
  end
  if mPlayerRankInfo.actorGroup then
    REF.WidgetDungeonGroup["$SetViewByActors"](mPlayerRankInfo.actorGroup, true)
    WU.ToggleRendering(REF.WidgetDungeonGroup, true)
    WU.ToggleRendering(REF.HideGroup, false)
  else
    WU.ToggleRendering(REF.WidgetDungeonGroup, false)
    WU.ToggleRendering(REF.HideGroup, true)
  end
  if mPlayerRankInfo.playerName then
    WU.SetActive(REF.PlayerName, true)
    REF.PlayerName.UILabel.text = mPlayerRankInfo.playerName
  else
    WU.SetActive(REF.PlayerName.UILabel, false)
  end
  if mPlayerRankInfo.score then
    WU.SetActive(REF.PlayerCultivation, true)
    REF.PlayerCultivation.UILabel.text = WU.GetString("CultivationPvP_PlayerRank2", -mPlayerRankInfo.score)
  else
    WU.SetActive(REF.PlayerCultivation, false)
  end
  if mPlayerRankInfo.rank then
    WU.SetActive(REF.Rank, true)
    REF.Rank.UILabel.text = mPlayerRankInfo.rank
  else
    WU.SetActive(REF.Rank, false)
  end
  if mChanged then
    PlayTween()
    mChanged = false
  end
end

function ClearSlot()
  mPlayerRankInfo = nil
  mChanged = false
  WU.ToggleRendering(REF["$"], false)
end

function PlayTween()
  local playTween = REF["$"].UIPlayTween
  if playTween ~= nil then
    playTween:Play(true)
  end
end
