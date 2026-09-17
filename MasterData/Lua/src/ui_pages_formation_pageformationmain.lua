local this = class("pageFormationMain", G_UIPageBase)
local MinFormationIndex = 1
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    go_loadingMask = nil,
    go_overlook = true,
    go_btnEnableFormation = true,
    go_listBtnAdd = false,
    list_btnAdd = {
      moduleName = "pages/formation/formationModule/cellTeamBtnAdd"
    },
    list_hud = {
      moduleName = "pages/formation/formationModule/cellTeamUnitHud"
    },
    go_teamInfo = false,
    txt_teamName = "",
    txt_teamIndex = nil,
    list_formationIndexTab = {
      moduleName = "pages/formation/formationModule/cellTeamPresetTip"
    },
    go_editHero = false,
    modulesSelectHeros = {
      type = "toggleModule",
      modulesSelectHero = {
        assetName = "UI/CommonModules/Unit/moduleSelectHero",
        moduleName = "modulePages/unit/moduleSelectHero"
      }
    },
    toggleSelectHeroStatus = "",
    go_editPet = false,
    modulesSelectPets = {
      type = "toggleModule",
      modulesSelectPet = {
        assetName = "UI/CommonModules/Unit/moduleSelectPet",
        moduleName = "modulePages/unit/moduleSelectPet"
      }
    },
    toggleSelectPetStatus = "",
    txt_posIndex = nil,
    go_listHud = nil,
    go_nodeCommon = nil,
    go_btnPresetTeam = nil
  }
end

function this.methods()
  return {
    onClick_quickFormation = function(self)
      if self.isSubFormation then
        self._setShowCallBack(false)
      end
      L_UI:open("pageQuickFormation", {
        formationType = L_FormationManager:getRuntimeFormationType(),
        teamIndex = L_FormationManager:getRuntimeFormationIndex(),
        vfxCb = function(teamInfo)
          self:playRandHeroVoice(teamInfo)
        end,
        failure_jump = self.options.failure_jump
      })
    end,
    onClick_enableFormation = function(self)
      local curFormationType = L_FormationManager:getRuntimeFormationType()
      local curFormationIndex = L_FormationManager:getRuntimeFormationIndex()
      local posData = L_FormationStore:getFormationPosData(curFormationType, curFormationIndex)
      local curPosData = {}
      for i, guid in ipairs(posData) do
        curPosData[i] = {
          hero_guid = guid,
          pet_guid = L_FormationStore:getFormationPosPetGuid(curFormationType, curFormationIndex, i)
        }
      end
      
      local function _confirmFunc()
        L_FormationManager:switchGroup(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), function()
          self.bind.go_btnEnableFormation = false
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_DefaultEnable"))
        end)
      end
      
      L_FormationManager:checkPetRuleEnableFormation(curPosData, _confirmFunc)
    end,
    onClick_last = function(self)
      self:changeTeamIndex(-1)
    end,
    onClick_next = function(self)
      self:changeTeamIndex(1)
    end,
    onClick_emptyArea = function(self)
      self:onClickEmptyArea()
    end,
    onClick_editTeamName = function(self)
      local systemId = L_SystemConst.enum.renameTeam
      if L_SystemBreakManager:checkBanSystemAndTip(systemId) then
        return
      end
      local data = {
        txtTitle = L_WordsTpl:getValue("notice_pageFormationMain_04"),
        placeHolder = L_WordsTpl:getValue("ui_formaitonName"),
        limit = 7,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        confirmCallback = function(txt)
          if string.isEmpty(string.trim(txt)) then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_03")
            return
          end
          if string.gsub(txt, " ", "") ~= txt then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_02")
            return
          end
          AzurWorld.formationMgr:ReqChangeFormationName(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), txt)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end,
    list_btnAdd = {
      onClick_addHero = function(self, bind)
        local editStatus = L_FormationManager:getEditStatus()
        if editStatus == L_FormationConst.FormationEditStatus.EditHero then
          if bind.posIndex == L_FormationManager:getFocusIndex() then
            return
          end
          self.isOnClickAdd = true
          self.onAddIndex = bind.posIndex
          self.nowSelectHeroIndex = bind.posIndex
          L_FormationManager:setFocusIndex(bind.posIndex)
          self:initEditHeroView()
          self:initEditHeroViewWithEntity()
          self:initSelectHeroModule()
        else
          self:editHeroByPos(bind.posIndex)
        end
      end,
      onClick_addPet = function(self, bind)
        self.nowSelectHeroIndex = bind.posIndex
        self:editPetByPos(bind.posIndex)
      end,
      onClick_addSwitchPos = function(self, bind)
        self:changePos(bind.posIndex)
      end
    },
    onClick_presetTeam = function(self)
      self:onClickModulePresetTeam()
    end
  }
end

function this:onClickSelectPetCb(petGuid)
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.EditPet then
    return
  end
  local curFormationType = L_FormationManager:getRuntimeFormationType()
  local curFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  local posData = L_FormationStore:getFormationPosData(curFormationType, curFormationIndex)
  local curPosData = {}
  for i, guid in ipairs(posData) do
    curPosData[i] = {
      hero_guid = guid,
      pet_guid = L_FormationStore:getFormationPosPetGuid(curFormationType, curFormationIndex, i)
    }
  end
  self.petCameraSwitchFlag = nil
  local curPosHero = L_FormationStore:getFormationPosData(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())[L_FormationManager:getFocusIndex()]
  local curPosPet = L_FormationStore:getFormationPosPetGuid(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex())
  if curPosPet == petGuid then
    self.isRemovePet = true
    L_FormationManager:req_removePet(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex(), function()
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_remove"))
    end)
  else
    self.nowSelectHeroIndex = L_FormationManager:getFocusIndex()
    
    local function _confirmFunc()
      FrameScheduler.add(function()
        L_FormationManager:req_addPet(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex(), petGuid, function()
          self:PlayVoice(curPosHero)
        end)
      end)
    end
    
    local usingIndex = L_FormationStore:getUsingTeamIndex(L_FormationManager:getRuntimeFormationType())
    if usingIndex == L_FormationManager:getRuntimeFormationIndex() then
      if not L_FormationManager:checkCanChangeFormationPet(petGuid, _confirmFunc) then
        return
      end
      _confirmFunc()
    else
      _confirmFunc()
    end
  end
