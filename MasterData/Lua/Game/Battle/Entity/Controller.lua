--
-- Author:luqucheng
-- Date: 2019-12-11 14:02:22
--
local Controller = {}
Controller = Class("Controller")


Controller.camp = nil
Controller.isPlayer = false
Controller.inputQueue = nil
Controller.playerId = nil
Controller.InputType = {
    UseCard = 1,
    MoveCard = 2,
    ChangeTarget = 3,
    ResetInput = 4,
    Finish = 100,
    CancelHost = 998, --取消托管
    Host = 999, --托管
}

Controller.baseSeqId = nil

local cameraStartPos = nil
local isSwipedEnd = true
-- local OnSwipe = function ( data )
--     local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
--     SkillCameraMgr.brain.enabled = false
--     -- {x = -8.8378868103027, y = 3.3599998950958, z = 13.393347740173}
-- --     LUA: UIBattlingCameraSwipe
-- -- dx:0.0 dy:0.0
-- -- phi:1.324998252966 theta:1.3643869902765
-- -- x:3.9046015090531 y:3.3599998950958 z:15.56419268759
-- -- cx:-8.8378868103027 cy:3.3599998950958 cz:13.393347740173
--     local camera = CS.UnityEngine.Camera.main
--     if isSwipedEnd then
--         --初始化，记录相机的初始位置
--         cameraStartPos = camera.transform.position
--     end
    
--     isSwipedEnd = false
--     local posStart = data.posStart
--     local posNow = data.posNow



--     --根据便宜改变相机位置
--     local dx = posNow.x - posStart.x
--     local dy = posNow.y - posStart.y
--     --保持相机相对于坐标原点的距离不变
--     --直角坐标转极坐标之后,保持r改变θ,φ的值
--     local x = cameraStartPos.x
--     local z = cameraStartPos.y
--     local y = cameraStartPos.z

--     local r = math.sqrt(x * x + y * y + z * z)
--     local theta = math.acos(z / math.sqrt(x * x + y * y + z * z))

--     -- print("???", math.sin(theta) * math.sqrt(x * x + y * y + z * z), x)
--     local phi = math.acos( x / math.sin(theta) / math.sqrt(x * x + y * y + z * z)) 

--     -- print(math.atan(13/ 0.2), math.atan(13 / (-0.2) ), math.cos(math.atan(13/ 0.2)),  math.cos(math.atan(13 / (-0.2) )), math.sin(math.atan(13/ 0.2)), math.sin(math.atan(13 / (-0.2) )))

--     -- theta = math.min(1, theta + dy)
--     theta = theta + dy * 5
--     theta = math.min(1.4, theta)
--     theta = math.max(-1.4, theta)
    

--     local v3 = Vector3.New(cameraStartPos.x, cameraStartPos.z, 0)
--     local f = Vector3.New(1, 0, 0)
--     local angle = math.sign(cameraStartPos.z) * Vector3.Angle(f, v3)
--     local rad2Deg = 57.295779513082
--     local deg2Rad = 0.017453292519943

--     -- print(angle, phi * rad2Deg)

--     angle = angle - dx * rad2Deg * 10
--     if math.abs(angle) > 180 then
--         angle = angle - 360 * math.sign(angle)
--     end

--     phi = angle * deg2Rad
    
--     -- local signY = 1
--     -- local signX = 1
--     -- phi = phi - dx * 2
--     -- if phi > math.pi / 2 or phi < - math.pi / 2  then
--     --     phi = phi - math.pi * math.sign(phi)
--     --     signX = -math.sign(camera.transform.position.x)
--     --     signY = math.sign(camera.transform.position.y)
--     -- end

--     --极坐标转换回直角坐标
--     x = r * math.sin(theta) * math.cos(phi) 
--     y = r * math.sin(theta) * math.sin(phi) 
--     z = r * math.cos(theta)

