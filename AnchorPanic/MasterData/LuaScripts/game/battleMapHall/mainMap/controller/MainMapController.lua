module("battleMap.MainMapController", Class.impl(Controller))

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
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_MAIN_STAGE_PANEL, self.__onOpenStagePanelHandler, self)
    GameDispatcher:addEventListener(EventName.PLAY_STORY_PIC_ANI, self.__onPlayStoryPicHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_STORY_PIC_PLAY, self.__onReqStoryPicHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_MAIN_STAGE_LIST_PANEL, self.__onOpenStageListPanelHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAIN_STAGE_LIST_PANEL, self.__onCloseStageListPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_MAIN_STAGE_INFO, self.__onOpenStageInfoHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_SATGEAWARD_VIEW, self.onOpenStageAwardViewHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAIN_STAGE_INFO, self.__onCloseStageInfoHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_STORY_MAIN_STORY_STAGE_AWARD, self.onReqStoryStageAwardListHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 主线关卡 18000
        SC_MAIN_STORY_INFO = self.__onMainMapInfoMsgHandler,
        --- *s2c* 已领取主线关卡奖励 18054
        SC_MAIN_STORY_STAGE_AWARD_LIST = self.onStoryStageAwardListHandler,
        --- *s2c* 主线播放章节插图 18052         
        SC_MAIN_STORY_PLAY_CHAPTER_PIC = self.__onStoryChapterPicHandler
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 主线关卡
function __onMainMapInfoMsgHandler(self, msg)
    battleMap.MainMapManager:parseMsg(msg)

    battleMap.MainMapManager.isDataInit = true

    if mainCity.MainCityManager.isLoadCompleted then
        local isGuide = guide.GuideManager:checkResetGuide()
        if (isGuide) then
            guide.GuideManager:startTodoEvent()
            -- 关闭登录的初始加载界面
            if (loginLoad.LoginLoadController:isLoginLoading()) then
                loginLoad.LoginLoadController:destroyLoading()
            end

        end
    end
end

function __onStoryChapterPicHandler(self, msg)
    if (msg.result == 1) then
        battleMap.MainMapManager:updateChaterPic(msg)
    end
end
--- *s2c* 已领取主线关卡奖励 18054
function onStoryStageAwardListHandler(self, msg)
        battleMap.MainMapManager:parseReceivedStageAwardListMsg(msg.stage_list)
end

--- 请求已领取主线关卡奖励
function onReqStoryStageAwardListHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAIN_STORY_STAGE_AWARD, { stage_id = args.id })
end


------------------------------------------------------------------------ 战斗地图大厅面板 ------------------------------------------------------------------------
-- 打开主线列表面板
function __onOpenStagePanelHandler(self, cusChapterVo)
    if self.m_stagePanel == nil then
        self.m_stagePanel = battleMap.MainMapTabView.new()
        self.m_stagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStagePanelHandler, self)
    end
    self.m_stagePanel:open()
end

-- ui销毁
function __onDestroyStagePanelHandler(self)
    self.m_stagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStagePanelHandler, self)
    self.m_stagePanel = nil
end

function __onPlayStoryPicHandler(self, args)
    if self.mFinishPic == nil then
        local viewClasses = {
            [1] = battleMap.MainMapFinish01View,
            [2] = battleMap.MainMapFinish02View,
            [3] = battleMap.MainMapFinish03View,
            [4] = battleMap.MainMapFinish04View,
            [5] = battleMap.MainMapFinish05View,
            [6] = battleMap.MainMapFinish06View,
            [7] = battleMap.MainMapFinish07View,
            [8] = battleMap.MainMapFinish08View,
            [9] = battleMap.MainMapFinish09View,
            [10] = battleMap.MainMapFinish10View,
            [11] = battleMap.MainMapFinish11View,
            [12] = battleMap.MainMapFinish12View
        }

        local viewClass = viewClasses[args.id]
        self.mFinishPic = viewClass.new() -- 动态加载类并创建实例，确保正确的类名和路径
        self.mFinishPic:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyPlayStoryHandler, self)
    end
    self.mFinishPic:setCallFinish(args.callback)
    self.mFinishPic:open()
end

function __onDestroyPlayStoryHandler(self)
    self.mFinishPic:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyPlayStoryHandler, self)
    self.mFinishPic = nil
end

------------------------------------------------------------------------ 战斗地图大厅面板 ------------------------------------------------------------------------
-- 打开主线关卡城池列表面板
function __onOpenStageListPanelHandler(self, args)
    local canPlay = battleMap.MainMapManager:canChaterPic(args.chapterVo.chapterId)
    if canPlay then
        local function callback()
            SOCKET_SEND(Protocol.CS_MAIN_STORY_PLAY_CHAPTER_PIC, { chapter_id = args.chapterVo.chapterId })
            if self.m_stageListPanel == nil then
                self.m_stageListPanel = battleMap.MainMapStageListPanel.new()
                self.m_stageListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
            end
            self.m_stageListPanel:open({ chapterVo = args.chapterVo, stageVo = args.stageVo })
        end
        GameDispatcher:dispatchEvent(EventName.PLAY_STORY_PIC_ANI, { callback = callback, id = args.chapterVo.chapterId })
    else
        if self.m_stageListPanel == nil then
            self.m_stageListPanel = battleMap.MainMapStageListPanel.new()
            self.m_stageListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
        end
        self.m_stageListPanel:open({ chapterVo = args.chapterVo, stageVo = args.stageVo })
    end
end

-- ui销毁
function __onDestroyStageListPanelHandler(self)
    self.m_stageListPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
    self.m_stageListPanel = nil
end

-- 关闭主线关卡城池信息面板
function __onCloseStageListPanelHandler(self)
    if self.m_stageListPanel then
        self.m_stageListPanel:close()
    end
end

------------------------------------------------------------------------ 主线关卡城池信息面板 ------------------------------------------------------------------------
-- 打开主线关卡城池信息面板
function __onOpenStageInfoHandler(self, args)
    -- if self.gInfoView == nil then
    --     self.gInfoView = battleMap.MainMapStageInfoPanel.new()
    --     self.gInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageInfoViewHandler, self)
    -- end
    -- self.gInfoView:open(args.stageId)
end

-- ui销毁
function __onDestroyStageInfoViewHandler(self)
    -- if self.gInfoView ~= nil then
    --     self.gInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageInfoViewHandler, self)
    --     self.gInfoView = nil
    -- end
end

-- 关闭主线关卡城池信息面板
function __onCloseStageInfoHandler(self)
    if self.gInfoView then
        self.gInfoView:close()
    end
end
------------------------------------------------------------------------ 主线关卡阶段性奖励弹窗 ------------------------------------------------------------------------
-- 打开主线关卡城池信息面板
function onOpenStageAwardViewHandler(self, args)
    if self.mStageAwardView == nil then
        self.mStageAwardView = battleMap.MainMapStageAwardView.new()
        self.mStageAwardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStageAwardViewHandler, self)
    end
    self.mStageAwardView:open(args)
end

-- ui销毁
function onDestroyStageAwardViewHandler(self)
    if self.mStageAwardView ~= nil then
        self.mStageAwardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStageAwardViewHandler, self)
        self.mStageAwardView = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]