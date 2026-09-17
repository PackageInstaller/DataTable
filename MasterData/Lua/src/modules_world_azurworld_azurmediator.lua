local AzurMediator = {}
local this = AzurMediator
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldBorthposTpl = L_GameTpl:getWorldBorthposTpl()
local _petEggTpl = L_GameTpl:getPetEggTpl()
local _adapter = CS.Lens.Gameplay.Modules.Azur.WorldAdapter

function this.onExitGame()
  L_BattleDataManager:dispose()
  L_BattleFieldManager:dispose()
  L_MountManager:dispose()
end

function this.setTransferPosId(posId, callback)
  local tpl = _worldBorthposTpl:getTplById(posId)
  local sceneId = _worldBorthposTpl:getCityId(tpl)
  
  local function delayCallback()
    FrameScheduler.add(function()
      callback()
    end, 5)
  end
  
  L_SceneStore:transferToPoint(sceneId, posId, C_LoginManager.lineId, delayCallback)
end

function this.showRewards(rewardList, isFly, title, srcId)
  local dataList = {}
  local pageRewardDataList = {}
  for k, v in pairs(rewardList) do
    local itemData = {}
    itemData.itemid = v.itemId
    itemData.itemnum = v.itemNum
    itemData.deadtime = v.deadTime
    itemData.exts = v.exts
    itemData.itemtype = v.itemType
    itemData.varitems = v.varitems
    itemData.guid = v.guid
    itemData.collect = v.collect
    if isFly and itemData.itemtype ~= L_Const.resType.pet and itemData.itemtype ~= L_Const.resType.hero then
      table.insert(dataList, itemData)
    else
      table.insert(pageRewardDataList, itemData)
    end
  end
  if 0 < #pageRewardDataList then
    pageRewardDataList.title = title
    L_RewardManager:showPage(pageRewardDataList, srcId)
  end
  if 0 < #dataList then
    L_FlyMsgManager:showItemServerRewards(dataList)
  end
end

function this.showCommonRewards(rewardList, srcId, title)
  local rewards = require("ui.manager.reward.rewardData").new()
  rewards.title = title
  rewards.src = srcId
  rewards:constructList(rewardList)
  L_RewardManager:ShowReward(rewards, true)
end

function this.showCommonRewardsWithShowType(rewardList, showType, title)
  local rewards = require("ui.manager.reward.rewardData").new()
  rewards.rewardShowType = showType
  rewards:constructList(rewardList)
  rewards.title = title
  L_RewardManager:ShowReward(rewards)
end

function this.showRewardsWithType(rewardList, srcId, title, showType, needCombine)
  local rewards = require("ui.manager.reward.rewardData").new()
  rewards.title = title
  rewards.src = srcId
  rewards.rewardShowType = showType
  rewards:constructList(rewardList)
  L_RewardManager:ShowReward(rewards, nil, nil, nil, needCombine)
end

function this.createInterimBattleData(heroTeam, battleId, configBattle)
  local action
  
  function action(args)
    if args.finishType == C_EBattlerServerFinishType.Win then
      configBattle(true)
      L_BattleDataManager:removeListener(L_BattleDataManager.event.battleFinished, action)
    else
      L_UI:open("PageFailureBigWorld", {
        callBack = function()
          L_BattleManager:startInterimBattle(heroTeam, battleId)
        end
      })
    end
  end
  
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleFinished, action)
  local status = L_UI:getPageStatus("loading")
  if status and status == "shown" then
    L_LoadingManager:closeLoading()
    Timer.once(0.2, function()
      L_BattleManager:startInterimBattle(heroTeam, battleId)
    end)
    return
  end
  L_BattleManager:startInterimBattle(heroTeam, battleId)
end

function this.getWorldNowLevelByMapId(mapId)
  return L_WorldMapLvStore:getNowLevel(mapId)
end

function this.setCSHomeBuildInteract(guid, isPet, forceRefresh)
  L_HomeManager:setCurrInteractId(isPet and 0 or guid, forceRefresh)
end

