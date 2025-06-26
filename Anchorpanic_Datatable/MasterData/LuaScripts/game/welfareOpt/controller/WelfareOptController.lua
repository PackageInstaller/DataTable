module("welfareOpt.WelfareOptController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数 
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    if next(self.mMgr) then
        for _, mgr in pairs(self.mMgr) do
            if mgr and mgr.resetData then
                mgr:resetData()
            end
        end
    end
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_WELFAREOPT_PANEL, self.onOpenWelfareOptHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_WELFAREOPT_FIGHTSUPPLYPRO_PANEL, self.onOpenWelfareOptFightSupplyProHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_WELFARE_FIGHTSUPPLY, self.onReqWelfareOptFightSupply, self)

    GameDispatcher:addEventListener(EventName.REQ_START_GOLD_WISH, self.onReqWelfareStartGoldWishHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_GAIN_GOLD_WISH, self.onReqWelfareGainGoldWishHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_GAIN_SEVEN_DAY_REWARD, self.onReqWelfareSevenDayRewardHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_GAIN_STRANGTH_REWARD, self.onReqWelfareStrengthSupplyRewardHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_WELFAREOPT_FLAG, self.onUpdateWelfareOptFlagHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_TRAINER_PANEL, self.onReqWelfareNoviceTrainHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_TRAINER_REWARD, self.onReqWelfareNoviceRewardHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_TRAINER_STAGE_REWARD, self.onReqWelfareNoviceStageRewardHandler, self)
    
    GameDispatcher:addEventListener(EventName.REQ_TAPTAP_TASK,self.onReqTapTapTaskHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_TAPTAP_TASK_GRAND,self.onReqTapTapGrandHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_FESTIVAL_REWARD,self.onReqWelfareRewardHandler,self)

    
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__onChangePlayerGold, self)
    --GameDispatcher:addEventListener(role.RoleVo.CHANGE_PLAYER_GOLD_COIN,self.__onChangePlayerGold,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 战斗补给抽奖返回 24055
        SC_BATTLE_SUPPLY_DRAW = self.__onWelfareOptFightSupplyHandler,
        --- *s2c* 金币祈愿面板信息 24060
        SC_GOLD_WISH_PANEL_INFO = self.__onWelfareOptGoldWishHandler,
        --- *s2c* 已领取奖励天数 24066
        SC_SEVEN_DAY_PANEL_INFO = self.__onWelfareOptSevenDayHandler,
        --- *c2s* 每日体力补给面板 24074
        SC_DAILY_STAMINA_PANEL = self.__onWelfareOptStrengthSupplyHandler,
        --- *s2c* 获取每日体力补给返回 24077
        SC_DAILY_STAMINA_REWARD = self.__onWelfareOptStrangthSupplyRewardHandler,
        --- *s2c* 道具更新 17001
        SC_BAG_UPDATE = self.__onUpdateProps,
        --- *s2c* 返回新手训练营面板 24112
        SC_NOVICE_TRAINING_PANEL = self.onWelfareOptTrainerPanel,
        --- *s2c* 领取新手训练营任务奖励结果 24114
        SC_NOVICE_TRAINING_RECEIVE_TASK = self.onWelfareOptTrainerReward,
        --- *s2c* 领取新手训练营阶段奖励结果 24116
        SC_NOVICE_TRAINING_RECEIVE_STEP = self.onWelfareOptTrainerStageReward,
        --- *s2c* 更新新手训练营任务进度 24117
        SC_UPDATE_NOVICE_TRAINING_TASK = self.onWelfareOptTrainerUpdate,

        --- *s2c* 开服活动面板信息 24271
        SC_OPEN_SERVER_SIGN_PANEL_INFO = self.onOpenBetaWelfareReceive,
        
        --- *s2c* 联动活动面板 24310
        SC_LINKAGE_PANEL = self.onTapTapTaskHandler,
        --- *s2c* 联动活动任务奖励领取 24312
        SC_LINKAGE_TASK_RECEIVE = self.onReceiveTapTapTaskHandler,
        --- *s2c* 联动活动任务领取最终奖励 24314
        SC_LINKAGE_RECEIVE_GRAND_PRIZE = self.onReceiveTapTapGrandHandler,

        --- *s2c* 更新活动任务的任务进度 24315
        SC_LINKAGE_TASK_UPDATE = self.onTapTapTaskUpdateHandler,

        --- *s2c* 面板信息 24258
        SC_FESTIVAL_ACTIVITY_SIGN_PANEL_INFO = self.onSignInfo,

    }
