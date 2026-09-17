local this = class("rewardManager", G_EventManagerBase)
table.merge(this, require("ui.manager.reward.rewardManagerExtend"))
local _reasonItemnumChangeTpl = L_GameTpl:getReasonItemnumChangeTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()

function this:ctor()
  this.super.ctor(self)
  self.queue = L_Struct.getQueue()
end

function this:dispose()
end

local function useCsRewardManager()
  return C_RewardMgr.IsUseCsImplementation
end

function this:showPage(sData, srcId, pageRewardType)
  if useCsRewardManager() then
    C_RewardMgr.ShowPage(sData, srcId, pageRewardType)
    return
  end
  pageRewardType = pageRewardType or L_Const.pageRewardType.normal
  if pageRewardType == L_Const.pageRewardType.normal then
    self:showNormalReward(sData, srcId)
  elseif pageRewardType == L_Const.pageRewardType.battle then
    self:showBattlePage(sData)
  end
end

function this:showTplReward(rewards, srcId, pageRewardType)
  if useCsRewardManager() then
    C_RewardMgr.showPage(rewards, srcId, pageRewardType)
    return
  end
  local items = L_DataUtil.parseRewardConfig(rewards)
  local sDatas = {}
  for _, item in ipairs(items) do
    table.insert(sDatas, {
      itemtype = item.itemType,
      itemid = item.itemId,
      itemnum = item.itemNum
    })
  end
  self:showPage(sDatas, srcId, pageRewardType)
end

function this:doReward()
  local first = self.queue:getFirst()
  if first == nil then
    self:tryInvokeShowRewardsEndCallback()
    return
  end
  local pageName = first[1]
  local param = first[2]
  local ignoreQueueCheck = param.ignoreQueueCheck
  local forceShow = param.forceShow and param.forceShow or false
  
  function param.closeCallback()
    self:doNextReward()
  end
  
  if pageName == "pageGetPet" then
    L_PetManager:commonGetPet(param, forceShow, nil, ignoreQueueCheck)
  elseif pageName == "pageFlyReward" then
    L_FlyMsgManager:showItemServerRewardsNotSort(param.itemList, nil, param.interactType)
    self:doNextReward()
  elseif pageName == "pageSoulEssenceInfo" then
    L_UI:open(pageName, param)
  elseif pageName == "PageDressUpObtain" then
    AzurWorld.MallMgr:ShowFashionObtainPage(param.itemType, param.itemId)
    self:doNextReward()
  elseif pageName == "pageGetPetEgg" then
    local entity = L_PetStore:getPetEggItem(param.guid)
    if entity then
      L_UI:open("pageGetPetEgg", {
        configId = entity.configId
      })
    else
      L_UI:open("pageGetPetEgg", {
        configId = param.configId
      })
    end
    self:doNextReward()
  else
    L_UI:open(pageName, param, nil, ignoreQueueCheck)
  end
end

function this:doNextReward()
  self.queue:deQueue()
  self:doReward()
end

function this:addQueuePage(name, param, delay)
  param = param or {}
  local list = C_VarList:Get()
  list:AddString(name)
  local cur = self.queue:getFirst()
  self.queue:enQueue({name, param})
  local length = self.queue:getLength()
  if length == 1 then
    if delay then
      L_TimerManager:newOrResetTimer(self, "doReward", function()
        self:resort()
        self:doReward()
      end, 0.2)
    else
      self:doReward()
    end
  end
end

