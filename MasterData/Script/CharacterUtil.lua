local CharacterUtil = {}

function CharacterUtil.GetHomeCharacterById(uid)
  if not uid or uid == "" then
    return
  end
  local unitCA = PlayerData:GetFactoryData(uid, "UnitFactory")
  local characterId = tonumber(unitCA.homeCharacter)
  local character = HomeCharacterManager:GetCharacterById(characterId)
  return character
end

function CharacterUtil.CreateHomeCharacter(uid, roomIndex, tileIndex)
  if not uid or uid == "" then
    return
  end
  local unitCA = PlayerData:GetFactoryData(uid, "UnitFactory")
  local characterId = tonumber(unitCA.homeCharacter)
  return HomeCharacterManager:CreateCharacter(characterId, roomIndex, tileIndex)
end

function CharacterUtil.GetFurnitureRoomIndexAndTileIndex(ufid)
  local furData = PlayerData:GetFurniture()[ufid]
  local MainUIDataModel = require("UIMainUI/UIMainUIDataModel")
  local roomIndex = MainUIDataModel.GetRoomIndexByUCid(furData.u_cid)
  if not roomIndex then
    return
  end
  local homeFurniture = HomeManager:GetFurnitureByUfid(ufid, roomIndex)
  local tileIndex = homeFurniture and homeFurniture:GetTileIdx()
  return roomIndex, tileIndex
end

function CharacterUtil.InitOp(uid, ufid, opIndex, opTime)
  local character = CharacterUtil.GetHomeCharacterById(uid)
  if not character then
    local roomIndex, tileIndex = CharacterUtil.GetFurnitureRoomIndexAndTileIndex(ufid)
    if not roomIndex or not tileIndex then
      return
    end
    character = CharacterUtil.CreateHomeCharacter(uid, roomIndex, tileIndex)
  end
  if not character then
    return
  end
  character.aiPart:Stop()
  character.movePart:Stop()
  HomeCharacterManager:InitContinuousOp(character, ufid, opIndex, opTime)
end

function CharacterUtil.StartOp(uid, ufid, opIndex, opTime, needCreate)
  local character = CharacterUtil.GetHomeCharacterById(uid)
  if not character and needCreate then
    local roomIndex, tileIndex = CharacterUtil.GetFurnitureRoomIndexAndTileIndex(ufid)
    if not roomIndex or not tileIndex then
      return
    end
    character = CharacterUtil.CreateHomeCharacter(uid, roomIndex, tileIndex)
  end
  if not character then
    return
  end
  character.aiPart:Stop()
  HomeCharacterManager:StartOp(character, ufid, opIndex, opTime)
end

function CharacterUtil.StopOp(uid, isCaption)
  if not uid or uid == "" then
    return
  end
  local character = CharacterUtil.GetHomeCharacterById(uid)
  if character then
    character.aiPart:Stop()
    HomeCharacterManager:StopOp(character)
    if character.workPart.opTime ~= 0 then
      if character.movePart.IsMoving then
        character.workPart:ResetOpData()
        character.tagPart:Delete("\228\184\141\232\131\189\230\137\147\230\150\173")
        character:ResetAIPart()
      else
        character.workPart:ResetOpData()
        character.tagPart:Delete("\228\184\141\232\131\189\230\137\147\230\150\173")
        HomeCharacterManager:RemoveCharacter(character)
        local HomeDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
        local roomCount = HomeDataModel.GetRoomCount()
        local roomIndex
        if isCaption then
          if 0 < PosClickHandler.GetRoomEmptyTileCount(1) then
            roomIndex = 1
          end
        else
          local curRoomIndex = HomeManager.camRoom + 1
          if 0 < PosClickHandler.GetRoomEmptyTileCount(curRoomIndex) then
            roomIndex = curRoomIndex
          else
            for i = 2, roomCount do
              if i ~= curRoomIndex and 0 < PosClickHandler.GetRoomEmptyTileCount(i) then
                roomIndex = i
                break
              end
            end
          end
        end
        if roomIndex then
          character = CharacterUtil.CreateHomeCharacter(uid, roomIndex - 1, -1)
          if character then
            character:ResetAIPart()
          end
        end
      end
    else
      character:ResetAIPart()
    end
  end
end

function CharacterUtil.InitCharacterOp()
  local liveController = require("UINewHomeLive/UINewHomeLiveController")
  local emergencyDataModel = require("UIHomeEmergency/UIHomeEmergencyDataModel")
  local homeFoodController = require("UIHomeFood/UIHomeFoodController")
  liveController.InitSleep()
  emergencyDataModel.InitEmergency()
  homeFoodController.InitFoodCook()
end

function CharacterUtil.FocusResetMovePart()
  for unitId, v in pairs(PlayerData.ServerData.roles) do
    local homeCharacter = CharacterUtil.GetHomeCharacterById(unitId)
    if homeCharacter then
      homeCharacter.movePart:Stop()
    end
  end
end

function CharacterUtil.GetCharacterAllSkinJson(characterId)
  characterId = tonumber(characterId)
  if characterId ~= ChangeSkinUtil.GetCaptainCharacterId() then
    return
  end
  local normalSkinItems = ChangeSkinUtil.InitNormalSkinItems()
  local overlaySkinItems = ChangeSkinUtil.InitOverlaySkinItems()
  local skinJson, attachmentsJson, atlasSkinJson, atlasOverlaySkinJson = ChangeSkinUtil.GetAllSkinJson(normalSkinItems, overlaySkinItems)
  local hairColorCurves = ""
  local hairColorMask = ""
  local hairColorTagId = ChangeSkinUtil.GetHairColor(normalSkinItems[EnumDefine.ESkinType.Hair])
  if hairColorTagId then
    local tagCA = PlayerData:GetFactoryData(hairColorTagId, "TagFactory")
    if tagCA then
      hairColorCurves = tagCA.hairColorCurves or ""
      hairColorMask = tagCA.hairColorMask or ""
    end
  end
  return {
    [1] = skinJson or "",
    [2] = attachmentsJson or "",
    [3] = atlasSkinJson or "",
    [4] = atlasOverlaySkinJson or "",
    [5] = hairColorCurves,
    [6] = hairColorMask
  }
end

function CharacterUtil.InitCharacterSpineSkin(characterId)
  characterId = tonumber(characterId)
  if characterId ~= ChangeSkinUtil.GetCaptainCharacterId() then
    return
  end
  ChangeSkinUtil.InitHomeCaptainSpineSkin()
  ChangeSkinUtil.InitHomeCaptainSpineHairColor()
end

return CharacterUtil
