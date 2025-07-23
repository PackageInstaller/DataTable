module("training.TrainingSceneController", Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    if self.mMgr then
        for i = 1, #self.mMgr do
            if(self.mMgr[i] and self.mMgr[i].resetData)then
                self.mMgr[i]:resetData()
            end
        end
    end
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.TRAINING
end

-- 地图资源名
function getMapID(self)
    return 164
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    self:__addEvent()
    self:__onResCompleteHandler()
	UIFactory:closeForcibly()
end

-- 清理当前地图
function clearMap(self)
    UIFactory:startForcibly()
    self:__removeEvent()
    AudioManager:stopAudioSound(self.m_loopAudio)
    self.m_loopAudio = nil
    self:__closeTrainingScene()
    super.clearMap(self)
end

function __addEvent(self)
    GameDispatcher:addEventListener(EventName.EXIT_TRAINING_SCENE, self.__onExitTrainingSceneHandler, self)
end

function __removeEvent(self)
    GameDispatcher:removeEventListener(EventName.EXIT_TRAINING_SCENE, self.__onExitTrainingSceneHandler, self)
end

-- 退出模拟训练场景
function __onExitTrainingSceneHandler(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    -- GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
end

---------------------------------------------------------------------------监听事件-----------------------------------------------------------------------------
-- 资源加载完毕
function __onResCompleteHandler(self)
    self:__openTrainingScene()
    GameDispatcher:dispatchEvent(EventName.TRAINING_SCENE_LOAD_SUC)
end

-- 打开场景内容
function __openTrainingScene(self)
    if(not self.mTrainingScene)then
        self.mTrainingScene = training.TrainingScene.new()
    end
    self.mTrainingScene:open()
end
-- 关闭场景内容
function __closeTrainingScene(self)
    if(self.mTrainingScene)then
        self.mTrainingScene:close()
        self.mTrainingScene = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
