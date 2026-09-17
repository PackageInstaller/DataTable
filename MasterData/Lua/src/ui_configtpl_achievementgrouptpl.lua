local this = class("achievementGroupTpl")

function this:init(config)
  self.data = config
  self.firstLvDir = {}
  self.secLvDir = {}
  for key, value in pairs(self.data) do
    if value.achiType == 1 then
      table.insert(self.firstLvDir, {
        id = value.id,
        order = value.achiOrder
      })
    end
  end
  table.sort(self.firstLvDir, function(a, b)
    return a.order < b.order
  end)
  self.IDMap = {}
  for key, value in pairs(self.data) do
    if value.achiType == 2 then
      if self.IDMap[value.achiGroupId] == nil then
        self.IDMap[value.achiGroupId] = {}
      end
      table.insert(self.IDMap[value.achiGroupId], {
        id = value.id
      })
    end
  end
  for key, value in pairs(self.firstLvDir) do
    value.data = self.IDMap[value.id]
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getAchiRes(tpl)
  local avatarTexture = L_Config:getPathByHash(tpl.achiRes)
  return avatarTexture
end

function this:getAchiPage(tpl)
  local avatarTexture = L_Config:getPathByHash(tpl.achiPage)
  return avatarTexture
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getAchiName(tpl)
  return L_Config:provider(tpl.achiName)
end

function this:getAchiEnglishName(tpl)
  return tpl.achiText
end

function this:getAcheiGroupIcon(tpl)
  return L_Config:getPathByHash(tpl.achiRes)
end

function this:getAcheiNameIcon(tpl)
  return L_Config:getPathByHash(tpl.achiPageWord)
end

function this:getfirstLvDir()
  return self.firstLvDir
end

function this:getBigGroupbySmallGroup(smallGroupID)
  for key, value in pairs(self.IDMap) do
    for key2, value2 in pairs(value) do
      if value2.id == smallGroupID then
        return key
      end
    end
  end
end

return this
