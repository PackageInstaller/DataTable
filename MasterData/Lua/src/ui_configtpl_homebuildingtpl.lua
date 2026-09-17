local this = class("homeBuildingTpl")

function this:init(config)
  self.data = config
  self.homeDormMaxNum = 0
  self.homeDormNumMap = {}
  self.groupData = {}
  for i, v in pairs(config) do
    self.groupData[v.groupId] = self.groupData[v.groupId] or {}
    self.groupData[v.groupId][v.level] = v
  end
  self:setHomeDormMaxNum()
end

function this:getTplById(id)
  if self.data[id] == nil then
    printf("HomeDebug", string.format("尝试获取建筑id:%d，但没有配置", id))
  end
  return self.data[id]
end

function this:setHomeDormMaxNum()
  self.homeDormNumMap = {}
  for i, v in pairs(self.data) do
    self.homeDormNumMap[v.dormCharacterNum] = v.level
    self.homeDormMaxNum = math.max(self.homeDormMaxNum, v.dormCharacterNum)
  end
end

function this:getUnlockDormSlotNeedLv(slot)
  local lvTable = {}
  for i, v in pairs(self.homeDormNumMap) do
    table.insert(lvTable, i)
  end
  table.sort(lvTable, function(a, b)
    return a < b
  end)
  for i, v in ipairs(lvTable) do
    if slot <= v then
      return self.homeDormNumMap[v]
    end
  end
end

function this:getHomeDormMaxNum()
  return self.homeDormMaxNum
end

function this:checkHomeBuildingIdIsValid(homeBuildingId)
  return self.data[homeBuildingId] ~= nil
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getTime(tpl)
  return tpl.time
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getNextLevel(tpl)
  return tpl.nextLevel
end

function this:getParam(tpl)
  return tpl.param
end

function this:getProsperity(tpl)
  return tpl.prosperity
end

function this:getId(tpl)
  return tpl.id
end

function this:getPath(tpl)
  return tpl.path
end

function this:getMaterial(tpl)
  return tpl.material
end

function this:getObjId(tpl)
  return tpl.objId
end

function this:getUpgradeCondition(tpl)
  return tpl.upgradeCondition
end

function this:getUpgradeObjId(tpl)
  if math.isEmpty(tpl.upgradeObjId) then
    printf(L_WordsTpl:getValue("notice_homeProduction_22") .. tpl.id .. "升级obj为空！")
  end
  return tpl.upgradeObjId
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getFuncDesc(tpl)
  local stringArr = string.split(L_Config:provider(tpl.desc_2), "/n")
  local tmp = {}
  for i, v in ipairs(stringArr) do
    if not string.isEmpty(v) then
      table.insert(tmp, v)
    end
  end
  return tmp
end

function this:getIsFullLevel(tpl)
  return self:getNextLevel(tpl) == 0
end

function this:getConfig()
  return self.data
end

function this:getShowTypeByTpl(tpl)
  local groupId = self:getGroupId(tpl)
  local homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
  local groupTpl = homeBuildingGroupTpl:getTplById(groupId)
  return homeBuildingGroupTpl:getShowType(groupTpl)
end

function this:getObjIdByBuildingId(id)
  local tpl = self:getTplById(id)
  return self:getObjId(tpl)
end

function this:getOuPut(tpl)
  return tpl.ouput
end

function this:getMaxLevelTpl(groupId)
  local count = table.count(self.groupData[groupId])
  return self.groupData[groupId][count]
end

function this:getGroupData(groupId)
  return self.groupData[groupId]
end

function this:getUpgradeCondition(tpl)
  return tpl.upgradeCondition
end

function this:getBuildIcon(tpl)
  local homeObjTpl = L_GameTpl:getHomeObjTpl(tpl.objId)
  local objTpl = homeObjTpl:getTplById(tpl.objId)
  return objTpl.objIcon or "UI/Atlas/Item/tex_icon_item_bait01.png"
end

function this:getStackNum(tpl)
  return tpl.stackNum
end

function this:getUpgradeDesc(tpl)
  local res = {}
  for _, key in ipairs(tpl.upgradeDesc) do
    table.insert(res, L_Config:provider(key))
  end
  return res
end

function this:getTrough(tpl)
  return tpl.trough
end

function this:getSlotNumber(tpl)
  return tpl.slotNumber
end

function this:isShowName(tpl)
  return tpl.isShowName
end

function this:getBuildingPixelIcon(tpl)
  return tpl.buildingPixelIcon
end

function this:getFrameTexture(tpl)
  return tpl.frameTexture
end

function this:getBuildingBaseTplByGroupId(groupId)
  local groupData = self:getGroupData(groupId)
  local tableId = groupData[1].id
  return self:getTplById(tableId)
end

function this:getHomeDormCharacterMaxNum(tpl)
  return tpl.dormCharacterNum
end

return this
