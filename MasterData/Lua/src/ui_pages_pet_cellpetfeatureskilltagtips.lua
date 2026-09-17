local cls = class("cellPetFeatureSkillTagTips", G_UIModuleBase)
local _battleTagTpl = L_GameTpl:getBattleTagTpl()
local Type2BgColor = {
  [0] = "#0000004C",
  [1] = "#b8aecb",
  [2] = "#e5d299",
  [3] = "#b7d4e7"
}

function cls.bind()
  return {
    color_bg = C_Color(1, 1, 1),
    txt_label = "",
    txt_desc = ""
  }
end

function cls:refresh()
  self.skillInfo = self.bind.skillInfo
  self:initModule()
end

function cls:initModule()
  if not self.skillInfo then
    return
  end
  local color = Type2BgColor[self.bind.type or 0]
  local _, color = C_ColorUtility.TryParseHtmlString(color)
  self.bind.color_bg = color
  self.bind.txt_label = string.format("%s", self.skillInfo.skillName)
  self.bind.txt_desc = string.format("%s", self.skillInfo.describe)
  self.bindComponents.rectDesc:SetSizeWithCurrentAnchors(1, self.bindComponents.tmpDesc.preferredHeight + 2)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function cls:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return cls
