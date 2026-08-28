---
--- 乱流幻境结束弹窗
--- Author: dawanfan
--- Date: 2024-1-25 18:31:42
---

local util = require 'XLua.util'

local UIModule = CS.Engine.UI.UIModule
local CoWait = CS.Engine.Lib.CoWait
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local UIEventProxy = CS.Engine.UI.UIEventProxy


--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandFinishPopup.prefab > name: ActionFairylandFinishPopup
---@class FairylandFinishPopupDialog
---@field Env                           	FairylandFinishPopupDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               
---@field DetailGroup                   	UnityEngine.RectTransform               
local FairylandFinishPopupDialog = Class("FairylandFinishPopupDialog")

function FairylandFinishPopupDialog:__init()
    
end

function FairylandFinishPopupDialog:__delete()
    
end

function FairylandFinishPopupDialog:Awake()
    -- SetButtonAction(self.BtnClose, Bind(self, self.OnClose))
    UIEventProxy.Create(self.BtnClose.gameObject).onPointerClick = function()
        ---Close
        self:OnBtnCloseClick()
    end
end

function FairylandFinishPopupDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        for index, suffix in pairs({["1"] = "1", ["2"] = "2", ["3"] = "3", [tostring(Constants.SpecialQuestId.Mirror)]="Boss"}) do
            local itemGo = self.DetailGroup:Find("DetailItem" .. suffix)
            if itemGo then
                local luaScr = CfUtils.GetLuaScr(itemGo, "Game.UI.Fairyland.FairylandFinishPopupDetailItem")
                if luaScr then
                    luaScr:Initialize(index)
                end
            end
        end
    end))
    return coWait
end

-- function FairylandFinishPopupDialog:OnInitialize()
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
--     end))
--     return coWait
-- end

function FairylandFinishPopupDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self:OnClose()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function FairylandFinishPopupDialog:OnBtnCloseClick()
    UIModule.CloseDialog(self.controller)
end

function FairylandFinishPopupDialog:OnClose()
    FairylandUtils.ShowFinish = false
    -- FairylandUtils.Finish = false
    UIModule.OpenDialog({id=Constants.UITypeIds.FairylandSceneDialog}, {}, false)
end

return FairylandFinishPopupDialog