end

function this:PlayVoice(curPosHero)
  if self.bInVoiceCD then
    return
  end
  self.bInVoiceCD = true
  local configId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(curPosHero))
  L_AudioUtil.playSound("Play_VO_System_" .. configId .. "_Forming")
  self:newOrResetTimer("voiceCD", function()
    self.bInVoiceCD = false
  end, 3)
end

function this:onVFXPlayHidePetCb()
  self.bind.go_editPet = false
end

function this:onClickSelectHeroCb(heroGuid, callBack)
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.EditHero then
    return
  end
  local posData = L_FormationStore:getFormationPosData(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())
  self.onAddIndex = L_FormationManager:getFocusIndex()
  if heroGuid == posData[L_FormationManager:getFocusIndex()] then
    self.onRemoveIndex = L_FormationManager:getFocusIndex()
    L_FormationManager:req_removeHero(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex(), function()
      C_AudioManager.Play("Play_SFX_System_UI_Team_Character_Remove")
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_remove"))
      if callBack then
        callBack()
      end
    end)
  else
    local oriPlace = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), heroGuid)
    if 0 < oriPlace then
      self.switchHeroBtnIndex = true
      self.switchHeroHudIndex = true
    end
    self.nowSelectHeroIndex = L_FormationManager:getFocusIndex()
    L_FormationManager:req_addHero(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex(), heroGuid, function()
      local heroData = L_HeroStore:getHero(heroGuid)
      C_AudioManager.Play("Play_SFX_System_UI_Team_Character_Deploy")
      self._nextPlayAudioTime = self._nextPlayAudioTime or 0
      if L_TimeUtil.getServerTime() >= self._nextPlayAudioTime then
        L_HeroVoiceManager:playHeroVoice(string.format("Play_VO_System_%s_Forming", L_HeroStore:getHeroConfigId(heroData)))
        self._nextPlayAudioTime = L_TimeUtil.getServerTime() + L_GameConstTpl:getData("CHAR_VOICE_TEAM_INTERVAL", L_Const.GameTplType.int) / 1000
      end
      if callBack then
        callBack()
      end
    end)
  end
end

function this:onVFXPlayHide()
  self.bind.go_editHero = false
end

function this:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsInTeaching() then
    callback(false)
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Formation, true) then
    callback(false)
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_transform_02"))
    callback(false)
    return
  end
  if L_FormationStore:getIsTrailFormation(L_FormationManager:getCurFormationType()) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageFormationMain_01"))
    callback(false)
    return
  end
  if (not options or not options.ignoreProxyType) and AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageFormationMain_01"))
    callback(false)
    return
  end
  if L_BattleDataManager:checkPlayerBattle() and not options.failure_jump then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.FormationSetting))
    callback(false)
    return
  end
  if not C_IntegrateMgr.SystemUnlockModule:CheckBanSystemAndTip(L_SystemConst.enum.formation) then
    callback(false)
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.formation)
  if not L_FormationManager:checkCanChangeFormation() then
    callback(false)
    return
  end
  callback(result)
end

function this:onTopBarRefresh()
  self:initCommonTopModule()
end

function this:created(obj, config, binderData)
  this.super.created(self, obj, config, binderData)
  if (self.options == nil or not L_CommonUtil.isValid(self.options.sceneObj)) and self.csharpPage ~= nil then
    self.wait = self.csharpPage:AddWaitComponent()
    local curSceneId = AzurWorldInstance.CurWorldId
    local formationScene = L_GameTpl:getWorldCityTpl():getFormationScene(curSceneId)
    local scenePath = L_CommonUtil.getMultiPlatformScenePath(string.concat("Program/UIScene/Formations/pre_formation_ui_", formationScene, ".prefab"))
    C_UIMgr.uiLoader:SpawnAsync(scenePath, function(instanceId, obj)
      if L_CommonUtil.isValid(obj) then
        C_UISceneManager.SetSceneVisible()
        self.sceneObj = obj
        self.wait:WaitOver(true)
      else
        self.wait:WaitOver(false)
      end
      C_UIMgr.CloseCutin()
    end, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page), false, true)
  end
end

function this:preOpen(options)
  L_SettingStore:setTempRenderScale("150")
  this.super.preOpen(self, options)
  C_UISceneManager.SetSceneVisible()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.Formation)
  self.isTop = true
  if options then
    self.options = options
    self.closeCallback = options.callback
    self.isSubFormation = options.isSubFormation
    
    function self._setShowCallBack(isShow)
      if options.setShowCallBack then
        options.setShowCallBack(isShow)
      end
      L_FormationManager:sendEvent(L_FormationManager.event.showFormations, isShow)
    end
    
    self.sceneObj = self.sceneObj or options.sceneObj
    if L_CommonUtil.isValid(self.sceneObj) then
      self.sceneObj:SetActive(true)
    else
      C_MJLogger:LogError("[pageFormationMain] preOpen options.sceneObj is nil")
    end
  end
  L_FormationManager:loadFormationScene(self.sceneObj)
  self.formationType = options and options.formationType or L_FormationConst.FormationType.world
  L_FormationManager:setRuntimeFormationType(self.formationType)
  L_FormationManager:setRuntimeFormationIndex(L_FormationStore:getUsingTeamIndex(L_FormationManager:getRuntimeFormationType()))
  self._ESyncFormationServerDataHandler = handler(self, self.onEvent_refreshFormation)
  AzurWorld.formationMgr:RegisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshFormation)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerDataList, self._ESyncHeroServerDataHandler)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshFormation, self, nil, 0)
  self._lateUpdateHandle = L_CommonUtil.handle(self.onLateUpdate_displayFollow, self)
  C_UpdateSource.AddLateUpdateEventHandler(self._lateUpdateHandle, "FormationMainPage.lateUpdate")
  self._dragStartPosX = 0
  self.onAddIndex = nil
  self.lastEditStatus = nil
  self.nowSelectHeroIndex = nil
  self.onRemoveIndex = nil
  self.switchHeroBtnIndex = false
  self.switchHeroHudIndex = false
  self.isOnClickAdd = false
  self.isRemovePet = false
  self:initPage()
  self.dontBack2RootWhenClose = options and options.dontBack2RootWhenClose or false
  if AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter then
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = true
  end
  self.bind.go_listHud = false
  self.bind.go_nodeCommon = false
  self:initModulePresetTeam()
