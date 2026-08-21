module("battleMap.FragmentMapController", Class.impl(Controller))

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
    -- GameDispatcher:addEventListener(EventName.PLAY_STORY_PIC_ANI, self.__onPlayStoryPicHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_UNLOCK_FRAGMENT, self.onReqUnlockChapterrHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FRAGMENT_STAGEVIEW, self.__onOpenStageListPanelHandler, self)
    -- GameDispatcher:addEventListener(EventName.CLOSE_MAIN_STAGE_LIST_PANEL, self.__onCloseStageListPanelHandler, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_MAIN_STAGE_INFO, self.__onOpenStageInfoHandler, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_SATGEAWARD_VIEW, self.onOpenStageAwardViewHandler, self)
    -- GameDispatcher:addEventListener(EventName.REQ_STORY_MAIN_STORY_STAGE_AWARD, self.onReqStoryStageAwardListHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 支线副本面板信息 18100
        SC_BRANCH_PLOT_PANEL = self.__onMainMapInfoMsgHandler,
        SC_BRANCH_PLOT_UNLOCK_CHAPTER = self.onUnlockNewChapter,
        --- *s2c* 支线副本更新章节信息 18103
        SC_BRANCH_PLOT_UPDATE_CHAPTER = self.onUpdateChapter
        -- --- *s2c* 主线关卡 18000
        -- SC_MAIN_STORY_INFO = self.__onMainMapInfoMsgHandler,
        -- --- *s2c* 已领取主线关卡奖励 18054
        -- SC_MAIN_STORY_STAGE_AWARD_LIST = self.onStoryStageAwardListHandler,
        -- --- *s2c* 主线播放章节插图 18052         
        -- SC_MAIN_STORY_PLAY_CHAPTER_PIC = self.__onStoryChapterPicHandler
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 支线关卡
function __onMainMapInfoMsgHandler(self, msg)
    battleMap.FragmentMapManager:parseMsg(msg)
end

function onUnlockNewChapter(self, msg)
    if (msg.result == 1) then
        battleMap.FragmentMapManager:unLockChapter(msg)
    end
end

function onUpdateChapter(self, msg)
    battleMap.FragmentMapManager:updateChapter(msg)
end

--- *c2s* 支线副本解锁新的章节 18101
function onReqUnlockChapterrHandler(self, args)
    SOCKET_SEND(Protocol.CS_BRANCH_PLOT_UNLOCK_CHAPTER, { chapter_id = args.id })
end


------------------------------------------------------------------------ 战斗地图大厅面板 ------------------------------------------------------------------------
-- -- 打开主线列表面板
-- function __onOpenStagePanelHandler(self, cusChapterVo)
--     if self.m_stagePanel == nil then
--         self.m_stagePanel = battleMap.MainMapTabView.new()
--         self.m_stagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStagePanelHandler, self)
--     end
--     self.m_stagePanel:open()
-- end

-- -- ui销毁
-- function __onDestroyStagePanelHandler(self)
--     self.m_stagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStagePanelHandler, self)
--     self.m_stagePanel = nil
-- end

-- function __onPlayStoryPicHandler(self, args)
--     if self.mFinishPic == nil then
--         if args.id == 1 then
--             self.mFinishPic = battleMap.MainMapFinish01View.new()
--         elseif args.id == 2 then
--             self.mFinishPic = battleMap.MainMapFinish02View.new()
--         elseif args.id == 3 then
--             self.mFinishPic = battleMap.MainMapFinish03View.new()
--         else
--             self.mFinishPic = battleMap.MainMapFinish01View.new()
--         end

--         self.mFinishPic:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyPlayStoryHandler, self)
--     end
--     self.mFinishPic:setCallFinish(args.callback)
--     self.mFinishPic:open()
-- end

-- function __onDestroyPlayStoryHandler(self)
--     self.mFinishPic:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyPlayStoryHandler, self)
--     self.mFinishPic = nil
-- end

------------------------------------------------------------------------ 战斗地图大厅面板 ------------------------------------------------------------------------
-- 打开支线关卡城池列表面板
function __onOpenStageListPanelHandler(self, args)
    -- local canPlay = battleMap.MainMapManager:canChaterPic(args.chapterVo.chapterId)
    -- if canPlay then
    --     local function callback()
    --         SOCKET_SEND(Protocol.CS_MAIN_STORY_PLAY_CHAPTER_PIC, { chapter_id = args.chapterVo.chapterId })
    --         if self.m_stageListPanel == nil then
    --             self.m_stageListPanel = battleMap.FragmentStageListPanel.new()
    --             self.m_stageListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
    --         end
    --         self.m_stageListPanel:open({ chapterVo = args.chapterVo, stageVo = args.stageVo })
    --     end
    --     GameDispatcher:dispatchEvent(EventName.PLAY_STORY_PIC_ANI, { callback = callback, id = args.chapterVo.chapterId })
    -- else
        if self.m_stageListPanel == nil then
            self.m_stageListPanel = battleMap.FragmentStageListPanel.new()
            self.m_stageListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
        end
        self.m_stageListPanel:open({ chapterVo = args.chapterVo, stageVo = args.stageVo })
    -- end
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

------------------------------------------------------------------------ 主线关卡阶段性奖励弹窗 ------------------------------------------------------------------------
-- 打开主线关卡城池信息面板
function onOpenStageAwardViewHandler(self, args)
    if self.mStageAwardView == nil then
        self.mStageAwardView = battleMap.FragmentStageAwardItem.new()
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