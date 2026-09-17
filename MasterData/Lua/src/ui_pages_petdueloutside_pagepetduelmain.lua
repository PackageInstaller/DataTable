local cls = class("pagePetDuelMain", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local _heroInterimTpl = L_GameTpl:getHeroInterimTpl()
local _kiboDuelChapterTpl = L_GameTpl:getKiBoDuelChapterTpl()
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _trialPetTpl = L_GameTpl:getTrialPetTpl()
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _kiboDuelpvpTpl = L_GameTpl:getKiboDuelPvpTpl()
local _kiboDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()
local MaxFormationNum = _gameConstTpl:getData("KIBO_DUEL_ARENA_MODE_FORMATION_NUM", L_Const.GameTplType.int)
local _scenePrefabPath = "Program/UIScene/PetDuel/pre_petDuelScene_ui_01.prefab"
local modeDefaultMapId = {
  [1] = 0,
  [2] = 0
}
local changeMapResult = {
  Succ = 1,
  Fail = 2,
  CheckFail = 3,
  Cancel = 4
}
local FormationTypeEnum = {
  PREPARE = "prepare",
  PREVIEW = "preview",
  EDIT = "edit"
}

function cls.bind()
  return {
    list_playerPetMain = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    list_playerPetFormation = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_listPlayerPet = false,
    list_enemyPet = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    modulePetDuelRecElement_prepare = {
      moduleName = "pages/petDuelOutside/modulePetDuelRecElement"
    },
    active_recELement_prepare = true,
    active_prepareBoard = true,
    active_formationBoard = false,
    leftBtnActive = true,
    rightBtnActive = true,
    active_leftList_Tips = true,
    active_leftList_GridPet = true,
    active_leftPetEmptyTip = false,
    leftPetGrid = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_petEdit = false,
    active_heroGrid = false,
    leftHeroGrid = {
      moduleName = "modulePages/cellIconUnit"
    },
    txt_curFormationName = "",
    modulePetBoxFilter = {
      moduleName = "modulePages/sortFilter/modulePetBoxFilter"
    },
    module_formationPetProperty = {
      moduleName = "pages/formation/formationModule/moduleFormationPetProperty"
    },
    module_DragKiboCard = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelEntranceNew"
    },
    active_DragKiboCard = false,
    int_petGridFocusItemIndex = 1,
    active_blockClickWhenAnimation = false,
    module_kiboDuelPlayerInfo = {
      moduleName = "pages/petDuelOutside/moduleKiboDuelPlayerInfo"
    },
    module_kiboDuelEnemyInfo = {
      moduleName = "pages/petDuelOutside/moduleKiboDuelPlayerInfo"
    },
    txt_enemyTalk = "",
    active_rootMatchNode = false,
    txt_matchTime = "",
    active_matchSucRoot = false,
    txt_startGameCounter = "",
    active_startGameRoot = false,
    active_multiBg = false,
    txt_btn = "",
    active_btnBlack = false,
    txt_cancel = "",
    active_btnCancelMatch = false,
    txt_duelTip = "",
    active_btnInvalid = false,
    active_btnCancelEdit = true,
    btnModule_cancelEdit = L_Const.ModuleInfo.ModuleBtn,
    txt_savePetEdit = "",
    module_playerReady = {
      moduleName = "pages/petDuelOutside/modulePlayerReady"
    },
    module_enemyReady = {
      moduleName = "pages/petDuelOutside/modulePlayerReady"
    },
    module_changeMap = {
      moduleName = "pages/petDuelOutside/moduleKiboDuelMapChange"
    },
    module_kiboDuelArenaNum = {
      moduleName = "pages/petDuelOutside/moduleKiboDuelArenaNum"
    },
    active_savePetEdit = true,
    active_savePetEditGrey = false,
    txt_savePetEditTip = "",
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule,
    toggle_isOnFilter = false,
    active_btnPetGridLeft = true,
    active_btnPetGridRight = true,
    active_btnPetGridLeft_ShortKey = false,
    active_btnPetGridRight_ShortKey = false
  }
end

function cls:checkCanEditFormation()
  if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_duel_block_formation"))
    return false
  end
  return true
end

function cls.methods()
  return {
    onClick_setFormation = function(self)
      if self.isPlayingAnimation then
        return
      end
      if not self:checkCanEditFormation() then
        return
      end
      if self.ready then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_22"))
        return
      end
      self.bindComponents.playerCardsAnim:Play("anim_PetDuelMain_playerContent_out")
      self.bindComponents.EnemyTalkAnim:Play("anim_PetDuelMain_EnemyTalk_out")
      L_AudioUtil.playSound("Play_SFX_System_QiboBattle_03_SetupCard_In")
      self.isPlayingAnimation = true
      Timer.once(0.3, function()
        self:switchToFormationPage()
        self:switchToPetEdit()
      end, self, self.gameObject)
    end,
    onClick_startDuel = function(self)
      if C_MultiTeam.IsInMultiTeam() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_84"))
        return
      end
      if self.isPlayingAnimation then
        return
      end
      if self.mode == L_PetConst.PetDuelFormationType.pvpMatch then
        self:onStartMatch()
      elseif self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
        self:onReady()
      elseif self.mode == L_PetConst.PetDuelFormationType.Teach then
        self.startBtnClickCall()
      else
        self:onBtnStartDuel()
      end
    end,
    onclick_cancel = function(self)
      if self.mode == L_PetConst.PetDuelFormationType.pvpMatch then
        self:onCancelMatch()
      elseif self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
        self:onCancelReady()
      end
    end,
    onClick_changeLeft_preview = function(self)
      self:onBtnChangeFormation(-1)
    end,
    onClick_changeRight_preview = function(self)
      self:onBtnChangeFormation(1)
    end,
    onClick_btnChangeHero = function(self)
      if self.isPlayingAnimation then
        return
      end
      if not self:checkCanEditFormation() then
        return
      end
      if self.ready then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_22"))
        return
      end
      self:switchToFormationPage()
      self:onBtnChangeHero(true)
    end,
    onClick_emptyArea = function(self)
      self:onClickEmpty()
    end,
    onClick_savePetEdit = function(self)
      if not self:checkCanEditFormation() then
        return
      end
      self:onEditFormation(false)
    end,
    onClick_saveHeroEdit = function(self)
      self:onBtnChangeHero(false)
    end,
    onClick_btnLeft = function(self)
      self:onBtnPageLeft()
    end,
    onClick_btnright = function(self)
      self:onBtnPageRight()
    end,
    OnClick_cancelFilter = function(self)
      self._petSortFilter:resetSortFiter(self.modules.module_sortFilter)
      self:initPetList()
      self:refreshLeftPetGrid()
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  if not L_UI:getPage("pageKiboDuelPVPEntrance") and not L_UI:getPage("pageFormationMain") then
    self.curAudioBg = L_AudioUtil.playSound("Play_Music_GamePlay_Qibo_Ring_PVP_Interface")
  end
  self.startBtnClickCall = options and options.startBtnClickCall or nil
  self.mode = options and options.mode or nil
  self.dontShowHome = options and options.dontShowHome or false
  self.dontBack2RootWhenClose = options and options.dontBack2RootWhenClose or false
  C_PetDuelArenaManager.SetCurIsRankMode(options and options.isRank)
  self.isRank = options and options.isRank
  if L_DeviceTpl:getIsPc() then
    self.bind.active_btnPetGridLeft_ShortKey = true
    self.bind.active_btnPetGridRight_ShortKey = true
  end
  self:configTouch("+")
  self.modules.module_kiboDuelArenaNum:initModule()
  local curChallengeLevelId = L_PetDuelStore:getCurChallengeLevelId()
  self.isFailureJumpFormationLocked = not options.failure_jump or C_KiboDuelSystemMgr:IsTrialDuel(curChallengeLevelId) or _kiBoDuelTpl:isKiboLock(curChallengeLevelId) or L_PetDuelStore:getIsTrailPetLevel()
  if not options.levelId then
    self.gameMode = options.gameMode or L_PetConst.PetDuelGameType.Arena
    if options.mode and (options.mode == L_PetConst.PetDuelFormationType.pvpMatch or options.mode == L_PetConst.PetDuelFormationType.pvpInvite) then
      self:handlepvpEntry(options)
      if options.mode and options.mode == L_PetConst.PetDuelFormationType.pvpMatch then
        self:handlepvpMatchEntry(options)
      elseif options.mode and options.mode == L_PetConst.PetDuelFormationType.pvpInvite then
        self:handlepvpInviteEntry(options)
      end
    else
      self:handleFormationEntry(options)
    end
  else
    self:handleDuelListEntry(options)
  end
  self:initPropertyModule()
  self:RegisterEventListeners()
  if self.hideCallback then
    self.hideCallback(true)
  end
  self:initSortFilterModule()
  self:initView()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetDuel)
end

function cls:initView()
  local moduleBtn = self.modules.btnModule_cancelEdit
  moduleBtn:setData({
    txtName = L_WordsTpl:getValue("ui_kibo_duel_back"),
    callback = function()
      self:handleSaveConfirm()
    end
  })
  self.bind.txt_savePetEdit = L_WordsTpl:getValue("ui_kibo_duel_save")
end

function cls:initSortFilterModule()
  self._isPetBoxMode = true
  if self.selectFormationSlotId ~= nil and self._lastEditFormationIndex == self.selectFormationSlotId then
    return
  end
  self._lastEditFormationIndex = self.selectFormationSlotId
  self._petSortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.formationCommonPet, function()
    self:initPetList()
    self:refreshLeftPetGrid()
  end, function()
    self:initPetList()
    self:refreshLeftPetGrid()
  end)
  self._petSortFilter:bindModule(self.modules.module_sortFilter)
end

function cls:initPetList()
  self._isPetBoxMode = self._petSortFilter.filterKeyDic[L_SortFilterConst.FilterType.Element] == nil and self._petSortFilter.filterKeyDic[L_SortFilterConst.FilterType.QiBoGrade] == nil
  self.bind.toggle_isOnFilter = not self._isPetBoxMode
  self.bind.active_btnPetGridLeft = self._isPetBoxMode
  self.bind.active_btnPetGridRight = self._isPetBoxMode
  if not self._isPetBoxMode then
    local allPet = L_PetStore:getPetList()
    self._petTotalDataList = {}
    for i, pet in pairs(allPet) do
      table.insert(self._petTotalDataList, {
        itemType = L_Const.resType.pet,
        itemId = pet.id,
        guid = pet.guid,
        groupId = 0
      })
    end
    self._petSortFilter:sortFilterList(self._petTotalDataList)
  end
  self.modules.module_formationPetProperty:showModuleInfo(false)
end

function cls:switchModeFormation(modeType, isSubFormation)
  if modeType == L_PetConst.PetDuelGameType.Battle then
    self:initFormationData()
    self.selectFormationSlotId = L_PetDuelStore:getCurPetDuelFormationSlot()
    self.modules.module_kiboDuelArenaNum:setActive(false)
    self.bind.active_savePetEdit = true
    self.bind.active_savePetEditGrey = false
    self.bind.active_btnCancelEdit = true
  elseif modeType == L_PetConst.PetDuelGameType.Arena then
    self:initArenaFormationData()
    if L_PetDuelStore:getCurPetDuelArenaFormationSlot() == L_Const.kiBoDuelBlockSlot then
      self.selectFormationSlotId = 1
    else
      self.selectFormationSlotId = L_PetDuelStore:getCurPetDuelArenaFormationSlot()
    end
    self.modules.module_kiboDuelArenaNum:setActive(true)
    self.bind.active_btnCancelEdit = false
  end
  self.gameMode = modeType
  if not self.isSubFormation then
    self.modules.module_changeMap:refreshView(self.selectMapIds[self.gameMode])
  end
  self:refreshCurSlotFormationInfo()
end

function cls:handleFormationEntry(options)
  self.isSubFormation = true
  if options.isSubFormation then
    self.closeCallback = options.callback
    self.hideCallback = options.setShowCallBack
    self.setSelectTabIdCallBack = options.setSelectTabIdCallBack
  end
  if options.changeHero then
    self.jumpToChangeHero = true
  end
  if options.failure_jump then
    self.levelId = L_PetDuelStore:getCurChallengeLevelId()
    self.kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
    self.gameMode = _kiBoDuelTpl:getDuelMode(self.kiBoDuelCfg)
  end
  L_PetDuelStore:setCurChallengeLevelId(self.levelId)
  self.levelType = self.isFailureJumpFormationLocked and L_Const.kiBoDuelLevelType.mix or L_Const.kiBoDuelLevelType.player
  self.bind.active_prepareBoard = false
  self.bind.active_formationBoard = true
  self:openPetDuelScene()
end

function cls:handlepvpEntry(options)
  L_UI:close("pageShortcutGuidePc")
  self.equalMode = false
  self.levelId = 20001
  self.dungeonId = _kiBoDuelTpl:getDungeonId(_kiBoDuelTpl:getTplById(self.levelId))
  L_PetDuelStore:setCurChallengeLevelId(self.levelId)
  self.levelType = L_Const.kiBoDuelLevelType.player
  self.bindComponents.EnemyTalk.gameObject:SetActive(false)
  self.modules.module_kiboDuelPlayerInfo:initModule_playerSelf(true)
  self.bHeroModLoaded = false
  self.bind.active_prepareBoard = true
  self.bind.active_formationBoard = false
  self.bind.active_recELement_prepare = false
  self:openPetDuelScene()
end

function cls:handlepvpMatchEntry(options)
  self.mode = L_PetConst.PetDuelFormationType.pvpMatch
  C_PetDuelArenaManager.SetCurKiboArenaMode(C_EKiboArenaMode.pvpMatch)
  self.bNpcModLoaded = true
  self.bind.txt_btn = L_WordsTpl:getValue("residual_code_moduleviewteamready_01")
  self.bind.txt_cancel = L_WordsTpl:getValue("residual_code_moduleviewteamready_02")
end

