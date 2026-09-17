local this = class("randomNameTpl")

function this:init(config)
  self.data = config
  self.firstNameList = self:getNameByType(1)
  self.lastNameList = self:getNameByType(2)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getNameWords(tpl)
  return L_Config:provider(tpl.nameWords)
end

function this:getNameByType(type)
  local nameList = {}
  for i, v in pairs(self.data) do
    if v.type == type then
      table.insert(nameList, v)
    end
  end
  return nameList
end

function this:getOneRandomName()
  local randomFirstId = math.random(1, #self.firstNameList)
  local randomLastId = math.random(1, #self.lastNameList)
  while self._firstId == self.firstNameList[randomFirstId].id do
    randomFirstId = math.random(1, #self.firstNameList)
  end
  while self._lastId == self.lastNameList[randomLastId].id do
    randomLastId = math.random(1, #self.lastNameList)
  end
  self._firstId = self.firstNameList[randomFirstId].id
  self._lastId = self.lastNameList[randomLastId].id
  local firstName = self:getNameWords(self:getTplById(self.firstNameList[randomFirstId].id))
  local lastName = self:getNameWords(self:getTplById(self.lastNameList[randomLastId].id))
  return string.concat(firstName, lastName)
end

return this
