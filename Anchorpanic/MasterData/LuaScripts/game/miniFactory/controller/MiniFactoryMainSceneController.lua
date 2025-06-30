module("covenant.MiniFactoryMainSceneController", Class.impl(map.MapBaseController))

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
    -- 清理当前地图
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.MINIFACTORY
end

-- 地图ID
function getMapID(self)
    return 998
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MINIFACTORY, true) == false then
        return
    end
    -- GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MINIFACTORY)
    if self.mMiniFactory == nil then
        self.mMiniFactory = miniFac.MiniFactoryPanel.new()
        self.mMiniFactory:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiniFactoryPanelHandler, self)
    end
    self.mMiniFactory:open()
    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_INFO)
    --if not self.loopSn then
    --    self.loopSn = LoopManager:addFrame(3, 0, self, self.updateUI)
    --end
    UIFactory:closeForcibly()
end

function onDestroyMiniFactoryPanelHandler(self)
    --LoopManager:removeFrameByIndex(self.loopSn)
    --self.loopSn = nil
    self.mMiniFactory:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiniFactoryPanelHandler, self)
    self.mMiniFactory:deActive()
    self.mMiniFactory:close()
    self.mMiniFactory = nil
end

function updateUI(self)
    if self.mMiniFactory then
        self.mMiniFactory:updateUI()
    end
end

-- 清理当前地图
function clearMap(self)
    UIFactory:startForcibly()
    if self.loopSn then
        LoopManager:removeFrameByIndex(self.loopSn)
        self.loopSn = nil
    end
    super.clearMap(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]