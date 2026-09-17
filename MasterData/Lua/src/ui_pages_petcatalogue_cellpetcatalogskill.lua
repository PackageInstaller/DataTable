local module = class("cellPetCatalogSkill", G_UIModuleBase)
local BGCOLOR = {
  [0] = "#828282",
  [1] = "#fb7675",
  [2] = "#fd9c47",
  [3] = "#e5b933",
  [4] = "#5dca95",
  [5] = "#47cdc9",
  [6] = "#16d0ff",
  [7] = "#708bff",
  [8] = "#e2ca2a",
  [9] = "#9a76f5"
}

function module.bind()
  return {
    img_icon = "",
    borderImgColor = C_Color(0.5, 0.5, 0.5, 1)
  }
end

function module.methods()
  return {}
end

function module:refresh()
  local _tpl = L_GameTpl:getSkillTpl():getTplById(self.bind.id)
  self.bind.img_icon = L_GameTpl:getSkillTpl():getIcon(_tpl)
  self.bind.borderImgColor = C_LuaUtility.ParseHtmlStringColor(BGCOLOR[self.bind.ele])
end

return module
