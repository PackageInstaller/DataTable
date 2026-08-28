---
--- 社团大厅，相机旋转控制
--- Author: dawanfan
--- Date: 2024-4-24 18:02:38
---


---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type 
local LuaParameters = CS.Engine.Modules.LuaParameters


local KeyCode = CS.UnityEngine.KeyCode
local Input = CS.UnityEngine.Input
local Screen = CS.UnityEngine.Screen
local Time = CS.UnityEngine.Time
local Mathf = CS.UnityEngine.Mathf
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Vector3 = CS.UnityEngine.Vector3
local EasyTouch = CS.HedgehogTeam.EasyTouch.EasyTouch

local DreamSpaceStates = import("Game.DreamSpace.Tools.DreamSpaceStates")


local RotateState =
{ 
    Manual = 1,         -- 玩家手操旋转
    AutoFollow = 2,     -- 自动跟随, 仿 SimpleFollowWithWorldUp
    ReturnToOrigin = 3  -- 双击屏幕, 视角自动回中  == 目前弃用
}


local isActive = true


--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubPlayerController.prefab > name: ViewRotateController
---@class OverseaClubViewRotateController
---@field Env                           	OverseaClubViewRotateController         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field vcamControllerTF              	UnityEngine.Transform                   	@ 0    
---@field autoFollowBH                  	Engine.Modules.LuaBehaviour             	@ 1    
---@field follow                        	UnityEngine.Transform                   	@ 2    
---@field vcam3rdPersonFollow           	Cinemachine.CinemachineVirtualCamera    	@ 3    
local OverseaClubViewRotateController = Class("OverseaClubViewRotateController")

function OverseaClubViewRotateController:__init()
    self.controller = nil
    self._isInit = false
    self.autoFollow = nil

    self.lastVTargetPos = Vector3.zero
    self.lastVCamPos = Vector3.zero
end

function OverseaClubViewRotateController:__delete()
    
end

function OverseaClubViewRotateController:OnDestroy()

    self:UnregistEvent()
    EasyTouch.instance.alwaysSendSwipe = false -- clear

    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
end

function OverseaClubViewRotateController:Start()
    KTool.SetActive(self.controller.gameObject, true)

    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.LateUpdateAction = function(behaviourAction)
            self:LateUpdate()
        end
    end
end

function OverseaClubViewRotateController:Init(isUseManualViwRotateInPCMode_ )

    assert( self.follow and self.autoFollowBH )
    assert(self.vcam3rdPersonFollow)

    self.isUseManualViwRotateInPCMode = isUseManualViwRotateInPCMode_

    ---@type OverseaClubAutoFollow
    self.autoFollow = CfUtils.GetLuaScr(self.autoFollowBH, "Game.UI.Club.Controller.OverseaClubAutoFollow" )
    assert( self.autoFollow )
    ----
    assert( self.vcamControllerTF )
    ---@type OverseaClubVCam3rdPersonFollowController
    self.vcam3rdPersonFollowControllerEnv = CfUtils.GetLuaScr(self.vcamControllerTF, "Game.UI.Club.Controller.OverseaClubVCam3rdPersonFollowController" )
    assert( self.vcam3rdPersonFollowControllerEnv )


    self.params = KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters))
    assert( self.params )


    self.rotateScale = LuaParametersReader.Read( self.params, "rotateScale", LuaParametersType.Float ) -- 0.5
    self.rotateScale = Mathf.Clamp(self.rotateScale, 0.0001, 1)

    -- 限制俯仰角上下界, (数值区间于虚拟相机相同)
    local pitchMinDegree = LuaParametersReader.Read( self.params, "pitchMinDegree", LuaParametersType.Float ) -- 0.1
    local pitchMaxDegree = LuaParametersReader.Read( self.params, "pitchMaxDegree", LuaParametersType.Float ) -- 0.9
    assert( type(pitchMinDegree) == "number" and type(pitchMaxDegree) == "number" )
    self.vcam3rdPersonFollowControllerEnv:SetPitchDegree( pitchMinDegree, pitchMaxDegree )


    self.rightScreenRegionPercent = LuaParametersReader.Read( self.params, "rightScreenRegionPercent", LuaParametersType.Float ) -- 0.6
    -- 当需要在 pc端模拟 移动端视角旋转时, 要把整个屏幕的划动权都开放给玩家:
    if DreamSpaceStates.isWindowsPlatform == true and self.isUseManualViwRotateInPCMode == true then 
        self.rightScreenRegionPercent = 1.0
    end 

    self.isFlipInXAxis = LuaParametersReader.Read( self.params, "isFlipInXAxis", LuaParametersType.Bool ) -- 玩家手动旋转视角时, 反转方向
    self.isFlipInYAxis = LuaParametersReader.Read( self.params, "isFlipInYAxis", LuaParametersType.Bool ) -- 玩家手动旋转视角时, 反转方向

    ------------------------------------
    self.lastVTargetPos = self.follow.position
    self.lastVCamPos = self.vcam3rdPersonFollow.transform.position

    self:SetRotateState(RotateState.AutoFollow)

    self.autoFollow:Init(self.vcam3rdPersonFollow, self)

    self:RegistEvent()

    EasyTouch.SetEnableAutoSelect(true)
    EasyTouch.instance.alwaysSendSwipe = true

    
    ---
    self._isInit = true
end