end

function this:open()
end

function this:show()
  C_UIMgr.CloseCutin()
  self.isShow = true
  local isKiboDuelOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petDuelNpcType)
  if self.isSubFormation and isKiboDuelOpen then
    L_UI:open("pageFormations")
  end
  FrameScheduler.add(function()
    if L_FormationManager.runtimeData then
      L_FormationManager.runtimeData:refreshBlend()
    end
  end, 1)
  L_SettingStore:setTempRenderScale("150")
  if not self.isTop then
  end
  L_TimerManager:clearTimer(self)
  L_FormationManager:setSceneArtActive(true)
  self:configTouch("+")
  local status = L_FormationManager:getEditStatus()
  if L_FormationManager:getNeedRevertFormationScene() then
    self:initFormationModel()
    self:initHudList()
    if status == L_FormationConst.FormationEditStatus.Overlook then
      self:initOverlookView()
      self:initAddBtnList()
    elseif status == L_FormationConst.FormationEditStatus.EditHero then
      self:initEditHeroView()
      self:initEditHeroViewWithEntity()
      self:initSelectHeroModule()
    elseif status == L_FormationConst.FormationEditStatus.EditPet then
      self:initEditPetView()
      self:initSelectPetModule()
    end
    L_FormationManager:revertFormationScene()
  end
  if status == L_FormationConst.FormationEditStatus.EditPet then
    self:initSelectPetModuleScript()
    self.modules.modulesSelectPets.modulesSelectPet:refreshContent()
  end
  if self.isSubFormation and status == L_FormationConst.FormationEditStatus.Overlook then
    self._setShowCallBack(true)
  end
  self:initCommonTopModule()
  if self._setShowCallBack then
    self._setShowCallBack(true)
  end
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.Formation)
end

function this:hide()
  if self.isOpenPresetTeam then
    self.isOpenPresetTeam = false
    self.modulePresetTeam:DoClose()
  end
  self.isShow = false
  L_SettingStore:revertRenderScale()
  L_FormationManager:setSceneArtActive(false)
  self:configTouch("-")
  if not L_UI:getPage("pagePetDuelMain") and self._setShowCallBack then
    self._setShowCallBack(false)
  end
end

function this:close(options)
  L_UI:close("pageFormations")
  L_SettingStore:revertRenderScale()
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
  L_AudioUtil.stopSound(self._petVoiceWrap)
  if self._lateUpdateHandle then
    C_UpdateSource.RemoveLateUpdateEventHandler(self._lateUpdateHandle)
  end
  self._lateUpdateHandle = nil
  AzurWorld.formationMgr:UnregisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerDataList, self._ESyncHeroServerDataHandler)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshFormation, self, nil, 0)
  C_PrefabManager:RecycleByLoader(self.sceneObj)
  L_FormationManager:removeFormationScene()
  self.sceneObj = nil
  if AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter then
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
  end
  if self.isSubFormation and self.closeCallback then
    self.closeCallback()
  end
  C_UISceneManager.SetSceneVisible()
  if not self.isFormationSaved then
    self:saveWorldFormationClose()
  end
end

function this:escHandle()
  if self.isOpenPresetTeam then
    self.isOpenPresetTeam = false
    self.modulePresetTeam:DoClose()
    return
  end
  local editStatus = L_FormationManager:getEditStatus()
  if editStatus == L_FormationConst.FormationEditStatus.EditPet then
    if self.isSelectPetModuleInited and not self.modules.modulesSelectPets.modulesSelectPet:escHandle() then
      L_FormationManager:setPetSwitchStatus(false)
      self:closeEditPet()
    end
  elseif editStatus == L_FormationConst.FormationEditStatus.EditHero then
    if self._isChangePosMode then
      self:closeChangePosView()
      self:initEditHeroView()
      self:initEditHeroViewWithEntity()
      self:initSelectHeroModule()
      self:initHudList()
    elseif self.isSelectHeroModuleInited and not self.modules.modulesSelectHeros.modulesSelectHero:escHandle() then
      self:closeEditHero()
    end
  elseif editStatus == L_FormationConst.FormationEditStatus.Overlook then
    self:closeCurPage()
  end
end

function this:onTopChange(options)
  if options.topLv == 0 and 0 < options.lastTopLv and not self.isTop then
    local options = self.options
    L_FormationManager:loadFormationScene(self.sceneObj)
    L_FormationManager:setRuntimeFormationType(options and options.formationType or L_FormationConst.FormationType.world)
    L_FormationManager:setRuntimeFormationIndex(self.remFormationIndex or L_FormationStore:getUsingTeamIndex(L_FormationManager:getRuntimeFormationType()))
    L_FormationManager:setEditStatus(self.remStatus)
    if self.remStatus == L_FormationConst.FormationEditStatus.EditHero or self.remStatus == L_FormationConst.FormationEditStatus.EditPet then
      L_FormationManager:setFocusIndex(self.remPos)
    end
    self.bind.go_btnPresetTeam = self.remStatus ~= L_FormationConst.FormationEditStatus.EditPet
    self.remFormationIndex = nil
    self.remStatus = nil
    self.remPos = nil
    L_FormationManager:setNeedRevertFormationScene(true)
    self.isTop = true
  elseif options.topLv == 1 and options.lastTopLv < 1 and self.isTop then
    self.isTop = false
    self.remFormationIndex = L_FormationManager:getRuntimeFormationIndex()
    self.remStatus = L_FormationManager:getEditStatus()
    if self.remStatus == L_FormationConst.FormationEditStatus.Switching then
      self.remStatus = L_FormationConst.FormationEditStatus.Overlook
    end
    self.remPos = L_FormationManager:getFocusIndex()
    L_FormationManager:removeFormationScene()
  end
