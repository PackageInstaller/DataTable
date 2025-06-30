--[[ 
-----------------------------------------------------
@filename       : DupImpliedController
@Description    : 默示之境副本
@date           : 2021-07-05 11:50:42
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup/dupImplied.controller.DupImpliedController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_ENTER_PANEL, self.onOpenEnterPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DUP_IMPLIED_ENTER_PANEL, self.closeEnterPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_DUP_PANEL, self.onOpenDupPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_MATRIX_SHOW_PANEL, self.onOpenMatrixShowView, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_ABNORMAL_SHOW_PANEL, self.onOpenAbnormalShowView, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_OpenMatrixBook_PANEL, self.onOpenMatrixBookView, self)
    
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_RANK_PANEL, self.onOpenRankPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_LEVELSELECTPANEL, self.openDiffSelectPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_DUP_IMPLIED_RESET, self.onReqImpliedDupReset, self)
    GameDispatcher:addEventListener(EventName.REQ_DUP_IMPLIED_SELECT_MATRIX, self.onReqImpliedDupSelectBuff, self)
    GameDispatcher:addEventListener(EventName.REQ_DUP_IMPLIED_LEVELSELECT,self.onReqImplied_difficulty_select,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_IMPLIED_PANEL_INFO = self.onImplideInfoMsg,
        SC_IMPLIED_RESET = self.onImliedResetMsg,
        SC_IMPLIED_PASS_CITY = self.onImliedPassSelectBuffMsg,
        SC_IMPLIED_CHAPTER_END = self.onImliedChapterEndMsg,
        SC_IMPLIED_DIFFICULTY_SELECT = self.onImplied_difficulty_select,
    }
end

---------------------------消息交互------------------------------------
--- *c2s* 默示之塔难度选择 19127
function onReqImplied_difficulty_select(self,diff_id)
    SOCKET_SEND(Protocol.CS_IMPLIED_DIFFICULTY_SELECT,{difficulty = diff_id})
end

--- *c2s* 请求默示之塔面板信息 19120
function onReqImpliedDupInfo(self)
    SOCKET_SEND(Protocol.CS_IMPLIED_PANEL_INFO)
end

--- *c2s* 默示之塔重置章节 19122
function onReqImpliedDupReset(self, args)
    SOCKET_SEND(Protocol.CS_IMPLIED_RESET, { chapter_id = args.stageId })
end

--- *c2s* 默示之塔选择的buff 19125
function onReqImpliedDupSelectBuff(self, args)
    local cmd = {}
    cmd.city_id = args.dupId
    cmd.buff_id = args.matrixId
    SOCKET_SEND(Protocol.CS_IMPLIED_SELLECT_BUFF, cmd)
    self:onCloseMatrixSelectViewHandler()
end

--- *s2c* 默示之塔难度选择结果返回 19128
function onImplied_difficulty_select(self,args)
    self:openEnterPanel()
end

--- *s2c* 默示之塔面板信息返回 19121
function onImplideInfoMsg(self, msg)
    self.mMgr:parseImplideInfoMsg(msg)
end

--- *s2c* 默示之塔重置返回 19123
function onImliedResetMsg(self, msg)

end

--- *s2c* 默示之塔挑战通过后选择buff 19124
function onImliedPassSelectBuffMsg(self, msg)
    self.mMgr:parseImliedPassSelectBuffMsg(msg)
end

--- *s2c* 默示之塔章节结束 19126
function onImliedChapterEndMsg(self, msg)
    self.mMgr:parseImpliedChapterEndMsg(msg)
end


---------------------------逻辑相关------------------------------------
-- 展示战利品选择
function onShowSelectMatrix(self, callBack)
    self.mSelectMatrixCallBack = callBack
    if self.mMgr.matrixSelectData and #self.mMgr.matrixSelectData.buff_list > 0 then
        self:onOpenMatrixSelectView(self.mMgr.matrixSelectData)
        self.mMgr.matrixSelectData = nil
    else
        if self.mSelectMatrixCallBack then
            self.mSelectMatrixCallBack()
            self.mSelectMatrixCallBack = nil
        end
    end
end
---------------------------UI相关--------------------------------------
-- 打开希望副本选章页面
function onOpenEnterPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_IMPLIED, true) == false then
        return
    end
    if dup.DupImpliedManager:getImpliedDiffId() == 0 then 
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_LEVELSELECTPANEL)
        return
    end

    self:openEnterPanel(args)
end

