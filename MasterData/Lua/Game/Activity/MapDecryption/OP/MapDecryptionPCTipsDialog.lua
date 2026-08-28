
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait

------------ import ------------


------------ define ------------


------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalExploreTracking.prefab
---@class MapDecryptionPCTipsDialog
---@field Env                           	MapDecryptionPCTipsDialog                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Root                          	UnityEngine.Animation                   
---@field TrackingPanel                 	UnityEngine.RectTransform               
---@field ExplorePanel                  	UnityEngine.RectTransform               
local MapDecryptionPCTipsDialog = Class('MapDecryptionPCTipsDialog')
---@type MaidCoffeeConstants
local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
local MaidCoffeeUtils     = import("Game.MaidCoffee.MaidCoffeeUtils")
function MapDecryptionPCTipsDialog:__init()

end


function MapDecryptionPCTipsDialog:__delete()

end


function MapDecryptionPCTipsDialog:Awake()
    self:AddEventListener()
end

function MapDecryptionPCTipsDialog:AddEventListener()
    self.closePcTipsEvent = Events.AddListener(MaidCoffeeConstants.EventNames.MaidCoffeeClosePcTip,Bind(self,self.OnPcTipClose))
end

function MapDecryptionPCTipsDialog:RemoveEventListener()
    if self.closePcTipsEvent then
        Events.RemoveListener(MaidCoffeeConstants.EventNames.MaidCoffeeClosePcTip,self.closePcTipsEvent)
        self.closePcTipsEvent = nil
    end
end


function MapDecryptionPCTipsDialog:OnFocus(focus)

end


function MapDecryptionPCTipsDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local args = self.controller.Argument.parameters
        self.callBack = args.callback
        -- print(table.toString(args))
        CfUtils.WriteLocalData(args.key, 1)
        --- 进入活动前要使用 自己import
        ---@type MapDecryptionConstants
        local MapDecryptionConstants = import("Game.Activity.MapDecryption.MapDecryptionConstants")
        Events.Broadcast(MapDecryptionConstants.EventNames.ChangeCameraControlMode, Constants.CameraControlMode.None)

    end))
    return coWait
end

function MapDecryptionPCTipsDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CfUtils.CookieSave("MapDecryptionPCTipsDialogOpen",1)
        --MaidCoffeeUtils.MaidCoffeeSetMouseMode(Constants.CameraControlMode.None)
    end))
    return coWait
end

function MapDecryptionPCTipsDialog:OnPcTipClose()
    CS.Engine.UI.UIModule.BackDialog()
end

function MapDecryptionPCTipsDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.callBack then
            self.callBack()
        end
        CfUtils.CookieSave("MapDecryptionPCTipsDialogOpen",0)
        MaidCoffeeUtils.MaidCoffeeSetMouseMode(Constants.CameraControlMode.MoveMouse)
        self:RemoveEventListener()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end



---------------------------------------------------
--- init begin --
---------------------------------------------------



---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------




---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionPCTipsDialog
