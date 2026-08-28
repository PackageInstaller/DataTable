---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'
local ResourceModule = CS.Engine.Modules.ResourceModule
local Animator = CS.UnityEngine.Animator
local GameObject          = CS.UnityEngine.GameObject
local ActivityConstants = import("Game.Activity.ActivityConstants")
local StoreChestDojo = import('Game.Dojo.StoreChestDojo')
local StoreConstants = import('Game.UI.Store.StoreConstants')
local StoreUtils = import('Game.UI.Store.StoreUtils')
local TimerModule = CS.Engine.Modules.TimerModule

------------ import ------------

------------ define ------------

------------ define ------------



--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalStoreRedBagPopup.prefab
---@class SpringFestivalStoreRedBag
---@field Env                           	SpringFestivalStoreRedBag
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtName                       	UnityEngine.RectTransform
---@field TxtContent                    	UnityEngine.RectTransform
---@field TxtTitle                      	UnityEngine.RectTransform
---@field ImgNpcIcon                    	UnityEngine.RectTransform
local SpringFestivalStoreRedBag = Class("SpringFestivalStoreRedBag")
function SpringFestivalStoreRedBag:__init()
    self.cb = nil   
    
end

function SpringFestivalStoreRedBag:__delete()
    self.cb = nil


    self.controller = nil
end

function SpringFestivalStoreRedBag:Awake()


end

function SpringFestivalStoreRedBag:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        
    end))
    return coWait
end

function SpringFestivalStoreRedBag:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local parameters        = self.controller.Argument.parameters
        self.cb = parameters.cb
        local data = parameters.data
        CfUtils.FillImage(self.ImgNpcIcon, data.picture)
        CfUtils.FillText(self.TxtTitle, data.title)
        CfUtils.FillText(self.TxtContent, data.desc)
        CfUtils.FillText(self.TxtName, data.name)
        SetButtonAction(self.ImgBlack.gameObject, function()
            UIModule.BackDialog()
        end)
    end))
    return coWait
end


function SpringFestivalStoreRedBag:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.cb then
            self.cb()
        end
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SpringFestivalStoreRedBag