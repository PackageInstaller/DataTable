local PlayerInfoType = {
  PlayerEdit = 1,
  Friend = 2,
  Stranger = 3,
  BlackList = 4,
  PlayerPreview = 5
}
_enum("PlayerInfoType", PlayerInfoType)
local PlayerInfoFrom = {
  MainLobby = 1,
  Chat = 2,
  WorldBoss = 3
}
_enum("PlayerInfoFrom", PlayerInfoFrom)
_class("UIPlayerInfoController", UIController)
UIPlayerInfoController = UIPlayerInfoController

function UIPlayerInfoController:Constructor()
  self._roleModule = self:GetModule(RoleModule)
  self._itemModule = self:GetModule(ItemModule)
  self._canShare = self:GetModule(ShareModule):CanShare()
end

function UIPlayerInfoController:LoadDataOnEnter(TT, res, uiParams)
  self._from = uiParams[1]
  self._friendId = uiParams[2]
  self._chatFriendManager = uiParams[3]
  self._infoData = {}
  self._roleModule = self:GetModule(RoleModule)
  if self._from == PlayerInfoFrom.MainLobby then
    self._isFriendMode = false
    self._isPlayerEditMode = true
  elseif self._from == PlayerInfoFrom.Chat then
    self._isFriendMode = true
    self._isPlayerEditMode = false
  elseif self._from == PlayerInfoFrom.WorldBoss then
    self._isFriendMode = true
    self._isPlayerEditMode = false
  else
    self._isFriendMode = false
    self._isPlayerEditMode = true
  end
  self:_RequestData(TT)
  self:_RefreshData()
end

function UIPlayerInfoController:_RequestData(TT)
  self:Lock("UIPlayerInfoController_RequestData")
  if self._isFriendMode then
    self.friendWakeUp = nil
    self._chatFriendManager:RequestFriendList(TT)
    local socialModule = self:GetModule(SocialModule)
    Log.info("###[wake] playerinfo self._friendId--", self._friendId)
    local res, tempPlayerDetailInfo = socialModule:HandleGetPlayerDetailInfo(TT, self._friendId)
    if not res:GetSucc() then
      self._chatFriendManager:HandleErrorMsgCode(res:GetResult())
      self:UnLock("UIPlayerInfoController_RequestData")
      return
    end
    if self._friendId == nil or self._friendId == 0 then
      Log.error("self._friendId == nil or == 0")
      self:UnLock("UIPlayerInfoController_RequestData")
      self:CloseDialog()
      return
    end
    local playerDetailInfo = tempPlayerDetailInfo
    local simpleInfo = playerDetailInfo.simple_info
    local MobileChoosePainting = playerDetailInfo.choose_painting
    local board_pet = 10015
    local back_id = 1
    local background_type = 1
    local pet_grade = 0
    local pet_template_id = 1500331
    local skin_id = 0
    local is_hand_operate = false
    local handle_ope_spine_id = 1
    if MobileChoosePainting ~= nil then
      board_pet = MobileChoosePainting.board_pet
      back_id = MobileChoosePainting.back_id
      background_type = MobileChoosePainting.background_type
      pet_grade = MobileChoosePainting.pet_grade
      pet_template_id = MobileChoosePainting.pet_template_id
      skin_id = MobileChoosePainting.skin_id
      is_hand_operate = MobileChoosePainting.is_hand_operate
      handle_ope_spine_id = MobileChoosePainting.spine_id
    end
    self.friendWakeUp = simpleInfo.privilege_status
    local chatFriendData = ChatFriendData:New(simpleInfo.pstid, simpleInfo.head, simpleInfo.head_bg, simpleInfo.frame_id, simpleInfo.level, simpleInfo.nick, false, simpleInfo.is_online, simpleInfo.create_time, 0, simpleInfo.last_logout_time, simpleInfo.remark_name, simpleInfo.help_pet, simpleInfo.world_boss_info, simpleInfo.homeland_info, nil, nil, nil, nil, simpleInfo.open_id, simpleInfo.plat_id, simpleInfo.login_source, board_pet, back_id, background_type, pet_grade, pet_template_id, skin_id, is_hand_operate, handle_ope_spine_id)
    self._friendDetailData = ChatFriendDetailData:New(chatFriendData, playerDetailInfo)
    self._friendData = self._friendDetailData:GetFriendData()
    if self._friendData then
      Log.info("###[wake] p id --", self._friendData._friendId)
    else
      Log.info("###[wake] p not id")
    end
  end
  if self._isPlayerEditMode and not GameSingle then
    local res = self._roleModule:Request_RoleImageInfo(TT)
    if not res:GetSucc() then
      Log.debug("###[UIPlayerInfoController] Request_RoleImageInfo Fail !")
    end
  end
  self:UnLock("UIPlayerInfoController_RequestData")
end

function UIPlayerInfoController:_RefreshData()
  if self._isPlayerEditMode then
    self._infoType = PlayerInfoType.PlayerEdit
    self._playerInfo = self._roleModule:UI_GetPlayerInfo()
    self._scheduleInfo = self._roleModule:UI_GetPlayerScheduleInfo()
    self._worldBossModule = self:GetModule(WorldBossModule)
    local headid = self._playerInfo.m_nHeadImageID
    local cfg_head = Cfg.cfg_role_head_image[headid]
    local headbgid = self._playerInfo.m_nHeadColorID
    local cfg_head_bg = Cfg.cfg_player_head_bg[headbgid]
    if cfg_head_bg == nil then
      Log.debug("###playerinfo - cfg_player_head_bg is nil ! id ", headbgid)
      local bid = HelperProxy:GetInstance():GetHeadBgDefaultID()
      cfg_head_bg = Cfg.cfg_player_head_bg[bid]
    end
    local frameid = self._roleModule:GetHeadFrameID()
    local cfg_head_frame = Cfg.cfg_role_head_frame[frameid]
    local frameIcon
    if cfg_head_frame then
      frameIcon = cfg_head_frame.Icon
    else
      local fid = HelperProxy:GetInstance():GetHeadFrameDefaultID()
      frameIcon = Cfg.cfg_role_head_frame[fid].Icon
    end
    self._infoData.headIconName = cfg_head.Icon
    self._infoData.headIconTag = cfg_head.Tag
    self._infoData.headBgName = cfg_head_bg.Icon
    self._infoData.headFrameIconName = frameIcon
    self._infoData.name = self._playerInfo.m_stRoleName
    local unixtime = self._playerInfo.m_nCreateTime
    local dateStr = os.date("%Y/%m/%d", unixtime)
    self._infoData.createDate = dateStr
    self._infoData.level = self._playerInfo.m_player_lv
    self._infoData.showID = self._playerInfo.m_player_showid
    self._infoData.sign = self._playerInfo.m_stSignText
    self._infoData.currMissionID = self._scheduleInfo.m_player_current_missionid
    self._infoData.star = self._scheduleInfo.m_player_mission_star
    self._infoData.petCount = self._scheduleInfo.m_player_pet_count
    self._infoData.achievementPoint = self._scheduleInfo.m_player_achievement_point
    self._infoData.achievementPointAll = self._scheduleInfo.m_player_achievement_all_point
    self._infoData.towerWater = self._scheduleInfo.m_player_tower_info.tower_water
    self._infoData.towerFire = self._scheduleInfo.m_player_tower_info.tower_fire
    self._infoData.towerWood = self._scheduleInfo.m_player_tower_info.tower_wood
    self._infoData.towerThunder = self._scheduleInfo.m_player_tower_info.tower_thunder
    self._infoData.difficultyMission = self._playerInfo.m_difficulty_mission
    self._infoData.sailingMission = self._playerInfo.m_sailing_mission
    self._infoData.titleUsed = self._playerInfo.m_title_used
    self._infoData.fifureUsed = self._playerInfo.m_fifure_used
    self._infoData.dan = self._roleModule:GetWorldBossRecordDan()
    self._infoData.grading = self._roleModule:GetWorldBossRecordRank()
    local expID = Cfg.cfg_aircraft_values[36].IntValue
    if not expID then
      Log.debug("###[UIPlayerInfoController] expID is nil !")
    end
    local exp = self._roleModule:GetAssetCount(expID)
    local rankValue = GameGlobal.GetModule(AircraftModule):GetLvByExp(exp)
    self._infoData.rankValue = rankValue
  end
  if self._isFriendMode then
    if self._chatFriendManager:IsMyFriend(self._friendId) then
      self._infoType = PlayerInfoType.Friend
    elseif self._chatFriendManager:IsInBlackList(self._friendId) then
      self._infoType = PlayerInfoType.BlackList
    elseif self._friendId == self._roleModule:GetPstId() then
      self._infoType = PlayerInfoType.PlayerPreview
    else
      self._infoType = PlayerInfoType.Stranger
    end
    if self._friendData == nil then
      self:CloseDialog()
      return
    end
    self._infoData.headIconName, self._infoData.headIconTag = self._friendData:GetHeadIconName()
    self._infoData.headBgName = self._friendData:GetHeadBgName()
    self._infoData.headFrameIconName = self._friendData:GetHeadFrameName()
    local friendName = self._chatFriendManager:GetFriendName(self._friendData)
    self._infoData.name = friendName
    self._infoData.createDate = self._friendData:GetCreateDateStr()
    self._infoData.level = self._friendData:GetLevel()
    self._infoData.showID = self._friendData:GetShowFriendId()
    self._infoData.sign = self._friendDetailData:GetDes()
    self._infoData.currMissionID = self._friendDetailData:GetCurrentMissionId()
    self._infoData.star = self._friendDetailData:GetStar()
    self._infoData.petCount = self._friendDetailData:GetPetCount()
    self._infoData.achievementPoint = self._friendDetailData:GetAchievementPoint()
    self._infoData.achievementPointAll = self._friendDetailData:GetAllAchievementPoint()
    self._infoData.towerWater = self._friendDetailData:GetTowerWater()
    self._infoData.towerFire = self._friendDetailData:GetTowerFire()
    self._infoData.towerWood = self._friendDetailData:GetTowerWood()
    self._infoData.towerThunder = self._friendDetailData:GetTowerThunder()
    self._infoData.difficultyMission = self._friendDetailData:GetDifficultyMission()
    self._infoData.sailingMission = self._friendDetailData:GetSailingMission()
    self._infoData.titleUsed = self._friendDetailData:GetTitleUsed()
    self._infoData.fifureUsed = self._friendDetailData:GetFifureUsed()
    self._infoData.rankValue = self._friendDetailData:GetRankValue()
    self._infoData.dan = self._friendDetailData:GetWorldBossRecordDan()
    self._infoData.grading = self._friendDetailData:GetWorldBossRecordRank()
  end
  self:RefreshNewPool()
