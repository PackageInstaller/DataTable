-- 1、Unity侧部分功能的Lua代码实现用来降低与cs代码的交互来提供性能---移植自tolua
-- 2、这里的模块在游戏逻辑跑之前开始启动，雷同Unity中的Plugin下脚本
-- 3、这里的全局模块一般用于提供对lua语言级别的支持和扩展，和游戏框架以及逻辑无关

-- 加载全局模块
require "Common.Tools.import"
require "Common.LuaUtil"
require "Common.TableUtil"
require "Common.StringUtil"


Mathf = require "Common.Tools.UnityEngine.Mathf"
Vector2 = require "Common.Tools.UnityEngine.Vector2"
Vector3 = require "Common.Tools.UnityEngine.Vector3"
Vector4 = require "Common.Tools.UnityEngine.Vector4"
Quaternion = require "Common.Tools.UnityEngine.Quaternion"
Color = require "Common.Tools.UnityEngine.Color"
Ray = require "Common.Tools.UnityEngine.Ray"
Bounds = require "Common.Tools.UnityEngine.Bounds"
RaycastHit = require "Common.Tools.UnityEngine.RaycastHit"
Touch = require "Common.Tools.UnityEngine.Touch"
LayerMask = require "Common.Tools.UnityEngine.LayerMask"
Plane = require "Common.Tools.UnityEngine.Plane"
Time = require "Common.Tools.UnityEngine.Time"
Object = require "Common.Tools.UnityEngine.Object"
Json = require "json"
list = require "Common.Tools.list"

require "Common.Tools.event"

require "GlobalBehaviourListener"
-- 加载全局模块
require "Framework.Common.BaseClass"
require "Framework.Common.DataClass"
require "Framework.Common.ConstClass"

-- 创建全局模块
Config = require "Global.Config"
Singleton = require "Framework.Common.Singleton"
Updatable = require "Framework.Common.Updatable"
UpdatableSingleton = require "Framework.Common.UpdatableSingleton"
SortingLayerNames = require "Global.SortingLayerNames"
Logger = require "Framework.Logger.Logger"
require "Framework.Updater.Coroutine"

-- game config

PlayerAction = require "Const.PlayerAction_Const"

-- ui base
UIUtil = require "Framework.UI.Util.UIUtil"
UIBaseComponent = require "Framework.UI.Base.UIBaseComponent"
UIBaseContainer = require "Framework.UI.Base.UIBaseContainer"
UICanvas = require "Framework.UI.Component.UICanvas"
UIText = require "Framework.UI.Component.UIText"
UIImage = require "Framework.UI.Component.UIImage"
UIRawImage = require "Framework.UI.Component.UIRawImage"
UISlider = require "Framework.UI.Component.UISlider"
UINewSlider = require "Framework.UI.Component.UINewSlider"
UIInput = require "Framework.UI.Component.UIInput"
UIButton = require "Framework.UI.Component.UIButton"
UINewButton = require "Framework.UI.Component.UINewButton"
UIEffect = require "Framework.UI.Component.UIEffect"
UIScrollView = require "Framework.UI.Component.UIScrollView"
LoopListView = require "Framework.UI.Component.LoopListView"
CircularScrollView = require "Framework.UI.Component.CircularScrollView"
BigMiddleScrollView = require "Framework.UI.Component.BigMiddleScrollView"
DotsToggler = require "Framework.UI.GameComponents.DotsToggler"
UIToggle = require "Framework.UI.Component.UIToggle"
UIToggleGroup = require "Framework.UI.Component.UIToggleGroup"
UINewToggle = require "Framework.UI.Component.UINewToggle"
UINewToggleGroup = require "Framework.UI.Component.UINewToggleGroup"
TimeUtil = require "Framework.Util.TimeUtil"
RandomUtil = require "Framework.Util.RandomUtil"
-- ui extend
GameUIImage = require "Framework.UI.GameComponents.GameUIImage"
GameRawImage = require "Framework.UI.GameComponents.GameRawImage"
GameUIText = require "Framework.UI.GameComponents.GameUIText"
EmojiText = require "Framework.UI.GameComponents.EmojiText"
TSButton = require "Framework.UI.GameComponents.TSButton"

UIMessageNames = require "Framework.UI.Message.UIMessageNames"
EventMgr = require("Framework.Common.Messenger").New()
-- UIConfig = require "UI.Config.UIConfig"

-- res
ResourceManager = require "Framework.Resource.ResourceManager"
GameObjectPool = require "Framework.Resource.GameObjectPool"