function OverseaClubViewRotateController:LateUpdate()
    if self._isInit ~= true then 
        return
    end 

    self.isPressAlt = (Input.GetKey(KeyCode.LeftAlt) == true or Input.GetKey(KeyCode.RightAlt) == true)
    if DreamSpaceStates.isWindowsPlatform == true then

        if DreamSpaceStates.IsViewRotateForbidden() == false then 

            -- 如果在 pc模式设置为 CursorLockMode.None, 此时存在两份旋转:
            --   (1) 鼠标左键滑动屏幕实现的旋转
            --   (2) 鼠标位移导致的旋转, 就是下方代码实现的
            -- 通过下面这个开关, 可以关掉 (2), 从而在 pc端实现类似移动端的 视角旋转操作;
            if self.isUseManualViwRotateInPCMode ~= true then 
                -- !!! pc模式 写入旋转值:
                local mouseX = Input.GetAxis("Mouse X")
                local mouseY = Input.GetAxis("Mouse Y")
                local ss = 10 
                self.vcam3rdPersonFollowControllerEnv:Rotate(
                    mouseX * self.rotateScale * ss * 0.3 * (self.isFlipInXAxis and -1 or 1),
                    mouseY* self.rotateScale * ss * -0.15 * (self.isFlipInYAxis and -1 or 1)
                )
            end 
        end

    else

        if self.rotateState == RotateState.AutoFollow then
            self.autoYawDelayTime = self.autoYawDelayTime + Time.deltaTime
            self.autoFollow:AutoYaw(self.autoYawDelayTime)

            if self:IsVTargetMoving() then
                self.autoPitchDelayTime = self.autoPitchDelayTime + Time.deltaTime
                self.autoFollow:AutoPitch(self.autoPitchDelayTime)
            else
                self.autoPitchDelayTime = 0
                --self:StopRotateY(self.vcamNormal)
            end
        elseif self.rotateState == RotateState.ReturnToOrigin then
            --self.returnToOrigin:DoReturn()
        end

        self.lastVTargetPos = self.follow.position
        self.lastVCamPos = self.vcam3rdPersonFollow.transform.position

    end
end

function OverseaClubViewRotateController.SetIsActive( isActive_ )
    isActive = isActive_
end



function OverseaClubViewRotateController:RegistEvent()
    self.OnSwipeActionEventFunc = function( gesture )
        self:OnSwipeActionEvent( gesture )
    end
    EasyTouch.On_SwipeStart( '+', self.OnSwipeActionEventFunc )
    EasyTouch.On_Swipe(      '+', self.OnSwipeActionEventFunc )
    EasyTouch.On_SwipeEnd(   '+', self.OnSwipeActionEventFunc )
end


function OverseaClubViewRotateController:UnregistEvent()
    EasyTouch.On_SwipeStart( '-', self.OnSwipeActionEventFunc )
    EasyTouch.On_Swipe(      '-', self.OnSwipeActionEventFunc )
    EasyTouch.On_SwipeEnd(   '-', self.OnSwipeActionEventFunc )
    self.OnSwipeActionEventFunc = nil
end


function OverseaClubViewRotateController:OnSwipeActionEvent(gesture)
    if isActive == false then
        return
    end

    -- !!! 玩家手按 alt 键时, 强制停止视角旋转
    if self.isPressAlt == true then 
        return
    end

    if DreamSpaceStates.IsViewRotateForbidden() == true then
        print( "koko --- 本帧阻止玩家滑动屏幕 旋转视角 ---" )
        self.isValidSwipe = false
        self:SetRotateState(RotateState.AutoFollow)
        return
    end


    if gesture.type == EasyTouch.EvtType.On_SwipeStart then
        self.isValidSwipe = self:IsInRightScreenRegion(gesture.position)

        if self.isValidSwipe then
            self:SetRotateState(RotateState.Manual)
        end
        return
    end
    
    if self.isValidSwipe == false then
        return
    end
    
    if gesture.type == EasyTouch.EvtType.On_Swipe then

        -- !!! 移动模式 写入旋转值:
        self.vcam3rdPersonFollowControllerEnv:Rotate(
            gesture.deltaPosition.x * self.rotateScale * 0.3 * (self.isFlipInXAxis and -1 or 1),
            gesture.deltaPosition.y * self.rotateScale * -0.15 * (self.isFlipInYAxis and -1 or 1)
        )

    elseif gesture.type == EasyTouch.EvtType.On_SwipeEnd then
        self.isValidSwipe = false
        self:SetRotateState(RotateState.AutoFollow)
    end
end



function OverseaClubViewRotateController:SetRotateState(state_)
    self.rotateState = state_
    if state_ == RotateState.AutoFollow then
        self.autoYawDelayTime = 0
        self.autoPitchDelayTime = 0
    end
end


function OverseaClubViewRotateController:IsInRightScreenRegion(uiPos_)
    return uiPos_.x > Screen.width * (1 - self.rightScreenRegionPercent)
end



function OverseaClubViewRotateController:RotateX( val_)
    -- local xAxis = vcam_.m_XAxis
    -- xAxis.m_InputAxisValue = val_
    -- vcam_.m_XAxis = xAxis
    self.vcam3rdPersonFollowControllerEnv:Rotate(
        val_ * 3 * (self.isFlipInXAxis and -1 or 1),
        0
    )
end


function OverseaClubViewRotateController:RotateY( val_)
    -- local yAxis = vcam_.m_YAxis
    -- yAxis.m_InputAxisValue = val_
    -- vcam_.m_YAxis = yAxis
    self.vcam3rdPersonFollowControllerEnv:Rotate(
        0,
        val_ * -1 * (self.isFlipInYAxis and -1 or 1)
    )
end


function OverseaClubViewRotateController:GetLastVTargetPos()
    return self.lastVTargetPos
end


function OverseaClubViewRotateController:GetLastVCamPos()
    return self.lastVCamPos
end


function OverseaClubViewRotateController:IsVTargetMoving()
    local move = self.follow.position - self.lastVTargetPos
    return Vector3.Dot(move, move) > 0.0001
end


return OverseaClubViewRotateController
