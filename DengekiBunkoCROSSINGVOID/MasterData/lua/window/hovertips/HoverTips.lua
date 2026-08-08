local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("common/HtmlUtil")

function SetupWindow()
  REF.Black["$SetCallback"](Hide)
  REF.BG.UISprite:UpdateAnchors()
end

function Hide()
  WU.RecycleWindow(this)
end

function SetTitleDescription(title, description)
  local text = HU.ApplyFontSize(title, 38) .. HU.HtmlSplitLine("Common.Line_dark") .. HU.ApplyFontSize(description, 32)
  SetContent(text)
end

function SetTitleDescription2(title, desc1, desc2, desc3, desc4, desc5, desc6)
  REF.Label1.UIHtmlLabel.text = desc1
  REF.Label2.UIHtmlLabel.text = desc2
  REF.Label3.UIHtmlLabel.text = desc3
  REF.Label4.UIHtmlLabel.text = desc4
  REF.Label5.UIHtmlLabel.text = desc5
  REF.Label6.UIHtmlLabel.text = desc6
  local text = HU.ApplyFontSize(title, 38) .. HU.HtmlSplitLine("Common.Line_dark")
  SetContent(text)
end

function SetContent(content)
  REF.Label.UIHtmlLabel.text = content
  REF.BG.UISprite:UpdateAnchors()
  ShowType(0)
end

function ShowType(type)
  if type == 0 then
    REF.Black.gameObject:SetActive(false)
    UpdatePosition()
  elseif type == 1 then
    REF.Black.gameObject:SetActive(true)
    REF.Content.transform.position = CS.UnityEngine.Vector3.zero
  end
end

function UpdatePosition()
  local refTransform = REF.WindowSize.transform
  local pos = refTransform:InverseTransformPoint(WU.ScreenToWorld(WU.MousePosition()))
  local corners = REF.BG.UISprite.worldCorners
  local bottomLeft = refTransform:InverseTransformPoint(corners[0])
  local topRight = refTransform:InverseTransformPoint(corners[2])
  local halfWidth = (topRight.x - bottomLeft.x) / 2
  local halfHeight = (topRight.y - bottomLeft.y) / 2
  local clickX = pos.x
  local displayWidth = REF.Black.UITexture.width
  local displayHeight = REF.Black.UITexture.height
  local offset = 40
  pos.x = CS.UnityEngine.Mathf.Clamp(pos.x, -displayWidth / 2 + halfWidth, displayWidth / 2 - halfWidth)
  pos.y = pos.y + halfHeight + offset
  if pos.y + halfHeight > displayHeight / 2 then
    pos.y = displayHeight / 2 - halfHeight
    if 0 < pos.x then
      pos.x = clickX - halfWidth - offset
    else
      pos.x = clickX + halfWidth + offset
    end
  end
  REF.Content.transform.localPosition = pos
end
