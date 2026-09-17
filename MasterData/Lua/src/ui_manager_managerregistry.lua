local this = class("ManagerRegistry")
require("ui.manager.system.systemConst")
require("ui.manager.priorityShowQueue.showQueueConst")
require("ui.manager.sortFilter.sortFilterConst")
require("ui.manager.fishing.fishingConst")
require("ui.manager.multiDungeon.multiDungeonConst")
require("ui.manager.formation.formationConst")
require("ui.manager.pet.petConst")
require("ui.manager.dungeon.dungeonConst")
require("ui.manager.bag.bagConst")
require("ui.manager.accessory.accessoryConst")
require("ui.manager.map.mapConst")
L_PoolManager = require("ui.manager.gamePool.poolManager").new()
L_ResPool = L_PoolManager:getResPool()
local ManagerPath = {
  L_UIManager = "ui.manager.ui.uiManager",
  L_PoolManager = "ui.manager.gamePool.poolManager",
  L_SceneGuideManager = "ui.manager.guide.sceneGuideManager",
  L_StoryDialogManager = "ui.manager.story.storyDialogManager",
  L_FormationManager = "ui.manager.formation.formationManager",
  L_SoldierManager = "ui.manager.soldier.soldierManager",
  L_TaskManager = "ui.manager.task.taskManager",
  L_ConditionManager = "ui.manager.condition.conditionManager",
  L_ItemTplManager = "ui.manager.item.itemTplManager",
  L_ItemManager = "ui.manager.item.itemManager",
  L_AttributeManager = "ui.manager.attribute.attributeManager",
  L_FlyMsgManager = "ui.manager.flyMsg.flyMsgManager",
  L_PhotoManager = "ui.manager.photo.photoManager",
  L_LoadingManager = "ui.manager.loading.loadingManager",
  L_SortFilterManager = "ui.manager.sortFilter.sortFilterManager",
  L_LoginPlatformManager = "ui.manager.login.loginPlatformManager",
  L_RewardManager = "ui.manager.reward.rewardManager",
  L_ChatManager = "ui.manager.chat.chatManager",
  L_FriendManager = "ui.manager.friend.friendManager",
  L_TimerManager = "ui.manager.timer.timerManager",
  L_ColliderManager = "ui.manager.collider.colliderManager",
  L_ReddotManager = "ui.manager.reddot.reddotManager",
  L_MoneyShopManager = "ui.manager.moneyShop.moneyShopManager",
  L_ShopManager = "ui.manager.shop.shopManager",
  L_ProductManager = "ui.manager.product.productManager",
  L_FishingManager = "ui.manager.fishing.fishingManager",
  L_HeroManager = "ui.manager.hero.heroManager",
  L_PetManager = "ui.manager.pet.petManager",
  L_PetReleaseManager = "ui.manager.pet.petReleaseManager",
  L_DropdownsManager = "ui.manager.dropdowns.dropdownsManager",
  L_ShortCutManager = "ui.manager.shortCut.shortCutManager",
  L_LibrarybookManager = "ui.manager.libraryBook.librarybookManager",
  L_MultiDungeonManager = "ui.manager.multiDungeon.multiDungeonManager",
  L_SystemBreakManager = "ui.manager.system.systemBreakManager",
  L_StaminaManager = "ui.manager.stamina.staminaManager",
  L_StaminaChestManager = "ui.manager.staminaChest.staminaChestManager",
  L_DungeonManager = "ui.manager.dungeon.dungeonManager",
  L_StarManualManager = "ui.manager.starManual.starManualManager",
  L_TowerManager = "ui.manager.tower.towerManager",
  L_PriorityShowQueueManager = "ui.manager.priorityShowQueue.priorityShowQueueManager",
  L_StarHealingManager = "ui.manager.starHealing.starHealingManager",
  L_FavorabilityManager = "ui.manager.favorability.favorabilityManager",
  L_WeatherManager = "ui.manager.weather.weatherManager",
  L_MailManager = "ui.manager.mail.mailManager",
  L_SatietyManager = "ui.manager.satiety.satietyManager",
  L_HeroVoiceManager = "ui.manager.hero.heroVoiceManager",
  L_QuickRouletteManager = "ui.manager.quickRoulette.quickRouletteManager",
  L_UIModelMgr = "ui.manager.ui.uiModelMgr",
  L_WaterMarkManager = "ui.manager.waterMark.waterMarkManager",
  L_MiniGameManager = "ui.manager.miniGame.miniGameManager",
  L_JumpMgr = "ui.manager.jump.jumpManager",
  L_GuideManager = "modules.guide.guideManager",
  L_SituationManager = "ui.manager.situation.situationManager",
  L_GameActivityManager = "ui.manager.gameActivity.gameActivityManager",
  L_BattleDataManager = L_R.battle .. "battleDataManager",
  L_BattleFieldManager = L_R.battle .. "battleFieldEventManager",
  L_MountManager = L_R.world.coreMgr .. "mount.mountManager",
  L_GameEventManager = "ui.store.gameEvent.gameEventManager",
  L_FrameLoaderMgr = "ui.manager.ui.frameLoaderMgr"
}

