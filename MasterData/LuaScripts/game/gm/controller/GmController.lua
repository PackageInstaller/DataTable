module('gm.GmController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
    self:__onCreateGmHandler()
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    if (self.m_gmPanel) then
        self.m_gmPanel:close()
    end
    self:__onDestroyGmHandler()
end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.CREATE_GM, self.__onCreateGmHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_GM_PANEL, self.__onOpenGmPanelHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_GM_LIST, self.__onRequestGmListHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_GM_RUN, self.__onRequestGmRunHandler, self)
    gm.GmManager:addEventListener(gm.GmManager.EVENT_VISIBLE_CHANGE, self.__onGmVisibleChangeHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 返回gm指令列表 10005
        SC_GM_LIST = self.__onGmListMsgHandler,
        --- *s2c* gm指令结果 10007
        SC_GM_COMMAND = self.__onGmResultMsgHandler,
    }
end

--  请求Gm列表
function __onRequestGmListHandler(self, args)
    SOCKET_SEND(Protocol.CS_GM_LIST, {})
end

-- Gm列表返回
function __onGmListMsgHandler(self, msg)
    local cmdList = msg.cmd_list
    gm.GmManager:parseCmdData(cmdList)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GM_PANEL)
end

-- 请求Gm命令
function __onRequestGmRunHandler(self, args)
    SOCKET_SEND(Protocol.CS_GM_COMMAND, {
        command = args.command
    })
end

-- Gm结果返回
function __onGmResultMsgHandler(self, msg)
    gs.Message.Show2(msg.result)
    logInfo(msg.result)
end

--------------------------------------------------------------Gm面板----------------------------------------------------------------------
-- 创建Gm
function __onCreateGmHandler(self)
    if GameManager.IS_DEBUG then
        if self.m_GmBtn == nil then
            self.m_GmBtn = AssetLoader.GetGO(UrlManager:getUIPrefabPath("gm/GM.prefab"))
            self.m_GmBtn.transform:SetParent(GameView.msg, false)
            local rect = self.m_GmBtn:GetComponent(ty.RectTransform)
            gs.TransQuick:LPos(rect, -100, 320, 0)
            gs.TransQuick:Scale(rect, 1, 1, 1)
            local function openGmPanel()
                GameDispatcher:dispatchEvent(EventName.OPEN_GM_PANEL)
            end
            gs.UIComponentProxy.AddListener(self.m_GmBtn, openGmPanel)
        end
    end
end

-- 销毁Gm
function __onDestroyGmHandler(self)
    if self.m_GmBtn then
        gs.UIComponentProxy.RemoveListener(self.m_GmBtn)
        AssetLoader.ReleaseAsset("GM.prefab")
        gs.GameObject.Destroy(self.m_GmBtn)
        self.m_GmBtn = nil
    end
end

function __onGmVisibleChangeHandler(self, args)
    self.m_GmBtn:SetActive(args)
end

-- 打开Gm面板
function __onOpenGmPanelHandler(self)
    if self.m_gmPanel == nil then
        self.m_gmPanel = gm.GmPanel.new()
        self.m_gmPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRolePanelHandler, self)
    end
    if (self.m_gmPanel.isPop == 0) then
        self.m_gmPanel:open()
    else
        self.m_gmPanel:close()
    end
end

-- ui销毁
function onDestroyRolePanelHandler(self)
    self.m_gmPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRolePanelHandler, self)
    self.m_gmPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
