local this = class("pagePlayerCard", G_UIPageBase)
local _playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
local _playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
local _solutionTpl = L_GameTpl:getPhotoSpaceCaseTpl()
local DisplayHeroCount = 3
local DisplayPetsCount = 4
local QUALITYTOIMG = {
  [L_Const.quality.n] = "Atlas/PlayerCardPage/tex_card_icon_chenjiuton",
  [L_Const.quality.r] = "Atlas/PlayerCardPage/tex_card_icon_chenjiuyin",
  [L_Const.quality.sr] = "Atlas/PlayerCardPage/tex_card_icon_chenjiujin"
}
local _mode = {standee = 0, situation = 1}

function this.bind()
  return {
    txt_title = nil,
    txt_title_a = nil,
    go_title = true,
    go_title_a = false,
    go_editTitle = false,
    go_editTitle_a = false,
    txt_name = nil,
    go_editName = false,
    txt_uid = nil,
    go_editMod = false,
    txt_level = nil,
    fill_exp = 1,
    txt_exp = nil,
    txt_nextExp = nil,
    txt_createTime = nil,
    txt_achievementPoint = nil,
    txt_achievementPointTitle = nil,
    txt_birthday = nil,
    go_editBirthday = false,
    txt_sign = nil,
    go_editSign = false,
    toggle_isEmptySign = false,
    list_hero = {
      moduleName = "pages/playerCard/cellSlotDisplay"
    },
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    },
    isOn_addFriend = false,
    list_pets = {
      moduleName = "pages/playerCard/cellPlayerCardPetPixelDisplay"
    },
    moduleCharacterStandee = {
      moduleName = "pages/playerCard/moduleCharacterStandee"
    },
    isActive_btnEditDisplay = nil,
    isActive_title = true,
    isOnStandee = false,
    isOnSituation = false,
    active_standee = true,
    active_bg = true,
    active_bg1 = false,
    active_blurtab = false,
    active_editSituation = false,
    active_modeSwitch = true,
    list_situation = {
      moduleName = "pages/playerCard/cellCardSituationItem"
    },
    activeSituationList = false,
    activeBottom = true,
    txt_homeLevel = "",
    img_homeLevelIcon = "",
    active_homeLevel = true,
    active_homeLevelName = true
  }
end

function this.methods()
  return {
    onClick_copyUid = function(self)
      L_PlayerManager:copyUid(self._playerUid)
    end,
    onClick_editSign = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.playerDisplayText)
    end,
    cellHeadPic = {
      onClick = function(self, bind)
        if self._isSelfPlayer then
          L_UI:open("pageHeadPic")
        end
      end
    },
    onClick_editName = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.playerRename)
    end,
    onClick_addFriend = function(self)
      L_FriendManager:addFriend(self._playerUid)
    end,
    onClick_editTitle = function()
      L_UI:open("pagePlayerTitle")
    end,
    onClick_editTitle_a = function()
      L_UI:open("pagePlayerTitle")
    end,
    onClick_editBirth = function()
      L_UI:open("pageEditBirthday")
    end,
    onClick_editMod = function(self)
      local canMod = L_GameUtil.checkCanMod()
      if not canMod then
        return
      end
      if L_GameUtil.checkClothingBlocked() then
        return
      end
      self:destroySituation()
      L_UI:open("pageCustomClothes")
    end,
    onClick_editModCard = function(self)
      self:destroySituation()
      L_UI:open("pagePlayerDisplay")
    end,
    list_hero = {
      onClick_add = function(self)
        if self._isSelfPlayer then
          L_UI:open("pageDisplayHero")
        end
      end,
      onClick_select = function(self)
        if self._isSelfPlayer then
          L_UI:open("pageDisplayHero")
        end
      end
    },
    list_pets = {
      onClick_select = function(self)
        self:onClick_pets()
      end
    },
    onClick_bg = function(self)
    end,
    onValueChangeStandee = function(self, isOn)
      if isOn then
        self:switchMode(_mode.standee, true)
      end
    end,
    onValueChangeSituation = function(self, isOn)
      if isOn then
        self:switchMode(_mode.situation, true)
      end
    end,
    onClickEditSituation = function(self)
      self:onClick_enterSituation()
    end,
    list_situation = {
      onClick = function(self, id)
        self:selectSolution(id)
      end
    },
    onClick_enterSituation = function(self)
    end,
    onClick_confirmSituation = function(self)
    end
  }
