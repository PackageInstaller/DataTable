local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local EA = require("Common/EquipAttr")
local DBH = require("Manager/DataBindingHandler")

function SetEquipDisplay(actor, equip, equips)
  local nodeRef = _ENV["$"](REF.NodeTarget)
  nodeRef["$gameObject"]:SetActive(equip)
  if equip and actor then
    local equipInfo = PB.get("EquipInfo", equip.id)
    nodeRef.WidgetIconEquip["$SetEquip"](equip)
    nodeRef.LabelName.UIHtmlLabel.text = WU.GetString("EquipName_" .. equip.id)
    nodeRef.LabelScore.UIHtmlLabel.text = WU.GetString("WindowActorEquipCompare_Score", math.floor(EA.GetEquipScore(equip)))
    local requireLevelText = ""
    if equipInfo then
      requireLevelText = WU.GetString("Window_Level", equipInfo.requireLevel)
      if equipInfo.requireLevel > actor.level then
        requireLevelText = HU.ApplyFontColor(requireLevelText, HU.ColorDefines.Error)
      end
    end
    nodeRef.LabelRequireLevel.UIHtmlLabel.text = WU.GetString("WindowActorEquipCompare_RequireLevel", requireLevelText)
    nodeRef.LabelDesc.UIHtmlLabel.text = WU.GetString("EquipDesc_" .. equip.id)
    local equipAttr = EA.GetEquipAttr(equip, nil, equips)
    nodeRef.WidgetEquipAttrCompactTable["$SetEquipAttr"](equipAttr)
    nodeRef.ScrollView.UIScrollView:ResetPosition()
  end
end
