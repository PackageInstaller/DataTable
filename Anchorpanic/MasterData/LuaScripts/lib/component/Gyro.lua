module('lib.component.Gyro', Class.impl())

--构造函数
function ctor(self)
    self.m_sn = SnMgr:getSn()
end

function attach(self, GO, speed , ignoreInput)
    if self.m_go then 
        return;
    end
    self.speed = speed;
    self.ignoreInput = ignoreInput
    self:initData(GO)
end

-- 初始化数据
function initData(self, rootGo)
    self.m_go = rootGo
    self.m_trans = rootGo.transform:GetComponent(ty.RectTransform)
    self.XScope = 0
    self.YScope = 0
    self.locationX = self.m_trans.anchoredPosition.x
    self.locationY = self.m_trans.anchoredPosition.y
    local wide, height = ScreenUtil:getScreenSize()
    self.MaxMoveX = math.abs(wide - self.m_trans.rect.size.x) * 0.5
    self.MaxMoveY = math.abs(height - self.m_trans.rect.size.y) * 0.5
    self.isStop = true
    self.time = 0
    gs.UnityEngineUtil.SetGyro(true)
    if self.speed > 0 then
        self.mLoop = LoopManager:addFrame(2, 0, self, self.update)
    end
end

function update(self)
    if gs.UnityEngineUtil.HasTouchScreen() and not self.ignoreInput then
        self.locationX = self.m_trans.anchoredPosition.x
        self.locationY = self.m_trans.anchoredPosition.y
        self.isStop = false
        self.time = 0
        return
    end
    if self.isStop then
        local xy = gs.UnityEngineUtil.GetGyroAttrbute()
        local gyroScopeX = math.ceil(xy[0]*220)   --越大幅度越大
        local gyroScopeY = math.ceil(xy[1]*220)   --越大幅度越大
        self.XScope = self.locationX + gyroScopeX
        self.YScope = self.locationY + gyroScopeY
        if self.XScope > self.MaxMoveX then 
            self.XScope = self.MaxMoveX
        elseif self.XScope < -self.MaxMoveX then
            self.XScope = -self.MaxMoveX
        end

        if self.YScope > self.MaxMoveY then 
            self.YScope = self.MaxMoveY
        elseif self.YScope < -self.MaxMoveY then
            self.YScope = -self.MaxMoveY
        end
        
        self.m_trans.anchoredPosition = gs.Vector2.Lerp(self.m_trans.anchoredPosition, gs.Vector2(self.XScope, self.YScope), self.speed)
        return
    end

    if self.time > 1.5 then 
        if not self.isStop and not self.ignoreInput then
            local newLocationX = self.m_trans.anchoredPosition.x
            local newLocationY = self.m_trans.anchoredPosition.y
            self.isStop = math.abs(newLocationX - self.locationX) <= 0.001 and math.abs(newLocationY - self.locationY) <= 0.001
            self.locationX = newLocationX
            self.locationY = newLocationY
        end
    else
        self.time = self.time + LoopManager:getDeltaTime()
    end
end

function removeSelf(self)
    SnMgr:disposeSn(self.m_sn)
    self.m_sn = nil
    self.m_go = nil
    if self.mLoop then 
        LoopManager:removeFrameByIndex(self.mLoop)
        self.mLoop = nil
    end
    self.m_trans = nil
    gs.UnityEngineUtil.SetGyro(false)
end

-- 移除
function removeGyro(self)
    self:removeSelf()
end

return _M