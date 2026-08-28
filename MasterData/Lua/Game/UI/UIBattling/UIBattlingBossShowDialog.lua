------------ import ------------
local util = require "XLua.util"
local cs_coroutine = require("XLua.cs_coroutine")
local CoWait = CS.Engine.Lib.CoWait
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders
------------ import ------------

------------ define ------------
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/UIBattlingBossShowDialog.prefab
---@class UIBattlingBossShowDialog
---@field Env                           	UIBattlingBossShowDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Txt_Name                      	UnityEngine.UI.Text                     
local UIBattlingBossShowDialog = Class("UIBattlingBossShowDialog")

function UIBattlingBossShowDialog:__init()
    self.co_show = nil
    self.bossInfo = nil
end

function UIBattlingBossShowDialog:__delete()
    self.co_show = nil
    self.bossInfo = nil
    self.controller = nil
    self = nil
end

function UIBattlingBossShowDialog:Awake()
    ---@type Engine.UI.UIArgument
    local argument = self.controller.Argument
    self.bossInfo = argument.parameters.bossInfo
end

function UIBattlingBossShowDialog:OnShow()
    xTry(function()
        local cardSkinVo = CardConfMgr:GetCardSkinBySkinId(self.bossInfo.skinId)
        local cardName = cardSkinVo.name
        cardName = string.isEmpty(cardName) and "" or cardName
        self.Txt_Name.text = cardName
        self:Show()
    end)
end

function UIBattlingBossShowDialog:OnInitialize()
end

function UIBattlingBossShowDialog:OnFinalize()
    xTry(function()
        -- print("->UIBattlingBossShowDialog:OnFinalize")

        if not isNull(self.co_show) then
            cs_coroutine.stop(self.co_show)
            self.co_show = nil
        end
        
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

function UIBattlingBossShowDialog:Show()
    self.co_show = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(5))
        UIModule.CloseDialog(self.controller)
        self.co_show = nil
    end)
end

return UIBattlingBossShowDialog
