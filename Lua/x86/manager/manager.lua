manager = {}

local var_0_0 = import("game.tools.ViewTools")

LoginAction = require("game.action.LoginAction")
manager.managerInit = false

function manager.init()
	manager.path = PathManager.inst
	manager.net = NetManager.New()
	manager.notify = NotificationCenter.GetInstance()

	require("game/action/ActionInclude")

	manager.gc = GCManager.New()
	manager.time = TimeMgr.New()
	manager.audio = AudioMgr.New()
	manager.redPoint = RedPointMgr.New()
	manager.resourcePool = ResourcesPool.New()
	manager.guide = GuideManager.New()
	manager.uiTime = UITimeMgr.New()
	manager.achievementTips = AchievementTipsMgr.New()
	manager.share = ShareMgr.New()
	manager.loadScene = LoadSceneMgr.New()
	manager.heroUiTimelinePool = HeroUITimelinePool.New()
	manager.heroUiTimeline = HeroUITimelineMgr.New()
	manager.IngameGraphic = IngameGraphicMgr.New()
	manager.posterGirl = PosterGirlMgr.New()
	manager.heroRaiseTrack = HeroRaiseTrackMgr.New()
	manager.reserveCamera = ReserveCameraMgr.New()
	manager.rollTips = RollTipsMgr.New()
	manager.assetPend = AssetPendMgr.New()

	require("game/redPoint/RedPointInclude")
end

function manager.uiInit()
	print("manager.uiInit")

	if manager.managerInit then
		return
	end

	manager.managerInit = true
	manager.ui = UIManager.New()
	manager.tips = TipsMgr.New()
	manager.messageBox = ShowMessageMgr.New()
	manager.loadui = LoadUIMgr.New()
	manager.effect = EffectMgr.New()
	manager.story = StoryMgr.New()

	manager.audio:InitListener()
	manager.posterGirl:Init()

	manager.windowBar = WindowBarMgr.New()
	manager.rogueTeamWindowBar = ChallengeRogueTeamWindowBarMgr.New()
	manager.rogueTeamMechanismBar = ChallengeRogueTeamMechanismBar.New()
	manager.rogueTeamInGameInfoBox = ChallengeRogueTeamPathInGameInfo.New()
	manager.rogueTeamMapPreviewBtnBar = ChallengeRogueTeamMapPreviewBtnBar.New()
	manager.transition = ShowTransitionMgr.New()

	manager.transition:RegistCanEndFunc(var_0_0.GetIsLoadied)

	manager.objectPool = ObjectPool.New()
	manager.commonItemPool = LuaItemPool.New(CommonItem, "UI/Common/CommonItem")
	manager.classPool = ClassesPool.New()
	manager.matrixPop = MatrixPopMgr.New()
	manager.video = VideoPlayMgr.New()
	manager.timeWheel = TimeWheelMgr.GetInstance()
	manager.delayed = DelayedActionMgr.GetInstance()

	manager.delayed:Init()

	UnityEngine.EventSystems.EventSystem.current.sendNavigationEvents = false

	print("Initialize Complete")
end

function manager.destroy()
	if manager.managerInit == false then
		return
	end

	manager.delayed:Dispose()
	manager.timeWheel:Dispose()

	manager.managerInit = false

	manager.ui:Dispose()
	ReduxFactory.GetInstance():ClearCacheViews()
	manager.tips:Dispose()
	manager.messageBox:Dispose()
	manager.loadui:Dispose()
	manager.effect:UnloadAllEffect()
	manager.story:Dispose()
	manager.windowBar:Dispose()
	manager.rogueTeamWindowBar:Dispose()
	manager.rogueTeamMechanismBar:Dispose()
	manager.rogueTeamInGameInfoBox:Dispose()
	manager.rogueTeamMapPreviewBtnBar:Dispose()
	manager.posterGirl:Dispose()
	manager.heroRaiseTrack:Dispose()
	manager.reserveCamera:Dispose()
	manager.heroUiTimeline:Dispose()
	manager.IngameGraphic:Dispose()
	manager.heroUiTimelinePool:Dispose()
	manager.resourcePool:Dispose()
	manager.objectPool:Dispose()
	manager.commonItemPool:Dispose()
	manager.classPool:Dispose()
	manager.transition:Dispose()
	manager.redPoint:Dispose()
	manager.matrixPop:Dispose()
	manager.loadScene:Dispose()
	manager.video:Dispose()
	ReduxFactory.GetInstance():PrintExistingObjectInfo()
	manager.gc:Collect()
	manager.guide.view:Dispose()
	manager.guide.weakView:Dispose(true)
	manager.achievementTips:Dispose()
	manager.share:Dispose()
	SectionSelectHeroVoiceManager.GetInstance():Dispose()
	SectionSelectHeroScene.GetInstance():Dispose()
end
