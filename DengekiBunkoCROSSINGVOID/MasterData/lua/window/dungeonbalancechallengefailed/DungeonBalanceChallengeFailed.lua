local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local BASE = inherit("Window/DungeonBalanceFailed/DungeonBalanceFailed", _ENV)

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonCheckHint, OnButtonCheckHintClick)
end

function InitWindow()
  m_fightDungeonType = this:GetData("FightDungeonType")
  BASE.InitDungeonName()
  InitDungeonFailedText()
  BASE.SetContinueButtons()
end

function OnButtonCheckHintClick()
  ShowHint(true, false, false)
end

function ShowHint(showHint, showToCheck, showFinding)
  WU.ToggleRendering(REF.NodeHint, showHint)
  WU.ToggleRendering(REF.LabelHintToCheck, showToCheck)
  WU.ToggleRendering(REF.ButtonCheckHint, showToCheck)
  WU.ToggleRendering(REF.LabelHintFinding, showFinding)
end

function InitDungeonFailedText()
  ShowHint(false, false, true)
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  if dungeonId then
    local dungeonMonster = PB.get("DungeonMonster", dungeonId)
    if dungeonMonster ~= nil then
      if this:GetData("DungeonBalance/result").loseNum > dungeonMonster.showHintLoseNumThreshold then
        for i = 1, 2 do
          local localizationIndex = dungeonMonster.failedDesc[i]
          local hasHint = localizationIndex ~= nil and localizationIndex ~= 0
          REF["LabelHint" .. i].gameObject:SetActive(hasHint)
          if hasHint then
            REF["LabelHint" .. i].UIHtmlLabel.text = WU.GetString("Window_DungeonFailedText" .. localizationIndex)
          end
        end
        if dungeonMonster.showHintLoseNumThreshold == 0 then
          ShowHint(true, false, false)
        else
          ShowHint(false, true, false)
        end
      end
    else
      error("Dungeon", "DungeonMonster.xlsx error, Can't find " .. dungeonId)
    end
  else
    error("Dungeon", " dugneonId = " .. tostring(dungeonId))
  end
end
