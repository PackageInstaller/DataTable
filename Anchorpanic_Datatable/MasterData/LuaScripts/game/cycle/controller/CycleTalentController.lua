module("game.cycle.controller.CycleTalentController", Class.impl(Controller))

-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_TALENT_PANEL, self.onOpenTalentPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_TALENT_CONGNITION_PANEL, self.onOpenTalentCongnitionPanel, self)
    ----------------------------------------------------------请求后端----------------------------------------------------------
    -- 请求后端
    GameDispatcher:addEventListener(EventName.REQ_UNLOCK_TALENT, self.onReqUnlockTalentHandler, self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 天赋面板信息 19522
        SC_EVENT_CYCLE_TALENT_INFO = self.onCycleTalentInfoHandler,
        --- *s2c* 解锁天赋结果 19521
        SC_EVENT_CYCLE_UNLOCK_TALENT = self.onCycleTalentUnlockHandler,
        --- *s2c* 更新天赋点数 19523
        SC_EVENT_CYCLE_UPDATE_TALENT_POINT = self.onCycleTalentPointUpdateHandler,
    }
end

------------------------------------------------------------server - local------------------------------------------------------------

function onCycleTalentInfoHandler(self, msg)
    cycle.CycleTalentManager:parseTalentPanel(msg)
end

function onCycleTalentUnlockHandler(self, msg)
    if msg.result == 1 then 
        cycle.CycleTalentManager:unlockTalentRes(msg)
    end
end

function onCycleTalentPointUpdateHandler(self, msg)
    cycle.CycleTalentManager:updateTalentPoint(msg)
end

------------------------------------------------------------local - server------------------------------------------------------------
--- *c2s* 解锁天赋 19520
function onReqUnlockTalentHandler(self, talentId)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_UNLOCK_TALENT, {talent_id = talentId})
end

------------------------------------------------------------主界面------------------------------------------------------------
function onOpenTalentPanel(self, args)
    if self.mCycleTalentPanel == nil then
        self.mCycleTalentPanel = cycle.CycleTalentPanel.new()
        self.mCycleTalentPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTalentPanelHandler, self)
    end
    self.mCycleTalentPanel:open()
end

function onDestoryCycleTalentPanelHandler(self)
    self.mCycleTalentPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTalentPanelHandler, self)
    self.mCycleTalentPanel = nil
end

function onOpenTalentCongnitionPanel(self, args)
    if self.mCycleTalentCongnitionPanel == nil then
        self.mCycleTalentCongnitionPanel = cycle.CycleTalentCongnitionPanel.new()
        self.mCycleTalentCongnitionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTalentCongnitionPanelHandler, self)
    end
    self.mCycleTalentCongnitionPanel:open()
end

function onDestoryCycleTalentCongnitionPanelHandler(self)
    self.mCycleTalentCongnitionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTalentCongnitionPanelHandler, self)
    self.mCycleTalentCongnitionPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
