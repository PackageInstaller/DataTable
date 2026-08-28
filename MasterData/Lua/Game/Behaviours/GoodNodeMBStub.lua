local GoodsNodeMBPath = "Game.Behaviours.GoodNodeMB"
local ReverseScale = CS.Game.Native.Common.ReverseScale

---@class GoodNodeMBStub
---@field Env                           	GoodNodeMBStub
---@field controller                    	Engine.Modules.LuaBehaviour
---@field GoodNodeStub                  	Engine.Modules.LuaStub                  	@ 0
---@field goodNode                      	UnityEngine.Transform
---@field goodNodeMB                    	GoodNodeMB  
local GoodNodeMBStub = Class("GoodNodeMBStub")

function GoodNodeMBStub:__init()
    self.controller = nil
end

function GoodNodeMBStub:__delete()
    self.controller = nil
end

function GoodNodeMBStub:Init()
    if self.inited then
        return
    end
    self.inited = true
    if isNull(self.GoodNodeStub) then
        self.GoodNodeStub = self.controller:FindGameObject("GoodNodeStub")
    end

    if isNull(self.GoodNodeStub) then
        printError("GoodNodeStub is nil")
        return
    end
end

---@param data GoodNodeMB.InputData
function GoodNodeMBStub:Reload(data,scale)
    if isNull(self.goodNode) then
        self.goodNode = self.GoodNodeStub:InstantiatePrefab("GoodNode")
        local rect = self.goodNode.gameObject:GetComponent("RectTransform")
        rect.pivot = Vector2.New(0.5, 0.5)
        rect.anchoredPosition = Vector3.New(0, 0, 0)
        rect.anchorMax = Vector2.New(0.5, 0.5)
        rect.anchorMin = Vector2.New(0.5, 0.5)
        CfUtils.SetActive(self.goodNode.gameObject, true)
    end

    if scale then
        local reScale = self.goodNode.gameObject:GetComponent(typeof(ReverseScale))
        reScale.scale = scale
        reScale:ResetScale()
    end
    
    self.goodNodeMB = CfUtils.GetLuaScr(self.goodNode, GoodsNodeMBPath)
    self.goodNodeMB:Reload(data)
end

--其他功能

function GoodNodeMBStub:OnDestroy()
    self:Delete()
end

return GoodNodeMBStub

