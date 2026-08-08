local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")

function ShowCustom(showInfo)
  if showInfo == nil then
    WU.SetActive(REF["$"], false)
    return
  end
  WU.SetActive(REF["$"], true)
  REF["@type"] = 1
  WU.SetActive(REF.NodeArms, true)
  WU.SetActive(REF.Desc, false)
  WU.TraverseChildren(REF.ArmList, function(g, index)
    if showInfo[index + 1] ~= nil then
      _ENV["$"](g)["$$SetData"](PB.enum.ResourceType.ResUniqueWeapon, showInfo[index + 1].id, 1, "N")
      _ENV["$"](g)["$$ShowCustom"](showInfo[index + 1])
      _ENV["$"](g)["$$SetClickCallback"](function()
        local arm = PB.get("UniqueWeaponInfo", showInfo[index + 1].id)
        if arm == nil then
          error("UniqueWeaponInfo.xlsx has no id " .. showInfo[index + 1].id)
          return
        end
        local armInfo = {}
        table.copy(arm, armInfo, true)
        armInfo.baseAttrs = {}
        for i = 1, #armInfo.attrId do
          local attrInfo = PB.get("UniqueWeaponAttrEnhanceInfo", armInfo.attrId[i], 1)
          if attrInfo == nil then
            error("UniqueWeaponAttrEnhanceInfo.xlsx has no id " .. armInfo.attrId[i] .. " level " .. 1)
            return
          end
          local copyAttr = {}
          table.copy(attrInfo, copyAttr, true)
          copyAttr.attr = copyAttr.attr[1]
          if copyAttr.attr.isRatio then
            copyAttr.attr.value = string.format("%.2f", copyAttr.attr.value / 100) .. "%"
          end
          table.insert(armInfo.baseAttrs, copyAttr)
        end
        armInfo.speAttr = {}
        local speAttrInfo = PB.get("UniqueWeaponAttrEnhanceInfo", armInfo.speAttrId, 0)
        if speAttrInfo == nil then
          error("UniqueWeaponAttrEnhanceInfo.xlsx has no id " .. armInfo.speAttrId .. " level " .. 0)
          return
        end
        table.insert(armInfo.speAttr, speAttrInfo)
        armInfo.level = 0
        armInfo.phase = showInfo[index + 1].phase - 1
        armInfo.maxPhase = 5
        armInfo.name = WU.GetString("UniqueWeaponName_" .. showInfo[index + 1].id)
        armInfo.cardSkinIndex = fif(showInfo[index + 1].phase == 1, 0, 1)
        armInfo.currentSkill = PB.get("UniqueWeaponSkill", showInfo[index + 1].id, showInfo[index + 1].phase)
        local skillInfo = PB.get("UniqueWeaponSkill", showInfo[index + 1].id, showInfo[index + 1].phase)
        if skillInfo == nil then
          error("UniqueWeaponSkill.xlsx has no id " .. showInfo[index + 1].id .. " phase " .. showInfo[index + 1].phase)
          return
        end
        armInfo.skillInfo = skillInfo
        showInfo[index + 1].fake = true
        WU.AcquireWindowAsync("ArmDetail", function(window)
          _ENV["$"](window)["$$SetContent"](armInfo, showInfo[index + 1])
        end)
      end)
    else
      _ENV["$"](g)["$$ClearSlot"]()
    end
  end)
end

function ShowDesc(showInfo)
  if showInfo == nil then
    WU.SetActive(REF["$"], false)
    return
  end
  WU.SetActive(REF["$"], true)
  REF["@type"] = 2
  WU.SetActive(REF.NodeArms, false)
  WU.SetActive(REF.Desc, true)
  REF.LabelTitle.UILabel.text = WU.GetString("ArmSeriesName_" .. showInfo.Desc)
  REF.LabelNum.UILabel.text = showInfo.textNum
end