end

function UIPlayerInfoController:OnShow(uiParams)
  self:AttachEvent(GameEventType.ModuleFriendNotifyNewMsg, self._RefreshFriendRedStatus)
  self:AttachEvent(GameEventType.UpdateFriendInvitation, self._RefreshFriendRedStatus)
  self._friendRedGo = self:GetGameObject("friendRed")
  if self._isFriendMode and self._friendData == nil then
    return
  end
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlas = self:GetAsset("UIPlayerInfo.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self.newCenterCanvasGroup = self:GetUIComponent("CanvasGroup", "NewCenter")
  self.newCenterCanvasGroup.alpha = 0
  self.getComponetOver = false
  TaskManager:GetInstance():StartTask(self.Task_OnValue, self)
end

function UIPlayerInfoController:Task_OnValue(TT)
  self:Lock("Task_OnValue")
  self:_InitiBg()
  YIELD(TT)
  self:_GetComponents()
  self.getComponetOver = true
  YIELD(TT)
  self:Task_InitOnValue(TT)
  self:UnLock("Task_OnValue")
end

function UIPlayerInfoController:Task_InitOnValue(TT)
  if not self.getComponetOver then
    return
  end
  if self._isPlayerEditMode then
    self:SetHelpPets()
  else
    self:ShowFriendHelpPets()
  end
  self.newCenterCanvasGroup:DOFade(1, 0.5)
  self:ShowPlayerInfo()
  self:ShowPlayerTitleAndEmblazonry()
  self:ShowScheduleInfo()
  self:FlushRed()
  self:RankValue()
  self:AttachAllEvents()
  YIELD(TT)
  self:SetViewFriendStatus()
  self:SetPlayerInfoHide()
  self:SetWakeUp(TT)
  self:_RefreshFirendLayoutBtns()
end

function UIPlayerInfoController:OnHide()
  self._helpPetIcon = nil
  self:DetachEvent(GameEventType.OnChapcterInfoChanged, self.OnChapcterInfoChanged)
  self:DetachEvent(GameEventType.OnPlayerHeadInfoChanged, self.OnPlayerHeadInfoChanged)
  self:DetachEvent(GameEventType.OnPlayerChangeHeadBadgeClick, self.OnPlayerHeadInfoChanged)
  self:DetachEvent(GameEventType.OnPlayerTitleInfoChanged, self.OnPlayerTitleInfoChanged)
  self:DetachEvent(GameEventType.OnPlayerEmblazonryChange, self.OnPlayerEmblazonryChange)
  self:DetachEvent(GameEventType.ChangeFriendInfoSuccess, self.ChangeFriendInfoSuccess)
  self:DetachEvent(GameEventType.RefreshPlayerInfoRedPoint, self.FlushRed)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerInfoOpen, false)
end

function UIPlayerInfoController:_GetComponents()
  self._backBtnsGO = self:GetGameObject("backBtns")
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = btns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:StartTask(function(TT)
      self:Lock("uieff_UIPlayerInfoController_out")
      self.newCenterAnim:Play("uieff_UIPlayerInfoController_out")
      YIELD(TT, 100)
      self:CloseDialog()
      self:UnLock("uieff_UIPlayerInfoController_out")
    end, self)
  end, nil, nil, nil, nil, not self._isFriendMode, function()
    self:Share()
  end)
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._nameRect = self:GetUIComponent("RectTransform", "nameRect")
  self._idTex = self:GetUIComponent("UILocalizationText", "id")
  self._dateTex = self:GetUIComponent("UILocalizationText", "date")
  self._lvTex = self:GetUIComponent("UILocalizationText", "lv")
  self._headIcon = self:GetUIComponent("RawImageLoader", "head")
  self._headIconRect = self:GetUIComponent("RectTransform", "head")
  self._headBgIcon = self:GetUIComponent("UICircleMaskLoader", "headbg")
  self._frameIcon = self:GetUIComponent("RawImageLoader", "frame")
  self._signTex = self:GetUIComponent("UILocalizationText", "signTex")
  self._goRedPoint = self:GetGameObject("UICommonRedPoint")
  self._titleRedPoint = self:GetGameObject("titleRed")
  self._emblazonryRedPoint = self:GetGameObject("emblazonryRed")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
  self._helpPetGO = self:GetGameObject("helpPetGO")
  self._btnManageHelp = self:GetGameObject("btnManageHelp")
  self._helppetholder = self:GetGameObject("helppetholder")
  self._friendhelppetObj = self:GetGameObject("friendhelppet")
  self._friendhelppet = self:GetUIComponent("UISelectObjectPath", "friendhelppet")
  self._helpPetIcon = {}
  for i = 1, 4 do
    self._helpPetIcon[i] = {}
    self._helpPetIcon[i].go = self:GetGameObject("helppeticon" .. i)
    self._helpPetIcon[i].icon = self:GetUIComponent("RawImageLoader", "helppeticon" .. i)
    self._helpPetIcon[i].levelObj = self:GetGameObject("helppetlevel" .. i)
    self._helpPetIcon[i].level = self:GetUIComponent("UILocalizationText", "helppetlevel" .. i)
    self._helpPetIcon[i].awake = self:GetUIComponent("Image", "helppetawake" .. i)
    self._helpPetIcon[i].first = self:GetUIComponent("Image", "helppet" .. i .. "f")
    self._helpPetIcon[i].second = self:GetUIComponent("Image", "helppet" .. i .. "s")
  end
  self._helppetholder = self:GetGameObject("helppetholder")
  self._noHelpTip = self:GetGameObject("noHelpTip")
  self._uicgGo = self:GetGameObject("uicg")
  self._emblazonrySetting = self:GetGameObject("emblazonrySetting")
  self._emblazonryBg = self:GetUIComponent("RawImageLoader", "emblazonryBg")
  self._nameSetting = self:GetGameObject("nameSetting")
  self._changeHeadBtn = self:GetUIComponent("EmptyImage", "changeHeadBtn")
  self._changeFriendNameObj = self:GetGameObject("changeFriendNameObj")
  self._chenghaoBtnRed = self:GetGameObject("chenghaoBtnRed")
  self._chenghaoBtnRed:SetActive(false)
  self._jinianBtnRed = self:GetGameObject("jinianBtnRed")
  self._jinianBtnRed:SetActive(false)
  self._jinianWallRed = self:GetGameObject("jinianWallRed")
  self._jinianWallRed:SetActive(false)
  self.FriendBtn = self:GetGameObject("FriendBtn")
  self.FriendBtn:SetActive(not GameSingle)
  self.signInBtn = self:GetGameObject("signInBtn")
  self.signInBtn:SetActive(not GameSingle)
  self.initMaoXian = false
  self.initJiNian = false
  self.initChenghao = false
  if not IsPc() and not EDITOR then
    self.wakeUp = self:GetUIComponent("UISelectObjectPath", "WakeUp")
    if self.wakeUp then
      self._wakeUp = self.wakeUp:SpawnObject("UIWakeUpInfo")
    end
    self.wakeUpSimple = self:GetUIComponent("UISelectObjectPath", "WakeUpSimple")
    if self.wakeUpSimple then
      self._wakeUpSimple = self.wakeUpSimple:SpawnObject("UIWakeUpInfoSimple")
    end
  end
  self:_GetNewComponents()
