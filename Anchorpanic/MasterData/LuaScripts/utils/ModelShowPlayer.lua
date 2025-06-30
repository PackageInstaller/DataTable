module("ModelShowPlayer", Class.impl())

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if(soundPath == nil)then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
        else
            AudioManager:playSoundEffect(soundPath)
        end
        if params then
            callBack(self, unpack(params))
        else
            callBack(self)
        end
    end
    gs.UIComponentProxy.AddListener(obj, func)
end

-- 为组件移除侦听点击事件
function removeOnClick(self, obj)
    gs.UIComponentProxy.RemoveListener(obj)
end

function ctor(self)
    self:__initData()
end

function __initData(self)
    -- 旋转速度，0~1
    self.m_rotateSpeed = 0.5
    -- 旋转的角度显示
    self.m_anglesMinAndMax = gs.Vector2(0, 0)
    -- 初始旋转的角度
    self.m_initAngle = 180
    -- 当前旋转的角度
    self.m_angle = 0
    -- 当前的鼠标坐标
    self.m_mousePos = gs.Vector3(0, 0, 0)

    self.m_modelPlayer = nil
    self.m_frameSn = nil
    self.m_parentTrans = nil
    self.m_clickGo = nil
end

function __reset(self)
    if (self.m_modelPlayer) then
        self.m_modelPlayer:poolRecover()
    end

    if (self.m_clickGo) then
        self.m_trigger.onBeginDrag:RemoveAllListeners()
        self.m_trigger.onEndDrag:RemoveAllListeners()
        self.m_trigger.onClick:RemoveAllListeners()
        gs.GoUtil.RemoveComponent(self.m_clickGo, ty.LongPressOrClickEventTrigger)
    end

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
function setData(self, cusLiveData, uiPanelIns, layerRootGo, depth, cusParentTrans, cusClickGo, cusScale)
    self:__reset()
    self:__initParent(cusParentTrans, cusClickGo)
    self:__initModelPlayer(cusLiveData, cusScale, uiPanelIns, layerRootGo, depth)
end

function getModelTrans(self, cusParentTrans)
    if(self.m_modelPlayer)then
        return self.m_modelPlayer:getModelTrans()
    end
end

function __initParent(self, cusParentTrans, cusClickGo)
    -- 设置模型所在展示节点的z坐标，此处改为放在ModelPlayer里直接设置模型
    -- local rect = cusParentTrans:GetComponent(ty.RectTransform)
    -- gs.TransQuick:LPosZ(rect, -gs.CameraMgr:GetWorldDis() / 2)
    -- gs.TransQuick:LPosZ(rect, -depth / 2)

    self.m_parentTrans = cusParentTrans
    self.m_clickGo = cusClickGo
    self.m_angle = self.m_parentTrans.eulerAngles

    if (self.m_clickGo) then
        -- gs.GoUtil.AddComponent(self.m_clickGo, ty.Button)
        -- self:addOnClick(self.m_clickGo, self.__onClickHandler)

        self.m_trigger = gs.GoUtil.AddComponent(self.m_clickGo, ty.LongPressOrClickEventTrigger)
        local function _onBeginDragHandler()
            self:__onBeginDragHandler()
        end
        self.m_trigger.onBeginDrag:AddListener(_onBeginDragHandler)
        local function _onEndDragHandler()
            self:__onEndDragHandler()
        end
        self.m_trigger.onEndDrag:AddListener(_onEndDragHandler)
        local function _onClickHandler()
            self:__onClickHandler()
        end
        self.m_trigger.onClick:AddListener(_onClickHandler)
    end
end

function __onBeginDragHandler(self)
    if (not self.m_frameSn) then
        self.m_mousePos = gs.Input.mousePosition
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.__onFrameUpdateHandler)
    end
end

function __onEndDragHandler(self)
    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function __onClickHandler(self)
    if (self.m_modelPlayer) then
        if not self.m_tmpAniList then
            self.m_tmpAniList = {fight.FightDef.ACT_SHOW_TIME_1,fight.FightDef.ACT_SHOW_TIME_2,fight.FightDef.ACT_SHOW_TIME_3,fight.FightDef.ACT_SHOW_TIME_4}
        end
        self.m_modelPlayer:playAction(self.m_tmpAniList[math.random(1, #self.m_tmpAniList)])
    end
end

function __initModelPlayer(self, cusLiveData, cusScale, uiPanelIns, layerRootGo, depth)
    self.m_modelPlayer = ModelPlayer:poolGet()
    self.m_modelPlayer:setData(cusLiveData, uiPanelIns, layerRootGo, depth)
    self.m_modelPlayer:setParent(self.m_parentTrans)
    self.m_modelPlayer:setRotate(gs.Vector3(0, self.m_initAngle, 0))
    self.m_modelPlayer:setScale(cusScale)
    if(cusLiveData.isUIAction)then
        self.m_modelPlayer:playAction(fight.FightDef.ACT_SHOW_STAND)
    else
        self.m_modelPlayer:playAction(fight.FightDef.ACT_STAND)
    end
end

function __onFrameUpdateHandler(self)
    if (not self.m_parentTrans) then
        self:__reset()
        return
    end
    -- 放到 onBeginDrag 时刻获取
    -- if (gs.Input:GetMouseButtonDown(0)) then
    --     self.m_mousePos = gs.Input.mousePosition
    -- end
    if (gs.Input:GetMouseButton(0)) then
        local pos = gs.Input.mousePosition - self.m_mousePos
        self.m_angle = self.m_angle - gs.Vector3(-pos.y * self.m_rotateSpeed, pos.x * self.m_rotateSpeed, 0)
    end
    self.m_angle.x = gs.Mathf.Clamp(self.m_angle.x, self.m_anglesMinAndMax.x, self.m_anglesMinAndMax.y)
    self.m_modelPlayer:setRotate(gs.Vector3(self.m_angle.x, self.m_initAngle + self.m_angle.y, self.m_angle.z))
    self.m_mousePos = gs.Input.mousePosition
end

return _M