end

function this:initPage()
  self:initTeamInfo()
  self:initOverlookView()
  self:initAddBtnList()
  self:initFormationModel()
  self:initHudList()
end

function this:initCommonTopModule()
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(handler(self, self.escHandle))
  if self.isSubFormation then
    C_IntegrateMgr.TopBarModule:SetTopBarMainBtnFunc(function()
      local options = {}
      options.mode = L_Const.loadingMode.saveFormation
      
      function options.showCallback()
        C_UIMgr.OpenCutin(1, function()
          L_UI:backToRoot()
          AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
          AzurWorld.playerMgr.myPlayerUnitAdapter:ResumePlayerUnit(nil, true, true)
          C_UIMgr.CloseCutin()
        end)
      end
      
      L_LoadingManager:openSaveFormationLoading(options, function()
      end)
    end)
    if L_FormationManager:getEditStatus() == L_FormationConst.FormationEditStatus.Overlook then
      self._setShowCallBack(true)
    end
  end
end

function this:initOverlookView()
  self.bind.go_overlook = true
  self.bind.go_teamInfo = true
  self:initTeamInfo()
  self:initBtnGroup()
end

function this:initTeamInfo()
  local runtionFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  if self._lastTeamIndex ~= runtionFormationIndex then
    self.bindComponents.ani_node_teamInfo:Stop()
    self.bindComponents.ani_node_teamInfo:Play("anim_formation_team_name_show")
    self._lastTeamIndex = runtionFormationIndex
  end
  self.bind.txt_teamName = L_FormationStore:getFormationName(L_FormationManager:getRuntimeFormationType(), runtionFormationIndex)
  self.bind.txt_teamIndex = string.format("%02d", runtionFormationIndex)
  self:initFormationIndexTabList()
end

function this:initFormationIndexTabList()
  local formationCount = L_FormationConst.FormationTeamPresetCount[L_FormationManager:getRuntimeFormationType()]
  local temp = {}
  local runtimeFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  local usingTeamIndex = L_FormationStore:getUsingTeamIndex(L_FormationManager:getRuntimeFormationType())
  for i = 1, formationCount do
    local isSelect = i == runtimeFormationIndex
    local isUse = i == usingTeamIndex
    table.insert(temp, {
      normal = not isSelect,
      active = isSelect
    })
  end
  self.bind.list_formationIndexTab:clear()
  self.bind.list_formationIndexTab:insert_array(temp)
end

function this:initFormationModel(isSync)
  local runtimeFormationType = L_FormationManager:getRuntimeFormationType()
  local runtimeFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  local posData = L_FormationStore:getFormationPosData(runtimeFormationType, runtimeFormationIndex)
  self.loadingCount = 0
  local isLoadingShowing = false
  for index = 1, L_FormationConst.FormationPosNum do
    self.loadingCount = self.loadingCount + 1 + 1
    if not isLoadingShowing then
      self:refreshLoadingMask()
      isLoadingShowing = true
    end
    local heroId = posData[index]
    local petId = L_FormationStore:getFormationPosPetGuid(runtimeFormationType, runtimeFormationIndex, index)
    L_FormationManager:loadHeroModelAtPlaceAsync(heroId, index, isSync, function()
      if not L_CommonUtil.isValid(self.gameObject) then
        return
      end
      if self.loadingCount > 0 then
        self.loadingCount = self.loadingCount - 1
      end
      self:refreshLoadingMask()
    end)
    L_FormationManager:loadPetModelAtPlaceAsync(petId, index, function()
      if not L_CommonUtil.isValid(self.gameObject) then
        return
      end
      if self.loadingCount > 0 then
        self.loadingCount = self.loadingCount - 1
      end
      self:refreshLoadingMask()
    end)
  end
end

function this:initHudList()
  local runtimeFormationType = L_FormationManager:getRuntimeFormationType()
  local runtimeFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  local hero = L_Const.roleType.hero
  local pet = L_Const.roleType.pet
  local posData = L_FormationStore:getFormationPosData(runtimeFormationType, runtimeFormationIndex)
  local temp = {}
  for index = 1, L_FormationConst.FormationPosNum do
    local heroId = posData[index]
    local petId = L_FormationStore:getFormationPosPetGuid(runtimeFormationType, runtimeFormationIndex, index)
    if not math.isEmpty(heroId) and (not self._isChangePosMode or self._isChangePosMode and index ~= L_FormationManager:getFocusIndex()) then
      table.insert(temp, {
        roleType = hero,
        roleId = heroId,
        changePosMode = self._isChangePosMode,
        index = index,
        needDownBtn = true,
        setTopTabHide = self._setShowCallBack
      })
    end
    if not self._isChangePosMode and not math.isEmpty(petId) then
      table.insert(temp, {
        roleType = pet,
        roleId = petId,
        index = index,
        needDownBtn = true,
        setTopTabHide = self._setShowCallBack
      })
    end
  end
  self.bind.list_hud:clear()
  self.bind.list_hud:insert_array(temp)
  self:setHudAlpha(1, L_FormationManager:getEditStatus())
end

function this:refreshHudList()
  local list = self.modules.list_hud
  for i, hud in pairs(list) do
    hud:setFollow()
  end
end

