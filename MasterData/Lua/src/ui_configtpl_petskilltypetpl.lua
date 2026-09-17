local this = class("petSkillTypeTpl")
local C_TDPetSkillTypeTable = CS.Azur.Gameplay.Table.TDPetSkillTypeTable

function this:init()
end

function this:getTplById(id)
  return C_TDPetSkillTypeTable.GetData(id)
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Lang:get(tpl.name)
end

function this:getIcon(tpl)
  if tpl.icon ~= nil and tpl.icon.Length > 0 then
    return tpl.icon[0] or ""
  end
  return ""
end

return this
