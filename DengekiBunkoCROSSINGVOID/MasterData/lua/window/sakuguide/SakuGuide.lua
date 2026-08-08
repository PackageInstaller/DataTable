local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetContent(text, text1, text2, callback, backCallback)
  if text then
    REF.LabelTalk.UILabel.text = text
  end
  if text1 then
    REF.LabelEnter.UILabel.text = text1
  end
  if text2 then
    REF.LabelBack.UILabel.text = text2
  end
  WU.SetActive(REF.ButtonEnter, text1)
  WU.SetActive(REF.ButtonBack, text2)
  REF.Black.BoxCollider2D.enabled = text1 == nil and text2 == nil
  if callback then
    WU.BindButtonEvent(REF.ButtonEnter, callback)
  else
    WU.BindButtonEvent(REF.ButtonEnter, DefaultCallback)
  end
  if backCallback then
    WU.BindButtonEvent(REF.ButtonBack, backCallback)
  else
    WU.BindButtonEvent(REF.ButtonBack, DefaultCallback)
  end
  REF.LabelTalk.TypewriterEffect:ResetToBeginning()
  REF.Saku.EffectGenerator:Reset()
  REF.Saku.EffectGenerator:Play()
end

function DefaultCallback()
  WU.RecycleWindow("SakuGuide")
end