end

function this:check(options, callback)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.OpenPlayerCardPage, true) then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.playerCard)
  callback(result)
end

function this:onTopBarRefresh()
  local settlementPage = L_UI:getPage("pageEntrustDungeonSettlement")
  if settlementPage ~= nil then
    C_IntegrateMgr.TopBarModule:SetTopBarMainBtnVisible(false)
    return
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._playerUid = options.uid or L_PlayerStore:getPlayerId()
  self._isSelfPlayer = self._playerUid == L_PlayerStore:getPlayerId()
  if self._isSelfPlayer then
    L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo, self)
    L_PlayerDisplayStore:buildRedDotTree()
    L_PlayerDisplayStore:listenCallFunc(L_PlayerDisplayStore.event.dressItemSync, self.onEvent_dressItemSync, self)
    self:registerReddot(self.bindComponents.reddotHead, L_ReddotManager.DotDef.PlayerHead)
  else
    self.bindComponents.reddotHead.gameObject:SetActive(false)
    self.bindComponents.reddotBrithday.gameObject:SetActive(false)
    L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  end
  self:initPage()
  local baseInfo = self._isSelfPlayer and L_PlayerStore:getPlayerBaseInfo() or L_FriendStore:getPlayerBaseInfo(self._playerUid)
  local mode = (baseInfo.show_case == _mode.standee or baseInfo.show_case == nil) and _mode.standee or _mode.situation
  self.bind.isOnStandee = mode == _mode.standee
  if self._isSelfPlayer then
    self.bindComponents.togStandee:SetIsOnWithoutNotify(mode == _mode.standee)
    self.bindComponents.togSituation:SetIsOnWithoutNotify(mode == _mode.situation)
  end
  self.bind.active_bg = mode == _mode.standee
  self.bind.active_standee = mode == _mode.standee
  if mode == _mode.situation and (L_DeviceTpl:getIsMobile() or C_DeviceGradeHelper.IsLowMemoryDevice()) then
    C_UIMgr.CloseMidStackPages()
  end
  C_UIMgr.CloseCutin()
  self:switchMode(mode)
  self:refreshAspectRatio_waveBg()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PlayerCard)
end

function this:show()
  if self.mode == _mode.situation then
    self:showSituation()
  end
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PlayerCard)
end

function this:close(options)
  this.super.close(self, options)
  self:destroySituation()
  if self._isSelfPlayer then
    L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo)
    L_PlayerDisplayStore:unListenCallFunc(L_PlayerDisplayStore.event.dressItemSync, self.onEvent_dressItemSync)
  else
    L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
  end
  L_TimerManager:clearTimer(self)
end

function this:initPage()
  self:initHomeLevel()
  self:initInfo()
end

