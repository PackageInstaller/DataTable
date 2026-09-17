local this = class("moduleAttrView", G_UIModuleBase)
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local petElementColor = {
  [1] = "#EE8580",
  [2] = "#E59E5E",
  [3] = "#D6BB7F",
  [4] = "#8DD583",
  [5] = "#78D0CE",
  [6] = "#76B4E9",
  [7] = "#6B76E6",
  [8] = "#DFCB47",
  [9] = "#8A6CD3"
}
local AttrElementColor = {
  [1] = "#F5D0D1",
  [2] = "#F4DCC8",
  [3] = "#EFE4CF",
  [4] = "#E1F2DD",
  [5] = "#C1EBEA",
  [6] = "#D0EFFD",
  [7] = "#EBECFF",
  [8] = "#F9EACA",
  [9] = "#E3D7FF"
}
local timeInterval = 0.02

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {curExpandIdx = 0}
end

function this.bind()
  return {
    list_element = {
      moduleName = "pages/petCatalogue/cellPetCatalogElement"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  if CS.Lens.Gameplay.Utility.ResolutionUtility.CheckSuperWidthScreen() then
    self.bindComponents.rect_listContent.pivot = C_Vector2(0.5, 0.5)
  else
    self.bindComponents.rect_listContent.pivot = C_Vector2(0, 0.5)
  end
  self.elasticity = self.bindComponents.scrollView.elasticity
end

function this:close(options)
  this.super.close(self, options)
  if L_CommonUtil.isValid(self.tween) then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:refresh()
  self.bind.list_element:clear()
  local elementList = {}
  local eleData = _elementTypeTpl.data
  for eid, eData in pairs(eleData) do
    if eData.elementiconography[1] and not string.isEmpty(eData.elementiconography[1]) then
      local eleLv = L_CatalogStore:getElementLv(eid)
      local _, color = C_ColorUtility.TryParseHtmlString(petElementColor[eid])
      local tpl = _elementTypeTpl:getTplById(eid)
      table.insert(elementList, {
        elementId = eid,
        img_bg = _elementTypeTpl:getElementiconography(tpl, 1),
        img_icon = _elementTypeTpl:getElementiconography(tpl, 2),
        color_bgMask = color,
        color_decTxt = color,
        color_attrBg = AttrElementColor[eid],
        txtLevel = L_WordsTpl:getValue("ui_iconography_level_word") .. eleLv,
        delayTimer = timeInterval * eid,
        clickCb = function(idx)
          self:expandAttr(idx)
        end
      })
    end
  end
  table.sort(elementList, function(a, b)
    return a.elementId < b.elementId
  end)
  for i = 1, #elementList do
    elementList[i].idx = i
  end
  self.bind.list_element:insert_array(elementList)
end

function this:expandAttr(idx)
  L_UI:open("pageBlank", {timeClose = 0.4})
  if self.data.curExpandIdx == idx then
    local item = self.bind.list_element:getItemCls(idx)
    item:setExpand(false)
    self.data.curExpandIdx = nil
  else
    if not math.isEmpty(self.data.curExpandIdx) then
      local oldItem = self.bind.list_element:getItemCls(self.data.curExpandIdx)
      oldItem:setExpand(false)
    end
    local newItem = self.bind.list_element:getItemCls(idx)
    if newItem then
      newItem:setExpand(true)
      self:elementAttrRebound(idx)
    end
    self.data.curExpandIdx = idx
  end
end

function this:showView()
  for i, v in ipairs(self.bind.list_element:getItemCls()) do
    v:playAnim_In()
  end
end

function this:elementAttrRebound(index)
  local cell = self.bind.list_element:getItemCls(index)
  local rectListContent = self.bindComponents.rect_listContent
  local rectCell = cell.bindComponents.rect_cell
  local rectViewport = self.bindComponents.rect_viewport
  local maxPosX = 238 * (index - 1) + 748
  if maxPosX > rectViewport.rect.size.x then
    local reboundIndex = index
    for i = reboundIndex, #self.bind.list_element do
      if not self:cellInViewport(i) then
        reboundIndex = i - 1
        break
      else
        reboundIndex = i
      end
    end
    self.reboundIndex = index < reboundIndex and reboundIndex or index
    self.openIndex = index
    self.oldReboundIndex = self.data.curExpandIdx
    self.bindComponents.scrollView.elasticity = 0
    L_TimerManager:newOrResetTimer(self, "elementAttrRebound", function()
      self.reboundIndex = nil
      self.oldReboundIndex = nil
      self.bindComponents.scrollView.elasticity = self.elasticity
    end, 0.45)
  end
end

function this:update()
  if not math.isEmpty(self.reboundIndex) then
    if self.oldReboundIndex and self.oldReboundIndex > self.openIndex then
      self.bindComponents.scrollView.horizontalNormalizedPosition = 1
    else
      local cell = self.bind.list_element:getItemCls(self.reboundIndex)
      local maxWidth = self.bindComponents.rect_listContent.rect.size.x
      local jumpX = cell.bindComponents.rect_cell.anchoredPosition.x + cell.bindComponents.rect_cell.rect.size.x
      if jumpX > self.bindComponents.rect_viewport.rect.size.x then
        local horizontalNormalizedPosition = (jumpX - self.bindComponents.rect_viewport.rect.size.x) / (maxWidth - self.bindComponents.rect_viewport.rect.size.x)
        self.bindComponents.scrollView.horizontalNormalizedPosition = math.clamp(horizontalNormalizedPosition, 0, 1)
      end
      print("图鉴属性加成动效Start：" .. tostring(self.bindComponents.scrollView.horizontalNormalizedPosition))
    end
  end
end

function this:cellInViewport(index)
  local cell = self.bind.list_element:getItemCls(index)
  if not cell then
    return false
  end
  return cell.bindComponents.rect_cell.anchoredPosition.x + self.bindComponents.rect_listContent.anchoredPosition.x < self.bindComponents.rect_viewport.rect.width
end

return this
