local this = class("petManager", G_EventManagerBase)
table.merge(this, require("ui.manager.pet.petManager_scene"))
table.merge(this, require("ui.manager.pet.petManager_petGet"))
local _petTpl = L_GameTpl:getPetTpl()
local _petCustomizedTpl = L_GameTpl:getPetCustomizedTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _petDna = L_GameTpl:getDnaTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
this.gmForceGetPetNew = false
this.event = {
  petBoxHaveCanMutationPetGuide = "petBoxHaveCanMutationPetGuide"
}

function this:ctor()
  this.super.ctor(self)
  self.petEntityBuffer = {}
  self.petBgColor = {
    [1] = {
      [1] = "#D5D5D5",
      [2] = "#8F8F8F",
      [3] = "#595959"
    },
    [2] = {
      [1] = "#D5D5D5",
      [2] = "#8F8F8F",
      [3] = "#595959"
    },
    [3] = {
      [1] = "#ACC0B4",
      [2] = "#8CAC95",
      [3] = "#1c795e"
    },
    [4] = {
      [1] = "#ACC0B4",
      [2] = "#8CAC95",
      [3] = "#1c795e"
    },
    [5] = {
      [1] = "#758097",
      [2] = "#6174B4",
      [3] = "#234edb"
    },
    [6] = {
      [1] = "#758097",
      [2] = "#6174B4",
      [3] = "#234edb"
    },
    [7] = {
      [1] = "#B37EB9",
      [2] = "#A272B3",
      [3] = "#935fd9"
    },
    [8] = {
      [1] = "#F0DC6D",
      [2] = "#B19749",
      [3] = "#b87500"
    }
  }
end

function this:petHintInfo(num)
  local switch = {
    [1] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_lackGold"))
      return
    end,
    [2] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_lackLevel"))
      return
    end,
    [3] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_lackItem"))
      return
    end,
    [4] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_rankMax"))
      return
    end,
    [5] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_levelMax"))
      return
    end,
    [6] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_chooseLevelItem"))
      return
    end,
    [7] = function()
      L_FlyMsgManager:showNormalMsg("notice_petManager")
      return
    end
  }
  local f = switch[num]
  if f then
    return f()
  else
  end
end

function this:initialize()
  self:addEventListener()
end

function this:addEventListener()
  function self.onHomeBuildSync()
    L_PetStore:resetCachedData()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSync)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetDatas, self.onRefreshPetDatas, self)
  L_TechnologyStore:listenCallFunc(L_TechnologyStore.event.refresh, self.onRefreshTechnology, self)
end

function this:dispose()
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSync)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetDatas, self.onRefreshPetDatas, self)
  L_TechnologyStore:unListenCallFunc(L_TechnologyStore.event.refresh, self.onRefreshTechnology, self)
end

function this:onRefreshPetDatas()
  L_PetStore:resetCachedData()
end

function this:onRefreshTechnology()
  L_PetStore:resetCachedData()
end

function this:getPetBgColor()
  return self.petBgColor
end

function this:checkTimelineControl()
  return self.timelineControl ~= nil
end

function this:getTimelineControl()
  if self.timelineControl == nil then
    self.timelineControl = require("ui.manager.pet.timeline.petHouseTimelineControl").new()
  end
  return self.timelineControl
end

function this:disposeTimelineControl()
  if self.timelineControl then
    self.timelineControl:dispose()
  end
  self.timelineControl = nil
end

function this:lvChange(lv)
  if lv < 10 then
    return string.format("0%d", lv)
  end
  return tostring(lv)
end

function this:autoLvUp(expBookTable, upExp)
  local sortMax = {}
  for i in pairs(expBookTable) do
    table.insert(sortMax, i)
  end
  table.sort(sortMax, function(a, b)
    return b < a
  end)
  local exp = upExp
  local tempData = {}
  for i = 1, #sortMax do
    tempData[sortMax[i]] = 0
    if exp >= sortMax[i] then
      local num = math.min(math.modf(exp / sortMax[i]), expBookTable[sortMax[i]])
      tempData[sortMax[i]] = num
      exp = exp - num * sortMax[i]
    end
  end
  if 0 < exp then
    for i = #sortMax, 1, -1 do
      local v = sortMax[i]
      if exp <= sortMax[i] and expBookTable[v] > tempData[v] then
        tempData[v] = tempData[v] + 1
        break
      end
    end
  end
  return tempData
end

function this:setPetEntitybuffer(entity)
  table.insert(self.petEntityBuffer, entity)
end

function this:clearPetEntitybuffer()
  self.petEntityBuffer = {}
end

