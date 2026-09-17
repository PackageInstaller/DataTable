local this = class("modulePetStarColorGroup", G_UIModuleBase)
local colorIdList = {}
local curActive = false

function this.bind()
  return {
    activeBtn = false,
    activeList = false,
    list_color = {
      moduleName = "pages/petCatalogue/cellPetStarColorItem"
    },
    normal_state = true,
    select_state = false
  }
end

function this.methods()
  return {
    onClickBtn = function(self)
      local targetActive = not self.bind.activeList
      if targetActive then
        if 0 < #colorIdList then
          self:setOptionActive(true)
        else
          L_FlyMsgManager:showNormalMsg("暂无星彩(Test)")
        end
      else
        self:setOptionActive(false)
      end
    end
  }
end

function this:setPetColorList(petId)
  self.bind.petId = petId
  self:setCurColor(0)
  table.clear(colorIdList)
  self.bind.list_color:clear()
  local petStarColorList = L_CatalogStore:getStarColorsByPetId(petId)
  if petStarColorList and 0 < #petStarColorList then
    table.insert(colorIdList, {colorId = 0})
    for i = 1, #petStarColorList do
      local targetId = petStarColorList[i]
      table.insert(colorIdList, {colorId = targetId})
    end
  end
  local modCount = #colorIdList % self.bindValue.colCount
  if 0 < modCount then
    local extraAddCount = self.bindValue.colCount - modCount
    for i = 1, extraAddCount do
      table.insert(colorIdList, {colorId = -1})
    end
  end
  self.bind.list_color:insert_array(colorIdList)
  self:setOptionActive(false)
  self.bind.activeBtn = 0 < #colorIdList
  self:SetActive(0 < #colorIdList)
end

function this:onPetColorItemClick(colorId)
  self:setCurColor(colorId)
  self:setOptionActive(false)
  self.parent:setStarColorId(colorId)
end

function this:setOptionActive(active)
  if curActive == active then
    return
  end
  self:refreshSelfActive(active)
  self.parent:setMaskActive(active, 1)
end

function this:refreshSelfActive(active)
  curActive = active
  self.bind.activeList = active
end

function this:setCurColor(colorId)
  self.curId = colorId
  local showColor = 0 < colorId
  self.bind.select_state = showColor
  self.bind.normal_state = not showColor
end

return this
