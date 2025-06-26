module("map.MapLoader", Class.impl())

--构造函数
function ctor(self)
    self:resetMapCtrl()
    self.m_ctrlMap = {}
    GameDispatcher:addEventListener(EventName.ENTER_NEW_MAP, self.onEnterMapHandler, self)
end

function resetMapCtrl(self)
    self.m_lastSceneCtrl = nil
    self.m_curSceneCtrl = nil
    self.m_lastMapType = nil
    self.m_curMapType = nil
    self.m_isForceLoad = nil
end

function regMap(self, mapType, sceneCtrl)
    self.m_ctrlMap[mapType] = sceneCtrl
end

function onEnterMapHandler(self, mapType)
    -- print(self.__cname, "onEnterMapHandler", mapType )
    if not self.m_isForceLoad then
        if self.m_curMapType == mapType then return end
    end

    local sceneCtrl = self.m_ctrlMap[mapType]
    if sceneCtrl then
        local function _preloadCall(pro)
            map.MapManager:setMapType(mapType)
            self:loadScene(sceneCtrl)
        end
        if sceneCtrl.preloadCall then
            sceneCtrl:preloadCall(_preloadCall)
        else
            _preloadCall()
        end
    end
end

-- 加载地图
function loadScene(self, sceneCtrl)
    -- print(self.__cname, "loadScene", sceneCtrl, sceneCtrl:getMapType())
    sceneCtrl:beforeLoad()
    if self.m_curSceneCtrl then
        if not self.m_isForceLoad then
            if sceneCtrl == self.m_curSceneCtrl then
                self.m_curSceneCtrl:enterMap()
                return
            end
        end
        self.m_curSceneCtrl:clearMap()
    end
    self.m_curSceneCtrl = sceneCtrl
    self.m_curMapType = sceneCtrl:getMapType()

    local function _loadCall(pro)
        -- 0 < pro < 100
    end
    local function _finishCall()
        local loadSceneCtrl = self.m_ctrlMap[self.m_curMapType]
        if loadSceneCtrl then
            -- 该段代码屏蔽，放在U3DSceneUtil处理
            -- -- 安卓加载并非100就切换成功，需要延迟一点才能完全释放老场景后进入新场景（重要）
            -- self.timeSn = LoopManager:setTimeout(0.2, self,function ()
            -- loadSceneCtrl:enterMap()
            -- end)
            self.m_isForceLoad = false
            loadSceneCtrl:enterMap()
        end
    end
    local sceneRo = fight.SceneManager:getSceneData(sceneCtrl:getMapID())
    if sceneRo then
        U3DSceneUtil:loadSceneSingle(sceneRo:getScene(), _loadCall, _finishCall)
    else
        logError(string.format("[%s]'s scene data is none! load map fail~", sceneCtrl:getMapID()))
    end
end

function getCurSceneCtrl(self)
    return self.m_curSceneCtrl
end

function getCurSceneType(self)
    return self.m_curMapType
end

--是否强切
function setIsForceLoad(self, isForceLoad)
    self.m_isForceLoad = isForceLoad
end

function getIsForceLoad(self)
    return self.m_isForceLoad
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