end

------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------

--- *c2s* 战斗补给抽奖 24054
function onReqWelfareOptFightSupply(self, msg)
    SOCKET_SEND(Protocol.CS_BATTLE_SUPPLY_DRAW, { type = msg.type, times = msg.times })
end

--- *c2s* 开启金币祈愿 24061
function onReqWelfareStartGoldWishHandler(self)
    SOCKET_SEND(Protocol.CS_START_GOLD_WISH)
end

--- *c2s* 领取金币祈愿奖励 24062
function onReqWelfareGainGoldWishHandler(self)
    SOCKET_SEND(Protocol.CS_GAIN_GOLD_WISH_AWARD)
end

--- *c2s* 领取七天奖励 24065
function onReqWelfareSevenDayRewardHandler(self, msg)
    SOCKET_SEND(Protocol.CS_GAIN_SEVEN_DAY_REWARD, { day = msg.day })
end

--- *c2s* 获取每日体力补给 24076
function onReqWelfareStrengthSupplyRewardHandler(self, idx)
    SOCKET_SEND(Protocol.CS_DAILY_STAMINA_REWARD, { id = idx })
end

--- *c2s* 请求新手训练营面板 24111
function onReqWelfareNoviceTrainHandler(self)
    SOCKET_SEND(Protocol.CS_NOVICE_TRAINING_PANEL)
end

--- *c2s* 请求领取新手训练营任务奖励 24113
function onReqWelfareNoviceRewardHandler(self, msg)
    SOCKET_SEND(Protocol.CS_NOVICE_TRAINING_RECEIVE_TASK, { task_id_list = msg })
end

--- *c2s* 请求领取新手训练营阶段奖励 24115
function onReqWelfareNoviceStageRewardHandler(self)
    SOCKET_SEND(Protocol.CS_NOVICE_TRAINING_RECEIVE_STEP)
end

function onReqTapTapTaskHandler(self,msg)
    SOCKET_SEND(Protocol.CS_LINKAGE_TASK_RECEIVE,{task_id_list = msg})
end

--- *c2s* 领取活动奖励 24257
function onReqWelfareRewardHandler(self,msg)
    SOCKET_SEND(Protocol.CS_GAIN_FESTIVAL_ACTIVITY_SIGN_REWARD, { day = msg.day })
end

function onReqTapTapGrandHandler(self)
    SOCKET_SEND(Protocol.CS_LINKAGE_RECEIVE_GRAND_PRIZE)
end

------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------
--战斗补给抽奖返回
function __onWelfareOptFightSupplyHandler(self, msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFARE_FIGHTSUPPLY)
end

--获取到金币祈愿相关数据
function __onWelfareOptGoldWishHandler(self, msg)
    welfareOpt.WelfareOptManager:parseGoldWishingServerData(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFARE_GOLD_WISH)
end

function __onWelfareOptSevenDayHandler(self, msg)
    welfareOpt.WelfareOptManager:parseSevenLoadingServerData(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEVEN_DAY_PANEL)
end

function __onWelfareOptStrengthSupplyHandler(self, msg)
    welfareOpt.WelfareOptManager:parseStrengthSupplyServerData(msg)
end

function __onWelfareOptStrangthSupplyRewardHandler(self, msg)
    welfareOpt.WelfareOptManager:retReward(msg)
end

--签到信息
function __onSignininfoPanelHandler(self, msg)
    welfareOpt.WelfareOptManager:parseSignInfoMsg(msg)
end

function onSigninHandler(self, msg)
    if (msg.result == 1) then
        ShowAwardPanel:showPropsAwardMsg(msg.award)
    else
        gs.Message.Show("签到失败")
    end
end

function onWelfareOptTrainerPanel(self, msg)
    welfareOpt.WelfareOptManager:parseTrainerServerData(msg)

end

function onWelfareOptTrainerReward(self, msg)
    welfareOpt.WelfareOptManager:parseTrainerRewardServerData(msg)
