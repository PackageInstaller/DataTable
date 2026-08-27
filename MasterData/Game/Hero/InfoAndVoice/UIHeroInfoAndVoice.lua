local UIHeroInfoAndVoice = class("UIHeroInfoAndVoice", UIBaseNode)
local base = UIBaseNode

function UIHeroInfoAndVoice:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBtnCloseClicked)
end

function UIHeroInfoAndVoice:InitHeroData(heroData, uiHeroList)
  self.heroData = heroData
  self.uiHeroList = uiHeroList
  self:RefreshHeroData()
end

function UIHeroInfoAndVoice:RefreshHeroData()
  self.ui.tex_HeroName.text = self.heroData:GetName()
end

function UIHeroInfoAndVoice:OnBtnCloseClicked()
  if self.uiHeroList ~= nil then
    self:Hide()
    self.uiHeroList:OpenStatePanel()
  end
end

function UIHeroInfoAndVoice:OnDelete()
  base.OnDelete(self)
end

return UIHeroInfoAndVoice