--     --坐标系参考方式不同
--     camera.transform.position = Vector3.New(x, z, y)
--     local pos = Vector3.New(0, 0, 0)
--     camera.transform:LookAt( pos )
--     -- local w = {
--     --     "UIBattlingCameraSwipe\n",
--     --     "dx:", dx, " dy:", dy, "\n",
--     --     "phi:", phi, " theta:", theta, "\n",
--     --     "x:", x, " y:", z, " z:" ,y , "\n",
--     --     "cx:", cameraStartPos.x, " cy:", cameraStartPos.y, " cz:", cameraStartPos.z
--     -- }
--     -- print(table.concat( w))
    
-- end

-- local OnSwipeEnd = function (  )
--     isSwipedEnd = true
--     local camera = CS.UnityEngine.Camera.main
--     cameraStartPos = camera.transform.position
--     print("UIBattlingCameraSwipeEnd", cameraStartPos.x, cameraStartPos.y, cameraStartPos.z)
-- end
local cameraTempLocalPos = nil
local posStart = nil
local catTempLocalPos = nil
local catTempLocalForward = nil
local catTempLocalUp = nil
local startEular = nil
local openCatFollow = false

local defaultEular = nil
local OnSwipeStart = function (eventData)
    -- print("OnSwipeStart")
    local center = BattleViewMgr.sceneCenter
    --获取ui阶段相机
    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    local uiCamera = SkillCameraMgr.overlayCamera.gameObject
    center.transform.rotation = uiCamera.transform.rotation
    startEular = uiCamera.transform.rotation.eulerAngles
    if isNull(defaultEular) then
        defaultEular = uiCamera.transform.rotation.eulerAngles
    end
    cameraTempLocalPos = center.transform:InverseTransformPoint(uiCamera.transform.position)
    posStart = eventData.position

    if not isNull(BattleViewMgr.unitCat) and openCatFollow then
        catTempLocalPos = uiCamera.transform:InverseTransformPoint(BattleViewMgr.unitCat.transform.position)
        catTempLocalForward = uiCamera.transform:InverseTransformDirection(BattleViewMgr.unitCat.transform.forward)
        catTempLocalUp = uiCamera.transform:InverseTransformDirection(BattleViewMgr.unitCat.transform.up)
    end
end

local NormalizeAngle = function (angle)
    while angle < 0 do
        angle = angle + 360
    end

    while angle >= 360 do
        angle = angle - 360
    end
    return angle
end

local AngleRange = function (angle, min, max)
    local tmpAngle = angle
    local tmpMin = min
    local tmpMax = max
    while min < 0 do
        min = min + 360
    end
    while max < min do
        max = max + 360
    end

    while angle < min do
        angle = angle + 360
    end
    while angle - min > 360 do
        angle = angle - 360
    end
    if angle > max then
        --看看哪个更接近
        local markMin = math.min( (angle - min) % 360, math.abs((angle - min) % 360 - 360) )
        local markMax = math.min( (angle - max) % 360, math.abs((angle - max) % 360 - 360) )
        local result = markMin < markMax and tmpMin or tmpMax
        return result
    end

    return tmpAngle
end

