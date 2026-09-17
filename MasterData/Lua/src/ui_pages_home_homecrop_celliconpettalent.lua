local this = class("cellIconPetTalent", G_UIModuleBase)
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()

function this.bind()
  return {img_icon = "", txt_lv = ""}
end

function this.methods()
  return {}
end

function this:open()
  local talentId = self.bind.talentId
  local tpl = _homeTalentTpl:getTplById(talentId)
  self.bind.img_icon = _homeTalentTpl:getIcon(tpl)
  self.bind.txt_lv = tostring(_homeTalentTpl:getTalentLevel(tpl))
end

function this:close()
end

return this
