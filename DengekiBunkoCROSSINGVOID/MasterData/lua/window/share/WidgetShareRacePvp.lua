local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetShareInfo(data)
  if data.highScore then
    REF.LabelHighScore.UILabel.text = data.highScore
  end
  REF.LabelGradeName.UILabel.text = WU.GetString(string.format("PVPREALRACE_GRADE_%d_%d", data.seg, data.subSeg))
  if data.actorIds then
    for i = 0, #REF.GroupActors - 1 do
      local actorId = data.actorIds[i + 1]
      if actorId then
        local actorConfig = PB.get("ActorConfig", actorId)
        local actorData = {
          animRes = actorConfig.animRes,
          unlock = true,
          kind = actorConfig.kind,
          id = actorConfig.id
        }
        REF.GroupActors[i]["$$SetData"](actorData)
        REF.GroupActors[i]["$$SetSelected"](false)
      else
        REF.GroupActors[i]["$$SetEmpty"]()
      end
    end
  end
  REF.EffectGrade.EffectGenerator.m_EffectName = "UI_DecrepitDream_ChangeL" .. data.seg
  REF.EffectGrade.EffectGenerator:Reset()
end
