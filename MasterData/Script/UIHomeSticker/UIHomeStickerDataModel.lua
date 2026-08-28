local DataModel = {
  allCheckInCharacters = {},
  curSelectCharacterIdx = 0,
  recordSelectCharacterIdx = 0,
  curRefreshBreakLv = 0
}

local function AddCharacterById(id)
  local character = {}
  character.id = tonumber(id)
  local ca = PlayerData:GetFactoryData(id, "UnitFactory")
  local currentSkin
  if id ~= 10000137 and id ~= 10000173 then
    currentSkin = tonumber(PlayerData.ServerData.roles[id].current_skin[1])
  else
    currentSkin = ca.viewId
  end
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  character.name = ca.name
  character.qualityInt = ca.qualityInt
  character.homeCharacter = ca.homeCharacter
  if currentSkin == ca.viewId then
    character.profilePhotoList = ca.ProfilePhotoList
  else
    character.profilePhotoList = viewCA.ProfilePhotoList
  end
  character.spinePath = viewCA.HomeresDir
  character.face = viewCA.face
  if id == 10000137 or id == 10000173 then
    character.isGender = true
  end
  if character.homeCharacter ~= -1 then
    table.insert(DataModel.allCheckInCharacters, character)
  end
end

function DataModel.Init()
  DataModel.allCheckInCharacters = {}
  local gender = PlayerData:GetUserInfo().gender or 1
  local genderUnitId = gender == 1 and 10000137 or 10000173
  AddCharacterById(genderUnitId)
  for k, v in pairs(PlayerData.ServerData.roles) do
    AddCharacterById(k)
  end
  table.sort(DataModel.allCheckInCharacters, function(t1, t2)
    if t1.isGender and not t2.isGender then
      return true
    end
    if t2.isGender and not t1.isGender then
      return false
    end
    if t1.qualityInt == t2.qualityInt then
      return t1.id > t2.id
    end
    return t1.qualityInt > t2.qualityInt
  end)
  DataModel.playerAvatar = {}
  for k, v in pairs(PlayerData:GetUserInfo().avatar_list) do
    DataModel.playerAvatar[v] = 1
  end
  DataModel.curSelectCharacterIdx = 1
end

function DataModel.UpdataAvatarData(data)
  for k, v in pairs(data) do
    DataModel.playerAvatar[k] = 1
  end
end

return DataModel
