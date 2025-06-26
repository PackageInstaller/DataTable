--[[ 
-----------------------------------------------------
@filename       : InfiniteCityController
@Description    : 无限城活动控制器
@date           : 2021-03-01 11:21:25
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.controller.InfiniteCityController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_MAIN_PANEL, self.onOpenMainPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_DUP_PANEL, self.onOpenDupPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_PREP_PANEL, self.onOpenPrepPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_SUPPLY_SELECT_PANEL, self.onOpenSupplyView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_INFINITE_CITY_SUPPLY_SELECT_PANEL, self.onCloseSupplyView, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_DISASTER_DETAIL_VIEW, self.onOpenDisasterDetailView, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_TROPHY_SHOW_PANEL, self.onOpenTrophyShowView, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_TROPHY_SELECT_VIEW, self.onOpenTrophySelectView, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_RANK_PANEL, self.onOpenRankPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_AWARD_PANEL, self.onOpenActivityPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_SHOP_PANEL, self.onOpenShopPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_INFINITE_CITY_INFO, self.onReqInfiniteCityInfoHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_INFINITE_CITY_PREP, self.onReqInfiniteCityPrepHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_INFINITE_CITY_RESET, self.onReqInfiniteCityResetHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_INFINITE_CITY_SELECT_TROPHY, self.onReqInfiniteCitySelectSupplyHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_INFINITE_GET_TARGET, self.onReqInfiniteCityGetTargetHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_INFINITE_CITY_RANK, self.onReqInfiniteCityRankHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_INFINITE_SUPPLY_DATA, self.onReqInfiniteCityDefaultSupplyHandler, self)

    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onCloseActivityHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_INFINITE_CITY_PANEL_INFO = self.onInfiniteCityInfoMsg,
        SC_INFINITE_CITY_CHALLENGE_CONFIRM = self.onInfiniteCityChallengeConfirmMsg,
        SC_INFINITE_CITY_RESET = self.onInfiniteCityResetMsg,
        SC_INFINITE_CITY_PASS_CITY = self.onInfiniteCityTrophySelectMsg,
        -- SC_INFINITE_CITY_RANK = self.onInfiniteCityRankMsg,
        SC_INFINITE_ACTIVE_SPECIAL_CITY = self.onInfiniteCitySpecialOpenMsg,
        SC_INFINITE_CITY_TARGET = self.onInfiniteCityTargetInfoMsg,
        SC_UPDATE_INFINITE_CITY_TARGET = self.onInfiniteCityTargetUpdateMsg,
        SC_GAIN_INFINITE_TARGET = self.onInfiniteCityTargetGainMsg,
        SC_INFINITE_CITY_ROUND_END = self.onInfiniteCityRoundEndMsg,
        SC_INFINITE_CITY_DEFAULT_SUPPLY = self.onInfiniteCityDefaultSupplyMsg,
    }
end

---------------------------消息交互------------------------------------------
--- *c2s* 请求无限城面板 19100
function onReqInfiniteCityInfoHandler(self)
    SOCKET_SEND(Protocol.CS_INFINITE_CITY_PANEL_INFO)
end

--- *c2s* 无限城挑战的前置准备 19102
function onReqInfiniteCityPrepHandler(self, args)
    local cmd = {}
    cmd.city_id = args.cityId
    cmd.hard_level = self.mMgr.hardLevel
    cmd.disaster_list = self.mMgr.selectDisasterList
    cmd.battle_supply_list = self.mMgr.selectSupplyList
    SOCKET_SEND(Protocol.CS_INFINITE_CITY_BEFORE_CHALLENGE, cmd)
end

--- *c2s* 无限城战斗结束选择战利品 19105
function onReqInfiniteCitySelectSupplyHandler(self, args)
    local cmd = {}
    cmd.city_id = args.cityId
    cmd.select_battle_buff = args.trophyId
    SOCKET_SEND(Protocol.CS_INFINITE_CITY_END_CHALLENGE, cmd)
    self:onCloseTrophySelectViewHandler()
end

--- *c2s* 重置无限城 19106
function onReqInfiniteCityResetHandler(self)
    SOCKET_SEND(Protocol.CS_INFINITE_CITY_RESET)
end

--- *c2s* 请求无限城排行版 19108
function onReqInfiniteCityRankHandler(self)
    SOCKET_SEND(Protocol.CS_INFINITE_CITY_RANK)
end

--- *c2s* 领取奖励 19113
function onReqInfiniteCityGetTargetHandler(self, args)
    SOCKET_SEND(Protocol.CS_GAIN_INFINITE_TARGET, { id = args.id })
end

--- *c2s* 无限城已选进入战斗的补给 19116
function onReqInfiniteCityDefaultSupplyHandler(self, args)
    SOCKET_SEND(Protocol.CS_INFINITE_CITY_DEFAULT_SUPPLY)
