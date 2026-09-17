local this = class("systemBreakManager")
local _systemTpl = L_GameTpl:getSystemUnlockTpl()

function this:jumpTo(systemId, ...)
  if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(systemId) then
    return
  end
  local quickName = this.quickBreakMap[systemId]
  if quickName then
    L_UI:open(quickName, ...)
  else
    local method = this.breakMap[systemId]
    if method then
      method(...)
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellNoviceTaskItem_05", {
        [0] = systemId
      }))
    end
  end
end

function this:checkBanSystemAndTip(systemId)
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(systemId) then
    local reason = C_IntegrateMgr.SystemUnlockModule:getSystemBanReason(systemId)
    local tip
    if not string.isEmpty(reason) then
      tip = reason
    else
      local tpl = _systemTpl:getTplById(systemId)
      tip = _systemTpl:getGmCloseTips(tpl)
    end
    if not string.isEmpty(tip) then
      L_FlyMsgManager:showNormalMsg(tip)
    end
    return true
  end
  return false
end

this.quickBreakMap = {
  [L_SystemConst.enum.mainMenu] = "pageMainMenu",
  [L_SystemConst.enum.gacha] = "pageGacha",
  [L_SystemConst.enum.hero] = "pageHero",
  [L_SystemConst.enum.pet] = "pagePetBox",
  [L_SystemConst.enum.shop] = "pageMoneyShop",
  [L_SystemConst.enum.specialShop] = "pageSpecialShop",
  [L_SystemConst.enum.bag] = "pageBag",
  [L_SystemConst.enum.task] = "pageTask",
  [L_SystemConst.enum.achievement] = "pageAchievement",
  [L_SystemConst.enum.mail] = "pageMail",
  [L_SystemConst.enum.friend] = "pageFriends",
  [L_SystemConst.enum.formation] = "pageFormationMain",
  [L_SystemConst.enum.photo] = "pagePhoto",
  [L_SystemConst.enum.stamina] = "pageStamina",
  [L_SystemConst.enum.climbTower] = "pageTower",
  [L_SystemConst.enum.starManual] = "pageStarManual",
  [L_SystemConst.enum.announcemenet] = "pageAnnouncement",
  [L_SystemConst.enum.gameAct] = "pageGameAct",
  [L_SystemConst.enum.petDuel] = "pagePetDuelChapter",
  [L_SystemConst.enum.homeBag] = "pageHomeBag",
  [L_SystemConst.enum.kiboDuelAreaLevel] = "pageKiboDuelAreaLevel",
  [L_SystemConst.enum.Abbys] = "pageAbbysMain",
  [L_SystemConst.enum.socialRoulette] = "pageSocialQuickRoulette",
  [L_SystemConst.enum.entrustTask] = "pageDungeonEntrustEntrance"
}
this.breakMap = {}
this.breakMap[L_SystemConst.enum.product] = function(callback)
  L_UI:open("pageProduct", {
    productType = L_Const.productType.cast
  }, callback)
end
this.breakMap[L_SystemConst.enum.chat] = function(option, callback)
  L_UI:open("pageChat", nil, callback)
end
this.breakMap[L_SystemConst.enum.playerRename] = function(option, callback)
  L_PlayerManager:modifyName()
end
this.breakMap[L_SystemConst.enum.playerDisplayText] = function(option, callback)
  L_PlayerManager:modifySign()
end
this.breakMap[L_SystemConst.enum.playerCard] = function(option, callback)
  L_UI:open("pagePlayerCard", {
    uid = L_PlayerStore:getPlayerId()
  }, callback)
end
this.breakMap[L_SystemConst.enum.home] = function(option, callback)
  if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.home) then
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Home, true) then
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_transform_05"))
    return
  end
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_gohome"))
    return
  end
  local curModule = L_WorldManager:getCurModule()
  if curModule == L_Const.worldModule.home then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemBreakManager_01"))
    return
  end
  local data = {
    txtContent = L_WordsTpl:getValue("notice_home_transfer_enter"),
    confirmCallback = function()
      if L_WorldManager:getIsActive() then
        L_HomeStore:req_enterHome()
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_noActive_01"))
      end
    end
  }
  L_GameUtil.showCommonTip(data)
end
this.breakMap[L_SystemConst.enum.petStrength] = function(option, callback)
  if option ~= nil and option.petId ~= nil then
    L_UI:open("pagePet", option, callback)
    return
  end
  local petGuid = L_PetStore:getFirstOrderPet()
  L_UI:open("pagePet", {petId = petGuid}, callback)
end
this.breakMap[L_SystemConst.enum.mount] = function(option, callback)
  L_UI:backToRoot(function()
    L_UI:open("pageMountRoulette")
  end)
