local this = class("petAttrModuleInfo")

function this:ctor(id)
  self.id = id
  self.subModules = {}
end

function this:addSub(moduleType, sSub)
  local sub = self:getSub(sSub.sub_module_id, true)
  if sSub.attrs and sSub.attrs.attrs then
    for _, v in ipairs(sSub.attrs.attrs) do
      local id = v.attr_id
      local val = v.attr_val
      if sub.attrs[id] then
        sub.attrs[id] = val + sub.attrs[id]
      else
        sub.attrs[id] = val
      end
    end
  end
  if sSub.skills then
    for _, v in ipairs(sSub.skills) do
      if moduleType == L_Const.HeroAttrModuleType.HAMT_PET_INHERENT then
        sub.inherent_skills[v.skill_id] = {
          skillId = v.skill_id,
          level = v.skill_lv,
          skillSlot = v.skill_slot,
          type = v.type
        }
      elseif moduleType == L_Const.HeroAttrModuleType.HAMT_PET_GEN then
        sub.gene_skills[v.skill_id] = {
          skillId = v.skill_id,
          level = v.skill_lv,
          skillSlot = v.skill_slot,
          type = v.type
        }
      else
        errorf("来历不明的宠物技能 moduleType = " .. tostring(moduleType))
      end
    end
  end
end

function this:getSub(subId, isCreate)
  local sub = {
    attrs = {},
    inherent_skills = {},
    gene_skills = {}
  }
  self.subModules[subId] = sub
  return sub
end

return this
