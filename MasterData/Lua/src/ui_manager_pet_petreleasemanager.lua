local this = class("petReleaseManager")
local expReturnRaito = L_GameTpl:getGameConstTpl():getData("PET_RETURN_RATIO", L_Const.GameTplType.int) / 10000
local petExpItems = L_GameTpl:getGameConstTpl():getData("PET_EXPITEMID", L_Const.GameTplType.list_int)
local petFreeReward = L_GameTpl:getGameConstTpl():getData("PET_FREEREWARD", L_Const.GameTplType.list_int)
local petEggFreeReward = L_GameTpl:getGameConstTpl():getData("PET_FREEEGGREWARD", L_Const.GameTplType.list_int)
local petFreeRewardLimit = L_GameTpl:getGameConstTpl():getData("PET_FREE_DAYLY_TIME", L_Const.GameTplType.int)
local petFreeEggRewardLimit = L_GameTpl:getGameConstTpl():getData("PET_FREEEGG_DAYLY_TIME", L_Const.GameTplType.int)
local expReturnActive = L_GameTpl:getGameConstTpl():getData("PET_EXPERIENCE_RETURN", L_Const.GameTplType.bool)
local rankEvoReturnActive = L_GameTpl:getGameConstTpl():getData("PET_EVOLUTION_RETURNS", L_Const.GameTplType.bool)
local petTpl = L_GameTpl:getPetTpl()
local petLevelTpl = L_GameTpl:getPetLevelTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local petStarSoulTpl = L_GameTpl:getPetStarSoulTpl()
local lastSelectedPetId = 0
local confirmTipTitle = L_WordsTpl:getValue("ui_pet_release_confirm_title")
local confirmTipSubContent = L_WordsTpl:getValue("ui_kibo_release_tips")

function this:ctor()
  self.isReleaseMode = false
  self.selectGuids = {}
end

function this:setIsReleaseMode(isOn, isKeep, defaultSelect)
  self.isReleaseMode = isOn
  if not isKeep then
    L_PetStore:resetSelectGuids()
    if defaultSelect and 0 < defaultSelect then
      L_PetStore:setCurSelectPetId(defaultSelect)
    end
  end
  L_PetStore:call(L_PetStore.event.setPetReleaseMode)
end

function this:getIsReleaseMode()
  return self.isReleaseMode
end

function this:getLastSelectedPetId()
  return lastSelectedPetId
end

function this:resetLastSelected()
  lastSelectedPetId = 0
end

function this:getSelectedIdWhenExit(curIndex)
  if 0 < lastSelectedPetId then
    return lastSelectedPetId
  end
  return L_PetStore:getPetBoxFirstPet(curIndex)
end

function this:dealQuickSelect(guids)
  local res = {}
  for k, guid in ipairs(guids) do
    local pet = L_PetStore:getPetItem(guid)
    if pet.is_lock ~= true and self:checkPetStatus(guid) then
      table.insert(res, guid)
    end
  end
  if 0 < #res then
    L_PetStore:setSelectGuids(res)
    return true
  end
  return false
end

function this:checkPetStatus(guid)
  local pet = L_PetStore:getPetItem(guid)
  if not pet then
    errorf("宠物Guid" .. guid .. "不存在PetStore内", 2)
    return false
  end
  local tpl = petTpl:getTplById(pet.id)
  if not tpl then
    errorf("宠物configId" .. pet.id .. "不存在Pet表内", 2)
    return false
  end
  local canNotRelease = pet.canNotRelease
  if canNotRelease == nil then
    canNotRelease = not petTpl:getIsRelease(tpl)
  end
  if canNotRelease or not petTpl:getIsRelease(tpl) then
    return false
  end
  if not math.isEmpty(pet:getHeroId()) then
    return false
  end
  if pet:isInMountRoulette() then
    return false
  end
  if pet.work_status ~= L_Const.PetStationedWorkStatusType.PSWST_NONE then
    return false
  end
  return true
end

function this:dealSelectPet(guid)
  if self:isPetSelected(guid) then
    self:setPetSelectedRelease(guid)
    return
  end
  if not self:checkPetStatusAndTips(guid) then
    return
  end
  local pet = L_PetStore:getPetItem(guid)
  if pet.is_lock == true then
    local contentMain = L_WordsTpl:getValue("ui_pet_release_lock_confirm")
    self:showLockedTip(contentMain, function()
      L_PetStore:req_lockPet(guid, false, function()
        self:dealSelectPet(guid)
      end)
    end)
    return
  end
  if pet:getIsSpecialPet() and pet:hasFlashGene() then
    local contentMain = L_WordsTpl:getValue("ui_pet_release_special_confirm_3")
    self:showLockedTip(contentMain, function()
      self:setPetSelectedRelease(guid)
    end)
    return
  end
  if pet:getIsSpecialPet() then
    local contentMain = L_WordsTpl:getValue("ui_pet_release_special_confirm_1")
    self:showLockedTip(contentMain, function()
      self:setPetSelectedRelease(guid)
    end)
    return
  end
  if pet:hasFlashGene() then
    local contentMain = L_WordsTpl:getValue("ui_pet_release_special_confirm_2")
    self:showLockedTip(contentMain, function()
      self:setPetSelectedRelease(guid)
    end)
    return
  end
  self:setPetSelectedRelease(guid)
