L_ShortCutConst = {}
L_ShortCutConst.event = {
  Mount = "ShortCutManager_Mount",
  MountFly = "ShortCutManager_MountFly",
  LongPressMount = "ShortCutManager_LongPressMount",
  LongPressPetSkill = "ShortCutManager_LongPressPetSkill",
  UseRoulette = "ShortCutManager_UseRoulette",
  TaskToMap = "ShortCutManager_TaskToMap",
  KiBoSkill = "KiBoSkill",
  PetDuelStatistics = "PetDuelStatistics",
  StartScanning = "StartScanning",
  PetGet = "ShortCutManager_PetGet",
  PetCatalog = "ShortCutManager_PetCatalog",
  journeyShow = "ShowtCutManager_JourneyShow",
  LibraryBook = "ShortCutManager_LibraryBook",
  Achievement = "ShortCutManager_Achievement",
  KeyCodeE = "ShortCutManager_KeyCodeE",
  KeyCodeR = "ShortCutManager_KeyCodeR",
  LongPressScan = "ShortCutManager_LongPressScan",
  PageBigMap = "ShortCutManager_bigMap"
}

local function sc_noop()
end

local function sc_jump_formation()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.formation, {isSubFormation = true})
end

local function sc_open_bigmap()
  L_UI:open("pageBigMap")
end

local function sc_jump_hero()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.hero)
end

local function sc_jump_bg()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.bag)
end

local function sc_send_start_scanning()
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.StartScanning)
end

local function sc_home_switch()
  C_HomeUtil.SwitchInOutHome()
end

local function sc_leave_home()
  C_HomeUtil.LeaveHome()
end

local function sc_tutorial_stub()
end

local function sc_open_home_bag()
  L_UI:open("pageHomeBag")
end

local function sc_jump_task()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.task)
end

local function sc_jump_pet()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.pet)
end

local function sc_jump_chat()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.chat)
end

local function sc_jump_activation()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.activation)
end

local function sc_jump_game_act()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.gameAct)
end

local function sc_jump_entrust_task()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.entrustTask)
end

local function sc_open_tutorial_page()
  L_UI:open("pageTutorial")
end

local function sc_jump_journey_task()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.journeyTask)
end

local function sc_try_switch_hero(index)
  if AzurWorld.QuickItemMgr.isShowQuickItemBar then
    return
  end
  if C_InputManager.IsEnableGamePad and AzurWorld.InteractMgr:GetShownInteractiveCount() > 0 then
    return
  end
  L_FormationManager:switchMyPlayerMainControl(index)
end

local function sc_switch_hero_0()
  sc_try_switch_hero(0)
end

local function sc_switch_hero_1()
  sc_try_switch_hero(1)
end

local function sc_switch_hero_2()
  sc_try_switch_hero(2)
end

local function sc_switch_hero_3()
  sc_try_switch_hero(3)
end

local function sc_call_mount()
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount) then
    return
  end
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.Mount)
end

local function sc_mount_fly_stub()
end

local function sc_achieve_stub()
end

local function sc_pet_skill()
  if C_PuzzleManager.HaveCanTriggerPuzzle() and AzurWorld.playerMgr.myPlayerData:GetIsSwimming() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_swim_petpuzzle_tip"))
  end
end

local function sc_pet_skill_roulette_hold(isPress)
  if L_BattleDataManager:checkPlayerBattle() then
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Pet, false) then
    return
  end
  if C_IntegrateMgr.SystemUnlockModule:CheckIsDisableSystem(L_SystemConst.enum.petPuzzleRoulette, true) then
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petPuzzleRoulette)
  if not result then
    return
  end
  if C_HomeUtil.IsInHome() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_homeFunction"))
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    return
  end
end

local function sc_pet_skill_roulette(isPress)
  local result = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petPuzzleRoulette)
  if not result then
    return
  end
  if C_HomeUtil.IsInHome() then
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Pet, false) then
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    return
  end
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.LongPressPetSkill, isPress)
end

