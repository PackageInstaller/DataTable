local WU, DB, REF = require("Common/WindowUtil")(this)
local GotoUtil = require("Common/GotoUtil")
local AU = require("Common/ActorUtil")

function SetDataBySkinId(skinId, actorId)
  REF.LabelSkinName.UILabel.text = WU.GetString("ActorSkinName_" .. skinId)
  REF.LabelSkinDesc.UILabel.text = WU.GetStringEmpty("ActorSkinDesc_" .. skinId)
  local actorIds = AU.GetSkinActors(skinId)
  for i = 0, #REF.GridApplicable - 1 do
    local actorId = actorIds[i + 1]
    local refIcon = REF.GridApplicable[i]
    WU.ToggleRendering(refIcon.root, actorId ~= nil)
    if actorId then
      refIcon["$$SetData"](actorId)
    end
  end
  REF.TexturePreview.ActorUIPreview:ResetActor(actorId or actorIds[1], AU.GetActorPaletteIndex(actorIds[1], skinId))
end