-- update & time
Timer = require "Framework.Updater.Timer"
TimerManager = require "Framework.Updater.TimerManager"
UpdateManager = require "Framework.Updater.UpdateManager"
GameObjectMgr = require "Mgr.GameObjectMgr"

RoleBehaviorCtrl = require "RoleBehavior.RoleBehaviorCtrl"

CommandMgr = require "Framework.Commands.CommandMgr"
BaseCommand = require "Framework.Commands.BaseCommand"
BaseJumpCommand = require "Framework.Commands.BaseJumpCommand"
CommandConst = require "Config.CommandConst"

ItemHelper = require "UI.Helpers.ItemHelper"

require "Framework.UI.BaseContext"
require "Framework.UI.BaseUICtrl"
require "Framework.UI.BaseView"

ServiceLocator = CS.GameX.ServiceLocator.Inst
ShareSDKMgr = CS.ShareSDKMgr.Instance
Screen = CS.UnityEngine.Screen
GameState = CS.GameX.GameState

if IsNull(ServiceLocator) == false then
    NewNet = ServiceLocator.isNewNet
    IResourceManager = ServiceLocator:SingletonLua("IResourceManager")
    ISceneManager = ServiceLocator:SingletonLua("ISceneManager")
    IModuleMgr = ServiceLocator:SingletonLua("IModuleMgr")
    IUIContextMgr = ServiceLocator:SingletonLua("IUIContextMgr")
    IUIManager = IUIContextMgr.uiManager

    IGuideMgr = ServiceLocator:SingletonLua("IGuideMgr")
    IBattle = ServiceLocator:SingletonLua("IBattle")
    ICameraMgr = ServiceLocator:SingletonLua("ICameraMgr")
    IGameEventMgr = ServiceLocator:SingletonLua("IGameEventMgr")
    IRoleActionMgr = ServiceLocator:SingletonLua("IRoleActionMgr")
    ISettingDataMgr = ServiceLocator:SingletonLua("ISettingDataMgr")
    IRedPointMgr = ServiceLocator:SingletonLua("IRedPointMgr")
    IRoleStudioHeroDataMgr = ServiceLocator:SingletonLua("IRoleStudioHeroDataMgr")

    INetPack = ServiceLocator:SingletonLua("INetPackNew")
    IItemDataMgr = ServiceLocator:SingletonLua("IItemDataMgrNew")
    IPlayerData = ServiceLocator:SingletonLua("IPlayerDataNew")
    IHeroDataMgr = ServiceLocator:SingletonLua("IHeroDataMgrNew")
    ITimeMgr = ServiceLocator:SingletonLua("ITimeMgr")
    IDataGetterMgr = ServiceLocator:SingletonLua("IDataGetterMgr")
    IBuriedPointDataMgr = ServiceLocator:SingletonLua("IBuriedPointDataMgr")
    ITimeNotifier = ServiceLocator:SingletonLua("ITimeNotifier")
    INoticeDataMgr = ServiceLocator:SingletonLua("INoticeDataMgr")
end

-- ConfigHelper = CS.GameX.Config.ConfigHelper

---------初始化常量
EGetterType = require "Const.EGetterType"
EGetterID = require "Const.EGetterID"
EGameKeyNode = require "Const.EGameKeyNode"
LotteryType = require "Config.LotteryType"
LotteryConst = require "Config.LotteryConst"
RoleType = require "Config.RoleType"
BagConst = require "Config.BagConst"
EnumConst = require "Config.EnumConst"
UIDefine = require "Config.UIDefine"
TaskConst = require "Config.TaskConst"
SettingConst = require "Config.SettingConst"
SettingDefault = require "Config.SettingDefault"
CameraConst = require "Config.CameraConst"
MainConst = require "Config.MainConst"
RedPointConst = require "Config.RedPointConst"
TaskHelper = require "UI.Helpers.TaskHelper"
GamesHelper = require "UI.Helpers.GamesHelper"
ETaskConditionType = require "DataCenter.Task.ETaskConditionType"
ItemNumberType = require("Config.ItemNumberType")
ModuleConfig = require("Config.ModuleConfig")
DormActionConfig = require("Config.DormActionConfig")
OtakuType = require("Config.OtakuType")
SmaillGamesType = require("Config.SmaillGamesType")
DormConst = require("Config.DormConst")
ShopConst = require("Config.ShopConst")
ComConst = require "Config.ComConst"
StoryConst = require("Config.StoryConst")
RechargeConst = require("Config.RechargeConst")
ChiefNoteConst = require("Config.ChiefNoteConst")
PassConst = require("Config.PassConst")
OtakuHeroDeloyState = require("Config.OtakuHeroDeloyState")
RedPointType = require("DataCenter.RedPoint.RedPointType")
DeployHeroType = require "Config.DeployHeroType"
InteractiveType = require("Config.InteractiveType")
ActivityType = require("Config.ActivityType")
EncountConst = require("Config.EncountConst")
EncounterHelper = require("UI.Helpers.EncounterHelper")
FriendHelper = require "UI.Helpers.FriendHelper"
MissionHelper = require "UI.Helpers.MissionHelper"
SlotFurnitureActionConfig = require("Config.SlotFurnitureActionConfig")
DevelopHelper = require "UI.Helpers.DevelopHelper"
DevelopCameraConfig = require "Config.DevelopCameraConfig"
BuriedPointConst = require "Config.BuriedPointConst"
ChapterConst = require "Config.ChapterConst"
SurveyHelper = require "UI.Helpers.SurveyHelper"

