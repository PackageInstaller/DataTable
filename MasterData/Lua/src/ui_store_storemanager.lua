local this = class("storeManager")
G_BaseStore = require("core.ui.manager.store.baseStore")
local StorePath = {
  L_SettingStore = "setting.settingStore",
  L_LocalStore = "local.localStore",
  L_PlayerStore = "player.playerStore",
  L_HeroStore = "hero.heroStore",
  L_FormationStore = "formation.formationStore",
  L_DungeonStore = "dungeon.dungeonStore",
  L_MultiDungeonStore = "multiDungeon.multiDungeonStore",
  L_StaminaChestStore = "staminaChest.staminaChestStore",
  L_ReddotStore = "reddot.reddotStore",
  L_TaskStore = "task.taskStore",
  L_PhotoStore = "photo.photoStore",
  L_HomeStore = "home.homeStore",
  L_OtakuStore = "otaku.otakuStore",
  L_PlacePointStore = "placePoint.placePointStore",
  L_LibraryBookStore = "libraryBook.libraryBookStore",
  L_ReputationStore = "reputation.reputationStore",
  L_ShopStore = "shop.shopStore",
  L_SceneStore = "scene.sceneStore",
  L_WorldLevelStore = "worldLevel.worldLevelStore",
  L_WorldMapLvStore = "worldMapLv.worldMapLvStore",
  L_MountStore = "mount.mountStore",
  L_ProductStore = "product.productStore",
  L_MailStore = "mail.mailStore",
  L_BattleStore = "battle.battleStore",
  L_BigWorldBattleStore = "bigWorldBattle.bigWorldBattleStore",
  L_ModStore = "mod.modStore",
  L_GameStore = "game.gameStore",
  L_PetStore = "pet.petStore",
  L_PetDuelStore = "petDuel.petDuelStore",
  L_GuideStore = "guide.guideStore",
  L_FriendStore = "friend.friendStore",
  L_WeaponStore = "weapon.weaponStore",
  L_ChatStore = "chat.chatStore",
  L_BattleTeamStore = "battleTeam.battleTeamStore",
  L_KiboDuelSimulatorStore = "kiboDuelSimulator.kiboDuelSimulatorStore",
  L_MoneyShopStore = "moneyShop.moneyShopStore",
  L_AreaStore = "area.areaStore",
  L_NoticeStore = "login.noticeStore",
  L_ActivityTaskStore = "activityTask.activityTaskStore",
  L_NoviceTaskStore = "activityTask.noviceTaskStore",
  L_FishingStore = "fishing.fishingStore",
  L_CookStore = "cook.cookStore",
  L_StarGiftStore = "starGift.starGiftStore",
  L_HomeScienceStore = "homeScience.homeScienceStore",
  L_HomeCropStore = "homeCrop.homeCropStore",
  L_ControlStore = "control.controlStore",
  L_TowerStore = "tower.towerStore",
  L_QuickRouletteStore = "quickRoulette.quickRouletteStore",
  L_EntrustStore = "entrust.entrustStore",
  L_GameActStore = "gameAct.gameActStore",
  L_GameEventStore = "gameEvent.gameEventStore",
  L_BuffStore = "buff.buffStore",
  L_StarHealingStore = "starHealing.starHealingStore",
  L_AnnouncementStore = "announcement.announcementStore",
  L_FavorabilityStore = "favorability.favorabilityStore",
  L_TechnologyStore = "technology.technologyStore",
  L_SatietyStore = "satiety.satietyStore",
  L_TutorialStore = "tutorial.tutorialStore",
  L_CatalogStore = "catalog.catalogStore",
  L_PlayerDisplayStore = "playerdisplay.playerDisplayStore",
  L_RuneStore = "rune.runeStore",
  L_SituationStore = "situation.situationStore",
  L_LimitedTimeActivityStore = "limitedTimeActivity.limitedTimeActivityStore",
  L_PopperPartyStore = "popperparty.matchStore"
}

local function EmmyTemp()
  L_SettingStore = nil
  L_LocalStore = nil
  L_PlayerStore = nil
  L_HeroStore = nil
  L_FormationStore = nil
  L_DungeonStore = nil
  L_MultiDungeonStore = nil
  L_StaminaChestStore = nil
  L_ReddotStore = nil
  L_soulessenceStore = nil
  L_TaskStore = nil
  L_PhotoStore = nil
  L_HomeStore = nil
  L_OtakuStore = nil
  L_PlacePointStore = nil
  L_LibraryBookStore = nil
  L_ReputationStore = nil
  L_ShopStore = nil
  L_SceneStore = nil
  L_WorldLevelStore = nil
  L_WorldMapLvStore = nil
  L_MountStore = nil
  L_ProductStore = nil
  L_MailStore = nil
  L_BattleStore = nil
  L_BigWorldBattleStore = nil
  L_ModStore = nil
  L_GameStore = nil
  L_PetStore = nil
  L_PetDuelStore = nil
  L_GuideStore = nil
  L_FriendStore = nil
  L_WeaponStore = nil
  L_ChatStore = nil
  L_BattleTeamStore = nil
  L_KiboDuelSimulatorStore = nil
  L_MoneyShopStore = nil
  L_NoticeStore = nil
  L_ActivityTaskStore = nil
  L_NoviceTaskStore = nil
  L_FishingStore = nil
  L_CookStore = nil
  L_StarGiftStore = nil
  L_HomeCropStore = nil
  L_ControlStore = nil
  L_EntrustStore = nil
  L_TowerStore = nil
  L_QuickRouletteStore = nil
  L_GameActStore = nil
  L_GameEventStore = nil
  L_BuffStore = nil
  L_PamiTalkStore = nil
  L_StarHealingStore = nil
  L_AnnouncementStore = nil
  L_FavorabilityStore = nil
  L_TechnologyStore = nil
  L_SatietyStore = nil
  L_TutorialStore = nil
  L_CatalogStore = nil
  L_PlayerDisplayStore = nil
  L_RuneStore = nil
  L_SituationStore = nil
  L_PopperPartyStore = nil
end

function this:ctor()
  self._stores = {}
end

function this:checkGetStore(key)
  local path = StorePath[key]
  if not path then
    return nil
  end
  if not self._stores[key] then
    self._stores[key] = require(L_R.store .. path).new()
  end
  return self._stores[key]
end

function this:removeStore(key)
  self._stores[key] = nil
end

function this:allStoresDoClear()
  for _, v in pairs(self._stores) do
    if v.clear then
      v:clear()
    end
  end
end

return this