end
this.breakMap[L_SystemConst.enum.bagSoulEssence] = function(option, callback)
  this.openBagByType(L_SystemConst.enum.bagSoulEssence, callback)
end
this.breakMap[L_SystemConst.enum.bagAccessory] = function(option, callback)
  this.openBagByType(L_SystemConst.enum.bagAccessory, callback)
end
this.breakMap[L_SystemConst.enum.bagFood] = function(option, callback)
  this.openBagByType(L_SystemConst.enum.bagFood, callback)
end

function this.openBagByType(systemId, callback)
  local tpl = _systemTpl:getTplById(systemId)
  local param = _systemTpl:getParam(tpl)
  L_UI:open("pageBag", {bagType = param}, callback)
end

this.breakMap[L_SystemConst.enum.announcement] = function(option, callback)
  this.openStarManualTab(L_SystemConst.enum.announcement, callback)
end
this.breakMap[L_SystemConst.enum.spritMaterial] = function(option, callback)
  this.openStarManualTab(L_SystemConst.enum.spritMaterial, callback)
end
this.breakMap[L_SystemConst.enum.skillMaterial] = function(option, callback)
  this.openStarManualTab(L_SystemConst.enum.skillMaterial, callback)
end
this.breakMap[L_SystemConst.enum.wildBoss] = function(option, callback)
  this.openStarManualTab(L_SystemConst.enum.wildBoss, callback)
end
this.breakMap[L_SystemConst.enum.equipMaterial] = function(option, callback)
  this.openStarManualTab(L_SystemConst.enum.equipMaterial, callback)
end
this.breakMap[L_SystemConst.enum.weeklyBoss] = function(option, callback)
  this.openStarManualTab(L_SystemConst.enum.weeklyBoss, callback)
end

function this.openStarManualTab(systemId, callback)
  local tpl = _systemTpl:getTplById(systemId)
  local param = _systemTpl:getParam(tpl)
  L_UI:open("pageStarManual", {starManualId = param}, callback)
end

this.breakMap[L_SystemConst.enum.characterExpDungon] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.characterExpDungon)
end
this.breakMap[L_SystemConst.enum.spritExpDungon] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.spritExpDungon)
end
this.breakMap[L_SystemConst.enum.petExpDungon] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.petExpDungon)
end
this.breakMap[L_SystemConst.enum.coinDungon] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.coinDungon)
end
this.breakMap[L_SystemConst.enum.wildBossDungeon1] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.wildBossDungeon1)
end
this.breakMap[L_SystemConst.enum.wildBossDungeon2] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.wildBossDungeon2)
end
this.breakMap[L_SystemConst.enum.wildBossDungeon3] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.wildBossDungeon3)
end
this.breakMap[L_SystemConst.enum.wildBossDungeon4] = function(option, callback)
  this.dealOpenDugonBigMap(L_SystemConst.enum.wildBossDungeon4)
end

function this.dealOpenDugonBigMap(systemId)
  local sysTpl = _systemTpl:getTplById(systemId)
  local targetParam = _systemTpl:getTargetParam(sysTpl)
  L_UI:open("pageBigMap", {targetParam = targetParam, areaId = 100000})
end

this.breakMap[L_SystemConst.enum.spiritBreakDungon1] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.spiritBreakDungon1)
end
this.breakMap[L_SystemConst.enum.spiritBreakDungon2] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.spiritBreakDungon2)
end
this.breakMap[L_SystemConst.enum.spiritBreakDungon3] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.spiritBreakDungon3)
end
this.breakMap[L_SystemConst.enum.skillMaterialDungeon1] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.skillMaterialDungeon1)
end
this.breakMap[L_SystemConst.enum.skillMaterialDungeon2] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.skillMaterialDungeon2)
end
this.breakMap[L_SystemConst.enum.skillMaterialDungeon3] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.skillMaterialDungeon3)
end
this.breakMap[L_SystemConst.enum.skillMaterialDungeon4] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.skillMaterialDungeon4)
end
this.breakMap[L_SystemConst.enum.skillMaterialDungeon5] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.skillMaterialDungeon5)
end
this.breakMap[L_SystemConst.enum.warriorResource] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.warriorResource)
end
this.breakMap[L_SystemConst.enum.assassinResource] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.assassinResource)
end
this.breakMap[L_SystemConst.enum.archerResource] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.archerResource)
end
this.breakMap[L_SystemConst.enum.casterResource] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.casterResource)
end
this.breakMap[L_SystemConst.enum.supporterResource] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.supporterResource)
end
this.breakMap[L_SystemConst.enum.weeklyBossDungeon1] = function(option, callback)
  this.dealTeleport(L_SystemConst.enum.weeklyBossDungeon1)