function this:getPetEntitybuffer()
  return self.petEntityBuffer
end

function this:getGeneUnlockConditions()
  local conditionMap = L_GameTpl:getGameConstTpl():getData("PET_DNAUNLOCK_NEW", L_Const.GameTplType.list_list_int)
  local conditions = {}
  for k, v in pairs(conditionMap) do
    conditions[v[1]] = v[2]
  end
  return conditions
end

function this:judgeCanScanPet()
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.catchPet) then
    return false
  end
  local playModule = L_WorldManager:getCurModule()
  if playModule == L_Const.worldModule.home then
    return false
  end
  local sceneId = AzurWorldInstance.CurWorldId
  local tpl = _worldCityTpl:getTplById(sceneId)
  local isCatchPetDisable = _worldCityTpl:getIsSystemDisable(tpl, L_SystemConst.enum.catchPet)
  return not isCatchPetDisable
end

function this:judgeCanCatchPet()
  local canCatch = true
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsBattleSimulator then
    return true
  end
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.catchPet) then
    return false
  end
  local playModule = L_WorldManager:getCurModule()
  if playModule == L_Const.worldModule.home then
    return false
  end
  local sceneId = AzurWorldInstance.CurWorldId
  local tpl = _worldCityTpl:getTplById(sceneId)
  local isCatchPetDisable = _worldCityTpl:getIsSystemDisable(tpl, L_SystemConst.enum.catchPet)
  if isCatchPetDisable and not AzurWorld.PetCatchManagerMgr:IsNestCoopPetCatch() then
    return false
  end
  if L_PlayerStore:playerInMountStatus() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_catch_ride"))
    return false
  end
  local data = C_BagMgr:GetAllCapturePetBall()
  local haveItem = false
  for key, value in pairs(data) do
    if value.num > 0 then
      haveItem = true
      break
    end
  end
  if not haveItem then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_noPetcatchitem"))
    return false
  end
  if not CS.Lens.Gameplay.Modules.BigWorld.Macro.IsBattleSimulator then
    local hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    if not hero then
      return false
    end
    local coolDown = C_EntityManager.MainPlayer.data.catchCoolDown
    if 0 < coolDown then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_catchcd"))
      return false
    end
  end
  return canCatch
end

function this:getPetConfigFeatureSkill(petConfigId)
  local randomFeature = {}
  local fixedFeature = {}
  local tpl = _petTpl:getTplById(petConfigId)
  if tpl then
    local randomSkillPool = _petTpl:getRandomSkillList(tpl)
    if not table.isEmpty(randomSkillPool) then
      for i, v in pairs(randomSkillPool) do
        local skill = self:parseSkillInfo(v[2])
        if not table.isEmpty(skill) then
          table.insert(randomFeature, skill)
        end
      end
    end
    local fixedSkillPool = _petTpl:getFeatureSkillList(tpl)
    if not table.isEmpty(fixedSkillPool) then
      for i, v in pairs(fixedSkillPool) do
        local skill = self:parseSkillInfo(v)
        if not table.isEmpty(skill) then
          table.insert(fixedFeature, skill)
        end
      end
    end
  end
  return randomFeature, fixedFeature
end

function this:getFPropertySkillList(petConfigId)
  local kiboFeature = {}
  local tpl = _petTpl:getTplById(petConfigId)
  if tpl then
    local kiboSkill = _petTpl:getFeatureSkillList(tpl)
    if not table.isEmpty(kiboSkill) then
      for i, v in pairs(kiboSkill) do
        local skill = self:parseSkillInfo(v)
        if not table.isEmpty(skill) then
          table.insert(kiboFeature, skill)
        end
      end
    end
  end
  return kiboFeature
end

function this:getCustomizedPropertySkillList(petCustomizedId)
  local kiboFeature = {}
  local tpl = _petCustomizedTpl:getTplById(petCustomizedId)
  if tpl then
    local kiboSkill = _petCustomizedTpl:getSkillCount(tpl)
    if not table.isEmpty(kiboSkill) then
      for i, v in pairs(kiboSkill) do
        local skill = self:parseSkillInfo(v)
        if not table.isEmpty(skill) then
          table.insert(kiboFeature, skill)
        end
      end
    end
  end
  return kiboFeature
end