end

function UIPlayerInfoController:_GetMaoxianComponent()
  self._missionProgressTex = self:GetUIComponent("UILocalizationText", "missionProgress")
  self._petCountTex = self:GetUIComponent("UILocalizationText", "petCount")
  self._achievementPointTex = self:GetUIComponent("UILocalizationText", "achievementPoint")
  self._worldBossLevelTex = self:GetUIComponent("UILocalizationText", "worldBossLevelTex")
  self._worldBossIcon = self:GetUIComponent("RawImageLoader", "worldBossIcon")
  self._worldBossIconObj = self:GetGameObject("worldBossIcon")
  self._worldBossNode = self:GetUIComponent("RectTransform", "worldBossNode")
  self._sailingMissionTex = self:GetUIComponent("UILocalizationText", "sailingMissionTex")
  self._sailingObj = self:GetGameObject("item10")
  self._difficultyMissionTex = self:GetUIComponent("UILocalizationText", "difficultyMissionTex")
  self._tower_water = self:GetUIComponent("UILocalizationText", "tower_water")
  self._tower_fire = self:GetUIComponent("UILocalizationText", "tower_fire")
  self._tower_wood = self:GetUIComponent("UILocalizationText", "tower_wood")
  self._tower_thunder = self:GetUIComponent("UILocalizationText", "tower_thunder")
  self._rank = self:GetGameObject("rank")
  self._rankTex = self:GetUIComponent("UILocalizationText", "rankTex")
  self._playerInfoSwitchGo = self:GetGameObject("ScrollView")
  self.hideGo = self:GetGameObject("hideGo")
end

function UIPlayerInfoController:_GetJinianComponent()
  local medalWall = self:GetUIComponent("UISelectObjectPath", "medalWall")
  self._medalWall = medalWall:SpawnObject("UIMedalCard_New")
  if self._isPlayerEditMode then
    self._medalWall:SetData(nil, false, function()
      self:FlushRed()
    end)
  else
    self._medalWall:SetData(self._friendDetailData:GetMedalPlacementInfo())
  end
end

function UIPlayerInfoController:_GetChenghaoComponent()
  self._titleSetting = self:GetGameObject("titleSetting")
  self._titleIcon = self:GetUIComponent("RawImageLoader", "titleIcon")
  self._titleIconObj = self:GetGameObject("titleIcon")
  self._noTitleTips = self:GetGameObject("noTitleTips")
  self._notitleredPoint = self:GetGameObject("notitlered")
  self.firendNoTitleTips = self:GetGameObject("firendNoTitleTips")
end

function UIPlayerInfoController:_GetNewComponents()
  self.zhuye_black_txt_obj = self:GetGameObject("zhuye_black_txt")
  self.zhuye_white_image_obj = self:GetGameObject("zhuye_white_image")
  self.maoxian_black_txt_obj = self:GetGameObject("maoxian_black_txt")
  self.maoxian_white_image_obj = self:GetGameObject("maoxian_white_image")
  self.jinian_black_txt_obj = self:GetGameObject("jinian_black_txt")
  self.jinian_white_image_obj = self:GetGameObject("jinian_white_image")
  self.chenghao_black_txt_obj = self:GetGameObject("chenghao_black_txt")
  self.chenghao_white_image_obj = self:GetGameObject("chenghao_white_image")
  self.Zhuye_pool = self:GetGameObject("Zhuye_pool")
  self.MaoXian_pool = self:GetGameObject("MaoXian_pool")
  self.JiNian_pool = self:GetGameObject("JiNian_pool")
  self.ChengHao_pool = self:GetGameObject("ChengHao_pool")
  self.Zhuye_pool:SetActive(true)
  self.MaoXian_pool:SetActive(false)
  self.JiNian_pool:SetActive(false)
  self.ChengHao_pool:SetActive(false)
  self.newCenterAnim = self:GetUIComponent("Animation", "UIPlayerInfoController")
  self.zhuYe_ButtonAnim = self:GetUIComponent("Animation", "ZhuYe_Button")
  self.maoXian_ButtonAnim = self:GetUIComponent("Animation", "MaoXian_Button")
  self.jiNian_ButtonAnim = self:GetUIComponent("Animation", "JiNian_Button")
  self.chengHao_ButtonAnim = self:GetUIComponent("Animation", "ChengHao_Button")
  self.zhuYe_poolAnim = self:GetUIComponent("Animation", "Zhuye_pool")
  self.maoXian_poolAnim = self:GetUIComponent("Animation", "MaoXian_pool")
  self.jiNian_poolAnim = self:GetUIComponent("Animation", "JiNian_pool")
  self.chengHao_poolAnim = self:GetUIComponent("Animation", "ChengHao_pool")
  self.emblazonryBgSmall = self:GetUIComponent("RawImageLoader", "emblazonryBgSmall")
  self.cur_exp_txt = self:GetUIComponent("UILocalizationText", "cur_exp_txt")
  self.LevelUp_Slider = self:GetUIComponent("Slider", "LevelUp_Slider")
  self.self_maoxian_zhuye_data_Obj = self:GetGameObject("Self_maoxian_zhuye_data")
  self.firend_maoxian_zhuye_data_Obj = self:GetGameObject("Firend_maoxian_zhuye_data")
  self.maoxian_get_pet_txt = self:GetUIComponent("UILocalizationText", "maoxian_get_pet_txt")
  self.achie_maoxian_get_pet_txt = self:GetUIComponent("UILocalizationText", "achie_maoxian_get_pet_txt")
  self.maoxian_worldBossLevel = self:GetUIComponent("UILocalizationText", "maoxian_worldBossLevel")
  self.maoxian_worldBossLevelPaRect = self:GetUIComponent("RectTransform", "maoxian_worldBossLevelPaRect")
  self.mapxian_levelIcon = self:GetUIComponent("RawImageLoader", "mapxian_levelIcon")
  self.layout_self = self:GetGameObject("layout_self")
  self.layout_friend = self:GetGameObject("layout_friend")
  self._signInModule = self:GetModule(SignInModule)
  self._signInRed = self:GetGameObject("signInRed")
  self._blindRed = self:GetGameObject("blindRed")
  self._PhotoFunctionLock = self:GetGameObject("PhotoFunctionLock")
  self._realName = self:GetGameObject("realName")
  self._lockPhoto = self:GetGameObject("LockPhoto")
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HandBook)
  if isLock then
    self._lockPhoto:SetActive(true)
  else
    self._lockPhoto:SetActive(false)
  end
  self._addFirendGo = self:GetGameObject("AddFirendGo")
  self._delteFriendGo = self:GetGameObject("DelteFriendGo")
  self._addBlackFirendGo = self:GetGameObject("AddBlackFirendGo")
  self._removeBlackFirendGo = self:GetGameObject("RemoveBlackFirendGo")
  self._userNameObj = self:GetGameObject("UserName")
  self._userNameHorizontal = self:GetUIComponent("HorizontalLayoutGroup", "UserName")
  self._userNameContentSizeFitter = self:GetUIComponent("ContentSizeFitter", "UserName")
  self.CurSelectInfoModTYpe = SelectPlayerInfoModType.Main
  self.OldSelectInfoModTYpe = nil
  self:RefreshNewPool()
  self:CheckLeftTitleRed()
end

function UIPlayerInfoController:_InitiBg()
  self._posAndScalePool = self:GetUIComponent("UISelectObjectPath", "posAndScale")
  self._fullArea = self:GetUIComponent("RectTransform", "FullArea")
  local BGWidth = self._fullArea.rect.width
  self._main_lobby_bg = self._posAndScalePool:SpawnObject("UIPlayerInfoBg")
  self._main_lobby_bg:SetData(self._isFriendMode, self._friendData, BGWidth)
  local staticSpineSettings, dynamicSpineSettings = self._main_lobby_bg:_GetSpineSettings()
  self._posAndRectT = self:GetUIComponent("RectTransform", "posAndScale")
  local playerCfgConst1 = Cfg.cfg_player_const[1]
  local playerCfgConst2 = Cfg.cfg_player_const[2]
  local delta = Vector2(playerCfgConst1[2], playerCfgConst2[2])
  if Cfg.cfg_global[staticSpineSettings] or Cfg.cfg_global[dynamicSpineSettings] then
    self._posAndRectT.anchoredPosition = Vector2(0, 0)
  else
    self._posAndRectT.anchoredPosition = delta
  end
end

function UIPlayerInfoController:CheckLeftTitleRed()
  self:_CheckRealName()
  self:_CheckSignIn()
  self:_CheckSetting()
  self:_RefreshFriendRedStatus()
end

function UIPlayerInfoController:_CheckRealName()
  local isEditSelf = self._infoType == PlayerInfoType.PlayerEdit or self._infoType == PlayerInfoType.PlayerPreview
  if isEditSelf then
    local info = GameGlobal.GameLogic().ClientInfo
    local isRealName = info.m_isRealName
    self._realName:SetActive(isRealName)
  else
    self._realName:SetActive(false)
  end
