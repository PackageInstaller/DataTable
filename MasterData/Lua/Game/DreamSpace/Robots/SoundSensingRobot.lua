---
--- 声音感应机器人
--- Author: dawanfan
--- Date: 2024-3-21 17:11:19
---

local cs_coroutine = import("XLua.cs_coroutine")
local KTool = CS.Engine.Lib.KTool
local BehaviourAction = CS.Engine.Lib.BehaviourAction


---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

local Vector3 = CS.UnityEngine.Vector3
local Time = CS.UnityEngine.Time
local Rigidbody = CS.UnityEngine.Rigidbody


--- from:  > name: Robot
---@class SoundSensingRobot
---@field Env                           	SoundSensingRobot                       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Trigger                       	UnityEngine.Transform                   	@ 0    
---@field Arrow                         	UnityEngine.Transform                   	@ 1    
local SoundSensingRobot = Class("SoundSensingRobot")

function SoundSensingRobot:__init()
    self._moveCo = nil
end

function SoundSensingRobot:__delete()
    self._moveCo = nil
end

function SoundSensingRobot:OnDestroy()
    Events.RemoveListener(DreamSpaceStates.EventNames.OnMeow, self.__OnMeowSensing)
end

function SoundSensingRobot:Awake()
    self:Init()
end

function SoundSensingRobot:Init()

    self.__OnMeowSensing = Bind(self, self.OnMeowSensing)
    Events.AddListener(DreamSpaceStates.EventNames.OnMeow, self.__OnMeowSensing)

    self.params = KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters))
    self.moveDistance = LuaParametersReader.Read(self.params, "MoveDistance", LuaParametersType.Float)
    self.moveSpeed = LuaParametersReader.Read(self.params, "MoveSpeed", LuaParametersType.Float)


    local triggerBehaviour = KTool.GetComponent(self.Trigger.gameObject, typeof(BehaviourAction))

    if triggerBehaviour then
        triggerBehaviour.OnTriggerEnterAction = function(behaviourAction, other_)
            self:OnTriggerEnter(other_)
        end

        triggerBehaviour.OnTriggerExitAction = function(behaviourAction, other_)
            self:OnTriggerExit(other_)
        end
    else
        printError("[SoundSensingRobot][Init] trigger Behaviour not exist")
    end

    self.cat = nil
    self.dir = Vector3.zero

    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    behaviourAction.UpdateAction = function (behaviourAction)
        self:Update()
    end
end

function SoundSensingRobot:Update()
    if self.cat == nil then
        return
    end

    self:UpdateMoveDir()

end

function SoundSensingRobot:UpdateMoveDir()
    ---@type UnityEngine.Vector3
    local dir = (self.cat.transform.position - self.controller.transform.position).normalized
    dir.y = 0

    if math.abs(dir.x) >= math.abs(dir.z) then
        dir.z = 0
    else
        dir.x = 0
    end

    self.dir = dir.normalized
    
    self.Arrow.forward = self.dir
end

function SoundSensingRobot:OnMeowSensing()
    if self.cat == nil then
        return
    end

    self.controller.transform.forward = self.dir

    if self._moveCo ~= nil then
        cs_coroutine.stop(self._moveCo)
    end

    self._moveCo = cs_coroutine.start(function ()
        local dir = self.dir
        local targetTime = self.moveDistance / self.moveSpeed
        local time = 0
        ---@type UnityEngine.Rigidbody
        local rigidbody = KTool.GetComponent(self.controller.gameObject, typeof(Rigidbody))


        while time < targetTime do
            local deltaTime = Time.deltaTime
            -- local targetPosition = self.controller.transform.position + dir * self.moveSpeed * deltaTime
            -- rigidbody:MovePosition(targetPosition)
            rigidbody.velocity = self.moveSpeed * dir
            time = time + deltaTime
            cs_coroutine.yield_return()
        end

        rigidbody.velocity = Vector3.zero
    end)
end

function SoundSensingRobot:OnTriggerEnter(other_)
    print("Trigger Enter")
    if other_.gameObject.tag == "Player" then
        self.cat = other_.gameObject
    end
end

function SoundSensingRobot:OnTriggerExit(other_)
    print("Trigger Exit")
    if other_.gameObject == self.cat then
        self.cat = nil
    end
end

return SoundSensingRobot
