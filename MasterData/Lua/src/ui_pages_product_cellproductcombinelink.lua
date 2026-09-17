local page = class("cellProductCombineLink", G_UIModuleBase)
local LightBgPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_light_0%s.png"
local DarkBgPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_dark_0%s.png"

function page.bind()
  return {
    go_selected = false,
    go_next = false,
    img_icon = "",
    img_quality = ""
  }
end

function page.methods()
  return {
    onClick_select = function(self, id)
      self:onClick_select(self)
    end
  }
end

function page:refresh()
  self:init()
end

function page:init()
  local itemId = self.bind.itemId
  local itemType = math.isEmpty(self.bind.itemType) and L_Const.resType.commonItem or self.bind.itemType
  self.bind.img_icon = L_ItemTplManager:getItemIcon(itemType, itemId)
  local quality = L_ItemTplManager:getItemQuality(itemType, itemId)
  self.bind.img_quality = string.format(DarkBgPath, tostring(quality + 1))
  local is_current_select = self.parent and self.parent.parentTab and self.parent.parentTab.itemId == self.bind.itemId
  self:setSelect(is_current_select)
  self.bindComponents.ani_cellLinkJump:Play(self.bind.isLast and "anim_product_cell_linkjump_selected" or "anim_product_cell_linkjump_in")
end

function page:setSelect(select)
  self.bind.go_selected = select == true
  self.bind.go_next = select == false
end

function page:onClick_select()
  local is_current_select = self.parent and self.parent.parentTab and self.parent.parentTab.itemId == self.bind.itemId
  if is_current_select then
    return
  end
  self.parent:onClick_combineLink(self.bind)
end

return page