end

function UIPlayerInfoController:OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_CheckSetting()
    self:_CheckSignIn()
  end
end

function UIPlayerInfoController:_CheckSetting()
  self.chessCfg = Cfg.cfg_item_chess({})
  self.itemModule = GameGlobal.GetModule(ItemModule)
  local hasNew = false
  for _, v in pairs(self.chessCfg) do
    local items = self.itemModule:GetItemByTempId(v.ID)
    for _, vitem in pairs(items) do
      self.item = vitem
    end
    if self.item and self.item:IsNewOverlay() then
      hasNew = true
    end
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not LocalDB.HasKey("FirstAutoFightRecord" .. roleModule:GetPstId()) then
    hasNew = true
  end
  self._blindRed:SetActive(hasNew)
end

function UIPlayerInfoController:_CheckSignIn()
  if self._signInModule == nil then
    return
  end
  if self._signInRed == nil then
    return
  end
  if self._helpPetIcon == nil then
    return
  end
  local showRed = self._signInModule:HaveTotalLoginReward()
  showRed = showRed or self._signInModule:IsReSignInToday()
  self._signInRed:SetActive(showRed)
end

function UIPlayerInfoController:_RefreshFriendRedStatus()
  local socialModule = GameGlobal.GetModule(SocialModule)
  if socialModule:HaveNewMsg() or socialModule:HaveNewInvitation() then
    self._friendRedGo:SetActive(true)
  else
    self._friendRedGo:SetActive(false)
  end
end

function UIPlayerInfoController:RefreshNewPool()
  if self.Zhuye_pool == nil then
    return
  end
  self.zhuye_black_txt_obj:SetActive(false)
  self.zhuye_white_image_obj:SetActive(false)
  self.maoxian_black_txt_obj:SetActive(false)
  self.maoxian_white_image_obj:SetActive(false)
  self.jinian_black_txt_obj:SetActive(false)
  self.jinian_white_image_obj:SetActive(false)
  self.chenghao_black_txt_obj:SetActive(false)
  self.chenghao_white_image_obj:SetActive(false)
  if self.CurSelectInfoModTYpe == SelectPlayerInfoModType.Main then
    self:_PoolOut()
    self:_RefreshMainPanel()
  elseif self.CurSelectInfoModTYpe == SelectPlayerInfoModType.Adv then
    self:_PoolOut()
    self:_RefreshMaoxianPanel()
  elseif self.CurSelectInfoModTYpe == SelectPlayerInfoModType.Ann then
    self:_PoolOut()
    self:_RefreshJiNianPanel()
  elseif self.CurSelectInfoModTYpe == SelectPlayerInfoModType.Til then
    self:_PoolOut()
    self:_RefreshChengHaoPanel()
  end
  self:_RefreshFirendLayoutBtns()
end

function UIPlayerInfoController:_PoolOut()
  self:StartTask(function(TT)
    self:Lock("_PoolOut")
    YIELD(TT, 167)
    if self.OldSelectInfoModTYpe ~= nil then
      if self.OldSelectInfoModTYpe == SelectPlayerInfoModType.Main then
        self.Zhuye_pool:SetActive(false)
      elseif self.OldSelectInfoModTYpe == SelectPlayerInfoModType.Adv then
        self.MaoXian_pool:SetActive(false)
      elseif self.OldSelectInfoModTYpe == SelectPlayerInfoModType.Ann then
        self.JiNian_pool:SetActive(false)
      elseif self.OldSelectInfoModTYpe == SelectPlayerInfoModType.Til then
        self.ChengHao_pool:SetActive(false)
      end
    end
    self:UnLock("_PoolOut")
  end, self)
end

function UIPlayerInfoController:_RefreshFirendLayoutBtns()
  local isEditSelf = self._infoType == PlayerInfoType.PlayerEdit or self._infoType == PlayerInfoType.PlayerPreview
  if isEditSelf then
    self.layout_self:SetActive(true)
    self.layout_friend:SetActive(false)
  else
    self.layout_self:SetActive(false)
    self.layout_friend:SetActive(true)
    if self._infoType == PlayerInfoType.Friend then
      self._addFirendGo:SetActive(false)
      self._delteFriendGo:SetActive(true)
      self._addBlackFirendGo:SetActive(true)
      self._removeBlackFirendGo:SetActive(false)
    elseif self._infoType == PlayerInfoType.Stranger then
      self._addFirendGo:SetActive(true)
      self._delteFriendGo:SetActive(false)
      self._addBlackFirendGo:SetActive(true)
      self._removeBlackFirendGo:SetActive(false)
    elseif self._infoType == PlayerInfoType.BlackList then
      self._addFirendGo:SetActive(false)
      self._delteFriendGo:SetActive(false)
      self._addBlackFirendGo:SetActive(false)
      self._removeBlackFirendGo:SetActive(true)
    end
  end
  if self._from == PlayerInfoFrom.WorldBoss then
    self._addFirendGo:SetActive(false)
  end
end

function UIPlayerInfoController:_RefreshMainPanel()
  self.Zhuye_pool:SetActive(true)
  self.zhuye_black_txt_obj:SetActive(true)
  self.zhuye_white_image_obj:SetActive(true)
  self:NewLevelExp()
  if self._isFriendMode then
    self:_RefreshMainByFirend()
  else
    self:_RefreshMainBySelf()
  end
end

function UIPlayerInfoController:_RefreshMainBySelf()
  self.self_maoxian_zhuye_data_Obj:SetActive(true)
  self.firend_maoxian_zhuye_data_Obj:SetActive(false)
  self:_RefreshMainBase()
end

function UIPlayerInfoController:_RefreshMainByFirend()
  if self._friendDetailData then
    local curSwitch = true
    if curSwitch == false then
      self.self_maoxian_zhuye_data_Obj:SetActive(false)
      self.firend_maoxian_zhuye_data_Obj:SetActive(true)
    else
      self:_RefreshMainBase()
    end
  end
end

function UIPlayerInfoController:_RefreshMainBase()
  local bPlus = false
  local petCount = self._infoData.petCount
  self.maoxian_get_pet_txt:SetText(petCount)
  local achievementPoint = self._infoData.achievementPoint
  local achievementPointAll = self._infoData.achievementPointAll
  self.achie_maoxian_get_pet_txt:SetText(achievementPoint .. "/" .. achievementPointAll)
  local dan = self._infoData.dan
  local grading = self._infoData.grading
  local danName = UIWorldBossHelper.GetDanName(dan, grading)
  if UIWorldBossHelper.IsNoDan(dan, grading) then
    self.mapxian_levelIcon.gameObject:SetActive(false)
    self.maoxian_worldBossLevel:SetText(StringTable.Get(danName))
    self.maoxian_worldBossLevel.gameObject:SetActive(true)
    self.maoxian_worldBossLevel.transform.parent.gameObject:SetActive(false)
    self.maoxian_worldBossLevel.transform.parent.gameObject:SetActive(true)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.maoxian_worldBossLevelPaRect)
  else
    local badgeBase = UIWorldBossHelper.GetDanBadgeBase(dan, grading)
    self.mapxian_levelIcon.gameObject:SetActive(true)
    self.mapxian_levelIcon:LoadImage(badgeBase)
    self.maoxian_worldBossLevel:SetText(StringTable.Get(danName))
    self.maoxian_worldBossLevel.gameObject:SetActive(true)
    local rankLevel = self._roleModule:GetWorldBossRecordRank()
    bPlus = UIWorldBossHelper.IsPlusDan(dan, rankLevel)
    self.maoxian_worldBossLevel.transform.parent.gameObject:SetActive(false)
    self.maoxian_worldBossLevel.transform.parent.gameObject:SetActive(true)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.maoxian_worldBossLevelPaRect)
  end
  local uiPlusIcon = self:GetChildComponent(self.mapxian_levelIcon, "RectTransform", "PlusIcon")
  if uiPlusIcon ~= nil then
    uiPlusIcon.gameObject:SetActive(bPlus)
  end
end

function UIPlayerInfoController:NewLevelExp()
  local lv = self._infoData.level
  self._lvTex:SetText(lv)
  local nPlayerExp = self._roleModule:GetRoleExp()
  local expPercent = 0
  if self._isFriendMode then
    self.cur_exp_txt.gameObject:SetActive(false)
    self.LevelUp_Slider.value = 0
    return
  else
    self.cur_exp_txt.gameObject:SetActive(true)
  end
  if lv == HelperProxy:GetInstance():GetMaxLevel() then
    local curLvExp = HelperProxy:GetInstance():GetLevelExp(lv)
    self.LevelUp_Slider.value = 1
    local curLvExpStr = "<color=#bd9a71>" .. curLvExp .. "</color>"
    self.cur_exp_txt:SetText(curLvExpStr .. "/" .. curLvExpStr)
  else
    local curLvExp = HelperProxy:GetInstance():GetLevelExp(lv)
    local nextLvExp = HelperProxy:GetInstance():GetLevelExp(lv + 1)
    self.LevelUp_Slider.value = (nPlayerExp - curLvExp) / (nextLvExp - curLvExp)
    local curLvExpStr = "<color=#bd9a71>" .. nPlayerExp - curLvExp .. "</color>"
    local nextExpStr = "<color=#4c4b4b>" .. "/" .. nextLvExp - curLvExp .. "</color>"
    self.cur_exp_txt:SetText(curLvExpStr .. nextExpStr)
  end
