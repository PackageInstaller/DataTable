local page = class("capturetest", G_UIPageBase)

function page.bind()
  return {
    hero1 = "",
    hero2 = "",
    hero3 = "",
    hero4 = ""
  }
end

function page:preOpen()
  self.bind.hero1 = "Character/World/pre_hero_girl_hanyouyou"
  self.bind.hero2 = "Character/World/pre_hero_girl_kuimo"
  self.bind.hero3 = "Character/World/pre_hero_loli_mingyu"
  self.bind.hero4 = "Character/World/pre_hero_loli_warrior00"
end

return page
