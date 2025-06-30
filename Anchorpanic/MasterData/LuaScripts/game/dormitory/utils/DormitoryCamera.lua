--[[
-----------------------------------------------------
@filename       : DormitoryCamera
@Description    : 宿舍摄像机
@date           : 2022-03-09 15：32
@Author         : Zhudonghai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.utils.DormitoryCamera', Class.impl(buildBase.BuildBaseCamera))

--可以调参数
cameraSpeedAtte = 0.08--速度衰减值
speedAddFloat = 20 --开始滑动的阻尼递增值

distance = 8.5 --当前镜头距离中心的距离（初始距离）
lateDistance = 0 --上一次镜头距离中心点的距离

maxDistance = 9.5--最大距离
minDistance = 6.8--最小距离

minimumY = 5--纵向最小角度
maximumY = 59--纵向最大角度

minimumX = 0--横向向最小角度
maximumX = 0--横向最大角度

cameraTweenFieldOfView = 60 --相机开始进来的视角大小

centerPos = {x = 0, y = 0, z = 0} --中心位置（相机聚焦）

function ctor(self)

end

function initCamera(self)
    super.initCamera(self)

    --特定镜头
    self.givenAngle = {
        {59, 0, 0}, --地面
        {10, 0, 0}, --墙壁
        {5, 0, 0}, --天花板
    }
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.DORMITORY_CONTROLLERLIVEMOVE, self.lookLive, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_EXITCONTROLLERLIVEMOVE, self.unlockLookLive, self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, self.onLockLive, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_CONTROLLERLIVEMOVE, self.lookLive, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_EXITCONTROLLERLIVEMOVE, self.unlockLookLive, self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, self.onLockLive, self)
end

--一开始进来的镜头拉近
function onStartTween(self)
    gs.TransQuick:Pos(self.sceneCameraTrans, self.sceneCameraTrans.forward * -self.distance)

    ---镜头拉近
    local sceneCamera = self.sceneCameraTrans:GetComponent(ty.Camera)
    local initField = sceneCamera.fieldOfView
    sceneCamera.fieldOfView = self.cameraTweenFieldOfView
    local tweener_FarClip = sceneCamera:DOFieldOfView(initField, 1)
    tweener_FarClip:SetEase(gs.DT.Ease.OutQuint)

    local sequence = gs.DT.DOTween.Sequence()
    sequence:OnUpdate(function()
        self:updateCameraPos()
    end)
    sequence:Append(tweener_FarClip)
    sequence:Play()
end

--镜头操作帧更新
function onCameraSlowMove(self)
    local isControllerLive = dormitory.DormitoryManager:getCurControllerLiveTid() ~= nil --是否操控站员
    --当前没有在操作战员的话，在操作的下一帧刷新角度，保留摇床晃动效果
    if not isControllerLive then
        gs.TransQuick:LerpCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
    end

    local isStop = false
    if gs.Application.isMobilePlatform and not isControllerLive then
        isStop = self:onMobilePlatformCameraSlowMove()
    else
        if not isControllerLive then
            -- if gs.UnityEngineUtil.GetMouseButton(1) == 1 and gs.UnityEngineUtil.GetMouseButton(0) == 0 then
            self.distance = self.distance - gs.Input.GetAxis("Mouse ScrollWheel") * self.scaleFactor * gs.Time.deltaTime * 100
            self.distance = gs.Mathf.Clamp(self.distance, self.minDistance, self.maxDistance)
            -- self:stopRotate()
            -- end
        end
        isStop = self:updateCamera()
    end

    --操作战员情况下，立马刷新角度。不需要摇床晃动效果
    if isControllerLive then
        gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
    end

    self:updateCameraPos()

    if gs.Application.isMobilePlatform then
        return isStop
    else
        return false
    end
end

--更新相机位置
function updateCameraPos(self)
    self:setWallHideOrShow()
    self:setFurnitureHideOrShow()

    GameDispatcher:dispatchEvent(EventName.DORMITORY_CAMERAUPDATEPOS)
end

--转向某个角度
function moveToAngle(self, _index)
    local args = self.givenAngle[_index]
    local angle = {gs.TransQuick:GetRotationX(self.sceneCameraTrans), gs.TransQuick:GetRotationY(self.sceneCameraTrans)}
    if angle[1] == args[1]
        and angle[2] == args[2] then
        return
    end

    for i = 1, 2 do
        if args[i] ~= 0 then
            angle[i] = args[i]
        end
    end

    local tweener_angle = self.sceneCameraTrans:DORotate(gs.Vector3(angle[1], angle[2], 0), 1)
    tweener_angle:SetEase(gs.DT.Ease.OutQuint)
    tweener_angle.onUpdate = function()
        self.mCamera_moveX = gs.TransQuick:GetRotationY(self.sceneCameraTrans)
        self.mCamera_moveY = gs.TransQuick:GetRotationX(self.sceneCameraTrans)

        gs.TransQuick:Pos(self.sceneCameraTrans, self.sceneCameraTrans.forward * -self.distance)

        self:stopRotate()
    end

    if not self.sequence then
        self.sequence = gs.DT.DOTween.Sequence()
    end
    self.sequence:Append(tweener_angle)
    self.sequence:Play()
end

--设置相机距离中心点的距离
function setDistance(self, val, angle_x, angle_y)
    if self.distance == val then return end
    self.lateDistance = self.distance
    self.distance = val

    local tweener_angle = self.sceneCameraTrans:DORotate(gs.Vector3(angle_y, angle_x, 0), 1)
    tweener_angle:SetEase(gs.DT.Ease.OutQuint)
    tweener_angle.onUpdate = function()
        if not self.sceneCameraTrans then return end
        self.mCamera_moveX = gs.TransQuick:GetRotationY(self.sceneCameraTrans)
        self.mCamera_moveY = gs.TransQuick:GetRotationX(self.sceneCameraTrans)

        if not dormitory.DormitoryManager:getCurControllerLiveTid() ~= nil then
            gs.TransQuick:LerpCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
        else
            gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
        end
        self:updateCameraPos()
    end

    if not self.sequence then
        self.sequence = gs.DT.DOTween.Sequence()
    end
    self.sequence:Append(tweener_angle)
    self.sequence:Play()
end

--看向战员，同时锁定相机为跟随战员
function lookLive(self)
    self:stopRotate()

    local curControllerLiveTid = dormitory.DormitoryManager:getCurControllerLiveTid()
    local LiveThing = dormitory.DormitoryAIManager:getLiveTing(curControllerLiveTid)
    self.mLiveTran = LiveThing:getTrans()
    local TransQuick = gs.TransQuick
    self.centerPos = {x = TransQuick:GetTranPosition_X(self.mLiveTran), y = TransQuick:GetTranPosition_Y(self.mLiveTran) + 0.8, z = TransQuick:GetTranPosition_Z(self.mLiveTran)}
    self:setDistance(2.7, self.mLiveTran.eulerAngles.y, 15)
end

--摇杆事件  更新相机位置
function onLockLive(self, args)
    self.mCamera_moveX = self.mCamera_moveX + args.deltaRatioX * args.deltaTime * 5
    self.sceneCameraTrans.eulerAngles = gs.Vector3(self.mCamera_moveY, self.mCamera_moveX, 0)

    local TransQuick = gs.TransQuick
    self.centerPos = {x = TransQuick:GetTranPosition_X(self.mLiveTran), y = TransQuick:GetTranPosition_Y(self.mLiveTran) + 0.8, z = TransQuick:GetTranPosition_Z(self.mLiveTran)}

    if dormitory.DormitoryManager:getCurControllerLiveTid() then
        gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
    end
    self:updateCameraPos()
end

--解锁跟随战员
function unlockLookLive(self)
    self.centerPos = {x = 0, y = 0, z = 0}
    self.mLiveTran = nil

    self:setDistance(self.lateDistance, self.mCamera_moveX, self.mCamera_moveY)
end

-- 设置墙体隐藏还是显示
function setWallHideOrShow(self)
    local dic = 1.8
    local state = false
    local tran = nil
    ---墙面
    for k, v in pairs(DormitoryCost.ROOT_WALL_LIST) do
        tran = dormitory.DormitorySceneController:getWallRootTran(k)
        if tran then
            if v == DormitoryCost.ROOT_WALL_FRONT then
                state = gs.TransQuick:GetTranPosition_Z(self.sceneCameraTrans) > gs.TransQuick:GetTranPosition_Z(tran) - dic
            elseif v == DormitoryCost.ROOT_WALL_LEFT then
                state = gs.TransQuick:GetTranPosition_X(self.sceneCameraTrans) < gs.TransQuick:GetTranPosition_X(tran) + dic
            elseif v == DormitoryCost.ROOT_WALL_BACK then
                state = gs.TransQuick:GetTranPosition_Z(self.sceneCameraTrans) < gs.TransQuick:GetTranPosition_Z(tran) + dic
            elseif v == DormitoryCost.ROOT_WALL_RIGHT then
                state = gs.TransQuick:GetTranPosition_X(self.sceneCameraTrans) > gs.TransQuick:GetTranPosition_X(tran) - dic
            end
            local fadeComponent = tran:GetComponent(ty.FadeModelComponent)
            if not gs.GoUtil.IsCompNull(fadeComponent) then
                fadeComponent:SetMaterialFade(state)
            end
        end
    end
    -- 天花板
    tran = dormitory.DormitorySceneController:getWallRootTran(5)
    if tran then
        local fadeComponent = tran:GetComponent(ty.FadeModelComponent)
        if not gs.GoUtil.IsCompNull(fadeComponent) then
            fadeComponent:SetMaterialFade(gs.TransQuick:GetTranPosition_Y(self.sceneCameraTrans) > gs.TransQuick:GetTranPosition_Y(tran) - dic)
        end
    end
end

--设置家私显示还是隐藏
function setFurnitureHideOrShow(self)
    -- local dic = 1.8
    -- local state = false
    -- local tran = nil
    -- for key, name in pairs(DormitoryCost.SITE_ROOT_LIST) do
    --     if key ~= DormitoryCost.SITE_FLOOR then
    --         tran = dormitory.DormitorySceneController.roomScene:getSiteHanging(key)
    --         if key == DormitoryCost.SITE_TOP then
    --             state = gs.TransQuick:GetTranPosition_Y(self.sceneCameraTrans) > gs.TransQuick:GetTranPosition_Y(tran)
    --         elseif key == DormitoryCost.SITE_WALL_FRONT then
    --             state = gs.TransQuick:GetTranPosition_Z(self.sceneCameraTrans) > gs.TransQuick:GetTranPosition_Z(tran) - dic
    --         elseif key == DormitoryCost.SITE_WALL_LEFT then
    --             state = gs.TransQuick:GetTranPosition_X(self.sceneCameraTrans) < gs.TransQuick:GetTranPosition_X(tran) + dic
    --         elseif key == DormitoryCost.SITE_WALL_BACK then
    --             state = gs.TransQuick:GetTranPosition_Z(self.sceneCameraTrans) < gs.TransQuick:GetTranPosition_Z(tran) + dic
    --         elseif key == DormitoryCost.SITE_WALL_RIGHT then
    --             state = gs.TransQuick:GetTranPosition_X(self.sceneCameraTrans) > gs.TransQuick:GetTranPosition_X(tran) - dic
    --         end
    --         local fadeComponent = tran:GetComponent(ty.FadeModelComponent)
    --         if not gs.GoUtil.IsCompNull(fadeComponent) then
    --             fadeComponent:SetMaterialFade(state)
    --         end
    --     end
    -- end
end

function destroy(self)
    super.destroy(self)

    --特定镜头
    self.givenAngle = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
