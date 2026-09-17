local this = class("cellDecryptPet", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    active_none = false,
    active_content = false,
    active_emptySelect = false,
    active_contentSelect = false,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    txt_slotNum = "",
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
    end,
    onPointEnter_item = function(self)
      if self.bind.onDragEnter then
        self.bind.onDragEnter(self)
      end
    end,
    onPointExit_item = function(self)
      if self.bind.onDragExit then
        self.bind.onDragExit(self)
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
    self.bind.txt_slotNum = tostring(self.bind.index)
    return
  end
  local pixel = self.modules.module_pixelIcon
  pixel:setGuid(self.bind.guid)
  if not pixel:getIsInitFrameIcon() then
    pixel:playPixelGif()
    pixel:stopPixelGif()
  end
  self:refreshElementIcon()
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
  self.bind.active_emptySelect = bSelect
  self.bind.active_contentSelect = bSelect
  if bSelect and self.bind.guid > 0 then
    self.modules.module_pixelIcon:playPixelGif()
  else
    self.modules.module_pixelIcon:stopPixelGif()
  end
end

return this
