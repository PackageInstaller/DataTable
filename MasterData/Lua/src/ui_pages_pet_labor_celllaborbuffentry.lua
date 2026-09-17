local module = class("cellLaborBuffEntry", G_UIModuleBase)
local path_rarity = {
  [0] = "UI/Atlas/PetTalentObsolute/tex_homeequipment_bg_color01.png",
  [1] = "UI/Atlas/PetTalentObsolute/tex_homeequipment_bg_color02.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_homeequipment_bg_color03.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_homeequipment_bg_color04.png",
  [4] = "UI/Atlas/PetTalentObsolute/tex_homeequipment_bg_color05.png"
}

function module.bind()
  return {
    txt_title = "",
    img_icon = "",
    img_quality = "",
    txt_desc = "",
    go_iconBg = false,
    go_descBg = false,
    list_tab = {
      moduleName = "pages/pet/labor/cellIconTabItem"
    }
  }
end

function module:getItemId()
  return self.bind.id
end

function module:isShowHover(isShow)
  if not isShow and not self._isHoverShown then
    return
  end
  self.bind.go_descHover = true
  self.bind.go_iconHover = true
  local animName = isShow and "anim_petgene_cellLaborDesc_show_01" or "anim_petgene_cellLaborDesc_out_01"
  local descAnim = self.bindComponents.startEquipment_iconHover
  if descAnim then
    descAnim:Play(animName)
  end
  local iconAnim = self.bindComponents.canProduction_iconHover
  if iconAnim then
    iconAnim:Play(animName)
  end
  self._isHoverShown = isShow
end

function module:open()
end

function module:refresh()
  self:setData()
end

function module:setData()
  self._isHoverShown = false
  self.bind.go_descHover = false
  self.bind.go_iconHover = false
  if self.bind.rarityProduct ~= nil then
    self.bind.img_quality = path_rarity[self.bind.rarityProduct]
  end
  self:setDesc()
end

function module:setDesc()
  local str = L_Lang:_translate(self.bind.buffSimpleDesc)
  self.bind.list_tab:clear()
  self.bind.go_iconBg = false
  self.bind.go_descBg = true
  self.bind.txt_title = L_GameUtil.fillColor(self.bind.titleName, "#8b8c8f")
  if str and str ~= "" and str ~= " " then
    self.bind.list_tab.gameObject = false
    self.bind.txt_desc = self.bind.buffDesc
  else
    self.bind.txt_desc = ""
    if not self.bind.isStarEq then
      self.bind.go_iconBg = true
      self.bind.go_descBg = false
      self.bind.txt_title = L_GameUtil.fillColor(self.bind.titleName, "#ffffff")
    end
    self.bind.list_tab.gameObject = true
    local iconList = self.bind.iconList
    if iconList == nil or #iconList <= 0 then
      return
    end
    local dataList = {}
    for i, v in ipairs(iconList) do
      local cleanPath = string.gsub(iconList[i], "^%s*(.-)%s*$", "%1")
      local rarity = self.bind.rarityProduct
      local newIconPath = cleanPath:gsub("{0}", rarity)
      table.insert(dataList, {
        img_icon = newIconPath,
        rarity = rarity,
        isStarEq = self.bind.isStarEq
      })
    end
    self.bindComponents.horizontal.spacing = self.bind.isStarEq and 13 or 7.8
    self.bind.list_tab:insert_array(dataList)
  end
end

return module