function this:initInfo()
  local baseInfo = self._isSelfPlayer and L_PlayerStore:getPlayerBaseInfo() or L_FriendStore:getPlayerBaseInfo(self._playerUid)
  local tpl_preTitle = _playerTitleTpl:getTplById(L_FriendStore:getPreTitle(baseInfo))
  local tpl_laterTitle = _playerTitleTpl:getTplById(L_FriendStore:getLaterTitle(baseInfo))
  local special_preTitle = _playerTitleTpl:getSpecial(tpl_preTitle)
  local special_laterTitle = _playerTitleTpl:getSpecial(tpl_laterTitle)
  local preTitle, laterTitle = "", ""
  if special_preTitle == 1 and special_laterTitle == 1 then
    laterTitle = L_WordsTpl:getValue("ui_palyertitle_titlenotselect")
    self.bind.go_title_a = true
    self.bind.go_title = false
  elseif special_preTitle == 1 and special_laterTitle ~= 1 then
    laterTitle = _playerTitleTpl:getName(tpl_laterTitle)
    self.bind.go_title_a = false
    self.bind.go_title = true
  elseif special_preTitle ~= 1 and special_laterTitle == 1 then
    preTitle = _playerTitleTpl:getName(tpl_preTitle)
    self.bind.go_title_a = false
    self.bind.go_title = true
  else
    preTitle = _playerTitleTpl:getName(tpl_preTitle)
    laterTitle = _playerTitleTpl:getName(tpl_laterTitle)
    self.bind.go_title_a = false
    self.bind.go_title = true
  end
  self.bind.txt_title = string.concat(preTitle, laterTitle)
  self.bind.txt_title_a = string.concat(preTitle, laterTitle)
  self.bind.go_editTitle = self._isSelfPlayer
  self.bind.go_editTitle_a = self._isSelfPlayer
  self.bind.txt_name = L_FriendStore:getPlayerName(baseInfo)
  self.bind.go_editName = self._isSelfPlayer
  self.bind.txt_uid = string.format("UID:%s", self._playerUid)
  local unlockMod = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.mod)
  self.bind.go_editMod = unlockMod and self._isSelfPlayer
  local pointAllNum = L_AchievementUtil.getStore():GetCurAllPointValue()
  self.bind.txt_achievementPoint = self._isSelfPlayer and string.format("%s", pointAllNum) or not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point)
  self.bind.txt_achievementPointTitle = L_WordsTpl:getValue("ui_idcard_12")
  local lv, isMaxLv = L_FriendStore:getPlayerLevel(baseInfo)
  local exp = L_FriendStore:getPlayerExp(baseInfo)
  self.bind.txt_level = string.format("Lv.%s", lv)
  local tpl_level = _playerLevelTpl:getTplById(lv)
  local totalExp = _playerLevelTpl:getExp(tpl_level)
  self.bind.fill_exp = isMaxLv and 1 or exp / totalExp
  self.bind.txt_exp = isMaxLv and "MAX" or tostring(exp)
  self.bind.txt_nextExp = isMaxLv and "/MAX" or "/" .. totalExp
  self.bind.go_editHead = self._isSelfPlayer
  local cellHeadPic = self.modules.cellHeadPic
  cellHeadPic:updateInfoByPlayerInfo(baseInfo)
  self.bind.txt_createTime = L_TimeUtil.getDisplayTime(L_FriendStore:getPlayerRegisterTime(baseInfo), L_TimeUtil.TimeFormat.YMD)
  local birthday = L_FriendStore:getPlayerBirthday(baseInfo)
  local notSetBirth = table.isEmpty(birthday)
  self.bind.txt_birthday = notSetBirth and (self._isSelfPlayer and "" or L_WordsTpl:getValue("notice_friend_unknown")) or L_WordsTpl:getValue("notice_playercard_birthday", {
    month = birthday.month,
    day = birthday.day
  })
  self.bind.go_editBirthday = self._isSelfPlayer and notSetBirth
  self.bind.go_editSign = self._isSelfPlayer
  local sign = L_FriendStore:getPlayerSign(baseInfo)
  self.bind.toggle_isEmptySign = string.isEmpty(sign)
  self.bind.txt_sign = sign
  self.bind.isOn_addFriend = not self._isSelfPlayer and not L_FriendStore:getIsFriend(self._playerUid)
  local tmp = {}
  local hero = L_FriendStore:getPlayerDisplayHero(baseInfo)
  for i = 1, DisplayHeroCount do
    local dataSrc = {}
    local headUrl
    if hero[i] then
      dataSrc.guid = hero[i].id
      dataSrc.configId = hero[i].config
      dataSrc.lv = hero[i].lv
      dataSrc.skin = hero[i].skin
      if dataSrc.configId == L_GameConstTpl:getMaleDefaultHeroConfigId() or dataSrc.configId == L_GameConstTpl:getFemaleDefaultHeroConfigId() then
        headUrl = L_FriendStore:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.head_talk)
        dataSrc.type = L_Const.HeroType.HT_MAIN
      end
    end
    table.insert(tmp, {
      isEdit = self._isSelfPlayer,
      dataSrc = dataSrc,
      headUrl = headUrl
    })
  end
  local isInit = #self.modules.list_hero ~= DisplayHeroCount
  if isInit then
    self.bind.list_hero:clear()
    self.bind.list_hero:insert_array(tmp)
  else
    for i, v in pairs(self.modules.list_hero) do
      local cell = v
      cell:refreshView(tmp[i])
    end
  end
  self:initPets()
  self:initStandee(baseInfo)
end

