

PanelParamMgr = {}


PanelParamMgr.EmptyPanelParam = function()
    PlayerBackpackMgr.Clear()
    HeroParameter.EmptyListParam()
    HeroParameter.EmptyTeamParam()
    HeroParameter.EmptyTerminalMapParam()
    HeroParameter.EmptyBattlePrepareParam()
    HeroParameter.EmptyMissionParam()
    HeroParameter.EmptyTarItem()
    HeroParameter.EmptyChanganLevelLable();
    HeroParameter.EmptyTeachingLevel()
    HeroParameter.EmptyJoinJobNovelTab()
    HeroParameter.EmptyPanelType()
    HeroParameter.EmptyDailyFB();
    HeroParameter.EmptyMountPoem();
    FeatureManager.ClearParameter()
    DelegateBattleMgr.Clear();
    BattlePrepareMgr.Clear()
    AreaMapSceneMgr.ClearExploreParam()
    DataReportMgr.goodsDataJson = nil
    HeroParameter.JournalGotoPanel = nil
    HeroParameter.EmptyNianBeastLevelIndex()
    HeroParameter.huazhaoLevel=nil;
    HeroParameter.moremodeTeaching=nil;
    HeroParameter.TrafficPermitTabIndex=nil;
    HeroParameter.huazhaoChapter=nil;
    HeroParameter.sealChangeList=nil;
    HeroParameter.branchHeroItemClick = nil;
    HeroParameter.EmptyComeBackParam();
    HeroParameter.SawPuzzleBarIndex=nil;    
    HeroParameter.TravelBossBarIndex=nil;
    HeroParameter.SelectAnalectId=nil;
    HeroParameter.FriendSkipInfo=nil;
    HeroParameter.MonthBuyTipActive=nil;
    HeroParameter.Qin2ScenicId=nil;
    HeroParameter.EmptyNovelEventParam();
    HeroParameter.IsRed = nil;
    HeroParameter.SettingHeroData=nil;
    HeroParameter.IsBrilliant = nil
    HeroParameter.EmptyDungeon66Param();
    HeroParameter.EmptyActivityParam();
    PlayerMedalMgr.Clear();
    HeroParameter.KZRYGroupId=nil;
    HeroParameter.giftJump=nil;
    PlayerBackpackMgr.ResetSift()
    PlayerBackpackMgr.equipPositioningId = nil
    TrainingTowerHelper.Clear();
    if ChanganMgr ~= nil then
        ChanganMgr.Clear();
    end
    RogueMgr.Clear();
    TrainingCampMgr.Clear()
    TrainingDummyMgr.Clear()
    BossDummy4Mgr.Clear()
    MiniBattle4Mgr.Clear()
    TeamWeaponMgr.Clear()
    TeamRelay2Mgr.Clear()
end