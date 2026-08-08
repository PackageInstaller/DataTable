local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")

function SetEquipAttr(equipAttr, showStatus)
  if equipAttr then
    SetBaseAttrMap(equipAttr.baseAttrMap)
    SetRandAttrMap(equipAttr.randAttrMap)
    SetSpecialAttr(equipAttr.specialAttr)
    SetSuitInfo(equipAttr.suitInfo, showStatus)
  end
  REF["$"].UITable:Reposition()
end

function SetBaseAttrMap(baseAttrMap)
  REF.BaseAttrName.gameObject:SetActive(baseAttrMap)
  REF.BaseAttrList.gameObject:SetActive(baseAttrMap)
  if baseAttrMap then
    local slotCount = #REF.BaseAttrList
    local slotIndex = 0
    local displayList = PB.index("AttrTypeSortOrder", 1).list
    for i = 1, #displayList do
      local attr = baseAttrMap[displayList[i]]
      if attr then
        slotIndex, slotCount = SetAttrImpl(attr, REF.BaseAttrList, slotIndex, slotCount)
      end
    end
    for i = slotIndex, slotCount - 1 do
      REF.BaseAttrList[i]["$gameObject"]:SetActive(false)
    end
    REF.BaseAttrList.UITable:Reposition()
  end
end

function SetRandAttrMap(randAttrMap)
  REF.RandAttrName.gameObject:SetActive(false)
  REF.RandAttrList.gameObject:SetActive(false)
  if randAttrMap and not randAttrMap:empty() then
    REF.RandAttrName.gameObject:SetActive(true)
    REF.RandAttrList.gameObject:SetActive(true)
    local slotCount = #REF.RandAttrList
    local slotIndex = 0
    local displayList = PB.index("AttrTypeSortOrder", 1).list
    for i = 1, #displayList do
      local attrList = randAttrMap[displayList[i]]
      if attrList then
        for _, attr in pairs(attrList) do
          if attr then
            slotIndex, slotCount = SetAttrImpl(attr, REF.RandAttrList, slotIndex, slotCount)
          end
        end
      end
    end
    if randAttrMap.randAttrUnlockLevels then
      slotIndex, slotCount = SetAttrImpl(randAttrMap.randAttrUnlockLevels, REF.RandAttrList, slotIndex, slotCount)
    end
    for i = slotIndex, slotCount - 1 do
      REF.RandAttrList[i]["$gameObject"]:SetActive(false)
    end
    REF.RandAttrList.UITable:Reposition()
  end
end

function SetSpecialAttr(specialAttr)
  REF.SpecialAttrName.gameObject:SetActive(specialAttr)
  REF.WidgetSpecialAttr.gameObject:SetActive(specialAttr)
  if specialAttr then
    REF.WidgetSpecialAttr["$SetAttr"](specialAttr)
  end
end

function SetSuitInfo(suitInfo, showStatus)
  REF.WidgetSuitInfo.gameObject:SetActive(suitInfo)
  if suitInfo then
    REF.WidgetSuitInfo["$SetSuitInfo"](suitInfo, showStatus)
  end
end

function SetAttrImpl(attr, listGasket, slotIndex, slotCount)
  local slotRef
  if slotIndex < slotCount then
    slotRef = listGasket[slotIndex]
  else
    local source = listGasket[0]["$gameObject"]
    local clone = CS.UnityEngine.GameObject.Instantiate(source, listGasket.transform)
    clone.name = source.name
    slotRef = _ENV["$"](clone)
    slotCount = slotCount + 1
  end
  slotRef["$gameObject"]:SetActive(true)
  slotRef["$$SetAttr"](attr)
  slotIndex = slotIndex + 1
  return slotIndex, slotCount
end
