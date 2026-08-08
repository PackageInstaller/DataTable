local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonPrepare, OnPrepareClick)
end

function InitWindow()
  local info = this:GetData("fci/RacePVPInfo")
  SetOpponents(info.dungeonId)
  REF.Record.UILabel.text = info.battleScore
  this:SetData("WindowDungeon/DungeonId", info.dungeonId)
  this:Bind("RacePVPisInActivity", ChangeBackground)
end

function OnPrepareClick()
  WU.RecordButtonClick(100126101)
  GU.SetGroupMode(PB.enum.ActorGroupType.RacePvp)
  this:SetData("ActorGroup/DungeonType", PB.enum.DungeonType.RacePVP)
  WU.AcquireWindowAsync("RacePVPActorGroup")
end

function SetOpponents(dungeonId)
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  if dungeonMonster == nil then
    error("RacePVPPrepare", "no dungeonId " .. dungeonId .. " in DungeonMonster! ")
    return
  end
  local actors = GU.MonsterGroup(dungeonMonster.monsterId)
  REF.WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
  REF.AffixWidget["$ShowAffixWidget"](dungeonId)
end

function ChangeBackground(isInActivity)
  if isInActivity ~= nil then
    REF.EffectBG.EffectGenerator.m_EffectName = fif(isInActivity, "UI_DecrepitDream_bg2b", "UI_DecrepitDream_bg2")
    REF.EffectBG.EffectGenerator:Reset()
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001261, on)
end