local function sc_mount_roulette(isPress)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Mount, true) then
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    return
  end
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.LongPressMount, isPress)
end

local function sc_task_to_map(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.TaskToMap, isPress)
end

local function sc_long_press_scan(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.LongPressScan, isPress)
end

local function sc_pet_get(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.PetGet, isPress)
end

local function sc_pet_catalog(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.PetCatalog, isPress)
end

local function sc_library_book(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.LibraryBook, isPress)
end

local function sc_achievement(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.Achievement, isPress)
end

local function sc_journey_show(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.journeyShow, isPress)
end

local function sc_jump_gacha()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.gacha)
end

local function kibo_can_start_summon()
  if C_KiboArenaSystemMgr.isInArena then
    return false
  end
  if C_KiboDuelSystemMgr.isDraggingCard then
    return false
  end
  return true
end

local function sc_select_kibo_1(isPress)
  if not kibo_can_start_summon() then
    return
  end
  C_KiboDuelSystemMgr:HandleKiBoSummonStart(1)
end

local function sc_select_kibo_2(isPress)
  if not kibo_can_start_summon() then
    return
  end
  C_KiboDuelSystemMgr:HandleKiBoSummonStart(2)
end

local function sc_select_kibo_3(isPress)
  if not kibo_can_start_summon() then
    return
  end
  C_KiboDuelSystemMgr:HandleKiBoSummonStart(3)
end

local function sc_select_kibo_4(isPress)
  if not kibo_can_start_summon() then
    return
  end
  C_KiboDuelSystemMgr:HandleKiBoSummonStart(4)
end

local function sc_confirm_kibo(isPress)
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  if C_KiboDuelSystemMgr.isInCard then
    return
  end
  C_KiboDuelSystemMgr:HandleKiBoSummonConfirm()
end

local function sc_cancel_kibo(isPress)
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  C_KiboDuelSystemMgr:Dispatch(C_EKiboDuelEvent.CancelDragCard)
  C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
end

local function sc_confirm_kibo_skill(isPress)
  if C_AppConfigManager.IsMobilePlatformForUI then
    return
  end
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  C_KiboDuelSystemMgr:HandleConfirmSkillRelease()
end

local function sc_cancel_kibo_skill(isPress)
  if C_AppConfigManager.IsMobilePlatformForUI then
    return
  end
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  C_KiboDuelSystemMgr:HandleCancelSkillRelease()
end

local function sc_pet_duel_statistics(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.PetDuelStatistics, isPress)
end

local function sc_kibo_common_skill_1(isPress)
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  C_KiboDuelSystemMgr:ChangeSkillStatus(L_Const.skillType.KiBoVersusCommonSkill1, C_EKiboDuelSkillStatus.WaitConfirm)
end

local function sc_kibo_common_skill_2(isPress)
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  C_KiboDuelSystemMgr:ChangeSkillStatus(L_Const.skillType.KiBoVersusCommonSkill2, C_EKiboDuelSkillStatus.WaitConfirm)
end

local function sc_kibo_info_talent_prev(isPress)
  C_KiboDuelSystemMgr:HandSwitchSkillInfo(CS.Lens.Gameplay.KiboDuel.KiBoDuelInfoType.TalentPrevious)
end

local function sc_kibo_info_talent_next(isPress)
  C_KiboDuelSystemMgr:HandSwitchSkillInfo(CS.Lens.Gameplay.KiboDuel.KiBoDuelInfoType.TalentNext)
end

local function sc_kibo_info_skill_prev(isPress)
  C_KiboDuelSystemMgr:HandSwitchSkillInfo(CS.Lens.Gameplay.KiboDuel.KiBoDuelInfoType.SkillPrevious)
end

local function sc_kibo_info_skill_next(isPress)
  C_KiboDuelSystemMgr:HandSwitchSkillInfo(CS.Lens.Gameplay.KiboDuel.KiBoDuelInfoType.SkillNext)
end

