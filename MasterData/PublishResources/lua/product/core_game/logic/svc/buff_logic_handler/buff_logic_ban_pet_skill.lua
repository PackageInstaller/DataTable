EnumBanPetSkill = {
  Normal = 1,
  Chain = 2,
  Active = 3,
  MAX = 9
}
_enum("EnumBanPetSkill", EnumBanPetSkill)
_class("BuffLogicBanPetSkill", BuffLogicBase)
BuffLogicBanPetSkill = BuffLogicBanPetSkill

function BuffLogicBanPetSkill:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
end

function BuffLogicBanPetSkill:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasPetPstID() then
    return
  end
  local buffCmpt = e:BuffComponent()
  local banPetSkillList = buffCmpt:GetBuffValue("BanPetSkill") or {}
  for _, paramType in ipairs(self._buffInstance._effectList) do
    if not table.icontains(banPetSkillList, paramType) then
      table.insert(banPetSkillList, paramType)
    end
  end
  buffCmpt:SetBuffValue("BanPetSkill", banPetSkillList)
  local buffResult = BuffResultBanPetSkill:New(banPetSkillList)
  return buffResult
end

_class("BuffLogicRemoveBanPetSkill", BuffLogicBase)
BuffLogicRemoveBanPetSkill = BuffLogicRemoveBanPetSkill

function BuffLogicRemoveBanPetSkill:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveBanPetSkill:DoLogic()
  local e = self._entity
  if not e:HasPetPstID() then
    return
  end
  local buffCmpt = e:BuffComponent()
  local banPetSkillList = buffCmpt:GetBuffValue("BanPetSkill") or {}
  for _, paramType in ipairs(self._buffInstance._effectList) do
    table.removev(banPetSkillList, paramType)
  end
  buffCmpt:SetBuffValue("BanPetSkill", banPetSkillList)
  local buffResult = BuffResultRemoveBanPetSkill:New(banPetSkillList)
  return buffResult
end
