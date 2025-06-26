-- 1.1副本活动
module("mainActivity.ActiveDupController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_ACTIVEDUP_STAGE_PANEL, self.__onOpenStageListPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ACTIVEDUPAWARD_VIEW, self.onOpenStageAwardViewHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ACTIVEDUP_INFO, self.onReqActiveDupInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_ACTIVEDUP_STAGE_AWARD, self.onReqStoryStageAwardListHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ACTIVEDUP_ALL_AWARD, self.onReqAllStageAward, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onCloseActivityHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 保护刁民面板信息 19610
        SC_PROTECT_PEOPLE_PANEL_INFO = self.__onMainMapInfoMsgHandler,
        --- *s2c* 保护刁民领取星级奖励 19604
        SC_PROTECT_PEOPLE_RECEIVE_STAR_AWARD = self.onRecStepAward,
        --- *s2c* 战斗结算界面星星展示 19605
        SC_PROTECT_PEOPLE_BATTLE_STAR = self.onFightEndStar,
        --- *s2c* 保护刁民一键领取星级奖励 19607
        SC_PROTECT_PEOPLE_RECEIVE_STAR_AWARD_ONE_KEY = self.onRecAllAward,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 主线关卡
function __onMainMapInfoMsgHandler(self, msg)
    mainActivity.ActiveDupManager:parseMsg(msg)
    mainActivity.ActiveDupManager.isDataInit = true
end

function onRecStepAward(self, msg)
    if msg.result == 1 then
        mainActivity.ActiveDupManager:addRecAward(msg.receive_id)
        mainActivity.ActiveDupManager:dispatchEvent(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE)
    else
        gs.Message.Show("领取失败！")
    end
end

--战斗结束 更新
function onFightEndStar(self, msg)
    mainActivity.ActiveDupManager:updateStageInfo(msg)
end

function __onStoryChapterPicHandler(self, msg)
    if (msg.result == 1) then
        mainActivity.ActiveDupManager:updateChaterPic(msg)
    end
end

--- 请求已领取主线关卡奖励
function onReqStoryStageAwardListHandler(self, args)
    SOCKET_SEND(Protocol.CS_PROTECT_PEOPLE_RECEIVE_STAR_AWARD, {receive_id = args.id})
end

function onReqAllStageAward(self)
    SOCKET_SEND(Protocol.CS_PROTECT_PEOPLE_RECEIVE_STAR_AWARD_ONE_KEY)
end

function onRecAllAward(self, msg)
    if msg.result == 1 then
        for k, v in pairs(msg.receive_id) do
            mainActivity.ActiveDupManager:addRecAward(v)
        end
        mainActivity.ActiveDupManager:dispatchEvent(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE)
    else
        gs.Message.Show("领取失败")
    end
end

--关闭所有活动界面
function onCloseActivityHandler(self, args)
    for _, id in ipairs(args.closeList) do
        if id == activity.ActivityId.MainActivity then
            self:closeAllView()
        end
    end
end

--添加到活动页面
function addViewToPool(self, cusView)
    table.insert(self.mMgr.mActiveViewList, cusView)
end

--移除活动页面
function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mActiveViewList, cusView)
end

--关闭所有界面
function closeAllView(self)
    for i = 1, #self.mMgr.mActiveViewList do
        self.mMgr.mActiveViewList[i]:close()
    end
end
------------------------------------------------------------------------ 战斗地图大厅面板 ------------------------------------------------------------------------
-- 打开主线关卡城池列表面板
function __onOpenStageListPanelHandler(self, args)
    if args == nil then
        args = mainActivity.ActiveDupStyleType.Easy
    end
    mainActivity.ActiveDupManager:setStyle(args)
    if self.m_stageListPanel == nil then
        self.m_stageListPanel = mainActivity.ActiveDupStageListPanel.new()
        self.m_stageListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
        self:addViewToPool(self.m_stageListPanel)
    end
    self.m_stageListPanel:open(args)
end

-- ui销毁
function __onDestroyStageListPanelHandler(self)
    self:removeViewToPool(self.m_stageListPanel)
    self.m_stageListPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyStageListPanelHandler, self)
    self.m_stageListPanel = nil
end

------------------------------------------------------------------------ 主线关卡阶段性奖励弹窗 ------------------------------------------------------------------------
-- 打开主线关卡城池信息面板
function onOpenStageAwardViewHandler(self)
    if self.mStageAwardPanel == nil then
        self.mStageAwardPanel = mainActivity.ActiveDupStageAwardPanel.new()
        self.mStageAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStageAwardViewHandler, self)
        self:addViewToPool(self.mStageAwardPanel)
    end
    self.mStageAwardPanel:open()
end

-- ui销毁
function onDestroyStageAwardViewHandler(self)
    if self.mStageAwardPanel ~= nil then
        self:removeViewToPool(self.mStageAwardPanel)
        self.mStageAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStageAwardViewHandler, self)
        self.mStageAwardPanel = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
