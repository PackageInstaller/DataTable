local this = class("achievementTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    self.groupData[v.groupId] = self.groupData[v.groupId] or {}
    table.insert(self.groupData[v.groupId], v)
  end
end

function this:getAlldata()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFinishCondi(tpl)
  return tpl.finishCondi
end

function this:getParam(tpl)
  return tpl.param
end

function this:getAchiLevel(tpl)
  return tpl.achiLevel
end

function this:getReward(tpl)
  return L_DataUtil.parseRewardConfigItem(tpl.reward)
end

function this:getAchiDesc(tpl)
  return L_Config:provider(tpl.achiDesc)
end

function this:getGroupId(tpl)
  if tpl then
    return tpl.groupId
  end
  return 0
end

function this:getAchiName(tpl)
  return L_Config:provider(tpl.achiName)
end

function this:getRawAchiName(tpl)
  return tpl.achiName
end

function this:getAchiPoint(tpl)
  return tpl.achPoint
end

function this:getFirstAchi(tpl)
  return tpl.firstAchi
end

function this:getId(tpl)
  return tpl.id
end

function this:getEachLevelNum()
  if not table.isEmpty(self.levelNum) then
    return self.levelNum
  end
  self.levelNum = {}
  for k, v in pairs(self.data) do
    local key = v.achiLevel
    if self.levelNum[key] then
      self.levelNum[key] = self.levelNum[key] + 1
    else
      self.levelNum[key] = 1
    end
  end
  return self.levelNum
end

function this:getAchievementVersion(id)
  local tpl = self.data[id]
  local groupId = self:getGroupId(tpl)
  local version = 1
  if tpl.firstAchi ~= 0 and tpl.firstAchi ~= id then
    local tmp_tpl = self.data[tpl.firstAchi]
    local groupList = self:getTplListByGroupId(groupId)
    local listCount = #groupList
    for j = 1, listCount do
      version = version + 1
      if tmp_tpl.nextAchi == id or tmp_tpl.nextAchi == 0 then
        break
      end
      tmp_tpl = self.data[tmp_tpl.nextAchi]
    end
  end
  return version
end

function this:getTplListByGroupId(groupId)
  return self.groupData[groupId] or {}
end

return this