end




--- *s2c* 返回无限城面板 19101
function onInfiniteCityInfoMsg(self, msg)
    self.mMgr:parseInfiniteCityInfoMsg(msg)
end

--- *s2c* 无限城挑战准备结果返回 19103
function onInfiniteCityChallengeConfirmMsg(self, msg)
    if msg.result == 1 then
        formation.checkFormationFight(PreFightBattleType.InfiniteCity, nil, msg.city_id, nil, nil, nil)
    end
end

--- *s2c* 通关之后可选择战利品 19104
function onInfiniteCityTrophySelectMsg(self, msg)
    self.mMgr:parseInfiniteCityTrophySelectMsg(msg)
end

--- *s2c* 重置返回 19107
function onInfiniteCityResetMsg(self, msg)
    if msg.result == 1 then
        -- gs.Message.Show("重置成功")
        gs.Message.Show(_TT(27134))
    end
end

--- *s2c* 返回无限城排行版 19109
function onInfiniteCityRankMsg(self, msg)
    self.mMgr:parseInfiniteCityRankMsg(msg)
end

--- *s2c* 无限城解锁隐藏关卡 19110
function onInfiniteCitySpecialOpenMsg(self, msg)
    self.mMgr:parseInfiniteCitySpecialOpenMsg(msg)
end

--- *s2c* 无限城活动目标面板 19111
function onInfiniteCityTargetInfoMsg(self, msg)
    self.mMgr:parseInfiniteCityTargetInfoMsg(msg)
end

--- *s2c* 无限城活动目标更新进度 19112
function onInfiniteCityTargetUpdateMsg(self, msg)
    self.mMgr:parseInfiniteCityTargetUpdateMsg(msg)
end

--- *s2c* 领取奖励返回 19114
function onInfiniteCityTargetGainMsg(self, msg)
    ShowAwardPanel:showPropsAwardMsg(msg.award)
end

--- *s2c* 无限城轮次结束 19115
function onInfiniteCityRoundEndMsg(self, msg)
    self.mMgr:parseInfiniteCityRoundEndMsg(msg)
end

--- *s2c* 无限城已选进入战斗的补给 19117
function onInfiniteCityDefaultSupplyMsg(self, msg)
    self.mMgr:parseInfiniteCityDefaultSupplyMsg(msg)
end

-------------------------逻辑相关------------------------------------
-- 展示战利品选择
function onShowSelectTrophy(self, callBack)
    self.mSelectTrophyCallBack = callBack
    if self.mMgr.trophySelectData and #self.mMgr.trophySelectData.battle_buff_list > 0 then
        self:onOpenTrophySelectView(self.mMgr.trophySelectData)
        self.mMgr.trophySelectData = nil
    else
        if self.mSelectTrophyCallBack then
            self.mSelectTrophyCallBack()
            self.mSelectTrophyCallBack = nil
        end
    end
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.activityViewList, cusView)
end
function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.activityViewList, cusView)
end

-- 关闭限时活动通知
function onCloseActivityHandler(self, args)
    for i, v in ipairs(args.closeList) do
        local vo = activity.ActivityManager:getCloseActivity(v)
        if vo and vo.funcId == funcopen.FuncOpenConst.FUNC_ID_INFINITE_CITY then
            -- 活动关闭了
            self:closeAllActivityView()
            break
        end
    end
end
function closeAllActivityView(self, args)
    for i, v in ipairs(self.mMgr.activityViewList) do
        if v then
            v:close()
        end
    end
end
---------------------------UI相关---------------------------------------
-- 打开主界面
function onOpenMainPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mMainPanel == nil then
        self.mMainPanel = UI.new(infiniteCity.InfiniteCityMainPanel)
        self.mMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
        self:addViewToPool(self.mMainPanel)
    end
    self.mMainPanel:open(args)
end
-- ui销毁
function onDestroyMainPanelHandler(self)
    self:removeViewToPool(self.mMainPanel)
    self.mMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mMainPanel = nil
end

-- 打开副本界面
function onOpenDupPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mDupPanel == nil then
        self.mDupPanel = UI.new(infiniteCity.InfiniteCityDupPanel)
        self.mDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
        self:addViewToPool(self.mDupPanel)
    end
    self.mDupPanel:open(args)
end
-- ui销毁
function onDestroyDupPanelHandler(self)
    self:removeViewToPool(self.mDupPanel)
    self.mDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    self.mDupPanel = nil
end

-- 打开备战界面
function onOpenPrepPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mPrepPanel == nil then
        self.mPrepPanel = UI.new(infiniteCity.InfiniteCityPrepPanel)
        self.mPrepPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPrepPanelHandler, self)
        self:addViewToPool(self.mPrepPanel)
    end
    self.mPrepPanel:open(args)
