local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")

function SetEquipAttr(equipAttr, newSuitAttr)
  if equipAttr then
    SetBaseAttrMap(equipAttr.baseAttrMap)
    SetRandAttrMap(equipAttr.randAttrMap)
    SetSpecialAttr(equipAttr.specialAttr)
    SetSuitInfo(equipAttr.suitInfo, newSuitAttr)
  end
  REF["$"].UITable:Reposition()
end

function SetBaseAttrMap(baseAttrMap)
  REF.BaseAttr.gameObject:SetActive(baseAttrMap and not baseAttrMap:empty())
  if baseAttrMap and not baseAttrMap:empty() then
    local attrHtml = ""
    local displayList = PB.index("AttrTypeSortOrder", 1).list
    for i = 1, #displayList do
      local attr = baseAttrMap[displayList[i]]
      if attr then
        attrHtml = attrHtml .. RenderAttr(attr)
      end
    end
    REF.LabelBaseAttrs.UIHtmlLabel.text = attrHtml
    REF.LabelBaseAttrs.UIHtmlLabel:MakePixelPerfect()
    _ENV["$"](REF.BaseAttr).SpriteBG.UISprite:UpdateAnchors()
  end
end

function SetRandAttrMap(randAttrMap)
  REF.RandAttr.gameObject:SetActive(randAttrMap and not randAttrMap:empty())
  if randAttrMap and not randAttrMap:empty() then
    local attrHtml = ""
    local displayList = PB.index("AttrTypeSortOrder", 1).list
    for i = 1, #displayList do
      local attrList = randAttrMap[displayList[i]]
      if attrList then
        for _, attr in pairs(attrList) do
          if attr then
            attrHtml = attrHtml .. RenderAttr(attr)
          end
        end
      end
    end
    REF.LabelRandAttrs.UIHtmlLabel.text = attrHtml
    REF.LabelRandAttrs.UIHtmlLabel:MakePixelPerfect()
    _ENV["$"](REF.RandAttr).SpriteBG.UISprite:UpdateAnchors()
  end
end

function SetSpecialAttr(specialAttr)
  REF.SpecialAttr.gameObject:SetActive(specialAttr)
  if specialAttr then
    REF.LabelSpecialAttrs.UIHtmlLabel.text = AU.GetSpecialEffectDesc(specialAttr.id, specialAttr.effect, U.AttrColorTable.Value)
    REF.LabelSpecialAttrs.UIHtmlLabel:MakePixelPerfect()
    _ENV["$"](REF.SpecialAttr).SpriteBG.UISprite:UpdateAnchors()
  end
end

function SetSuitInfo(suitInfo, newSuitAttr)
  REF.SuitInfo.gameObject:SetActive(suitInfo)
  if suitInfo then
    REF.SuitInfo["$SetSuitInfo"](suitInfo)
    if REF.LabelSuitAttrs.TweenColor then
      REF.LabelSuitAttrs.TweenColor.enabled = newSuitAttr
      if not newSuitAttr then
        REF.LabelSuitAttrs.UIHtmlLabel.color = REF.LabelSuitAttrs.TweenColor.to
      end
    end
  end
end

function RenderAttr(attr)
  local maxText = ""
  if attr.max then
    maxText = U.FormatAttrValue({
      type = attr.type,
      isRatio = attr.isRatio,
      value = attr.max.value
    })
    if attr.max.delta ~= 0 then
      maxText = maxText .. fif(attr.max.delta > 0, "\226\134\145", "\226\134\147")
      maxText = HU.ApplyFontColor(maxText, fif(attr.max.delta > 0, U.AttrColorTable.Positive, U.AttrColorTable.Negative))
    end
  end
  return "<l width=100%><c width=50%>" .. WU.GetString("Window_ActorAttrName_" .. attr.type) .. "</c><font color=" .. U.AttrColorTable.Value .. "><c width=30% align=right>" .. maxText .. "</c><c width=20% align=right>+" .. U.FormatAttrValue(attr) .. "</c></font></l>"
end
