local this = class("medicineTpl")

function this:init(config)
  self.data = config
end

function this:getName(tpl)
  return tpl.name
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getTargetType(tpl)
  return tpl.medicineTarget
end

function this:getMedicineType(tpl)
  return tpl.medicinType
end

function this:getBuffType(tpl)
  return tpl.buffType
end

function this:getBuffId(tpl)
  return tpl.buffId
end

function this:getCoolDown(tpl)
  return tpl.coolDown
end

function this:getTplById(id)
  return self.data[id]
end

return this
