local this = class("cellPetSkillUpItem", G_UIModuleBase)

function this.bind()
  return {
    bgImgColor = C_Color(1, 1, 1, 0.84),
    borderImgColor = C_Color(0.5, 0.5, 0.5, 1),
    skillLv = "",
    skillNextLv = "2",
    skillName = "",
    itemIcon = ""
  }
end

function this:open()
  self:refreshInfo()
end

function this:refreshInfo()
  if self.bind.skillElement ~= nil and self.bind.skillElement[1] then
    self.bind.borderImgColor = C_LuaUtility.ParseHtmlStringColor(L_PetConst.SKILLBORDERICON[self.bind.skillElement[1]])
  else
    self.bind.borderImgColor = C_LuaUtility.ParseHtmlStringColor(L_PetConst.SKILLBORDERICON[0])
  end
  local petSpecialSkill = L_GameConstTpl:getData("PET_SIGNATURESKILLLIST", L_Const.GameTplType.int)
  if self.bind.index == petSpecialSkill then
    local color
    if self.bind.skillElement ~= nil and self.bind.skillElement[1] then
      color = C_LuaUtility.ParseHtmlStringColor(L_PetConst.SKILLBORDERICON[self.bind.skillElement[1]])
    else
      color = C_LuaUtility.ParseHtmlStringColor(L_PetConst.SKILLBORDERICON[0])
    end
    color.a = 0.7
    self.bind.bgImgColor = color
  end
end

function this:getPosition()
  return self.bindComponents.skillItemTrans.position
end

return this
