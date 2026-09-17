local this = class("cellTenResult", G_UIModuleBase)

function this.bind()
  return {
    go_img_bg_quality = false,
    go_new = false,
    img_bg_quality = "",
    img_bg_quality2 = "",
    img_quality = "",
    go_hero = false,
    img_hero = "",
    go_weapon = false,
    img_weapon = "",
    scrollList_extraReward = {
      moduleName = "pages/Raffle/cellExtraReward"
    }
  }
end

function this:refresh()
  if self.bind.serverData.mainPropType == L_Const.resType.hero then
    self.bind.go_hero = true
    self.bind.go_weapon = false
    self.bind.img_hero = L_ItemManager:parseHeroItem(self.bind.serverData.mainPropId).iconRaffle
  elseif self.bind.serverData.mainPropType == L_Const.resType.soulEssence then
    self.bind.go_hero = false
    self.bind.go_weapon = true
    self.bind.img_weapon = L_ItemManager:parseSpiritronItem(self.bind.serverData.mainPropId).icon
  end
  local tmp = {}
  for i, v in pairs(self.bind.serverData.attachRewards) do
    local item = L_ItemManager:parseItem(v.type, v.id)
    table.insert(tmp, {
      img_icon = item.icon,
      txt_num = string.format("X%s", v.num)
    })
  end
  self.bind.scrollList_extraReward:clear()
  self.bind.scrollList_extraReward:insert_array(tmp)
end

return this
