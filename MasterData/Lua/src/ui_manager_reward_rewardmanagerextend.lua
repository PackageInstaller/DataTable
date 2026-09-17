local this = {}
local _itemRewardFormTpl = L_GameTpl:getItemRewardFormTpl()
local _reasonItemnumChangeTpl = L_GameTpl:getReasonItemnumChangeTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()

local function useCsRewardManager()
  return C_RewardMgr.IsUseCsImplementation
end

function this:ShowReward(rewards, isOne, interactType, src, needCombine)
  if useCsRewardManager() then
    C_RewardMgr.ShowReward(rewards, isOne or false, interactType, src or 0, needCombine or false)
    return
  end
  if rewards == nil or rewards.rewards == nil then
    return
  end
  local count = 0
  if rewards.rewards.Count ~= nil then
    count = rewards.rewards.Count
  else
    count = #rewards.rewards
  end
  if count == 0 then
    return
  end
  local ignoreQueueCheck = rewards.ignoreQueueCheck
  local title = rewards.title or nil
  local forceShow = rewards.forceShow and rewards.forceShow or false
  local cacheList = {}
  local rwds = self:PreProcessRewards(rewards)
  self:FilterRewards(rwds)
  self:MergeRewards(rwds)
  self:filterSpecialSrc(rewards, rwds, cacheList, interactType, src)
  local listfull = cacheList.listfull
  local listhalf = cacheList.listhalf
  local listfly = cacheList.listfly
  local listleftMiddle = cacheList.listleftMiddle
  local listTitle = cacheList.listTitle
  local petEggList = cacheList.petEggList
  local petList = cacheList.petList
  local heroList = cacheList.heroList
  local soulEssenceList = cacheList.soulEssenceList
  local interactHandledData = cacheList.interactType
  local fashionList = cacheList.fashionList
  if soulEssenceList and 0 < #soulEssenceList then
    table.sort(soulEssenceList, this.soulEssenceComparer)
    for i, v in ipairs(soulEssenceList) do
      if _soulessenceTpl:isValid(v.soulEssenceId) == false then
        self:addQueuePage("pageSoulEssenceInfo", {
          id = v.soulEssenceId,
          isPreview = v.isPreview
        })
      end
    end
  end
  if petEggList and 0 < #petEggList then
    for i, v in ipairs(petEggList) do
      self:addQueuePage("pageGetPetEgg", {
        configId = v.itemId,
        guid = v.guid
      })
    end
  end
  if petList and 0 < #petList then
    table.sort(petList, this.petComparer)
    for i, v in ipairs(petList) do
      local entity = L_PetStore:getPetItem(v.petId)
      if entity then
        self:addQueuePage("pageGetPet", {
          pet = entity,
          forceShow = forceShow,
          ignoreQueueCheck = ignoreQueueCheck
        })
      end
    end
  end
  if listfull and 0 < #listfull and (interactHandledData == nil or interactHandledData.sourceFromType ~= 1) then
    self:addQueuePage("pageReward", {
      itemList = listfull,
      ignoreQueueCheck = ignoreQueueCheck,
      title = title
    })
  end
  if listTitle and 0 < #listTitle then
    self:addQueuePage("pageRewardTitle", {titleList = listTitle})
  end
  if heroList and 0 < #heroList then
    for i, v in ipairs(heroList) do
      self:addQueuePage("pageGetHero", {configId = v})
    end
  end
  if listhalf and 0 < #listhalf then
    self:addQueuePage("pageFreeReward", {
      itemList = listhalf,
      ignoreQueueCheck = ignoreQueueCheck,
      title = title
    })
  end
  if listleftMiddle and 0 < #listleftMiddle then
    local sortedRewards = L_DataUtil.parseRewardConfig(listleftMiddle, true, true, nil, true, needCombine)
    for _, commonItem in ipairs(sortedRewards) do
      AzurWorld.FlymsgManager:Enqueue("pageLeftMiddleReward", commonItem)
    end
  end
  if listfly and 0 < #listfly then
    local sortedRewards = L_DataUtil.parseRewardConfig(listfly, true, true, nil, true, needCombine)
    if ignoreQueueCheck then
      L_FlyMsgManager:showItemServerRewardsNotSort(sortedRewards, ignoreQueueCheck, interactHandledData)
    else
      self:addQueuePage("pageFlyReward", {itemList = sortedRewards, interactType = interactHandledData}, isOne)
    end
  end
  if fashionList and 0 < #fashionList then
    for i, v in ipairs(fashionList) do
      self:addQueuePage("PageDressUpObtain", {
        itemType = v.itemType,
        itemId = v.itemId
      })
    end
  end
end

function this.baseRewardComparer(a, b)
  if a.quality ~= b.quality then
    return a.quality > b.quality
  else
    return a.itemId < b.itemId
  end
end

function this.petComparer(a, b)
  if a.grade ~= b.grade then
    return a.grade > b.grade
  end
