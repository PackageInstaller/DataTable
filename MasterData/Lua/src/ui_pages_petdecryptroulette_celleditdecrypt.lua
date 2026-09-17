local this = class("cellEditDecrypt", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    active_none = false,
    active_content = false,
    active_Select = false,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    module_petGamePlayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    },
    active_curSlot = false,
    txt_curSlot = "",
    list_petElement = {
      moduleName = "pages/petDecryptRoulette/cellDecryptPetElementIcon"
    }
  }
end

function this.methods()
  return {
    onClick_item = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  self.bind.active_none = self.bind.guid <= 0
  self.bind.active_content = self.bind.guid > 0
  if self.bind.guid <= 0 then
    return
  end
  self.modules.module_pixelIcon:setGuid(self.bind.guid)
  local index = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, self.bind.guid)
  self.bind.active_curSlot = 0 < index
  if 0 < index then
    self.bind.txt_curSlot = tostring(index)
  end
  self.modules.module_petGamePlayStatus:setData(self.bind.guid)
  self:refreshElementIcon()
  self:setSelectState(self.bind.selected)
end

function this:refreshElementIcon()
  local petItem = L_PetStore:getPetItem(self.bind.guid)
  local petCfg = _petTpl:getTplById(petItem:petCfgId())
  local element = _petTpl:getElement(petCfg)
  local tmp = {}
  for _, v in ipairs(element or {}) do
    table.insert(tmp, {elementId = v})
  end
  self.bind.list_petElement:clear()
  self.bind.list_petElement:insert_array(tmp)
end

function this:setSelectState(bSelect)
  self.bind.active_Select = bSelect
  if bSelect and self.bind.guid > 0 then
    self.modules.module_pixelIcon:playPixelGif()
  else
    self.modules.module_pixelIcon:stopPixelGif()
  end
end

return this
