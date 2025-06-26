--base--
Class = require 'lib/Class'
GameManager = require('game/common/manager/GameManager').new()
LoadOnManager = require('game/common/manager/LoadOnManager').new()
UrlManager = require('game/common/manager/UrlManager').new()
-- AudioGoPlayer = require('game/common/manager/AudioGoPlayer').new()
AudioDataVo = require 'game/common/manager/vo/AudioDataVo'
AudioFightEffectDataVo = require 'game/common/manager/vo/AudioFightEffectDataVo'
AudioManager = require('game/common/manager/AudioManager').new()

-- common vo--
LyScrollerSelectVo = require 'game/common/manager/vo/LyScrollerSelectVo'

require('utils/AvproUtil')
BoardShower = require("utils/BoardShower").new()
require 'utils/TableUtil'
require 'utils/StringUtil'
JsonUtil = require 'utils/JsonUtil'
SnMgr = require('utils/SnMgr').new()
-- LanguageUtil = require 'utils/LanguageUtil'
--加载常量或配置文件 BEGIN
--加载常量或配置文件 END
require("def/const_storage_key")
require("def/const_color_def")
require("def/const_ui_def")
--加载工具文件 BEGIN
require("utils/math/FixMath")

--日志设置
Debug = require 'utils/debug/Debug'
Debug:setOpenLog(GameManager.LOG_SHOW)
Debug:setLogType(GameManager.LOG_LIMIT_LEVEL)
Debug:setNeedLog(GameManager.LOG_EXCLUSIVE)
Debug:setIgnoreLog(GameManager.LOG_IGNORE)

--组件
BaseComponent = require 'lib/component/BaseComponent'
BaseReuseItem = require 'lib/component/BaseReuseItem'
SimpleInsItem = require 'lib/component/SimpleInsItem'
StateButton = require 'lib/component/StateButton'
TabBar = require 'lib/component/TabBar'
TabData = require 'lib/component/TabData'
SkillGrid = require 'lib/component/SkillGrid'
BaseGrid = require 'lib/component/BaseGrid'
PropsGrid = require 'lib/component/PropsGrid'
PropsGrid2 = require 'lib/component/PropsGrid2'
EquipGrid = require 'lib/component/EquipGrid'
EquipGrid2 = require 'lib/component/EquipGrid2'
EquipGrid3 = require 'lib/component/EquipGrid3'
OrderGrid = require 'lib/component/OrderGrid'
BraceletsGrid = require 'lib/component/BraceletsGrid'
BraceletsGrid2 = require 'lib/component/BraceletsGrid2'
PropsSelectGrid = require 'lib/component/PropsSelectGrid'
PropsAddGrid = require 'lib/component/PropsAddGrid'
HeroHeadGrid = require 'lib/component/HeroHeadGrid'
HeroHeadSelectGrid = require 'lib/component/HeroHeadSelectGrid'
HeroHeadAddGrid = require 'lib/component/HeroHeadAddGrid'
PlayerHeadGrid = require 'lib/component/PlayerHeadGrid'
MonsterHeadGrid = require 'lib/component/MonsterHeadGrid'
EquipSelectGrid = require 'lib/component/EquipSelectGrid'
PlayerHeadFrameGrid = require 'lib/component/PlayerHeadFrameGrid'
CustomTabBar = require 'lib/component/CustomTabBar'
CustomTabBar2 = require 'lib/component/CustomTabBar2'
DropDownEx = require("lib/component/DropDownEx")
DropDown = require("lib/component/DropDown")
ArcScrollList = require("lib/component/ArcScrollList")
ArcScrollBaseItem = require("lib/component/ArcScrollBaseItem")
Gyro = require 'lib/component/Gyro'
SceneGyro = require 'lib/component/SceneGyro'
DeltaList = require("lib/component/DeltaList")
--util
AssetLoader = require 'utils/AssetLoader'
U3DSceneUtil = require('utils/U3DSceneUtil').new()
-- PrefabApi = require 'utils/PrefabApi'
FilterWordUtil = require 'utils/FilterWordUtil'
GoUtil = require 'utils/GoUtil'
WebInterfaceUtil = require 'utils/WebInterfaceUtil'
StorageUtil = require("utils/Storage").new()
ColorUtil = require("utils/ColorUtil")
HtmlUtil = require("utils/HtmlUtil")
TimeUtil = require("utils/TimeUtil")
ScreenUtil = require("utils/ScreenUtil")
VideoAdaptUtil = require("utils/VideoAdaptUtil")
RichTextUtil = require("utils/RichTextUtil").new()
ModelScenePlayer = require 'utils/ModelScenePlayer'
ModelPlayer = require 'utils/ModelPlayer'
ModelShowPlayer = require 'utils/ModelShowPlayer'
-- Audio = require ('utils/Audio').new()
MoneyUtil = require 'utils/MoneyUtil'
ModelLayerUtil = require 'utils/ModelLayerUtil'
MultiLock = require 'utils/MultiLock'
LuaUtil = require 'utils/LuaUtil'
PostHandler = require 'utils/PostHandler'
GCUtil = require 'utils/GCUtil'
AnimatorUtil = require 'utils/AnimatorUtil'
UISceneBgUtil = require 'utils/UISceneBgUtil'


