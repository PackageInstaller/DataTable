
module("doundless.DisasterController", Class.impl(Controller))

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
    
    GameDispatcher:addEventListener(EventName.CAN_OPEN_DISASTER_PANEL,self.onCanOpenDisasterPanel,self)
    GameDispatcher:addEventListener(EventName.REQ_CHALLENGE_DISASTER,self.onReqChallengeDisaster,self)
    GameDispatcher:addEventListener(EventName.REQ_ABANDON_DISASTER,self.onReqAbandonDisaster,self)
    GameDispatcher:addEventListener(EventName.REQ_GAIN_DAMAGE_REWARD,self.onReqDamageReward,self)
    GameDispatcher:addEventListener(EventName.REQ_DISASTER_RANK_PANEL,self.onReqDisasterRank,self)
    
    
    GameDispatcher:addEventListener(EventName.OPEN_DISASTER_MAIN_PANEL,self.onOpenDisasterMainPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_DISASTER_FIGHT_AWARD_PANEL,self.onOpenDisasterAwardPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_DISASTER_RANK_PANEL,self.onOpenDisasterRankPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_DISASTER_BOSS_PANEL,self.onOpenDisasterBossPanel,self)
    
    GameDispatcher:addEventListener(EventName.OPEN_DISASTER_RESULT_PANEL,self.onOpenDisasterResultPanel,self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onCloseAllViewHandler, self)
end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_DISASTER_PANEL = self.onDisasterPanelHandler,
        SC_CHALLENGE_DISASTER = self.onChallengeDisasterHandler,
        SC_ABANDON_DISASTER = self.onAbandonDisaterHandler,
        SC_GAIN_DAMAGE_REWARD = self.onGainDamageRewardHandler,
        SC_DISASTER_RANK_PANEL = self.onDisasterRankHandler,
    }
end

function onDisasterPanelHandler(self,args)
    disaster.DisasterManager:onDisasterPanelInfo(args)
end

function onChallengeDisasterHandler(self,args)
    if args.result == 1 then
        self:openFormationPanel()
    else
        gs.Message.Show("挑战失败")
    end
end

function onAbandonDisaterHandler(self,args)
    if args.result == 1 then
        GameDispatcher:dispatchEvent(EventName.CAN_OPEN_DISASTER_PANEL)
    else
        gs.Message.Show("失败")
    end
end

function onGainDamageRewardHandler(self,args)
    if args.result == 1 then
        disaster.DisasterManager:updateReward(args.reward_id)
        --GameDispatcher:dispatchEvent(EventName.CAN_OPEN_DISASTER_PANEL)
    else
        gs.Message.Show("领取失败")
    end
end

function onDisasterRankHandler(self,args)
    disaster.DisasterManager:updateDisasterRankInfo(args)
end


function onReqChallengeDisaster(self,args)
    SOCKET_SEND(Protocol.CS_CHALLENGE_DISASTER,{difficulty = args.dif})
end

function onReqAbandonDisaster(self,args)
    SOCKET_SEND(Protocol.CS_ABANDON_DISASTER)
end

function onReqDamageReward(self,args)
    SOCKET_SEND(Protocol.CS_GAIN_DAMAGE_REWARD,{reward_id = args.id})
end

function onReqDisasterRank(self,args)
    SOCKET_SEND(Protocol.CS_DISASTER_RANK_PANEL)
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.mViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mViewList, cusView)
end

function onCloseAllViewHandler(self,args)
    for _, id in ipairs(args.closeList) do
        if id == activity.ActivityId.Disaster then
            self:closeAllView()
        end
    end
end

--关闭所有界面
function closeAllView(self)
    for i = 1, #self.mMgr.mViewList do
        self.mMgr.mViewList[i]:close()
    end
end

function onCanOpenDisasterPanel(self,args)

    if disaster.DisasterManager:getDisasterIsOpen() == false then
        gs.Message.Show("活动已关闭")
        return
    end
    
    -- if disaster.DisasterManager:getDisasterPanelType() == 1 then
    GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_MAIN_PANEL)
    -- else
    --     self:openFormationPanel()
    -- end
end

function openFormationPanel(self)
        local curDif = disaster.DisasterManager:getCurChallengingDif()
        local dupVo = disaster.DisasterManager:getDisasterDupDataByDif(curDif)

        formation.checkFormationFight(PreFightBattleType.Disaster, DupType.Disaster, dupVo.dupId,
            formation.TYPE.DISASTER , nil, nil, nil)
end

function onOpenDisasterMainPanel(self,args)
    if self.mDisasterMainPanel == nil then
        self.mDisasterMainPanel = disaster.DisasterMainPanel.new()
        self.mDisasterMainPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterMainHandler,self)
        self:addViewToPool(self.mDisasterMainPanel)
    end
    self.mDisasterMainPanel:open(args)
end

function onDestoryDisasterMainHandler(self)
    self:removeViewToPool(self.mDisasterMainPanel)
    self.mDisasterMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterMainHandler,self)
    self.mDisasterMainPanel = nil
end

function onOpenDisasterAwardPanel(self,args)
    if self.mDisasterAwardPanel == nil then
        self.mDisasterAwardPanel = disaster.DisasterFightAwardPanel.new()
        self.mDisasterAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterAwardHandler,self)
        self:addViewToPool(self.mDisasterAwardPanel)
    end
    self.mDisasterAwardPanel:open(args)
end

function onDestoryDisasterAwardHandler(self)
    self:removeViewToPool(self.mDisasterAwardPanel)
    self.mDisasterAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterAwardHandler,self)
    self.mDisasterAwardPanel = nil
end


function onOpenDisasterRankPanel(self,args)
    if self.mDisasterRankPanel == nil then
        self.mDisasterRankPanel = disaster.DisasterRankPanel.new()
        self.mDisasterRankPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterRankHandler,self)
        self:addViewToPool(self.mDisasterRankPanel)
    end
    self.mDisasterRankPanel:open(args)
end

function onDestoryDisasterRankHandler(self)
    self:removeViewToPool(self.mDisasterRankPanel)
    self.mDisasterRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterRankHandler,self)
    self.mDisasterRankPanel = nil
end

function onOpenDisasterBossPanel(self,args)
    if self.mDisasterBossPanel == nil then
        self.mDisasterBossPanel = disaster.DisasterBossPanel.new()
        self.mDisasterBossPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterBossHandler,self)
        self:addViewToPool(self.mDisasterBossPanel)
    end
    self.mDisasterBossPanel:open(args)
end

function onDestoryDisasterBossHandler(self)
    self:removeViewToPool(self.mDisasterBossPanel)
    self.mDisasterBossPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterBossHandler,self)
    self.mDisasterBossPanel = nil
end

function onOpenDisasterResultPanel(self,args)
    if self.mDisasterResultPanel == nil then
        self.mDisasterResultPanel = disaster.DisasterResultPanel.new()
        self.mDisasterResultPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterResultHandler,self)
        --self:addViewToPool(self.mDisasterResultPanel)
    end
    self.mDisasterResultPanel:open(args)
end

function onDestoryDisasterResultHandler(self)
    --self:removeViewToPool(self.mDisasterResultPanel)
    self.mDisasterResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDisasterResultHandler,self)
    self.mDisasterResultPanel = nil
end



return _M