local function sc_main_skill(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.KeyCodeE, isPress)
end

local function sc_kibo_duel_back(isPress)
  C_KiboDuelSystemMgr:Dispatch(C_EKiboDuelEvent.OnClickEsc)
end

local function sc_main_ultimate(isPress)
  L_ShortCutManager:sendEvent(L_ShortCutConst.event.KeyCodeR, isPress)
end

local function sc_jump_home_science(isPress)
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeScience)
end

local function sc_switch_bird_view(isPress)
  C_KiboDuelSystemMgr:OnSwitchBirdView()
end

local function sc_main_social_roulette()
  if C_KiBoDuelLuaWrapper:IsInKiBoDuel() then
    if C_KiboDuelSystemMgr:IsInNestCoop() or C_KiboArenaSystemMgr.isInArena and not C_KiboArenaSystemMgr.isPVE then
      C_KiboDuelSystemMgr:OpenSocialQuickRoulette()
    end
    return
  end
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.socialRoulette)
end

local function sc_open_product_quick()
  L_UI:open("pageProduct_Quick")
end

local function sc_cancel_swap_summon()
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  C_KiboDuelSystemMgr:HandleSwapSummonCancel()
end

local function nest_swap_confirm_guard()
  if C_KiboArenaSystemMgr.isInArena then
    return false
  end
  return true
end

local function sc_nest_swap_1()
  if not nest_swap_confirm_guard() then
    return
  end
  C_KiboDuelSystemMgr:HandleSwapSummonConfirmByIndex(1)
end

local function sc_nest_swap_2()
  if not nest_swap_confirm_guard() then
    return
  end
  C_KiboDuelSystemMgr:HandleSwapSummonConfirmByIndex(2)
end

local function sc_nest_swap_3()
  if not nest_swap_confirm_guard() then
    return
  end
  C_KiboDuelSystemMgr:HandleSwapSummonConfirmByIndex(3)
end

local function sc_open_battle_pass()
  if C_BattlePassStore.CheckShowBattlePass() and C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.battlePass) then
    L_UI:open("pageBattlePassMain")
  end
end

local function sc_open_controller_roulette_switcher()
  if AzurWorld.QuickItemMgr.isShowQuickItemBar then
    return
  end
  local curModule = L_WorldManager:getCurModule()
  if table.containsValue(L_Const.validModulesRoulette, curModule) then
    L_UI:open("pageControllerRouletteSwitcher")
  end
end

local function mch_open_page_menu()
  L_UI:open("pageMainMenu")
end

local function mch_exit_dungeon()
  AzurWorld.DungeonMgr:EscExitDungeon()
end

local function mch_exit_rogue()
  L_UI:open("pageRogueMap")
end

local function mch_exit_abbys()
  L_UI:open("pageAbbysInsideSinglePause")
end

local function mch_exit_multi_dungeon()
  AzurWorld.MultipleDungeonMgr:QuitDungeon()
end

local function mch_exit_cult_trial()
  AzurWorld.culTrialMgr:EscExitCulTrial()
end

