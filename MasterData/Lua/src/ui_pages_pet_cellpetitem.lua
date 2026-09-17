local module = class("cellPetItem", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    photoEntity = nil
  }
end

function module.bind()
  return {
    selectedBg = false,
    name = "",
    Lv = "",
    lockIcon = "Page/BSCommon/tex_common_icon_lock01",
    show_lock = false,
    show_belongIcon = false,
    belongIcon = ""
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      if self.bind.guid then
        self:emit("onClick_Choose", self.bind.guid)
      end
    end,
    onLongClick_btn = function(self)
      if self.bind.guid then
        self:emit("onLongClick_btn", self.bind.guid)
      end
    end
  }
end

function module:open()
  if self.bindComponents.reddotNew then
    L_ReddotManager:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.PetNew, self.bind.guid))
  end
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.lock ~= nil then
    self.bind.lockIcon = self.bind.lock == true and "Page/BSCommon/tex_common_icon_lock02" or "Page/BSCommon/tex_common_icon_lock01"
    self.bind.show_lock = self.bind.lock == true and true or false
  end
  if self.bind.id ~= nil and self.bind.id ~= 0 then
    local tpl = petInfoTpl:getTplById(self.bind.id)
    local unitID = petInfoTpl:getUnitID(tpl)
    if unitID then
      local petItem = L_PetStore:getPetItem(self.bind.guid)
      local path = petInfoTpl:getPetIcon(tpl, petItem:isSpecialPet())
      self.bindComponents.petIcon:LoadSprite(path)
    end
  end
end

function module:close()
end

return module