end

function UIPlayerInfoController:_RefreshMaoxianPanel()
  if not self.initMaoXian then
    self:_GetMaoxianComponent()
    self.initMaoXian = true
    self:ShowScheduleInfo()
    self:RankValue()
    self:SetPlayerInfoHide()
  end
  self.MaoXian_pool:SetActive(true)
  self.maoxian_black_txt_obj:SetActive(true)
  self.maoxian_white_image_obj:SetActive(true)
end

function UIPlayerInfoController:_RefreshJiNianPanel()
  if not self.initJiNian then
    self:_GetJinianComponent()
    self.initJiNian = true
    self:FlushRed()
  end
  self.JiNian_pool:SetActive(true)
  self.jinian_black_txt_obj:SetActive(true)
  self.jinian_white_image_obj:SetActive(true)
end

function UIPlayerInfoController:_RefreshChengHaoPanel()
  if not self.initChenghao then
    self:_GetChenghaoComponent()
    self.initChenghao = true
    self:ShowPlayerTitleAndEmblazonry()
    self:FlushRed()
  end
  self.ChengHao_pool:SetActive(true)
  self.chenghao_black_txt_obj:SetActive(true)
  self.chenghao_white_image_obj:SetActive(true)
  local isEditSelf = self._infoType == PlayerInfoType.PlayerEdit or self._infoType == PlayerInfoType.PlayerPreview
  if isEditSelf then
    self.firendNoTitleTips:SetActive(false)
    if self._infoData.titleUsed == -1 then
      self._titleSetting:SetActive(false)
    elseif self._infoData.titleUsed == 0 then
      self._titleSetting:SetActive(false)
    else
      self._titleSetting:SetActive(true)
    end
  else
    self._titleSetting:SetActive(false)
    if self._infoData.titleUsed == -1 then
      self.firendNoTitleTips:SetActive(true)
      self._noTitleTips:SetActive(false)
    elseif self._infoData.titleUsed == 0 then
      self.firendNoTitleTips:SetActive(true)
      self._noTitleTips:SetActive(false)
    else
      self.firendNoTitleTips:SetActive(false)
      self._noTitleTips:SetActive(false)
    end
  end
end

function UIPlayerInfoController:_OnValue()
  if not self.getComponetOver then
    return
  end
  self:ShowPlayerInfo()
  self:ShowPlayerTitleAndEmblazonry()
  self:ShowScheduleInfo()
  self:FlushRed()
  self:RankValue()
  self:AttachAllEvents()
  self:SetViewFriendStatus()
  if self._isPlayerEditMode then
    self:SetHelpPets()
  else
    self:ShowFriendHelpPets()
  end
  self:SetPlayerInfoHide()
  self:_RefreshFirendLayoutBtns()
end

function UIPlayerInfoController:SetWakeUp(TT)
  if IsPc() or EDITOR then
    return
  end
  if self.wakeUp then
    local friendid
    if self._isFriendMode then
      friendid = self._friendId
    end
    self._wakeUp:SetData(friendid, self.friendWakeUp)
  end
  YIELD(TT)
  if self.wakeUpSimple then
    local friendid
    if self._isFriendMode then
      friendid = self._friendId
    end
    self._wakeUpSimple:SetData(friendid, self.friendWakeUp)
  end
  YIELD(TT)
end

function UIPlayerInfoController:SetPlayerInfoHide()
  if not self.initMaoXian then
    return
  end
  self.hideGo:SetActive(false)
  if self._isFriendMode and self._friendDetailData then
    local curSwitch = true
    if curSwitch == false then
      self._playerInfoSwitchGo:SetActive(false)
      self.hideGo:SetActive(true)
    else
      self._playerInfoSwitchGo:SetActive(true)
    end
  end
end

function UIPlayerInfoController:AttachAllEvents()
  self:AttachEvent(GameEventType.OnChapcterInfoChanged, self.OnChapcterInfoChanged)
  self:AttachEvent(GameEventType.OnPlayerHeadInfoChanged, self.OnPlayerHeadInfoChanged)
  self:AttachEvent(GameEventType.OnPlayerChangeHeadBadgeClick, self.OnPlayerHeadInfoChanged)
  self:AttachEvent(GameEventType.OnPlayerTitleInfoChanged, self.OnPlayerTitleInfoChanged)
  self:AttachEvent(GameEventType.OnPlayerEmblazonryChange, self.OnPlayerEmblazonryChange)
  self:AttachEvent(GameEventType.ChangeFriendInfoSuccess, self.ChangeFriendInfoSuccess)
  self:AttachEvent(GameEventType.RefreshPlayerInfoRedPoint, self.FlushRed)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
end

function UIPlayerInfoController:RankValue()
  if not self.initMaoXian then
    return
  end
  local airModule = GameGlobal.GetModule(AircraftModule)
  local module = GameGlobal.GetModule(RoleModule)
  if not module:CheckModuleUnlock(GameModuleID.MD_DIFFICULTYMISSION) then
    self._rank:SetActive(false)
  else
    self._rank:SetActive(true)
    self._rankTex:SetText(self._infoData.rankValue)
  end
end

function UIPlayerInfoController:OnPlayerHeadInfoChanged()
  self:_RefreshData()
  self:ShowPlayerHeadAndBg()
end

function UIPlayerInfoController:OnPlayerEmblazonryChange()
  self:_RefreshData()
  self:ShowPlayerTitleAndEmblazonry()
end

function UIPlayerInfoController:OnPlayerTitleInfoChanged()
  self:_RefreshData()
  self:ShowPlayerTitleAndEmblazonry()
end

function UIPlayerInfoController:ShowPlayerTitleAndEmblazonry()
  local icon
  if self._infoData.fifureUsed == 0 then
    local cfgs = Cfg.cfg_item_fifure_extend({Order = 1})
    icon = cfgs[1].PlayerInfoFifureIcon
  else
    icon = Cfg.cfg_item_fifure_extend[self._infoData.fifureUsed].PlayerInfoFifureIcon
  end
  self._emblazonryBg:LoadImage(icon)
  self.emblazonryBgSmall:LoadImage(icon)
  if self.initChenghao then
    if self._infoData.titleUsed == -1 then
      self._titleIconObj:SetActive(false)
      self._noTitleTips:SetActive(true)
    elseif self._infoData.titleUsed == 0 then
      self._noTitleTips:SetActive(true)
      self._titleIconObj:SetActive(false)
    else
      self._noTitleTips:SetActive(false)
      self._titleIconObj:SetActive(true)
      self._titleIcon:LoadImage(Cfg.cfg_item_title_extend[self._infoData.titleUsed].ChangeTitleIcon)
    end
  end
end

function UIPlayerInfoController:UI_GetHeadFrameList()
  local cfg = Cfg.cfg_role_head_frame({})
  local frameList = {}
  for i, v in HelperProxy:GetInstance():pairsByKeys(cfg) do
    local headFrame = {}
    headFrame.ID = v[1]
    headFrame.Icon = v[3]
    table.insert(frameList, headFrame)
  end
  return frameList
end