function this.setProductInfoFromLua(buildGuid, productGuid)
  this.ProductStateLua2CS = this.ProductStateLua2CS or {
    [L_HomeConst.ProductQueueState.NONE] = CS.Lens.Gameplay.UI.Home.HomeBuildProductState.NONE,
    [L_HomeConst.ProductQueueState.WAITING] = CS.Lens.Gameplay.UI.Home.HomeBuildProductState.WAITNIG,
    [L_HomeConst.ProductQueueState.PAUSE] = CS.Lens.Gameplay.UI.Home.HomeBuildProductState.PAUSE,
    [L_HomeConst.ProductQueueState.RUNNING] = CS.Lens.Gameplay.UI.Home.HomeBuildProductState.RUNNING,
    [L_HomeConst.ProductQueueState.FINISH] = CS.Lens.Gameplay.UI.Home.HomeBuildProductState.FINISH
  }
  local ProductStateLua2CS = this.ProductStateLua2CS
  local state = L_ProductManager:getProductState(buildGuid, productGuid)
  local csHomeBuildProductData = L_ProductManager:getProductByGuid(buildGuid, productGuid)
  local onceTime, iconPath, img_iconFilter
  if C_HomeUtil.GetBuildingType(buildGuid) == L_Const.WorldMapBuildType.WMBT_HATCH then
    local petEggData = L_PetStore:getPetEggItem(csHomeBuildProductData.specialGuid)
    local petEggTpl = _petEggTpl:getTplById(petEggData.configId)
    iconPath = _petEggTpl:getEggImgIcon(petEggTpl)
    onceTime = L_PetStore:getEggIncubationTime(L_PetStore:getPetEggItem(csHomeBuildProductData.specialGuid).configId, buildGuid)
  else
    onceTime = L_ProductManager:getProduceOnceTime(buildGuid, csHomeBuildProductData.productId)
    local itemData = L_ProductManager:getProductRewardItemData(csHomeBuildProductData.productId)
    local item = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
    local commonItemTpl = L_GameTpl:getCommonItemTpl():getTplById(itemData.itemId)
    img_iconFilter = commonItemTpl and L_GameTpl:getCommonItemTpl():getFilterIcon(commonItemTpl) or ""
    iconPath = item.icon
  end
  local finishNum, total, amount = L_ProductManager:getProductProduceInfo(buildGuid, csHomeBuildProductData)
  local CSTemp = CS.Lens.Gameplay.UI.Home.TempHomeBuildDataFromLua
  CSTemp.state = ProductStateLua2CS[state]
  CSTemp.onceTime = onceTime
  CSTemp.finishCount = finishNum
  CSTemp.restCount = total - finishNum
  CSTemp.amount = amount
  CSTemp.iconPath = iconPath
  CSTemp.filterIconPath = img_iconFilter
end

function this.showGetEgg(itemId)
  L_UI:open("pageGetPetEgg", {configId = itemId})
end

function this.convertPos2MapAreaId(pos)
  return -1
end

function this.doOneRewardDropEnd(guid, itemid, itemnum, itemtype, sourcetype, sourceToolType, src, sourceFromType)
  local entity
  if itemtype == L_Const.resType.petEgg then
    entity = L_PetStore:getPetEggItem(guid)
    if entity then
      L_UI:open("pageGetPetEgg", {
        configId = entity.configId
      })
    end
  elseif itemtype == L_Const.resType.pet then
    entity = L_PetStore:getPetItem(guid)
    if entity then
      local options = {pet = entity}
      L_PetManager:commonGetPet(options)
    end
  else
    local rewards = require("ui.manager.reward.rewardData").new()
    rewards:constructOne(guid, itemid, itemnum, itemtype)
    local param = {
      sourcetype = sourcetype,
      sourceToolType = sourceToolType,
      sourceFromType = sourceFromType
    }
    L_RewardManager:ShowReward(rewards, true, param, src)
  end
end

function this.checkCollectionToolTrigger(isIn, toolType)
end

function this.checkCollectionToolBtnShow(isShow, toolType)
end

function this.notifyPlayerCollectAction(isBegin)
end

function this.isBlockBattleByUI()
  for _, pageType in pairs(L_UI.groupKeys) do
    local pages = L_UI:getAllPages(pageType)
    for _, page in pairs(pages) do
      if L_UI:checkPageOpen(page.pageName) then
        local pageConfig = L_UI:getPageConfig(page.pageName)
        if pageConfig.control.blockBattle then
          return true
        end
      end
    end
  end
  return false
