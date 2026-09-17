local cls = class("cellPetSkillTagTips", G_UIModuleBase)
local _battleTagTpl = L_GameTpl:getBattleTagTpl()
local _skillLevel = L_GameTpl:getSkillLevelTpl()
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

function cls.bind()
  return {
    img_icon = "",
    borderImgColor = C_Color(0.5, 0.5, 0.5, 1),
    txt_desc = "",
    txt_name = "",
    txt_level = ""
  }
end

function cls:refresh()
  self:initModule()
end

function cls:initModule()
  local petCatalogData = L_CatalogStore:getPetCatalogByPetId(self.petId) or {}
  local level = petCatalogData.lv or 1
  local _tpl = L_GameTpl:getSkillTpl():getTplById(self.bind.id)
  local _levelTpl = L_GameTpl:getSkillLevelTpl():getTplByIdAndLevel(self.bind.id, level)
  self.bind.txt_desc = _skillLevel:getSkillDescribe(_levelTpl)
  self.bind.img_icon = L_GameTpl:getSkillTpl():getIcon(_tpl)
  self.bind.txt_level = string.format("LV.%s", level)
  self.bind.txt_name = L_GameTpl:getSkillTpl():getName(_tpl)
  self.bind.borderImgColor = C_LuaUtility.ParseHtmlStringColor(BGCOLOR[self.bind.ele])
  self.bindComponents.rectDesc:SetSizeWithCurrentAnchors(1, self.bindComponents.tmpDesc.preferredHeight + 2)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function cls:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return cls
