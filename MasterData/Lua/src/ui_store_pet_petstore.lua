local this = class("petStore", G_BaseStore)
this.event = {
  sortPetList = "sortPetList",
  refreshPet = "refreshPet",
  refreshPetDatas = "refreshPetDatas",
  setCurPetId = "setCurPetId",
  setSelectReleasePet = "setSelectReleasePet",
  clickBoxFilter = "clickBoxFilter",
  refreshIncubationList = "refreshIncubationList",
  refreshFeedBack = "refreshFeedBack",
  refreshNewPet = "refreshNewPet",
  refreshPetGeneMutation = "refreshPetGeneMutation",
  removePet = "removePet",
  removePetEgg = "removePetEgg",
  closeGetPet = "closeGetPet",
  closeGetPetEgg = "closeGetPetEgg",
  closePetBox = "closePetBox",
  updatePetSkill = "updatePetSkill",
  getNewPetSkill = "getNewPetSkill",
  convertPetSkill = "convertPetSkill",
  refreshBuildingPet = "refreshBuildingPet",
  refreshPetBox = "refreshPetBox",
  refreshSinglePetBox = "refreshSinglePetBox",
  refreshPetCombindHero = "refreshPetCombindHero",
  petLevelUp = "petLevelUp",
  petComprehensionLvUp = "petComprehensionLvUp",
  setPetReleaseMode = "setPetReleaseMode",
  specialPetInfoRefresh = "specialPetInfoRefresh",
  refreshPetFavorLvUp = "refreshPetFavorLvUp",
  refreshPetFruitFavorLvUp = "refreshPetFruitFavorLvUp",
  refreshSatiety = "refreshSatiety",
  refreshBoxLock = "refreshBoxLock",
  refreshStarSoul = "refreshStarSoul",
  refreshPetCatchFoodBuff = "refreshPetCatchFoodBuff",
  triggerLaborDescPoint = "triggerLaborDescPoint"
}
this.saveKey = {
  save_curBoxIndex = "saveBoxIndex_%d"
}
local _keyShowPetSkillDetail = "showPetSkillDetail"
this:importPartialClass(require(L_R.store .. "pet.petState"))
this:importPartialClass(require(L_R.store .. "pet.petAction"))

function this:setCurSelectedEggGuid(guid)
  self.data.curSelectedEggGuid = guid
end

function this:removePet(guid)
  local refreshBox = {}
  for i, v in ipairs(guid) do
    for n, k in pairs(self.data.petList) do
      if k.guid == v then
        if self.data.curSelectedPetGuid == v then
          self.data.curSelectedPetGuid = nil
        end
        self.data.petList[n] = nil
      end
    end
    local index = self.data.petBoxIndex[v].index
    if index and self.data.petBoxList[index][self.data.petBoxIndex[v].slot] then
      self.data.petBoxList[index][self.data.petBoxIndex[v].slot] = 0
      refreshBox[index] = index
    end
  end
  if not table.isEmpty(refreshBox) then
    self:call(self.event.refreshPetBox, refreshBox)
  end
  self:call(self.event.removePet, guid)
end

function this:removePetEgg(guid)
  for i, v in ipairs(guid) do
    if self.data.petEggList[v] ~= nil then
      self.data.petEggList[v] = nil
    end
  end
  self:call(self.event.removePetEgg)
end

function this:setHasInitSync()
  self.data.setHasInitSync = true
end

function this:setInsertBox(boxId, guid, needRefreshBox)
  if math.isEmpty(boxId) then
    return
  end
  needRefreshBox = needRefreshBox or {}
  local index = boxId // 100
  local slot = boxId % 100
  local oldBox = 0
  local oldSlot = 0
  if self.data.petBoxIndex[guid] then
    oldBox = self.data.petBoxIndex[guid].index
    oldSlot = self.data.petBoxIndex[guid].slot
    if (oldBox ~= index or oldSlot ~= slot) and self.data.petBoxList[oldBox][oldSlot] == guid then
      self.data.petBoxList[oldBox][oldSlot] = 0
    end
  end
  if self.data.petBoxList[index] == nil then
    self.data.petBoxList[index] = {}
  end
  self.data.petBoxList[index][slot] = guid
  self.data.petBoxIndex[guid] = {}
  self.data.petBoxIndex[guid].index = index
  self.data.petBoxIndex[guid].slot = slot
  needRefreshBox[oldBox] = oldBox
  needRefreshBox[index] = index
  return needRefreshBox
end

function this:setSaveBoxIndexKey(boxIndex, playerId)
  local pId = playerId or L_PlayerStore:getPlayerId()
  local key = string.format(self.saveKey.save_curBoxIndex, pId)
  C_PlayerPrefsUtility.SetInt(key, boxIndex)
end

function this:setPetBoxName(index, name)
  self.data.petBoxNameList[index] = name
end

function this:setPetBoxCustomName(index, name)
  self.data.petBoxCustomNameList[index] = name or ""
end

function this:checkPetBoxCanAdd()
  for i = 1, self.data.petBoxNum do
    local isFull = self:getPetBoxIsFull(i)
    if not isFull then
      return true
    end
  end
  return false
end

function this:checkPetBoxCanPlace()
  for i = 1, self.data.petBoxNum do
    local isFull = self:getPetBoxIsFull(i)
    local isLock = self:getBoxIsLock(i)
    if isFull == false and isLock == false then
      return true
    end
  end
  return false
end

function this:setShowPetSkillDetail(isShow)
  self.showDetail = isShow
  L_CommonUtil.setLocalBoolValue(_keyShowPetSkillDetail, self.showDetail)
end

function this:isShowPetSkillDetail()
  if self.showDetail ~= nil then
    return self.showDetail
  end
  self.showDetail = L_CommonUtil.getLocalBoolValue(_keyShowPetSkillDetail) or false
  return self.showDetail
end

function this:getCurPetDuelFormationPetGuids()
  local pets = L_PetDuelStore:getCurPetDuelFormationPetGuids()
  local duelId = L_PetDuelStore:getCurChallengeLevelId()
  if self:isTrialDuel(duelId) then
    local tpl = kiBoDuelTpl:getTplById(duelId)
    local trialPets = kiBoDuelTpl:getKiboList(tpl)
    pets = {}
    for _, v in ipairs(trialPets) do
      table.insert(pets, {is_trial = true, id = v})
    end
  elseif kiBoDuelTpl:isKiboLock(duelId) then
    pets = L_PetDuelStore:getPetDuelFormationPetGuids(L_Const.kiBoDuelBlockSlot)
  end
  return pets
end

function this:clear()
  this.super.clear(self)
  self.showDetail = nil
end

return this
