module("maze.MazeSceneController", Class.impl(map.MapBaseController))

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
    return MAP_TYPE.MAZE
end

-- 地图资源名
function getMapID(self)
    local sceneId = 156
    local mazeId = maze.MazeSceneManager:getMazeId()
    if(mazeId)then
        local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(mazeId)
        if(mazeConfigVo)then
            sceneId = mazeConfigVo:getSceneId()
        end
    end
    return sceneId
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
end

-- 清理当前地图
function clearMap(self)
    UIFactory:startForcibly()
    self:__removeEvent()
    AudioManager:stopAudioSound(self.m_loopAudio)
    self.m_loopAudio = nil
    self:__closeMazeScenePanel()
    self:__closeMazeScene()
    maze.MazeEffectExecutor:resetEffect()
    maze.MazeEventExecutor:resetExecutor()
    maze.MazeSceneManager:resetMazeData(true)
    super.clearMap(self)
end

function __addEvent(self)
    GameDispatcher:addEventListener(EventName.MAZE_ADD_EVENT_TRIGGER, self.__onAddEventTriggerHandler, self)
    GameDispatcher:addEventListener(EventName.MAZE_REMOVE_EVENT_TRIGGER, self.__onRemoveEventTriggerHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAZE_SCENE, self.__onCloseMazeSceneHandler, self)
    GameDispatcher:addEventListener(EventName.MAZE_START_FINDPATH,self.showFindPathEfx,self)
    GameDispatcher:addEventListener(EventName.MAZE_FINISH_FINDPATH,self.hideFindPathEfx,self)

end

function __removeEvent(self)
    GameDispatcher:removeEventListener(EventName.MAZE_ADD_EVENT_TRIGGER, self.__onAddEventTriggerHandler, self)
    GameDispatcher:removeEventListener(EventName.MAZE_REMOVE_EVENT_TRIGGER, self.__onRemoveEventTriggerHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_MAZE_SCENE, self.__onCloseMazeSceneHandler, self)
    GameDispatcher:removeEventListener(EventName.MAZE_START_FINDPATH,self.showFindPathEfx,self)
    GameDispatcher:removeEventListener(EventName.MAZE_FINISH_FINDPATH,self.hideFindPathEfx,self)
end

---------------------------------------------------------------------------监听事件-----------------------------------------------------------------------------
-- 资源加载完毕
function __onResCompleteHandler(self)
    self:__openMazeScene()
    self:__openMazeScenePanel()
end

--- 添加触碰事件触发器
function __onAddEventTriggerHandler(self, args)
    maze.MazeSceneThingManager:setEventTrigger(args.eventTrigger)
    self.mMazeScene:addEventTrigger()
end

--- 移除触碰事件触发器
function __onRemoveEventTriggerHandler(self, args)
    self.mMazeScene:removeEventTrigger()
    maze.MazeSceneThingManager:setEventTrigger(args.eventTrigger)
end

-- 触发退出迷宫
function __onCloseMazeSceneHandler(self)
    -- 通知后端退出
    GameDispatcher:dispatchEvent(EventName.REQ_MAZE_EXIT, {mazeId = maze.MazeSceneManager:getMazeId()})
    -- 回到主界面
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    -- GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
end

-- 打开场景内容
function __openMazeScene(self)
    if(not self.mMazeScene)then
        self.mMazeScene = maze.MazeScene.new()
    end
    self.mMazeScene:open()
end
-- 关闭场景内容
function __closeMazeScene(self)
    if(self.mMazeScene)then
        self.mMazeScene:close()
        self.mMazeScene = nil
    end
end

--显示寻路特效
function showFindPathEfx(self,args)
    if(self.mMazeScene)then
        self.mMazeScene:showFindPathEfx(true)
        self.mMazeScene:setFindPathTileEfxPos(args.row, args.col)
    end 
end

--隐藏寻路特效
function hideFindPathEfx(self)
    if(self.mMazeScene)then
        self.mMazeScene:showFindPathEfx(false)
    end
end

-- 打开迷宫场景面板
function __openMazeScenePanel(self, args)
    if(not self.mMazeScenePanel)then
        self.mMazeScenePanel = maze.MazeScenePanel.new()
        local function destroyPanel()
            self.mMazeScenePanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeScenePanel = nil
        end
        self.mMazeScenePanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeScenePanel:open()
end
-- 关闭迷宫场景面板
function __closeMazeScenePanel(self)
    if(self.mMazeScenePanel and self.mMazeScenePanel.isPop)then
        self.mMazeScenePanel:close()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