L_ShortCutConst.shortCutMap = {
  [C_InputManager_KeyType.EMainOpenTeam] = sc_jump_formation,
  [C_InputManager_KeyType.EMainOpenBag] = sc_jump_bg,
  [C_InputManager_KeyType.EMainOpenMap] = sc_open_bigmap,
  [C_InputManager_KeyType.EMainOpenHero] = sc_jump_hero,
  [C_InputManager_KeyType.EMainScanning] = sc_send_start_scanning,
  [C_InputManager_KeyType.EMainOpenHome] = sc_home_switch,
  [C_InputManager_KeyType.EMainInput_LeaveHome] = sc_leave_home,
  [C_InputManager_KeyType.EMainTutorial] = sc_tutorial_stub,
  [C_InputManager_KeyType.EMainOpenHomeBag] = sc_open_home_bag,
  [C_InputManager_KeyType.EMainOpenTasks] = sc_jump_task,
  [C_InputManager_KeyType.EMainOpenPet] = sc_jump_pet,
  [C_InputManager_KeyType.EMainTalking] = sc_jump_chat,
  [C_InputManager_KeyType.EMainOpenActivity] = sc_jump_activation,
  [C_InputManager_KeyType.EMainOpenGameAct] = sc_jump_game_act,
  [C_InputManager_KeyType.EMainOpenEntrustTask] = sc_jump_entrust_task,
  [C_InputManager_KeyType.EMainOpenTutorial] = sc_open_tutorial_page,
  [C_InputManager_KeyType.EMainOpenNoviceTask] = sc_jump_journey_task,
  [C_InputManager_KeyType.EMainNowTask] = sc_noop,
  [C_InputManager_KeyType.EMainSwitchHero1] = sc_switch_hero_0,
  [C_InputManager_KeyType.EMainSwitchHero2] = sc_switch_hero_1,
  [C_InputManager_KeyType.EMainSwitchHero3] = sc_switch_hero_2,
  [C_InputManager_KeyType.EMainSwitchHero4] = sc_switch_hero_3,
  [C_InputManager_KeyType.EMainOneKeySwitch] = sc_noop,
  [C_InputManager_KeyType.EMainCallMount] = sc_call_mount,
  [C_InputManager_KeyType.EMainMountFly] = sc_mount_fly_stub,
  [C_InputManager_KeyType.EMainOpenAchieve] = sc_achieve_stub,
  [C_InputManager_KeyType.EMainPetSkill] = sc_pet_skill,
  [C_InputManager_KeyType.EMainPetSkillRouletteHold] = sc_pet_skill_roulette_hold,
  [C_InputManager_KeyType.EMainPetSkillRoulette] = sc_pet_skill_roulette,
  [C_InputManager_KeyType.EMainMountRoulette] = sc_mount_roulette,
  [C_InputManager_KeyType.ETaskToMap] = sc_task_to_map,
  [C_InputManager_KeyType.EMainPetCatchUseBuffItem4] = sc_long_press_scan,
  [C_InputManager_KeyType.EMainPetGet] = sc_pet_get,
  [C_InputManager_KeyType.EMainPetCatalog] = sc_pet_catalog,
  [C_InputManager_KeyType.EMainLibraryBook] = sc_library_book,
  [C_InputManager_KeyType.EMainAchievement] = sc_achievement,
  [C_InputManager_KeyType.EMainJourneyShow] = sc_journey_show,
  [C_InputManager_KeyType.EMainOpenGacha] = sc_jump_gacha,
  [C_InputManager_KeyType.ESelectKiBo1] = sc_select_kibo_1,
  [C_InputManager_KeyType.ESelectKiBo2] = sc_select_kibo_2,
  [C_InputManager_KeyType.ESelectKiBo3] = sc_select_kibo_3,
  [C_InputManager_KeyType.ESelectKiBo4] = sc_select_kibo_4,
  [C_InputManager_KeyType.EConfirmKiBo] = sc_confirm_kibo,
  [C_InputManager_KeyType.ECancelKiBo] = sc_cancel_kibo,
  [C_InputManager_KeyType.EConfirmKiBoSkill] = sc_confirm_kibo_skill,
  [C_InputManager_KeyType.ECancelKiBoSkill] = sc_cancel_kibo_skill,
  [C_InputManager_KeyType.EPetDuelStatistics] = sc_pet_duel_statistics,
  [C_InputManager_KeyType.EKiBoVersusCommonSkill1] = sc_kibo_common_skill_1,
  [C_InputManager_KeyType.EKiBoVersusCommonSkill2] = sc_kibo_common_skill_2,
  [C_InputManager_KeyType.EKiBoSkillInfoSwitch1] = sc_kibo_info_talent_prev,
  [C_InputManager_KeyType.EKiBoSkillInfoSwitch2] = sc_kibo_info_talent_next,
  [C_InputManager_KeyType.EKiBoSkillInfoSwitch3] = sc_kibo_info_skill_prev,
  [C_InputManager_KeyType.EKiBoSkillInfoSwitch4] = sc_kibo_info_skill_next,
  [C_InputManager_KeyType.EMainSkill] = sc_main_skill,
  [C_InputManager_KeyType.EKiBoDuelBack] = sc_kibo_duel_back,
  [C_InputManager_KeyType.EMainUltimateSkill] = sc_main_ultimate,
  [C_InputManager_KeyType.EMainHomeTechnology] = sc_jump_home_science,
  [C_InputManager_KeyType.ESwitchBirdView] = sc_switch_bird_view,
  [C_InputManager_KeyType.EMainSocialRoulette] = sc_main_social_roulette,
  [C_InputManager_KeyType.EMainProductQuick] = sc_open_product_quick,
  [C_InputManager_KeyType.ECancelSwapSummon] = sc_cancel_swap_summon,
  [C_InputManager_KeyType.ENestSwapSummon1] = sc_nest_swap_1,
  [C_InputManager_KeyType.ENestSwapSummon2] = sc_nest_swap_2,
  [C_InputManager_KeyType.ENestSwapSummon3] = sc_nest_swap_3,
  [C_InputManager_KeyType.EMainOpenBattlePass] = sc_open_battle_pass,
  [C_InputManager_KeyType.EMainInputControllerQuickRoulette] = sc_open_controller_roulette_switcher
}
L_ShortCutConst.shortCutMapNeedFlag = {
  [C_InputManager_KeyType.EMainMountRoulette] = true,
  [C_InputManager_KeyType.EMainTab] = true,
  [C_InputManager_KeyType.EMainPetSkillRoulette] = true
}
L_ShortCutConst.mainCityHandle = {
  openPageMenu = mch_open_page_menu,
  exitDungeon = mch_exit_dungeon,
  exitRogue = mch_exit_rogue,
  exitAbbys = mch_exit_abbys,
  exitMultiDungeon = mch_exit_multi_dungeon,
  exitCultTrial = mch_exit_cult_trial
}
L_ShortCutConst.mainCityKeyMap = {
  [C_EWorldType.World] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.MultipleWorld] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.WhiteBox] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.Prologue] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.Dungeon] = {
    menuFunc = L_ShortCutConst.mainCityHandle.exitDungeon,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.MultiDungeon] = {
    menuFunc = L_ShortCutConst.mainCityHandle.exitMultiDungeon,
    shortCutList = {
      C_InputManager_KeyType.EMainSwitchHero1,
      C_InputManager_KeyType.EMainSwitchHero2,
      C_InputManager_KeyType.EMainSwitchHero3,
      C_InputManager_KeyType.EMainOpenMap,
      C_InputManager_KeyType.EMainTalking,
      C_InputManager_KeyType.EMainCallMount,
      C_InputManager_KeyType.EMainMountFly,
      C_InputManager_KeyType.EMainPetSkill,
      C_InputManager_KeyType.EMainMountRoulette,
      C_InputManager_KeyType.EMainSocialRoulette
    }
  },
  [C_EWorldType.Rogue] = {
    menuFunc = L_ShortCutConst.mainCityHandle.exitRogue,
    shortCutList = {
      C_InputManager_KeyType.EMainSwitchHero1,
      C_InputManager_KeyType.EMainSwitchHero2,
      C_InputManager_KeyType.EMainSwitchHero3,
      C_InputManager_KeyType.EMainTalking,
      C_InputManager_KeyType.EMainScanning,
      C_InputManager_KeyType.EMainCallMount,
      C_InputManager_KeyType.EMainPetSkill,
      C_InputManager_KeyType.EMainMountRoulette,
      C_InputManager_KeyType.EMainSocialRoulette
    }
  },
  [C_EWorldType.Abyss] = {
    menuFunc = L_ShortCutConst.mainCityHandle.exitAbbys,
    shortCutList = {
      C_InputManager_KeyType.EMainSwitchHero1,
      C_InputManager_KeyType.EMainSwitchHero2,
      C_InputManager_KeyType.EMainSwitchHero3,
      C_InputManager_KeyType.EMainTalking,
      C_InputManager_KeyType.EMainScanning,
      C_InputManager_KeyType.EMainCallMount,
      C_InputManager_KeyType.EMainPetSkill,
      C_InputManager_KeyType.EMainMountRoulette,
      C_InputManager_KeyType.EMainSocialRoulette
    }
  },
  [C_EWorldType.Home] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.HomeBase] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.BigBattleWorld] = {
    shortCutList = {}
  },
  [C_EWorldType.LevelSimulator] = {
    shortCutList = {
      C_InputManager_KeyType.EMainSwitchHero1,
      C_InputManager_KeyType.EMainSwitchHero2,
      C_InputManager_KeyType.EMainSwitchHero3
    }
  },
  [C_EWorldType.KiboDuelSimulator] = {
    shortCutList = {}
  },
  [C_EWorldType.PurifySimulator] = {
    shortCutList = {}
  },
  [C_EWorldType.Interim] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.KiboDuel] = {
    shortCutList = {
      C_InputManager_KeyType.ESelectKiBo1,
      C_InputManager_KeyType.ESelectKiBo2,
      C_InputManager_KeyType.ESelectKiBo3,
      C_InputManager_KeyType.ESelectKiBo4,
      C_InputManager_KeyType.EConfirmKiBo,
      C_InputManager_KeyType.ECancelKiBo,
      C_InputManager_KeyType.EMainMountRoulette,
      C_InputManager_KeyType.EMainCallMount,
      C_InputManager_KeyType.EMainMountFly,
      C_InputManager_KeyType.EKiBoVersusCommonSkill1,
      C_InputManager_KeyType.EKiBoVersusCommonSkill2,
      C_InputManager_KeyType.EKiBoSkillInfoSwitch1,
      C_InputManager_KeyType.EKiBoSkillInfoSwitch2,
      C_InputManager_KeyType.EKiBoSkillInfoSwitch3,
      C_InputManager_KeyType.EKiBoSkillInfoSwitch4,
      C_InputManager_KeyType.EConfirmKiBoSkill,
      C_InputManager_KeyType.ECancelKiBoSkill,
      C_InputManager_KeyType.EPetDuelStatistics,
      C_InputManager_KeyType.ESwitchBirdView,
      C_InputManager_KeyType.EKiBoDuelBack,
      C_InputManager_KeyType.ECancelSwapSummon,
      C_InputManager_KeyType.ENestSwapSummon1,
      C_InputManager_KeyType.ENestSwapSummon2,
      C_InputManager_KeyType.ENestSwapSummon3,
      C_InputManager_KeyType.EMainSocialRoulette
    }
  },
  [C_EWorldType.KiboDuelArena] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.Photo] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.HomeDorm] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.HomeStory] = {
    menuFunc = L_ShortCutConst.mainCityHandle.openPageMenu,
    shortCutList = {},
    useMainCityShortCut = true
  },
  [C_EWorldType.CulTrial] = {
    menuFunc = L_ShortCutConst.mainCityHandle.exitCultTrial,
    shortCutList = {
      C_InputManager_KeyType.EMainSwitchHero1,
      C_InputManager_KeyType.EMainSwitchHero2,
      C_InputManager_KeyType.EMainSwitchHero3,
      C_InputManager_KeyType.EMainPetSkill,
      C_InputManager_KeyType.EMainSocialRoulette
    }
  }
}

local function getMainCityShortCutList()
  local res = {}
  for i, v in pairs(L_ShortCutConst.shortCutMap) do
    table.insert(res, i)
  end
  for _, v in pairs(L_ShortCutConst.mainCityKeyMap) do
    if v.useMainCityShortCut then
      v.shortCutList = res
    end
  end
end

getMainCityShortCutList()
