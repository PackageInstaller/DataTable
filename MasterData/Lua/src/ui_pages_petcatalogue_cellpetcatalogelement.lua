local module = class("cellPetCatalogElement", G_UIModuleBase)
local animKey = {
  In = "Anim_cellPetCatalogAttrAddition_In",
  OpenAttr = "Anim_cellPetCatalogAttrAddition_Open",
  CloseAttr = "Anim_cellPetCatalogAttrAddition_Close"
}

function module.bind()
  return {
    cellActive = true,
    spaceActive = false,
    img_bg = "",
    img_icon = "",
    color_bgMask = C_Color(1, 1, 1, 1),
    color_decTxt = C_Color(1, 1, 1, 1),
    txtLevel = "",
    attrActive = false,
    emptyActive = false,
    listAttr = {
      moduleName = "pages/petCatalogue/cellPetCatalogElementAttrItem"
    }
  }
end

function module.methods()
  return {
    onClickAttr = function(self)
      if self.bind.clickCb then
        self.bind.clickCb(self.bind.idx)
      end
    end
  }
end

function module:refresh()
  self.bind.spaceActive = self.bind.idx % 2 == 1
  local eId = self.bind.elementId
  local attrs = {}
  local tempAttrs = L_CatalogStore:getElementAllAttr(eId)
  for attrId, attrVal in pairs(tempAttrs) do
    local attrTpl = L_GameTpl:getBattleInfoTpl():getTplById(attrId)
    table.insert(attrs, {
      attrId = attrId,
      attrVal = attrVal,
      index = L_GameTpl:getBattleInfoTpl():getPetSort(attrTpl),
      color_attrBg = string.format("%s99", self.bind.color_attrBg)
    })
  end
  if #attrs <= 0 then
    self.bind.emptyActive = true
  end
  table.sort(attrs, function(a, b)
    return a.index < b.index
  end)
  for i = 1, #attrs do
    attrs[i].index = i
  end
  self.bind.listAttr:clear()
  self.bind.listAttr:insert_array(attrs)
end

function module:setExpand(isExpand)
  if self.bind.attrActive == isExpand then
    return
  end
  if isExpand then
    self.bind.attrActive = true
    self.bindComponents.anim:Play(animKey.OpenAttr)
  else
    self.bindComponents.anim:Play(animKey.CloseAttr)
    L_TimerManager:newOrResetTimer(self, "playAnim_Close", function()
      self.bind.attrActive = false
    end, 0.4)
  end
end

function module:playAnim_In()
  self.bind.cellActive = false
  L_TimerManager:newOrResetTimer(self, "playAnim_In", function()
    self.bind.cellActive = true
    self.bindComponents.anim:Play(animKey.In)
  end, self.bind.delayTimer)
end

return module
