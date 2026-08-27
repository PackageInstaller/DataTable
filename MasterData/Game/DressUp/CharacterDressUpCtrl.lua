local CharacterDressUpCtrl = class("CharacterDressUpCtrl", ControllerBase)
local CharacterAvatarPart = require("Game.DressUp.AvatarPart.CharacterAvatarPartBase")
local cs_ResLoader = CS.ResLoader
local eCharacterAttachType = {Body = 1, Decorator = 2}
local AvatarParts = {
  [eCharacterAttachType.Body] = require("Game.DressUp.AvatarPart.BodyAvatarPart"),
  [eCharacterAttachType.Decorator] = require("Game.DressUp.AvatarPart.DecoratorAvatarPart")
}

function CharacterDressUpCtrl:Init()
  self.obj = nil
  self.dressUpController = nil
  self.animator = nil
  self.resLoader = nil
  self.avatarPartTable = {}
end

function CharacterDressUpCtrl:InitCharacterDressUpCtrl(parent, callback)
  self.resLoader = cs_ResLoader.Create()
  self.resLoader:LoadABAssetAsync(PathConsts:GetCharacterAvatarMainPrefabPath(), function(prefab)
    if IsNull(prefab) then
      return
    end
    self.obj = prefab:Instantiate(parent)
    self.dressUpController = self.obj:GetComponent(typeof(CS.DressUpController))
    self.animator = self.obj:GetComponent(typeof(CS.UnityEngine.Animator))
    if callback ~= nil then
      callback(self)
    end
  end)
end

function CharacterDressUpCtrl:CombinedParts(dressIdList)
  for key, dressId in pairs(dressIdList) do
    local avatarPartConfig = ConfigData.avatar_part[dressId]
    self:AttachAvatarPart(avatarPartConfig)
  end
end

function CharacterDressUpCtrl:AttachAvatarPart(avatarPartConfig)
  if avatarPartConfig == nil then
    return
  end
  local avatarPart = self.CreateAvatarPart(avatarPartConfig)
  avatarPart:Init()
  avatarPart:InitCharacterAvatarPart(avatarPartConfig, self)
  avatarPart:InstantiatePartObj(self.resLoader)
  avatarPart:AttachAvatarParts(self.obj.transform)
  local bodyPartType = avatarPartConfig.body_part_type
  self.avatarPartTable[bodyPartType] = avatarPart
end

function CharacterDressUpCtrl:ChangeParts(bodyPartType, newDressId)
  local oldAvatarPart = self.avatarPartTable[bodyPartType]
  if oldAvatarPart ~= nil and oldAvatarPart.dressId ~= newDressId then
    if oldAvatarPart.dressId ~= newDressId then
      oldAvatarPart:RemoveAvatarParts()
    else
      return
    end
  end
  local avatarPartConfig = ConfigData.avatar_part[newDressId]
  self:AttachAvatarPart(avatarPartConfig)
  self.animator:Rebind()
  self.animator:Update(0)
end

function CharacterDressUpCtrl.CreateAvatarPart(avatarPartConfig)
  if avatarPartConfig == nil then
    return
  end
  local attachType = avatarPartConfig.attach_type
  local avatarPartClass = AvatarParts[attachType]
  if avatarPartClass == nil then
    error("角色装扮挂载方式不存在,type:" .. tostring(attachType))
  end
  local avatarPart = avatarPartClass.New()
  return avatarPart
end

return CharacterDressUpCtrl