local OnSwipe = function (eventData)
    -- print("OnSwipe")

    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    local uiCamera = SkillCameraMgr.overlayCamera.gameObject
    local center = BattleViewMgr.sceneCenter

    --根据位移差计算出旋转角度，这块可能需要进行一次线性转换
    local posNow = eventData.position

    local dx = posNow.x - posStart.x
    local dy = posNow.y - posStart.y

    local limitHorizontalLeft = BattleViewMgr.sceneVo.limitHorizontalLeft
    local limitHorizontalRight = BattleViewMgr.sceneVo.limitHorizontalRight
    local limitVertical = BattleViewMgr.sceneVo.limitVertical

    local speed = 0.05
    -- local eularX = math.range(startEular.x - dy * speed, 10, defaultEular.x + 40) 
    -- local eularY = math.range(startEular.y + dx * speed, defaultEular.y - 60, defaultEular.y + 60) 
    local eularX = startEular.x - dy * speed
    local eularY = startEular.y + dx * speed

    -- print("eularX", eularX, "min", defaultEular.x - limitVertical, "max", defaultEular.x + limitVertical)
    eularX = AngleRange(eularX, defaultEular.x - limitVertical, defaultEular.x + limitVertical)
    eularY = AngleRange(eularY, defaultEular.y - limitHorizontalRight, defaultEular.y + limitHorizontalLeft)--这里是符号跟常识是反的

    local nowEularX = center.transform.rotation.eulerAngles.x

    local r = Vector3.New( eularX, eularY, startEular.z)
    center.transform.rotation = Quaternion.Euler(r.x, r.y, r.z)
    uiCamera.transform.rotation = center.transform.rotation
    -- center.transform:RotateAroundX(dy * 0.01)
    -- center.transform:RotateAroundY(dx * 0.01)
    local pos = center.transform.localToWorldMatrix:MultiplyPoint(cameraTempLocalPos)
    if pos.y <  BattleViewMgr.sceneVo.limitHeight then
        --取消x轴偏移
        r.x = nowEularX
        center.transform.rotation = Quaternion.Euler(r.x, r.y, r.z)
        uiCamera.transform.rotation = center.transform.rotation
        pos = center.transform.localToWorldMatrix:MultiplyPoint(cameraTempLocalPos)
    end
    uiCamera.transform.position = pos

    if BattleViewMgr.unitCat and openCatFollow then
        local catPos = uiCamera.transform.localToWorldMatrix:MultiplyPoint(catTempLocalPos)
        local catForword = uiCamera.transform:TransformDirection(catTempLocalForward)
        local catUp = uiCamera.transform:TransformDirection(catTempLocalUp)
        BattleViewMgr.unitCat.transform.position = catPos
        BattleViewMgr.unitCat.transform.rotation = Quaternion.LookRotation( Vector3.New(catForword.x, catForword.y, catForword.z), Vector3.New(catUp.x, catUp.y, catUp.z))
    end
end


function  Controller:__init(camp, playerId)
    self.camp = camp
    self.playerId = playerId
    self.inputQueue = {}
    self.baseSeqId = 0
    if BattleInfo:IsUserCamp(self.camp) then
        defaultEular = nil
        Events.AddListener(Constants.EventNames.UIBattlingCameraSwipe, OnSwipe)
        Events.AddListener(Constants.EventNames.UIBattlingCameraSwipeStart, OnSwipeStart)
    end
end


function Controller:__delete(  )
    if BattleInfo:IsUserCamp(self.camp) then
        Events.RemoveListener(Constants.EventNames.UIBattlingCameraSwipe, OnSwipe)
        Events.RemoveListener(Constants.EventNames.UIBattlingCameraSwipeStart, OnSwipeStart)
    end
end


function Controller:OnRequireInput( callback, refInputSkills )
end

function Controller:OnTurnStart( camp )
    
end

function Controller:OnGameStart(  )
end

function Controller:OnTurnEnd( camp )
end

function Controller:OnTrig( trigMainType, trigData, target  )
    
end

function Controller:AddInputQueue(inputType, data)
    local inputData = self:GenerateInputData(inputType, data)
    table.insert(self.inputQueue, inputData)
end

function Controller:GenerateInputData(inputType, data, isReq)
    local inputData = {inputType = inputType, data = DeepCopy(data), playerId = self.playerId, seqId = self.baseSeqId}
    if isNull(isReq) then
        self.baseSeqId = self.baseSeqId + 1
    end
    return inputData
end

function Controller:ClearInputQueue()
    self.inputQueue = {}
end

function Controller:GetMaxCost(  )
    local rs = BattleMgr:GetAliveRoles(self.camp)
    return #rs
end

function Controller:GetCardMgr(role)
    return nil
end

function Controller:AfterOnRequireInput()
    
end

return  Controller