CameraUtil = require "utils/CameraUtil"
CustomCamera = require "utils/CustomCamera"

--base cls
BaseRefVo = require('lib/base/BaseRefVo')

--mgr
UI = require("lib/mgr/UIManager")
UIEffectMgr = require("lib/mgr/UIEffectMgr")
LanguageMgr = require('lib/mgr/LanguageMgr').new()
LuaPoolMgr = require('lib/mgr/LuaPoolMgr').new()
RefMgr = require('lib/mgr/RefMgr').new()
RefMgr:setBasePath("ref/")
RefMgr:setLanPath("ref/" .. LanguageMgr:getLanuage() .. "/")

RootLoop = require('utils/loop/RootLoop').new()
LoopVo = require('utils/loop/LoopVo')
--正常的帧循环处理器
LoopManager = require('utils/loop/LoopManager').new()
--带速率的帧循环处理器 （一般战斗中使用）
RateLooper = require('utils/loop/RateLooper').new()
--带速率的帧循环处理器 并且不受timeScale影响（一般战斗中使用）
RateLooperUnScale = require('utils/loop/RateLooperUnScale').new()

-- fight.Looper = require('game/fight/utils/Looper').new()
-- RateLooperUnScale = require('game/fight/utils/LooperUnScale').new()

SubLayerMgr = require('game/common/manager/SubLayerMgr').new()
ProgramTextMgr = require('lib/mgr/ProgramTextMgr').new()

-- 程序文本的快捷方法
_TT = function(cusID, ...)
    local cnt = select("#", ...)
    if cnt > 0 then
        return string.substitute(ProgramTextMgr:getTxt(cusID), ...)
    else
        return ProgramTextMgr:getTxt(cusID)
    end
end
-- 语言更新事件
local function _lanUpdate(oldLan, newLan)
    RefMgr:clearAllData()
    RefMgr:setLanPath("ref/" .. newLan .. "/")
end
LanguageMgr:addFirstUpdateEvent(_lanUpdate)

-- --日记记录
function logAll(msg, tag)
    if CS.UnityEngine.RuntimePlatform.WindowsEditor then
        Debug.Log(msg, tag)
    end
end

function logInfo(msg, tag)
    if GameManager.IS_DEBUG then
        if type(msg) == "table" then
            msg = Debug:print_table(msg)
        end
        tag = tag or ""
        Debug:log_info(tag, msg)
    end
end

function logError(msg, tag)
    if type(msg) == "table" then
        msg = Debug:print_table(msg)
    end
    tag = tag or ""
    Debug:log_error(tag, msg)
end

function logWarn(msg, tag)
    if type(msg) == "table" then
        msg = Debug:print_table(msg)
    end
    tag = tag or ""
    Debug:log_warn(tag, msg)
end

function cusLog(msg)
    Debug:cuslog_info(msg)
end

--加载工具文件 END
--MVC--
Manager = require 'lib/mvc/Manager'
View = require 'lib/mvc/View'
TabView = require 'lib/mvc/TabView'
TabSubView = require 'lib/mvc/TabSubView'
Controller = require 'lib/mvc/Controller'

--event--
require('game/event/EventName')
GameDispatcher = require('game/event/GameDispatcher').new()

--handler
-- StandOut3DHandler = require('game/common/handler/StandOut3DHandler').new()
UIFactory = require('game/common/handler/UIFactory').new()
TweenFactory = require('game/common/handler/TweenFactory').new()
TextureCameraHandler = require('game/common/handler/TextureCameraHandler').new()
Perset3dHandler = require('game/common/handler/Perset3dHandler').new()

local function _unLoadLua(path)
    package.loaded[path] = nil
end
CS.Lylibs.LuaFileWatcher.SetLuaReloadCallback(_unLoadLua)

-- 设置资源缓存策略
function SetCacheRule()
    if (gs.Application.platform ~= gs.RuntimePlatform.WindowsPlayer) then
        gs.ResMgr:SetRule("arts/character/role", 20, 10, false)
        gs.ResMgr:SetRule("arts/character/weapon", 20, 10, false)
        gs.ResMgr:SetRule("arts/character/monster", 10, 5, true)
    end
end
