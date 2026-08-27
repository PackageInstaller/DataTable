local UINBattleDPSItem = class("UINBattleDPSItem", UIBaseNode)
local base = UIBaseWindow
local CareerToColor = {
  [0] = Color.New(1, 1, 1, 0.3),
  [1] = Color.New(0.54, 0.67, 1, 0.3),
  [2] = Color.New(1, 0.39, 0.43, 0.3),
  [3] = Color.New(1, 0.68, 0.42, 0.3),
  [4] = Color.New(0.84, 0.62, 1, 0.3),
  [5] = Color.New(0.75, 1, 0.78, 0.3)
}

function UINBattleDPSItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.damage = 0
  self.heroID = 0
end

function UINBattleDPSItem:InitDPSItem(id, heroName, damage)
  if id == 0 then
    self.ui.tex_Name.text = ConfigData:GetTipContent(TipContent.CommanderDPSName) or "Commander"
    self.ui.img_Career.sprite = CRH:GetSprite("career_commander", CommonAtlasType.CareerCamp)
    self.ui.img_Bar.color = CareerToColor[0]
    return
  end
  local heroCfg = ConfigData.hero_data[id]
  if heroCfg == nil then
    error("read heroCfg error id" .. id)
  end
  local careerCfg = ConfigData.career[heroCfg.career]
  if careerCfg == nil then
    error("read careerCfg error id" .. heroCfg.career)
  end
  local name = heroName
  if string.IsNullOrEmpty(heroName) then
    name = LanguageUtil.GetLocaleText(heroCfg.name)
  end
  self.ui.tex_Name.text = name
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.img_Bar.color = CareerToColor[careerCfg.id]
end

function UINBattleDPSItem:AddDamage(damage, maxDamage, isNeedUpdateMaxDamage)
  self.damage = damage
  self:RefreshDamage(maxDamage, isNeedUpdateMaxDamage)
end

function UINBattleDPSItem:RefreshDamage(maxDamage, isNeedUpdateMaxDamage)
  self.ui.tex_Percent.text = tostring(self.damage)
  if isNeedUpdateMaxDamage then
    self.ui.img_Bar.fillAmount = self.damage / maxDamage
  end
end

function UINBattleDPSItem:Clean()
  self.damage = 0
  self.ui.tex_Percent.text = 0
  self.ui.img_Bar.fillAmount = 0
end

function UINBattleDPSItem:OnDelete()
  base.OnDelete(self)
end

return UINBattleDPSItem
