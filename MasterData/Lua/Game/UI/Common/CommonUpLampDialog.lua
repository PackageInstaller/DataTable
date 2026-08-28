---
--- 跑马灯 UI
--- Author: dawanfan
--- Date: 2024-3-6 11:44:32
---


local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local cs_coroutine = import("XLua.cs_coroutine")
local Vector3 = CS.UnityEngine.Vector3
local Time = CS.UnityEngine.Time
local Yielders = CS.Engine.Lib.Yielders


---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

---@type MessageTickerComponent
local messageTickerComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MessageTickerComponent)


--- from:  > name: CommonUpLampDialog
---@class CommonUpLampDialog
---@field Env                           	CommonUpLampDialog                      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtDetails                    	UnityEngine.RectTransform               	@ 0    
---@field Mask                          	UnityEngine.RectTransform               	@ 1    
---@field Node                          	UnityEngine.RectTransform               	@ 2    
local CommonUpLampDialog = Class("CommonUpLampDialog")

function CommonUpLampDialog:__init()
    self.co = nil
    self.inPlay = false
    
    ---@type MessageTickerData
    self.currentMessage = nil
end

function CommonUpLampDialog:__delete()
    self.controller = nil
    self.currentMessage = nil
end

function CommonUpLampDialog:Awake()
    self.params = KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters))
    self.loopTime = LuaParametersReader.Read(self.params, "loopTime", LuaParametersType.Float)
    self.loopSpeed = LuaParametersReader.Read(self.params, "loopSpeed", LuaParametersType.Float)

    self.co = cs_coroutine.start(
        self._CoCheckNeedPlayMessage, self
    )
end


function CommonUpLampDialog:PlayMessage()
    if self.inPlay then
        return
    end

    if self.co ~= nil then
        cs_coroutine.stop(self.co)
    end

    self.co = cs_coroutine.start(
        self._CoPlayMessage, self
    )
end

function CommonUpLampDialog:_CoPlayMessage()
    self.inPlay = true

    CfUtils.SetActive(self.Node, true)

    self.currentMessage, _ = messageTickerComponent.pendingList:Dequeue()

    while self.currentMessage ~= nil do
        
        CfUtils.FillText(self.TxtDetails, self.currentMessage.msg)

        cs_coroutine.yield_return()

        if self.currentMessage.roundGap == 0 then
            while self.currentMessage.round > 0 do
                cs_coroutine.yield_return(self:_CoScrollText(self.currentMessage))
                self.currentMessage.round = self.currentMessage.round - 1

                if not messageTickerComponent:CheckShowType(self.currentMessage.messageShowType) then
                    break
                end
            end
        else
            cs_coroutine.yield_return(self:_CoScrollText(self.currentMessage))
            self.currentMessage.round = self.currentMessage.round - 1
        end
        
        if self.currentMessage.round > 0 then
            self.currentMessage.playTime = self.currentMessage.playTime + self.currentMessage.roundGap
            messageTickerComponent._messageWaitList:AddLast(self.currentMessage)
        end

        self.currentMessage, _ = messageTickerComponent.pendingList:Dequeue()
    end

    CfUtils.WaitPlayAnimationTo(self.Node, "CommonUpLampNode_Out", function()
        self.inPlay = false
        CfUtils.SetActive(self.Node, false)
        self.co = cs_coroutine.start(self._CoCheckNeedPlayMessage, self)
    end)
end


function CommonUpLampDialog:_CoCheckNeedPlayMessage()
    
    while true do
        
        if messageTickerComponent:AddMessageToPendlingList() then
            self:PlayMessage()
            return
        end

        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
    end
    
end

---@param value MessageTickerData
function CommonUpLampDialog:_CoScrollText(value)
    local posX = self.Mask.rect.width
    local textWidth = self.TxtDetails.rect.width

    local startPosition = Vector3(posX, 0, 0)
    local targetPosition = Vector3(-textWidth, 0, 0)
    local position = startPosition

    local speed = self.loopSpeed * value.loopTime
    while position.x >= targetPosition.x do
        position.x =  position.x - Time.deltaTime * speed
        self.TxtDetails.anchoredPosition3D = position
        cs_coroutine.yield_return()
    end
end

function CommonUpLampDialog:Destroy()
    if self.co then
        cs_coroutine.stop(self.co)
    end
end

return CommonUpLampDialog