function this:getPetConfigActiveSkill(petConfigId)
  local tpl = _petTpl:getTplById(petConfigId)
  local commonSkill = {}
  local breakSkill = {}
  local signatureSkill = {}
  if tpl then
    local signatureSkillPool = _petTpl:getSignatureSkillList(tpl)
    if not table.isEmpty(signatureSkillPool) then
      for i, v in pairs(signatureSkillPool) do
        if not math.isEmpty(v[3]) then
          local skill = self:parseSkillInfo(v[2])
          if not table.isEmpty(skill) then
            table.insert(signatureSkill, skill)
          end
        end
      end
    end
    local breakSkillPool = _petTpl:getBreakSkillList(tpl)
    if not table.isEmpty(breakSkillPool) then
      for i, v in pairs(breakSkillPool) do
        local skill = self:parseSkillInfo(v)
        if not table.isEmpty(skill) then
          table.insert(breakSkill, skill)
        end
      end
    end
    local commonSkillPool = _petTpl:getCommonSkillList(tpl)
    if not table.isEmpty(commonSkillPool) then
      for i, v in pairs(commonSkillPool) do
        if not math.isEmpty(v[3]) then
          local skill = self:parseSkillInfo(v[2])
          if not table.isEmpty(skill) then
            table.insert(commonSkill, skill)
          end
        end
      end
    end
  end
  return signatureSkill, breakSkill, commonSkill
end

function this:getCustomizedPetConfigActiveSkill(petCustomizedId)
  local tpl = _petCustomizedTpl:getTplById(petCustomizedId)
  local commonSkill = {}
  local breakSkill = {}
  local signatureSkill = {}
  if tpl then
    local signatureSkillPool = _petCustomizedTpl:getSignatureSkillList(tpl)
    if not table.isEmpty(signatureSkillPool) then
      for i, v in pairs(signatureSkillPool) do
        if not math.isEmpty(v[3]) then
          local skill = self:parseSkillInfo(v[2])
          if not table.isEmpty(skill) then
            table.insert(signatureSkill, skill)
          end
        end
      end
    end
    local breakSkillPool = _petCustomizedTpl:getBreakSkillList(tpl)
    if not table.isEmpty(breakSkillPool) then
      for i, v in pairs(breakSkillPool) do
        local skill = self:parseSkillInfo(v)
        if not table.isEmpty(skill) then
          table.insert(breakSkill, skill)
        end
      end
    end
    local commonSkillPool = _petCustomizedTpl:getSkillList(tpl)
    if not table.isEmpty(commonSkillPool) then
      for i, v in pairs(commonSkillPool) do
        if not math.isEmpty(v[3]) then
          local skill = self:parseSkillInfo(v[2])
          if not table.isEmpty(skill) then
            table.insert(commonSkill, skill)
          end
        end
      end
    end
  end
  return signatureSkill, breakSkill, commonSkill
end

function this:parseSkillInfo(petSkillId)
  local tpl = _skillLevelTpl:getTplByIdAndLevel(petSkillId, 1)
  if tpl ~= nil then
    local skillId = _skillLevelTpl:getSkillGroupId(tpl)
    local nameTpl = _skillTpl:getTplById(tonumber(skillId))
    local skillName = _skillTpl:getName(nameTpl)
    local skillDescribe = _skillLevelTpl:getSkillDescribe(tpl)
    local skillDetailDescribe = _skillLevelTpl:getSkillDetailDescribe(tpl)
    local skillIcon = _skillTpl:getIcon(nameTpl)
    local skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
    local tpl_skillSub = skillSubLogicTpl:getTplById(skillId)
    local skillCd = skillSubLogicTpl:getCoolDown(tpl_skillSub)
    local skillInfo = {
      index = 0,
      skillLv = "Lv.1",
      skillId = petSkillId,
      skillLevelShow = false,
      levelLabel = true,
      skillCd = skillCd,
      itemIcon = skillIcon,
      describe = skillDescribe,
      detailDescribe = skillDetailDescribe,
      skillName = skillName,
      skillElement = _skillTpl:getSkillElement(nameTpl),
      skillPowerName = "",
      skillPower = "",
      name = ""
    }
    return skillInfo
  end
  return nil
end

function this:parseGeneInfo(petGeneId)
  local tpl = _skillLevelTpl:getTplByIdAndLevel(petGeneId, 1)
  if tpl ~= nil then
    local nameTpl = _skillTpl:getTplById(tonumber(_skillLevelTpl:getSkillGroupId(tpl)))
    local dnaTpl = _petDna:getTplById(tonumber(_skillLevelTpl:getSkillGroupId(tpl)))
    local dnaRarity = _petDna:getRarity(dnaTpl)
    local skillName = _skillTpl:getName(nameTpl)
    local skillDescribe = _skillLevelTpl:getSkillDescribe(tpl)
    local skillIcon = _skillTpl:getIcon(nameTpl)
    local geneInfo = {
      geneId = petGeneId,
      skillLv = "Lv." .. 1,
      skillLevelShow = false,
      levelLabel = false,
      itemIcon = skillIcon,
      describe = skillDescribe,
      skillName = skillName,
      starLv = 0,
      rarity = dnaRarity
    }
    return geneInfo
  end
  return nil
