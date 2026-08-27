local base = require("Game.DressUp.AvatarPart.CharacterAvatarPartBase")
local BodyAvatarPart = class("BodyAvatarPart", base)

function BodyAvatarPart:Init()
  base.Init(self)
  self.avatarType = 0
  self.cs_avatarPart = nil
end

function BodyAvatarPart:InstantiatePartObj(resLoader)
  if IsNull(resLoader) then
    return
  end
  base.InstantiatePartObj(self, resLoader)
  if IsNull(self.obj) then
    return
  end
  self.cs_avatarPart = self.obj:GetComponent(typeof(CS.MagicaCloth.MagicaAvatarParts))
  return self.obj
end

function BodyAvatarPart:AttachAvatarParts(parent)
  if self.dressUpCtrl == nil then
    return
  end
  if IsNull(self.cs_avatarPart) then
    return
  end
  if IsNull(self.dressUpCtrl.dressUpController) then
    return
  end
  self:RemoveAvatarParts()
  self.partsId = self.dressUpCtrl.dressUpController:AttachAvatarParts(self.cs_avatarPart)
  if not IsNull(parent) then
    self.obj.transform:SetParent(parent)
    self.obj.transform.position = Vector3.zero
    self.obj.transform.localEulerAngles = Vector3.zero
  end
end

function BodyAvatarPart:RemoveAvatarParts()
  if self.dressUpCtrl == nil then
    return
  end
  if IsNull(self.cs_avatarPart) then
    return
  end
  if IsNull(self.dressUpCtrl.dressUpController) then
    return
  end
  self.dressUpCtrl.dressUpController:RemoveAvatarParts(self.cs_avatarPart)
  self.partsId = 0
end

return BodyAvatarPart
