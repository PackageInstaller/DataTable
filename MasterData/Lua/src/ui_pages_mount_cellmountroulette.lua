local this = class("cellMountRoulette", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    go_empty = false,
    txt_index = nil,
    go_normal = false,
    img_icon = nil,
    module_mountMoveType = {
      moduleName = "pages/mount/moduleMountMoveType"
    },
    module_petGameplayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    },
    module_checkInfo = {
      moduleName = "pages/pet/modulePetSSLCheckBar"
    },
    modulePetFlashEft = {
      moduleName = "pages/pet/modulePetFlashEft"
    }
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end,
    onPointEnter_content = function(self)
      self:emit("onPointEnter_content", self.bind)
    end,
    onPointExit_content = function(self)
      self:emit("onPointExit_content", self.bind)
    end
  }
end

function this:open()
  this.super.open(self)
  self:initCell(true)
end

function this:initCell(isInit)
  if not self.isBind then
    return
  end
  self._guid = L_MountStore:getMountMap()[self.bind.index]
  local isEmpty = math.isEmpty(self._guid)
  self.modules.modulePetFlashEft:setModulePetFlashEftData(self._guid)
  local isDataChange = self._lastGuid ~= self._guid
  if isDataChange or isInit then
    self.bind.go_empty = isEmpty
    self.bind.go_normal = not isEmpty
  end
  if not isEmpty then
    local pet = L_PetStore:getPetItem(self._guid)
    local tpl = _petTpl:getTplById(pet.id)
    self.bind.img_icon = _petTpl:getPetPixelIcon(tpl, pet:isSpecialPet())
    local moduleMoveType = self.modules.module_mountMoveType
    moduleMoveType:setData(self._guid)
    local moduleCheckInfo = self.modules.module_checkInfo
    moduleCheckInfo:setData(self._guid)
  else
    self.bind.txt_index = tostring(self.bind.index)
  end
  local moduleStatus = self.modules.module_petGameplayStatus
  moduleStatus:setContentShow(self._guid == L_MountStore:getEquipMountId())
  moduleStatus:setCurSelectForMount()
  self._lastGuid = self._guid
end

return this
