local this = class("cellPetTagHomeTalent", G_UIModuleBase)
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()

function this.bind()
  return {img_icon = "", talentName = ""}
end

function this:open()
  local talentId = self.bind.id
  local tpl = _HomeTalentTpl:getTplById(talentId)
  self.bind.img_icon = _HomeTalentTpl:getTagIcon(tpl)
  self.bind.talentName = _HomeTalentTpl:getTalentNameShort(tpl)
end

return this
