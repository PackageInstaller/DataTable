local this = {}
local _petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local _homeCollectionWorkLimitTpl = L_GameTpl:getHomeCollectionWorkLimitTpl()
local _commonConditionTpl = L_GameTpl:getCommonConditionTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _homeLaborTrain = L_GameTpl:getHomeLaborTarinTpl()
local _petTalentTpl = L_GameTpl:getPetTalentTpl()

function this:req_hatchPetEgg(bldGuid, eggGuid, callback)
  local data = {build_guid = bldGuid, egg_guid = eggGuid}
  L_Net:sendMessage(MsgGenCode.CSProtoHatchPetEgg, data, function(rspData)
    if not rspData and callback then
      callback()
    end
  end)
end

function this:req_hatchOutPetEgg(bldGuid, egg_guid, callback)
  local productGuid = L_ProductManager:getProductGuidBySpecialGuid(bldGuid, egg_guid)
  local productGuidList = {}
  table.insert(productGuidList, productGuid)
  L_ProductStore:req_CSProtoProductFinishByPGuidList(bldGuid, productGuidList, function(rspData, errorCode)
    if 0 < errorCode then
      L_UI:close("pageExclusive")
      return
    end
    if rspData.reward then
      local reward = rspData.reward.rewards
      for _, commonItem in ipairs(reward) do
        local entity = L_PetStore:getPetItem(commonItem.guid)
        if entity then
          L_PetManager:setPetEntitybuffer(entity)
        else
          errorf("未拿到该宠物信息 guid = " .. tostring(commonItem.guid))
        end
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:onClickHatchOutPetEgg(bldUid, eggUid)
  print("请求领取孵蛋")
  if not L_PetStore:getIsPetBoxHasValidSlot() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pagePetGet_04"))
    return
  end
  L_UI:open("pageExclusive", {
    openCbk = function()
      if C_HomeUtil.IsInHome() then
        L_PetStore:playGetPetAnim(bldUid, eggUid)
      else
        L_PetStore:skipHatchOutEggTimeline(bldUid, eggUid)
      end
    end,
    skipCbk = function()
      L_PetStore:skipHatchOutEggTimeline(bldUid, eggUid)
    end
  })
end

function this:playGetPetAnim(bldGuid, eggUid)
  if self.timeLineObj then
    return
  end
  if self.timeLineObj == nil then
    self.timeLineObj = require("ui.manager.timeline.commonTimelinePrefabHandle").new()
    
    function self.timeLineObj.timelineLoadedHandle()
      local manager = AzurWorld.HomeMgr
      local bldEntity = manager:GetHomeBuild(bldGuid)
      if bldEntity == nil then
        return
      end
      local trans = bldEntity.buildNode
      self.timeLineObj:setParent(trans)
      self.timeLineObj:setWorldRotation(L_PlayerManager:getMainControlEntityRot() + L_Vector3.new(0, 180, 0))
      self.timeLineObj:setLocalPosition(L_Vector3.new(0, 0.45, 0))
      self.timeLineObj:playTimelineAsset()
      C_HomeUtil.FocusBuild(bldGuid)
      manager.HudModule:ShowOrHideAllHomeBuildingHud(false)
    end
    
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
    self.timer = Timer.once(3.5, function()
      self:skipHatchOutEggTimeline(bldGuid, eggUid)
    end, self)
  end
  self.timeLineObj:loadTimelinePrefab("EggHatch/pre_egghatch")
end

function this:skipHatchOutEggTimeline(bldGuid, eggUid)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  L_PetStore:req_hatchOutPetEgg(bldGuid, eggUid, function()
    local entityList = L_PetManager:getPetEntitybuffer()
    for i, v in pairs(entityList) do
      local entity = L_PetStore:getPetItem(v.guid)
      if entity then
        local options = {
          pet = entity,
          bFromPetHatch = true,
          bldUid = bldGuid,
          closeCallback = function()
            L_UI:close("pageExclusive")
          end
        }
        L_PetManager:commonGetPet(options, true)
      end
    end
    L_PetManager:clearPetEntitybuffer()
  end)
  AzurWorld.HomeMgr.HudModule:ShowOrHideAllHomeBuildingHud(true)
end

function this:clearTimeLineObj()
  if self.timeLineObj then
    self.timeLineObj:dispose()
    self.timeLineObj = nil
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
  end
  if C_HomeUtil.IsInHome() then
    C_HomeUtil.FocusBuild(0)
  end
end

function this:req_cancelHatchPetEgg(bldGuid, egg_guid, callback)
  local productGuid = L_ProductManager:getProductGuidBySpecialGuid(bldGuid, egg_guid)
  L_ProductManager:reqCancelProduct(bldGuid, productGuid, function(rspData)
    if callback and not rspData then
      callback()
    end
  end)
end

function this:req_changeLvUpPet(petId, items, callback)
  local data = {pet_id = petId, items = items}
  L_Net:sendMessage(MsgGenCode.CSProtoLvUpPet, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local params = {}
      self:call(self.event.petComprehensionLvUp)
      if callback then
        callback()
      end
      if rspData.rewards then
        local rewards = require("ui.manager.reward.rewardData").new()
        rewards.rewardShowType = L_Const.rewardShowType.full
        local data = L_DataUtil.parseRewardConfig(rspData.rewards, true, true)
        rewards:constructList(data)
        rewards.title = L_WordsTpl:getValue("notice_soulessenceStore")
        L_RewardManager:ShowReward(rewards)
      end
    end
  end)
end

function this:req_changeRankUpPet(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoRankUpPet, data, callback)
end

function this:req_changePetName(name, guid, callback)
  local data = {pet_name = name, guid = guid}
  L_Net:sendMessage(MsgGenCode.CSProtoPetChangeName, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeInvalidNick then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_idcard_4"))
    elseif callback then
      callback("error_name")
    end
  end)
end

function this:req_changePetBoxName(name, index, callback)
  local data = {box_id = index, box_name = name}
  L_Net:sendMessage(MsgGenCode.CSProtoPetBoxRename, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeInvalidNick then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_idcard_4"))
    elseif callback then
      callback("error_name")
    end
  end)
end

function this:req_removePet(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoDelPet, data, function(rspData, errorCode)
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

function this:req_removePetEgg(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoDelEgg, data, callback)
end

function this:req_chooseGeneMutation(uid, bAccept, callback)
  local data = {pet_guid = uid, is_accept = bAccept}
  L_Net:sendMessage(MsgGenCode.CSProtoChoseMutation, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_CSProtoPetBreed(data, callback)
end

function this:req_lockPet(petGuid, operation, callback)
  local data = {guid = petGuid, lock_operate = operation}
  L_Net:sendMessage(MsgGenCode.CSProtoPetLock, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_lockPetEgg(petEggGuid, operation, callback)
end

function this:req_lockPetBox(boxId, operation, callback)
  local data = {box_id = boxId, lock_operate = operation}
  L_Net:sendMessage(MsgGenCode.CSProtoPetBoxLock, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if self.data.lockBoxIds and operation == 0 then
        table.removeWith(self.data.lockBoxIds, function(o)
          return o == boxId
        end)
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:req_getFriendRentPet(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoLendFriendPet, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData)
    end
  end)
end

function this:req_getFriendComplexPetInfo(pid, callback)
  local data = {friend_pid = pid}
  L_Net:sendMessage(MsgGenCode.CSProtoGetComplexInfo, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback and rspData.complex_info ~= nil then
      callback(rspData.complex_info)
    end
  end)
end

function this:req_getRentPetRewards(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoGetRentPetReward, nil, function(rspData, errorCode)
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

function this:req_getRentPetInfo(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoGetRentPetInfo, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData)
    end
  end)
end

function this:req_CSProtoPetStationed(petGuid, type, buildGuid, sourceBuild, isOutHomeHub, callback, replacePetGuidInHomeHub)
  local canReq = self:checkIfCanReqPetStationed(petGuid, type, buildGuid, sourceBuild)
  if not canReq then
    return
  end
  local isStationPet = true
  if type == L_Const.PetStationedWorkStatusType.PSWST_WILD_REST then
    local csWorldCollectBuildData = L_HomeStore:getCsWorldCollectBuildDataByGuid(buildGuid)
    if csWorldCollectBuildData ~= nil and csWorldCollectBuildData.PetGuid == petGuid then
      isStationPet = false
    end
  else
    local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildGuid)
    if csHomeBuildData ~= nil then
      local stationedPetGuidList = csHomeBuildData:GetStationedPetGuidList()
      for i = 0, stationedPetGuidList.Count - 1 do
        local stationedPetGuid = stationedPetGuidList[i]
        if stationedPetGuid == petGuid then
          isStationPet = false
          break
        end
      end
    end
  end
  AzurWorld.HomeMgr.PerformanceModule:SetIsPlayerActivelyChangeSetPass()
  local data = {
    pet_guid = petGuid,
    build_type = type,
    build_guid = buildGuid,
    source_build = sourceBuild or 0,
    out_hub = isOutHomeHub and true or false
  }
  L_Net:sendMessage(MsgGenCode.CSProtoPetStationed, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if isStationPet then
        C_AliveVoiceManager.PlayEntityVoice("Home_DispatchSuccessful", true)
      end
      if callback then
        callback()
      end
      self:call(self.event.refreshBuildingPet)
    end
  end)
end

function this:checkIfCanReqPetStationed(petGuid, petStationedWorkStatusType, buildGuid, sourceBuild)
  if petStationedWorkStatusType == L_Const.PetStationedWorkStatusType.PSWST_WILD_REST or petStationedWorkStatusType == L_Const.PSWST_WILD_WORK then
    local petItem = L_PetStore:getPetItem(petGuid)
    local csPetData = L_PetStore:getCsPetData(petGuid)
    if petItem:isWorking() and petItem:getWorkBuilding() == buildGuid then
      return true
    end
    if csPetData:IsWildWorking() then
      return true
    end
    local curWorkingNum = AzurWorld.HomeMgr:GetCurWorkingNumOfCollectionBuilding()
    local maxWorkingNum = C_DataUtil.GetHomeCollectionWorkingLimit()
    local collectionId = buildGuid
    local csHomeStore = L_HomeStore:getCsHomeStore()
    local isWildBuildWorking = csHomeStore.WorldCollectModule:OnIsWorkingByCollectBuildId(collectionId)
    if isWildBuildWorking then
      return true
    elseif curWorkingNum >= maxWorkingNum then
      local conditionGroupList = _homeCollectionWorkLimitTpl:getAllConditionGroup()
      local hasImproveSpace = false
      local targetConditionGroup
      for _, conditionGroup in pairs(conditionGroupList) do
        if L_ConditionManager:isComplete(conditionGroup) == false then
          hasImproveSpace = true
          targetConditionGroup = conditionGroup
          break
        end
      end
      if hasImproveSpace then
        local conditionDescShowKeyWithConditionParam = L_ConditionManager:getSingleDesc(targetConditionGroup[1])
        local res = string.format(L_WordsTpl:getValue("ui_home_collectionbuilding_nextlimit"), conditionDescShowKeyWithConditionParam)
        L_FlyMsgManager:showNormalMsg(res)
      else
        L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("ui_home_collectionbuilding_reachlimit")))
      end
      return false
    else
      return true
    end
  end
  return true
end

function this:req_CSSetPetBox(petGuid, box_id, callback)
  local data = {guid = petGuid, box_id = box_id}
  L_Net:sendMessage(MsgGenCode.CSProtoSetPetBoxInfo, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_CSExchangePetBoxId(petGuid, targetPetGuid, callback)
  local data = {guid = petGuid, target_guid = targetPetGuid}
  L_Net:sendMessage(MsgGenCode.CSProtoExchangePetBoxId, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_CSProtoOrderPetBoxInfo(boxIndexOrParams, callback)
  local data, refreshBoxIndex
  if type(boxIndexOrParams) == "table" then
    data = {
      box = boxIndexOrParams.box or boxIndexOrParams.boxIndex,
      is_all = boxIndexOrParams.is_all,
      is_seq_order = boxIndexOrParams.is_seq_order,
      order_id = table.clone(boxIndexOrParams.order_id or boxIndexOrParams.orderIdList or {})
    }
    if data.is_all == nil then
      data.is_all = boxIndexOrParams.isAll == true
    end
    if data.is_seq_order == nil then
      if boxIndexOrParams.isSeqOrder == nil then
        data.is_seq_order = true
      else
        data.is_seq_order = boxIndexOrParams.isSeqOrder == true
      end
    end
    refreshBoxIndex = data.box
  else
    refreshBoxIndex = boxIndexOrParams
    data = {box = boxIndexOrParams}
  end
  L_Net:sendMessage(MsgGenCode.CSProtoOrderPetBoxInfo, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
      if not math.isEmpty(refreshBoxIndex) then
        self:call(self.event.refreshSinglePetBox, refreshBoxIndex)
      end
    end
  end)
end

function this:req_CSProtoPetEatAttrFruit(preUseFruitInfoList, petGuid, callback)
  local items = {}
  for _, preUseFruitInfo in pairs(preUseFruitInfoList) do
    local item = {
      item_id = preUseFruitInfo.itemId,
      item_num = preUseFruitInfo.itemNum
    }
    table.insert(items, item)
  end
  local data = {pet_id = petGuid, items = items}
  L_Net:sendMessage(MsgGenCode.CSProtoLvUpComprehension, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local params = {}
      params.attrId = 1
      self:call(self.event.petComprehensionLvUp, params)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_CSProtoUseMutationTimes(petGuid, callback)
  local data = {pet_guid = petGuid}
  L_Net:sendMessage(MsgGenCode.CSProtoUseMutationTimes, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData)
    end
  end)
end

function this:req_StarSoulUpgrade(petGuid, isSkillUp, callback)
  local data = {u64 = petGuid}
  L_Net:sendMessage(MsgGenCode.CSProtoKiboStarLinkSoulUpdate, data, function(rspData, errorCode)
    self:call(self.event.refreshStarSoul, petGuid, errorCode == L_Const.errorCode.ErrCodeSucc)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if isSkillUp then
        L_UI:open("pagePetUpgradeSucess", {petGuid = petGuid})
      end
      if callback then
        callback(rspData)
      end
    end
  end)
end

function this:rsp_syncPetEggItem(info)
  if info.eggs and not table.isEmpty(info.eggs) then
    for i = 1, #info.eggs do
      local entity = self:getPetEggItem(info.eggs[i].guid, true)
      entity:populate(info.eggs[i])
    end
  end
  if not table.isEmpty(info.guid) then
    self:removePetEgg(info.guid)
  end
end

function this:rsp_syncPetFreeRewardNum(freeRewardNum)
  self.data.freeRewardNum = freeRewardNum
end

function this:rsp_syncPetLastFreeTime(lastFreeTime)
  self.data.lastFreeTime = lastFreeTime
end

function this:rsp_syncPetBoxInfo(info)
  if table.isEmpty(info) then
    return
  end
  local boxInfos = info.box_infos or info.infos or info
  if boxInfos.id ~= nil then
    boxInfos = {boxInfos}
  end
  if table.isEmpty(boxInfos) then
    return
  end
  local refreshBox = {}
  for _, boxInfo in ipairs(boxInfos) do
    local boxId = boxInfo.id
    if not math.isEmpty(boxId) then
      local rawBoxName = boxInfo.box_name or ""
      self:setPetBoxCustomName(boxId, rawBoxName)
      local boxName = self:getPetBoxDisplayName(boxId, rawBoxName)
      self:setPetBoxName(boxId, boxName)
      refreshBox[boxId] = boxId
    end
  end
  if not table.isEmpty(refreshBox) then
    self:call(self.event.refreshPetBox, refreshBox)
  end
end

function this:rsp_syncPet(info)
  self.petLaborGradeList = {}
  self:syncPetItem(info.pets, info.add_guid)
  if self.petLaborGradeList ~= nil and #self.petLaborGradeList > 0 then
    self:sortPetLaborGradeList(self.petLaborGradeList)
    for i, v in ipairs(self.petLaborGradeList) do
      AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petLaborGrade, v)
    end
  end
  if not table.isEmpty(info.guid) then
    self:removePet(info.guid)
  end
  self:call(self.event.refreshPetDatas)
end

function this:sortPetLaborGradeList(list)
  table.sort(list, function(a, b)
    if a.laborId ~= b.laborId then
      return a.laborId < b.laborId
    end
    if a.petId ~= b.petId then
      return a.petId < b.petId
    end
    if a.curLaborGrade ~= b.curLaborGrade then
      return a.curLaborGrade > b.curLaborGrade
    end
    return a.guid < b.guid
  end)
  return list
end

function this:syncPetItem(data, addGuid)
  local genMutationInfo = {}
  local satietyChangeList
  if data and not table.isEmpty(data) then
    local isShowGetPet = self._isGm
    local isPTShopOpen = L_UI:checkPageOpen("PagePTShop")
    local petInfoTpl = L_GameTpl:getPetTpl()
    local refreshBox = {}
    for i = 1, #data do
      local pet_tpl = petInfoTpl:getTplById(data[i].config_id)
      if not pet_tpl then
        errorf("没有该宠物的配置" .. data[i].config_id)
        printf("协议", data[i])
      else
        local hadPetData = self:getPetItem(data[i].guid)
        if self.data.setHasInitSync and not hadPetData then
          L_ReddotManager:markNew(L_ReddotManager.DotDef.PetNew, data[i].guid)
        end
        local entity = self:getPetItem(data[i].guid, true)
        if (isShowGetPet or isPTShopOpen and table.containsValue(addGuid or {}, data[i].guid)) and entity then
          local options = {pet = entity}
          L_PetManager:commonGetPet(options)
        end
        local lastSatiety = hadPetData and entity.satiety_val or -1
        if data[i].gene_infos == nil then
          data[i].gene_infos = {}
        end
        if data[i].pet_name == "" or data[i].pet_name == nil then
          local pet_name = petInfoTpl:getName(pet_tpl, data[i].color)
          entity.pet_name = pet_name
        else
          entity.pet_name = data[i].pet_name
        end
        local petChanged = false
        local serverPetConfigId = data[i].config_id or 0
        if not math.isEmpty(entity.id) and not math.isEmpty(serverPetConfigId) and entity.id ~= serverPetConfigId then
          petChanged = true
        end
        local needRefreshFormation = false
        local refreshHeroId, refreshPetId
        local oldHeroId = entity.hero_id or 0
        local newHeroId = data[i].hero_id or 0
        local heroChanged = oldHeroId ~= newHeroId
        if not heroChanged and not math.isEmpty(newHeroId) and petChanged then
          needRefreshFormation = true
          refreshHeroId = newHeroId
          refreshPetId = data[i].guid
        end
        local petLvChanged = false
        local oldLv = entity.lv or 0
        local newLv = data[i].lv or 0
        local starColorId = data[i].colorful or 0
        entity.guid = data[i].guid
        entity.id = data[i].config_id
        entity.comprehension = data[i].comprehension or nil
        entity.skillSlotInfo = self:getNewSkillSlotInfo(data[i], entity.skillSlotInfo, addGuid)
        entity.skills = data[i].inherent_skills or {}
        entity.feature = data[i].feature
        entity.lv = data[i].lv
        entity.exp = data[i].exp
        entity.rank = data[i].rank
        entity.hero_id = data[i].hero_id
        entity.petId = data[i].config_id
        entity.catchLevel = data[i].suppress_lv or 0
        entity.enemyType = data[i].original_type or 0
        entity.colorMatId = starColorId
        entity.wear_skin_id = data[i].wear_skin_id or 0
        entity.gene_value = self:getPetGeneValue(data[i].gene_infos, data[i].gene_state)
        entity.is_lock = data[i].is_lock
        entity.tour_state = data[i].tour_state
        entity.race = petInfoTpl:getRace(pet_tpl)
        entity.element = petInfoTpl:getElement(pet_tpl)
        if data[i].soul_link_level then
          entity.stage = math.max(math.floor(data[i].soul_link_level / 4.294967296E9), 1)
          entity.node = math.max(math.floor(data[i].soul_link_level % 4.294967296E9), 1)
        end
        if oldLv < newLv then
          self:call(self.event.petLevelUp, {
            petId = data[i].guid,
            oldLv = oldLv,
            newLv = newLv
          })
          if oldLv ~= 0 then
            L_BattleDataManager:setLevelSettleData(L_Const.roleType.pet, data[i].guid, "levelUp")
          end
          petLvChanged = true
        end
        local oldMutationTimes = entity.mutation_times or 0
        local newMutationTimes = data[i].mutation_times or 0
        local hasReplaceMutation = not table.isEmpty(data[i].mutation_info) and 0 < data[i].mutation_info.pos and (table.isEmpty(entity.mutation_info) or 0 >= entity.mutation_info.pos)
        if entity.gene_infos and #entity.gene_infos > 0 then
          if hasReplaceMutation then
            table.insert(genMutationInfo, {
              guid = data[i].guid,
              pos = data[i].mutation_info.pos,
              gene_id = data[i].mutation_info.gene_id,
              isNew = false
            })
          end
          if #entity.gene_infos < #data[i].gene_infos then
            for _, geneInfo in pairs(data[i].gene_infos) do
              local bNew = true
              for _, entityGeneInfo in pairs(entity.gene_infos) do
                if geneInfo.pos == entityGeneInfo.pos then
                  bNew = false
                  break
                end
              end
              if bNew then
                local bRecorded = false
                local bMutation = false
                for _, v in ipairs(genMutationInfo) do
                  if v.guid == data[i].guid then
                    bRecorded = true
                    if v.pos == geneInfo.pos then
                      bMutation = true
                    end
                    break
                  end
                end
                if not bMutation then
                  local keyString = L_PetStore:getPetGeneMutationNewSaveKeyByPos(data[i].guid, geneInfo.pos)
                  C_PlayerPrefsUtility.SetInt(keyString, geneInfo.pos + 1)
                end
                if not bRecorded then
                  table.insert(genMutationInfo, {
                    guid = data[i].guid,
                    pos = geneInfo.pos,
                    gene_id = geneInfo.gene_id,
                    isNew = true
                  })
                end
                local keyNewString = L_PetStore:getPetGeneMutationNewSaveKey(data[i].guid)
                C_PlayerPrefsUtility.SetInt(keyNewString, geneInfo.pos)
                L_PetManager:tryShowAddMutationGene(geneInfo.gene_id)
              end
            end
          end
        end
        entity.gene_state = data[i].gene_state
        entity.gene_infos = data[i].gene_infos
        entity.mutation_info = data[i].mutation_info
        if hasReplaceMutation and hadPetData and oldMutationTimes > newMutationTimes then
          L_UI:open("pagePetGeneMutation", {
            petId = data[i].guid
          })
        end
        if hadPetData and oldMutationTimes < newMutationTimes then
          local boxIndexId = data[i].box_id // 100
          local key = string.format("%s_petGeneBoxVisited_%s", L_PlayerStore:getPlayerId(), boxIndexId)
          C_PlayerPrefsUtility.SetInt(key, 0)
          AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petGeneMutation, {
            guid = data[i].guid,
            isNew = false,
            mutationNum = newMutationTimes
          })
        end
        entity.mutation_times = data[i].mutation_times
        local newMutationTimesForReddot = data[i].mutation_times or 0
        local hasMutationInfo = not table.isEmpty(data[i].mutation_info) and 0 < data[i].mutation_info.pos
        if 0 < newMutationTimesForReddot or hasMutationInfo then
          L_ReddotManager:markNew(L_ReddotManager.DotDef.PetGeneMutation, data[i].guid)
        else
          L_ReddotManager:clearNew(L_ReddotManager.DotDef.PetGeneMutation, data[i].guid)
        end
        entity.ur_pos = data[i].ur_pos
        entity.speed = data[i].speed or 0
        entity.work_status = data[i].work_status
        entity.work_build = data[i].work_build
        entity.talent_id = data[i].talent_id or {}
        entity.capacity_id = data[i].capacity_id
        entity.box_id = data[i].box_id
        entity.roulette_pos = data[i].roulette_pos
        entity.satiety_val = data[i].satiety_val or 0
        entity.canteen_id = data[i].canteen_id
        entity.work_pause = data[i].work_pause
        entity.satiety = entity.satiety_val
        entity.work_start_time = data[i].work_start_time
        entity.stationLock = data[i].stationLock
        local curSatiety = entity.satiety_val
        if 0 <= lastSatiety and lastSatiety ~= curSatiety then
          satietyChangeList = satietyChangeList or {}
          table.insert(satietyChangeList, data[i].guid)
        end
        local petFlashChanged = false
        local oldFlashParam = entity.special == L_Const.PetSpecialType.PST_FLASH or entity.special == L_Const.PetSpecialType.PST_FLASH_COLOR or entity.special == L_Const.PetSpecialType.PST_FLASH_COLORFUL
        local newFlashParam = data[i].special == L_Const.PetSpecialType.PST_FLASH or data[i].special == L_Const.PetSpecialType.PST_FLASH_COLOR or data[i].special == L_Const.PetSpecialType.PST_FLASH_COLORFUL
        if oldFlashParam ~= newFlashParam then
          petFlashChanged = true
        end
        entity.special = data[i].special or 0
        entity.catch_item = data[i].catch_item
        entity.grade = data[i].grade
        entity.base_lv = data[i].base_lv
        entity.color = data[i].color
        entity.canNotRelease = data[i].can_not_release
        entity.laborInfoList = {}
        self.laborDic = self.laborDic or {}
        self.laborDic[entity.guid] = self.laborDic[entity.guid] or {}
        if data[i].labor_infos then
          for _, laborInfo_proto in pairs(data[i].labor_infos) do
            local laborInfo = {}
            laborInfo.laborId = laborInfo_proto.labor_id
            laborInfo.laborGrade = laborInfo_proto.labor_grade
            laborInfo.upperLaborGrade = laborInfo_proto.upper_labor_grade
            laborInfo.laborExp = laborInfo_proto.labor_exp
            laborInfo.satiety_val = entity.satiety_val
            table.insert(entity.laborInfoList, laborInfo)
          end
        end
        if entity.laborInfoList ~= nil then
          for k, value in ipairs(entity.laborInfoList) do
            local index = value.laborId
            if self.laborDic[entity.guid][index] ~= nil and (value.laborExp ~= self.laborDic[entity.guid][index].laborExp or self.laborDic[entity.guid][index].laborGrade ~= value.laborGrade) then
              local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(value.laborId)
              local name = _homeLaborTypeTpl:getLaborName(homeLaborTypeTpl)
              if 0 < value.laborGrade - self.laborDic[entity.guid][index].laborGrade then
                local petLaborGrade = {
                  laborInfo = value,
                  petId = entity.petId,
                  guid = entity.guid,
                  laborId = value.laborId,
                  lastExp = self.laborDic[entity.guid][index].laborExp,
                  laborGrade = self.laborDic[entity.guid][index].laborGrade,
                  laborGradeAdd = value.laborGrade - self.laborDic[entity.guid][index].laborGrade,
                  upperLaborGrade = value.upperLaborGrade,
                  curLaborGrade = value.laborGrade
                }
                table.insert(self.petLaborGradeList, petLaborGrade)
              end
            end
            if self.laborDic[entity.guid] then
              if self.laborDic[entity.guid][index] then
                if self.laborDic[entity.guid][index].laborGrade ~= value.laborGrade then
                  self.laborDic[entity.guid][index].laborGrade = value.laborGrade
                end
                if self.laborDic[entity.guid][index].laborExp ~= value.laborExp then
                  self.laborDic[entity.guid][index].laborExp = value.laborExp
                end
                if self.laborDic[entity.guid][index].satiety_val ~= value.satiety_val then
                  self.laborDic[entity.guid][index].satiety_val = value.satiety_val
                end
              else
                self.laborDic[entity.guid][index] = {
                  laborGrade = value.laborGrade,
                  satiety_val = value.satiety_val,
                  laborExp = value.laborExp
                }
              end
            end
          end
        end
        if math.isEmpty(entity.base_lv) then
          entity.base_lv = 1
        end
        local oldFavorLv = entity.favor_lv or 0
        local oldFavorVal = entity.favor_val or 0
        entity.favor_val = data[i].favor_val or 0
        entity.favor_lv = data[i].favor_lv or 0
        local dailyFavorList = data[i].daily_favor_val
        if not table.isEmpty(dailyFavorList) then
          local isFavorLvUp = oldFavorLv < entity.favor_lv
          for _, value in ipairs(dailyFavorList) do
            local dailyFavorInfo = value
            local sourceType = dailyFavorInfo.source_type
            if sourceType == L_Const.FavorSourceType.FST_BATTLE then
              if isFavorLvUp then
                L_BattleDataManager:setLevelSettleData(L_Const.roleType.pet, data[i].guid, "favorLevelUp")
              end
            elseif sourceType == 161 then
              if isFavorLvUp then
                self:call(self.event.refreshPetFavorLvUp, {
                  petGuid = data[i].guid,
                  oldFavorLv = oldFavorLv,
                  newFavorLv = entity.favor_lv
                })
              end
            elseif sourceType == 162 then
              self:call(self.event.refreshPetFruitFavorLvUp, {
                petGuid = data[i].guid,
                oldFavorLv = oldFavorLv,
                newFavorLv = entity.favor_lv,
                isFavorLvUp = isFavorLvUp,
                oldFavorVal = oldFavorVal,
                newFavorVal = entity.favor_val,
                petConfigId = entity.petId,
                dailyFavorCount = data[i].daily_favor_count
              })
            end
          end
        end
        local totalIV = entity.comprehension and self:getPetSixDimPotentialQualification(entity)
        local talentGradeTpl = totalIV and self:getPetTalentGradeTplByTotalIV(totalIV)
        entity.petTalentId = talentGradeTpl and _petTalentTpl:getId(talentGradeTpl) or 0
        refreshBox = self:setInsertBox(data[i].box_id, data[i].guid, refreshBox)
        if needRefreshFormation and AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter then
          AzurWorld.playerMgr.myPlayerUnitAdapter:RecreateFormationEntity(0, refreshPetId)
        end
        self:call(self.event.refreshPet, entity)
        if not math.isEmpty(entity.hero_id) and petLvChanged then
          L_PlayerManager:refreshPetEntityLevel(entity.guid)
        end
        if not math.isEmpty(entity.hero_id) and petFlashChanged then
          L_PlayerManager:refreshPetEntityFlashParam(entity.guid)
        end
      end
    end
    if not table.isEmpty(refreshBox) then
      self:call(self.event.refreshPetBox, refreshBox)
    end
    if not table.isEmpty(satietyChangeList) then
      self:call(self.event.refreshSatiety, satietyChangeList)
    end
  end
end

function this:rsp_syncTrialPetItem(data)
  if table.isEmpty(data) then
    return
  end
  local petInfoTpl = L_GameTpl:getPetTpl()
  local petInterimTpl = L_GameTpl:getPetInterimTpl()
  for i = 1, #data do
    local trialId = C_DataUtil.GetUuid2ConfigId(data[i].guid)
    local tpl_trial = petInterimTpl:getTplById(trialId)
    if not tpl_trial then
      errorf("没有该试用宠物的配置" .. trialId)
    end
    local entity = self:getPetItem(data[i].guid, true)
    local pet_tpl = petInfoTpl:getTplById(data[i].config_id)
    if not pet_tpl then
      errorf("没有该宠物的配置" .. data[i].config_id)
      printf("协议", data[i])
    end
    if data[i].gene_infos == nil then
      data[i].gene_infos = {}
    end
    if data[i].pet_name == "" or data[i].pet_name == nil then
      local pet_name = petInfoTpl:getName(pet_tpl, data[i].color)
      entity.pet_name = pet_name
    else
      entity.pet_name = data[i].pet_name
    end
    entity.guid = data[i].guid
    entity.id = petInterimTpl:getPetId(tpl_trial)
    local param = petInterimTpl:getParam(tpl_trial)
    entity.comprehension = {}
    for _, att in pairs(param) do
      local id, value = table.unpack(att)
      table.insert(entity.comprehension, {attr_id = id, value = value})
    end
    entity.skills = data[i].inherent_skills or {}
    entity.feature = petInterimTpl:getFeature(tpl_trial)
    entity.lv = petInterimTpl:getPetLevel(tpl_trial)
    entity.speed = petInterimTpl:getSpeed(tpl_trial)
    entity.petId = petInterimTpl:getPetId(tpl_trial)
    entity.grade = petInterimTpl:getPetGrade(tpl_trial)
    entity.exp = 0
    entity.rank = 1
    entity.box_id = 0
    entity.roulette_pos = 0
    entity.is_lock = false
    entity.hero_id = data[i].hero_id
    entity.gene_value = self:getPetGeneValue(data[i].gene_infos, data[i].gene_state)
    entity.race = petInfoTpl:getRace(pet_tpl)
    entity.element = petInfoTpl:getElement(pet_tpl)
    entity.gene_state = data[i].gene_state
    entity.gene_infos = data[i].gene_infos
    entity.work_status = data[i].work_status
    entity.work_build = data[i].work_build
    entity.talent_id = data[i].talent_id or {}
    entity.capacity_id = data[i].capacity_id
    entity.satiety_val = data[i].satiety_val or 0
    entity.canteen_id = data[i].canteen_id
    entity.work_pause = data[i].work_pause
    entity.satiety = entity.satiety_val
    entity.work_start_time = data[i].work_start_time
    entity.special = data[i].special or 0
    entity.catch_item = data[i].catch_item
    entity.base_lv = data[i].base_lv
    entity.color = data[i].color
    if data[i].soul_link_level then
      entity.stage = math.floor(data[i].soul_link_level / 4.294967296E9)
      entity.node = math.floor(data[i].soul_link_level % 4.294967296E9)
    end
    if math.isEmpty(entity.base_lv) then
      entity.base_lv = 1
    end
    entity.favor_val = data[i].favor_val or 0
    entity.favor_lv = data[i].favor_lv or 0
  end
end

function this:setFreeEggRewardNum(num)
  if num ~= nil then
    self.data.free_egg_reward_num = num
  end
end

function this:getFreeEggRewardNum()
  return self.data.free_egg_reward_num
end

function this:rsp_syncLockBoxId(boxIds)
  self.data.lockBoxIds = boxIds
  self:call(self.event.refreshBoxLock)
end

return this