end

function this.sendSyncHeroServerDataList()
  L_HeroStore:call(L_HeroStore.event.heroSync)
  AzurWorld.RedDotMgr:MarkDirtyTree(L_ReddotManager.DotDef.HeroHead)
end

function this.sendSyncHeroCharData()
  L_HeroStore:call(L_HeroStore.event.heroDataSync)
end

function this.heroMarkNew(heroGuid)
  L_ReddotManager:markNew(L_ReddotManager.DotDef.HeroNew, heroGuid)
  AzurWorld.RedDotMgr:MarkDirty(string.format(L_ReddotManager.DotDef.HeroHead, heroGuid))
  L_ReddotManager:markNew(L_ReddotManager.DotDef.HandBook_Character_New, "")
  L_ReddotManager:markNew(L_ReddotManager.DotDef.HandBook_Character_New_Item, heroGuid)
end

function this.heroLevelUp(heroGuid)
  L_BattleDataManager:setLevelSettleData(L_Const.roleType.hero, heroGuid, "levelUp")
end

function this.heroFavorLevelUp(heroGuid)
  L_BattleDataManager:setLevelSettleData(L_Const.roleType.hero, heroGuid, "favorLevelUp")
end

function this.getIsGuideComplete(id, flag)
  return L_GuideStore:isGuideComplete(id, flag)
end

function this.getIsLocalGuideComplete(id)
  return L_GuideManager:isLocalGuideCompleted(id)
end

local CachedConditionString2SingleCondition = {}
local CachedConditionString2ConditionGroup = {}

local function getSingleCondition(singleConditionString)
  if CachedConditionString2SingleCondition[singleConditionString] ~= nil then
    return CachedConditionString2SingleCondition[singleConditionString]
  end
  local singleConditionParamList = string.find(singleConditionString, "#") and string.split(singleConditionString, "#") or string.split(singleConditionString, "|")
  local singleCondition = {}
  for k, v in pairs(singleConditionParamList) do
    table.insert(singleCondition, tonumber(v))
  end
  CachedConditionString2SingleCondition[singleConditionString] = singleCondition
  return CachedConditionString2SingleCondition[singleConditionString]
end

local function getConditionGroup(conditionGroupString)
  if CachedConditionString2ConditionGroup[conditionGroupString] ~= nil then
    return CachedConditionString2ConditionGroup[conditionGroupString]
  end
  local conditionGroup = {}
  local singleConditionStringList = string.split(conditionGroupString, "|")
  for _, singleConditionString in pairs(singleConditionStringList) do
    local singleCondition = getSingleCondition(singleConditionString)
    table.insert(conditionGroup, singleCondition)
  end
  CachedConditionString2ConditionGroup[conditionGroupString] = conditionGroup
  return CachedConditionString2ConditionGroup[conditionGroupString]
end

function this.setStoryProxy()
  CS.Lens.Gameplay.Modules.BigWorld.Macro.IsBattleSimulator = true
  local sexType = CS.Azur.Gameplay.EditorTool.StorySimulator.StorySimulator.GetPlayerSexType()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  baseInfo.sex = sexType
end

function this.isFirstGetPet(petGuid)
  local entity = L_PetStore:getPetItem(petGuid)
  local map = L_CatalogStore:getPetCatalog()
  if entity then
    local firstGet = not map[entity.id] or not (map[entity.id] > 2)
    return firstGet
  else
    return false
  end
end

function this.isFirstGetPetByPetId(petId)
  local map = L_CatalogStore:getPetCatalog()
  local firstGet = not map[petId] or not (1 < map[petId])
  return firstGet
end

function this.playerUnitLua(isCreate)
  if isCreate then
    L_PlayerManager:createPlayerUnitLua()
  else
    L_PlayerManager:removePlayerUnitLua()
  end
end

table.merge(this, require("modules.world.azurWorld.azurMediator_story"))

function this.showFullPageReward(rewardsList, closeCallback, title)
  L_RewardManager:showFullPageReward(rewardsList, closeCallback, title)
end

_adapter.SetLuaMediator(this)
return AzurMediator
