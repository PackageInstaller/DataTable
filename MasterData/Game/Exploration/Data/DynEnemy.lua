local DynChipHolder = require("Game.Exploration.Data.DynChipHolder")
local DynEnemy = class("DynEnemy", DynChipHolder)

function DynEnemy:ctor()
end

function DynEnemy:InitEnemy(career, camp, attackRange)
end

function DynEnemy:GetCareer()
  return self._career
end

function DynEnemy:GetCamp()
  return self._camp
end

return DynEnemy