end

function this:commonGetPetAsOwned(options)
  local pet = options.pet
  local map = L_CatalogStore:getPetCatalog()
  if map[pet.id] then
    map[pet.id] = map[pet.id] + 1
  end
  L_CatalogStore:_triggerCommonGetPet(pet)
  if options.closeCallback then
    options.closeCallback(true)
  end
  if options.voiceCallBack then
    options.voiceCallBack()
  end
end

function this:completePetRewardWithoutPage(pet, forceShow)
  if pet == nil then
    return
  end
  local map = L_CatalogStore:getPetCatalog()
  if L_UI:checkPageOpen("pageNestCoopPetCatch") then
    L_PetManager.curNestCoopCatchGuid = pet.guid
    forceShow = true
  end
  if L_UI:checkPageOpen("pageSpecialShop") or L_UI:checkPageOpen("PagePTShop") then
    forceShow = true
  end
  if forceShow then
    if map[pet.id] then
      map[pet.id] = map[pet.id] + 1
    end
    return
  end
  if map[pet.id] and map[pet.id] > 1 then
    if map[pet.id] then
      map[pet.id] = map[pet.id] + 1
    end
    L_CatalogStore:_triggerCommonGetPet(pet)
    return
  end
  L_CatalogStore:_triggerCommonGetPet(pet, true)
  if map[pet.id] then
    map[pet.id] = map[pet.id] + 1
  end
end

function this:commonGetPet(options, forceShow, callback, ignoreQueueCheck)
  if options.closeCallback == nil then
    options.closeCallback = options.callback
  end
  local pet = options.pet
  local map = L_CatalogStore:getPetCatalog()
  if L_UI:checkPageOpen("pageNestCoopPetCatch") then
    L_PetManager.curNestCoopCatchGuid = pet.guid
    forceShow = true
  end
  if L_UI:checkPageOpen("pageSpecialShop") or L_UI:checkPageOpen("PagePTShop") then
    forceShow = true
  end
  if forceShow then
    if map[pet.id] and not options.skipPetCatalogCount then
      map[pet.id] = map[pet.id] + 1
    end
    options.showType = L_Const.getPetShowType.long
    self:getTempRenderTexture(function(tempTex)
      options.texture = tempTex
      if options.closeCallback then
        local tmpCallback = options.closeCallback
        
        function options.closeCallback(alreadyGetBefore)
          if not alreadyGetBefore then
            AzurWorld.PetCatchManagerMgr:CloseCatchResultUI()
          end
          tmpCallback()
        end
      end
      L_UI:open("pageGetPet", options, callback, ignoreQueueCheck)
    end)
    return true
  end
  if map[pet.id] and map[pet.id] > 1 then
    self:commonGetPetAsOwned(options)
    return false
  else
    L_CatalogStore:_triggerCommonGetPet(pet, true)
    if map[pet.id] then
      map[pet.id] = map[pet.id] + 1
    end
    options.isNew = true
    options.showType = L_Const.getPetShowType.long
    self:getTempRenderTexture(function(tempTex)
      options.texture = tempTex
      if options.closeCallback then
        local tmpCallback = options.closeCallback
        
        function options.closeCallback(alreadyGetBefore)
          if not alreadyGetBefore then
            AzurWorld.PetCatchManagerMgr:CloseCatchResultUI()
          end
          tmpCallback()
        end
      end
      L_UI:open("pageGetPet", options, callback, ignoreQueueCheck)
    end)
    return true
  end
end

function this:getTempRenderTexture(callback)
  local width = Unity.Screen.width
  local height = Unity.Screen.height
  local tempTex = C_RenderTexture.GetTemporary(width, height)
  C_UniversalRenderPipeline.CaptureFrame(C_CameraManager.uiCamera, tempTex, true, false, function()
    if callback then
      callback(tempTex)
    end
  end)
end

function this:getScanLevelById(id)
  local scanLevel = 0
  for i, v in pairs(L_PetConst.PetCatchLensItemIds) do
    if v == id then
      scanLevel = i
      break
    end
  end
  return scanLevel
end