function this:initHomeLevel()
  local homeOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.home)
  self.bind.active_homeLevel = homeOpen
  self.bind.active_homeLevelName = homeOpen
  if homeOpen then
    self.bind.txt_homeLevel = tostring(C_HomeUtil.GetHomeLevel())
    local colors = C_HomeUtil.GetHomeLevelColor()
    local _, top = C_ColorUtility.TryParseHtmlString(colors[0])
    local _, bottom = C_ColorUtility.TryParseHtmlString(colors[1])
    self.bindComponents.tmp_homeLevel:SetColorGradient(top, top, bottom, bottom)
    local useSmall = true
    self.bind.img_homeLevelIcon = C_HomeUtil.GetCurrentHomeLevelIcon(useSmall)
  end
end

function this:initPets()
  local baseInfo = self._isSelfPlayer and L_PlayerStore:getPlayerBaseInfo() or L_FriendStore:getPlayerBaseInfo(self._playerUid)
  local allPetInfo = L_FriendStore:getPlayerDisplayPet(baseInfo)
  local datas = {}
  if allPetInfo ~= nil then
    for _, v in pairs(allPetInfo) do
      local temp = {
        isActive_panelNone = false,
        isActive_panelSel = true,
        petInfo = v,
        guid = v.guid,
        isMastIcon = false
      }
      local pos = v.pos
      if pos <= DisplayPetsCount then
        datas[pos] = temp
      end
    end
  end
  for i = 1, DisplayPetsCount do
    if datas[i] == nil then
      datas[i] = {
        isActive_panelNone = true,
        isActive_panelSel = false,
        guid = -1,
        isMastIcon = false
      }
    end
    datas[i].isActive_nextLine = i < DisplayPetsCount
  end
  local needRefresh = #self.modules.list_pets == 0
  if not needRefresh then
    for i, v in pairs(self.modules.list_pets) do
      if datas[i] ~= nil and v.bind ~= nil and datas[i].guid ~= v.bind.guid then
        needRefresh = true
        break
      end
    end
  end
  if needRefresh then
    self.bind.list_pets:clear()
    self.bind.list_pets:insert_array(datas)
  end
end

function this:onClick_pets()
  if self._isSelfPlayer then
    L_UI:open("pageSelectPetDisplay")
  end
end

function this:initStandee(baseInfo)
  local stand_plates = baseInfo.stand_plates
  self.modules.moduleCharacterStandee:setStandeeByBaseInfo(baseInfo)
end

function this:onEvent_refreshBaseInfo()
  self:initInfo()
end

function this:onEvent_refreshIdList()
  self:initInfo()
end

function this:onEvent_dressItemSync(id)
  if self._isSelfPlayer and L_PlayerDisplayStore.redDotRootNode ~= nil then
    AzurWorld.RedDotMgr:MarkDirty(id)
  end
end

function this:switchMode(mode, trigger)
  if self.mode == mode then
    return
  end
  self.mode = mode
  self.bind.active_blurtab = mode == _mode.situation
  if mode == _mode.standee then
    self.bind.active_bg = true
    self.bind.active_standee = true
  else
    FrameScheduler.add(function()
      if self.bind then
        self.bind.active_bg = mode == _mode.standee
        self.bind.active_standee = mode == _mode.standee
      end
    end, 2)
  end
  self.bind.active_bg1 = mode == _mode.situation
  self.bind.isActive_btnEditDisplay = mode == _mode.standee and self._isSelfPlayer
  self.bind.active_editSituation = mode == _mode.situation and self._isSelfPlayer
  if self.mode == _mode.standee then
    self:showStandee()
  elseif self.mode == _mode.situation then
    self:showSituation()
  end
  if trigger and self._isSelfPlayer then
    L_PlayerDisplayStore:req_setPlayerCardShowType(self.mode)
  end
  if self.mode == _mode.standee then
    if trigger then
      self.bindComponents.anim_playerCard:Play("anim_playercard_tomodcard")
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_NameCard_Signboard")
  else
    if trigger then
      self.bindComponents.anim_playerCard:Play("anim_playercard_tosituation")
      if L_DeviceTpl:getIsMobile() or C_DeviceGradeHelper.IsLowMemoryDevice() then
        C_UIMgr.CloseMidStackPages(self.pageName)
      end
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_NameCard_Background")
  end