function this:initAddBtnList(toEditStatus)
  local editStatus = toEditStatus or L_FormationManager:getEditStatus()
  self.bind.go_listBtnAdd = true
  local posData = L_FormationStore:getFormationPosData(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())
  local temp = {}
  for index = 1, L_FormationConst.FormationPosNum do
    local heroId = posData[index]
    if editStatus == L_FormationConst.FormationEditStatus.Overlook then
      if math.isEmpty(heroId) then
        table.insert(temp, {
          posIndex = index,
          roleType = L_Const.roleType.hero,
          isPlayAnim = true
        })
      end
    elseif editStatus == L_FormationConst.FormationEditStatus.EditHero then
      local petId = L_FormationStore:getFormationPosPetGuid(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), index)
      local isPlayAnim = true
      if self.onAddIndex and self.onAddIndex ~= 0 and index ~= self.onAddIndex or self.isOnClickAdd or self.switchHeroBtnIndex then
        isPlayAnim = false
      end
      if math.isEmpty(petId) and not math.isEmpty(heroId) and not self._isChangePosMode then
        table.insert(temp, {
          posIndex = index,
          roleType = L_Const.roleType.pet,
          isPlayAnim = isPlayAnim
        })
      elseif math.isEmpty(heroId) then
        table.insert(temp, {
          posIndex = index,
          roleType = L_Const.roleType.hero,
          isChangePosMode = self._isChangePosMode,
          isPlayAnim = isPlayAnim
        })
      end
    end
  end
  self.bind.list_btnAdd:clear()
  self.bind.list_btnAdd:insert_array(temp)
  self.isOnClickAdd = false
  self.onAddIndex = 0
  self.switchHeroBtnIndex = false
  if self.onRemoveIndex then
    local list = self.modules.list_btnAdd
    for i, add in pairs(list or {}) do
      if add:getPosIndex() == self.onRemoveIndex then
        add:playTeamBtnAnim()
        break
      end
    end
    self.onRemoveIndex = nil
  end
end

function this:refreshAddBtnList()
  local list = self.modules.list_btnAdd
  for i, hud in pairs(list or {}) do
    hud:setFollow()
  end
end

function this:initBtnGroup()
  if L_FormationManager:getRuntimeFormationType() == L_FormationConst.FormationType.world then
    local curIndex = L_FormationStore:getUsingTeamIndex(L_FormationManager:getRuntimeFormationType())
    self.bind.go_btnEnableFormation = curIndex ~= L_FormationManager:getRuntimeFormationIndex()
  end
end

function this:closeCurPage()
  local curTeamIndex = L_FormationStore:getUsingTeamIndex(L_FormationManager:getRuntimeFormationType())
  if curTeamIndex ~= L_FormationManager:getRuntimeFormationIndex() then
    local vaildHeroCount = L_FormationStore:getTeamHeroCount(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())
    if 0 < vaildHeroCount then
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("notice_formation_DefaultDisable"),
        confirmCallback = function()
          self:saveWorldFormation()
        end
      })
      return
    end
  end
  self:saveWorldFormation()
end

function this:_onCutinEnd_saveWorldFormationClosePage()
  L_UI:close(self.pageName)
  local adapter = AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter
  if adapter then
    adapter.pause = false
    adapter:ResumePlayerUnit(nil, true, true)
  end
  C_UIMgr.CloseCutin()
end

function this:_onCutinEnd_saveWorldFormationBackToRoot()
  L_UI:backToRoot()
  local adapter = AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter
  if adapter then
    adapter.pause = false
    adapter:ResumePlayerUnit(nil, true, true)
  end
  C_UIMgr.CloseCutin()
end

function this:saveWorldFormation()
  self.isFormationSaved = true
  local options = {}
  options.mode = L_Const.loadingMode.saveFormation
  
  function options.showCallback()
    if self.dontBack2RootWhenClose then
      C_UIMgr.OpenCutin(1, handler(self, self._onCutinEnd_saveWorldFormationClosePage))
      return
    end
    C_UIMgr.OpenCutin(1, handler(self, self._onCutinEnd_saveWorldFormationBackToRoot))
  end
  
  L_LoadingManager:openSaveFormationLoading(options, function()
  end)
end

function this:saveWorldFormationClose()
  AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
  AzurWorld.playerMgr.myPlayerUnitAdapter:ResumePlayerUnit(nil, true, true)
end

function this:changeTeamIndex(addNum)
  local presetCount = L_FormationConst.FormationTeamPresetCount[L_FormationManager:getRuntimeFormationType()] or 0
  local tmpIndex = L_FormationManager:getRuntimeFormationIndex() + addNum
  if presetCount < tmpIndex then
    tmpIndex = MinFormationIndex
  elseif tmpIndex < MinFormationIndex then
    tmpIndex = presetCount
  end
  if tmpIndex == L_FormationManager:getRuntimeFormationIndex() then
    return
  end
  L_FormationManager:setRuntimeFormationIndex(tmpIndex)
  self:initPage()
end

function this:editHeroByPos(index)
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.Overlook then
    return
  end
  self.bind.go_overlook = false
  self.bind.go_listBtnAdd = false
  L_FormationManager:setFocusIndex(index)
  L_TimerManager:newOrResetTimer(self, "editHeroByPos_VFX", function()
    self:initSelectHeroModule()
    self:initEditHeroView()
    self:initEditHeroViewWithEntity(L_FormationConst.FormationEditStatus.EditHero)
    self:setHudAlpha(1, L_FormationConst.FormationEditStatus.EditHero)
  end, 0.2)
  self:setHudAlpha(0)
  L_FormationManager:switchToEditHero()
  if self.isSubFormation then
    self._setShowCallBack(false)
  end
end

function this:initEditHeroView()
  self._isChangePosMode = false
  self.bind.go_overlook = false
  self.bind.go_teamInfo = true
end

function this:initEditHeroViewWithEntity(toEditStatus)
  self:initAddBtnList(toEditStatus)
  L_FormationManager:setFocusEffect(L_FormationManager:getFocusIndex(), toEditStatus)
end

function this:initSelectHeroModuleScript()
  if self.isSelectHeroModuleInited then
    return
  end
  self.bind.toggleSelectHeroStatus = "modulesSelectHero"
  
  function self.modules.modulesSelectHeros.modulesSelectHero.bind.onVFXPlayHideCb(cell)
    self:onVFXPlayHide()
  end
  
  function self.modules.modulesSelectHeros.modulesSelectHero.bind.onClickSelectHero(cell, heroGuid, callback)
    self:onClickSelectHeroCb(heroGuid, callback)
  end
  
  self.isSelectHeroModuleInited = true
end

