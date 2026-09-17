local module = class("cellPetNewSkill", G_UIModuleBase)
local SKILLBORDERICON = {
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
local mainSkillIconColor = "#71C2E9"
local lvColor = {
  [0] = "#4F525D",
  [1] = "#ffffff"
}
local nameColor = {
  [0] = "#4F525D",
  [1] = "#ffffff"
}

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    bgImg_color = C_Color(1, 1, 1, 0.84),
    borderImgColor = C_Color(0.5, 0.5, 0.5, 1),
    skillLv = "",
    skillName = "",
    itemIcon = "",
    lvColor = C_Color(1, 1, 1, 1),
    lvNumColor = C_Color(1, 1, 1, 1),
    nameColor = C_Color(1, 1, 1, 1),
    nameDecorateColor = C_Color(1, 1, 1, 1),
    goMainSkillDecorate = false,
    active_mainSkillBg = false
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind.index, self.bind)
    end,
    onClick_Down = function(self)
      self:emit("onClick_Down", self.bind.index, self.bind)
    end,
    onClick_Up = function(self)
      self:emit("onClick_Up", self.bind.index, self.bind)
    end
  }
end

function module:open()
  self:refreshInfo()
end

function module:SetMainSkillBg()
  local petSpecialSkill = L_GameConstTpl:getData("PET_SIGNATURESKILLLIST", L_Const.GameTplType.int)
  if self.bind.index == petSpecialSkill then
    self.bind.nameColor = C_LuaUtility.ParseHtmlStringColor(nameColor[1])
    self.bind.nameDecorateColor = C_LuaUtility.ParseHtmlStringColor(nameColor[1])
    self.bind.lvColor = C_LuaUtility.ParseHtmlStringColor(lvColor[1])
    self.bind.lvNumColor = C_LuaUtility.ParseHtmlStringColor(lvColor[1])
    self.bind.goMainSkillDecorate = true
    self.bind.active_mainSkillBg = true
  else
    local nameInfoColor = C_LuaUtility.ParseHtmlStringColor(nameColor[0])
    nameInfoColor.a = 0.75
    self.bind.nameColor = nameInfoColor
    local nameDecorateColor = C_LuaUtility.ParseHtmlStringColor(nameColor[0])
    nameDecorateColor.a = 0.5
    self.bind.nameDecorateColor = nameDecorateColor
    self.bind.lvColor = C_LuaUtility.ParseHtmlStringColor(lvColor[0])
    self.bind.lvNumColor = C_LuaUtility.ParseHtmlStringColor(lvColor[0])
    self.bind.goMainSkillDecorate = false
    self.bind.active_mainSkillBg = false
  end
end

function module:refresh()
end

function module:refreshInfo()
  self:SetMainSkillBg()
  if self.bind.starLv and self.bind.starLv ~= 0 then
    self.bind.itemIcon = "Skill/tex_icon_skill_playgirl01"
  end
  if self.bind.skillElement ~= nil and self.bind.skillElement[1] then
    self.bind.borderImgColor = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[self.bind.skillElement[1]])
  else
    self.bind.borderImgColor = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[0])
  end
  local petSpecialSkill = L_GameConstTpl:getData("PET_SIGNATURESKILLLIST", L_Const.GameTplType.int)
  if self.bind.index == petSpecialSkill then
    local color
    if self.bind.skillElement ~= nil and self.bind.skillElement[1] then
      color = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[self.bind.skillElement[1]])
    else
      color = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[0])
    end
    color.a = 0.7
    self.bind.bgImg_color = color
  end
end

function module:getPosition()
  return self.bindComponents.skillItemTrans.position
end

function module:close()
end

return module