function cls:handlepvpInviteEntry(options)
  self.dungeonId = 0
  self.bNpcModLoaded = false
  self.mode = L_PetConst.PetDuelFormationType.pvpInvite
  C_PetDuelArenaManager.SetCurKiboArenaMode(C_EKiboArenaMode.pvpInvite)
  self:initMapId2DungeonId()
  self.enemyPlayerId = C_PetDuelArenaManager.GetPetDuelArenaPvpEnemyPlayerId()
  self.selectMapIds = {
    [L_PetConst.PetDuelGameType.Battle] = modeDefaultMapId[L_PetConst.PetDuelGameType.Battle],
    [L_PetConst.PetDuelGameType.Arena] = modeDefaultMapId[L_PetConst.PetDuelGameType.Arena]
  }
  L_PetDuelStore:changePetDuelMap(self.selectMapIds[self.gameMode])
  self.modules.module_enemyReady:initModule(L_PetConst.PetDuelPlayerState.unReady, self.enemyPlayerId)
  self.modules.module_playerReady:initModule(L_PetConst.PetDuelPlayerState.unReady, L_PlayerStore:getPlayerId())
  self.modules.module_changeMap:initModule(self.selectMapIds[self.gameMode], function()
    if self.enemyUIStatus == L_PetConst.PetDuelPlayerState.MapEdit then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_24"))
      return
    end
    if self.ready then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_22"))
      return
    end
    self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.MapEdit)
    L_UI:open("pagePetDuelChangeMap", {
      mapId = self.selectMapIds[self.gameMode],
      gameMode = self.gameMode,
      callback = function(id, dungeonId)
        if id == self.selectMapIds[self.gameMode] then
          return
        end
        C_PetDuelArenaManager.ReqChangeMap(dungeonId, false)
        self.changeMapTarget = dungeonId
      end,
      close_callback = function()
        self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.unReady)
      end
    })
  end)
  self.modules.module_changeMap:setActive(true)
  self.bind.txt_btn = L_WordsTpl:getValue("residual_code_moduleviewteamready_03")
  self.bind.txt_cancel = L_WordsTpl:getValue("residual_code_moduleviewteamready_04")
  if self.enemyPlayerId then
    self.modules.module_kiboDuelEnemyInfo:initModule_pvpEnemy(self.enemyPlayerId)
  end
end

function cls:initMapId2DungeonId()
  local dungeonData = _dungeonTpl:getKiboArenaPvpDungeonData()
  self.mapId2dungeonId = {}
  self.dungeonId2mapId = {}
  self.mapId2dungeonId[0] = 0
  self.dungeonId2mapId[0] = 0
  for _, dungeon in pairs(dungeonData) do
    local pvpId = _dungeonTpl:getgameplayID(dungeon)
    local conf = _kiboDuelpvpTpl:getTplById(pvpId)
    if conf ~= nil then
      local mapId = _kiboDuelpvpTpl:getMap(conf)
      self.mapId2dungeonId[mapId] = dungeon.id
      self.dungeonId2mapId[dungeon.id] = mapId
    end
  end
end

function cls:handleDuelListEntry(options)
  self.mode = L_PetConst.PetDuelFormationType.Normal
  C_PetDuelArenaManager.SetCurKiboArenaMode(C_EKiboArenaMode.pve)
  self.levelId = options.levelId
  self.dungeonId = _kiBoDuelTpl:getDungeonId(_kiBoDuelTpl:getTplById(self.levelId))
  self.isRestore = options.isRestore
  self.levelMode = options.levelMode
  self.restorePage = options.pageName
  L_PetDuelStore:setCurChallengeLevelId(self.levelId)
  self.kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  if not self.kiBoDuelCfg then
    errorf("kiBoDuelCfg is nil, levelId: " .. tostring(self.levelId))
  end
  self.levelType = _kiBoDuelTpl:getLevelType(self.kiBoDuelCfg)
  self.gameMode = _kiBoDuelTpl:getDuelMode(self.kiBoDuelCfg)
  self.bind.txt_btn = L_WordsTpl:getValue("ui_kiboDuel_41")
  self.bHeroModLoaded = false
  self.bNpcModLoaded = false
  self.modules.modulePetDuelRecElement_prepare:initModule(self.levelId)
  self.modules.modulePetDuelRecElement_prepare:setRecLevel(self.levelId)
  self.bind.active_prepareBoard = true
  self.bind.active_formationBoard = false
  local levelTalk = _kiBoDuelTpl:getLevelTalk(self.kiBoDuelCfg)
  if self.bindComponents.EnemyTalk then
    self.bindComponents.EnemyTalk.gameObject:SetActive(not string.isEmpty(levelTalk))
  end
  self.bind.txt_enemyTalk = levelTalk
  self:initDuelDetail()
  self:openPetDuelScene()
end

function cls:initPropertyModule()
  self.modules.module_formationPetProperty:openDetailBtn()
  self.modules.module_formationPetProperty:showModuleInfo(false)
  self.modules.module_formationPetProperty:checkTipsHeight(true)
  self.modules.module_formationPetProperty:setKiboFormationState()
  self._onPointEnterPetCellHandler = handler(self, self.onPointEnterPetCell)
  self._onPointExitPetCellHandler = handler(self, self.onPointExitPetCell)
end

function cls:RegisterEventListeners()
  L_PetStore:listenCallFunc(L_PetStore.event.closePetBox, self.onClosePetBox, self)
  self.onSyncPvpMatchSucessHandler = self.onSyncPvpMatchSucessHandler or handler(self, self.onSyncPvpMatchSucess)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpMatchSucess, self.onSyncPvpMatchSucessHandler)
  self.onSyncPvpLeaveRoomHandler = self.onSyncPvpLeaveRoomHandler or handler(self, self.onSyncPvpLeaveRoom)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpLeaveRoom, self.onSyncPvpLeaveRoomHandler)
  self.onSyncPvpChangeMapReqHandler = self.onSyncPvpChangeMapReqHandler or handler(self, self.onSyncPvpChangeMapReq)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeMapReq, self.onSyncPvpChangeMapReqHandler)
  self.onSyncPvpChangeMapReplyHandler = self.onSyncPvpChangeMapReplyHandler or handler(self, self.onSyncPvpChangeMapReply)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeMapReply, self.onSyncPvpChangeMapReplyHandler)
  self.onSyncPvpChangeUIStatusHandler = self.onSyncPvpChangeUIStatusHandler or handler(self, self.onSyncPvpChangeUIStatus)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeUIStatus, self.onSyncPvpChangeUIStatusHandler)
  self.onSyncPvpChangeFormationHandler = self.onSyncPvpChangeFormationHandler or handler(self, self.onSyncPvpChangeFormation)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeFormation, self.onSyncPvpChangeFormationHandler)
  self.onSyncPvpChangeHeroHandler = self.onSyncPvpChangeHeroHandler or handler(self, self.onSyncPvpChangeHero)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeHero, self.onSyncPvpChangeHeroHandler)
  self.onKiboArenaRankActivityEndHandler = self.onKiboArenaRankActivityEndHandler or handler(self, self.onKiboArenaRankActivityEnd)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.KiboArenaRankActivityEnd, self.onKiboArenaRankActivityEndHandler)
  AzurWorld.HUDMgr:SetAllVisible(false, "pagePetDuelMain")
end

function cls:unRegisterEventListeners()
  L_PetStore:unListenCallFunc(L_PetStore.event.closePetBox, self.onClosePetBox, self)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpMatchSucess, self.onSyncPvpMatchSucessHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpLeaveRoom, self.onSyncPvpLeaveRoomHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeMapReq, self.onSyncPvpChangeMapReqHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeMapReply, self.onSyncPvpChangeMapReplyHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeUIStatus, self.onSyncPvpChangeUIStatusHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeFormation, self.onSyncPvpChangeFormationHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SyncPvpChangeHero, self.onSyncPvpChangeHeroHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.KiboArenaRankActivityEnd, self.onKiboArenaRankActivityEndHandler)
  AzurWorld.HUDMgr:SetAllVisible(true, "pagePetDuelMain")
end

function cls:onTopBarRefresh()
  self:initCommonTopModule()
end

function cls:initCommonTopModule()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(handler(self, self.escHandle))
  C_IntegrateMgr.TopBarModule:SetTopBarMainBtnFunc(handler(self, self.backToMainHandle))
  if self.isSubFormation then
    C_IntegrateMgr.TopBarModule:SetTopBarBackName(L_WordsTpl:getValue("ui_systemMessage_17"))
  end
  if self.isFormationPage or self.isSubFormation or self.dontShowHome then
    C_IntegrateMgr.TopBarModule:SetTopBarMainBtnVisible(false)
  end
end

function cls:initPlayerFormation()
  if self.gameMode == L_PetConst.PetDuelGameType.Battle then
    self.modules.module_kiboDuelArenaNum:setActive(false)
    self:initFormationData()
    self.selectFormationSlotId = L_PetDuelStore:getCurPetDuelFormationSlot()
  elseif self.gameMode == L_PetConst.PetDuelGameType.Arena then
    self:initArenaFormationData()
    self.modules.module_kiboDuelArenaNum:setActive(true)
    self.bind.active_btnCancelEdit = false
    self.selectFormationSlotId = L_PetDuelStore:getCurPetDuelArenaFormationSlot()
  end
  if self.selectFormationSlotId == L_Const.kiBoDuelBlockSlot or self.selectFormationSlotId < 1 or self.selectFormationSlotId > MaxFormationNum then
    self.selectFormationSlotId = 1
  end
  if self.levelId then
    if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
      self.selectFormationSlotId = L_Const.kiBoDuelBlockSlot
      self:initTrialFormation(L_Const.kiBoDuelBlockSlot)
    elseif _kiBoDuelTpl:isKiboLock(self.levelId) then
      self.selectFormationSlotId = L_Const.kiBoDuelBlockSlot
      if self.gameMode == L_PetConst.PetDuelGameType.Battle then
        self:refreshLockFormationInfo(L_Const.kiBoDuelBlockSlot)
      elseif self.gameMode == L_PetConst.PetDuelGameType.Arena then
        self:refreshLockArenaFormationInfo(L_Const.kiBoDuelBlockSlot)
      end
    elseif L_PetDuelStore:getIsTrailPetLevel() then
      self.selectFormationSlotId = L_Const.kiBoDuelBlockSlot
      self:refreshEmptyFormationInfo(L_Const.kiBoDuelBlockSlot)
    end
  end
  self:applyFormationSlot()
  self.bind.leftBtnActive = self.selectFormationSlotId ~= L_Const.kiBoDuelBlockSlot
  self.bind.rightBtnActive = self.selectFormationSlotId ~= L_Const.kiBoDuelBlockSlot
  if self.gameMode == L_PetConst.PetDuelGameType.Arena then
    self:checkStartMatchCondition()
  else
    self:checkStartDuelCondition()
  end
  self:initModulePetBoxFilter()
  self:repeatCheck()
  self:refreshCurSlotFormationInfo()
end

function cls:initDuelDetail()
  self.modules.module_kiboDuelPlayerInfo:initModule_playerSelf(false)
  self.modules.module_kiboDuelEnemyInfo:initModule_npcEnmey(self.levelId)
end

function cls:refreshCurSlotFormationInfo()
  self.selectSlotId = 1
  self.selectHeroGuid = -1
  if self.selectFormationSlotId == L_Const.kiBoDuelBlockSlot then
    self.bind.txt_curFormationName = L_WordsTpl:getValue("residual_code_pagepetduelformationnew_02")
  else
    self.bind.txt_curFormationName = L_WordsTpl:getValue("residual_code_pagepetduelformationnew_03", {
      [0] = self.selectFormationSlotId
    })
  end
  self:refreshPlayerFormationInfo()
  self:refreshHeroShow(false)
end

function cls:initFormationData()
  self.curFormationPetData = {}
  self.curFormationHeroData = {}
  self.curFormationSkillData = {}
  for slotId = 1, MaxFormationNum do
    local petUids = {}
    for _, v in ipairs(L_PetDuelStore:getPetDuelFormationPetGuids(slotId)) do
      table.insert(petUids, {
        is_trial = v.is_trial,
        id = v.id
      })
    end
    self.curFormationPetData[slotId] = petUids
    self.curFormationHeroData[slotId] = L_PetDuelStore:getPetDuelFormationHeroGuid(slotId)
    local skills = {}
    for _, v in ipairs(L_PetDuelStore:getPetDuelFormationHeroSkills(slotId)) do
      table.insert(skills, table.clone(v))
    end
    self.curFormationSkillData[slotId] = skills
  end
end

function cls:initArenaFormationData()
  self.curFormationPetData = {}
  self.curFormationHeroData = {}
  self.curFormationSkillData = {}
  for slotId = 1, MaxFormationNum do
    local petUids = {}
    for _, v in ipairs(L_PetDuelStore:getPetDuelArenaFormationPetGuids(slotId)) do
      table.insert(petUids, {
        is_trial = v.is_trial,
        id = v.id
      })
    end
    self.curFormationPetData[slotId] = petUids
    self.curFormationHeroData[slotId] = L_PetDuelStore:getPetDuelArenaFormationHeroGuid(slotId)
    local skills = {}
    for _, v in ipairs(L_PetDuelStore:getPetDuelArenaFormationHeroSkills(slotId)) do
      table.insert(skills, table.clone(v))
    end
    self.curFormationSkillData[slotId] = skills
  end
end

function cls:revertArenaFormationSlotData(slot)
  local petUids = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelArenaFormationPetGuids(slot)) do
    table.insert(petUids, {
      is_trial = v.is_trial,
      id = v.id
    })
  end
  self.curFormationPetData[slot] = petUids
  self:refreshPlayerFormationInfo()
end

function cls:initTrialFormation(slotId)
  local tpl = _kiBoDuelTpl:getTplById(self.levelId)
  if not tpl then
    errorf("kiBoDuelCfg is nil, levelId: " .. tostring(self.levelId))
    return
  end
  local petUids = {}
  local trialPets = _kiBoDuelTpl:getKiboList(tpl)
  for _, v in ipairs(trialPets) do
    table.insert(petUids, {is_trial = true, id = v})
  end
  if #trialPets < 8 then
    for i = 1, 8 - #trialPets do
      table.insert(petUids, {is_trial = false, id = 0})
    end
  end
  self.curFormationPetData[slotId] = petUids
  local trialRole = _kiBoDuelTpl:getTrialRole(tpl)
  local heroConfigId = L_GameUtil.getDefaultHeroId(L_PlayerStore:getSex())
  if not math.isEmpty(trialRole) then
    local trialRoleTpl = _heroInterimTpl:getTplById(trialRole)
    heroConfigId = _heroInterimTpl:getHeroId(trialRoleTpl)
  end
  self.curFormationHeroData[slotId] = heroConfigId
  local skills = {}
  for _, v in ipairs(_kiBoDuelTpl:getSkillList(tpl)) do
    table.insert(skills, table.clone(v))
  end
  self.curFormationSkillData[slotId] = skills
end

function cls:initBlockFormation(slotId)
  local petUids = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelFormationPetGuids(slotId)) do
    table.insert(petUids, {
      is_trial = v.is_trial,
      id = v.id
    })
  end
  self.curFormationPetData[slotId] = petUids
  self.curFormationHeroData[slotId] = L_PetDuelStore:getPetDuelFormationHeroGuid(slotId)
  local skills = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelFormationHeroSkills(slotId)) do
    table.insert(skills, table.clone(v))
  end
  self.curFormationSkillData[slotId] = skills
end

function cls:initModulePetBoxFilter()
  self.modules.modulePetBoxFilter:initPetBoxFilterModule(L_PetConst.PetBoxFilterEnums.PetDuel, function(selectBoxIndex)
    self:onRspPetBoxSelectCallBack(selectBoxIndex)
  end)
end

