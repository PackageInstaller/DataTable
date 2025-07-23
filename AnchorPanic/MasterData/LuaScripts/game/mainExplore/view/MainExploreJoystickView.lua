--[[ 
-----------------------------------------------------
@filename       : MainExploreJoystickView
@Description    : 主线探索摇杆
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreJoystickView', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreJoystickView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

function getAdaptaTrans(self)
    return self:getChildTrans("AdaptaGroup")
end

function initData(self)
    self.mEnable = true
    
    self.mStartPos = math.Vector3(0, 0, 0)
    self.mEndPos = math.Vector3(0, 0, 0)

    -- 摇杆最大半径
    self.mMaxRadius = 50
end

-- 初始化
function configUI(self)
    self.mImgBg = self:getChildTrans('mImgBg')
    self.mImgRoll = self:getChildTrans('mImgRoll')
    self.mArrow = self:getChildGO('mArrow')
    if(self.mArrow)then
        self.mArrowRect = self.mArrow:GetComponent(ty.RectTransform)
    end
    self.mEventTrigger = self:getChildGO('mTouchEvent'):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mEventTrigger:SetIsPassEvent(false)

    self.mStartPos.x = self.mImgRoll.localPosition.x
    self.mStartPos.y = self.mImgRoll.localPosition.y

    self:setGuideTrans("guide_mainExploreScene_touch", self:getChildTrans('mTouchEvent'))
    
end

--激活
function active(self)
    super.active(self)
    self:addEventTrigger(self.mEventTrigger)
    if(self.mArrow)then
        self.mArrow:SetActive(false)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeUpdateFrameSn()
    self:removeEventTrigger(self.mEventTrigger)
    GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, {deltaTime = 0, deltaRatioX = 0, deltaRatioY = 0})
end

function addEventTrigger(self, eventTrigger)
    local function _onBeginDragHandler()
        self:onBeginDragHandler(eventTrigger.EventData)
    end
    eventTrigger.onBeginDrag:AddListener(_onBeginDragHandler)
    local function _onDragHandler()
        self:onDragHandler(eventTrigger.EventData)
    end
    eventTrigger.onDrag:AddListener(_onDragHandler)
    local function _onEndDragHandler()
        self:onEndDragHandler(eventTrigger.EventData)
    end
    eventTrigger.onEndDrag:AddListener(_onEndDragHandler)
end

function removeEventTrigger(self, eventTrigger)
    eventTrigger.onBeginDrag:RemoveAllListeners()
    eventTrigger.onDrag:RemoveAllListeners()
    eventTrigger.onEndDrag:RemoveAllListeners()
end

function onBeginDragHandler(self, eventData)
    self:addUpdateFramSn()
end

function onDragHandler(self, eventData)
    local pos = eventData.position
    self.mEndPos.x = pos.x
    self.mEndPos.y = pos.y
    if(self.mArrow)then
        self.mArrow:SetActive(true)
    end
end

function onEndDragHandler(self, eventData)
    self:removeUpdateFrameSn()
    if(self.mArrow)then
        self.mArrow:SetActive(false)
    end
	gs.TransQuick:UIPos(self.mImgRoll, self.mStartPos.x, self.mStartPos.y)
    GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, {deltaTime = 0, deltaRatioX = 0, deltaRatioY = 0})
end

function addUpdateFramSn(self)
    self:removeUpdateFrameSn()
    self.mUpdateFrameSn = LoopManager:addFrame(1, 0, self, self.onFrameUpdateHandler)
end

function removeUpdateFrameSn(self)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    end
end

function onFrameUpdateHandler(self, deltaTime)
    if(mainExplore.MainExploreManager:getRate() ~= 0 and self.mEnable == true)then
        local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(self.mEndPos)
        local localPos = self.mImgBg:InverseTransformPoint(mouseWorldPos)
        localPos.z = 0
    
        -- 如果超出摇杆范围
        if (localPos.magnitude > self.mMaxRadius) then
            localPos = localPos.normalized * self.mMaxRadius
        end
        localPos.x = math.floor(localPos.x)
        localPos.y = math.floor(localPos.y)
        gs.TransQuick:UIPos(self.mImgRoll, localPos.x, localPos.y)
    
        if(self.mArrowRect)then
            local angle = gs.Vector3.Angle(localPos, self.mImgBg.transform.up)
            local cross = gs.Vector3.Dot(gs.Vector3.forward, gs.Vector3.Cross(localPos, self.mImgBg.transform.up))
            local dir = cross < 0 and 1 or -1
            self.mArrowRect.localEulerAngles = gs.Vector3(0, 0, dir * angle)
        end
        
        -- 获取拖动的delta值 （-1 < DeltaX < 1，-1 < DeltaY < 1）
        local deltaRatioX = localPos.x / self.mMaxRadius
        local deltaRatioY = localPos.y / self.mMaxRadius

        GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, {deltaTime = deltaTime, deltaRatioX = deltaRatioX, deltaRatioY = deltaRatioY})
    else
        GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, {deltaTime = deltaTime, deltaRatioX = 0, deltaRatioY = 0})
    end
end

function setEnable(self, enable)
    self.mEnable = enable
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
