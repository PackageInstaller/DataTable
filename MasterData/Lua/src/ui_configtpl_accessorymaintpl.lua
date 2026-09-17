local this = class("accessoryMainTpl")

function this:init(config)
  self.data = {}
  for _, v in pairs(config) do
    if not self.data[v.groupId] then
      self.data[v.groupId] = {}
    end
    if not self.data[v.groupId][v.level] then
      self.data[v.groupId][v.level] = {}
    end
    table.insert(self.data[v.groupId][v.level], v)
  end
end

function this:getTplByGroupIdAndLevel(groupId, level)
  return self.data[groupId][level]
end

function this:getId(tpl)
  return tpl.id
end

function this:getValue(tpl)
  return tpl.value
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getBattleInfo(tpl)
  return tpl.battleInfo
end

function this:getBattleInfoName(tpl)
  return L_Lang:get(tpl.battleInfoName)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getShowMainAttrStr(tpl)
  local attId = self:getBattleInfo(tpl)
  local value = self:getValue(tpl)
  local showName = L_Lang:get(tpl.battleInfoName)
  return string.format("%s+%s", showName, L_GameTpl:getBattleInfoTpl():getShowTxt(attId[1], value))
end

return this