end
this.checkInitTimer = false

function this.dealTeleport(systemId)
  local sysTpl = _systemTpl:getTplById(systemId)
  local markId = _systemTpl:getDungeon(sysTpl)
  local worldFilterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
  local tpl = worldFilterMarkTpl:getTplById(markId)
  local doorId = worldFilterMarkTpl:getParam(tpl)
  local worldId = worldFilterMarkTpl:getWorldId(tpl)
  local posId = worldFilterMarkTpl:getPosId(tpl)
  local worldmapId = worldFilterMarkTpl:getWorldmapId(tpl)
  L_SceneStore:transferToPoint(worldId, posId, C_LoginManager.lineId, function()
    if this.checkInitTimer then
      Timer.remove(this.checkInitTimer)
    end
    this.checkInitTimer = Timer.repeated(0.1, function()
      if L_UI:checkPageOpen("pageAttendance") or L_UI:checkPageOpen("pageReward") then
        if L_UI:checkPageOpen("pageBlank") then
          L_UI:close("pageBlank")
        end
        return
      end
      if not L_LoadingManager:isLoading() then
        if not L_UI:checkPageOpen("pageBlank") then
          L_UI:open("pageBlank", {timeClose = 10})
        end
        local entity = AzurWorld.WorldMapMgr:TryGetEntity(worldmapId)
        if entity then
          L_UI:open("pageDungeonEntry", {entity = entity, doorId = doorId})
          Timer.once(1, function()
            L_UI:close("pageBlank")
          end)
          Timer.remove(this.checkInitTimer)
          this.checkInitTimer = false
        end
      end
    end)
  end)
end

this.breakMap[L_SystemConst.enum.adventure] = function(option)
  local mapStore = C_MapManager:GetMapStore()
  local bExist = mapStore ~= nil and mapStore:hasSpecialMonster(option.map_id, option.obj_id, option.special_type)
  if not bExist then
    L_FlyMsgManager:showNormalMsg(L_GameTpl:getWordsTpl():getTplById("notice_special_pet_disappear"))
    return
  end
  local areaId = L_GameTpl:getWorldAreaTpl():getCurSceneAreaList(option.map_id)[1].id
  L_UI:open("pageBigMap", {
    areaId = areaId,
    specialParams = {
      map_id = option.map_id,
      obj_id = option.obj_id,
      special_type = option.special_type
    }
  })
end

function this.jumpToMoneyShop(subSysTemId, option, callback)
  local function func()
    L_JumpMgr:jumpTo(L_SystemConst.jumpEnum.jumpToMoneyShopRecharge)
  end
  
  if subSysTemId == L_SystemConst.enum.MallRechargeDiamondSystem then
    if AzurWorld.MallMgr:IsEnterMall() then
      func()
      return
    end
    local debt1 = C_BagMgr:GetDebtNum(L_Const.currencyType.tiedDiamond)
    local debt2 = C_BagMgr:GetDebtNum(L_Const.currencyType.tiedDiamondExtend)
    local debt = 0 < debt1 or 0 < debt2
    local data = {
      txtTitle = "",
      txtContent = debt and L_WordsTpl:getValue("diamond_buy_notice") or L_WordsTpl:getValue("notice_goto_recharge", {
        [0] = L_ItemTplManager:getItemConfig(L_Const.resType.currency, L_Const.currencyType.tiedDiamond).name
      }),
      confirmCallback = func
    }
    L_GameUtil.showCommonTip(data)
  else
    func()
  end
end

this.breakMap[L_SystemConst.enum.MallRechargeDiamondSystem] = function(...)
  if C_AppConfigManager.Platform == C_EAppPlatform.IOS then
    local data = {
      txtTitle = "",
      txtContent = L_WordsTpl:getValue("notice_shop_nopay_ios_tips")
    }
    L_GameUtil.showCommonTip(data)
    return
  end
  this.jumpToMoneyShop(L_SystemConst.enum.MallRechargeDiamondSystem, ...)
end
this.breakMap[L_SystemConst.enum.moneyShopYellow] = function(...)
  this.jumpToMoneyShop(L_SystemConst.enum.moneyShopYellow, ...)
end
this.breakMap[L_SystemConst.enum.moneyShopGreen] = function(...)
  this.jumpToMoneyShop(L_SystemConst.enum.moneyShopGreen, ...)
end
this.breakMap[L_SystemConst.enum.moneyShopGift] = function(...)
  this.jumpToMoneyShop(L_SystemConst.enum.moneyShopGift, ...)