function cls:regisShortCut()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ENextPetBox, function()
    if self.isDrag or not self._isPetBoxMode then
      return
    end
    if self.bind.active_petEdit then
      self:onBtnPageRight()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ELastPetBox, function()
    if self.isDrag or not self._isPetBoxMode then
      return
    end
    if self.bind.active_petEdit then
      self:onBtnPageLeft()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.LookPetSkillTip, function()
    if self.modules.module_formationPetProperty.bind.go_content then
      self.modules.module_formationPetProperty:ShowBattleSkillDetail()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.LookBattleDuelTagTip, function()
    if self.modules.module_formationPetProperty.bind.go_content then
      self.modules.module_formationPetProperty:ShowGeneSkillDetail()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.LookPetBattleTagTip, function()
    if self.modules.module_formationPetProperty.bind.go_content then
      self.modules.module_formationPetProperty:onSwitchPetSkillTagInfo()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.SwitchPetSkillDetail, function()
    if self.modules.module_formationPetProperty.bind.go_content then
      self.modules.module_formationPetProperty:onSwitchPetSkillDetail()
    end
  end)
end

function cls:switchPage(isFormation)
  self.bind.active_prepareBoard = not isFormation
  self.bind.active_formationBoard = isFormation
  self.isFormationPage = isFormation
  if isFormation then
    self:SetNpcHeroModelShow(false)
  else
    self:SetNpcHeroModelShow(true)
    if self.gameMode == L_PetConst.PetDuelGameType.Arena then
      self:checkStartMatchCondition()
    end
    self:checkStartDuelCondition()
  end
  self:refreshPlayerFormationInfo()
end

function cls:SetNpcHeroModelShow(isShow)
  L_CommonUtil.setObjActive(self.npcParent.gameObject, isShow)
end

function cls:switchToFormationPage()
  self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.Formation)
  self:switchPage(true)
end

function cls:switchToPetEdit()
  self.selectSlotId = 1
  for i = 1, #self.bind.list_playerPetFormation do
    self.bind.list_playerPetFormation:change(i, {
      selectSlotId = self.selectSlotId
    })
  end
  self.modules.modulePetBoxFilter:changeIndexOutside(1)
  self:onEditFormation(true)
  self:refreshLeftPetGrid()
end

function cls:onRspPetBoxSelectCallBack(selectBoxIndex)
  self.selectPetBoxIndex = selectBoxIndex
  self:refreshLeftPetGrid()
end

function cls:refreshPlayerCardBack()
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  for i, v in ipairs(self.modules.list_playerPetFormation) do
    local module = v
    module:refreshBackImg_Out(curFormationPetGuids[i].id)
  end
end

function cls:getPlayerFormationPetList()
  local petItems = {}
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  self:refreshPetCostNum()
  for i = 1, #curFormationPetGuids do
    local info = curFormationPetGuids[i]
    local isOwn = false
    if L_PetStore.isOwnPet then
      isOwn = L_PetStore:isOwnPet(info.id)
    else
      isOwn = L_PetStore:getPetItem(info.id) ~= nil
    end
    if info.id > 0 and not info.is_trial and not isOwn then
      info.id = 0
    end
  end
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  local curRepeatParamList = L_PetDuelStore:getRepeatPetParam(curFormationPetGuids)
  for i = 1, 8 do
    local info = curFormationPetGuids[i]
    local isForbidden = false
    isForbidden = not L_PetDuelStore:checkPetValid(info, self.levelId) or curRepeatParamList[i] and self.gameMode == L_PetConst.PetDuelGameType.Arena and _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 0
    table.insert(petItems, {
      slotId = i,
      petGuid = info.id,
      is_trial = info.is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
  return petItems
end

function cls:getTeachPlayerFormationPetList()
  local petItems = {}
  local cfg = _kiBoDuelTpl:getTplById(self.levelId)
  local trialPetCfgIds = _kiBoDuelTpl:getKiboList(cfg)
  local count = #trialPetCfgIds
  for i = 1, 8 do
    local trialPetCfgId
    if i <= count then
      trialPetCfgId = trialPetCfgIds[i]
    end
    table.insert(petItems, {
      isForbidden = false,
      slot = i,
      trialPetCfgId = trialPetCfgId,
      petGuid = 0,
      isTeachMode = true
    })
  end
  return petItems
end

function cls:refreshPlayerFormationInfo()
  local petItems
  if self.mode == L_PetConst.PetDuelFormationType.Teach then
    petItems = self:getTeachPlayerFormationPetList()
  else
    petItems = self:getPlayerFormationPetList()
  end
  if self.isFormationPage then
    self.bind.list_playerPetFormation:clear()
    self.bind.list_playerPetFormation:insert_array(petItems)
    local formationType = FormationTypeEnum.EDIT
    self:refreshPlayerFormationCallback(formationType)
  elseif not self.isSubFormationthen then
    self.bind.list_playerPetMain:clear()
    self.bind.list_playerPetMain:insert_array(petItems)
    self:refreshPlayerFormationCallback(FormationTypeEnum.PREPARE)
  end
end

function cls:refreshPlayerFormationCallback(formationType)
  local function onClick_prepareFormation(cell)
    if self.isPlayingAnimation then
      return
    end
    if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_duel_block_formation"))
      return
    end
    if self.ready then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_22"))
      return
    end
    self.selectSlotId = cell.bind.slotId
    self.selectPetGuid = cell.bind.petGuid
    for i = 1, #self.bind.list_playerPetFormation do
      self.bind.list_playerPetFormation:change(i, {
        selectSlotId = self.selectSlotId
      })
    end
    local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
    if curSelectPetGuid == 0 or cell.bind.is_trial then
      local curSelectBoxIndex = 1
      self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
    else
      local petItem = L_PetStore:getPetItem(curSelectPetGuid)
      local curSelectBoxIndex = petItem.box_id // 100
      self.modules.modulePetBoxFilter:changeIndexOutside(curSelectBoxIndex)
    end
    self.bindComponents.playerCardsAnim:Play("anim_PetDuelMain_playerContent_out")
    self.bindComponents.EnemyTalkAnim:Play("anim_PetDuelMain_EnemyTalk_out")
    L_AudioUtil.playSound("Play_SFX_System_QiboBattle_03_SetupCard_In")
    self.isPlayingAnimation = true
    Timer.once(0.3, function()
      self:switchToFormationPage()
      self:onEditFormation(true)
    end, self, self.gameObject)
    self:refreshLeftPetGrid()
  end
  
  local function onClick_previewFormation()
    self:checkCanEditFormation()
  end
  
  local function onClick_editFormation(cell)
    if self.isDrag then
      return
    end
    self.selectSlotId = cell.bind.slotId
    self.selectPetGuid = cell.bind.petGuid
    for i = 1, #self.bind.list_playerPetFormation do
      self.bind.list_playerPetFormation:change(i, {
        selectSlotId = self.selectSlotId
      })
    end
    if not cell.bind.is_trial and cell.bind.petGuid > 0 then
      self:showPetProperty(cell:getRaycastGo(), cell.bind.petGuid)
    elseif cell.bind.is_trial or cell.bind.petGuid <= 0 then
      self.modules.module_formationPetProperty:showModuleInfo(false)
      self.modules.module_formationPetProperty:checkTipsHeight(true)
    end
    self:refreshLeftPetGridLit()
  end
  
  local function onClick_removeFromFormation(cell)
    self.selectSlotId = cell.bind.slotId
    self:onBtnCancelFormation()
    self.modules.module_formationPetProperty:showModuleInfo(false)
    self.modules.module_formationPetProperty:checkTipsHeight(true)
  end
  
  if formationType == FormationTypeEnum.PREPARE then
    for i = 1, #self.bind.list_playerPetMain do
      self.bind.list_playerPetMain:change(i, {
        cellMode = L_PetConst.PetDuelEntranceCellMode.PrepareSelf,
        callback = onClick_prepareFormation
      })
    end
  elseif formationType == FormationTypeEnum.EDIT then
    for i = 1, #self.bind.list_playerPetFormation do
      self.bind.list_playerPetFormation:change(i, {
        cellMode = L_PetConst.PetDuelEntranceCellMode.FormationSlot,
        callback = onClick_editFormation,
        callback_remove = onClick_removeFromFormation,
        pointEnterCallback = self._onPointEnterPetCellHandler,
        pointExitCallback = self._onPointExitPetCellHandler
      })
    end
  elseif formationType == FormationTypeEnum.PREVIEW then
    for i = 1, #self.bind.list_playerPetFormation do
      self.bind.list_playerPetFormation:change(i, {
        cellMode = L_PetConst.PetDuelEntranceCellMode.FormationPreviewSlot,
        callback = onClick_previewFormation
      })
    end
  end
end

function cls:changePetFormation(dstPetUid, isTrial)
  local dstSlot = self:getPetSlot(dstPetUid, isTrial)
  if _kiBoDuelTpl:isKiboLock(self.levelId) then
    local info = L_PetDuelStore:getPetDuelArenaFormationGroupInfo(L_PetDuelStore:getCurPetDuelArenaFormationSlot())
    if info ~= nil and self.selectSlotId <= info.lockSlot then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_cannt_formation"))
      return
    end
    if 0 < dstSlot and info ~= nil and dstSlot <= info.lockSlot then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_cannt_formation"))
      return
    end
  end
  local curSelectUid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local curSelectIsTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  if curSelectUid <= 0 then
    self.isBlankSlot = true
  else
    self.isBlankSlot = false
  end
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id = dstPetUid
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial = isTrial
  if 0 < dstSlot then
    self.curFormationPetData[self.selectFormationSlotId][dstSlot].id = curSelectUid
    self.curFormationPetData[self.selectFormationSlotId][dstSlot].is_trial = curSelectIsTrial
  end
  self:refreshPetCostNum()
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  local curRepeatParamList = L_PetDuelStore:getRepeatPetParam(curFormationPetGuids)
  local isFound = false
  for i = self.selectSlotId, 8 do
    if 0 >= curFormationPetGuids[i].id and self.isBlankSlot then
      self.selectSlotId = i
      isFound = true
      break
    end
  end
  if not isFound then
    for i = 1, self.selectSlotId do
      if 0 >= curFormationPetGuids[i].id and self.isBlankSlot then
        self.selectSlotId = i
        break
      end
    end
  end
  for i = 1, #self.bind.list_playerPetFormation do
    local isForbidden = not L_PetDuelStore:checkPetValid(curFormationPetGuids[i], self.levelId) or curRepeatParamList[i] and self.gameMode == L_PetConst.PetDuelGameType.Arena and _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 0
    self.bind.list_playerPetFormation:change(i, {
      selectSlotId = self.selectSlotId,
      petGuid = curFormationPetGuids[i].id,
      is_trial = curFormationPetGuids[i].is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
end

function cls:refreshLeftPetGridLit()
  local petList = self:getCurPetList()
  for i, v in ipairs(petList) do
    self.bind.leftPetGrid:change(i, {
      petGuid = v.id,
      is_trial = v.is_trial,
      slotId = self:getPetSlot(v.id, v.is_trial),
      selectSlotId = self.selectSlotId
    })
  end
end

function cls:refreshLeftPetGrid()
  local function onClick_select(cell)
    if not self:checkCanEditFormation() then
      return
    end
    local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
    local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
    if 0 < curSelectPetGuid and curSelectPetGuid == cell.petGuid and not isTrial == not cell.isTrial then
      self:onBtnCancelFormation()
      self.modules.module_formationPetProperty:showModuleInfo(false)
      self.modules.module_formationPetProperty:checkTipsHeight(true)
      return
    else
      if self.gameMode == L_PetConst.PetDuelGameType.Arena and L_PetDuelStore:checkKiboRepeat(cell.isTrial, cell.petGuid, self.selectSlotId, self.curFormationPetData[self.selectFormationSlotId]) then
        cell:playShakeAnim()
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_11"))
        return
      end
      self:changePetFormation(cell.petGuid, cell.isTrial)
      self:refreshLeftPetGridLit()
    end
    if not cell.bind.is_trial then
      self:showPetProperty(cell:getRaycastGo(), cell.bind.petGuid)
    end
  end
  
  local function onClick_remove(cell)
    self.selectSlotId = cell.bind.slotId
    self:onBtnCancelFormation()
    self.modules.module_formationPetProperty:showModuleInfo(false)
    self.modules.module_formationPetProperty:checkTipsHeight(true)
  end
  
  if self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId] == nil then
    return
  end
  self:refreshPetCostNum()
  local curSelectPetGuid = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id
  local isTrial = self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial
  local petList = self:getCurPetList()
  local petCount = #petList
  self.bind.active_leftList_Tips = 0 < petCount
  self.bind.active_leftList_GridPet = 0 < petCount
  self.bind.active_leftPetEmptyTip = petCount < 1
  if curSelectPetGuid <= 0 and petCount < 1 then
    return
  end
  local petItems = {}
  for i, v in ipairs(petList) do
    local isForbidden = not L_PetDuelStore:checkPetValid(v, self.levelId)
    table.insert(petItems, {
      petGuid = v.id,
      is_trial = v.is_trial,
      slotId = self:getPetSlot(v.id, v.is_trial),
      selectSlotId = self.selectSlotId,
      callback = onClick_select,
      callback_remove = onClick_remove,
      pointEnterCallback = self._onPointEnterPetCellHandler,
      pointExitCallback = self._onPointExitPetCellHandler,
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationPetPool,
      isForbidden = isForbidden
    })
  end
  self.bind.leftPetGrid:clear()
  self.bind.leftPetGrid:insert_array(petItems)
  for index, v in ipairs(petItems) do
    if v.petGuid == self.selectPetGuid then
      self.bind.int_petGridFocusItemIndex = index
    end
  end
end

function cls:refreshHeroShow(bSwitch)
  local curHeroGuid = self.curFormationHeroData[self.selectFormationSlotId]
  if 0 < curHeroGuid and curHeroGuid == self.selectHeroGuid then
    return
  end
  if curHeroGuid <= 0 and 0 >= self.selectHeroGuid then
    self.selectHeroGuid = L_HeroStore:getDefaultHeroGuid()
  end
  if 0 >= self.selectHeroGuid then
    self.selectHeroGuid = self.curFormationHeroData[self.selectFormationSlotId]
  end
  self.curFormationHeroData[self.selectFormationSlotId] = self.selectHeroGuid
  self:refreshHeroModel(bSwitch)
end

function cls:refreshHeroModel(bSwitch)
  local heroCfg, heroGuid
  if self.selectFormationSlotId == L_Const.kiBoDuelBlockSlot and not bSwitch and C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
    heroGuid = self.selectHeroGuid
    heroCfg = _heroTpl:getTplById(self.selectHeroGuid)
  else
    local heroInfo = L_HeroStore:getHero(self.selectHeroGuid)
    if not heroInfo then
      errorf("英雄数据不存在 heroGuid = " .. tostring(self.selectHeroGuid))
      return
    else
      heroGuid = L_HeroStore:getHeroConfigId(heroInfo)
      heroCfg = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(heroInfo))
    end
  end
  self.selectHeroConfigId = heroGuid
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(self.selectHeroGuid, heroCfg.id)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local unitID = heroClothingTpl:getUnitId(heroClothingTpl:getTplById(clothingId))
  if not unitID then
    return
  end
  local unit = _unitTpl:getTplById(unitID)
  local path = _unitTpl:getModel(unit, 1)
  path = L_GameUtil.getAvatarModelPathByUnitId(unitID, L_Const.avatarModelIndex.UnitModel)
  self.curRotation = _heroTpl:getKiBoDuelFormationHeroTransEuler(heroCfg)
  local tmpRotation = self.curRotation
  
  local function loadHeroCallback()
    self.characterAnchorFit = self.heroParent:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
    if bSwitch then
      self.characterAnchorFit.followTrans = self.bindComponents.modelHeadRoot_edit
    else
      self.characterAnchorFit.followTrans = self.bindComponents.playerModelHeadRoot
    end
    if self.jumpToChangeHero then
      self.jumpToChangeHero = false
      self:onBtnChangeHero(true)
    end
    self:findHeroModel()
    self:SetCharacterPosition()
    self.isLoadingHero = false
    self.bHeroModLoaded = true
    if self.bHeroModLoaded and self.bNpcModLoaded and not self.binit then
      self.binit = true
      self:loadModelCallBack()
    elseif self.bHeroModLoaded and not self.binit and self.isSubFormation then
      self.binit = true
      Timer.once(0.1, function()
        C_UIMgr.CloseCutin()
      end, self, self.gameObject)
    end
    if bSwitch then
      self:loadEffectModel(heroGuid, self.heroParent, _heroTpl:getKiBoDuelFormationHeroTransOffset(heroCfg))
      L_AudioUtil.playSound("Play_SFX_System_QiboBattle_07_SetupCharacter_Select")
    end
  end
  
  self.isLoadingHero = true
  L_UIModelMgr:LoadHeroModelAsync(path, _heroTpl:getKiBoDuelFormationHeroTransOffset(heroCfg), tmpRotation, _heroTpl:getKiBoDuelHeroPrepareTransScale(heroCfg), function(go)
    self.biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), go)
    if self.biologyData then
      self.biologyData.isSync = true
    end
    local isPlayerHero = self.selectHeroGuid == L_HeroStore:getDefaultHeroGuid()
    if self.entity then
      self.entity:onDestroy()
    end
    local needAnimaList = {"KiboDuelUi"}
    self.entity = L_EntityManager:generateSimpleHero(heroGuid, go, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.PetDuel)
    self.entity.playableAnimator:Play("KiboDuelUi")
    loadHeroCallback()
  end, self.heroParent)
