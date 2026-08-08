local WU, DB, REF = require("Common/WindowUtil")(this)
local m_previewCallback

function Start()
  WU.BindButtonEvent(REF.ButtonPrizePreview, OnPrizePreview)
  WU.ToggleRendering(REF.ButtonPrizePreview, false)
  m_previewCallback = nil
end

function SetPrizeData(prizes)
  for i = 0, #REF.GridPrizes - 1 do
    local itemRef = REF.GridPrizes[i]
    if i < #prizes then
      local prize = prizes[i + 1]
      WU.ToggleRendering(itemRef["$"], true)
      itemRef["$$SetData"](prize.type, prize.id, prize.count)
    else
      WU.ToggleRendering(itemRef["$"], false)
    end
  end
  REF.GridPrizes.UIGrid:Reposition()
end

function SetPrizeTitle(title)
  _ENV["$"](REF.NodePrizeTitle).Label.UIHtmlLabel.text = title
end

function SetPreviewCallback(callback)
  m_previewCallback = callback
  WU.ToggleRendering(REF.ButtonPrizePreview, true)
end

function OnPrizePreview(go)
  if m_previewCallback then
    m_previewCallback()
  end
end
