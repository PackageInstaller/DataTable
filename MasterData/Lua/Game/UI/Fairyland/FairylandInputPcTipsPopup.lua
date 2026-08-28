---
--- 乱流幻境操作提示弹窗
--- Author: dawanfan
--- Date: 2024-2-2 13:53:35
---

local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait

---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')
local KeyboardInfo = DreamSpaceStates.KeyboardInfo
local KeyboardInputMap = import("Game.DreamSpace.CharacterController.KeyboardInputMap")

local UIModule = CS.Engine.UI.UIModule
local UIEventProxy = CS.Engine.UI.UIEventProxy

--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandInputPcTipsPopup.prefab > name: ActionFairylandInputPcTipsPopup
---@class FairylandInputPcTipsPopup
---@field Env                           	FairylandInputPcTipsPopup               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               	0    
local FairylandInputPcTipsPopup = Class("FairylandInputPcTipsPopup")

function FairylandInputPcTipsPopup:__init()
    
end

function FairylandInputPcTipsPopup:__delete()
    
end

function FairylandInputPcTipsPopup:Awake()
    UIEventProxy.Create(self.BtnClose.gameObject).onPointerClick = function()
        ---Close
        self:Close()
    end
end

function FairylandInputPcTipsPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local args = self.controller.Argument.parameters
        self.callBack = args.callback

    end))
    return coWait
end

function FairylandInputPcTipsPopup:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RegisterInputFunc()
    end))
    return coWait
end

function FairylandInputPcTipsPopup:OnHide()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:UnRegisterInputFunc()
    end))
    return coWait
end

function FairylandInputPcTipsPopup:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        if self.callBack then
            self.callBack()
        end
        
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end

function FairylandInputPcTipsPopup:Close()
    local keyboardInputMap = KeyboardInputMap:GetInstance()
    keyboardInputMap:UnRegisterInput(KeyboardInfo.PcTipsKey)

    UIModule.OpenDialog({id=Constants.UITypeIds.FairylandSceneDialog, parameters={}}, {
        { id = Constants.UITypeIds.FairylandInputPcTipsPopup },
        { id = Constants.UITypeIds.FairylandFinishPopup}
    }, false)
end

function FairylandInputPcTipsPopup:RegisterInputFunc()
    local keyboardInputMap = KeyboardInputMap:GetInstance()

    keyboardInputMap:RegisterInput(KeyboardInfo.PcTipsKey, Bind(self, self.Close))
end

function FairylandInputPcTipsPopup:UnRegisterInputFunc()
    
end

return FairylandInputPcTipsPopup