ResourceManager:GetInstance()
ConfigHelper = require "Config.ConfigHelper"
BattleHelper = require "Battle.BattleHelper"

--用于扩展
--ConfigHelper.Extend()
PhysicsMgr = CS.GameX.PhysicsMgr
SecurityHelper = CS.GameX.SecurityHelper
PlayerPrefabHelper = CS.GameX.PlayerPrefabHelper
UIContextMgr = require("Framework.UI.UIContextMgr")
ModuleMgr = require("Framework.Module.ModuleMgr")
NetPack = require("Mgr.NetPack").New()
--VirtualCameraMgr = require("Camera.VirtualCameraMgr")

---------初始化工具
require "Global.GameUtil"
require "Common.GameHelper"
require "Common.DormHelper"
require "Common.StoryHelper"
require "UI.Ctrl.Lottery.LotteryHelper"
UITouchHandle = require "UI.Misc.UITouchHandle"

ItemDataMgr = require("DataCenter.Item.ItemDataMgr")
DormActionMgr = require("DormAction.DormActionMgr")


DormDataMgr = require("DataCenter.Dorm.DormDataMgr").New()
OtakuFurniturDataMgr = require("DataCenter.Otaku.OtakuFurniturDataMgr").New()
PresentReturnDataMgr = require("DataCenter.Otaku.PresentReturnDataMgr").New()
DevelopMgr = require("DataCenter.Develop.DevelopMgr")
DevelopMgr:GetInstance()
MathUtil = require("Common.MathUtil")
MapUtil = require("Common.MapUtil")
OtakuHelper = require("UI.Ctrl.Otaku.OtakuHelper")
PlayerPrefTools = require("Common.PlayerPrefTools")
RedPointMgr = require("DataCenter.RedPoint.RedPointMgr")
CmderSkillMgr = require("DataCenter.Otaku.CmderSkillMgr").New()
PlotAtlasDataMgr = require("DataCenter.ComRoom.PlotAtlasDataMgr")
ActivityHelper = require("UI.Helpers.ActivityHelper")
DataGetterMgr = require("DataCenter.DataGetterMgr")
OtakuRedPointMgr = require("DataCenter.Otaku.OtakuRedPointMgr")