function this:initSelectHeroModule()
  self.bind.go_editHero = true
  local param = {}
  param.systemId = L_SystemConst.enum.formationBaseHero
  self:initSelectHeroModuleScript()
  self.modules.modulesSelectHeros.modulesSelectHero:initModule(param)
end

function this:closeEditHero()
  self:playHideHeroModuleVFX()
  self.bind.go_listBtnAdd = false
  L_TimerManager:newOrResetTimer(self, "closeEditHero_VFX", function()
    self:initOverlookView()
    self:initAddBtnList(L_FormationConst.FormationEditStatus.Overlook)
    self:setHudAlpha(1, L_FormationConst.FormationEditStatus.Overlook)
  end, 0.2)
  self:setHudAlpha(0)
  L_FormationManager:switchToOverlook(function()
    if self.isBind and L_FormationManager:getEditStatus() == L_FormationConst.FormationEditStatus.Overlook then
      self:initAddBtnList(L_FormationConst.FormationEditStatus.Overlook)
    end
  end)
  if self.isSubFormation then
    self._setShowCallBack(true)
  end
end

function this:editPetByPos(posIndex)
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.EditHero then
    return
  end
  self:playHideHeroModuleVFX()
  self.bind.go_listBtnAdd = false
  self.bind.go_teamInfo = false
  L_FormationManager:setFocusIndex(posIndex)
  L_TimerManager:newOrResetTimer(self, "initSelectPetModule_VFX", function()
    self:initSelectPetModule()
    self:setHudAlpha(1, L_FormationConst.FormationEditStatus.EditPet)
    self.bind.go_btnPresetTeam = false
  end, 0.17)
  L_FormationManager:setPetSwitchStatus(true)
  self:setHudAlpha(0)
  self.petCameraSwitchFlag = nil
  self.bind.go_btnPresetTeam = false
  L_FormationManager:switchToEditPet(posIndex, function()
    self:initEditPetView()
  end)
end

function this:playHideHeroModuleVFX()
  self.modules.modulesSelectHeros.modulesSelectHero:playHideVFX()
end

function this:removeHero(idx)
  if not idx or idx <= 0 then
    printf("Formation", "removeHero idx invalid")
    return
  end
  self.onAddIndex = idx
  self.onRemoveIndex = idx
  L_FormationManager:req_removeHero(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), idx, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_remove"))
  end)
end

function this:initChangePosView()
  self:initAddBtnList()
  self:initHudList()
  L_FormationManager:setPosTranslucent(true)
end

function this:closeChangePosView()
  L_FormationManager:setPosTranslucent(false)
end

function this:changePos(targetPos)
  if targetPos == L_FormationManager:getFocusIndex() then
    return
  end
  local posData = L_FormationStore:getFormationPosData(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())
  L_FormationManager:req_addHero(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), targetPos, posData[L_FormationManager:getFocusIndex()], function()
    L_FormationManager:setFocusIndex(targetPos)
    self:closeChangePosView()
    self:initEditHeroView()
    self:initSelectHeroModule()
    self:initEditHeroViewWithEntity()
    self:initHudList()
  end)
end

function this:initSelectPetModuleScript()
  if self.isSelectPetModuleInited then
    return
  end
  self.bind.toggleSelectPetStatus = "modulesSelectPet"
  
  function self.modules.modulesSelectPets.modulesSelectPet.bind.onVFXPlayHideCb(cell)
    self:onVFXPlayHidePetCb()
  end
  
  function self.modules.modulesSelectPets.modulesSelectPet.bind.onClickSelectPet(cell, petGuid)
    self:onClickSelectPetCb(petGuid)
  end
  
  self.isSelectPetModuleInited = true
end

function this:initEditPetView()
  self.bind.go_overlook = false
  self.bind.go_teamInfo = false
end

function this:initSelectPetModule()
  self.bind.go_editPet = true
  local runtimeFormationType = L_FormationManager:getRuntimeFormationType()
  local runtimeFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  local focusIndex = L_FormationManager:getFocusIndex()
  local curPosPet = L_FormationStore:getFormationPosPetGuid(runtimeFormationType, runtimeFormationIndex, focusIndex)
  local posData = L_FormationStore:getFormationPosData(runtimeFormationType, runtimeFormationIndex)
  local heroConfigId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(posData[focusIndex]))
  local param = {}
  param.systemId = L_SystemConst.enum.formationBasePet
  param.editMode = true
  param.showRecommend = true
  param.heroConfigId = heroConfigId
  param.pageType = L_PetConst.PageType.Formation
  if not math.isEmpty(curPosPet) then
    local petItem = L_PetStore:getPetItem(curPosPet)
    param.defaultSelectBoxIndex = petItem.box_id // 100
  end
  self:initSelectPetModuleScript()
  if not L_FormationManager:getNeedRevertFormationScene() then
    self.modules.modulesSelectPets.modulesSelectPet:initModule(param)
  end
  self.modules.modulesSelectPets.modulesSelectPet:enableDetailBtn()
  self:initPosIndex()
end

function this:closeEditPet()
  if C_InputManager.IsEnableGamePad then
    if self.modules.modulesSelectPets.modulesSelectPet:isShowPetPropertyDetail() then
      self.modules.modulesSelectPets.modulesSelectPet:hidePetPropertyDetail()
      self.modules.modulesSelectPets.modulesSelectPet:refreshBottomGamepadCuts()
      return
    end
    if self.modules.modulesSelectPets.modulesSelectPet:isShowPetProperty() then
      self.modules.modulesSelectPets.modulesSelectPet:hidePetProperty()
      self.modules.modulesSelectPets.modulesSelectPet:refreshBottomGamepadCuts()
      return
    end
  end
  self:playHidePetModuleVFX()
  self.bind.go_listBtnAdd = false
  L_TimerManager:newOrResetTimer(self, "initSelectHeroModule_VFX", function()
    self:initSelectHeroModule()
    self:initEditHeroView()
    self:initEditHeroViewWithEntity(L_FormationConst.FormationEditStatus.EditHero)
    self:setHudAlpha(1, L_FormationConst.FormationEditStatus.EditHero)
    self.bind.go_btnPresetTeam = true
  end, 0.17)
  self:setHudAlpha(0)
  L_FormationManager:switchToEditHero()
  self.petCameraSwitchFlag = nil