function this:judgeShowScanPet()
  local scanLevel = 0
  if C_BagMgr:getScanUsingItemId() == 0 then
    return 1
  end
  for i, v in pairs(L_PetConst.PetCatchLensItemIds) do
    if v == C_BagMgr:getScanUsingItemId() then
      scanLevel = i
      break
    end
  end
  local itemId = L_PetConst.PetCatchLensItemIds[scanLevel]
  if itemId ~= nil and C_BagMgr:getItemNumByItemId(itemId) == 0 then
    return 1
  end
  return scanLevel
end

function this:clearAllKiboLimitState(guid, callback)
  local petGuid = guid
  local entity = L_PetStore:getPetItem(petGuid)
  local tasks = {}
  local completedCount = 0
  
  local function onTaskCompleted()
    completedCount = completedCount + 1
    if completedCount >= #tasks and callback then
      callback()
    end
  end
  
  local function executeTask(taskFunc)
    table.insert(tasks, taskFunc)
  end
  
  if entity.is_lock then
    executeTask(function()
      L_PetStore:req_lockPet(petGuid, false, function()
        onTaskCompleted()
      end)
    end)
  end
  if entity.hero_id and entity.hero_id ~= 0 then
    executeTask(function()
      L_HeroManager:reqWearPet(entity.hero_id, nil, function()
        onTaskCompleted()
      end)
    end)
  end
  if entity.roulette_pos and entity.roulette_pos ~= 0 then
    executeTask(function()
      local function removeMountFromRoulette()
        L_MountManager:reqRemoveMountFormRoulettePos(entity.roulette_pos, function()
          onTaskCompleted()
        end)
      end
      
      if petGuid == L_MountStore:getEquipMountId() and AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
        AzurWorld.mountMgr:ReqLeaveMount(true, function()
          removeMountFromRoulette()
        end)
      else
        removeMountFromRoulette()
      end
    end)
  end
  if entity.work_status and entity.work_status ~= 0 or entity.capacity_id and entity.capacity_id ~= 0 then
    executeTask(function()
      if entity.work_status == L_Const.PetStationedWorkStatusType.PSWST_RANCH_WORK and math.isEmpty(entity.work_start_time) then
        local blockId = entity.work_build
        local ranchData = C_HomeManager:GetHomeStore():GetRanchData(blockId)
        local petIndex = ranchData:GetSlotByGuid(petGuid)
        if 0 < petIndex then
          C_HomeManager:GetHomeStore():ReqSetProductPet(blockId, petIndex, petGuid, function(rspData, errorCode)
            onTaskCompleted()
          end)
        end
      else
        local data = {pet_guid = petGuid, type = 1}
        L_Net:sendMessage(MsgGenCode.CSProtoPetStationInHomeHub, data, function(rspData, errorCode)
          onTaskCompleted()
        end)
      end
    end)
  end
  if #tasks == 0 then
    if callback then
      callback()
    end
    return
  end
  for _, task in ipairs(tasks) do
    task()
  end
end

function this:getPetScale(pageName)
end

function this:tryShowAddMutationGene(addId)
  if L_UI:checkPageShown("pagePetBox") then
    L_UI:open("pagePetGeneMutation", {geneId = addId})
  end
end

function this:getCanMutationPetInBox(boxIndex)
  if math.isEmpty(boxIndex) then
    return nil, nil
  end
  local petList = L_PetStore:getPetBoxList(boxIndex) or {}
  if table.isEmpty(petList) then
    return nil, nil
  end
  for slot, guid in ipairs(petList) do
    if not math.isEmpty(guid) then
      local pet = L_PetStore:getPetItem(guid)
      if pet and pet.haveMutationNum and pet:haveMutationNum() then
        return guid, slot
      end
    end
  end
  return nil, nil
end

function this:hasPetBoxCanMutationPet()
  local petBoxList = L_PetStore:getPetBoxList() or {}
  if table.isEmpty(petBoxList) then
    return false
  end
  for boxIndex in ipairs(petBoxList) do
    local guid = self:getCanMutationPetInBox(boxIndex)
    if guid then
      return true
    end
  end
  return false
end

function this:checkPetBoxCanMutationGuide()
  if not self:hasPetBoxCanMutationPet() then
    return
  end
  self:sendEvent(self.event.petBoxHaveCanMutationPetGuide)
end

function this:checkPetInMailReward(configId)
  local allMailInfo = L_MailStore:getAllMailInfo()
  for _, mail in pairs(allMailInfo) do
    local rewards = mail.reward and mail.reward.rewards
    if rewards then
      for _, reward in pairs(rewards) do
        local itemType = reward.itemtype or reward.itemType
        local itemId = reward.itemid or reward.itemId
        if itemType == L_Const.resType.pet and itemId == configId then
          return true
        end
      end
    end
  end
  return false
end

return this