end

function this:showSituation()
  if not self.sceneData then
    C_UISceneManager.SetSceneVisible()
    local sceneData, obj = L_SituationManager:loadScene(self.bindComponents.stampRoot)
    self.sceneData = sceneData
    self.sceneObj = obj
  end
  local baseInfo = self._isSelfPlayer and L_PlayerStore:getPlayerBaseInfo() or L_FriendStore:getPlayerBaseInfo(self._playerUid)
  local situationId = baseInfo.show_case_id == 0 and 1 or baseInfo.show_case_id
  if self._isSelfPlayer then
    local solution = L_SituationStore:getSolutionInfo(situationId)
    if self.showSolution ~= solution then
      if self.showSolution ~= nil then
        self.showSolution:clear()
      end
      solution:loadSolution(self.sceneData)
      self.showSolution = solution
      self.curSelectId = situationId
    end
  else
    if self.showSolution ~= nil and self.curSelectId == situationId then
      return
    end
    local solution
    for i, v in pairs(baseInfo.scene_showcase or {}) do
      if v.id == situationId then
        solution = L_SituationStore:deserializeSituation(v, self._playerUid)
        break
      end
    end
    if solution == nil then
      solution = L_SituationStore:constructSolutionInfo(1, self._playerUid)
    end
    if self.showSolution ~= nil then
      self.showSolution:clear()
    end
    solution:loadSolution(self.sceneData)
    self.showSolution = solution
    self.curSelectId = situationId
  end
end

function this:showStandee()
end

function this:openSituationList(isOn)
  if self.bind.activeSituationList == isOn then
    return
  end
  self.bind.active_modeSwitch = not isOn
  self.bind.activeBottom = not isOn and self._isSelfPlayer
  self.bind.activeSituationList = isOn
  if isOn then
    local list = {}
    for i, v in pairs(_solutionTpl.data) do
      local data = {}
      local id = v.id
      data.id = id
      local info = L_SituationStore:getSolutionInfo(id)
      if info then
        data.solutionData = info
        table.insert(list, data)
      end
    end
    table.sort(list, function(a, b)
      return a.id < b.id
    end)
    self.bind.list_situation:clear()
    self.bind.list_situation:insert_array(list)
    self:selectSolution(self.curSelectId)
    for i, v in pairs(self.modules.list_situation) do
      v:refreshSelect(self.curSelectId)
    end
  else
    local baseInfo = self._isSelfPlayer and L_PlayerStore:getPlayerBaseInfo() or L_FriendStore:getPlayerBaseInfo(self._playerUid)
    self:selectSolution(baseInfo.show_case_id)
  end
end

function this:selectSolution(id)
  for i, v in pairs(self.modules.list_situation) do
    v.bind.isSelect = v.bind.id == id
  end
  if self.curSelectId == id then
    return
  end
  if self.curSelectId then
    local solution = L_SituationStore:getSolutionInfo(self.curSelectId)
    solution:clear()
  end
  self.curSelectId = id
  local solution = L_SituationStore:getSolutionInfo(id)
  if solution then
  end
  solution:loadSolution(self.sceneData)
  self.showSolution = solution
  for i, v in pairs(self.modules.list_situation) do
    v:refreshSelect(id)
  end
end

function this:onClick_enterSituation()
  L_UI:open("pageSituation", {
    selectId = self.curSelectId,
    saveSituation = true,
    openCallback = function()
      self:destroySituation()
    end
  })
end

function this:onClick_confirmSituation()
end

function this:refreshAspectRatio_waveBg()
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.bg1_aspectRatio.aspectRatio = 14.0
  elseif L_DeviceTpl:getIsMobile() then
    self.bindComponents.bg1_aspectRatio.aspectRatio = 25.6
  end
end

function this:destroySituation()
  if self.showSolution then
    self.showSolution:clear()
    L_SituationManager:releaseAll()
  end
  if L_CommonUtil.isValid(self.sceneObj) then
    C_GameObject.Destroy(self.sceneObj)
  end
  C_UISceneManager.SetSceneVisible()
  self.showSolution = nil
  self.sceneObj = nil
  self.sceneData = nil
  self.curSelectId = nil
end

return this
