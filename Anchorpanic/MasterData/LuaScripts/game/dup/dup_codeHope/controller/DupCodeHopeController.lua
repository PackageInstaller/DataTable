--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeController
@Description    : 代号·希望副本控制器
@date           : 2021-05-10 14:36:04
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.controller.DupCodeHopeController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_DUP_CODE_HOPE_PANEL, self.onOpenMainPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_CODE_HOPE_CHAPTER, self.onOpenDupPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_CODE_HOPE_RESET, self.onOpenResetView, self)
    GameDispatcher:addEventListener(EventName.OPEN_CODE_HOPE_SHOW_BUFF, self.onOpenShowBuffView, self)
    GameDispatcher:addEventListener(EventName.OPEN_CODE_HOPE_RANK_PANEL, self.onOpenRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_CODE_HOPE_DUP_INFO, self.onReqCodeHopeDupInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_CODE_HOPE_CHAPTER_AWARD, self.onReqCodeHopeChapterAward, self)
    GameDispatcher:addEventListener(EventName.REQ_CODE_HOPE_RESET, self.onReqCodeHopeReset, self)
    GameDispatcher:addEventListener(EventName.REQ_CODE_HOPE_HERO_INFO, self.onReqCodeHopeHeroInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_CODE_HOPE_RANK_DATA, self.onReqCodeHopeRankInfo, self)


    dup.DupMainManager:addEventListener(dup.DupMainManager.EVENT_DUP_INFO_INIT, self.onDupInfoUpdate, self)
    dup.DupMainManager:addEventListener(dup.DupMainManager.EVENT_DUP_INFO_UPDATE, self.onDupInfoUpdate, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_CODE_HOPE_PANEL_INFO = self.onCodeHopeInfoMsg,
        SC_GAIN_CODE_HOPE_CHAPTER_AWARD = self.onCodeHopeChapterAwardMsg,
        SC_RESET_CODE_HOPE_CHAPTER = self.onCodeHopeResetMsg,
        SC_CODE_HOPE_HERO_INFO = self.onCodeHopeHeroInfoMsg,
        SC_CODE_HOPE_ACTIVE_BUFF = self.onCodeHopeActiveBuffMsg,
        SC_CODE_HOPE_CHAPTER_END = self.onCodeHopeChapterEndMsg,
    -- SC_CODE_HOPE_RANK_INFO = self.onCodeHopeRankInfoMsg,
    }
end

---------------------------消息交互------------------------------------------
--- *c2s* 请求代号希望副本信息 19140
function onReqCodeHopeDupInfo(self)
    SOCKET_SEND(Protocol.CS_CODE_HOPE_PANEL_INFO)
end

--- *c2s* 请求领取代号希望章节奖励 19142
function onReqCodeHopeChapterAward(self, cusId)
    SOCKET_SEND(Protocol.CS_GAIN_CODE_HOPE_CHAPTER_AWARD, { chapter_id = cusId })
end

--- *c2s* 重置某个章节 19144
function onReqCodeHopeReset(self, cusId)
    SOCKET_SEND(Protocol.CS_RESET_CODE_HOPE_CHAPTER, { chapter_id = cusId })
end

--- *c2s* 代号希望战员信息 19146
function onReqCodeHopeHeroInfo(self, cusId)
    SOCKET_SEND(Protocol.CS_CODE_HOPE_HERO_INFO, { chapter_id = cusId })
end

--- *c2s* 代号希望排行榜 19150
function onReqCodeHopeRankInfo(self)
    SOCKET_SEND(Protocol.CS_CODE_HOPE_RANK_INFO)
end




--- *s2c* 返回代号希望副本信息 19141
function onCodeHopeInfoMsg(self, msg)
    self.mMgr:parseCodeHopeInfoMsg(msg)
end

--- *s2c* 返回领取代号希望章节奖励结果 19143
function onCodeHopeChapterAwardMsg(self, msg)
    self.mMgr:parseCodeHopeChapterAwardMsg(msg)
end

--- *s2c* 重置某个章节结果返回 19145
function onCodeHopeResetMsg(self, msg)
    -- self.mMgr:parseCodeHopeResetMsg(msg)
    if msg.result == 1 then
        -- gs.Message.Show2("重置成功")
        gs.Message.Show2(_TT(29128))
    end
end

--- *s2c* 代号希望战员信息返回 19147
function onCodeHopeHeroInfoMsg(self, msg)
    self.mMgr:parseCodeHopeHeroInfoMsg(msg)
end

--- *s2c* 代号希望激活某个buff 19148
function onCodeHopeActiveBuffMsg(self, msg)
    self.mMgr:parseCodeHopeActiveBuffMsg(msg)
end

--- *s2c* 代号希望完成某个章节 19149
function onCodeHopeChapterEndMsg(self, msg)
    self.mMgr:parseCodeHopeChapterEndMsg(msg)
end

--- *s2c* 代号希望排行榜返回 19151
function onCodeHopeRankInfoMsg(self, msg)
    self.mMgr:parseCodeHopeRankInfoMsg(msg)
end


--------------------------逻辑相关------------------------------------
-- 副本总数据更新
function onDupInfoUpdate(self)
    self.mMgr:checkFlag()
end
---------------------------UI相关---------------------------------------
-- 打开希望副本选章页面
function onOpenMainPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE, true) == false then
        return
    end
    dup.DupCodeHopeManager:setFinishFirstNew()
    if self.mMainPanel == nil then
        self.mMainPanel = dup.DupCodeHopeMainPanel.new()
        self.mMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    end
    self.mMainPanel:open(args)
end

-- ui销毁
function onDestroyMainPanelHandler(self)
    self.mMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mMainPanel = nil
end

-- 打开希望副本页面
function onOpenDupPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE, true) == false then
        return
    end
    
    -- if GameManager:checkDialy5Reset() then
    --     return
    -- end

    if self.mDupPanel == nil then
        self.mDupPanel = dup.DupCodeHopeChapterPanel.new()
        self.mDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    end

    self.mDupPanel:open(args)
end

-- ui销毁
function onDestroyDupPanelHandler(self)
    self.mDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    self.mDupPanel = nil
end

-- 打开希望副本重置页面
function onOpenResetView(self, args)
    if self.mResetView == nil then
        self.mResetView = dup.DupCodeHopeResetView.new()
        self.mResetView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupResetHandler, self)
    end
    self.mResetView:open(args)
end

-- ui销毁
function onDestroyDupResetHandler(self)
    self.mResetView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupResetHandler, self)
    self.mResetView = nil
end

-- 打开希望副本buff展示
function onOpenShowBuffView(self, args)
    if self.mshowBuffView == nil then
        self.mshowBuffView = dup.DupCodeHopeShowBuffView.new()
        self.mshowBuffView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupShowBuffHandler, self)
    end
    self.mshowBuffView:open(args)
end

-- ui销毁
function onDestroyDupShowBuffHandler(self)
    self.mshowBuffView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupShowBuffHandler, self)
    self.mshowBuffView = nil
end

-- 打开排行榜界面
function onOpenRankPanel(self, args)
    if self.mRankPanel == nil then
        self.mRankPanel = dup.DupCodeHopeRankHallPanel.new()
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
