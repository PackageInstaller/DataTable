local this = class("homeBuildingGroupTpl")

function this:init(config)
  self.data = config
  self.showTypeDic = {}
  for i, v in pairs(self.data) do
    local showType = self:getShowType(v)
    if self.showTypeDic[showType] == nil then
      self.showTypeDic[showType] = {}
    end
    table.insert(self.showTypeDic[showType], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getConfig()
  return self.data
end

function this:getGroupIdsByShowType(showType)
  return self.showTypeDic[showType] or {}
end

function this:getBuildingIdsByShowType(showType)
  local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
  local ids = self:getGroupIdsByShowType(showType)
  for i, v in ipairs(ids) do
    local tpl = homeBuildingTpl:getTplById()
  end
end

function this:getUnlockCondi(tpl)
  return tpl.unlockCondi
end

function this:getLimit(tpl)
  return tpl.limit
end

function this:getShowType(tpl)
  return tpl.type
end

function this:getType(tpl)
  return tpl.type
end

function this:getIcon(tpl)
  return L_Config:getPathByHash(tpl.icon)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getMiniIcon(tpl)
  return L_Config:getPathByHash(tpl.miniIcon) or "Altas/HomeButton/tex_home_entrance_icon_suishichang.png"
end

function this:getIsStorable(tpl)
  return tpl.isStorable
end

function this:getInteractIconQuickClaim(tpl)
  local icon = L_Config:getPathByHash(tpl.interactIconQuickClaim)
  return icon
end

function this:getInteractIconInterface(tpl)
  local icon = L_Config:getPathByHash(tpl.interactIconInterface)
  return icon
end

function this:getSeriesId(tpl)
  return tpl.seriesId
end

function this:getStartButtonWord(tpl)
  return L_Config:provider(tpl.startButtonWord)
end

function this:getProduceTypeTitle(tpl)
  return L_Config:provider(tpl.produceTypeTitle)
end

function this:getBuildingGroupIdListByBuildingType(buildingType)
  local buildingGroupIdList = {}
  for _, v in pairs(self.data) do
    if v.type == buildingType then
      table.insert(buildingGroupIdList, v.groupId)
    end
  end
  return buildingGroupIdList
end

function this:getHomeBuffType(tpl)
  return L_Config:provider(tpl.homeBuffType)
end

return this