end

function cls:SetCharacterPosition()
  if self.heroModel == nil then
    return
  end
  if self.characterAnchorFit then
    local initPos, initRotate, initScale, configHeight
    local heroCfg = _heroTpl:getTplById(self.selectHeroConfigId)
    if heroCfg == nil then
      return
    end
    if not self.bind.active_heroGrid then
      configHeight = _heroTpl:getKiBoDuelHeroPrepareTransYOffset(heroCfg).y
      initPos = _heroTpl:getKiBoDuelHeroPrepareTransXZOffset(heroCfg)
      initRotate = _heroTpl:getKiBoDuelHeroPrepareTransEuler(heroCfg)
      initScale = _heroTpl:getKiBoDuelHeroPrepareTransScale(heroCfg)
    else
      configHeight = _heroTpl:getKiBoDuelFormationHeroTransYOffset(heroCfg).y
      initPos = _heroTpl:getKiBoDuelFormationHeroTransXZOffset(heroCfg)
      initRotate = _heroTpl:getKiBoDuelFormationHeroTransEuler(heroCfg)
      initScale = _heroTpl:getKiBoDuelFormationHeroTransScale(heroCfg)
    end
    if L_DeviceTpl:getIsMobile() then
      configHeight = configHeight + 0.1
    end
    self.characterAnchorFit:SetModelHeight(configHeight)
    L_Vector3.setLocalPos(self.heroModel.transform, initPos)
    L_Vector3.setRot(self.heroModel.transform, initRotate)
    L_Vector3.setScale(self.heroModel.transform, initScale)
  end
end

function cls:loadNpcEffectModel(heroCfgId, heroParent, heroPos)
  local tpl = _heroTpl:getTplById(heroCfgId)
  local elementId = _heroTpl:getElement(tpl)
  if elementId ~= self.lastNpcElementId then
    self:recycleNpcEffectModel()
    self.lastNpcElementId = elementId
  end
  if not L_CommonUtil.isValid(self.heroNpcSwitchEft) then
    local tpl_ele = _elementTpl:getTplById(elementId)
    local path = _elementTpl:getAdmissioneffects(tpl_ele)
    self.heroNpcSwitchEft = L_ResPool:syncGameObject(path)
    self.heroNpcSwitchEft.transform:SetParent(heroParent)
    L_Vector3.setLocalPos(self.heroNpcSwitchEft.transform, heroPos)
  else
    self.heroNpcSwitchEft:ActiveTrans(false)
  end
  self.heroNpcSwitchEft:ActiveTrans(true)
end

function cls:recycleNpcEffectModel()
  if L_CommonUtil.isValid(self.heroNpcSwitchEft) then
    C_GameObject.Destroy(self.heroNpcSwitchEft)
  end
  self.heroNpcSwitchEft = nil
end

function cls:loadEffectModel(heroCfgId, heroParent, heroPos)
  local tpl = _heroTpl:getTplById(heroCfgId)
  local elementId = _heroTpl:getElement(tpl)
  if elementId ~= self.lastElementId then
    self:recycleEffectModel()
    self.lastElementId = elementId
  end
  if not L_CommonUtil.isValid(self.heroSwitchEft) then
    local tpl_ele = _elementTpl:getTplById(elementId)
    local path = _elementTpl:getAdmissioneffects(tpl_ele)
    self.heroSwitchEft = L_ResPool:syncGameObject(path)
    self.heroSwitchEft.transform:SetParent(heroParent)
    L_Vector3.setLocalPos(self.heroSwitchEft.transform, heroPos)
  else
    self.heroSwitchEft:ActiveTrans(false)
  end
  self.heroSwitchEft:ActiveTrans(true)
end

function cls:recycleEffectModel()
  if L_CommonUtil.isValid(self.heroSwitchEft) then
    C_GameObject.Destroy(self.heroSwitchEft)
  end
  self.heroSwitchEft = nil
end

function cls:getFormationData()
  local formationType = L_FormationConst.FormationType.world
  local posData = L_FormationStore:getFormationPosData(formationType)
  local data = {}
  for i, guid in pairs(posData) do
    if not math.isEmpty(guid) then
      data[guid] = i
    end
  end
  return data
end

function cls:sortHeroUidList()
  table.sort(self.heroUidList, function(a, b)
    local heroDataA = L_HeroStore:getHero(a)
    local heroDataB = L_HeroStore:getHero(b)
    local heroGuidA = L_HeroStore:getHeroConfigId(heroDataA)
    local heroGuidB = L_HeroStore:getHeroConfigId(heroDataB)
    return heroGuidA < heroGuidB
  end)
end

function cls:getAllHeroList()
  local list = {}
  for i, v in pairs(L_HeroStore:getAllHero()) do
    local id = L_HeroStore:getHeroGuid(v)
    table.insert(list, id)
  end
  return list
end

function cls:refreshHeroList()
  self.heroUidList = self:getAllHeroList()
  self._heroId2FormationData = self:getFormationData()
  if self.modeController == nil then
    self.modeController = require("ui.pages.HeroPanel.controller.heroListModeController").new()
  end
  self:sortHeroUidList()
  local dataArray = {}
  
  local function onClickHeroCell(cell)
    if self.selectHeroGuid ~= cell.bind.guid then
      L_AudioUtil.playSound("Play_SFX_System_UI_CHAR_Role_Choose")
      local heroInfo = L_HeroStore:getHero(cell.bind.guid)
      L_HeroVoiceManager:playHeroVoice(string.format("Play_VO_System_%s_Forming", L_HeroStore:getHeroConfigId(heroInfo)))
    end
    self.selectHeroGuid = cell.bind.guid
    self:refreshHeroShow(true)
    self:setHeroListActive()
  end
  
  for _, uid in ipairs(self.heroUidList) do
    local heroInfo = L_HeroStore:getHero(uid)
    local heroItem = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroInfo))
    local data = {
      itemType = L_Const.resType.hero,
      guid = L_HeroStore:getHeroGuid(heroInfo),
      star = L_HeroStore:getHeroStar(heroInfo),
      lv = L_HeroStore:getHeroLevel(heroInfo),
      ignorePet = true,
      quality = heroItem.quality,
      callback = onClickHeroCell
    }
    table.insert(dataArray, data)
  end
  self.bind.leftHeroGrid:clear()
  self.bind.leftHeroGrid:insert_array(dataArray)
  self:setHeroListActive()
end

function cls:setHeroListActive()
  for i, v in pairs(self.modules.leftHeroGrid) do
    v:setSelectState(v.bind.guid == self.selectHeroGuid)
  end
end

function cls:getPetSlot(id, isTrial)
  if id <= 0 then
    return -1
  end
  for index, info in ipairs(self.curFormationPetData[self.selectFormationSlotId]) do
    if id == info.id and not info.is_trial == not isTrial then
      return index
    end
  end
  return -1
end

function cls:getCurPetList()
  local petList = {}
  if self.levelType == L_Const.kiBoDuelLevelType.system or self.levelType == L_Const.kiBoDuelLevelType.mix then
    local systemKiBoList = _kiBoDuelTpl:getKiboList(self.kiBoDuelCfg)
    for i = 1, #systemKiBoList do
      table.insert(petList, {
        is_trial = true,
        id = systemKiBoList[i]
      })
    end
  end
  if self._isPetBoxMode then
    local petBoxList = L_PetStore:getPetBoxList(self.selectPetBoxIndex)
    if not table.isEmpty(petBoxList) then
      for _, v in ipairs(petBoxList) do
        if 0 < v then
          local pet = L_PetStore:getPetItem(v)
          if not table.isEmpty(pet) then
            table.insert(petList, {is_trial = false, id = v})
          end
        end
      end
    end
  elseif not table.isEmpty(self._petTotalDataList) then
    for _, v in pairs(self._petTotalDataList) do
      if 0 < v.guid then
        local pet = L_PetStore:getPetItem(v.guid)
        if not table.isEmpty(pet) then
          table.insert(petList, {
            is_trial = false,
            id = v.guid
          })
        end
      end
    end
  end
  return petList
end

function cls:applyFormationSlot()
  if self.gameMode == L_PetConst.PetDuelGameType.Battle then
    if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
      return
    end
    L_PetDuelStore:req_setPetCurDuelFormation(self.selectFormationSlotId)
  elseif self.gameMode == L_PetConst.PetDuelGameType.Arena then
    L_PetDuelStore:req_setPetCurDuelArenaFormation(self.selectFormationSlotId)
  end
end

function cls:saveFormationInfoNew(isChangeHero)
  if self.gameMode == L_PetConst.PetDuelGameType.Battle then
    if C_KiboDuelSystemMgr:IsTrialDuel(self.levelId) then
      return
    end
    local info = L_PetDuelStore:getPetDuelFormationGroupInfo(self.selectFormationSlotId)
    local index = info.lockSlot
    L_PetDuelStore:req_setPetDuelFormation(self.selectFormationSlotId, self.curFormationPetData[self.selectFormationSlotId], self.curFormationHeroData[self.selectFormationSlotId], self.curFormationSkillData[self.selectFormationSlotId], self.levelId, index)
    C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(handler(self, self.escHandle))
  elseif self.gameMode == L_PetConst.PetDuelGameType.Arena then
    if not isChangeHero or self.selectFormationSlotId == L_Const.kiBoDuelBlockSlot then
      local groupInfo = L_PetDuelStore:getPetDuelArenaFormationGroupInfo(self.selectFormationSlotId)
      local index = groupInfo.lockSlot
      L_PetDuelStore:req_setPetDuelArenaFormation(self.selectFormationSlotId, self.curFormationPetData[self.selectFormationSlotId], self.curFormationHeroData[self.selectFormationSlotId], self.curFormationSkillData[self.selectFormationSlotId], self.levelId, index)
    else
      if self.curFormationHeroData[self.selectFormationSlotId] == L_PetDuelStore:getPetDuelArenaFormationHeroGuid(self.selectFormationSlotId) then
        return
      end
      for slotId = 1, MaxFormationNum do
        self.curFormationHeroData[slotId] = self.curFormationHeroData[self.selectFormationSlotId]
        L_PetDuelStore:req_setPetDuelArenaFormation(slotId, self.curFormationPetData[slotId], self.curFormationHeroData[slotId], self.curFormationSkillData[slotId], self.levelId, 0)
      end
    end
  end
end

function cls:onClickEmpty()
  self.modules.module_formationPetProperty:showModuleInfo(false)
  self:endDrag()
end

function cls:checkSlotCanEdit(slot)
  local info = L_PetDuelStore:getPetDuelArenaFormationGroupInfo(L_PetDuelStore:getCurPetDuelArenaFormationSlot())
  if info ~= nil and slot <= info.lockSlot and 0 < slot then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_cannt_formation"))
    return false
  end
  return true
end

