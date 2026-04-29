require("_buff_result_base")
_class("BuffResultBanPetSkill", BuffResultBase)
BuffResultBanPetSkill = BuffResultBanPetSkill

function BuffResultBanPetSkill:Constructor(banPetSkillList)
  self._banPetSkillList = banPetSkillList
end

function BuffResultBanPetSkill:GetBanPetSkillList()
  return self._banPetSkillList
end

_class("BuffResultRemoveBanPetSkill", BuffResultBase)
BuffResultRemoveBanPetSkill = BuffResultRemoveBanPetSkill

function BuffResultRemoveBanPetSkill:Constructor(banPetSkillList)
  self._banPetSkillList = banPetSkillList
end

function BuffResultRemoveBanPetSkill:GetBanPetSkillList()
  return self._banPetSkillList
end