function UIPlayerInfoController:FlushRed()
  if GameSingle then
    return
  end
  local headRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Head, true)
  headRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_Head) or headRed
  local headFrameRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_HeadFrame, true)
  headFrameRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_HeadFrame) or headFrameRed
  self._tmpheadList = self._roleModule:UI_GetHeadImageListByTag(0)
  for i = 1, #self._tmpheadList do
    local headitem = self._tmpheadList[i] or nil
    local isOpen = false
    local canUnLock = false
    if headitem then
      local lockInfo = self._roleModule:UI_GetHeadImageLockInfo(headitem.m_nImageID)
      if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
        isOpen = true
      end
      if not isOpen then
        canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
      end
    end
    if not isOpen and canUnLock then
      headRed = true
    end
  end
  self._tmpHeadFrameList = self:UI_GetHeadFrameList()
  for i = 1, #self._tmpHeadFrameList do
    local hide = false
    local frame = self._tmpHeadFrameList[i] or nil
    local canUnLock = false
    local isOpen = false
    if frame then
      local lockInfo = self._roleModule:UI_GetHeadFrameLockInfo(frame.ID)
      if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
        isOpen = true
      end
      if not isOpen then
        canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
      end
    end
    if not isOpen and canUnLock then
      headFrameRed = true
    end
  end
  if self._isFriendMode then
    self._goRedPoint:SetActive(false)
  else
    self._goRedPoint:SetActive(headRed or headFrameRed)
  end
  local emblazonryRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Fifure, true)
  emblazonryRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_Title) or emblazonryRed
  self._emblazonryRedPoint:SetActive(emblazonryRed)
  local titleRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Title, true)
  titleRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_Title) or titleRed
  if self.initChenghao then
    self._titleRedPoint:SetActive(titleRed)
    self._notitleredPoint:SetActive(titleRed)
  end
  if self._isFriendMode then
    self._chenghaoBtnRed:SetActive(false)
  else
    self._chenghaoBtnRed:SetActive(titleRed)
  end
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.data = self.mMedal:GetN22MedalEditData()
  self.listData = UIMedalListData:New()
  local client_medal_info = self.mMedal:GetMedalVec()
  self.listData:Init(client_medal_info)
  local listAll = self.listData:GetItemsByFilter(0)
  local jinianRed = false
  for _, item in ipairs(listAll) do
    if item:IsReceive() then
      local id = item:GetID()
      local boardMedal = self.data:GetBoardMedalById(id)
      if boardMedal then
      elseif item:IsNew() then
        jinianRed = true
      end
    end
  end
  if self._isFriendMode then
    self._jinianBtnRed:SetActive(false)
    self._jinianWallRed:SetActive(false)
  else
    self._jinianBtnRed:SetActive(jinianRed)
    self._jinianWallRed:SetActive(jinianRed)
  end
end

function UIPlayerInfoController:OnChapcterInfoChanged()
  self:_RefreshData()
  self:ShowPlayerSignAndName()
end

function UIPlayerInfoController:ShowPlayerSignAndName()
  if string.len(self._infoData.name) > 30 then
    self._userNameHorizontal.enabled = false
    self._userNameContentSizeFitter.enabled = false
    self._nameTex:SetText(self._infoData.name)
  else
    self._userNameHorizontal.enabled = true
    self._userNameContentSizeFitter.enabled = true
    self._nameTex:SetText(self._infoData.name)
  end
  if string.isnullorempty(self._infoData.sign) then
    self._infoData.sign = StringTable.Get("str_player_info_set_your_sign")
  end
  if self._isFriendMode then
    if self._infoData.sign == StringTable.Get("str_player_info_set_your_sign") then
      self._infoData.sign = StringTable.Get("str_player_info_firend_no_set_sign")
    end
    if string.isnullorempty(self._infoData.sign) then
      self._infoData.sign = StringTable.Get("str_player_info_firend_no_set_sign")
    end
  end
  self._signTex:SetText(self._infoData.sign)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._nameRect)
end

function UIPlayerInfoController:ShowCurrentAssistant()
  local petid = self._roleModule:GetResId()
  local asIsNil = false
  self._defaultPetID = 0
  local grade, skin, asid
  if petid and petid ~= 0 then
    self._defaultPetID = petid
    if petid == -1 then
      asIsNil = true
    end
    grade = self._roleModule.m_choose_painting.pet_grade
    skin = self._roleModule.m_choose_painting.skin_id
    asid = self._roleModule.m_choose_painting.board_pet
    if asid == 3400050 then
      asid = 10015
    end
  else
    self._defaultPetID = Cfg.cfg_global.main_default_spine_pet_id.IntValue
    grade = 0
    skin = 0
    asid = 0
  end
  self._uicgGo:SetActive(not asIsNil)
  if asIsNil then
    return
  end
  local petModule = self:GetModule(PetModule)
  local cfg_pet
  if 0 < grade then
    cfg_pet = Cfg.cfg_pet_grade({
      PetID = self._defaultPetID,
      Grade = grade
    })[1]
  else
    cfg_pet = Cfg.cfg_pet[self._defaultPetID]
  end
  local resName = ""
  local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  flagValue = true
  if cfg_pet then
    if asid and asid ~= 0 then
      local cfg_as = Cfg.cfg_only_assistant[asid]
      if not cfg_as then
        Log.error("###[UIPlayerInfoController] cfg_as is nil ! id --> ", asid)
      end
      if flagValue then
        resName = cfg_as.CG
      else
        resName = cfg_as.Spine
      end
    elseif flagValue then
      resName = HelperProxy:GetInstance():GetPetStaticBody(self._defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
    else
      resName = HelperProxy:GetInstance():GetPetSpine(self._defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
    end
  else
    Log.fatal("###[UIPlayerInfoController] cfg_pet is nil ! id == ", self._defaultPetID)
    if flagValue then
      resName = self._defaultPetID .. "_cg"
    else
      resName = self._defaultPetID .. "_spine_idle"
    end
  end
  if flagValue then
    self._spineGo:SetActive(false)
    self._cgGo:SetActive(true)
    local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
    self._cgGo:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
    self._cg:LoadImage(resName)
    UICG.SetTransform(self._cgGo.transform, "UIMainLobbyController", resName)
  else
    self._spineGo:SetActive(true)
    self._cgGo:SetActive(false)
    self._spine:LoadSpine(resName)
    UICG.SetTransform(self._spineGo.transform, "UIMainLobbyController", resName)
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
    local cfg_pet
    if 0 < grade then
      cfg_pet = Cfg.cfg_pet_grade({
        PetID = self._defaultPetID,
        Grade = grade
      })[1]
    else
      cfg_pet = Cfg.cfg_pet[self._selectID]
    end
    local dynamicSpineAnim
    if cfg_pet and asid and asid ~= 0 then
      local cfg_as = Cfg.cfg_only_assistant[asid]
      if cfg_as then
        dynamicSpineAnim = cfg_as.SpineAnim
      end
    end
    if dynamicSpineAnim then
      do
        local function tryFunc()
          if self._spineSke then
            self._spineSke:Initialize(true)
            
            self._spineSke.AnimationState:SetAnimation(0, dynamicSpineAnim, true)
            self._spine.AnimationState.Data.DefaultMix = 0
            self._spineSke:Update(0)
          end
        end
        
        local succ = pcall(tryFunc)
        if not succ then
          Log.error("###[UIChooseAssistantController] set _dynamicSpineAnim fail ! anim:", dynamicSpineAnim)
        end
      end
    end
  end
end

function UIPlayerInfoController:ShowPlayerInfo()
  self:ShowPlayerSignAndName()
  self:ShowPlayerHeadAndBg()
  local id = self._infoData.showID
  self._idTex:SetText(StringTable.Get("str_player_info_id") .. id)
  self:LevelExp()
  self:ShowDate()
end

function UIPlayerInfoController:ShowDate()
  self._dateTex:SetText(self._infoData.createDate)
end

function UIPlayerInfoController:ShowPlayerHeadAndBg()
  self._headIcon:LoadImage(self._infoData.headIconName)
  HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headIconRect, self._infoData.headIconTag)
  self._headBgIcon:LoadImage(self._infoData.headBgName)
  self._frameIcon:LoadImage(self._infoData.headFrameIconName)
  if self._infoType == PlayerInfoType.PlayerEdit then
    UIWorldBossHelper.InitSelfDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect)
  else
    UIWorldBossHelper.InitOtherDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._friendData:GetWorldBossInfo())
  end
end

function UIPlayerInfoController:LevelExp()
  local lv = self._infoData.level
  self._lvTex:SetText(lv)
  if self._isPlayerEditMode then
    local nPlayerExp = self._roleModule:GetRoleExp()
    local expPercent = 0
    if lv == HelperProxy:GetInstance():GetMaxLevel() then
      expPercent = 1
    else
      local curLvExp = HelperProxy:GetInstance():GetLevelExp(lv)
      local nextLvExp = HelperProxy:GetInstance():GetLevelExp(lv + 1)
      local deltaExp = nextLvExp - curLvExp
      if 0 < deltaExp then
        expPercent = (nPlayerExp - curLvExp) / deltaExp
      end
    end
    local txtFilling = self._lvTex.gameObject:GetComponent("ArtFont")
    txtFilling.Division = expPercent
  end
end