end

function this:setPetSelectedRelease(guid)
  if L_PetStore:setSelectReleasePet(guid) then
    lastSelectedPetId = guid
  end
end

function this:checkPetStatusAndTips(guid)
  local pet = L_PetStore:getPetItem(guid)
  if not pet then
    errorf("宠物Guid" .. guid .. "不存在PetStore内", 2)
    return false
  end
  local tpl = petTpl:getTplById(pet.id)
  if not tpl then
    errorf("宠物configId" .. pet.id .. "不存在Pet表内", 2)
    return false
  end
  local canNotRelease = pet.canNotRelease
  if canNotRelease == nil then
    canNotRelease = not petTpl:getIsRelease(tpl)
  end
  if canNotRelease or not petTpl:getIsRelease(tpl) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_block_name"))
    return false
  end
  if not math.isEmpty(pet:getHeroId()) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_block_hero"))
    return false
  end
  if pet:isInMountRoulette() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_block_mount"))
    return false
  end
  if pet.work_status ~= L_Const.PetStationedWorkStatusType.PSWST_NONE then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_block_building"))
    return false
  end
  return true
end

function this:isPetSelected(guid)
  local selectGuids = L_PetStore:getSelectGuids()
  return table.containsValue(selectGuids, guid)
end

function this:calculateReleaseRewards(guids)
  local res = {}
  local extraExpAddNum = 0
  for _, guid in ipairs(guids) do
    local petItem = L_PetStore:getPetItem(guid)
    if petItem then
      if expReturnActive then
        local targetExp = self:calculatePetReleaseExp(petItem)
        local expItems = self:calculateExpItems(targetExp or 0)
        if table.count(expItems) == 0 then
          extraExpAddNum = extraExpAddNum + 1
        end
        self:mergeRewards(res, expItems)
      end
      if rankEvoReturnActive then
        local rankItems = self:calculateRankBreakItems(petItem)
        self:mergeRewards(res, rankItems)
      end
      local starSoulItems = self:calculateReleaseStarSoulForOnePet(guid)
      self:mergeRewards(res, starSoulItems)
    end
  end
  local freeItems = self:calculatePetFreeReward(extraExpAddNum)
  self:mergeRewards(res, freeItems)
  local rewards = {}
  for itemId, itemData in pairs(res) do
    local orderWeight = 0
    if table.containsValue(petExpItems, itemId) then
      orderWeight = 100000000
    elseif itemId ~= petFreeReward[1] then
      orderWeight = 1000000
    end
    if itemData.type == L_Const.resType.commonItem then
      local tpl = commonItemTpl:getTplById(itemId)
      orderWeight = orderWeight + commonItemTpl:getRarity(tpl)
    end
    table.insert(rewards, {
      orderWeight = orderWeight,
      itemId = itemId,
      itemNum = itemData.count,
      itemType = itemData.type
    })
  end
  table.sort(rewards, function(a, b)
    return a.orderWeight > b.orderWeight
  end)
  printf("计算放生奖励结果: ", rewards)
  return rewards
end

function this:mergeRewards(res, items)
  for itemId, itemData in pairs(items) do
    if res[itemId] == nil then
      local data = {}
      data.count = 0
      data.type = itemData.type or L_Const.resType.commonItem
      res[itemId] = data
    end
    res[itemId].count = res[itemId].count + itemData.count
  end
end

function this:calculateReleaseRewardForOnePet(pet, targetExp)
  if not pet then
    return {}
  end
  local res = self:calculateExpItems(targetExp or 0)
  return res
end

function this:calculatePetReleaseExp(pet)
  local currentLevel = pet.lv
  local baseLevel = pet.base_lv
  local totalExp = 0
  local levelTpl
  for i = baseLevel, currentLevel - 1 do
    levelTpl = petLevelTpl:getTplById(i)
    totalExp = totalExp + petLevelTpl:getExp(levelTpl)
  end
  totalExp = totalExp + pet.exp
  return math.floor(totalExp * expReturnRaito)
end

