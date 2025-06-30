module("covenant.CovenantMainSceneController", Class.impl(map.MapBaseController))

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
    return MAP_TYPE.COVENANT
end

-- 地图ID
function getMapID(self)
    return 1001
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    self:addEvent()

    covenant.CovenantMainCamera:initCamera()
    self.mCovenantMainPanel = covenant.CovenantMainPanel.new()
    self.mCovenantMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mCovenantMainPanel:open()

    UIFactory:closeForcibly()
end

function onDestroyMainPanelHandler(self)
    UIFactory:startForcibly()
    covenant.CovenantMainCamera:destoryCamera()

    self.mCovenantMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mCovenantMainPanel = nil
    UIFactory:closeForcibly()
end

function updateUI(self)
    if self.mCovenantMainPanel then
        self.mCovenantMainPanel:updateUI()
    end
end

function canUseRay(self)
    return self.mCovenantMainPanel:canRay()
end

function clickEvent(self)
    self.mCovenantMainPanel:clickRay()
end

-- -- 变更是否后台刷新
-- function setUpdateRuntime(self, isUpdate)
--     self.isUpdate = isUpdate
--     covenant.CovenantMainCamera:setRunUpdate(isUpdate)
-- end

-- 清理当前地图
function clearMap(self)
    super.clearMap(self)
    self:removeEvent()
end

function addEvent(self)
    GameDispatcher:addEventListener(EventName.CUSTOM_CONVENANT_SCENE_CHANGE, self.onSceneChange, self)
end

function removeEvent(self)
    GameDispatcher:removeEventListener(EventName.CUSTOM_CONVENANT_SCENE_CHANGE, self.onSceneChange, self)
end

function onSceneChange(self)
    if self.mCovenantMainPanel ~= nil then
        self.mCovenantMainPanel:onCustomClose()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