function cls:onBtnCancelFormation()
  if not self:checkCanEditFormation() then
    return
  end
  if _kiBoDuelTpl:isKiboLock(self.levelId) and not self:checkSlotCanEdit(self.selectSlotId) then
    return
  end
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].id = 0
  self.curFormationPetData[self.selectFormationSlotId][self.selectSlotId].is_trial = false
  self:refreshPetCostNum()
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  local curRepeatParamList = L_PetDuelStore:getRepeatPetParam(curFormationPetGuids)
  for i = 1, #self.bind.list_playerPetFormation do
    local isForbidden = not L_PetDuelStore:checkPetValid(curFormationPetGuids[i], self.levelId) or curRepeatParamList[i] and self.gameMode == L_PetConst.PetDuelGameType.Arena and _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 0
    self.bind.list_playerPetFormation:change(i, {
      selectSlotId = self.selectSlotId,
      petGuid = curFormationPetGuids[i].id,
      is_trial = curFormationPetGuids[i].is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
  self:refreshLeftPetGridLit()
end

function cls:onBtnChangeFormation(index)
  if self.isPlayingAnimation then
    return
  end
  
  local function switchFormation()
    self.bindComponents.CardListRootAnim:Stop()
    self.bindComponents.CardListRootAnim:Play("anim_PetDuelMain_CardListRoot_switch")
    self.bind.active_blockClickWhenAnimation = true
    if self.selectFormationSlotId + index < 1 then
      self.selectFormationSlotId = MaxFormationNum
    elseif self.selectFormationSlotId + index > MaxFormationNum then
      self.selectFormationSlotId = 1
    else
      self.selectFormationSlotId = self.selectFormationSlotId + index
    end
    self:applyFormationSlot()
    self:refreshPlayerCardBack()
    L_AudioUtil.playSound("Play_SFX_System_QiboBattle_04_SetupCard_Switch")
    Timer.once(0.066, function()
      self:repeatCheck()
      self:refreshCurSlotFormationInfo()
      self.modules.module_formationPetProperty:showModuleInfo(false)
      self:refreshLeftPetGridLit()
    end, self, self.gameObject)
    Timer.once(0.5, function()
      self.bindComponents.CardListRootAnim:Play("anim_PetDuelMain_CardListRoot_reset")
      self.bind.active_blockClickWhenAnimation = false
    end, self, self.gameObject)
  end
  
  if self.gameMode == L_PetConst.PetDuelGameType.Arena and L_PetDuelStore:checkCostCondition(self.curFormationPetData[self.selectFormationSlotId]) then
    self:showCostConfirmTips(function()
      self:revertArenaFormationSlotData(self.selectFormationSlotId)
      switchFormation()
    end)
  else
    self:saveFormationInfoNew()
    switchFormation()
  end
end

function cls:onBtnPageLeft()
  L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
  self.selectPetBoxIndex = self.selectPetBoxIndex - 1
  self.modules.modulePetBoxFilter:changeIndexOutside(self.selectPetBoxIndex)
  self:refreshLeftPetGrid()
  self.modules.module_formationPetProperty:showModuleInfo(false)
end

function cls:onBtnPageRight()
  L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
  self.selectPetBoxIndex = self.selectPetBoxIndex + 1
  self.modules.modulePetBoxFilter:changeIndexOutside(self.selectPetBoxIndex)
  self:refreshLeftPetGrid()
  self.modules.module_formationPetProperty:showModuleInfo(false)
end

function cls:onBtnChangeHero(isChangeHero, isClosePage)
  self.bind.active_heroGrid = isChangeHero
  C_IntegrateMgr.TopBarModule:setTopBarMainBtnVisible(not isChangeHero and not self.dontShowHome)
  self:changeModeBg(not isChangeHero)
  if self.isSubFormation then
    self.hideCallback(not isChangeHero)
  end
  self:refreshHeroList()
  if not isChangeHero then
    if self.characterAnchorFit then
      self.characterAnchorFit.followTrans = self.bindComponents.playerModelHeadRoot
    end
    if not isClosePage then
    end
    self:saveFormationInfoNew(true)
    self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.unReady)
    self:switchPage(false)
  else
    if self.characterAnchorFit then
      self.characterAnchorFit.followTrans = self.bindComponents.modelHeadRoot_edit
    end
    self.bindComponents.heroEditBGAnim:Play("anim_commonbg_in3")
    self.bindComponents.root_heroEditAnim:Play("anim_root_heroEdit")
    self.bindComponents.SceneRootAnim:Play("anim_petDuelScene_SceneRoot_in1")
    L_AudioUtil.playSound("Play_SFX_System_QiboBattle_06_SetupCharacter_In")
  end
  self:findHeroModel()
  self:SetCharacterPosition()
end

function cls:findHeroModel()
  if not self.heroParent then
    return
  end
  local childCount = self.heroParent.childCount
  if 0 < childCount then
    for i = 0, childCount - 1 do
      local child = self.heroParent:GetChild(i)
      if L_CommonUtil.compareLayer(child.gameObject, L_Const.layer.character) and child.gameObject.activeSelf then
        self.heroModel = child.gameObject
      end
    end
  end
end

function cls:findNpcModel()
  if not self.npcParent then
    return
  end
  local childCount = self.npcParent.childCount
  if 0 < childCount then
    for i = 0, childCount - 1 do
      local child = self.npcParent:GetChild(i)
      if L_CommonUtil.compareLayer(child.gameObject, L_Const.layer.character) and child.gameObject.activeSelf then
        self.npcModel = child.gameObject
      end
    end
  end
end

function cls:onEditFormation(isEdit, noSave)
  if not isEdit then
    self:endDrag()
    if not noSave then
      self:saveFormationInfoNew()
      if self.isSubFormation then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagephotopreview_01"))
        return
      end
    end
  end
  if not isEdit then
    self.selectSlotId = 0
    self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.unReady)
    L_AudioUtil.playSound("Play_SFX_System_QiboBattle_05_SetupCard_Cancel")
    self.bindComponents.CardListRootAnim:Play("anim_PetDuelMain_CardListRoot_toPrep_out")
    self.bindComponents.root_petEditAnim:Play("ainm_root_petEdit_out")
    self.modules.module_formationPetProperty:showModuleInfo(false)
    self.isPlayingAnimation = true
    Timer.once(0.25, function()
      self.bind.active_petEdit = isEdit
      self.bind.active_listPlayerPet = isEdit
      C_IntegrateMgr.TopBarModule:setTopBarMainBtnVisible(not isEdit and not self.dontShowHome)
      self:switchPage(false)
      self.bindComponents.playerCardsAnim:Play("anim_PetDuelMain_playerContent_in1")
      Timer.once(0.6, function()
        self.isPlayingAnimation = false
        self.bindComponents.playerCardsAnim:Play("anim_PetDuelMain_playerContent_reset")
      end, self, self.gameObject)
    end, self, self.gameObject)
  end
  for i = 1, #self.bind.list_playerPetFormation do
    self.bind.list_playerPetFormation:change(i, {
      selectSlotId = self.selectSlotId
    })
  end
  L_CommonUtil.setObjActive(self.heroModel, not isEdit)
  if isEdit then
    self.bind.active_petEdit = isEdit
    self.bind.active_listPlayerPet = isEdit
    C_IntegrateMgr.TopBarModule:setTopBarMainBtnVisible(not isEdit and not self.dontShowHome)
    self.bindComponents.petEditBGAnim:Play("anim_commonbg_in3")
    self.bindComponents.root_petEditAnim:Play("ainm_root_petEdit")
    self.bindComponents.CardListRootAnim:Play("anim_PetDuelMain_CardListRoot_toPrep")
    Timer.once(0.567, function()
      self.bindComponents.CardListRootAnim:Play("anim_PetDuelMain_CardListRoot_reset")
      self.isPlayingAnimation = false
    end, self, self.gameObject)
  else
  end
end

function cls:onPointEnterPetCell(cell)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  if cell.bind.is_trial then
    return
  end
  self:showPetProperty(cell:getRaycastGo(), cell.bind.petGuid)
end

function cls:onPointExitPetCell(cell)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  self.modules.module_formationPetProperty:showModuleInfo(false)
end

function cls:configTouch(operator)
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self.onUITouchHandle)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function cls:getHoldInfo(go)
  for i, v in ipairs(self.modules.list_playerPetFormation) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.petGuid, module.bind.is_trial, module.bind.slotId, module.bind.cellMode
    end
  end
  for i, v in ipairs(self.modules.leftPetGrid) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.petGuid, module.bind.is_trial, module.bind.slotId, module.bind.cellMode
    end
  end
end

function cls:onUI_clickHandle(gesture)
  if not self.isBind or not self.bindComponents then
    return
  end
  if not math.isEmpty(self.bindComponents.rect_drag) then
    self:onUI_dragEndHandle(gesture)
  end
  return
end

function cls:onUI_touchHandle(gesture)
  if not self.isBind or not self.bindComponents then
    return
  end
  if self.bindComponents.rect_drag.gameObject.activeSelf == true then
    return
  end
  if not self.bind.active_petEdit then
    return
  end
  if not self:checkCanEditFormation() then
    return
  end
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  local go = gesture.go
  self.fingerId = gesture.fingerId
  local holdGuid, holdIsTrial, holdSlotId, holdCellMode = self:getHoldInfo(go)
  if math.isEmpty(holdGuid) then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Click_Hold")
  L_FlyMsgManager:startLongPress(gesture, 0.3, function()
    if not self:checkSlotCanEdit(holdSlotId) then
      return
    end
    self.isDrag = true
    self._holdGuid, self._holdIsTrial, self._holdSlotId, self._holdCellMode = holdGuid, holdIsTrial, holdSlotId, holdCellMode
    L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
    self:showDragImg(true, holdGuid, holdIsTrial, holdGuid)
  end)
end

function cls:onUI_dragHandle(gesture)
  if not self.isBind or not self.bindComponents then
    return
  end
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
end

function cls:onUI_dragEndHandle(gesture)
  if not self.isBind or not self.bindComponents then
    return
  end
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  if gesture.fingerId ~= self.fingerId then
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  if not math.isEmpty(self._holdGuid) and go ~= nil then
    local holdGuid, holdIsTrail, holdSlotId, holdCellMode = self:getHoldInfo(go)
    if holdGuid == self._holdGuid or holdSlotId == self._holdSlotId then
      self:endDrag()
      return
    end
    if math.isEmpty(holdSlotId) then
      self:endDrag()
      return
    end
    if holdCellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
      self:endDrag()
      return
    end
    if self._holdSlotId <= 0 and self.gameMode == L_PetConst.PetDuelGameType.Arena and L_PetDuelStore:checkKiboRepeat(self._holdIsTrial, self._holdGuid, holdSlotId, self.curFormationPetData[self.selectFormationSlotId]) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_11"))
      self:endDrag()
      return
    end
    self:handleDragEffect(self._holdGuid, self._holdSlotId, self._holdIsTrial, holdGuid, holdSlotId)
    self:endDrag()
  else
    self:endDrag()
  end
end

function cls:showDragImg(isShow, holdGuid, holdIsTrial, holdSlotId)
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  if isShow then
    self.modules.module_formationPetProperty:showModuleInfo(false)
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
    self:changeDragCardInfo(holdGuid, holdIsTrial)
    self.bindComponents.scroll_petGrid.enabled = false
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp")
    for i, module in ipairs(self.modules.list_playerPetFormation) do
      if module.bind.petGuid == holdGuid and module.isBind then
        module:setIsDragging(true, true)
      else
        module:setIsDragging(true, false)
      end
    end
    for i, module in ipairs(self.modules.leftPetGrid) do
      if module.isBind then
        if module.bind.petGuid == holdGuid then
          module:setIsDragging(true, true)
        else
          module:setIsDragging(true, false)
        end
      end
    end
  else
    self:endDrag()
  end
end

function cls:changeDragCardInfo(_petGuid, _isTrial)
  if 0 < _petGuid then
    local isForbidden = not L_PetDuelStore:checkPetValid({id = _petGuid, is_trial = _isTrial}, self.levelId)
    isForbidden = false
    self.modules.module_DragKiboCard:initData({
      petGuid = _petGuid,
      is_trial = _isTrial,
      slotId = self:getPetSlot(_petGuid, _isTrial),
      cellMode = L_PetConst.PetDuelEntranceCellMode.FormationSlot,
      isForbidden = isForbidden
    })
  end
end

function cls:handleDragEffect(fromGuid, fromSlotId, fromIsTrial, toGuid, toSlotId)
  self:changePetFormationFromDrag(fromGuid, fromSlotId, fromIsTrial, toSlotId)
  self:refreshLeftPetGridLit()
  L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
end

function cls:changePetFormationFromDrag(fromPetGuid, fromSlotId, fromIsTrial, toPetSlotId)
  if _kiBoDuelTpl:isKiboLock(self.levelId) then
    local info = L_PetDuelStore:getPetDuelArenaFormationGroupInfo(L_PetDuelStore:getCurPetDuelArenaFormationSlot())
    if info ~= nil and toPetSlotId <= info.lockSlot then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_cannt_formation"))
      return
    end
    if 0 < fromSlotId and info ~= nil and fromSlotId <= info.lockSlot then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_cannt_formation"))
      return
    end
  end
  local toPetUid = self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].id
  local toPetIsTrial = self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].is_trial
  local curPetSlotId = self:getPetSlot(fromPetGuid, fromIsTrial)
  if toPetUid <= 0 then
    self.isBlankSlot = true
  else
    self.isBlankSlot = false
  end
  self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].id = fromPetGuid
  self.curFormationPetData[self.selectFormationSlotId][toPetSlotId].is_trial = fromIsTrial
  if 0 < curPetSlotId then
    self.curFormationPetData[self.selectFormationSlotId][curPetSlotId].id = toPetUid
    self.curFormationPetData[self.selectFormationSlotId][curPetSlotId].is_trial = toPetIsTrial
  end
  self:refreshPetCostNum()
  local curFormationPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local curNameList = L_PetDuelStore:getPetName(curFormationPetGuids)
  local curRepeatParamList = L_PetDuelStore:getRepeatPetParam(curFormationPetGuids)
  local isFound = false
  for i = self.selectSlotId, 8 do
    if 0 >= curFormationPetGuids[i].id and self.isBlankSlot then
      self.selectSlotId = i
      isFound = true
      break
    end
  end
  if not isFound then
    for i = 1, self.selectSlotId do
      if 0 >= curFormationPetGuids[i].id and self.isBlankSlot then
        self.selectSlotId = i
        break
      end
    end
  end
  for i = 1, #self.bind.list_playerPetFormation do
    local isForbidden = not L_PetDuelStore:checkPetValid(curFormationPetGuids[i], self.levelId) or curRepeatParamList[i] and self.gameMode == L_PetConst.PetDuelGameType.Arena and _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 0
    self.bind.list_playerPetFormation:change(i, {
      selectSlotId = self.selectSlotId,
      petGuid = curFormationPetGuids[i].id,
      is_trial = curFormationPetGuids[i].is_trial,
      isForbidden = isForbidden,
      petName = curNameList[i]
    })
  end
end

function cls:endDrag()
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  if not self.isDrag then
    return
  end
  self._holdGuid, self._holdSlotId, self._holdIsTrial, self._holdCellMode, self.fingerId = nil, nil, nil, nil, nil
  self.isDrag = false
  if not math.isEmpty(self.bindComponents.rect_drag) then
    self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  end
  self.bindComponents.scroll_petGrid.enabled = true
  for i, module in ipairs(self.modules.list_playerPetFormation) do
    if module.isBind then
      module:setIsDragging(false, false)
    end
  end
  for i, module in ipairs(self.modules.leftPetGrid) do
    if module.isBind then
      module:setIsDragging(false, false)
    end
  end
  self:killAutoDragTimer()
end

function cls:createAutoDragTimer(index)
  self:killAutoDragTimer()
  local value = index == 1 and 1 or -1
  self.autoDragTimer = Timer.repeated(1.1, function()
    self:clearFilter()
    self.bind.snapToItemIndex = self.realIndex + value
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
  end, self)
end

function cls:killAutoDragTimer()
  if self.autoDragTimer then
    Timer.remove(self.autoDragTimer)
    self.autoDragTimer = nil
  end
end

function cls:showPetProperty(go, guid)
  self.modules.module_formationPetProperty:HideBattleSkillDetail()
  self.modules.module_formationPetProperty:HideGeneSkillDetail()
  self.modules.module_formationPetProperty:HidePetSkillTagInfo()
  self.modules.module_formationPetProperty:showModuleInfo(true, guid, true)
  self.modules.module_formationPetProperty:checkTipsHeight(true)
  self.modules.module_formationPetProperty.bind.arrowActive = false
end

