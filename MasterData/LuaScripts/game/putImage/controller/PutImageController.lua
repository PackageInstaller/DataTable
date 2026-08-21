-- @FileName:   PutImageController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-05 16:11:19
-- @Copyright:   (LY) 2023 雷焰网络

module("game.putImage.controller.PutImageController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_PUTIMAGE_SCENEUI, self.onOpePutImageSceneUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_PUTIMAGE_DUPINFOPANEL, self.onOpenPutImageDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_PUTIMAGE_DUPINFOPANEL, self.onClosePutImageDupPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_PUTIMAGE_STAGEPANEL, self.onOpePutImageStageMainUI, self)

    GameDispatcher:addEventListener(EventName.PUTIMAGE_PASS_DUP, self.onReqPutImagePassDup, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_JIGSAW_PUZZLE_PANEL = onReceivePutImagePanelInfo,
    }
end
-------------------------------------------------------------数据--------------------------------------------------------------------

--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------
-- 打开场景战斗界面
function onOpePutImageSceneUI(self, args)
    if self.mPutImageSceneUI == nil then
        self.mPutImageSceneUI = UI.new(putImage.PutImageSceneUI)
        self.mPutImageSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPutImageSceneUI, self)
        self.mPutImageSceneUI:open(args)
    else
        self.mPutImageSceneUI:refreshView(args)
    end
end

-- ui销毁
function onDestroyPutImageSceneUI(self)
    self.mPutImageSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPutImageSceneUI, self)
    self.mPutImageSceneUI = nil
end

-- 关闭蛋壳场景战斗界面
function onClosePutImageSceneUI(self)
    if self.mPutImageSceneUI then
        self.mPutImageSceneUI:close()
    end
end

-- 打开关卡详情界面
function onOpenPutImageDupPanel(self, args)
    if self.mPutImageDupPanel == nil then
        self.mPutImageDupPanel = UI.new(putImage.PutImageDupPanel)
        self.mPutImageDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPutImageDupPanel, self)
        self.mPutImageDupPanel:open(args)
    else
        self.mPutImageDupPanel:updateView(args)
    end

end

-- ui销毁
function onDestroyPutImageDupPanel(self)
    self.mPutImageDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPutImageDupPanel, self)
    self.mPutImageDupPanel = nil
end

function onClosePutImageDupPanel(self, args)
    if self.mPutImageDupPanel ~= nil then
        self.mPutImageDupPanel:close()
    end
end

-- 打开关卡选择界面
function onOpePutImageStageMainUI(self, args)
    if self.mPutImageStageMainUI == nil then
        self.mPutImageStageMainUI = UI.new(putImage.PutImageStageMainUI)
        self.mPutImageStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPutImageStageMainUI, self)

    end
    self.mPutImageStageMainUI:open(args)
end

-- ui销毁
function onDestroyPutImageStageMainUI(self)
    self.mPutImageStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPutImageStageMainUI, self)
    self.mPutImageStageMainUI = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

--面板数据
function onReceivePutImagePanelInfo(self, msg)
    -- logAll(msg, " *s2c* 拼图面板 18212")
    for _, dup_id in pairs(msg.dup_list) do
        putImage.PutImageManager:setPassStage(dup_id)
    end

    GameDispatcher:dispatchEvent(EventName.PUTIMAGE_RECEIVE_INFO)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end
---------------------------------------------------------------请求------------------------------------------------------------------
--请求通关关卡
function onReqPutImagePassDup(self, args)
    local cmd = {dup_id = args}
    -- logAll(cmd, "请求通关关卡")
    SOCKET_SEND(Protocol.CS_PASS_JIGSAW_PUZZLE, cmd)
end

return _M