end

function this:playHidePetModuleVFX()
  self.modules.modulesSelectPets.modulesSelectPet:playHideVFX()
end

function this:switchPetCamera()
  if L_FormationManager:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet then
    self.petCameraSwitchFlag = not self.petCameraSwitchFlag
    L_FormationManager:switchPetCamera(self.petCameraSwitchFlag)
  end
end

function this:resetPetCamera()
  if L_FormationManager:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet then
    self.petCameraSwitchFlag = nil
    L_FormationManager:resetPetCamera()
  end
end

function this:removePet(idx)
  if not idx or idx <= 0 then
    printf("Formation", "removePet idx invalid")
    return
  end
  L_FormationManager:req_removePet(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), idx, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_remove"))
  end)
end

function this:initPosIndex()
  self.bind.txt_posIndex = tostring(L_FormationManager:getFocusIndex())
end

function this:onEvent_refreshFormation()
  if not L_FormationManager:getRuntimeFormationType() then
    return
  end
  self.needRefreshFormation = true
end

function this:update()
  if self.needRefreshFormation then
    self.needRefreshFormation = false
    self:initFormationModel(true)
    self:initHudList()
    self:initAddBtnList()
    self:initBtnGroup()
    self:initTeamInfo()
    self:refreshPetSelect()
  end
end

function this:refreshPetSelect()
  local moduleSelectPet = self.modules.modulesSelectPets.modulesSelectPet
  moduleSelectPet:refreshAllSelect()
end

function this:onLateUpdate_displayFollow()
  if not self.isTop or not self.isShow then
    return
  end
  self.bind.go_listHud = true
  self.bind.go_nodeCommon = true
  self:refreshHudList()
  self:refreshAddBtnList()
end

function this:onClickEmptyArea()
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  local editStatus = L_FormationManager:getEditStatus()
  if editStatus ~= L_FormationConst.FormationEditStatus.Overlook and editStatus ~= L_FormationConst.FormationEditStatus.EditHero then
    return
  end
  local mousePosition = CS.UnityEngine.Input.mousePosition
  if C_InputManager.IsEnableGamePad then
    mousePosition = C_InputManager.GetVirtualMousePosition()
  end
  local success, hit = C_CameraManager.mainCamera:ScreenRaycastByLayer(C_Vector2(mousePosition.x, mousePosition.y), "Character")
  if success then
    local hitObj = hit.collider.gameObject
    local name = hitObj.name
    local splitStr = string.split(name, "_")
    if splitStr[1] == "hero" then
      local heroId = tonumber(splitStr[2])
      local index = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), heroId)
      if math.isEmpty(index) or not math.isEmpty(index) and index < 0 then
        return
      end
      if self._isChangePosMode then
        self:changePos(index)
      elseif editStatus == L_FormationConst.FormationEditStatus.Overlook then
        self:editHeroByPos(index)
      elseif editStatus == L_FormationConst.FormationEditStatus.EditHero then
        if index == L_FormationManager:getFocusIndex() then
          self:editPetByPos(index)
        else
          self.onAddIndex = index
          L_FormationManager:setFocusIndex(index)
          self:initEditHeroView()
          self:initEditHeroViewWithEntity()
          self:initSelectHeroModule()
        end
      end
      C_AudioManager.Play("Play_SFX_System_UI_Team_Seat_Click")
    elseif splitStr[1] == "pet" then
      local petGuid = tonumber(splitStr[2])
      local index = L_FormationStore:getPetPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), petGuid)
      if math.isEmpty(index) or not math.isEmpty(index) and index < 0 then
        return
      end
      if self._isChangePosMode then
        self:changePos(index)
      elseif editStatus == L_FormationConst.FormationEditStatus.Overlook then
        self:editHeroByPos(index)
      elseif editStatus == L_FormationConst.FormationEditStatus.EditHero then
        self:editPetByPos(index)
      end
      C_AudioManager.Play("Play_SFX_System_UI_Team_Seat_Click")
    end
  elseif self._isChangePosMode then
    self:closeChangePosView()
    self:initEditHeroView()
    self:initEditHeroViewWithEntity()
    self:initSelectHeroModule()
    self:initHudList()
  end
end

function this:playRandHeroVoice(teamInfo)
  local heroList = {}
  for i = 1, #teamInfo do
    if teamInfo[i].hero_guid and teamInfo[i].hero_guid > 0 then
      table.insert(heroList, teamInfo[i].hero_guid)
    end
  end
  local idx = math.random(1, #heroList)
  local heroData = L_HeroStore:getHero(heroList[idx])
  self._nextPlayAudioTime = self._nextPlayAudioTime or 0
  if L_TimeUtil.getServerTime() >= self._nextPlayAudioTime then
    L_HeroVoiceManager:playHeroVoice(string.format("Play_VO_System_%s_Forming", L_HeroStore:getHeroConfigId(heroData)))
    self._nextPlayAudioTime = L_TimeUtil.getServerTime() + L_GameConstTpl:getData("CHAR_VOICE_TEAM_INTERVAL", L_Const.GameTplType.int) / 1000
  end
end

function this:configTouch(operator)
  self.onUILongTapStartHandle = self.onUILongTapStartHandle or L_CommonUtil.handle(self.onUI_longTapStartHandle, self)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self.onUILongTapStartHandle)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function this:onUI_longTapStartHandle(gesture)
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  local editStatus = L_FormationManager:getEditStatus()
  if editStatus ~= L_FormationConst.FormationEditStatus.EditHero then
    return
  end
  local mousePosition = CS.UnityEngine.Input.mousePosition
  local success, hit = C_CameraManager.mainCamera:ScreenRaycastByLayer(C_Vector2(mousePosition.x, mousePosition.y), "Character")
  if success then
    local hitObj = hit.collider.gameObject
    local name = hitObj.name
    local splitStr = string.split(name, "_")
    local index
    if splitStr[1] == "hero" then
      local heroId = tonumber(splitStr[2])
      index = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), heroId)
    elseif splitStr[1] == "pet" then
      local petGuid = tonumber(splitStr[2])
      local heroId = L_PetStore:getPetItem(petGuid).hero_id
      index = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), heroId)
    end
    if index and 0 < index then
      L_FlyMsgManager:startLongPress(gesture, 0.5, function()
        self._isChangePosMode = true
        L_FormationManager:setFocusIndex(index)
        L_FormationManager:setFocusEffect()
        self:initChangePosView()
        self:playHideHeroModuleVFX()
      end)
    end
  end
