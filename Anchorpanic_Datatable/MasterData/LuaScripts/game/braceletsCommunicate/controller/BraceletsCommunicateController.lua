module("braceletsCommunicate.BraceletsCommunicateController", Class.impl(Controller))

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
    -- 打开通讯面板
    GameDispatcher:addEventListener(EventName.OPEN_COMMUNICATE_PANEL, self.onOpenCommunicatePanelHandler, self)

    --请求对话ID
    GameDispatcher:addEventListener(EventName.REQ_COMMUNICATE, self.__reqCommunicateHandler, self)
    --请求选择对话id
    GameDispatcher:addEventListener(EventName.REQ_COMMUNICATE_SELETE, self.__reqCommunicateSelectHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 手环通讯面板信息 12160
        SC_DIALOGUE_PANEL = self.__onResCommunicatePanelHandler,
        --- *s2c* 返回手环通讯对话 12162
        SC_DIALOGUE_TALK = self.__onResCommunicateMsgHandler,
        --- *s2c* 返回手环通讯玩家对话选择 12164
        SC_DIALOGUE_TALK_SELECT = self.__onResCommunicateMsgHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
function __onResCommunicatePanelHandler(self, msg)
    braceletsCommunicate.BraceletsCommunicateManager:parseCommunicateMsg(msg)
end

function __onResCommunicateMsgHandler(self, msg)
    if msg.result == 1 then 
        braceletsCommunicate.BraceletsCommunicateManager:updateCommunicate(msg)
    else
        -- gs.Message.Show()
    end
end
---------------------------------------------------------------请求------------------------------------------------------------------
--- *c2s* 手环通讯对话 12161
function __reqCommunicateHandler(self, targetId)
    SOCKET_SEND(Protocol.CS_DIALOGUE_TALK, { target_id = targetId })
end

--- *c2s* 手环通讯玩家对话选择 12163
function __reqCommunicateSelectHandler(self, args)
    local targetId = args.targetId
    local talkId = args.talkId
    SOCKET_SEND(Protocol.CS_DIALOGUE_TALK_SELECT, { target_id = targetId, talk_id = talkId})
end

------------------------------------------------------------------界面------------------------------------------
function onOpenCommunicatePanelHandler(self)
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHAT, true) == false then
    --     return
    -- end
    if self.mCommunicatePanel == nil then
        self.mCommunicatePanel = braceletsCommunicate.BraceletsCommunicatePanel.new()
        self.mCommunicatePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.mCommunicatePanel:open()
end

-- ui销毁
function onDestroyViewHandler(self)
    self.mCommunicatePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mCommunicatePanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