function UIPlayerInfoController:ShowScheduleInfo()
  if not self.initMaoXian then
    return
  end
  local currMissionID = self._infoData.currMissionID
  local cfg_mission = Cfg.cfg_mission[currMissionID]
  if cfg_mission then
    local cfgName = DiscoveryStage.GetStageIndexString(currMissionID)
    self._missionProgressTex:SetText(cfgName)
  else
    Log.fatal("###uiplayerinfo - cfg_mission is nil ! id - ", currMissionID)
    self._missionProgressTex:SetText("")
  end
  local petCount = self._infoData.petCount
  self._petCountTex:SetText(petCount)
  local achievementPoint = "<size=38>" .. self._infoData.achievementPoint .. "</size>"
  local achievementPointAll = "<size=28>" .. self._infoData.achievementPointAll .. "</size>"
  self._achievementPointTex:SetText(achievementPoint .. "\n" .. "<size=28>/</size>" .. achievementPointAll)
  self._tower_water:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerWater))
  self._tower_fire:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerFire))
  self._tower_wood:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerWood))
  self._tower_thunder:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerThunder))
  local diffMiss = self._infoData.difficultyMission
  self._difficultyMissionTex:SetText(diffMiss)
  local sailingMission = self._infoData.sailingMission
  self._sailingMissionTex:SetText(sailingMission)
  local module = GameGlobal.GetModule(RoleModule)
  if not module:CheckModuleUnlock(GameModuleID.MD_SAILINGMISSION) then
    self._sailingObj:SetActive(false)
  else
    self._sailingObj:SetActive(true)
  end
  local dan = self._infoData.dan
  local grading = self._infoData.grading
  local danName = UIWorldBossHelper.GetDanName(dan, grading)
  if UIWorldBossHelper.IsNoDan(dan, grading) then
    self._worldBossIconObj:SetActive(false)
    self._worldBossLevelTex:SetText(StringTable.Get(danName))
  else
    local badgeBase = UIWorldBossHelper.GetDanBadgeBase(dan, grading)
    self._worldBossIconObj:SetActive(true)
    self._worldBossIcon:LoadImage(badgeBase)
    self._worldBossLevelTex:SetText(StringTable.Get(danName))
    self._worldBossLevelTex.transform.parent.gameObject:SetActive(false)
    self._worldBossLevelTex.transform.parent.gameObject:SetActive(true)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._worldBossNode)
end

function UIPlayerInfoController:SetViewFriendStatus()
  local isEditSelf = self._infoType == PlayerInfoType.PlayerEdit
  local isShowSelf = isEditSelf or self._infoType == PlayerInfoType.PlayerPreview
  self._emblazonrySetting:SetActive(isEditSelf)
  self._nameSetting:SetActive(isEditSelf)
  if not isEditSelf then
    self._goRedPoint:SetActive(false)
  end
  self._btnManageHelp:SetActive(isEditSelf)
  self._helppetholder:SetActive(isEditSelf)
  self._friendhelppetObj:SetActive(not isEditSelf)
  self._changeHeadBtn.enabled = isEditSelf
  if self.initChenghao then
    self._titleSetting:SetActive(isEditSelf)
  end
  if self._infoType == PlayerInfoType.Friend then
    self._changeFriendNameObj:SetActive(true)
  elseif self._infoType == PlayerInfoType.Stranger then
  elseif self._infoType == PlayerInfoType.BlackList then
  else
    self._changeFriendNameObj:SetActive(false)
  end
  if GameSingle then
    self._nameSetting:SetActive(false)
  end
end

function UIPlayerInfoController:headOnClick()
  self:ShowDialog("UIChangeHeadController", self._playerInfo, function()
    self:FlushRed()
  end)
end

function UIPlayerInfoController:signBtnOnClick()
  if self._infoType ~= PlayerInfoType.PlayerEdit then
    return
  end
  self:ShowDialog("UIChangeSignController", self._playerInfo)
end

function UIPlayerInfoController:nameBtnOnClick()
  self:ShowDialog("UIChangeNameController", self._playerInfo)
end

function UIPlayerInfoController:titleBtnOnClick()
  self:ShowDialog("UIChangeTitleController", self._playerInfo)
end

function UIPlayerInfoController:emblazonryBtnOnClick()
  self:ShowDialog("UIChangeEmblazonryController", self._playerInfo)
end

function UIPlayerInfoController:SetHelpPets()
  local isLock = not self._roleModule:CheckModuleUnlock(GameModuleID.MD_HelpPet)
  if isLock then
    self._helpPetGO:SetActive(true)
    return
  end
  self._helpPetGO:SetActive(true)
  if GameSingle then
    self._helpPetGO:SetActive(false)
    return
  end
  self:StartTask(function(TT)
    local helpPetModule = self:GetModule(HelpPetModule)
    local res = helpPetModule:RequestHelpPet_SupportInfo(TT)
    if res:GetSucc() then
      local _elements = {
        [1] = ElementType.ElementType_Blue,
        [2] = ElementType.ElementType_Red,
        [3] = ElementType.ElementType_Green,
        [4] = ElementType.ElementType_Yellow
      }
      local _infos = {}
      for i = 1, #_elements do
        local elem = _elements[i]
        local _info = helpPetModule:UI_FindSupportPet(elem)
        if _info then
          table.insert(_infos, _info)
        end
      end
      if not self._helpPetIcon then
        return
      end
      local petModule = self:GetModule(PetModule)
      local showHelpPetCount = 4
      local noHelpPetCount = 0
      for i = 1, showHelpPetCount do
        local helpPetIcon = self._helpPetIcon[i]
        if helpPetIcon and _infos[i] then
          helpPetIcon.go.transform.parent.gameObject:SetActive(true)
          local tempId = _infos[i] and _infos[i].m_nTemplateID or 0
          local helpPetLevel = _infos[i].m_nLevel
          local pet = petModule:GetPetByTemplateId(tempId)
          if pet then
            local grade = pet:GetPetGrade()
            local head = HelperProxy:GetInstance():GetPetHead(tempId, grade, pet:GetSkinId(), PetSkinEffectPath.HEAD_ICON_PLAYER_INFO_HELP)
            helpPetIcon.icon:LoadImage(head)
            helpPetIcon.icon.gameObject:SetActive(true)
            helpPetIcon.level:SetText("Lv." .. helpPetLevel)
            helpPetIcon.levelObj.gameObject:SetActive(true)
            self:ShowElement(helpPetIcon, pet)
            helpPetIcon.awake.gameObject:SetActive(true)
            local spriteName = UIPetModule.GetAwakeSpriteName(tempId, grade)
            helpPetIcon.awake.sprite = self._atlasAwake:GetSprite(spriteName)
          else
            helpPetIcon.icon.gameObject:SetActive(false)
            helpPetIcon.go.transform.parent.gameObject:SetActive(false)
            helpPetIcon.awake.gameObject:SetActive(false)
            helpPetIcon.levelObj.gameObject:SetActive(false)
            helpPetIcon.first.gameObject:SetActive(false)
            helpPetIcon.second.gameObject:SetActive(false)
            noHelpPetCount = noHelpPetCount + 1
          end
        else
          helpPetIcon.go.transform.parent.gameObject:SetActive(false)
          helpPetIcon.awake.gameObject:SetActive(false)
          helpPetIcon.first.gameObject:SetActive(false)
          helpPetIcon.second.gameObject:SetActive(false)
          helpPetIcon.levelObj.gameObject:SetActive(false)
          noHelpPetCount = noHelpPetCount + 1
        end
      end
      if noHelpPetCount == showHelpPetCount then
        self._helppetholder:SetActive(false)
        self._noHelpTip:SetActive(true)
      else
        self._helppetholder:SetActive(true)
        self._noHelpTip:SetActive(false)
      end
    end
  end)
end

function UIPlayerInfoController:ShowFriendHelpPets()
  local maxPetCount = 4
  self._petList = {}
  self._friendhelppet:SpawnObjects("UINewChatPetItem", maxPetCount, self._petList)
  local petList = self._friendData:GetPetDataList()
  for i = 1, maxPetCount do
    if petList and petList[i] then
      self._petList[i]:Refresh(petList[i])
    else
      self._petList[i]:Refresh(nil)
    end
  end
end

function UIPlayerInfoController:btnManageHelpOnClick()
  local isLock = not self._roleModule:CheckModuleUnlock(GameModuleID.MD_HelpPet)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_zhuzhan_tips"))
    return
  end
  self:ShowDialog("UIHelpPetManageController", function()
    self:SetHelpPets()
  end)
end

function UIPlayerInfoController:ShowElement(trans, pet)
  if pet == nil then
    return
  end
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    local _1stElement = pet:GetPetFirstElement()
    if _1stElement then
      trans.first.gameObject:SetActive(true)
      trans.first.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_1stElement].Icon .. "_battle"))
    else
      trans.first.gameObject:SetActive(false)
    end
    local _2ndElement = pet:GetPetSecondElement()
    if _2ndElement then
      trans.second.gameObject:SetActive(true)
      trans.second.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_2ndElement].Icon .. "_battle"))
    else
      trans.second.gameObject:SetActive(false)
    end
  end
end

function UIPlayerInfoController:idCopyOnClick(go)
  local copyid = self._infoData.showID
  HelperProxy:GetInstance():CopyString(copyid)
  ToastManager.ShowToast(StringTable.Get("str_player_info_id_copy_succ"))
end

function UIPlayerInfoController:FriendOptionsBtnOnClick()
end

function UIPlayerInfoController:FriendOptionsBtnCloseOnClick()
end

