local UnlockFunc = {}

function UnlockFunc:onUnlockTaskUI()
  local ctrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if ctrl ~= nil then
    ctrl:OnUpdateTask()
  end
  PlayerDataCenter.allTaskData:InitNormalTaskRedDot()
end

function UnlockFunc:onUnlockDailyAndWeeklyTaskUI()
  PlayerDataCenter.allTaskData:InitNormalTaskRedDot()
  local ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  if ctrl ~= nil then
    ctrl:SetDailyAndWeeklyLock()
  end
end

function UnlockFunc:onUnlockShop()
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshshopBtn()
  end
  ControllerManager:GetController(ControllerTypeId.Shop, true):SetIsUnLock(true)
end

function UnlockFunc:onUnlockOasis()
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshOasisBtn()
  end
end

function UnlockFunc:onUnlockSector()
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshEpBtn()
  end
end

function UnlockFunc:onUnlockHeroList()
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshHeroListBtn()
  end
end

function UnlockFunc:onUnlockLottery()
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshLotteryBtn()
  end
end

function UnlockFunc:onUnlockFactory()
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshFactoryBtn()
  end
end

function UnlockFunc:onUnlockTraining()
end

function UnlockFunc:onUnlockSocial()
end

function UnlockFunc:onUnlockHeroEnter()
  local uiTraining = UIManager:GetWindow(UIWindowTypeID.Training)
  if uiTraining ~= nil then
    uiTraining:OnStaffInfoUnlock(true)
  end
end

function UnlockFunc:onUnlockEnemyDetail()
  local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if uiBattle ~= nil then
    uiBattle:OnEnemyDetailUnlock(true)
  end
end

function UnlockFunc:onUnlockDorm(self)
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome.homeRightNode:RefreshDormBtn()
  end
  if PlayerDataCenter.dormBriefData ~= nil then
    PlayerDataCenter.dormBriefData:RefreshNewDormHouseReddot()
  end
end

function UnlockFunc:onUnlockRandom(self)
end

function UnlockFunc:onUnlockCommanderSkill()
  local function LocalTrySetCstForFormation()
    for formId, formation in pairs(PlayerDataCenter.formationDic) do
      if formation:IsIllegalCST(true) then
        NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill):CS_COMMANDSKILL_SaveFromFormation(formation)
      end
    end
    local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
    if uiFormation ~= nil then
      uiFormation:UnlockCommanderSkillUI((FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui)))
    end
    MsgCenter:RemoveListener(eMsgEventId.NetDiffSyncFinish, LocalTrySetCstForFormation)
  end
  
  MsgCenter:AddListener(eMsgEventId.NetDiffSyncFinish, LocalTrySetCstForFormation)
end

function UnlockFunc:onUnlockCommanderSkillUI()
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:UnlockCommanderSkillUI((FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)))
  end
end

function UnlockFunc:onUnlockStarUp(self)
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockStarup(true)
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return
  end
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroStarNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroStarUp, RedDotDynPath.HeroCardStartUpPath)
    if heroData:AbleUpgradeStar() then
      heroStarNode:SetRedDotCount(1)
    else
      heroStarNode:SetRedDotCount(0)
    end
  end
end

function UnlockFunc:onUnlockSectorBuilding(self)
end

function UnlockFunc:onUnlockCareerBuilding(self)
  NetworkManager:GetNetwork(NetworkTypeID.Building):InitBuildingRedDotOasis()
end

function UnlockFunc:onUnlockEndlss()
end

function UnlockFunc:onUnlockEpHard()
end

function UnlockFunc:onUnlockAchievement()
  local HomeSide = UIManager:GetWindow(UIWindowTypeID.HomeSide)
  if HomeSide ~= nil then
    HomeSide:RefreshAchievementBtn()
  end
  local userInfo = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  if userInfo ~= nil then
    userInfo:RefreshAchievementInfo()
  end
end

function UnlockFunc:onUnlockPeriodicChanllenge()
  NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_DAILYCHALLENGE_Detail()
end

function UnlockFunc:onUnlockFriendShip()
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockFriendship(true)
  end
  local plotDungeon = UIManager:GetWindow(UIWindowTypeID.FriendShipPlotDungeon)
  if plotDungeon ~= nil then
    plotDungeon:__loadFriendShip()
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return
  end
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local friendShipNode = heroNode:AddChild(RedDotStaticTypeId.HeroFriendship)
    local upgradeFriendshipSkillNode = friendShipNode:AddChildWithPath(RedDotStaticTypeId.HeroFriendshipSkillUp, RedDotDynPath.HeroCardFriendshipPath)
    if PlayerDataCenter.allFriendshipData:GetCouldUnlockForestLine(heroId) then
      upgradeFriendshipSkillNode:SetRedDotCount(1)
    else
      upgradeFriendshipSkillNode:SetRedDotCount(0)
    end
  end
end