---------数据类
TaskDataMgr = (require "DataCenter.Task.TaskDataMgr").New()          --任务数据类
SettingDataMgr = (require "DataCenter.Setting.SettingDataMgr").New() --设置数据类
MailDataMgr = (require "DataCenter.Mail.MailDataMgr").New()          --邮件数据类
ComRoomDataMgr = (require "DataCenter.ComRoom.ComRoomDataMgr")       --通讯室数据类
VotingDataMgr = (require "DataCenter.Voting.VotingDataMgr")          --票选活动数据类
PhotoWallDataMgr = (require "DataCenter.PhotoWall.PhotoWallDataMgr") --照片墙数据类
TeamConfMgr = (require "DataCenter.TeamConfig.TeamConfMgr")          --编队数据类
GlobalTeamConfMgr = require "DataCenter.TeamConfig.GlobalTeamConfMgr"
EnTeamConfMgr = (require "DataCenter.TeamConfig.EnTeamConfMgr")      --遭遇战编队
EncounterConfMgr = require "DataCenter.TeamConfig.EncounterConfMgr"
BossWarTeamMgr = require "DataCenter.TeamConfig.BossWarTeamMgr"
ActivityDataMgr = (require "DataCenter.Activity.ActivityDataMgr") --活动总控数据类
GamesDataMgr = require("DataCenter.Games.GamesDataMgr")           --小游戏数据
ChiefNoteDataMgr = require("DataCenter.ComRoom.ChiefNoteDataMgr") --长官笔记数据类
ShopDataMgr = require("DataCenter.Shop.ShopDataMgr").New()        --商店数据类
DailyGolasDataMgr = require("DataCenter.Activity.DailyGolasDataMgr")
DormDailyGolasDataMgr = require("DataCenter.Dorm.DormDailyGolasDataMgr")
MissionDataMgr = require("DataCenter.Mission.MissionDataMgr")
CycleDataMgr = require("DataCenter.Cycle.CycleDataMgr")
StoryDataMgr = require("DataCenter.Story.StoryDataMgr") --剧情数据类UI
RechargeDataMgr = require("DataCenter.Shop.RechargeDataMgr")
PassDataMgr = require("DataCenter.Pass.PassDataMgr")
GmDataMgr = require("DataCenter.GM.GmDataMgr")
FriendDataMgr = require("DataCenter.Friend.FriendDataMgr")
AchievementDataMgr = require("DataCenter.Achievement.AchievementDataMgr")
GameKeyNodeMgr = require("DataCenter.GameKeyNode.GameKeyNodeMgr")
EnergyMgr = require("DataCenter.Energy.EnergyMgr")
OtakuRoomDataMgr = require("DataCenter.Otaku.OtakuRoomDataMgr")
RestaurantDataMgr = require("DataCenter.Otaku.RestaurantDataMgr")
ActivityCopyDataMgr = require("DataCenter.Otaku.ActivityCopyDataMgr")
OpenSystemMgr = require("DataCenter.OpenSystem.OpenSystemMgr")
SDKHelper = require("UI.Helpers.SDKHelper")
NotesWorkMgr = require("DataCenter.Notes.NotesWorkMgr")
BossWarDataMgr = require("DataCenter.BossWar.BossWarDataMgr")
DormPuzzleActivityDataMgr = require("DataCenter.Dorm.DormPuzzleActivityDataMgr")
LevelFundMgr = require("DataCenter.LevelFund.LevelFundMgr")
LimitDataMgr = require("DataCenter.Mission.LimitDataMgr")


OtakuRoomDataMgr:GetInstance()
ItemDataMgr:GetInstance()
PhotoWallDataMgr:GetInstance()
MissionDataMgr:GetInstance()
CycleDataMgr:GetInstance()
FriendDataMgr:GetInstance()
AchievementDataMgr:GetInstance()
GameKeyNodeMgr:GetInstance()
EnergyMgr:GetInstance()
VotingDataMgr:GetInstance()
TeamConfMgr:GetInstance()
EnTeamConfMgr:GetInstance()
ActivityDataMgr:GetInstance()
DailyGolasDataMgr:GetInstance()
DormDailyGolasDataMgr:GetInstance()
ActivityCopyDataMgr:GetInstance()
OpenSystemMgr:GetInstance()
RestaurantDataMgr:GetInstance()
LevelFundMgr:GetInstance()
RechargeDataMgr:GetInstance()
--初始化所有modules
ModuleMgr:GetInstance():SetModules()


---跳转
JumpConst = require "Config.JumpConst"
JumpMgr = require "JumpCommand.JumpMgr"
OpenConditionConst = require "Config.OpenConditionConst"
OpenConditionMgr = require "OpenCondition.OpenConditionMgr"
-----

DataGetterMgr:GetInstance():Load()
HotFixOfCS = require("DataCenter.HotFix.HotFixOfCS")
HotFixOfCS:Register()

--重连之后处理
function ReConnect()
    NetPack:OnReConnect()
end

