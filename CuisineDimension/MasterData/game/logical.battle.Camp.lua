local Entity = import(".Entity")
local Camp = class("Camp", Entity)

function Camp:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.side = params.side
  self.battle = params.battle
  self.beauties = {}
  self.pets = {}
  self:reset()
end

function Camp:reset()
  self.skillIndex = 1
  for key, skill in pairs(self.activeSkills or {}) do
    skill:dispose()
  end
  self.activeSkills = {}
  self.hpBarDelay = 6
end

function Camp:addSkill(skill)
  self.activeSkills[self.skillIndex] = skill
  skill.primaryKey = self.skillIndex
  self.skillIndex = self.skillIndex + 1
  skill:beginEffect()
end

function Camp:addBeauty(beauty)
  table.insert(self.beauties, beauty)
end

function Camp:addPet(pet)
  table.insert(self.pets, pet)
end

function Camp:removePet(pet)
  for _index, _pet in ipairs(self.pets) do
    if _pet.id == pet.id then
      table.remove(self.pets, _index)
      break
    end
  end
end

function Camp:getSelfBeauty()
  for _, beauty in ipairs(self.beauties) do
    if not beauty.isTeamer then
      return beauty
    end
  end
end

function Camp:getBeautyByIndex(index)
  for _, beauty in ipairs(self.beauties) do
    if beauty.index == index then
      return beauty
    end
  end
end

function Camp:refreshHpBars()
end

function Camp:onPause()
  for _, beauty in ipairs(self.beauties) do
    beauty:pause()
  end
  for _, pet in ipairs(self.pets) do
    pet:pause()
  end
end

function Camp:onResume()
  for _, beauty in ipairs(self.beauties) do
    beauty:resume()
  end
  for _, pet in ipairs(self.pets) do
    pet:resume()
  end
end

function Camp:update(dt)
  if self.hasPaused then
    return
  end
  self.hpBarDelay = self.hpBarDelay + 1
  if self.hpBarDelay > 6 then
    self:refreshHpBars()
    self.hpBarDelay = 0
  end
  for key, skill in pairs(self.activeSkills) do
    if not skill:isDone() then
      skill:update(dt)
    else
      self.activeSkills[key]:dispose()
      self.activeSkills[key] = nil
    end
  end
  for _, beauty in ipairs(self.beauties) do
    beauty:update(dt)
  end
  for _, pet in ipairs(self.pets) do
    pet:update(dt)
  end
end

function Camp:dispose()
  for key, skill in pairs(self.activeSkills) do
    skill:dispose()
  end
  self.activeSkills = {}
end

return Camp
