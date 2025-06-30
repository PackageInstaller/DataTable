module("ModelPlayer", Class.impl())

function ctor(self)
    self:__initData()
end

function __initData(self)    
    -- 父对象
    self.m_parentTrans = nil

    -- liveView用到的数据
    self.m_liveData = nil
    -- 模型显示的ui面板节点
    self.m_uiPanelIns = nil
    -- 模型显示的ui根节点
    self.m_layerRootGo = nil
    -- 模型显示的深度大小范围
    self.m_depth = nil
    -- 预制体的目标层级
    self.m_targetLayer = nil
    -- 屏幕坐标
    self.m_screenPos = nil
    -- 缩放大小
    self.m_scale = nil
    -- 旋转角度
    self.m_rotateAngle = nil
    -- 模型的世界坐标
    self._m_localPos = nil
end

function __reset(self)
    if self.m_modelView then
        self.m_modelView:destroy()
        self.m_modelView = nil
    end
    ModelLayerUtil:__removeDepth(self.m_uiPanelIns, self.m_layerRootGo)

    self:__initData()
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:__reset()
    LuaPoolMgr:poolRecover(self)
end

-- 设置data
function setData(self, cusLiveData, uiPanelIns, layerRootGo, depth)
    self:__reset()

    self.m_liveData = cusLiveData
    self.m_uiPanelIns = uiPanelIns
    self.m_layerRootGo = layerRootGo
    -- 设置模型默认的展示深度大小
    self.m_depth = depth and depth or 400
    if not self.m_modelView then
        self.m_modelView = fight.LiveView.new()
    end
    local function finishCall()
        self:__updateView()
        if(cusLiveData.finishCall)then
            cusLiveData.finishCall()
        end
    end
    self.m_modelView:setTID(cusLiveData.tid, cusLiveData.isMonster and 1 or 0, cusLiveData.isEffect, cusLiveData.weapon, finishCall)
end

function getModelTrans(self, cusParentTrans)
    if(self.m_modelView)then
        return self.m_modelView:getModelTrans()
    end
end

function __updateView(self)
    ModelLayerUtil:__addDepth(self.m_uiPanelIns, self.m_layerRootGo, self.m_depth)
    self:__updateParent()
    self:__updateScale()
    self:__updateRotate()
    self:__updateModelLayer()
    self:__updateScreenPos()
    self:__updateLocalPos()
    self:__updateAction()
end

function setParent(self, cusParentTrans)
    self.m_parentTrans = cusParentTrans
    self:__updateParent()
end

function __updateParent(self)
    if (self.m_modelView and self.m_parentTrans ~= nil) then
        self.m_modelView:setToParent(self.m_parentTrans, false)
    end
end

function playAction(self, aniHash)
    if (self.m_modelView ~= nil) then        
        self.m_modelView:playAction(aniHash)
    end
end

function setModelLayer(self, targetLayer)
    self.m_targetLayer = targetLayer
    self:__updateModelLayer()
end

function __updateModelLayer(self)
    if not self.m_targetLayer then
        self.m_targetLayer = "UI_ANIMATION"
    end
    if self.m_modelView then
        self.m_modelView:setDisplayLayer(self.m_targetLayer)
    end
end

function setScreenPos(self, cusX, cusY)
    self.m_screenPos = gs.Vector2(cusX, cusY)
    ---- 延迟2帧确保摄像机已经设置生效
    --LoopManager:removeFrame(self, self.__updateLocalPos)
    --LoopManager:addFrame(2, 1, self, self.__updateLocalPos)
    self:__updateScreenPos()
end

function __updateScreenPos(self)
    if (self.m_modelView) then
        if (self.m_screenPos ~= nil) then
            local uiRootCanvas = GameView.stage:GetComponent(ty.Canvas)
            -- local worldPos = gs.CameraMgr:ScreenToWorldByUICamera(gs.Vector3(self.m_screenPos.x, self.m_screenPos.y, uiRootCanvas.planeDistance / 2))
            local worldPos = gs.CameraMgr:ScreenToWorldByUICamera(gs.Vector3(self.m_screenPos.x, self.m_screenPos.y, -self.m_depth / 2))
            gs.TransQuick:Pos(self.m_modelView:getTrans(), worldPos.x, worldPos.y, worldPos.z)
        else
            gs.TransQuick:LPosZ(self.m_modelView:getTrans(), -self.m_depth / 2)
        end
    end
end

function setScale(self, cusScale)
    self.m_scale = cusScale == nil and 320 or cusScale
    self:__updateScale()
end

function __updateScale(self)
    if (self.m_modelView) then
        if (self.m_scale ~= nil) then
            gs.TransQuick:Scale(self.m_modelView:getTrans(), self.m_scale, self.m_scale, self.m_scale)
        end
    end
end

function setRotate(self, cusRotate)
    self.m_rotateAngle = cusRotate
    self:__updateRotate()
end

function __updateRotate(self)
    if (self.m_modelView) then
        if (self.m_rotateAngle ~= nil) then
            gs.TransQuick:SetLRotation(self.m_modelView:getTrans(), self.m_rotateAngle.x, self.m_rotateAngle.y, self.m_rotateAngle.z)
        end
    end
end

function setLocalPos(self, cusX, cusY, cusZ)
    self._m_localPos = gs.Vector3(cusX, cusY, cusZ)
    self:__updateLocalPos()
end

function __updateLocalPos(self)
    if (self.m_modelView) then
        if (self._m_localPos ~= nil) then
            gs.TransQuick:LPos(self.m_modelView:getTrans(), self._m_localPos.x, self._m_localPos.y, self._m_localPos.z)
        end
    end
end

function setAction(self)
end

function __updateAction(self)
end

return _M
