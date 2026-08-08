local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local TU = require("Common/TextUtil")
local SE = require("Common/SkillEffect")
local HU = {
  ColorDefines = {Error = "#FD5454"}
}

function HU.ApplyFontFace(text, face)
  return "<font face='" .. face .. "'>" .. text .. "</font>"
end

function HU.ApplyFontColor(text, color)
  return "<font color=" .. color .. ">" .. text .. "</font>"
end

function HU.ApplyFontSize(text, size)
  return "<font size=" .. size .. ">" .. text .. "</font>"
end

function HU.ApplyFontStyle(text, face, color, size)
  local result = ""
  result = result .. "<font"
  if face then
    result = result .. " face='" .. face .. "'"
  end
  if color then
    result = result .. " color=" .. color
  end
  if size then
    result = result .. " size=" .. size
  end
  result = result .. ">" .. text .. "</font>"
  return result
end

function HU.ApplyBold(text)
  return "<b>" .. text .. "</b>"
end

function HU.ApplyItalic(text)
  return "<i>" .. text .. "</i>"
end

function HU.ApplyUnderline(text)
  return "<u>" .. text .. "</u>"
end

function HU.ApplyStrike(text)
  return "<s>" .. text .. "</s>"
end

function HU.ApplyHyperLink(text, url)
  return "<a href='" .. url .. "'>" .. text .. "</a>"
end

function HU.HtmlSplitLine(spriteName)
  return "<l width=100%><c width=100%><img src='" .. spriteName .. "' width=100%p height=4/></c></l>"
end

function HU.RenderTitle(title, subTitle)
  local html = "<font color=" .. U.AttrColorTable.Value .. ">" .. title .. "</font>"
  if subTitle then
    html = html .. "<font size=22 color=" .. U.AttrColorTable.SubTitle .. ">&nbsp;&nbsp;&nbsp;&nbsp;" .. subTitle .. "</font>"
  end
  return "<l width=100% align=left src='Common.title_bg_2' type=sliced> <c width=1%></c><c width=58% valign=bottom><i>" .. html .. "</i></c><font size=46>&nbsp;</font> </l>"
end

function HU.RenderOtherAttr(otherAttr, descName, localizationName, descSuffix)
  local text = ""
  local name = ""
  if otherAttr.attr ~= nil then
    text = WU.GetString("Window_ActorAttrName_" .. otherAttr.attr.type) .. HU.ApplyFontColor("+" .. U.FormatAttrValue(otherAttr.attr), "#0199E9") .. ",&nbsp;&nbsp;"
    text = text .. WU.GetString("Window_Only")
    local ids = otherAttr.ids
    for j = 1, #ids do
      local id = ids[j]
      name = name .. WU.GetString(descName, WU.GetString(localizationName .. id))
      if j ~= #ids then
        name = name .. "\227\128\129"
      end
    end
  end
  return text .. name .. descSuffix
end

function HU.ActorReplaceDesc(actor)
  local actorDesc = WU.GetString("ActorName_" .. actor.id)
  actorDesc = actorDesc .. "("
  for i = 1, actor.star do
    actorDesc = actorDesc .. "<img src='Common.star_m'/>"
  end
  actorDesc = actorDesc .. "&nbsp;&nbsp;" .. WU.GetString("Window_Level", actor.level)
  actorDesc = actorDesc .. ")"
  actorDesc = HU.ApplyFontColor(actorDesc, "#7F888C")
  return actorDesc
end

return HU
