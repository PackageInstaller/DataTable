local UIAttrUtil = {}
local UINAttrOutlineWindow = require("Game.CommonUI.Hero.Attr.UINAttrOutLineWindow")
local UINAttrMiniWidget = require("Game.CommonUI.Hero.Attr.UINAttrMiniWidget")

function UIAttrUtil.GetAttrDataListForShow(heroData)
  local attrDataList = {}
  for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
    if ConfigData.attribute[attrId].merge_attribute == 0 then
      local attrValue = heroData:GetAttr(attrId)
      local basicAttrValue = heroData:GetAttr(attrId, nil, nil, true)
      local addAttrValue = attrValue - basicAttrValue
      local attrName, attrValueStrs, attrIcon
      if addAttrValue <= 0 then
        attrName, attrValueStrs, attrIcon = ConfigData:GetAttribute(attrId, {
          [1] = basicAttrValue
        })
      else
        attrName, attrValueStrs, attrIcon = ConfigData:GetAttribute(attrId, {
          [1] = basicAttrValue,
          [2] = attrValue - basicAttrValue
        })
      end
      local isRecommend = heroData:IsHeroRecommendAttr(attrId)
      local tempData = {
        attrId = attrId,
        name = attrName,
        attrValueStrs = attrValueStrs,
        icon = attrIcon,
        isRecommend = isRecommend
      }
      table.insert(attrDataList, tempData)
    end
  end
  return attrDataList
end

function UIAttrUtil.GetDynBattleRoleAttrDataListForShow(dynRole, getValueFunc)
  local attrDataList = {}
  for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
    if ConfigData.attribute[attrId].merge_attribute == 0 then
      local attrValue = getValueFunc(dynRole, attrId)
      if not (attrValue <= 0) then
        local attrName, attrValueStrs, attrIcon = ConfigData:GetAttribute(attrId, {
          [1] = attrValue
        })
        local tempData = {
          attrId = attrId,
          name = attrName,
          attrValueStrs = attrValueStrs,
          icon = attrIcon
        }
        table.insert(attrDataList, tempData)
      end
    end
  end
  return attrDataList
end

function UIAttrUtil.ShowAttrOutLineWindow(heroData, ui_logicPreviewNode)
  local attrDataList = UIAttrUtil.GetAttrDataListForShow(heroData)
  local attrOutLineWindow = UINAttrOutlineWindow.New()
  attrOutLineWindow:Init(ui_logicPreviewNode)
  return attrOutLineWindow, attrDataList
end

function UIAttrUtil.UpdateAttrData(heroName, attrDataList, attrOutLineWindow)
  attrOutLineWindow:OnUpdateAttrData(heroName, attrDataList)
end

function UIAttrUtil.ShowAttrMiniWidget(dynRole, ui_mini_logicPreviewNode)
  local attrDataList = UIAttrUtil.GetDynBattleRoleAttrDataListForShow(dynRole, function(dynRealRole, attrId)
    return dynRealRole:GetRealAttr(attrId)
  end)
  local attrMiniWidget = UINAttrMiniWidget.New()
  attrMiniWidget:Init(ui_mini_logicPreviewNode)
  return attrMiniWidget, attrDataList
end

function UIAttrUtil.ShowEntityAttrMiniWidget(entity, ui_mini_logicPreviewNode)
  local attrDataList = UIAttrUtil.GetDynBattleRoleAttrDataListForShow(entity, function(dynRealRole, attrId)
    return entity:GetRealProperty(attrId)
  end)
  local attrMiniWidget = UINAttrMiniWidget.New()
  attrMiniWidget:Init(ui_mini_logicPreviewNode)
  return attrMiniWidget, attrDataList
end

function UIAttrUtil.ShowSummonerAttrMiniWidget(summonerEntity, ui_mini_logicPreviewNode)
  local attrDataList = UIAttrUtil.GetDynBattleRoleAttrDataListForShow(summonerEntity, function(summonerRealEntity, attrId)
    return summonerRealEntity:GetRealProperty(attrId)
  end)
  local attrMiniWidget = UINAttrMiniWidget.New()
  attrMiniWidget:Init(ui_mini_logicPreviewNode)
  return attrMiniWidget, attrDataList
end

function UIAttrUtil.GetAttrSortListData(attrMap)
  local attrIds = {}
  local attrNums = {}
  for id, num in pairs(attrMap) do
    table.insert(attrIds, id)
  end
  table.sort(attrIds, function(a1, a2)
    local p1 = ConfigData.attribute[a1].attribute_priority
    local p2 = ConfigData.attribute[a2].attribute_priority
    if p1 == p2 then
      return a1 < a2
    end
    return p1 < p2
  end)
  for _, attrId in pairs(attrIds) do
    table.insert(attrNums, attrMap[attrId])
  end
  return attrIds, attrNums
end

return UIAttrUtil