end

function this:onUI_dragStartHandle(gesture)
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.Overlook then
    return
  end
  self._dragStartPosX = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_board, gesture.position).x
end

function this:onUI_dragEndHandle(gesture)
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.Overlook then
    self._dragStartPosX = 0
    return
  end
  local dragEndPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_board, gesture.position)
  local dragDelta = dragEndPos.x - self._dragStartPosX
  if math.abs(dragDelta) >= self.bindComponents.rect_board.rect.width * 0.3 then
    local addNum = 0 < dragDelta and -1 or 1
    self:changeTeamIndex(addNum)
  end
  self._dragStartPosX = 0
end

function this:refreshLoadingMask()
  self.loadingCount = self.loadingCount or 0
  self.bind.go_loadingMask = self.loadingCount > 0
end

function this:setHudAlpha(alpha, state)
  local list = self.modules.list_hud
  if alpha == 0 then
    self.lastEditStatus = L_FormationManager:getEditStatus()
  end
  local isSelectHero = false
  local isSelectStatus = false
  local isAlpha = alpha == 1
  for i, hud in pairs(list or {}) do
    hud:setAlpha(alpha)
    if isAlpha then
      local ishero = hud.bind.roleType == L_Const.roleType.hero
      if hud:getIndex() == 1 or hud:getIndex() == 2 then
        hud:setRevertBtn(not ishero)
      else
        hud:setRevertBtn(ishero)
      end
      hud:checkDownBtn(state)
      if self.nowSelectHeroIndex and hud:getIndex() == self.nowSelectHeroIndex and not self.switchHeroHudIndex then
        hud:setAlpha(alpha)
        hud:playTeamHud()
        isSelectHero = true
      elseif state == L_FormationConst.FormationEditStatus.Overlook then
        hud:playTeamHud()
      elseif self.lastEditStatus ~= nil then
        isSelectStatus = true
        if self.lastEditStatus == L_FormationConst.FormationEditStatus.Overlook and state == L_FormationConst.FormationEditStatus.EditHero then
          hud:playTeamHud()
        elseif self.lastEditStatus == L_FormationConst.FormationEditStatus.EditHero and state == L_FormationConst.FormationEditStatus.EditPet then
        elseif self.lastEditStatus == L_FormationConst.FormationEditStatus.EditPet and state == L_FormationConst.FormationEditStatus.EditHero then
          hud:playTeamHud()
        end
      elseif state == L_FormationConst.FormationEditStatus.EditPet and not ishero then
        hud:playTeamHud()
      end
    end
  end
  self.switchHeroHudIndex = false
  if isSelectHero then
    self.nowSelectHeroIndex = nil
  end
  if isSelectStatus then
    self.lastEditStatus = nil
  end
end

function this:initModulePresetTeam()
  local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleCommonPresetTeam, CS.UnityEngine.GameObject)
  self.modulePresetTeam = addModule(self.csharpPage, self.csharpPage, self.bindComponents.moduleCommonPresetTeam.gameObject)
end

function this:onClickModulePresetTeam()
  local param = CS.Lens.Gameplay.UI.ModuleCommonPresetTeamParams()
  
  function param.usePresetTeam(presetTeam)
    self.isOpenPresetTeam = false
    local index = presetTeam.index
    if L_FormationManager:getRuntimeFormationIndex() == index then
      return
    end
    L_FormationManager:setRuntimeFormationIndex(index)
    local editStatus = L_FormationManager:getEditStatus()
    if editStatus == L_FormationConst.FormationEditStatus.EditPet then
      if self.isSelectPetModuleInited and not self.modules.modulesSelectPets.modulesSelectPet:escHandle() then
        L_FormationManager:setPetSwitchStatus(false)
        self:playHidePetModuleVFX()
        self.bind.go_listBtnAdd = false
        self.petCameraSwitchFlag = nil
        self:setHudAlpha(1, L_FormationConst.FormationEditStatus.Overlook)
        L_FormationManager:switchToOverlook()
      end
    elseif editStatus == L_FormationConst.FormationEditStatus.EditHero then
      if self._isChangePosMode then
        self:closeChangePosView()
        self:initEditHeroView()
        self:initEditHeroViewWithEntity()
        self:initSelectHeroModule()
        self:initHudList()
      elseif self.isSelectHeroModuleInited and not self.modules.modulesSelectHeros.modulesSelectHero:escHandle() then
        self:closeEditHero()
      end
    end
    self:initPage()
    self:initOverlookView()
    self:initAddBtnList(L_FormationConst.FormationEditStatus.Overlook)
    L_FormationManager:revertFormationScene()
    self.modulePresetTeam:DoClose()
  end
  
  function param.checkIsCurSelectedTeam(presetTeam)
    local index = presetTeam.index
    return index == L_FormationManager:getRuntimeFormationIndex()
  end
  
  function param.getPresetTeamIndex(presetTeam)
    local p = presetTeam.index == L_FormationManager:getRuntimeFormationIndex()
    if p then
      return 1
    end
    return -1
  end
  
  function param.closeAction()
    self.isOpenPresetTeam = false
    self.modulePresetTeam:SetActive(false)
  end
  
  param.editType = CS.Azur.Gameplay.UI.ETeamEditGroupType.Single
  self.modulePresetTeam:SetActive(true)
  self.modulePresetTeam:InitData(param)
  self.isOpenPresetTeam = true
end

return this
