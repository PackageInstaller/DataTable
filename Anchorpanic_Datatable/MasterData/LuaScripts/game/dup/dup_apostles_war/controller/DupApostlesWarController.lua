--[[ 
-----------------------------------------------------
@filename       : DupApostlesWarController
@Description    : ***
@date           : ***
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.controller.DupApostlesWarController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_DUP_APOSTLES_MAIN_PANEL, self.onOpenMainPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_APOSTLES_WAR_PANEL, self.onOpenWarPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_APOSTLES_REWARD_PANEL, self.onOpenRewardPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_DUP_APOSTLES_WAR_GOAL_PANEL, self.onOpenGoalPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_DUP_APOSTLES_BOSS_INFO_VIEW, self.onOpenBossInfoView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DUP_APOSTLES_BOSS_INFO_VIEW, self.onCloseBossInfoView, self)
    GameDispatcher:addEventListener(EventName.REQ_DUP_APOSTLES2_PANEL_INFO, self.onReqApostles2PanelInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_DUP_APOSTLES2_START_REWARD, self.onReqApostles2StarReward, self)
    GameDispatcher:addEventListener(EventName.REQ_DUP_APOSTLES2_TRAIN, self.onReqApostles2Train, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_APOSTLES2_PANEL_INFO = self.onApostlesPanelInfoHandler,
        SC_RECEIVE_STAR_AWARD = self.onApostlesStartRewardHandler,
        SC_INTO_TRAINING_MODE = self.onApostlesTrainMsg,
    }
end

---------------------------消息交互------------------------------------------
--- *c2s* 请求使徒之战2面板信息 19420
function onReqApostles2PanelInfo(self)
    SOCKET_SEND(Protocol.CS_APOSTLES2_PANEL_INFO)
end
--- *c2s* 领取星星奖励 19422
function onReqApostles2StarReward(self, cusId)
    SOCKET_SEND(Protocol.CS_RECEIVE_STAR_AWARD, { receive_id = cusId })
end

--- *c2s* 请求进入训练模式 19424
function onReqApostles2Train(self, args)
    SOCKET_SEND(Protocol.CS_INTO_TRAINING_MODE, { boss_id = args.bossId, dup_id = args.dupId })
end

-- *s2c* 返回使徒之战2面板信息 19421
function onApostlesPanelInfoHandler(self, msg)
    self.mMgr:onApostlesPanelInfoMsg(msg)
end

--- *s2c* 领取星星奖励结果 19423
function onApostlesStartRewardHandler(self, msg)
    self.mMgr:onApostlesStarRewardMsg(msg)
end

--- *s2c* 使徒之战训练模式返回 19425
function onApostlesTrainMsg(self, msg)
    -- self.mMgr:parseApostlesRankInfoMsg(msg)
    if(msg.result == 1) then 
        -- 计算被锁定的战员
        local lockList = {}
        local bossData = dup.DupApostlesWarManager:getPanelInfo()
        for k,v in pairs(bossData.bossList) do
            if(v.id ~= msg.boss_id) then 
                local list = v.lockHeroList
                for i = 1, #list do
                    table.insert(lockList, list[i])
                end
            end
        end
         formation.checkFormationFight(PreFightBattleType.DupApostle2War, nil, msg.dup_id, formation.TYPE.DUP_APOSTLES, msg.boss_id, {lockList})
    end
end

---------------------------逻辑相关------------------------------------
---------------------------UI相关---------------------------------------
-- 打开副本页面
function onOpenMainPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR, true) == false then
        return
    end
    if self.mMainPanel == nil then
        self.mMainPanel = dup.DupApostlesMainPanel.new()
        self.mMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    end
    self.mMainPanel:open(args)
end

-- ui销毁
function onDestroyMainPanelHandler(self)
    self.mMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mMainPanel = nil
end

-- 打开Boss信息
function onOpenBossInfoView(self, args)
    if self.mBossInfoView == nil then
        self.mBossInfoView = dup.DupApostlesBossInfoView.new()
        self.mBossInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBossInfoViewHandler, self)
    end
    self.mBossInfoView:open(args)
end

function onCloseBossInfoView(self)
    if self.mBossInfoView and self.mBossInfoView.isPop then
        self.mBossInfoView:close()
    end
end

-- ui销毁
function onDestroyBossInfoViewHandler(self)
    self.mBossInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBossInfoViewHandler, self)
    self.mBossInfoView = nil
end

-- 打开使徒之战Boss界面
function onOpenWarPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR, true) == false then
        return
    end
    if self.mWarPanel == nil then
        self.mWarPanel = dup.DupApostlesWarPanel.new()
        self.mWarPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWarPanelHandler, self)
    end
    self.mWarPanel:open(args)
end

-- ui销毁
function onDestroyWarPanelHandler(self)
    self.mWarPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWarPanelHandler, self)
    self.mWarPanel = nil
end

-- 打开使徒之战奖励界面
function onOpenRewardPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR, true) == false then
        return
    end
    if self.mRewardPanel == nil then
        self.mRewardPanel = dup.DupApostlesWarStarAwardPanel.new()
        self.mRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRewardPanelHandler, self)
    end
    self.mRewardPanel:open(args)
end

-- ui销毁
function onDestroyRewardPanelHandler(self)
    self.mRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRewardPanelHandler, self)
    self.mRewardPanel = nil
end

-- 打开目标页面
function onOpenGoalPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR, true) == false then
        return
    end
    if self.mGoalPanel == nil then
        self.mGoalPanel = dup.DupApostlesWarGoalPanel.new()
        self.mGoalPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGoalPanelHandler, self)
    end
    self.mGoalPanel:open(args)
end

-- ui销毁
function onDestroyGoalPanelHandler(self)
    self.mGoalPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGoalPanelHandler, self)
    self.mGoalPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]