local CharacterAvatarPartBase = class("CharacterAvatarPartBase")
local bodyPartTypeNameTable = {
  [1] = "_head",
  [2] = "_hair",
  [3] = "_body",
  [4] = "_leg",
  [5] = "",
  [6] = ""
}

function CharacterAvatarPartBase:Init()
  self.dressId = 0
  self.dressData = nil
  self.prefabPath = nil
  self.obj = nil
  self.dressUpCtrl = nil
end

function CharacterAvatarPartBase:InitCharacterAvatarPart(avatarPartConfig, DressUpCtrl)
  self.dressData = avatarPartConfig
  if self.dressData == nil then
    return
  end
  self.dressId = avatarPartConfig.id
  self.dressUpCtrl = DressUpCtrl
end

function CharacterAvatarPartBase:InstantiatePartObj(resLoader, callback)
  if resLoader == nil then
    return
  end
  local prefabPath = self:GetAvatarPartPath()
  resLoader:LoadABAssetAsync(prefabPath, function(prefab)
    if IsNull(prefab) then
      return
    end
    self.obj = prefab:Instantiate()
    if callback ~= nil then
      callback(self)
    end
  end)
end

function CharacterAvatarPartBase:AttachAvatarParts()
end

function CharacterAvatarPartBase:RemoveAvatarParts()
end

function CharacterAvatarPartBase:GetAvatarPartPath()
  if self.dressData == nil then
    return
  end
  local avatarName = self.dressData.avatar_name
  local bodyPartType = self.dressData.body_part_type
  local prefabPath = PathConsts:GetCharacterAvatarPartPrefabPath(avatarName, avatarName .. bodyPartTypeNameTable[bodyPartType])
  return prefabPath
end

return CharacterAvatarPartBase
