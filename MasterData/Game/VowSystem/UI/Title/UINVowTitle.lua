local UINVowTitle = class("UINVowTitle", UIBaseNode)
local base = UIBaseNode

function UINVowTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINVowTitle:InitVowTitle(heroVowCfg)
  self.preItemCfg = nil
  self.preTitleCfg = nil
  self.postTitleCfg = nil
  self.postItemCfg = nil
  for rewardId, rewardNum in pairs(heroVowCfg.vow_reward) do
    local itemCfg = ConfigData.item[rewardId]
    local titleCfg = ConfigData.title[rewardId]
    if titleCfg.position == 1 then
      self.preItemCfg = itemCfg
      self.preTitleCfg = titleCfg
    else
      self.postItemCfg = itemCfg
      self.postTitleCfg = titleCfg
    end
  end
  self:RefreshVowTitle()
end

function UINVowTitle:RefreshVowTitle()
  if self.preTitleCfg == nil or self.postTitleCfg == nil then
    return
  end
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self.preItemCfg.describe)
  self.ui.tex_Prefix.text = LanguageUtil.GetLocaleText(self.preTitleCfg.name)
  self.ui.tex_Suffix.text = LanguageUtil.GetLocaleText(self.postTitleCfg.name)
end

function UINVowTitle:OnDelete()
end

return UINVowTitle