function UIPlayerInfoController:addFriendBtnOnClick(go)
  self:Lock("AddFriendBtnOnClick")
  GameGlobal.TaskManager():StartTask(function()
    local socialModule = GameGlobal.GetModule(SocialModule)
    local res, invtInfo = socialModule:InvitationFriend(TT, self._friendId)
    if not res:GetSucc() then
      local retCode = res:GetResult()
      if retCode == SocialErrorCode.SOCIAL_INVITATION_MUTUAL_SUCCESS then
        ToastManager.ShowToast(StringTable.Get("str_chat_is_your_friend"))
      else
        self._chatFriendManager:HandleErrorMsgCode(retCode)
      end
    else
      ToastManager.ShowToast(StringTable.Get("str_chat_send_request_add_friend_success"))
    end
    self:UnLock("AddFriendBtnOnClick")
  end, self)
end

function UIPlayerInfoController:deleteFriendBtnOnClick(go)
  self:ShowDialog("UIChatDeleteFriendController", self._friendData, self._chatFriendManager)
end

function UIPlayerInfoController:setBlackListBtnOnClick(go)
  if not self._friendData then
    return
  end
  self:ShowDialog("UIChatAddBlacklistController", self._friendData, self._chatFriendManager)
end

function UIPlayerInfoController:removeBlackListBtnOnClick(go)
  if not self._friendData then
    return
  end
  self:ShowDialog("UIChatRemoveBlacklistController", self._friendData, self._chatFriendManager)
end

function UIPlayerInfoController:ChangeFriendInfoSuccess(go)
  GameGlobal.TaskManager():StartTask(function(TT)
    local socialModule = GameGlobal.GetModule(SocialModule)
    socialModule.immedRefresh = true
    self:_RequestData(TT)
    self:_RefreshData()
    self:ShowPlayerSignAndName()
    self:SetViewFriendStatus()
    YIELD(TT)
    self:_RefreshFirendLayoutBtns()
  end, self)
end

function UIPlayerInfoController:ChangeFriendNameBtnOnClick(go)
  if not self._friendData then
    return
  end
  self:ShowDialog("UIChatSetNoteNameController", self._friendData, self._chatFriendManager)
end

function UIPlayerInfoController:Share()
  self:Lock("UIPlayerInfoControllerShare")
  self:StartTask(function(TT)
    self:ShareHideBtn(false)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomLeft, function()
      self:ShareHideBtn(true)
    end, ShareAnchorType.TopLeft, nil, nil, ShareSceneType.PlayerInfo)
    self:UnLock("UIPlayerInfoControllerShare")
  end)
end

function UIPlayerInfoController:ShareHideBtn(show)
  self._backBtnsGO:SetActive(show)
  self.layout_self:SetActive(show)
end

function UIPlayerInfoController:ReportBtnOnClick(go)
  if GameGlobal.GetModule(LoginModule):CanReport() then
    self:ShowDialog("UIReport", self:GetName(), self._friendDetailData)
  end
end

function UIPlayerInfoController:ZhuYe_ButtonOnClick(go)
  if self.CurSelectInfoModTYpe ~= SelectPlayerInfoModType.Main then
    self.zhuYe_ButtonAnim:Play("uieff_UIPlayerInfoController_ZhuYe_Button_in")
    self.zhuYe_poolAnim:Play("uieff_UIPlayerInfoController_Zhuye_pool_in")
    self:_PlayButton_AnimOut(self.CurSelectInfoModTYpe)
    self.OldSelectInfoModTYpe = self.CurSelectInfoModTYpe
  else
    self.OldSelectInfoModTYpe = nil
  end
  self.CurSelectInfoModTYpe = SelectPlayerInfoModType.Main
  self:RefreshNewPool()
end

function UIPlayerInfoController:MaoXian_ButtonOnClick(go)
  if self.CurSelectInfoModTYpe ~= SelectPlayerInfoModType.Adv then
    self.maoXian_ButtonAnim:Play("uieff_UIPlayerInfoController_MaoXian_Button_in")
    self.maoXian_poolAnim:Play("uieff_UIPlayerInfoController_MaoXian_pool_in")
    self:_PlayButton_AnimOut(self.CurSelectInfoModTYpe)
    self.OldSelectInfoModTYpe = self.CurSelectInfoModTYpe
  else
    self.OldSelectInfoModTYpe = nil
  end
  self.CurSelectInfoModTYpe = SelectPlayerInfoModType.Adv
  self:RefreshNewPool()
end

function UIPlayerInfoController:JiNian_ButtonOnClick(go)
  if self.CurSelectInfoModTYpe ~= SelectPlayerInfoModType.Ann then
    self.jiNian_ButtonAnim:Play("uieff_UIPlayerInfoController_JiNian_Button_in")
    self.jiNian_poolAnim:Play("uieff_UIPlayerInfoController_JiNian_pooll_in")
    self:_PlayButton_AnimOut(self.CurSelectInfoModTYpe)
    self.OldSelectInfoModTYpe = self.CurSelectInfoModTYpe
  else
    self.OldSelectInfoModTYpe = nil
  end
  self.CurSelectInfoModTYpe = SelectPlayerInfoModType.Ann
  self:RefreshNewPool()
end

function UIPlayerInfoController:ChengHao_ButtonOnClick(go)
  if self.CurSelectInfoModTYpe ~= SelectPlayerInfoModType.Til then
    self.chengHao_ButtonAnim:Play("uieff_UIPlayerInfoController_ChengHao_Button_in")
    self.chengHao_poolAnim:Play("uieff_UIPlayerInfoController_ChengHao_pool_in")
    self:_PlayButton_AnimOut(self.CurSelectInfoModTYpe)
    self.OldSelectInfoModTYpe = self.CurSelectInfoModTYpe
  else
    self.OldSelectInfoModTYpe = nil
  end
  self.CurSelectInfoModTYpe = SelectPlayerInfoModType.Til
  self:RefreshNewPool()
end

function UIPlayerInfoController:_PlayButton_AnimOut(CurSelectInfoModTYpe)
  if CurSelectInfoModTYpe == SelectPlayerInfoModType.Main then
    self.zhuYe_ButtonAnim:Play("uieff_UIPlayerInfoController_ZhuYe_Button_out")
    self.zhuYe_poolAnim:Play("uieff_UIPlayerInfoController_Zhuye_pool_out")
  elseif CurSelectInfoModTYpe == SelectPlayerInfoModType.Adv then
    self.maoXian_ButtonAnim:Play("uieff_UIPlayerInfoController_MaoXian_Button_out")
    self.maoXian_poolAnim:Play("uieff_UIPlayerInfoController_MaoXian_pool_out")
  elseif CurSelectInfoModTYpe == SelectPlayerInfoModType.Ann then
    self.jiNian_ButtonAnim:Play("uieff_UIPlayerInfoController_JiNian_Button_out")
    self.jiNian_poolAnim:Play("uieff_UIPlayerInfoController_JiNian_pooll_out")
  elseif CurSelectInfoModTYpe == SelectPlayerInfoModType.Til then
    self.chengHao_ButtonAnim:Play("uieff_UIPlayerInfoController_ChengHao_Button_out")
    self.chengHao_poolAnim:Play("uieff_UIPlayerInfoController_ChengHao_pool_out")
  end
end

function UIPlayerInfoController:SignInBtnOnClick(go)
  self:ShowDialog("UISignInController")
end

function UIPlayerInfoController:FriendBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_ChatController"
  }, true)
  self:ShowDialog("UIChatController", function()
    self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.MainLobby)
  end)
end

function UIPlayerInfoController:SetupBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "UISetController"
  }, true)
  self:ShowDialog("UISetController")
end

function UIPlayerInfoController:PhotoBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_BookEntryController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HandBook)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_tongyong116_tips"))
    return
  end
  self:ShowDialog("UIBookEntryController")
end

function UIPlayerInfoController:NotitleBtnOnClick()
  self:ShowDialog("UIChangeTitleController", self._playerInfo)
end

function UIPlayerInfoController:MedalWallBigBtnOnClick()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_MEDAL)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_tongyong116_tips"))
    return
  end
  local visitData
  if self._isPlayerEditMode then
    visitData = nil
  else
    visitData = self._friendDetailData:GetMedalPlacementInfo()
  end
  if visitData then
    self:ShowDialog("UIMedalCardDetailController", visitData)
  else
    self:ShowDialog("UIMedalCardDetailController", nil, function()
      self:FlushRed()
    end)
  end
end

function UIPlayerInfoController:AddFirendBtnOnClick()
  self:addFriendBtnOnClick()
end

function UIPlayerInfoController:DelteFriendBtnOnClick()
  self:deleteFriendBtnOnClick()
end

function UIPlayerInfoController:AddBlackFirendBtnOnClick()
  self:setBlackListBtnOnClick()
end

function UIPlayerInfoController:RemoveBlackFirendBtnOnClick()
  self:removeBlackListBtnOnClick()
end

function UIPlayerInfoController:OnUpdate(deltaTimeMS)
  if self._isFriendMode == nil or not self._isFriendMode then
  end
end

local SelectPlayerInfoModType = {
  Main = 0,
  Adv = 1,
  Ann = 2,
  Til = 3
}
_enum("SelectPlayerInfoModType", SelectPlayerInfoModType)
