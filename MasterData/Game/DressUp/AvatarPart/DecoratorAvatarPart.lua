local base = require("Game.DressUp.AvatarPart.CharacterAvatarPartBase")
local DecoratorAvatarPart = class("DecoratorAvatarPart", base)
local attachNodePathTable = {
  right_hand = "root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand",
  left_hand = "root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand",
  head = "root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 Head"
}

function DecoratorAvatarPart:Init()
  base.Init(self)
  self.avatarType = 0
  self.cs_avatarPart = nil
end

function DecoratorAvatarPart:AttachAvatarParts()
  if self.dressUpCtrl == nil then
    return
  end
  if IsNull(self.dressUpCtrl.obj) then
    return
  end
  if IsNull(self.obj) then
    return
  end
  local attachNodePath = attachNodePathTable[self.dressData.attach_pos]
  local parent = self.dressUpCtrl.obj.transform:Find(attachNodePath)
  if not IsNull(parent) then
    self.obj.transform:SetParent(parent)
    self.obj.transform.localPosition = Vector3.zero
    self.obj.transform.localEulerAngles = Vector3.zero
    self.obj.transform.localScale = Vector3.one
  end
end

function DecoratorAvatarPart:RemoveAvatarParts()
  if IsNull(self.obj) then
    return
  end
  CS.UnityEngine.GameObject.Destroy(self.obj)
end

return DecoratorAvatarPart