end
this.breakMap[L_SystemConst.enum.moneyShopCity] = function(...)
  this.jumpToMoneyShop(L_SystemConst.enum.moneyShopCity, ...)
end
this.breakMap[L_SystemConst.enum.moneyRaffleGoods] = function(...)
  this.jumpToMoneyShop(L_SystemConst.enum.moneyRaffleGoods, ...)
end
this.breakMap[L_SystemConst.enum.science] = function(...)
  this.jumpToPageHero(L_SystemConst.enum.science, ...)
end
this.breakMap[L_SystemConst.enum.skill] = function(...)
  this.jumpToPageHero(L_SystemConst.enum.skill, ...)
end
this.breakMap[L_SystemConst.enum.heroGrade] = function(...)
  this.jumpToPageHero(L_SystemConst.enum.heroGrade, ...)
end
this.breakMap[L_SystemConst.enum.soulEssence] = function(...)
  this.jumpToPageHero(L_SystemConst.enum.soulEssence, ...)
end
this.breakMap[L_SystemConst.enum.accessory] = function(...)
  this.jumpToPageHero(L_SystemConst.enum.accessory, ...)
end
this.breakMap[L_SystemConst.enum.heroData] = function(...)
  this.jumpToPageHero(L_SystemConst.enum.heroData, ...)
end

function this.jumpToPageHero(subSysTemId, option, callback)
  local function func()
    option = option or {}
    
    if subSysTemId == L_SystemConst.enum.science then
      option.selectModuleType = L_Const.heroModuleType.Talent
    elseif subSysTemId == L_SystemConst.enum.skill then
      option.selectModuleType = L_Const.heroModuleType.Skill
    elseif subSysTemId == L_SystemConst.enum.heroGrade then
      option.selectModuleType = L_Const.heroModuleType.Star
    elseif subSysTemId == L_SystemConst.enum.soulEssence then
      option.selectModuleType = L_Const.heroModuleType.SoulEssence
    elseif subSysTemId == L_SystemConst.enum.accessory then
      option.selectModuleType = L_Const.heroModuleType.Accessory
    elseif subSysTemId == L_SystemConst.enum.heroData then
      option.selectModuleType = L_Const.heroModuleType.Data
    end
    local page = L_UI:getPage("pageHero")
    if L_UI:checkPageShown("pageHero", true) then
      page.cls:refresh(option, callback)
    else
      L_UI:open("pageHero", option, callback)
    end
  end
  
  func()
end

this.breakMap[L_SystemConst.enum.activation] = function(option, callback)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.activation) and not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceTask) then
    return
  elseif C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.activation) then
    L_UI:open("pageActivityTask", option, callback)
  elseif C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceTask) then
    if L_NoviceTaskStore:checkIfAllTaskCompletedAndAllRewardReceived() == true then
      return
    end
    L_UI:open("pageActivityTask")
  end
end
this.breakMap[L_SystemConst.enum.homeScience] = function(option, callback)
  C_HomeUtil.OpenHomeTechnology(option and option.isTopLayer and true or false, callback)
end
this.breakMap[L_SystemConst.enum.noviceTask] = function(option, callback)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceTask) then
    return
  end
  if L_NoviceTaskStore:checkIfAllTaskCompletedAndAllRewardReceived() then
    return
  end
  if AzurWorld.DungeonMgr:CheckIsInTeaching() then
    return
  end
  if AzurWorld.JourneyMgr:AllRewardAndBottomRewardComplete() then
    return
  end
  L_UI:open("pageStarJourney", option, callback)
end
this.breakMap[L_SystemConst.enum.journeyTask] = function(option, callback)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.journeyTask) then
    return
  end
  if AzurWorld.DungeonMgr:CheckIsInTeaching() then
    return
  end
  if AzurWorld.JourneyMgr:AllRewardAndBottomRewardComplete() then
    return
  end
  L_UI:open("pageStarJourney", option, callback)
end
this.breakMap[L_SystemConst.enum.payToFreeExchangeSystem] = function(option, callback)
  local debt1 = C_BagMgr:GetDebtNum(L_Const.currencyType.tiedDiamond)
  local debt2 = C_BagMgr:GetDebtNum(L_Const.currencyType.tiedDiamondExtend)
  local currencyNum = L_PlayerStore:getCurrencyNum(L_Const.currencyType.tiedDiamond)
  if 0 < debt1 or 0 < debt2 or currencyNum < 1 then
    this:jumpTo(L_SystemConst.enum.MallRechargeDiamondSystem)
    return
  end
  L_UI:open("pageBagUseExchange", {
    itemType = L_Const.resType.currency,
    itemId = L_Const.currencyType.tiedDiamond
  })
end
return this
