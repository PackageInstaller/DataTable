local UINFosterButtomNode = class("UINFosterButtomNode", UIBaseNode)
local base = UIBaseNode

function UINFosterButtomNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFosterButtomNode:RefreshAndShowLockedInfo(fosterCfg)
  self.ui.obj_upgradeDetail:SetActive(false)
  self.ui.obj_currentEffect:SetActive(true)
  self.ui.txt_effectTip:SetIndex(0)
  local des = LanguageUtil.GetLocaleText(fosterCfg[1].describe)
  for index, attrID in ipairs(fosterCfg[1].attributeIds) do
    local value = fosterCfg[1].attributeNums[index]
    des = string.gsub(des, "{" .. tostring(index - 1) .. "}", tostring(value))
  end
  self.ui.txt_currentEffect.text = des
  self.ui.tex_SkillName.text = LanguageUtil.GetLocaleText(fosterCfg[1].name)
end

function UINFosterButtomNode:RefreshAndShowInfo(fosterCfg, nowLevel)
  self.ui.obj_upgradeDetail:SetActive(true)
  self.ui.obj_currentEffect:SetActive(false)
  local cfg = fosterCfg[nowLevel]
  local nextCfg = fosterCfg[nowLevel + 1]
  self.ui.tex_SkillName.text = LanguageUtil.GetLocaleText(cfg.name)
  local currDes = LanguageUtil.GetLocaleText(cfg.describe)
  for index, attrID in ipairs(cfg.attributeIds) do
    local value = cfg.attributeNums[index]
    currDes = string.gsub(currDes, "{" .. tostring(index - 1) .. "}", tostring(value))
  end
  self.ui.tex_CurrSkill.text = currDes
  local nextDes = LanguageUtil.GetLocaleText(nextCfg.describe)
  for index, attrID in ipairs(nextCfg.attributeIds) do
    local value = nextCfg.attributeNums[index]
    nextDes = string.gsub(nextDes, "{" .. tostring(index - 1) .. "}", "<color=#FF8400>" .. tostring(value) .. "</color>")
  end
  self.ui.tex_NextSkill.text = nextDes
end

function UINFosterButtomNode:RefreshAndShowMaxLevelInfo(fosterCfg, nowLevel)
  self.ui.obj_upgradeDetail:SetActive(false)
  self.ui.obj_currentEffect:SetActive(true)
  local cfg = fosterCfg[nowLevel]
  self.ui.txt_effectTip:SetIndex(1)
  self.ui.tex_SkillName.text = LanguageUtil.GetLocaleText(cfg.name) .. " MAX"
  local des = LanguageUtil.GetLocaleText(cfg.describe)
  for index, attrID in ipairs(cfg.attributeIds) do
    local value = cfg.attributeNums[index]
    des = string.gsub(des, "{" .. tostring(index - 1) .. "}", tostring(value))
  end
  self.ui.txt_currentEffect.text = des
end

function UINFosterButtomNode:OnDelete()
  base.OnDelete(self)
end

return UINFosterButtomNode
