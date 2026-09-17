local this = class("cellSelectStation", G_UIModuleBase)
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()

function this.bind()
  return {
    cell_pixelPet = {
      moduleName = "pages/pet/cellPixelPet"
    },
    go_dropItem = false,
    img_dropItem = nil,
    module_gameplayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    }
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.go_content then
        self:emit("onClick_select", self.bind)
      end
    end
  }
end

function this:initCell()
  if not self.isBind then
    return
  end
  local isEmpty = math.isEmpty(self.bind.guid)
  local moduleIcon = self.modules.cell_pixelPet
  moduleIcon:setPetDataContent(self.bind.guid, {
    filterType = L_PetConst.filterPetBox.labor,
    needLaborType = self.bind.needLaborType,
    callback = function(cell)
      self:emit("onClick_select", self.bind)
    end
  })
  self:setSingleSelect(self.bind.curSelect)
  if isEmpty then
    return
  end
  local pet = L_PetStore:getPetItem(self.bind.guid)
  local moduleGameplayStatus = self.modules.module_gameplayStatus
  local isPetPlaceRanch
  if pet.work_build == 201 then
    isPetPlaceRanch = true
  else
    isPetPlaceRanch = false
  end
  moduleGameplayStatus:setData(self.bind.guid, isPetPlaceRanch, true, true)
  if self.bind.isCurStationed then
    moduleGameplayStatus:setCurSelectForWorking(isPetPlaceRanch)
  end
  local needShowDropItem = self.bind.isPasture
  if needShowDropItem then
    local confId = L_PetStore:getPetItem(self.bind.guid).id
    local petTalentTpl = _petHomeTalentTpl:getTplById(confId)
    if petTalentTpl then
      local dropIds = _petHomeTalentTpl:getFarmProducts(petTalentTpl)
      needShowDropItem = not table.isEmpty(dropIds)
      if needShowDropItem then
        local tpl_drop = _homeDropTpl:getTplById(dropIds[1])
        local itemType, itemId = _homeDropTpl:getItemType(tpl_drop), _homeDropTpl:getItemId(tpl_drop)
        local configData = L_ItemTplManager:getItemConfig(itemType, itemId[1])
        self.bind.img_dropItem = configData.icon
      end
    end
  end
  self.bind.go_dropItem = needShowDropItem
end

function this:setSingleSelect(active)
  if not self.isBind then
    return
  end
  self.bind.curSelect = active
  local pixel = self.modules.cell_pixelPet
  pixel:setGifPlay(self.bind.curSelect)
end

function this:refresh()
  self:initCell()
end

return this