function UnlockFunc:onUnlockMial()
  local MailController = ControllerManager:GetController(ControllerTypeId.Mail)
  if MailController ~= nil then
    MailController:RefrshMailRedDot()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return
  end
  win.homeUpNdoe:RefreshMailBtn()
end

function UnlockFunc:onUnlockSignIn()
  ControllerManager:GetController(ControllerTypeId.ActivityFrame, true):AddFakeSigninActivityData()
  local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, {
    ActivityFrameEnum.eActiveityFakeId.dailySignIn
  })
end

function UnlockFunc:onUnlockHeroTask()
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockHeroTask(true)
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return
  end
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroTaskNode = heroNode:AddChild(RedDotStaticTypeId.HeroTask)
    if heroData:IsHaveCompletedHeroTask() then
      heroTaskNode:SetRedDotCount(1)
    else
      heroTaskNode:SetRedDotCount(0)
    end
  end
end

function UnlockFunc:onUnlockHeroInfo()
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockHeroInfo(true)
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return
  end
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroInfoNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroInfomation, RedDotDynPath.HeroCardHeroInfomationPath)
    if heroData:IsHaveCouldGetRewardArchive() then
      heroInfoNode:SetRedDotCount(1)
    else
      heroInfoNode:SetRedDotCount(0)
    end
  end
end

function UnlockFunc:onUnlockCDK()
  local win = UIManager:GetWindow(UIWindowTypeID.Setting)
  if win == nil or not win.active then
    return
  end
  win:SetCDKButtomActive(true)
end

function UnlockFunc:onUnlockSectorTask()
  local win = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if win == nil or not win.active then
    return
  end
  win:SetTaskTaskUnlock(true)
end

function UnlockFunc:onUnlockNavigation()
  local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if win == nil then
    return
  end
  win.topGroup:RefreshouldShowNaviBtn(true)
end

function UnlockFunc:onUnlockCommanderInformation()
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return
  end
  win.homeUpNdoe:RefershUserInfo()
end

function UnlockFunc:onUnlockSkin()
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil then
    win:RefreshSkinBtnState()
  end
end

function UnlockFunc:onUnlockWarehouse()
  for id, itemData in pairs(PlayerDataCenter.itemDic) do
    local itemCfg = itemData.itemCfg
    if ConfigData:IsManualOpenGiftItem(itemCfg) and 0 < (itemCfg.warehouse_page or 0) and 0 < itemData:GetCount() then
      local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse)
      node:AddChild(itemCfg.warehouse_page):AddChild(itemCfg.id):SetRedDotCount(1)
    end
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.active then
    window.homeRightNode:RefreshWarehouseBtn()
  end
end

function UnlockFunc:onUnlockChangeUserInfo()
end

function UnlockFunc:onUnlockChatSystem()
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return
  end
  win.homeLeftNode:RefreshHomeChatBtnShow()
end

function UnlockFunc:onUnlockFriend()
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return
  end
  win.homeLeftNode:RefreshFriendBtn()
end

function UnlockFunc:OnUnlockDailyDungeon()
  NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_Dync_Detail(function()
    MsgCenter:Broadcast(eMsgEventId.DailyDungeonOutOfData)
  end)
end

function UnlockFunc.OnUnlockDungeonTower()
  NetworkManager:GetNetwork(NetworkTypeID.DungeonTower):CS_DUNGEONTOWER_Detail()
end

function UnlockFunc:OnUnlockWeeklyChallenge()
  PlayerDataCenter.allTaskData:InitWeeklyChallengeTaskRedDot()
end

function UnlockFunc.OnUnlockSectorActivity()
  MsgCenter:Broadcast(eMsgEventId.SectorActivityUnlock)
end

function UnlockFunc.OnUnlockHeroActivity()
  MsgCenter:Broadcast(eMsgEventId.HeroGrowActivityUnlock)
end

function UnlockFunc.onUnlockAth()
  NetworkManager:GetNetwork(NetworkTypeID.Arithmetic):CS_ATH_Detail()
end

function UnlockFunc.onCompleteIntro()
  local topStatusWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatusWin ~= nil and topStatusWin.topGroup ~= nil then
    topStatusWin.topGroup:ShowTopBtnGroupGoHomeBtn(true)
  end
end

function UnlockFunc.OnUnlockTalent()
  PlayerDataCenter.allHeroTalentData:InitHeroTalent()
  MsgCenter:Broadcast(eMsgEventId.HeroTalentUnlock)
end

function UnlockFunc.OnUnlockSpecWeapon()
  MsgCenter:Broadcast(eMsgEventId.SpecWeaponUnlock)
end

function UnlockFunc.OnUnlockAdjChange()
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.active then
    window.homeLeftNode:RefreshAdjBtn()
  end
end

function UnlockFunc:OnUnlockAdjModule()
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.active then
    window.homeController:LoadBoardHero()
  end
end

return UnlockFunc