function this:calculateReleaseStarSoulForOnePet(guid)
  local petItem = L_PetStore:getPetItem(guid)
  if not petItem then
    return {}
  end
  local petStage = petItem.stage
  local petNode = petItem.node
  local targetPetTpl = petTpl:getTplById(petItem.petId)
  local templateId = petTpl:getStarsoulId(targetPetTpl)
  local targetStarSoulTpl = petStarSoulTpl:getTplByStageNode(templateId, petStage, petNode)
  if not targetStarSoulTpl then
    return {}
  end
  local itemReturn = L_DataUtil.parseRewardConfig(petStarSoulTpl:getItemReturn(targetStarSoulTpl))
  if not itemReturn or #itemReturn == 0 then
    return {}
  end
  local res = {}
  for _, rewardData in ipairs(itemReturn) do
    if 0 < rewardData.itemNum then
      local itemData = {}
      itemData.count = rewardData.itemNum
      itemData.type = rewardData.itemType
      res[rewardData.itemId] = itemData
    end
  end
  local starSoulItem = petTpl:getStarsoulItem(targetPetTpl)
  local starSoulCount = petStarSoulTpl:getKiboItemReturn(targetStarSoulTpl)
  if 0 < starSoulItem and 0 < starSoulCount then
    local itemData = {}
    itemData.count = starSoulCount
    itemData.type = L_Const.resType.commonItem
    res[starSoulItem] = itemData
  end
  return res
end

function this:calculatePetFreeReward(addNum)
  local curNum = L_PetStore:getPetFreeRewardNum()
  local left = petFreeRewardLimit - curNum
  local num = math.min(left, addNum)
  local res = {}
  if num <= 0 then
    return res
  end
  local itemData = {}
  itemData.type = L_Const.resType.commonItem
  itemData.count = num * petFreeReward[2]
  res[petFreeReward[1]] = itemData
  return res
end

function this:calculateRankBreakItems(pet)
  local items = {}
  if not pet then
    return items
  end
  local rank = pet.rank
  local tpls = {}
  local previous = petRankTpl:getPreviousRankTpl(pet.id)
  while previous ~= nil and 0 < rank do
    table.insert(tpls, previous)
    previous = petRankTpl:getPreviousRankTpl(previous.petId)
    rank = rank - 1
  end
  for _, tpl in ipairs(tpls) do
    local breakItems = petRankTpl:getRankBreakthroughItem(tpl)
    for _, item in ipairs(breakItems) do
      if items[item[2]] == nil then
        local itemData = {}
        itemData.count = 0
        itemData.type = item[1]
        items[item[2]] = itemData
      end
      items[item[2]].count = items[item[2]].count + item[3]
    end
  end
  return items
end

function this:calculateExpItems(targetExp)
  local items = {}
  for _, v in ipairs(petExpItems) do
    local tpl_commonItem = commonItemTpl:getTplById(v)
    local expNum = commonItemTpl:getUseFunction(tpl_commonItem)[1]
    table.insert(items, {
      exp = expNum,
      count = 0,
      itemId = v
    })
  end
  table.sort(items, function(a, b)
    return a.exp > b.exp
  end)
  for i = 1, #items do
    local itemExp = items[i].exp
    while targetExp >= itemExp do
      targetExp = targetExp - itemExp
      items[i].count = items[i].count + 1
    end
  end
  local res = {}
  for _, item in pairs(items) do
    if item.count > 0 then
      local itemData = {}
      itemData.count = item.count
      itemData.type = L_Const.resType.commonItem
      res[item.itemId] = itemData
    end
  end
  return res
end

function this:getFreeEggRewards(guids)
  local curNum = L_PetStore:getFreeEggRewardNum()
  local addNum = #guids
  if curNum + addNum >= petFreeEggRewardLimit then
    return {}
  end
  local res = {
    {
      itemId = petEggFreeReward[1],
      itemType = L_Const.resType.commonItem,
      itemNum = petEggFreeReward[2] * addNum
    }
  }
  return res
end

function this:reqDeletePetEgg(eggList, callback)
  for _, v in pairs(eggList) do
    if L_PetStore:checkIsEggHatch(v) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_egg_release_hatch_block"))
      return
    end
  end
  local data = {egg_list = eggList}
  local rewards = self:getFreeEggRewards(eggList)
  if 0 < #rewards then
    L_GameUtil.showCommonTip({
      txtTitle = L_WordsTpl:getValue("ui_egg_release_confirm_title"),
      txtContent = L_WordsTpl:getValue("ui_egg_release_confirm_content"),
      confirmCallback = function()
        self:dealReleaseEggAction(data, callback)
      end,
      itemList = rewards
    })
  else
    local data_tip = {
      txtTitle = L_WordsTpl:getValue("ui_egg_release_confirm_title"),
      txtContent = L_WordsTpl:getValue("notice_bag_qibodan_fangsheng"),
      confirmCallback = function()
        self:dealReleaseEggAction(data, callback)
      end
    }
    L_GameUtil.showCommonTip(data_tip)
  end
end

function this:dealReleaseEggAction(data, callback)
  L_PetStore:req_removePetEgg(data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if not table.isEmpty(rspData.rewards) then
        L_RewardManager:showPage(rspData.rewards, rspData.src)
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:showLockedTip(contentMain, onConfirm)
  local option = {
    title = confirmTipTitle,
    contentMain = contentMain,
    contentSub = confirmTipSubContent,
    onConfirm = onConfirm
  }
  L_UI:open("PagePetReleaseLocked", option)
end

return this
