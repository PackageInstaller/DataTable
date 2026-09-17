local this = class("cellGiftItem", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    txt_itemName = "",
    txt_favorValue = "",
    txt_ownNum = "",
    img_icon = "",
    list_star = {},
    active_sel = false,
    active_favour = false,
    go_interact = false,
    txt_interact = "",
    go_lock = false,
    go_hasGive = false,
    go_normalPresent = false,
    go_furniturePresent = false,
    go_reddot = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback(self.index)
      end
    end
  }
end

function this:open()
  self.bind.go_reddot = false
  if self.bind.bFurniture then
    self.bind.go_normalPresent = false
    self.bind.go_furniturePresent = true
    self:setInteractUI(self.bind.interact)
    if self.bind.furnitureState == L_Const.FurnitureStateEnum.InBag then
      self.bind.go_lock = false
      self.bind.go_hasGive = false
      self.bind.go_reddot = true
    elseif self.bind.furnitureState == L_Const.FurnitureStateEnum.HasGive then
      self.bind.go_lock = false
      self.bind.go_hasGive = true
    elseif self.bind.furnitureState == L_Const.FurnitureStateEnum.Notbuy then
      self.bind.go_lock = true
      self.bind.go_hasGive = false
    end
  else
    self.bind.go_normalPresent = true
    self.bind.go_furniturePresent = false
    self.bind.txt_ownNum = tostring(self.bind.itemNum)
    self.bind.active_favour = self.bind.bFavour
  end
  self.index = self.bind.index
  self.bind.active_sel = self.bind.bSel
  self.itemId = self.bind.itemId
  self.bind.txt_itemName = self.bind.name
  local configData = L_ItemTplManager:getCommonItem(self.itemId)
  self.bind.img_icon = configData.icon
  self.bind.txt_favorValue = "+ " .. self.bind.favourValue
  local starNum = L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, self.itemId)
  self:setStars(starNum)
end

function this:refresh()
end

function this:setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function this:setInteractUI(interact)
  if interact then
    if interact == 0 then
      self.bind.go_interact = false
    elseif interact == 1 then
      self.bind.go_interact = true
      self.bind.txt_interact = L_WordsTpl:getValue("residual_code_cellgiftitem_01")
    elseif interact == 2 then
      self.bind.go_interact = true
      self.bind.txt_interact = L_WordsTpl:getValue("residual_code_cellgiftitem_02")
    end
  else
    self.bind.go_interact = false
  end
end

return this