end

function this.soulEssenceComparer(a, b)
  if a.rarity ~= b.rarity then
    return a.rarity > b.rarity
  end
  if a.itemId ~= b.itemId then
    return a.itemId < b.itemId
  end
  return a.index < b.index
end

local function insertCache(cache, key, data)
  local t = cache[key]
  if not t then
    cache[key] = {data}
  else
    t[#t + 1] = data
  end
end

function this:PreProcessRewards(rewards)
  local rwds
  if type(rewards.rewards) == "table" then
    rwds = rewards.rewards
  else
    rwds = {}
    for i = 0, rewards.rewards.Count - 1 do
      table.insert(rwds, rewards.rewards[i])
    end
  end
  return rwds
end

function this:FilterRewards(rwds)
  for i = #rwds, 1, -1 do
    if rwds[i].itemtype == L_Const.resType.currency and rwds[i].itemid == L_Const.currencyType.homeLevelExp then
      table.remove(rwds, i)
    end
  end
end

function this:MergeRewards(rwds)
  local tiedDiamondList = {}
  local freeTiedDiamondList = {}
  for i = #rwds, 1, -1 do
    if rwds[i].itemtype == L_Const.resType.currency and rwds[i].itemid == L_Const.currencyType.tiedDiamond then
      table.insert(tiedDiamondList, rwds[i])
      table.remove(rwds, i)
    elseif rwds[i].itemtype == L_Const.resType.currency and rwds[i].itemid == L_Const.currencyType.tiedDiamondExtend then
      table.insert(freeTiedDiamondList, rwds[i])
      table.remove(rwds, i)
    elseif rwds[i].itemtype == L_Const.resType.currency and rwds[i].itemid == L_Const.currencyType.homeLevelExp then
      table.remove(rwds, i)
    end
  end
  if 0 < #tiedDiamondList then
    for i = 1, #freeTiedDiamondList do
      local index = i
      if i > #tiedDiamondList then
        index = #tiedDiamondList
      end
      tiedDiamondList[index].itemnum = tiedDiamondList[index].itemnum + freeTiedDiamondList[i].itemnum
    end
    for i = 1, #tiedDiamondList do
      table.insert(rwds, tiedDiamondList[i])
    end
  elseif 0 < #freeTiedDiamondList then
    for i = 1, #freeTiedDiamondList do
      table.insert(rwds, freeTiedDiamondList[i])
    end
  end
end

function this:filterSpecialSrc(rewards, rwds, cacheList, interactType, src)
  local srcId = 0
  if rewards.src then
    srcId = rewards.src
  else
    srcId = src
  end
  local isFromTaskFinish = false
  local tpl = _reasonItemnumChangeTpl:getTplById(srcId)
  if tpl then
    isFromTaskFinish = _reasonItemnumChangeTpl:getId(tpl) == 88
  end
  local soulEssenceIdSet = {}
  for i, v in ipairs(rwds) do
    local item = v
    local index = i
    if not math.isEmpty(v.itemtype) then
      local parseData = L_ItemManager:parseItem(v.itemtype, v.itemid)
      local txt_count = ""
      if v.itemtype == L_Const.resType.playerTitle then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.Title, v.itemid)
        insertCache(cacheList, "listTitle", {parseData = parseData})
      elseif v.itemtype == L_Const.resType.petEgg then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.Title, v.itemid)
        insertCache(cacheList, "petEggList", {
          itemId = v.itemid,
          guid = v.guid
        })
      elseif v.itemtype == L_Const.resType.pet then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.PetNew, v.guid)
        local grade, gradeRank = L_PetStore:getPetGradeNew(v.guid)
        insertCache(cacheList, "petList", {
          petId = v.guid,
          grade = grade
        })
      elseif v.itemtype == L_Const.resType.hero and isFromTaskFinish then
        insertCache(cacheList, "heroList", v.itemid)
      elseif v.itemtype == L_Const.resType.soulEssence then
        local needDetail = v.exts and v.exts[1] == 1
        if needDetail and soulEssenceIdSet[v.itemid] == nil then
          local serverData = C_SoulEssenceMgr:getsoulessenceItem(v.guid)
          local soulEssenceId = serverData.soulEssenceId
          local soulessenceTpl = _soulessenceTpl:getTplById(v.itemid)
          local rarity = _soulessenceTpl:getRarity(soulessenceTpl)
          insertCache(cacheList, "soulEssenceList", {
            index = index,
            itemId = v.itemid,
            soulEssenceId = soulEssenceId,
            isPreview = true,
            rarity = rarity
          })
          soulEssenceIdSet[v.itemid] = true
        end
        self:setShowListByTpl(item, srcId, cacheList)
      elseif v.itemtype == L_Const.resType.cloth or v.itemtype == L_Const.resType.petSkin or v.itemtype == L_Const.resType.heroCloth or v.itemtype == L_Const.resType.homeDormItem then
        insertCache(cacheList, "fashionList", {
          itemType = v.itemtype,
          itemId = v.itemid
        })
      else
        local bShow = true
        local limitFlag = false
        if L_PlayerStore:isElementCurrency(item.itemid) then
          if L_PlayerStore:getShowElementCurrencyLimitFlag(item.itemid) == false then
            if L_PlayerStore:getCurrencyNum(item.itemid) >= L_PlayerStore:getElementCurrencyMaxNum(item.itemid) then
              limitFlag = true
              L_PlayerStore:setShowElementCurrencyLimitFlag(item.itemid, true)
            end
          else
            bShow = false
          end
        end
        if bShow == false then
          break
        end
        if interactType == nil then
          interactType = {}
          interactType.sourcetype = 0
          interactType.sourceToolType = 0
        end
        interactType.limitFlag = limitFlag
        local showType = L_Const.rewardShowType.full
        if rewards.rewardShowType then
          showType = rewards.rewardShowType
        else
          local srcForm = this:getShowTypeByTpl(item, srcId)
          showType = srcForm ~= nil and srcForm or L_Const.rewardShowType.full
        end
        local totalNum = self:getItemTotalNum(v)
        if 0 < totalNum then
          txt_count = tostring(totalNum)
          if showType == L_Const.rewardShowType.fly then
            insertCache(cacheList, "listfly", {
              itemtype = v.itemtype,
              itemid = v.itemid,
              txt_count = txt_count,
              guid = v.guid,
              itemnum = totalNum,
              sort_arg1 = v.sort_arg1,
              sort_arg2 = v.sort_arg2
            })
          elseif showType == L_Const.rewardShowType.half then
            insertCache(cacheList, "listhalf", {
              itemType = v.itemtype,
              itemId = v.itemid,
              txt_count = txt_count,
              guid = v.guid
            })
          elseif showType == L_Const.rewardShowType.full then
            insertCache(cacheList, "listfull", {
              itemType = v.itemtype,
              itemId = v.itemid,
              txt_count = txt_count,
              guid = v.guid
            })
          elseif showType == L_Const.rewardShowType.leftMiddle then
            insertCache(cacheList, "listleftMiddle", v)
          end
          cacheList.interactType = interactType
        end
      end
    end
  end