function cls:onClosePetBox()
  self:refreshLeftPetGrid()
  self:initModulePetBoxFilter()
  self.modules.module_formationPetProperty:showModuleInfo(false)
  for i, module in ipairs(self.modules.list_playerPetFormation) do
    module:refreshView()
  end
  self:repeatCheck()
  self:refreshCurSlotFormationInfo()
end

function cls:repeatCheck()
  local bRepeat = false
  local curRepeatParamList = L_PetDuelStore:getRepeatPetParam(self.curFormationPetData[self.selectFormationSlotId])
  for i = 1, 8 do
    if curRepeatParamList[i] and self.gameMode == L_PetConst.PetDuelGameType.Arena and _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 0 then
      bRepeat = true
      self.curFormationPetData[self.selectFormationSlotId][i] = {is_trial = false, id = 0}
    end
  end
  return bRepeat
end

function cls:onSyncPvpMatchSucess()
  self.enemyPlayerId = C_PetDuelArenaManager.GetPetDuelArenaPvpEnemyPlayerId()
  self.bind.txt_btn = L_WordsTpl:getValue("ui_kiboDuel_41")
  self.match = false
  L_AudioUtil.stopSound(self.curAudio)
  self.curAudio = nil
  L_AudioUtil.playSound("Play_SFX_System_QiboBattle_22_Matched")
  self.bindComponents.PrepareRoot_upLayerAnim:Play("anim_PrepareRoot_upLayer_out")
  L_TimerManager:newOrResetTimer(self, "cancelMatchDelay", function()
    self.bind.active_btnCancelMatch = false
    self.bind.active_btnBlack = true
    self.bind.active_rootMatchNode = false
    self.bind.active_multiBg = false
  end, 0.233, 1)
  L_TimerManager:stopTimer(self, "petDuelPvpMatch")
  self.bind.active_matchSucRoot = true
end

function cls:onSyncPvpLeaveRoom()
  if (self.mode == L_PetConst.PetDuelFormationType.pvpMatch or self.mode == L_PetConst.PetDuelFormationType.pvpInvite) and not self.bind.active_multiBg then
    self.isCallClose = true
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_39"))
    L_UI:close("pagePetDuelMain")
  end
end

function cls:onSyncPvpChangeMapReq(id, data)
  local dungeonId = data:GetInt(0)
  local playerId = data:GetInt(1)
  local preId = self.selectMapIds[self.gameMode]
  local nextId = self.dungeonId2mapId[dungeonId]
  if playerId == self.enemyPlayerId then
    self.isReqSender = false
    local preMapName = preId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(_kiboDuelMapTpl:getTplById(preId))
    local nextMapName = nextId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(_kiboDuelMapTpl:getTplById(nextId))
    L_UI:open("pageKiboDuelInviteWaiting", {
      playerId = playerId,
      title = L_WordsTpl:getValue("ui_kiboDuel_40"),
      content = L_WordsTpl:getValue("ui_kiboDuel_83", {
        [0] = preMapName,
        [1] = nextMapName
      }),
      showMode = 4,
      acceptAction = function()
        C_PetDuelArenaManager.ReqReplyMapChange(dungeonId, true)
      end,
      cancelAction = function()
        C_PetDuelArenaManager.ReqReplyMapChange(dungeonId, false)
      end
    })
  elseif playerId == L_PlayerStore:getPlayerId() then
    self.isReqSender = true
    local preMapName = preId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(_kiboDuelMapTpl:getTplById(preId))
    local nextMapName = nextId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(_kiboDuelMapTpl:getTplById(nextId))
    L_UI:open("pageKiboDuelInviteWaiting", {
      playerId = L_PlayerStore:getPlayerId(),
      title = L_WordsTpl:getValue("ui_kiboDuel_25"),
      content = L_WordsTpl:getValue("ui_kiboDuel_83", {
        [0] = preMapName,
        [1] = nextMapName
      }),
      showMode = 3,
      cancelAction = function()
        C_PetDuelArenaManager.ReqChangeMap(self.changeMapTarget, true)
        L_UI:close("pageKiboDuelInviteWaiting")
      end
    })
  end
end

function cls:onSyncPvpChangeMapReply(id, data)
  local result = data:GetInt(0)
  L_UI:close("pageKiboDuelInviteWaiting")
  if result == changeMapResult.Succ then
    local dungeonId = data:GetInt(1)
    local mapId = self.dungeonId2mapId[dungeonId]
    self.dungeonId = dungeonId
    self.modules.module_changeMap:refreshView(mapId)
    self.selectMapIds[self.gameMode] = mapId
    if self.isReqSender then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_27"))
    end
  elseif result == changeMapResult.Fail then
    if self.isReqSender then
      self.changeMapTarget = 0
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_28"))
    end
  elseif result == changeMapResult.CheckFail then
  elseif result == changeMapResult.Cancel and not self.isReqSender then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_26"))
  end
end

function cls:onSyncPvpChangeUIStatus(id, data)
  local status = data:GetInt(0)
  self.enemyUIStatus = status
  self.modules.module_enemyReady:setPlayerState(status)
  if status == L_PetConst.PetDuelPlayerState.unReady then
    if self.onStartGameCD then
      self:handleCancelStartGameCountdown()
      self:handleReady(false)
    end
  elseif status == L_PetConst.PetDuelPlayerState.Ready and self.ready then
    self:onStartGameCountdown()
  end
end

function cls:onSyncPvpChangeHero(id, data)
  if not self.binit then
    return
  end
  self:initModNPC(true)
end

function cls:onSyncPvpChangeFormation(id, data)
  if not self.binit then
    return
  end
  self.bindComponents.enemyCardsAnim:Play("anim_PetDuelMain_enemyContent_refresh")
  Timer.once(0.3, function()
    self:refreshEnemyEmptyFormationInfo()
  end, self, self.gameObject)
end

function cls:onKiboArenaRankActivityEnd(id, data)
  L_UI:close("pagePetDuelMain")
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_74"))
end

function cls:initPage_prepare()
  self:initModNPC()
  self:refreshEnemyFormationInfo()
  self.curHeroGuid = -1
  self:initPlayerFormation()
  self:switchPage(false)
end

function cls:initPage_preparePvp()
  if self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
    self:initModNPC()
  end
  self:refreshEnemyEmptyFormationInfo()
  self.curHeroGuid = -1
  self:initPlayerFormation()
  self:switchPage(false)
end

function cls:recycleFakeLight()
  if L_CommonUtil.isValid(self.fakeLightGo) then
    C_GameObject.Destroy(self.fakeLightGo)
  end
  self.fakeLightGo = nil
end

function cls:loadFakeLightForCharacter()
  self:recycleFakeLight()
  local go_fakeLight = Unity.GameObject("fakeLightRoot")
  CS.UnityEngine.Object.DontDestroyOnLoad(go_fakeLight)
  self.fakeLightGo = go_fakeLight
  local modelControl = self.npcModel:GetComponent(typeof(C_ModelControl))
  local splineTrans = modelControl:GetTransByName("Spine")
  go_fakeLight.transform:SetParent(splineTrans)
  local _fakeLight = go_fakeLight:AddComponent(typeof(C_CharacterFakeLightDir))
  local eulerAngles = L_Vector3.new(90, 0, 0)
  go_fakeLight.transform.localPosition = L_Vector3.zero
  go_fakeLight.transform.localRotation = Unity.Quaternion.Euler(eulerAngles)
  go_fakeLight.transform.localScale = L_Vector3.zero
  _fakeLight.isGlobal = false
  _fakeLight:SetCharacterList(self.npcModel.gameObject)
end

function cls:openPetDuelScene()
  C_UISceneManager.SetSceneVisible()
  L_UIModelMgr:LoadHeroScenePrefabAsync(_scenePrefabPath, function(go)
    self.petDuelFormationSceneGo = go
    self.root = go.transform:Find("pre_petDuelScene_ui_01").gameObject
    self.heroParent = go.transform:Find("pre_petDuelScene_ui_01/PlayerAnimRoot/PlayerModelRoot")
    self.npcParent = go.transform:Find("pre_petDuelScene_ui_01/NpcAnimRoot/NpcModelRoot")
    self.prepareModeCamera = go.transform:Find("pre_petDuelScene_ui_01/petCameraPrepare").gameObject
    self.formationModeCamera = go.transform:Find("pre_petDuelScene_ui_01/petCameraFormation").gameObject
    self.HeroChangeCamera = go.transform:Find("pre_petDuelScene_ui_01/petCameraHeroChange").gameObject
    self.bg = go.transform:Find("pre_petDuelScene_ui_01/BgRoot/AnimRoot_Pre/BgFullScreen_bg").gameObject
    self.bg_prepare_front = go.transform:Find("pre_petDuelScene_ui_01/BgRoot/AnimRoot_Main/BgFullScreen_bg_prepare_front").gameObject
    self.bg_prepare_back = go.transform:Find("pre_petDuelScene_ui_01/BgRoot/AnimRoot_Main/BgFullScreen_bg_prepare_back").gameObject
    self.bg_state_front = go.transform:Find("pre_petDuelScene_ui_01/BgRoot/AnimRoot_Main/BgFullScreen_bg_state_front").gameObject
    self.bg_state_emptyRole = go.transform:Find("pre_petDuelScene_ui_01/BgRoot/AnimRoot_Main/BgFullScreen_bg_emptyRole_back").gameObject
    local _offset = self:mapValue(C_Screen.width / C_Screen.height, 1, 2, -0.3, 0)
    self.bg_state_emptyRole.transform:GetComponent(typeof(CS.Lens.Gameplay.UI.FullscreenFacingPlane)).offset = L_Vector3.new(_offset, 0, 0)
    self.bg_VX = go.transform:Find("pre_petDuelScene_ui_01/BgRoot/AnimRoot_Main/VX_bg").gameObject
    self:changeModeBg(true)
    if self.isSubFormation then
      self:initPlayerFormation()
      self:switchPage(true)
      self:switchToPetEdit()
    elseif self.mode == L_PetConst.PetDuelFormationType.pvpMatch or self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
      self:initPage_preparePvp()
    elseif _kiBoDuelTpl:isKiboLock(self.levelId) then
      L_PetDuelStore:req_CSProtoKiboDuelGetGroup(self.levelId, function()
        self:initPage_prepare()
      end)
    else
      self:initPage_prepare()
    end
  end)
end

function cls:loadModelCallBack()
  C_UIMgr.CloseCutin()
  Timer.once(0.1, function()
    L_AudioUtil.playSound("Play_SFX_System_QiboBattle_02_Setup_VS")
    self.bindComponents.playerCardsAnim:Play("anim_PetDuelMain_playerContent_in")
    self.bindComponents.enemyCardsAnim:Play("anim_PetDuelMain_enemyContent_in")
    self.bindComponents.PrepareRootAnim:Play("anim_PetDuelMain_PrepareRoot_in")
    self.bindComponents.SceneRootAnim:Play("anim_petDuelScene_SceneRoot_in")
    Timer.once(0.7, function()
      self.bindComponents.playerCardsAnim:Play("anim_PetDuelMain_playerContent_reset")
    end, self, self.gameObject)
    Timer.once(1.233, function()
      self.bindComponents.PrepareRootAnim:Play("anim_PetDuelMain_PrepareRoot_hold")
    end, self, self.gameObject)
  end, self, self.gameObject)
end

function cls:changeModeBg(isPrepare)
  L_CommonUtil.setObjActive(self.bg, not isPrepare)
  L_CommonUtil.setObjActive(self.bg_prepare_front, isPrepare)
  L_CommonUtil.setObjActive(self.bg_prepare_back, isPrepare)
  L_CommonUtil.setObjActive(self.bg_state_front, isPrepare)
  L_CommonUtil.setObjActive(self.bg_VX, isPrepare)
  L_CommonUtil.setObjActive(self.bg_state_emptyRole, isPrepare and self.mode == L_PetConst.PetDuelFormationType.pvpMatch)
end

function cls:initModNPC(bSwitch)
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  local path, unit, enemyHeroId, heroCfg, initPos, initRotate, initScale
  if self.mode == L_PetConst.PetDuelFormationType.Normal then
    local spawnerId = _kiBoDuelTpl:getNpcSpawnerID(kiBoDuelCfg)
    local spawnerTpl = L_GameTpl:getWorldSpawnerTpl()
    local spawnerCfg = spawnerTpl:getTplById(spawnerId)
    local unitID = spawnerTpl:getResourceId(spawnerCfg)
    if not unitID then
      return
    end
    initPos = _kiBoDuelTpl:getNpcTransOffset(kiBoDuelCfg)
    initRotate = _kiBoDuelTpl:getNpcTransEuler(kiBoDuelCfg)
    initScale = _kiBoDuelTpl:getNpcTransScale(kiBoDuelCfg)
    unit = _unitTpl:getTplById(unitID)
    path = _unitTpl:getModel(unit, 1)
  elseif self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
    local enemyInfo = C_PetDuelArenaManager.GetPetDuelArenaPvpEnemyFormationInfo()
    enemyHeroId = enemyInfo.hero
    if enemyHeroId == self.enemyHeroId then
      return
    end
    self.enemyHeroId = enemyHeroId
    heroCfg = _heroTpl:getTplById(enemyHeroId)
    if self.enemyHeroId ~= L_GameUtil.getDefaultHeroId(L_Const.sexType.male) and self.enemyHeroId ~= L_GameUtil.getDefaultHeroId(L_Const.sexType.female) then
      local enemyClothingId = enemyInfo.hero_skin_id
      local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
      local unitID = heroClothingTpl:getUnitId(heroClothingTpl:getTplById(enemyClothingId))
      if not unitID then
        return
      end
      unit = _unitTpl:getTplById(unitID)
      path = _unitTpl:getModel(unit, 1)
    else
      unit = _unitTpl:getTplById(heroCfg.unitId)
    end
    initPos = _heroTpl:getKiBoDuelEnemyHeroTransXZOffset(heroCfg)
    initRotate = _heroTpl:getKiBoDuelEnemyHeroTransEuler(heroCfg)
    initScale = _heroTpl:getKiBoDuelEnemyHeroTransScale(heroCfg)
  end
  
  local function loadNpcCallback(go)
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), go)
    if biologyData then
      biologyData.isSync = true
      local lodLevel = C_EntityManager.GetUIEntityLodLevelInt(C_EEntityEntranceType.PetDuel)
      biologyData:SetTheoryShadowLodLv(0)
      biologyData:UsePreviewLodLevelByInt(lodLevel)
    end
    local characterAnchorFit = self.npcParent:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
    characterAnchorFit.followTrans = self.bindComponents.npcModelHeadRoot
    self:findNpcModel()
    local animName = "KiboDuelUi"
    L_Vector3.setScale(self.npcModel.transform, initScale)
    if self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
      animName = "KiboDuelUiR"
      local configHeight = _heroTpl:getKiBoDuelEnemyHeroTransYOffset(_heroTpl:getTplById(enemyHeroId)).y
      if L_DeviceTpl:getIsMobile() then
        configHeight = configHeight + 0.1
      end
      characterAnchorFit:SetModelHeight(configHeight)
      self.bNpcModLoaded = true
      if self.bHeroModLoaded and self.bNpcModLoaded and not self.binit then
        self.binit = true
        self:loadModelCallBack()
      end
    elseif self.mode == L_PetConst.PetDuelFormationType.Normal then
      animName = _kiBoDuelTpl:getAnimName(kiBoDuelCfg)
      Timer.once(0.05, function()
        self:SetNPCPosition(characterAnchorFit, biologyData, enemyHeroId)
        self.bNpcModLoaded = true
        if self.bHeroModLoaded and self.bNpcModLoaded and not self.binit then
          self.binit = true
          self:loadModelCallBack()
        end
      end, self, self.gameObject)
    end
    characterAnchorFit.deltaFollowY = 0
    self.animatorEnemyPlayer = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), go)
    self.animatorEnemyPlayer.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    self.animatorEnemyPlayer.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
    local needAnimaList = {animName}
    local loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needAnimaList)
    for i = 1, #needAnimaList do
      loadNames[i - 1] = needAnimaList[i]
    end
    self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(_unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview), loadNames)
    self.animatorEnemyPlayer.defaultAnimatorController = self.controllerAssetHandle.config
    self.animatorEnemyPlayer:Play(animName)
    self:loadFakeLightForCharacter()
    if bSwitch then
      self:loadNpcEffectModel(enemyHeroId, self.npcParent, initPos)
      L_AudioUtil.playSound("Play_SFX_System_QiboBattle_07_SetupCharacter_Select")
    end
  end
  
  if self.enemyHeroId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or self.enemyHeroId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female) then
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    L_FriendManager:requestBaseInfo(types, {
      self.enemyPlayerId
    }, function()
      local entityId = L_EntityManager:generateUIHeroEntity(self.enemyHeroId, function(_entity)
        L_UIModelMgr:RecycleViceHeroModel()
        self.enemyPlayerEntity = _entity
        _entity.gameObject.transform:SetParent(self.npcParent)
        L_Vector3.setLocalPos(_entity.gameObject.transform, initPos)
        L_Vector3.setRot(_entity.gameObject.transform, initRotate)
        loadNpcCallback(self.enemyPlayerEntity.gameObject)
      end, self.enemyPlayerId, nil, C_EEntityEntranceType.PetDuel)
      self.enemyHeroId = enemyHeroId
      self.isEnemyDefaultHeroId = true
      if entityId then
        self.entityId = entityId
      end
    end)
  else
    L_UIModelMgr:LoadViceHeroModelAsync(path, initPos, initRotate, initScale, function(go)
      self:recycleEnemyPlayerModel()
      self.isEnemyDefaultHeroId = false
      loadNpcCallback(go)
    end, self.npcParent)
  end