function DisposeLuaRef()
    if UITouchHandle then
        UITouchHandle.Dispose()
    end

    EventMgr:Cleanup()

    GameObjectPool:GetInstance():Cleanup(true)

    TimerManager:GetInstance():Cleanup()
    TimerManager:GetInstance():Dispose()

    UpdateManager:GetInstance():Cleanup()
    UpdateManager:GetInstance():Dispose()

    UIContextMgr:GetInstance():Cleanup()
    UIContextMgr:GetInstance():Dispose()

    --VirtualCameraMgr:GetInstance():Cleanup()
    --VirtualCameraMgr:GetInstance():Dispose()

    DormActionMgr:GetInstance():Cleanup()
    DormActionMgr:GetInstance():Dispose()

    DormDataMgr:Cleanup()
    DormDataMgr:Dispose()

    OtakuFurniturDataMgr:Cleanup()
    OtakuFurniturDataMgr:Dispose()

    RedPointMgr:GetInstance():Cleanup()
    RedPointMgr:GetInstance():Dispose()

    CmderSkillMgr:Cleanup()
    CmderSkillMgr:Dispose()

    PlotAtlasDataMgr:GetInstance():Cleanup()
    PlotAtlasDataMgr:GetInstance():Dispose()

    GameKeyNodeMgr:GetInstance():Cleanup()
    GameKeyNodeMgr:GetInstance():Dispose()

    EnergyMgr:GetInstance():Cleanup()
    EnergyMgr:GetInstance():Dispose()

    NetPack:Cleanup()
    NetPack:Dispose()

    TaskDataMgr:Cleanup()
    TaskDataMgr:Dispose()

    MailDataMgr:Cleanup()
    MailDataMgr:Dispose()

    ComRoomDataMgr:GetInstance():Cleanup()
    ComRoomDataMgr:GetInstance():Dispose()

    ModuleMgr:GetInstance():Cleanup()
    ModuleMgr:GetInstance():Dispose()

    ChiefNoteDataMgr:GetInstance():Cleanup()
    ChiefNoteDataMgr:GetInstance():Dispose()

    ShopDataMgr:Cleanup()
    ShopDataMgr:Dispose()

    StoryDataMgr:GetInstance():Cleanup()
    StoryDataMgr:GetInstance():Dispose()

    RechargeDataMgr:GetInstance():Cleanup()
    RechargeDataMgr:GetInstance():Dispose()

    PassDataMgr:GetInstance():Cleanup()
    PassDataMgr:GetInstance():Dispose()

    GmDataMgr:GetInstance():Cleanup()
    GmDataMgr:GetInstance():Dispose()

    FriendDataMgr:GetInstance():Cleanup()
    FriendDataMgr:GetInstance():Dispose()

    MissionDataMgr:GetInstance():Cleanup()
    MissionDataMgr:GetInstance():Dispose()

    CycleDataMgr:GetInstance():Cleanup()
    CycleDataMgr:GetInstance():Dispose()

    DataGetterMgr:GetInstance():Cleanup()
    DataGetterMgr:GetInstance():Dispose()

    ActivityDataMgr:GetInstance():Cleanup()
    ActivityDataMgr:GetInstance():Dispose()


    ItemDataMgr:GetInstance():Cleanup()
    ItemDataMgr:GetInstance():Dispose()

    OtakuRoomDataMgr:GetInstance():Cleanup()
    OtakuRoomDataMgr:GetInstance():Dispose()

    NotesWorkMgr:GetInstance():Cleanup()
    NotesWorkMgr:GetInstance():Dispose()

    BossWarDataMgr:GetInstance():Cleanup()
    BossWarDataMgr:GetInstance():Dispose()

    DormPuzzleActivityDataMgr:GetInstance():Cleanup()
    DormPuzzleActivityDataMgr:GetInstance():Dispose()

    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()

    EnTeamConfMgr:GetInstance():Dispose()

    CommandMgr:GetInstance():Clear()
    CommandMgr:GetInstance():Dispose()

    OpenSystemMgr:GetInstance():Dispose()
    RestaurantDataMgr:GetInstance():Dispose()
    LevelFundMgr:GetInstance():Dispose()
    
    if HotFixOfCS then
        HotFixOfCS.Unregister()
    end

    IResourceManager = nil
    ISceneManager = nil
    IModuleMgr = nil
    IUIContextMgr = nil
    IUIManager = nil
    INetPack = nil
    IItemDataMgr = nil
    IGuideMgr = nil
    IHeroDataMgr = nil
    IPlayerData = nil
    IBattle = nil
    ICameraMgr = nil
    PhysicsMgr = nil
    IRoleActionMgr = nil
    SecurityHelper = nil
    ServiceLocator = nil
    PlayerPrefabHelper = nil
    CommandMgr = nil
    EventMgr = nil
    GameObjectPool = nil
    TimerManager = nil
    UpdateManager = nil
    NetPack = nil
    TaskDataMgr = nil
    MailDataMgr = nil
    ComRoomDataMgr = nil
    ShopDataMgr = nil
    StoryDataMgr = nil
    RechargeDataMgr = nil
    PassDataMgr = nil
    GmDataMgr = nil
    FriendDataMgr = nil
    CmderSkillMgr = nil
    PlotAtlasDataMgr = nil
    ChiefNoteDataMgr = nil
    ITimeMgr = nil
    IDataGetterMgr = nil
    ItemDataMgr = nil
    OtakuRoomDataMgr = nil
    NotesWorkMgr = nil
    BossWarDataMgr = nil
    DormPuzzleActivityDataMgr = nil
end
