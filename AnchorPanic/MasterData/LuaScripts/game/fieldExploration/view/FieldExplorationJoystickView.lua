-- @FileName:   FieldExplorationJoystickView.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationJoystickView', Class.impl(mainExplore.MainExploreJoystickView))
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationJoystickView.prefab")

function active(self)
    super.active(self)
    --添加键盘监听事件
    LoopManager:addFrame(1, 0, self, self.onKeyboard)
end

function initData(self)
    super.initData(self)
    -- 摇杆最大半径
    self.mMaxRadius = 32
end

function configUI(self)
    super.configUI(self)
    self.mImgbg1 = self:getChildGO("mImgbg1")
    self.mImgbg2 = self:getChildGO("mImgbg2")
    self.mImgbg2Rect = self.mImgbg2:GetComponent(ty.RectTransform)

    if not self.mImgbg1.activeSelf then
        self.mImgbg1:SetActive(true)
    end

    if self.mImgbg2.activeSelf then
        self.mImgbg2:SetActive(false)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    --移除键盘事件
    LoopManager:removeFrame(self, self.onKeyboard)
end

function onBeginDragHandler(self, eventData)
    self.mIsDragJoystick = true
    super.onBeginDragHandler(self, eventData)
    if self.mImgbg1.activeSelf then
        self.mImgbg1:SetActive(false)
    end

    if not self.mImgbg2.activeSelf then
        self.mImgbg2:SetActive(true)
    end
end

function onEndDragHandler(self, eventData)
    self.mIsDragJoystick = false
    super.onEndDragHandler(self, eventData)

    if not self.mImgbg1.activeSelf then
        self.mImgbg1:SetActive(true)
    end

    if self.mImgbg2.activeSelf then
        self.mImgbg2:SetActive(false)
    end
end

function onFrameUpdateHandler(self, deltaTime)
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(self.mEndPos)
    local localPos = self.mImgBg:InverseTransformPoint(mouseWorldPos)
    localPos.z = 0

    if math.abs(localPos.normalized.x) < 0.2 and math.abs(localPos.normalized.y) < 0.2 then return end

    --不管是不是超过摇杆范围还是只移动了一点点
    localPos = localPos.normalized * self.mMaxRadius

    localPos.x = math.floor(localPos.x)
    localPos.y = math.floor(localPos.y)
    gs.TransQuick:UIPos(self.mImgRoll, localPos.x, localPos.y)

    -- 获取拖动的delta值 （-1 < DeltaX < 1，-1 < DeltaY < 1）
    local deltaRatioX = localPos.x / self.mMaxRadius
    local deltaRatioY = localPos.y / self.mMaxRadius
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, {deltaTime = deltaTime, deltaRatioX = deltaRatioX, deltaRatioY = deltaRatioY})

    local angle = gs.Vector3.Angle(localPos, self.mImgBg.transform.up)
    local cross = gs.Vector3.Dot(gs.Vector3.forward, gs.Vector3.Cross(localPos, self.mImgBg.transform.up))
    local dir = cross < 0 and 1 or - 1
    self.mImgbg2Rect.localEulerAngles = gs.Vector3(0, 0, dir * angle)
end

function onKeyboard(self, deltaTime)
    if self.mIsDragJoystick then return end

    local deltaRatioX = gs.Input.GetAxisRaw("Horizontal")
    local deltaRatioY = gs.Input.GetAxisRaw("Vertical")

    if deltaRatioX > 0 then
        deltaRatioX = 1
    elseif deltaRatioX < 0 then
        deltaRatioX = -1
    end

    if deltaRatioY > 0 then
        deltaRatioY = 1
    elseif deltaRatioY < 0 then
        deltaRatioY = -1
    end

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, {deltaTime = deltaTime, deltaRatioX = deltaRatioX, deltaRatioY = deltaRatioY})
end

return _M
