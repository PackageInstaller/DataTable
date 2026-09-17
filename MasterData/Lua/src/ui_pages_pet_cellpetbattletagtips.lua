local cls = class("cellPetBattleTagTips", G_UIModuleBase)
local _battleTagTpl = L_GameTpl:getBattleTagTpl()
local Type2BgColor = {
  [0] = "#0000004C",
  [1] = "#b9aecf",
  [2] = "#e5d090",
  [3] = "#81A3BB"
}
local TxtColor = {
  [0] = "#606469",
  [1] = "#FFFFFF"
}

function cls.bind()
  return {
    color_MainBg = C_Color(1, 1, 1),
    color_FeatureBg = C_Color(1, 1, 1),
    txt_battle = "",
    txt_featrue = "",
    img_label = "",
    txt_desc = "",
    active_Icon = true,
    color_nameTxt = C_Color(1, 1, 1),
    active_mainBg = true,
    active_featureBg = false,
    active_txtBattle = true,
    active_txtFeatrue = true
  }
end

function cls:refresh()
  if self.bind.type == "battleTag" then
    self.cfgId = self.bind.id
    self:initModuleBattle()
  elseif self.bind.type == "featureTag" then
    self:InitModuleFeature()
  end
  self.bindComponents.rectDesc:SetSizeWithCurrentAnchors(1, self.bindComponents.tmpDesc.preferredHeight + 2)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function cls:initModuleBattle()
  if not self.cfgId then
    return
  end
  self.bind.active_Icon = true
  local battleTagCfg = _battleTagTpl:getTplById(self.cfgId)
  local _, color = C_ColorUtility.TryParseHtmlString(_battleTagTpl:getColor(battleTagCfg))
  self.bind.color_MainBg = color
  self.bind.txt_battle = _battleTagTpl:getTitle(battleTagCfg)
  self.bind.img_label = _battleTagTpl:getIcon(battleTagCfg)
  self.bind.txt_desc = _battleTagTpl:getDesc(battleTagCfg)
  local _, txtColor = C_ColorUtility.TryParseHtmlString(TxtColor[0])
  txtColor.a = 0.8
  self.bind.color_nameTxt = txtColor
  self.bind.active_mainBg = true
  self.bind.active_featureBg = false
  self.bind.active_txtBattle = true
  self.bind.active_txtFeatrue = false
end

function cls:InitModuleFeature()
  local info = self.bind.parms
  if not info then
    return
  end
  self.bind.active_Icon = false
  local color = Type2BgColor[info.type or 0]
  local _, color = C_ColorUtility.TryParseHtmlString(color)
  self.bind.color_FeatureBg = color
  self.bind.txt_featrue = info.label
  self.bind.img_label = info.itemIcon
  self.bind.txt_desc = info.describe
  local _, txtColor = C_ColorUtility.TryParseHtmlString(TxtColor[1])
  self.bind.color_nameTxt = txtColor
  self.bind.active_mainBg = false
  self.bind.active_featureBg = true
  self.bind.active_txtBattle = false
  self.bind.active_txtFeatrue = true
end

function cls:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return cls