end
-- ui销毁
function onDestroyPrepPanelHandler(self)
    self:removeViewToPool(self.mPrepPanel)
    self.mPrepPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPrepPanelHandler, self)
    self.mPrepPanel = nil
end


-- 打开补给选择界面
function onOpenSupplyView(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mSupplyView == nil then
        self.mSupplyView = UI.new(infiniteCity.InfiniteCitySupplyView)
        self.mSupplyView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySupplyViewHandler, self)
        self:addViewToPool(self.mSupplyView)
    end
    self.mSupplyView:open(args)
end
-- 外部关闭UI
function onCloseSupplyView(self)
    if self.mSupplyView then
        self.mSupplyView:close()
    end
end
-- ui销毁
function onDestroySupplyViewHandler(self)
    self:removeViewToPool(self.mSupplyView)
    self.mSupplyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySupplyViewHandler, self)
    self.mSupplyView = nil
end


-- 打开灾害详情界面
function onOpenDisasterDetailView(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mDisasterDetailView == nil then
        self.mDisasterDetailView = UI.new(infiniteCity.InfiniteCityDisasterDetailView)
        self.mDisasterDetailView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDisasterDetailViewHandler, self)
        self:addViewToPool(self.mDisasterDetailView)
    end
    self.mDisasterDetailView:open(args)
end
-- ui销毁
function onDestroyDisasterDetailViewHandler(self)
    self:removeViewToPool(self.mDisasterDetailView)
    self.mDisasterDetailView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDisasterDetailViewHandler, self)
    self.mDisasterDetailView = nil
end

-- 打开拥有战利品展示界面
function onOpenTrophyShowView(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mTrophyShowView == nil then
        self.mTrophyShowView = UI.new(infiniteCity.InfiniteCityTrophyShowView)
        self.mTrophyShowView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTrophyShowViewHandler, self)
        self:addViewToPool(self.mTrophyShowView)
    end
    self.mTrophyShowView:open(args)
end
-- ui销毁
function onDestroyTrophyShowViewHandler(self)
    self:removeViewToPool(self.mTrophyShowView)
    self.mTrophyShowView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTrophyShowViewHandler, self)
    self.mTrophyShowView = nil
end

-- 打开通关战利品选择界面
function onOpenTrophySelectView(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mTrophySelectView == nil then
        self.mTrophySelectView = UI.new(infiniteCity.InfiniteCityTrophySelectView)
        self.mTrophySelectView:addEventListener(View.EVENT_CLOSE, self.onCloseTrophySelectViewCall, self)
        self.mTrophySelectView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTrophySelectViewHandler, self)
        self:addViewToPool(self.mTrophySelectView)
    end
    self.mTrophySelectView:open(args)
end
function onCloseTrophySelectViewHandler(self)
    if self.mTrophySelectView then
        self.mTrophySelectView:close()
    end
end
-- 关闭回调
function onCloseTrophySelectViewCall(self)
    if self.mSelectTrophyCallBack then
        self.mSelectTrophyCallBack()
        self.mSelectTrophyCallBack = nil
    end
end
-- ui销毁
function onDestroyTrophySelectViewHandler(self)
    self:removeViewToPool(self.mTrophySelectView)
    self.mTrophySelectView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTrophySelectViewHandler, self)
    self.mTrophySelectView = nil
end

-- 打开无限榜界面
function onOpenRankPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mRankPanel == nil then
        self.mRankPanel = UI.new(infiniteCity.InfiniteCityRankPanel)
        self.mRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankPanelHandler, self)
        self:addViewToPool(self.mRankPanel)
    end
    self.mRankPanel:open(args)
end
-- ui销毁
function onDestroyRankPanelHandler(self)
    self:removeViewToPool(self.mRankPanel)
    self.mRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankPanelHandler, self)
    self.mRankPanel = nil
end

-- 打开活动奖励面板
function onOpenActivityPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mActivityPanel == nil then
        self.mActivityPanel = UI.new(infiniteCity.ActivityTargetPanel)
        self.mActivityPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPanelHandler, self)
        self:addViewToPool(self.mActivityPanel)
    end
    self.mActivityPanel:open(args)
end
-- ui销毁
function onDestroyActivityPanelHandler(self)
    self:removeViewToPool(self.mActivityPanel)
    self.mActivityPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPanelHandler, self)
    self.mActivityPanel = nil
end

-- 打开夜市面板
function onOpenShopPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mShopPanel == nil then
        self.mShopPanel = UI.new(infiniteCity.InfiniteCityShopPanel)
        self.mShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
        self:addViewToPool(self.mShopPanel)
    end
    self.mShopPanel:open(args)
end
-- ui销毁
function onDestroyShopPanelHandler(self)
    self:removeViewToPool(self.mShopPanel)
    self.mShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
    self.mShopPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