end

function cls:SetNPCPosition(characterAnchorFit, biologyData)
  local modelControl = self.npcModel:GetComponent(typeof(C_ModelControl))
  local headTrans = modelControl:GetTransByName("Head")
  if headTrans then
    local height = headTrans.position.y - self.npcParent.position.y + 0.9
    characterAnchorFit:SetModelHeight(height)
  end
end

function cls:recycleEnemyPlayerModel()
  if not self.enemyPlayerEntity and self.entityId then
    C_EntityManager.ClearUIHeroEntityByConfigId(self.enemyHeroId, self.entityId)
  end
  if self.enemyPlayerEntity then
    C_EntityManager.ClearUIHeroEntityByConfigId(self.enemyHeroId, self.entityId)
    self.enemyPlayerEntity:onDestroy()
    C_EntityManager.RemoveEntityWithEntityId(self.entityId)
    C_EntityManager.ClearUIHeroEntity()
  end
  self.enemyPlayerEntity = nil
  self.animatorEnemyPlayer = nil
  self.entityId = nil
end

function cls:mapValue(x, inMin, inMax, outMin, outMax)
  if inMax < x then
    return outMax
  end
  if x < inMin then
    return outMin
  end
  return outMin + (x - inMin) * (outMax - outMin) / (inMax - inMin)
end

function cls:checkStartDuelCondition()
  local curPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  self.Cond_notAllPetUseable = false
  for i = 1, #curPetGuids do
    local info = curPetGuids[i]
    local isForbidden = not L_PetDuelStore:checkPetValid(info, self.levelId)
    self.Cond_notAllPetUseable = self.Cond_notAllPetUseable or isForbidden
  end
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  self.minimumKibo = _kiBoDuelTpl:getMinimumKibo(kiBoDuelCfg)
  local validPetNum = self:getValidPetNum(curPetGuids)
  self.Cond_costNotAvailable = L_PetDuelStore:checkCostCondition(self.curFormationPetData[self.selectFormationSlotId])
  self.Cond_miniKiboNum = validPetNum >= self.minimumKibo
  self.Cond_skillUsable = self.gameMode == L_PetConst.PetDuelGameType.Battle and self:checkSkillUsable() or true
  if self.gameMode == L_PetConst.PetDuelGameType.Battle then
    if not self.Cond_skillUsable then
      self.bind.txt_duelTip = L_WordsTpl:getValue("notice_pagePetPrepareDuel_03")
    end
    self.bind.active_btnInvalid = self.Cond_notAllPetUseable or not self.Cond_miniKiboNum or not self.Cond_skillUsable
  elseif self.gameMode == L_PetConst.PetDuelGameType.Arena then
    if self.Cond_costNotAvailable then
      self.bind.txt_duelTip = L_WordsTpl:getValue("ui_kiboDuel_07")
    end
    self.bind.active_btnInvalid = self.Cond_notAllPetUseable or not self.Cond_miniKiboNum or self.Cond_costNotAvailable
  end
  if self.Cond_notAllPetUseable then
    self.bind.txt_duelTip = L_WordsTpl:getValue("notice_pagePetPrepareDuel_01")
  elseif not self.Cond_miniKiboNum then
    self.bind.txt_duelTip = L_WordsTpl:getValue("notice_pagePetPrepareDuel_02", {
      [0] = self.minimumKibo
    })
  end
  self.bind.active_btnBlack = not self.bind.active_btnInvalid
end

function cls:checkStartMatchCondition()
  local curPetGuids = self.curFormationPetData[self.selectFormationSlotId]
  local ret = L_PetDuelStore:checkRepeatKibo(curPetGuids)
  self.bind.active_btnInvalid = ret
  self.bind.active_btnBlack = not self.bind.active_btnInvalid
  if ret then
    self.bind.txt_duelTip = L_WordsTpl:getValue("ui_kiboDuel_11")
  end
end

function cls:refreshPetCostNum()
  if self.gameMode ~= L_PetConst.PetDuelGameType.Arena then
    return
  end
  local num = L_PetDuelStore:calKiboDuelFormationCost(self.curFormationPetData[self.selectFormationSlotId])
  local maxNum = _gameConstTpl:getData("KIBO_DUEL_ARENA_MODE_COST_LIMIT", L_Const.GameTplType.int)
  local ret = num > maxNum
  if maxNum >= self.modules.module_kiboDuelArenaNum:getCurNum() and ret then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_08"))
  end
  self.modules.module_kiboDuelArenaNum:setCurNum(num)
  self.bind.active_savePetEdit = not ret
  self.bind.active_savePetEditGrey = ret
  self.bind.txt_savePetEditTip = L_WordsTpl:getValue("ui_kiboDuel_08")
end

function cls:setInitialArenaFormation()
  local skillInfos = L_PetDuelStore:getDefaultSkillInfos(self.levelId)
  local slot = L_PetDuelStore:getCurPetDuelArenaFormationSlot()
  local groupInfo = L_PetDuelStore:getPetDuelArenaFormationGroupInfo(self.selectFormationSlotId)
  local index = groupInfo.lockSlot
  L_PetDuelStore:req_setPetDuelArenaFormation(slot, L_PetDuelStore:getPetDuelArenaFormationPetGuids(slot), L_HeroStore:getDefaultHeroGuid(), skillInfos, self.levelId, index)
end

function cls:setInitialFormation()
  local skillInfos = L_PetDuelStore:getDefaultSkillInfos(self.levelId)
  local info = L_PetDuelStore:getPetDuelFormationGroupInfo(L_PetDuelStore:getCurPetDuelFormationSlot())
  local index = info.lockSlot
  L_PetDuelStore:req_setPetDuelFormation(L_PetDuelStore:getCurPetDuelFormationSlot(), L_PetDuelStore:getPetDuelFormationPetGuids(), L_HeroStore:getDefaultHeroGuid(), skillInfos, self.levelId, index)
end

function cls:refreshLockArenaFormationInfo(slotId)
  local curHeroGuid = L_PetDuelStore:getPetDuelArenaFormationHeroGuid(slotId)
  if curHeroGuid <= 0 and not self.isFailureJumpFormationLocked then
    self:setInitialArenaFormation()
  end
  local petUids = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelArenaFormationPetGuids(slotId)) do
    table.insert(petUids, {
      is_trial = v.is_trial,
      id = v.id
    })
  end
  self.curFormationPetData[slotId] = petUids
  self.curFormationHeroData[slotId] = L_PetDuelStore:getPetDuelArenaFormationHeroGuid(slotId)
end

function cls:refreshLockFormationInfo(slotId)
  local curHeroGuid = L_PetDuelStore:getCurPetDuelFormationHeroGuid()
  if curHeroGuid <= 0 then
    self:setInitialFormation()
  end
  local petUids = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelFormationPetGuids(slotId)) do
    table.insert(petUids, {
      is_trial = v.is_trial,
      id = v.id
    })
  end
  self.curFormationPetData[slotId] = petUids
  local tpl = _kiBoDuelTpl:getTplById(self.levelId)
  local trialRole = _kiBoDuelTpl:getTrialRole(tpl)
  local heroConfigId = L_GameUtil.getDefaultHeroId(L_PlayerStore:getSex())
  heroConfigId = L_HeroStore:getDefaultHeroGuid()
  if not math.isEmpty(trialRole) then
    local trialRoleTpl = _heroInterimTpl:getTplById(trialRole)
    heroConfigId = _heroInterimTpl:getHeroId(trialRoleTpl)
  end
  self.curFormationHeroData[slotId] = heroConfigId
  local skills = {}
  for _, v in ipairs(L_PetDuelStore:getPetDuelFormationHeroSkills(slotId)) do
    table.insert(skills, table.clone(v))
  end
  self.curFormationSkillData[slotId] = skills
end

function cls:refreshEmptyFormationInfo(slotId)
  local petUids = {}
  for i = 1, 8 do
    table.insert(petUids, {is_trial = false, id = 0})
  end
  self.curFormationPetData[slotId] = petUids
  local heroConfigId = L_HeroStore:getDefaultHeroGuid()
  self.curFormationHeroData[slotId] = heroConfigId
  self.curFormationSkillData[slotId] = L_PetDuelStore:getDefaultSkillInfos(self.levelId)
  self:saveFormationInfoNew()
end

function cls:getValidPetNum(petIds)
  if not petIds then
    return 0
  end
  local num = 0
  for _, v in ipairs(petIds) do
    if 0 < v.id then
      num = num + 1
    end
  end
  return num
end

function cls:refreshEnemyFormationInfo()
  local enemySlotItem = {}
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.levelId)
  for _, id in pairs(kiBoDuelCfg.enemy) do
    table.insert(enemySlotItem, {
      petCfgId = id,
      petLv = kiBoDuelCfg.recommendLevel,
      cellMode = L_PetConst.PetDuelEntranceCellMode.PrepareEnemy
    })
  end
  local reversed = {}
  for i = #enemySlotItem, 1, -1 do
    table.insert(reversed, enemySlotItem[i])
  end
  self.bind.list_enemyPet:clear()
  self.bind.list_enemyPet:insert_array(reversed)
end

function cls:refreshEnemyEmptyFormationInfo()
  local enemySlotItem = {}
  if self.mode == L_PetConst.PetDuelFormationType.pvpMatch then
    for id = 1, 8 do
      table.insert(enemySlotItem, {
        petCfgId = 0,
        cellMode = L_PetConst.PetDuelEntranceCellMode.PreparePvp,
        catchItem = 0
      })
    end
  elseif self.mode == L_PetConst.PetDuelFormationType.pvpInvite then
    local enemyInfo = C_PetDuelArenaManager.GetPetDuelArenaPvpEnemyFormationInfo()
    local enemyHeroId = enemyInfo.hero
    local enemyPets = enemyInfo.pet_guids
    for i = 1, 8 do
      local catch_Item = 0
      local cellMode = L_PetConst.PetDuelEntranceCellMode.PrepareEnemy
      if i <= enemyPets.Count then
        local enemyPet = enemyPets[i - 1]
        if 0 < enemyPet.id then
          catch_Item = enemyPet.catchItem and enemyPet.catchItem or 0
          cellMode = L_PetConst.PetDuelEntranceCellMode.PreparePvp
        end
      end
      table.insert(enemySlotItem, {
        petCfgId = 0,
        cellMode = cellMode,
        catchItem = catch_Item
      })
    end
  end
  self.bind.list_enemyPet:clear()
  self.bind.list_enemyPet:insert_array(enemySlotItem)
end

function cls:checkSkillUsable()
  local curSkillInfo = self.curFormationSkillData[self.selectFormationSlotId]
  for _, v in ipairs(curSkillInfo) do
    if not L_PetDuelStore:checkSkillCanUse(self.levelId, v.skill_id) then
      L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_04")
      return false
    end
  end
  return true
end

