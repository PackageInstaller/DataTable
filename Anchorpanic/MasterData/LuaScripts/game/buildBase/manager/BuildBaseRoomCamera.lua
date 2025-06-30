--[[ 
-----------------------------------------------------
@filename       : BuildBaseRoomCamera
@Description    : 基建摄像机
@date           : 2023-5-10 15：32
@Author         : Zhudonghai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.buildBase.BuildBaseRoomCamera', Class.impl(buildBase.BuildBaseCamera))

--可以调参数
cameraSpeedAtte = 0.08--速度衰减值
speedAddFloat = 20 --开始滑动的阻尼递增值

distance = 20 --当前镜头距离中心的距离（初始距离）
maxDistance = 20--最大距离
minDistance = 15--最小距离

minimumY = 20--纵向最小角度
maximumY = 40--纵向最大角度

minimumX = -30--横向向最小角度
maximumX = 30--横向最大角度

scaleFactor = 2 --缩放速度

cameraTweenFieldOfView = 60 --相机开始进来的视角大小

function ctor(self)

end

function initCamera(self)
    super.initCamera(self)
end

function addEventListener(self)

end

function removeEventListener(self)

end

--移动端镜头更新滑动
function onMobilePlatformCameraSlowMove(self)
    local isStop = false
    if gs.Input.touchCount == 1 then
        isStop = self:updateCamera()

        self.m_IsSingleFinger = true
    elseif gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
        self:onMobilePlatformCameraScale()

        ---速度归0 停下镜头旋转
    self.cameraSpeed = { x = 0, y = 0 }
    elseif math.abs(self.cameraSpeed.x) > 0 or math.abs(self.cameraSpeed.y) > 0 then
        isStop = self:updateCamera()
    end
    return isStop
end

function destroy(self)
    super.destroy(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
