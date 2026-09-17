local this = class("goodsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getCostId(tpl)
  return tpl.costId
end

function this:getCurrencyType(tpl)
  return tpl.costId[1][1]
end

function this:getCurrencyId(tpl)
  return tpl.costId[1][2]
end

function this:getDiscountedPrice(tpl)
  return tpl.recommend
end

function this:getRecommend(tpl)
  return tpl.recommend
end

function this:getDuration(tpl)
  return tpl.duration
end

function this:getResourceld(tpl)
  return tpl.resourceld
end

function this:getRefreshType(tpl)
  return tpl.refreshType
end

function this:getRefreshTypeParam(tpl)
  return tpl.refreshTypeParam
end

function this:getStartTime(tpl)
  return L_TimeUtil.parseConfigDatetime(tpl.startTime)
end

function this:getPrerequisite(tpl)
  return tpl.prerequisite
end

function this:getGoodsId(tpl)
  return tpl.goodsId
end

function this:getPrerequisiteType(tpl)
  return tpl.prerequisiteType
end

function this:getRefreshTime(tpl)
  return tpl.refreshTime
end

function this:getCurrencyNum(tpl)
  return tpl.costId[1][3]
end

function this:getItem(tpl)
  return tpl.item
end

function this:getItemType(tpl)
  return self:getItem(tpl)[1][1]
end

function this:getItemId(tpl)
  return self:getItem(tpl)[1][2]
end

function this:getItemNum(tpl)
  return self:getItem(tpl)[1][3]
end

function this:getCommonCondition(tpl)
  return tpl.commonCondition
end

function this:getUnlockParams(tpl)
  return tpl.unlockParam
end

function this:getIsDelete(tpl)
  return tpl.isDelete
end

function this:getEndTime(tpl)
  local startTime = self:getStartTime(tpl)
  if math.isEmpty(startTime) or startTime <= 0 or math.isEmpty(tpl.endTime) or 0 >= tpl.endTime then
    return 0
  else
    return L_TimeUtil.parseConfigDatetime(tpl.endTime)
  end
end

function this:getGoodsName(tpl)
  return L_Config:provider(tpl.goodsName)
end

function this:getGoodsDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getIcon(tpl)
  local icon = tpl.icon
  if string.isEmpty(icon) then
    local conf = L_ItemTplManager:getItemConfig(tpl.item[1][1], tpl.item[1][2])
    return conf.icon
  end
  return icon
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getLimitTxt(tpl)
  return L_Config:provider(tpl.limitTxt)
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getUnlockDesc(tpl)
  return tpl.unlockDesc
end

function this:getSpecialTips(tpl)
  return tpl.specialTips
end

function this:getSpecialPrice(tpl)
  return tpl.specialPrice
end

function this:getLaunchType(tpl)
  return tpl.launchType
end

function this:getTimelimit(tpl)
  return tpl.timelimit
end

return this
