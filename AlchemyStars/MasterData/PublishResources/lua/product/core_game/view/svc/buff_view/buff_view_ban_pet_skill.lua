_class("BuffViewBanPetSkill", BuffViewBase)
BuffViewBanPetSkill = BuffViewBanPetSkill

function BuffViewBanPetSkill:PlayView(TT)
  local result = self._buffResult
  local banPetSkillList = result:GetBanPetSkillList()
  local buffViewComponent = self._entity:BuffView()
  buffViewComponent:SetBuffValue("BanPetSkill", banPetSkillList)
end

_class("BuffViewRemoveBanPetSkill", BuffViewBase)
BuffViewRemoveBanPetSkill = BuffViewRemoveBanPetSkill

function BuffViewRemoveBanPetSkill:PlayView(TT)
  local result = self._buffResult
  local banPetSkillList = result:GetBanPetSkillList()
  local buffViewComponent = self._entity:BuffView()
  buffViewComponent:SetBuffValue("BanPetSkill", banPetSkillList)
end