--打开希望副本选章页面
function openEnterPanel(self,args)
    if self.mMainPanel == nil then
        self.mMainPanel = dup.DupImpliedEnterPanel.new()
        self.mMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEnterPanelHandler, self)
    end
    self.mMainPanel:open(args)
end

--关闭希望副本选章页面
function closeEnterPanel(self)
    if self.mMainPanel  then
        self.mMainPanel:close()
    end
end

-- ui销毁
function onDestroyEnterPanelHandler(self)
    self.mMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEnterPanelHandler, self)
    self.mMainPanel = nil
end

-- 打开希望副本页面
function onOpenDupPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_IMPLIED, true) == false then
        return
    end
    if self.mDupPanel == nil then
        self.mDupPanel = dup.DupImpliedDupPanel.new()
        self.mDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    end
    self.mDupPanel:open(args)
end

-- ui销毁
function onDestroyDupPanelHandler(self)
    self.mDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    self.mDupPanel = nil
end

-- 打开拥有异常界面
function onOpenAbnormalShowView(self, args)
    if self.mAbnormalShowView == nil then
        self.mAbnormalShowView = dup.DupImpliedAbnormalShowView.new()
        self.mAbnormalShowView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAbnormalShowViewHandler, self)
    end
    self.mAbnormalShowView:open(args)
end
-- ui销毁
function onDestroyAbnormalShowViewHandler(self)
    self.mAbnormalShowView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAbnormalShowViewHandler, self)
    self.mAbnormalShowView = nil
end

-- 打开拥有矩阵展示界面
function onOpenMatrixShowView(self, args)
    if self.mMatrixShowView == nil then
        self.mMatrixShowView = dup.DupImpliedMatrixShowView.new()
        self.mMatrixShowView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixShowViewHandler, self)
    end
    self.mMatrixShowView:open(args)
end
-- ui销毁
function onDestroyMatrixShowViewHandler(self)
    self.mMatrixShowView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixShowViewHandler, self)
    self.mMatrixShowView = nil
end

-- 打开通关矩阵选择界面
function onOpenMatrixSelectView(self, args)
    if self.mMatrixSelectView == nil then
        self.mMatrixSelectView = dup.DupImpliedMatrixSelectView.new()
        self.mMatrixSelectView:addEventListener(View.EVENT_CLOSE, self.onCloseMatrixSelectViewCall, self)
        self.mMatrixSelectView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixSelectViewHandler, self)
    end
    self.mMatrixSelectView:open(args)
end
function onCloseMatrixSelectViewHandler(self)
    if self.mMatrixSelectView then
        self.mMatrixSelectView:close()
    end
end
-- 关闭回调
function onCloseMatrixSelectViewCall(self)
    if self.mSelectMatrixCallBack then
        self.mSelectMatrixCallBack()
        self.mSelectMatrixCallBack = nil
    end
end

-- ui销毁
function onDestroyMatrixSelectViewHandler(self)
    self.mMatrixSelectView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixSelectViewHandler, self)
    self.mMatrixSelectView = nil
end

-- 打开通关矩阵图鉴界面
function onOpenMatrixBookView(self, args)
    if self.mMatrixBookView == nil then
        self.mMatrixBookView = dup.DupImpliedMatrixBookView.new()
        self.mMatrixBookView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixBookViewHandler, self)
    end
    self.mMatrixBookView:open(args)
end

-- ui销毁
function onDestroyMatrixBookViewHandler(self)
    self.mMatrixBookView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixBookViewHandler, self)
    self.mMatrixBookView = nil
end


--打开难度选择界面
function openDiffSelectPanel(self)
    if not self.mSelectDiffPanel then 
        self.mSelectDiffPanel = dup.DupImpliedLevelSelectPanel.new()
        self.mSelectDiffPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDiffSelectViewHandler, self)
    end
    self.mSelectDiffPanel:open()
end

function onDestroyDiffSelectViewHandler(self)
    self.mSelectDiffPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMatrixSelectViewHandler, self)
    self.mSelectDiffPanel = nil
end

-- 打开排行榜界面
function onOpenRankPanel(self, args)
    if self.mRankPanel == nil then
        self.mRankPanel = dup.DupImpliedRankHallPanel.new()
        self.mRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankPanelHandler, self)
    end
    self.mRankPanel:open(args)
end
-- ui销毁
function onDestroyRankPanelHandler(self)
    self.mRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankPanelHandler, self)
    self.mRankPanel = nil
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
