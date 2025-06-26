module('guide.GuideController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--游戏开始的回调
function gameStartCallBack(self)
    self.m_firstUpdate = true
end
function reLogin(self)
    super.reLogin(self)
    guide.GuideManager:switchFinishCall(false)
    self:__onClosePanel()
    self:__onCloseToolsPanel()
end
--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_GUIDE_PANEL, self.__onOpenPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUIDE_PANEL, self.__onClosePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUIDE_TOOLS_PANEL, self.__onOpenToolsPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUIDE_TOOLS_PANEL, self.__onCloseToolsPanel, self)

    GameDispatcher:addEventListener(EventName.FUNC_OPEN_UPDATE, self.__onFuncOpenUpdate, self)

    -- -- 防止消息比创建更快
    -- if guide.GuideManager:checkResetGuide()==true then
    --     self.m_firstUpdate = false
    -- else
    --     battleMap.MainMapManager:addEventListener(battleMap.MainMapManager.EVENT_DUP_UPDATE, self.__onDupUpdateHandler, self)   
    -- end
end

function __onDupUpdateHandler(self)
    -- print("__onDupUpdateHandler")
    -- if self.m_firstUpdate then
    --     self.m_firstUpdate = false
    --     guide.GuideManager:checkResetGuide()
    -- end
end

-- 功能开启
function __onFuncOpenUpdate(self, msg)
    if msg and msg.funcId then
        guide.GuideCondition:condition07(msg.funcId)
    end
end
--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_PLAYER_GUIDE_INFO = self.onRecvSC_PLAYER_GUIDE_INFO,
        SC_GUIDE_AWARD = self.onRecvSC_GUIDE_AWARD,
    }
end

function onRecvSC_PLAYER_GUIDE_INFO(self, msg)
    guide.GuideManager:setPassGuideIds(msg.guide_list)
end

function onRecvSC_GUIDE_AWARD(self, msg)
    self:recvGuideFlag()
end

function __onOpenPanel(self)
    if self.m_guidePanel == nil then
        self.m_guidePanel = guide.GuidePanel.new()
        self.m_guidePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.m_guidePanel:open()
end

-- ui销毁
function __onClosePanel(self)
    guide.GuideManager:recoverTimeScale()
    guide.GuideManager:closeLoopCheck()
    if self.m_guidePanel then
        self.m_guidePanel:close()
        -- self.m_guidePanel = nil
    end
end

function onDestroyViewHandler(self)
    self.m_guidePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.m_guidePanel = nil
end

-- TOOLS
function __onOpenToolsPanel(self)
    if self.m_guideToolsPanel == nil then
        self.m_guideToolsPanel = guide.GuidePanelTools.new()
        self.m_guideToolsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyToolsViewHandler, self)
    end
    self.m_guideToolsPanel:open()
end

-- ui销毁
function __onCloseToolsPanel(self)
    if self.m_guideToolsPanel then
        self.m_guideToolsPanel:close()
        -- self.m_guideToolsPanel = nil
    end
end

function onDestroyToolsViewHandler(self)
    self.m_guideToolsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyToolsViewHandler, self)
    self.m_guideToolsPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
