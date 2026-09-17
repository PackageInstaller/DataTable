local this = class("goodsPurchaseTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getItem(tpl)
  return tpl.item
end

function this:getPrerequisiteType(tpl)
  return tpl.prerequisiteType
end

function this:getRecommend(tpl)
  return tpl.recommend
end

function this:getGoodsName(tpl)
  return L_Config:provider(tpl.goodsName)
end

function this:getCostNum(tpl)
  return tpl.costNum
end

function this:getPrerequisite(tpl)
  return tpl.prerequisite
end

function this:getDuration(tpl)
  return tpl.duration
end

function this:getStartTime(tpl)
  return L_TimeUtil.parseConfigDatetime(tpl.startTime)
end

function this:getRefreshTypeParam(tpl)
  return tpl.refreshTypeParam
end

function this:getGoodsId(tpl)
  return tpl.goodsId
end

function this:getIcon(tpl)
  local icon = tpl.icon
  if type(icon) == "table" and icon[1] then
    icon = icon[1]
  end
  return L_Config:getPathByHash(icon) or ""
end

function this:getRefreshType(tpl)
  return tpl.refreshType
end

function this:getCommonCondition(tpl)
  return tpl.commonCondition
end

function this:getIsDelete(tpl)
  return tpl.isDelete
end

function this:getEndTime(tpl)
  local startTime = self:getStartTime(tpl)
  local duraTime = self:getDuration(tpl)
  if startTime <= 0 or duraTime <= 0 then
    return 0
  end
  return startTime + duraTime
end

function this:getGoodsDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getLimitTxt(tpl)
  return L_Config:provider(tpl.limitTxt)
end

function this:getSpecialPrice(tpl)
  return tpl.specialPrice
end

function this:getSpecialTips(tpl)
  return tpl.specialTips
end

function this:getUnlockDesc(tpl)
  if not tpl.unlockDesc or #tpl.unlockDesc < 1 then
    return ""
  end
  return L_Config:provider(tpl.unlockDesc[1])
end

function this:getRarity(tpl)
  return tpl.rarity or 0
end

return this