end

function onWelfareOptTrainerStageReward(self, msg)
    welfareOpt.WelfareOptManager:parseTrainerStageRewardServerData(msg)
end

function onWelfareOptTrainerUpdate(self, msg)
    welfareOpt.WelfareOptManager:parseTaskInfo(msg)
end

--- *s2c* 开服活动面板信息 24271
function onOpenBetaWelfareReceive(self, msg)
    if msg ~= nil and next(msg) ~= nil then
        welfareOpt.WelfareOptOpenBetaManager:parseMsgData(msg)
    else
        logInfo("后端发空协议")
    end
end


function onTapTapTaskHandler(self,msg)
    welfareOpt.WelfareOptManager:parseTapTapTaskServerInfo(msg)
end

--- *s2c* 面板信息 24258
function onSignInfo(self,msg)
    welfareOpt.WelfareOptManager:parseFestivalSignInfoMsg(msg)
end



function onReceiveTapTapTaskHandler(self,msg)
    if msg.result == 1 then
        welfareOpt.WelfareOptManager:updateTapTaskServerInfo(msg)
    end
end

function onReceiveTapTapGrandHandler(self,msg)
    if msg.result == 1 then
        welfareOpt.WelfareOptManager:updateTapTaskServerGrandInfo(msg)
    end
end

function onTapTapTaskUpdateHandler(self,msg)
    welfareOpt.WelfareOptManager:updateTapTapTaskInfo(msg)
end
------------------------------------------------------------------------ 界面 ------------------------------------------------------------------------

----------------------------福利相关界面----------------------------
function onOpenWelfareOptHandler(self, args)
    if not args then
        args = {}
    end
    local curPage = 1
    for i, vo in pairs(welfareOpt.WelfareOptConst:getTabList()) do
        curPage = vo.page
        break
    end
    if not args.type then
        args.type = curPage
    end
    if args.type == welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET and activityTarget.ActivityTargetManager:getIsFinish() then
        gs.Message.Show("活动已结束")
        return
    end

    if self.mWelfareOptPanel == nil then
        self.mWelfareOptPanel = UI.new(welfareOpt.WelfareOptPanel)
        self.mWelfareOptPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWelfareOpt, self)
    end
    self.mWelfareOptPanel:open(args)
end

function onDestroyWelfareOpt(self)
    self.mWelfareOptPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWelfareOpt, self)
    self.mWelfareOptPanel = nil
end

----------------------------战斗补给概率界面----------------------------
function onOpenWelfareOptFightSupplyProHandler(self, args)
    if self.mWelfareOptFightSupplyProView == nil then
        self.mWelfareOptFightSupplyProView = UI.new(welfareOpt.WelfareOptFightSupplyProView)
        self.mWelfareOptFightSupplyProView:addEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyWelfareOptFightSupplyProView,
        self
        )
    end
    self.mWelfareOptFightSupplyProView:open(args)
end

function onDestroyWelfareOptFightSupplyProView(self)
    self.mWelfareOptFightSupplyProView:removeEventListener(
    View.EVENT_VIEW_DESTROY,
    self.onDestroyWelfareOptFightSupplyProView,
    self
    )
    self.mWelfareOptFightSupplyProView = nil
end


function onUpdateWelfareOptFlagHandler(self, args)
    if args == nil then
        args = {}
        args.tabType = 1
    end
    local tabType = args.tabType
    local isFlag = false

    if (self.mWelfareOptPanel) then
        self.mWelfareOptPanel:updateTabRed(tabType)
    end
    isFlag = welfareOpt.WelfareOptManager:getRedAll()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_HOME_WELFARE, isFlag)
end

function __onUpdateProps(self)
    self:__onUpdatePlayerHeroDisHandler()
end

function __onUpdatePlayerHeroDisHandler(self)
    self:onUpdateWelfareOptFlagHandler({ tabType = welfareOpt.WelfareOptConst.WELFAREOPT_FIGHTSUPPLY })
end

function __onChangePlayerGold(self, moneyTid)
    if moneyTid == MoneyTid.GOLD_COIN_TID then
        self:onUpdateWelfareOptFlagHandler({ tabType = welfareOpt.WelfareOptConst.WELFAREOPT_GOLDWISHING })
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]