end

function this:getItemTotalNum(itemData)
  local totalNum = itemData.itemnum or 0
  totalNum = totalNum + (itemData.more_itemnum or 0)
  return totalNum
end

function this:getShowTypeByTpl(item, srcId)
  local subType
  if item.itemtype == L_Const.resType.commonItem then
    local itemTpl = _commonItemTpl:getTplById(item.itemid)
    if itemTpl then
      subType = itemTpl.type
    end
  elseif item.itemtype == L_Const.resType.currency then
    subType = item.itemid
  end
  local srcForm = _reasonItemnumChangeTpl:getFormType(srcId, item.itemtype, subType)
  if not srcForm then
    local itemForm = _itemRewardFormTpl:getFormType(item.itemtype, subType)
    srcForm = itemForm
  end
  return srcForm
end

function this:setShowListByTpl(item, srcId, cacheList)
  local srcForm = this:getShowTypeByTpl(item, srcId)
  local showType = srcForm ~= nil and srcForm or L_Const.rewardShowType.full
  local totalNum = self:getItemTotalNum(item)
  if 0 < totalNum then
    local txt_count = tostring(totalNum)
    if showType == L_Const.rewardShowType.fly then
      insertCache(cacheList, "listfly", {
        itemtype = item.itemtype,
        itemid = item.itemid,
        txt_count = txt_count,
        guid = item.guid,
        itemnum = totalNum
      })
    elseif showType == L_Const.rewardShowType.half then
      insertCache(cacheList, "listhalf", {
        itemType = item.itemtype,
        itemId = item.itemid,
        txt_count = txt_count,
        guid = item.guid
      })
    elseif showType == L_Const.rewardShowType.full then
      insertCache(cacheList, "listfull", {
        itemType = item.itemtype,
        itemId = item.itemid,
        txt_count = txt_count,
        guid = item.guid
      })
    end
  end
end

function this:showFullPageReward(rewardsList, closeCallback, title)
  local list = {}
  for i = 0, rewardsList.Count - 1 do
    local rwd = rewardsList[i]
    local num = self:getItemTotalNum(rwd)
    if num == 0 and rwd.itemNum then
      num = rwd.itemNum
    end
    if num and 0 < num then
      local txt_count = tostring(num)
      table.insert(list, {
        itemNum = rwd.itemnum,
        itemType = rwd.itemtype or rwd.itemType,
        itemId = rwd.itemid or rwd.itemId,
        txt_count = txt_count,
        guid = rwd.guid
      })
    end
  end
  local param = {
    itemList = list,
    title = title,
    closeCallback = closeCallback
  }
  L_UI:open("pageReward", param)
end

return this
