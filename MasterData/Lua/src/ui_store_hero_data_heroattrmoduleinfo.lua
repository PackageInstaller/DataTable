local this = class("heroAttrModuleInfo")
local _infoTpl = L_GameTpl:getBattleInfoTpl()

function this:ctor(id)
  self.id = id
  self.subModules = {}
end

function this:addSub(sSub)
  local sub = self:getSub(sSub.sub_module_id, true)
  sub.attrs = {}
  sub.skills = {}
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
  if sSub.skills and sSub.skills.skills then
    for _, v in ipairs(sSub.skills.skills) do
      sub.skills[v.skill_id] = v.skill_lv
    end
  end
end

function this:getSub(subId, isCreate)
  local sub = self.subModules[subId]
  if sub == nil and isCreate then
    sub = {
      attrs = {},
      skills = {}
    }
    self.subModules[subId] = sub
  end
  return sub
end

return this
