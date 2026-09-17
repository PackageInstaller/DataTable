local this = class("homeScienceTpl")
local E = {}

function this:init(config)
  self.data = config
  self.unlockData = {}
  for k, v in pairs(config) do
    for kk, vv in pairs(v.unlockCondi1) do
      if vv[1] == L_CodConst.enum.homeScienceComplete then
        self.unlockData[v.id] = self.unlockData[v.id] or {}
        self.unlockData[v.id].prev = self.unlockData[v.id].prev or {}
        table.insert(self.unlockData[v.id].prev, vv[2])
        self.unlockData[vv[2]] = self.unlockData[vv[2]] or {}
        self.unlockData[vv[2]].post = self.unlockData[vv[2]].post or {}
        table.insert(self.unlockData[vv[2]].post, v.id)
      end
    end
  end
  self.dataArray = table.toArray(config)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByTypeAndLevel(type, level)
  for k, v in pairs(self.data) do
    if v.scienceType == type and v.level == level then
      return v
    end
  end
end

function this:getObjName(tpl)
  return L_Config:provider(tpl.objName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getScienceType(tpl)
  return tpl.scienceType
end

function this:getNeedItem(tpl)
  return tpl.needItem
end

function this:getNeedWorkerNum(tpl)
  return tpl.needWorkerNum
end

function this:getTime(tpl)
  return tpl.time
end

function this:getUnlockCondi1(tpl)
  return tpl.unlockCondi1
end

function this:getEffect1Id(tpl)
  return tpl.effect1Id
end

function this:getArray()
  return self.dataArray
end

function this:getUnlockData(id)
  return self.unlockData[id]
end

return this
