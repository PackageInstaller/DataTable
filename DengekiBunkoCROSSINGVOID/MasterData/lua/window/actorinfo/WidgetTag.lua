local WU, DB, REF = require("Common/WindowUtil")(this)
local SE = require("Common/SkillEffect")

function SetSkillCost(costSp, costMp)
  if 0 < costSp then
    REF["$UISprite"].color = CS.NGUIMath.HexToColor(4292290303)
    REF.LabelText.UIHtmlLabel.text = "<font color=#835942>" .. costSp .. WU.GetString("Window_SPCost") .. "</font>"
  else
    REF["$UISprite"].color = CS.NGUIMath.HexToColor(10289151)
    REF.LabelText.UIHtmlLabel.text = "<font color=#FFFFFF>" .. costMp .. WU.GetString("Window_MPCost") .. "</font>"
  end
end

function SetPassive()
  REF["$UISprite"].color = CS.NGUIMath.HexToColor(4294967295)
  REF.LabelText.UIHtmlLabel.text = "<font color=#486B8F>" .. WU.GetString("Window_ActorPassiveSkill") .. "</font>"
end

function SetSkillKind(skillId)
  local actorCombo = SE.GetActorSkillCombo(skillId)
  SetKind(actorCombo.kindIcon)
end

function SetKind(kindIcon)
  REF["$UISprite"].color = CS.NGUIMath.HexToColor(4294967295)
  REF.LabelText.UIHtmlLabel.text = "<font color=#486B8F>" .. WU.GetString(kindIcon) .. "</font>"
end

function SetUnlockTips(unlockStarCount)
  REF["$UISprite"].color = CS.NGUIMath.HexToColor(2342238463)
  REF.LabelText.UIHtmlLabel.text = "<font color=#FFFFFF>" .. WU.GetString("Window_starCountToUnlock", unlockStarCount) .. "</font>"
end
