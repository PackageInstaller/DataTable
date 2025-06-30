module("game.buildBase.controller.BuildBaseSceneController", Class.impl(map.MapBaseController))

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
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.BUILDBASE
end

-- 地图ID
function getMapID(self)
    return 1002
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    self:addEvent()
    self.camera = CameraUtil:createMainCamera()
    self.mainPanel = buildBase.BuildBaseMainPanel.new()
    self.mainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mainPanel:open()
    UIFactory:closeForcibly()
end

function onDestroyMainPanelHandler(self)
    UIFactory:startForcibly()
    CustomCamera:enableCamera(false)
    self.mainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mainPanel = nil
end

-- 清理当前地图
function clearMap(self)
    super.clearMap(self)
    self:removeEvent()
    -- UIFactory:closeForcibly()
end

function addEvent(self)
end

function removeEvent(self)
end

return _M