function this:showNormalReward(sData, srcId)
  local list = {}
  local listTitle = {}
  local petEggList = {}
  local petList = {}
  local heroList = {}
  local soulEssenceList = {}
  local tiedDiamondList = {}
  local fashionShareList = {}
  local ignoreQueueCheck = sData.ignoreQueueCheck
  local useStaticBackground = sData.useStaticBackground or false
  local forceShow = sData.forceShow and sData.forceShow or false
  local title = sData.title or nil
  local isFromTaskFinish = false
  srcId = srcId or 0
  local tpl = _reasonItemnumChangeTpl:getTplById(srcId)
  if tpl then
    isFromTaskFinish = _reasonItemnumChangeTpl:getId(tpl) == 88
  end
  for _, v in ipairs(sData) do
    if not math.isEmpty(v.itemtype) then
      local parseData = L_ItemManager:parseItem(v.itemtype, v.itemid)
      local txt_count = ""
      if v.itemtype == L_Const.resType.playerTitle then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.Title, v.itemid)
        table.insert(listTitle, {parseData = parseData})
      elseif v.itemtype == L_Const.resType.petEgg then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.Title, v.itemid)
        table.insert(petEggList, {
          itemId = v.itemid,
          guid = v.guid
        })
      elseif v.itemtype == L_Const.resType.pet then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.PetNew, v.guid)
        local grade, gradeRank = L_PetStore:getPetGradeNew(v.guid)
        table.insert(petList, {
          petId = v.guid,
          grade = grade
        })
      elseif v.itemtype == L_Const.resType.hero and isFromTaskFinish then
        table.insert(heroList, v.itemid)
      elseif v.itemtype == L_Const.resType.soulEssence then
        local soulessenceTpl = _soulessenceTpl:getTplById(v.itemid)
        local rarity = _soulessenceTpl:getRarity(soulessenceTpl)
        table.insert(soulEssenceList, {
          soulEssenceId = v.itemid,
          isPreview = true,
          rarity = rarity
        })
      elseif v.itemtype == L_Const.resType.currency and (v.itemid == L_Const.currencyType.tiedDiamond or v.itemid == L_Const.currencyType.tiedDiamondExtend) then
        table.insert(tiedDiamondList, {
          itemNum = v.itemnum,
          itemType = v.itemtype,
          itemId = v.itemid,
          txt_count = txt_count,
          guid = v.guid
        })
      elseif v.itemtype == L_Const.resType.cloth or v.itemtype == L_Const.resType.petSkin or v.itemtype == L_Const.resType.heroCloth or v.itemtype == L_Const.resType.homeDormItem then
        table.insert(fashionShareList, {
          itemNum = v.itemnum,
          itemType = v.itemtype,
          itemId = v.itemid,
          txt_count = txt_count,
          guid = v.guid
        })
      elseif v.itemnum and 0 < v.itemnum then
        txt_count = tostring(v.itemnum)
        table.insert(list, {
          itemNum = v.itemnum,
          itemType = v.itemtype,
          itemId = v.itemid,
          txt_count = txt_count,
          guid = v.guid
        })
      end
    end
  end
  if 0 < #fashionShareList then
    for i, v in ipairs(fashionShareList) do
      self:addQueuePage("PageDressUpObtain", {
        itemType = v.itemtype,
        itemId = v.itemid
      })
    end
  end
  if 0 < #tiedDiamondList then
    local tiedDiamondNum = 0
    local guid
    for i, v in ipairs(tiedDiamondList) do
      tiedDiamondNum = tiedDiamondNum + v.itemNum
      guid = v.guid
    end
    local txt_count = tostring(tiedDiamondNum)
    table.insert(list, {
      itemNum = tiedDiamondNum,
      itemType = L_Const.resType.currency,
      itemId = L_Const.currencyType.tiedDiamond,
      txt_count = txt_count,
      guid = guid
    })
  end
  if 0 < #soulEssenceList then
    table.sort(soulEssenceList, function(a, b)
      if a.rarity ~= b.rarity then
        return a.rarity > b.rarity
      end
    end)
    for i, v in ipairs(soulEssenceList) do
      self:addQueuePage("pageSoulEssenceInfo", {
        id = v.soulEssenceId,
        isPreview = v.isPreview
      })
    end
  end
  if 0 < #petEggList then
    for i, v in ipairs(petEggList) do
      self:addQueuePage("pageGetPetEgg", {
        configId = v.itemId,
        guid = v.guid
      })
    end
  end
  if 0 < #petList then
    table.sort(petList, function(a, b)
      if a.grade ~= b.grade then
        return a.grade > b.grade
      end
    end)
    for i, v in ipairs(petList) do
      local entity = L_PetStore:getPetItem(v.petId)
      if entity then
        self:addQueuePage("pageGetPet", {pet = entity, forceShow = forceShow})
      end
    end
  end
  if 0 < #list then
    self:addQueuePage("pageReward", {
      itemList = list,
      titleList = listTitle,
      ignoreQueueCheck = ignoreQueueCheck,
      title = title,
      useStaticBackground = useStaticBackground
    })
  end
  if 0 < #listTitle then
    self:addQueuePage("pageRewardTitle", {titleList = listTitle})
  end
  if 0 < #heroList then
    for i, v in ipairs(heroList) do
      self:addQueuePage("pageGetHero", {configId = v})
    end
  end
end

function this:showBattlePage(sData, sType)
  if L_BattleStore:checkRewardShown() then
    return
  end
  local reward = L_BattleStore:getParseBattleReward(sType)
  local data = {}
  local commonItemReward = reward[L_Const.resType.commonItem] or {}
  for i, v in pairs(commonItemReward) do
    table.insert(data, v)
  end
  local currencyReward = reward[L_Const.resType.currency] or {}
  local gold = currencyReward[L_Const.currencyType.gold]
  if not table.isEmpty(gold) then
    table.insert(data, gold)
  end
  if table.isEmpty(data) then
    return
  end
  L_BattleStore:setBattleRewardShowMark()
  L_FlyMsgManager:showItemServerRewards(data)
end

function this:getPetRewardAfterBattle()
  local itemInfo = L_BattleStore:getParseBattleReward()
  for i, v in pairs(itemInfo) do
    if i == L_Const.resType.petEgg then
      for _, k in pairs(v) do
        local entity = L_PetStore:getPetEggItem(k.guid)
        if entity then
          L_UI:open("pageGetPetEgg", {
            configId = entity.configId
          })
        end
      end
    elseif i == L_Const.resType.pet then
      for _, k in pairs(v) do
        local entity = L_PetStore:getPetItem(k.guid)
        if entity then
          local options = {pet = entity}
          L_PetManager:commonGetPet(options)
        end
      end
    end
  end
end

function this:exp2BookItemNumMap(num)
  local bookTable = {}
  local book_big = math.modf(num / 5000)
  local book_middle = math.modf((num - book_big * 5000) / 500)
  local book_small = math.modf((num - book_big * 5000 - book_middle * 500) / 50)
  bookTable[400000] = book_small
  bookTable[400001] = book_middle
  bookTable[400002] = book_big
  return bookTable
end

function this:resort()
  local free = {}
  local fly = {}
  local others = {}
  local list = self.queue.list
  local recordI
  for i = 1, self.queue:getLength() do
    if list[i][1] == "pageFreeReward" then
      table.insert(free, list[i])
    elseif list[i][1] == "pageFlyReward" then
      table.insert(fly, list[i])
    else
      recordI = i
      break
    end
  end
  if recordI ~= nil then
    for i = recordI, self.queue:getLength() do
      table.insert(others, list[i])
    end
  end
  self.queue:clean()
  for i = 1, #free do
    self.queue:enQueue(free[i])
  end
  for i = 1, #fly do
    self.queue:enQueue(fly[i])
  end
  for i = 1, #others do
    self.queue:enQueue(others[i])
  end
end

function this:tryInvokeShowRewardsEndCallback()
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.ShowRewardsEnd)
end

return this