function cls:getRandomMap(t)
  local keys = {}
  for k in pairs(t) do
    table.insert(keys, k)
  end
  local randomKey = keys[math.random(1, #keys)]
  return randomKey
end

function cls:onBtnStartDuel()
  if self.gameMode == L_PetConst.PetDuelGameType.Arena then
    if self.dungeonId == 0 or self.mode == L_PetConst.PetDuelFormationType.pvpMatch then
      local dungeonData = _dungeonTpl:getKiboArenaPvpDungeonData()
      self.dungeonId = self:getRandomMap(dungeonData)
    end
    self:saveFormationInfoNew()
    self:applyFormationSlot()
    self.noSave = true
    C_PetDuelArenaManager.ReqEnterKiboArenaGame(self.dungeonId)
    return
  end
  if self.Cond_notAllPetUseable then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_05")
    return
  end
  if not self.Cond_miniKiboNum then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_02", {
      [0] = self.minimumKibo
    })
    return
  end
  if not self.Cond_skillUsable then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetPrepareDuel_03")
    return
  end
  if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petDuelNpcType) then
    return
  end
  local kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
  local duelGroup = kiboDuelGroupTpl:getTplById(self.levelId)
  if duelGroup then
    local entrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
    local tpl = entrustTypeTpl:getTplById(L_Const.EntrustTypeEnum.PetDuel)
    local systemId = entrustTypeTpl:getSystemUnLockId(tpl)
    if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(systemId) then
      return
    end
  end
  if self.isRestore ~= nil and self.isRestore == true and not string.isEmpty(self.restorePage) then
    c_UIRestore.TagUIRestoreData(self.restorePage)
  end
  C_KiBoDuelLuaWrapper.SetCurrentLevel(self.levelId)
  if L_EntrustStore:isActivityEntrustLevel(self.levelId) then
    if self.levelId ~= 0 then
      local buffList = L_EntrustStore:getEntrustBuffByLevelId(self.levelId)
      if buffList ~= nil then
        C_KiBoDuelLuaWrapper.SetCurrentLevelBuff(buffList)
      end
      L_GameEventStore:req_CSProtoKiboDuelGetGroup(self.levelId, function()
        if self.levelMode ~= L_PetConst.PetDuelChallengeMode.ChapterLevel then
          return
        end
        local keyWithoutMode = L_PetDuelStore:getLastLevelIdSaveKey()
        C_PlayerPrefsUtility.SetInt(keyWithoutMode, self.levelId)
        local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(self.levelId)
        local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
        local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
        local keyWithMode = L_PetDuelStore:getLastLevelIdSaveKey(_kiboDuelChapterTpl:getModeId(kiBoDuelChapterCfg))
        C_PlayerPrefsUtility.SetInt(keyWithMode, self.levelId)
      end)
    else
      errorf("活动" .. "not found activityId for levelId" .. tostring(self.levelId), 2)
    end
    return
  end
  L_PetDuelStore:req_CSProtoKiboDuelStart(self.levelId, function()
    if self.levelMode ~= L_PetConst.PetDuelChallengeMode.ChapterLevel then
      return
    end
    local keyWithoutMode = L_PetDuelStore:getLastLevelIdSaveKey()
    C_PlayerPrefsUtility.SetInt(keyWithoutMode, self.levelId)
    local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(self.levelId)
    local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
    local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
    local keyWithMode = L_PetDuelStore:getLastLevelIdSaveKey(_kiboDuelChapterTpl:getModeId(kiBoDuelChapterCfg))
    C_PlayerPrefsUtility.SetInt(keyWithMode, self.levelId)
  end)
end

function cls:onStartMatch()
  if not self.enemyPlayerId then
    if not self.match then
      if self.isRank then
        if C_PetDuelArenaManager.CheckAndTipIsInMatchTime() then
          self:handleStartMatch()
        end
      else
        self:handleStartMatch()
      end
    end
  elseif self.gameMode == L_PetConst.PetDuelGameType.Arena then
    C_PetDuelArenaManager.ReqEnterKiboArenaGame(self.dungeonId)
    return
  end
end

function cls:onCancelMatch()
  if not self.enemyPlayerId and self.match then
    self:handleCancelMatch()
  end
end

function cls:onReady()
  if self._readyCD then
    return
  end
  if not self.ready and self.enemyPlayerId then
    self:_startReadyCD()
    self:handleReady(true)
    if self.enemyUIStatus == L_PetConst.PetDuelPlayerState.Ready then
      self:onStartGameCountdown()
    end
  end
end

function cls:onCancelReady()
  if self._readyCD then
    return
  end
  if self.ready and self.enemyPlayerId then
    self:_startReadyCD()
    self:handleReady(false)
    if self.onStartGameCD then
      self:handleCancelStartGameCountdown()
    end
  end
end

function cls:_startReadyCD()
  self._readyCD = true
  L_TimerManager:newOrResetTimer(self, "readyCD", function()
    self._readyCD = false
  end, 0.5, 1)
end

function cls:onStartGameCountdown()
  if self.onStartGameCD then
    return
  end
  L_TimerManager:stopTimer(self, "cancelCountdownDelay")
  L_AudioUtil.playSound("Play_SFX_System_QiboBattle_20_Countdown")
  self.bind.active_multiBg = true
  self.bind.active_startGameRoot = true
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
  self.bindComponents.PrepareRoot_upLayerAnim:Play("anim_PrepareRoot_upLayer_in")
  self.onStartGameCD = true
  self.startGameTimer = _gameConstTpl:getData("KIBO_DUEL_PVP_INVITE_PALY_COUNTDOWN", L_Const.GameTplType.int)
  self.bind.txt_startGameCounter = tostring(self.startGameTimer)
  L_TimerManager:newOrResetTimer(self, "petDuelPvpCountdown", function()
    self.startGameTimer = self.startGameTimer - 1
    if self.startGameTimer <= 0 then
      L_TimerManager:stopTimer(self, "petDuelPvpCountdown")
    end
    self.bind.txt_startGameCounter = tostring(self.startGameTimer)
  end, 1, -1)
end

function cls:handleCancelStartGameCountdown()
  self.onStartGameCD = false
  self.bindComponents.PrepareRoot_upLayerAnim:Play("anim_PrepareRoot_upLayer_out")
  L_TimerManager:newOrResetTimer(self, "cancelCountdownDelay", function()
    self.bind.active_multiBg = false
    C_IntegrateMgr.TopBarModule:SetTopBarVisible(true)
    self.bind.active_startGameRoot = false
  end, 0.233, 1)
  L_TimerManager:stopTimer(self, "petDuelPvpCountdown")
end

function cls:handleStartMatch()
  self.match = true
  self.bind.active_rootMatchNode = true
  self.bind.active_multiBg = true
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
  self.bind.active_btnCancelMatch = true
  self.curAudio = L_AudioUtil.playSound("Play_SFX_System_QiboBattle_21_Matching")
  self.bindComponents.PrepareRoot_upLayerAnim:Play("anim_PrepareRoot_upLayer_in")
  self.matchTimer = 0
  self.bind.txt_matchTime = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. " (" .. tostring(self.matchTimer) .. "s)"
  L_TimerManager:newOrResetTimer(self, "petDuelPvpMatch", function()
    self.matchTimer = self.matchTimer + 1
    if self.matchTimer >= _gameConstTpl:getData("KIBO_DUEL_PVP_MATCH_TIME", L_Const.GameTplType.int) then
      self:handleCancelMatch()
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_44"))
    end
    if self.isRank and not C_PetDuelArenaManager.CheckAndTipIsInMatchTime() then
      self:handleCancelMatch()
    end
    self.bind.txt_matchTime = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. " (" .. tostring(self.matchTimer) .. "s)"
  end, 1, -1)
  C_PetDuelArenaManager.ReqStartMatchKiboArenaGamePvp(true, self.dungeonId, nil)
end

function cls:handleCancelMatch()
  self.match = false
  C_PetDuelArenaManager.ReqStartMatchKiboArenaGamePvp(false, self.dungeonId, nil)
  self.bindComponents.PrepareRoot_upLayerAnim:Play("anim_PrepareRoot_upLayer_out")
  L_AudioUtil.stopSound(self.curAudio)
  self.curAudio = nil
  L_AudioUtil.playSound("Play_SFX_System_QiboBattle_21_Matching_Stop")
  L_TimerManager:newOrResetTimer(self, "cancelMatchDelay", function()
    self.bind.active_btnCancelMatch = false
    self.bind.active_btnBlack = true
    self.bind.active_rootMatchNode = false
    self.bind.active_multiBg = false
    C_IntegrateMgr.TopBarModule:SetTopBarVisible(true)
  end, 0.233, 1)
  L_TimerManager:stopTimer(self, "petDuelPvpMatch")
end

function cls:handleReady(isReady)
  self.ready = isReady
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(not isReady)
  self.bind.active_btnCancelMatch = isReady
  if isReady then
    self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.Ready)
  else
    self.modules.module_playerReady:setPlayerState(L_PetConst.PetDuelPlayerState.unReady)
  end
end

function cls:showCostConfirmTips(confimCallback)
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_kiboDuel_09"),
    txtContent = L_WordsTpl:getValue("ui_kiboDuel_10"),
    confirmCallback = function()
      if confimCallback ~= nil then
        confimCallback()
      end
    end
  }
  L_GameUtil.showCommonTip(data)
end

function cls:handleSaveConfirm()
  local saveSlot = self.selectFormationSlotId
  local isSame = L_PetDuelStore:checkArenaFormationChange(saveSlot, self.curFormationPetData[self.selectFormationSlotId], self.curFormationHeroData[self.selectFormationSlotId], self.curFormationSkillData[self.selectFormationSlotId])
  if isSame then
    self:onEditFormation(false, true)
  else
    local data = {
      txtContent = L_WordsTpl:getValue("notice_option_secondconfirm"),
      txtCancel = L_WordsTpl:getValue("ui_kibo_duel_giveup"),
      txtConfirm = L_WordsTpl:getValue("ui_kibo_duel_save"),
      confirmCallback = function()
        self:onEditFormation(false)
      end,
      cancelCallback = function()
        local petUids = {}
        if self.gameMode == L_PetConst.PetDuelGameType.Arena then
          for _, v in ipairs(L_PetDuelStore:getPetDuelArenaFormationPetGuids(self.selectFormationSlotId)) do
            table.insert(petUids, {
              is_trial = v.is_trial,
              id = v.id
            })
          end
        elseif self.gameMode == L_PetConst.PetDuelGameType.Battle then
          for _, v in ipairs(L_PetDuelStore:getPetDuelFormationPetGuids(self.selectFormationSlotId)) do
            table.insert(petUids, {
              is_trial = v.is_trial,
              id = v.id
            })
          end
        end
        self.curFormationPetData[self.selectFormationSlotId] = petUids
        self:refreshPlayerFormationInfo()
        self:onEditFormation(false, true)
      end
    }
    L_GameUtil.showCommonTip(data)
  end
end

function cls:closeCheck()
  if self.gameMode == L_PetConst.PetDuelGameType.Arena and L_PetDuelStore:checkCostCondition(self.curFormationPetData[self.selectFormationSlotId]) then
    self:showCostConfirmTips(function()
      self:revertArenaFormationSlotData(self.selectFormationSlotId)
      self.setSelectTabIdCallBack(L_FormationConst.FormationType.world)
    end)
    return false
  end
  return true
end

function cls:backToMainHandle()
  if self.ready or self.bind.active_multiBg or self.match or self.bind.active_matchSucRoot then
    return
  end
  L_UI:backToRoot()
end

function cls:escHandle()
  if self.isPlayingAnimation == true then
    return
  end
  if self.ready or self.bind.active_multiBg or self.match or self.bind.active_matchSucRoot then
    return
  end
  if self.bind.active_heroGrid then
    if self.isLoadingHero then
      return
    end
    self:onBtnChangeHero(false, true)
    return
  end
  if self.isSubFormation then
    if self.gameMode == L_PetConst.PetDuelGameType.Arena and L_PetDuelStore:checkCostCondition(self.curFormationPetData[self.selectFormationSlotId]) then
      self:showCostConfirmTips(function()
        self.noSave = true
        if self.dontBack2RootWhenClose then
          L_UI:close(self.pageName)
          return
        end
        L_UI:backToRoot()
      end)
      return
    end
    if self.dontBack2RootWhenClose then
      L_UI:close(self.pageName)
      return
    end
    L_UI:backToRoot()
    return
  end
  if self.bind.active_petEdit then
    if self.gameMode == L_PetConst.PetDuelGameType.Arena and L_PetDuelStore:checkCostCondition(self.curFormationPetData[self.selectFormationSlotId]) then
      self:showCostConfirmTips(function()
        self:revertArenaFormationSlotData(self.selectFormationSlotId)
        self:onEditFormation(false, true)
      end)
      return
    end
    self:handleSaveConfirm()
    return
  end
  L_UI:close(self.pageName)
end

function cls:show()
  C_UISceneManager.SetSceneVisible()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetDuel)
  self:regisShortCut()
  if L_CommonUtil.isValid(self.petDuelFormationSceneGo) then
    L_CommonUtil.setObjActive(self.petDuelFormationSceneGo, true)
    C_UIMgr.CloseCutin()
  end
  self:initCommonTopModule()
  if self.heroPosition then
    self.heroParent.position = self.heroPosition
  end
  if self.hideCallback then
    self.hideCallback(true)
  end
end

function cls:hide()
  if L_CommonUtil.isValid(self.petDuelFormationSceneGo) then
    L_CommonUtil.setObjActive(self.petDuelFormationSceneGo, false)
    self:recycleEffectModel()
    self:recycleNpcEffectModel()
  end
  self.heroPosition = self.heroParent.position
  if self.hideCallback then
    self.hideCallback(false)
  end
end

function cls:close(options)
  self:configTouch("-")
  if self.match then
    self:handleCancelMatch()
  elseif self.mode == L_PetConst.PetDuelFormationType.pvpMatch then
    C_PetDuelArenaManager.ReqStartMatchKiboArenaGamePvp(false, self.dungeonId, nil)
  end
  if self.entity then
    self.entity:onDestroy()
  end
  if self.curAudio then
    L_AudioUtil.stopSound(self.curAudio)
    self.curAudio = nil
  end
  if self.curAudioBg then
    L_AudioUtil.stopSound(self.curAudioBg)
    self.curAudioBg = nil
  end
  if self.isSubFormation and self.closeCallback then
    self.closeCallback()
  end
  if L_UI:checkPageOpen("pageKiboDuelInviteWaiting") then
    L_UI:close("pageKiboDuelInviteWaiting")
  end
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
  L_ShortCutManager:removeShortCut(self.pageName)
  if not self.isCallClose and self.enemyPlayerId and not self.bind.active_multiBg and (self.mode == L_PetConst.PetDuelFormationType.pvpMatch or self.mode == L_PetConst.PetDuelFormationType.pvpInvite) then
    C_PetDuelArenaManager.ReqLeaveRoom()
  end
  self:recycleEffectModel()
  self:recycleNpcEffectModel()
  self:recycleFakeLight()
  L_UIModelMgr:RecycleHeroEnvironment()
  L_UIModelMgr:RecycleHeroModel()
  L_UIModelMgr:RecycleViceHeroModel()
  self:recycleEnemyPlayerModel()
  C_UISceneManager.SetSceneVisible()
  if not self.noSave then
    self:saveFormationInfoNew()
    self:applyFormationSlot()
  end
  self:killAutoDragTimer()
  self._petSortFilter = nil
  self._petTotalDataList = nil
  if self._unityEvent and self._eventCb then
    self._unityEvent:RemoveListener(self._eventCb)
  end
  L_TimerManager:clearTimer(self)
  self:unRegisterEventListeners()
  local list = C_VarList:Get()
  list:AddString("pagePetDuelMain")
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnInteractPageClose, list)
  cls.super.close(self, options)
end

function cls:check(options, callback)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.KiboDuel, true) then
    callback(false)
    return
  end
  if C_IntegrateMgr.SystemUnlockModule:CheckBanSystemAndTip(L_SystemConst.enum.petDuelTask) then
    callback(false)
    return
  end
  if C_IntegrateMgr.SystemUnlockModule:CheckBanSystemAndTip(L_SystemConst.enum.petDuelNpcType) then
    callback(false)
    return
  end
  callback(true)
end

function cls:destroy()
  cls.super.destroy(self)
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
end

return cls
