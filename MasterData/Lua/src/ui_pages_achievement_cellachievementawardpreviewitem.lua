local this = class("cellAchievementAwardPreViewItem", G_UIModuleBase)
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {
    img_icon = "",
    txt_num = "",
    list_star = {},
    img_qualityBg = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.bind.itemType == nil then
    return
  end
  self.bind.txt_num = tostring(self.bind.itemNum)
  local conf = L_ItemTplManager:getItemConfig(self.bind.itemType, self.bind.itemId)
  self:SetMainIcon(self.bind.itemType, conf)
  local starNum = L_ItemTplManager:getItemShowStarNum(self.bind.itemType, self.bind.itemId)
  self:setStars(starNum)
end

function this:refreshView(itemType, itemId, itemNum)
  self.bind.txt_num = tostring(itemNum)
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self:SetMainIcon(itemType, conf)
  local starNum = L_ItemTplManager:getItemShowStarNum(itemType, itemId)
  self:setStars(starNum)
end

function this:SetMainIcon(itemType, conf)
  if itemType == L_Const.resType.soulEssence then
    self.bind.img_icon = conf.icon
  elseif itemType == L_Const.resType.pet then
    self.bind.img_icon = conf.icon
  else
    self.bind.active_icon = true
    if itemType == L_Const.resType.hero then
      self.bind.img_icon = conf.icon
    else
      self.bind.img_icon = conf.icon
    end
  end
  local quality = conf.quality or 0
  self.bind.img_qualityBg = string.format("BSCommon/tex_homecommontip_bg_quality_%s.png", quality)
end

function this:setStars(num)
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

return this
