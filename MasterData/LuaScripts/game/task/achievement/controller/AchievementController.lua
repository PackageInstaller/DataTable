module("task.AchievementController", Class.impl(Controller))

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

    if (self.mAchievementTip) then
        self.mAchievementTip:destroy()
        self.mAchievementTip = nil
    end
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开成就信息面板
    GameDispatcher:addEventListener(EventName.OPEN_ACHIEVEMENT_PANEL, self.__onOpenAchievementPanelHandler, self)
    -- 打开成就主页面面板
    GameDispatcher:addEventListener(EventName.OPEN_ACHIEVEMENTMAIN_PANEL, self.onOpenAchievementMainPanelHandler, self)
    -- 请求成就信息面板
    GameDispatcher:addEventListener(EventName.REQ_ACHIEVEMENT_PANEL_INFO, self.__onReqAchievementPanelInfoHandler, self)
    -- 请求领取成就奖励
    GameDispatcher:addEventListener(EventName.REQ_REC_ACHIEVEMENT_AWARD, self.__onReqRecAchievementAwardHandler, self)
    -- 请求领取全部奖励
    GameDispatcher:addEventListener(EventName.REQ_REC_ALL_ACHIEVEMENT_AWARD, self.__onReqRecAllAchievementAwardHandler, self)
    -- 请求领取积分奖励
    GameDispatcher:addEventListener(EventName.REQ_REC_ACHIEVEMENT_SCORE_AWARD, self.__onReqRecAchievementScoreAwardHandler, self)

    -- 请求成就tip检查
    GameDispatcher:addEventListener(EventName.CHECK_ACHIEVEMENT_TIP, self.__onUpdateAchievementTipHandler, self)

    GameDispatcher:addEventListener(EventName.FUNC_OPEN_DATA_INIT, self.__onFuncOpenUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_UPDATE, self.__onFuncOpenUpdateHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 成就信息面板 24021
        SC_ACHIEVEMENT_PANEL_INFO = self.__onResAchievementPanelInfoHandler,
        --- *s2c* 返回领取成就奖励 24023
        SC_GAIN_ACHIEVEMENT_AWARD = self.__onResGetAchievementAwardHandler,
        --- *s2c* 更新成就进度 24024
        SC_UPDATE_ACHIEVEMENT_INFO = self.__onResAchievementInfoHandler,
        --- *s2c* 成就奖励一键领取返回 24026
        SC_GAIN_ACHIEVEMENT_ALL = self.__onResGetAllAchievementAwardHandler,
        --- *s2c* 更新已完成成就总数 24027 
        SC_UPDATE_COMPLETE_ACHIEVE_INFO = self.__onResUpdateCompleteInfoHandler,
        --- *s2c* 更新领取积分奖励 24029
        SC_GAIN_ACHIEVEMENT_STAGE_AWARD = self.__onResUpdateScoreAwardHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新成就信息面板
function __onResAchievementPanelInfoHandler(self, msg)
    task.AchievementManager:parseAchievementListMsg(msg)
    self:__onUpdateAchievementTipHandler()
end

-- 更新领取成就奖励
function __onResGetAchievementAwardHandler(self, msg)
    task.AchievementManager:updateAchievementAward(msg)
end

-- 更新成就进度
function __onResAchievementInfoHandler(self, msg)
    task.AchievementManager:updateAchievementListMsg(msg.achievement_info)
    self:__onUpdateAchievementTipHandler()
end

-- 更新领取全部奖励
function __onResGetAllAchievementAwardHandler(self, msg)
    task.AchievementManager:updateAllAchievementAward(msg)
end

-- 更新已完成成就总数
function __onResUpdateCompleteInfoHandler(self, msg)
    task.AchievementManager:parseUpdateCompleteInfoMsg(msg)
end

-- 更新领取积分奖励
function __onResUpdateScoreAwardHandler(self, msg)
    task.AchievementManager:parseUpdateScoreMsg(msg)
end

-- 更新功能开启
function __onFuncOpenUpdateHandler(self, args)
    if (not args or args.funcId == funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT) then
        task.AchievementManager:updateRedFlag()
    end
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求成就列表信息
function __onReqAchievementPanelInfoHandler(self, args)
    --- *c2s* 成就信息面板 24020
    SOCKET_SEND(Protocol.CS_ACHIEVEMENT_PANEL_INFO, {})
end

-- 请求领取成就奖励
function __onReqRecAchievementAwardHandler(self, args)
    --- *c2s* 领取成就奖励 24022
    SOCKET_SEND(Protocol.CS_GAIN_ACHIEVEMENT_AWARD, { achievement_id = args.id, stage = args.step })
end

-- 请求领取全部奖励
function __onReqRecAllAchievementAwardHandler(self, args)
    --- *c2s* 成就奖励一键领取 24025
    SOCKET_SEND(Protocol.CS_GAIN_ACHIEVEMENT_ALL, { type = args.tabType })
end

-- 请求领取积分奖励
function __onReqRecAchievementScoreAwardHandler(self, args)
    --- *c2s* 请求领取积分奖励 24028
    SOCKET_SEND(Protocol.CS_GAIN_ACHIEVEMENT_STAGE_AWARD, { stage_award_id = args.scoreId })
end

---------------------------------------------------------------界面------------------------------------------------------------------
function __onOpenAchievementPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT, true) then
        if not args then
            args = { type = task.AchievementTab.PREVIEW }
        end
        if (not self.mAchievementPanel) then
            self.mAchievementPanel = task.AchievementPanel.new()
            self.mAchievementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAchievementHandler, self)
        end
        self.mAchievementPanel:open(args)
    end
end

function onDestroyAchievementHandler(self)
    self.mAchievementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAchievementHandler, self)
    self.mAchievementPanel = nil
end
--打开主页面成就
function onOpenAchievementMainPanelHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT, true) then
        if (not self.mAchievementMainPanel) then
            self.mAchievementMainPanel = task.AchievementPreviewTabView.new()
            self.mAchievementMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAchievementMainPanelHandler, self)
        end
        self.mAchievementMainPanel:open()
    end
end

function onDestroyAchievementMainPanelHandler(self)
    self.mAchievementMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAchievementHandler, self)
    self.mAchievementMainPanel = nil
end

function __onUpdateAchievementTipHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT) then
        if (not self.mAchievementTip) then
            self.mAchievementTip = task.AchievementTip.new()
        end
        self.mAchievementTip:checkActive()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]