local function EmmyTemp()
  L_UIManager = nil
  L_PoolManager = nil
  L_SceneGuideManager = nil
  L_StoryDialogManager = nil
  L_FormationManager = nil
  L_SoldierManager = nil
  L_TaskManager = nil
  L_ConditionManager = nil
  L_ItemTplManager = nil
  L_ItemManager = nil
  L_AttributeManager = nil
  L_FlyMsgManager = nil
  L_PhotoManager = nil
  L_LoadingManager = nil
  L_InteractiveManager = nil
  L_SortFilterManager = nil
  L_MultiDungeonManager = nil
  L_LoginPlatformManager = nil
  L_RewardManager = nil
  L_ChatManager = nil
  L_FriendManager = nil
  L_TimerManager = nil
  L_ColliderManager = nil
  L_ReddotManager = nil
  L_MoneyShopManager = nil
  L_ShopManager = nil
  L_ProductManager = nil
  L_CanteenManager = nil
  L_FishingManager = nil
  L_HeroManager = nil
  L_PetManager = nil
  L_PetReleaseManager = nil
  L_DropdownsManager = nil
  L_ShortCutManager = nil
  L_LibrarybookManager = nil
  L_SystemBreakManager = nil
  L_StaminaManager = nil
  L_StaminaChestManager = nil
  L_DungeonManager = nil
  L_StarManualManager = nil
  L_TowerManager = nil
  L_PriorityShowQueueManager = nil
  L_StarHealingManager = nil
  L_FavorabilityManager = nil
  L_WeatherManager = nil
  L_MailManager = nil
  L_SatietyManager = nil
  L_HeroVoiceManager = nil
  L_QuickRouletteManager = nil
  L_UIModelMgr = nil
  L_WaterMarkManager = nil
  L_MiniGameManager = nil
  L_JumpMgr = nil
  L_GuideManager = nil
  L_SituationManager = nil
  L_GameActivityManager = nil
  L_BattleDataManager = nil
  L_BattleFieldManager = nil
  L_MountManager = nil
  L_FrameLoaderMgr = nil
  L_GameEventManager = nil
end

function this:ctor()
  self._managers = {}
end

function this:getManager(key)
  local path = ManagerPath[key]
  if not path then
    return nil
  end
  if not self._managers[key] then
    local mgrClass = require(path)
    self._managers[key] = mgrClass.new()
  end
  return self._managers[key]
end

function this:initializeAll()
  for k, _ in pairs(ManagerPath) do
    local mgr = self:getManager(k)
    if mgr and mgr.initialize and type(mgr.initialize) == "function" then
      mgr:initialize()
    end
  end
end

function this:disposeAll()
  for k, mgr in pairs(self._managers) do
    if mgr and mgr.dispose and type(mgr.dispose) == "function" then
      mgr:dispose()
    end
  end
end

return this
