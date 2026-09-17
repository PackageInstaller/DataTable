local this = class("petEggItem")
local eggTpl = L_GameTpl:getPetEggTpl()

function this:ctor()
  self.guid = nil
  self.type = nil
  self.weight = nil
  self.odor = nil
  self.configId = nil
  self.hatching = nil
  self.itemNum = nil
  self.eggAffix = nil
end

function this:populate(eggData)
  self.guid = eggData.guid
  self.weight = eggData.weight
  self.odor = eggData.odor
  self.configId = eggData.configid
  local egg_tpl = eggTpl:getTplById(eggData.configid)
  if not egg_tpl or eggData.guid == 0 then
    errorf("蛋数据有问题,看下条打印")
    printf("蛋数据", eggData)
  end
  local type = eggTpl:getName(egg_tpl)
  self.type = type
  self.hatching = eggData.hatching
  self.main_parents = eggData.main_parents
  self.secondary_parents = eggData.secondary_parents
  self.lock_state = eggData.lock_state
  self.hatch_state = eggData.hatch_state
  self.itemNum = eggData.itemNum
  self.eggAffix = eggData.eggAffix
  return this
end

return this
