local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")

function SetAttr(attr, bgConfig)
  if attr then
    if attr.type then
      local valueHtml = U.FormatAttrValue(attr)
      REF.LabelType.UIHtmlLabel.text = WU.GetAttrName(attr.type)
      REF.LabelValue.UIHtmlLabel.text = valueHtml
    else
      REF.LabelType.UIHtmlLabel.text = WU.GetString("Window_NewAttr")
      REF.LabelValue.UIHtmlLabel.text = WU.GetString("Window_AttrGetLevel", table.concat(attr, "\227\128\129"))
    end
    if bgConfig then
      REF.SpriteBG.UISprite.spriteName = "share_equipment_grade_" .. tostring(bgConfig.quality)
      if bgConfig.isBase then
        REF.SpriteBG.UISprite.color = CS.NGUIMath.HexToColor(4294967168)
      end
    end
  end
end
