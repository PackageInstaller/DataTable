------------ import ------------
local UIModule = CS.Engine.UI.UIModule
local util = require "XLua.util"
local CoWait = CS.Engine.Lib.CoWait
local Yielders = CS.Engine.Lib.Yielders
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
------------ import ------------

---@class UIBattlingWaveChangeDialog
---@field DefaultNode                   	UnityEngine.Animation
---@field Container                     	UnityEngine.CanvasGroup
---@field Txt_Part_3red                 	UnityEngine.UI.Text
---@field Txt_Part_3blue                	UnityEngine.UI.Text
---@field Txt_WaveNow                   	UnityEngine.UI.Text
---@field Txt_NumRount                  	UnityEngine.UI.Text
local UIBattlingWaveChangeDialog = Class("UIBattlingWaveChangeDialog")

function UIBattlingWaveChangeDialog:__init()
    self.numWaveNow = 0
end

function UIBattlingWaveChangeDialog:__delete()
    self.numWaveNow = nil
    self.controller = nil
    self = nil
end

function UIBattlingWaveChangeDialog:Awake()
    ---@type Engine.UI.UIArgument
    local argument = self.controller.Argument
    if not IsNull(argument.parameters) then
        self.numWaveNow = argument.parameters.numWaveNow
    end
end

function UIBattlingWaveChangeDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function()
                --self:AnimationSimple()
                coroutine.yield(Yielders.GetWaitForSeconds(1.5))
                UIModule.CloseDialog(self.controller)
            end
        )
    )
    return coWait
end

function UIBattlingWaveChangeDialog:OnInitialize()
    xTry(function()
        local strNumWave = localize("第_num_波", {_num_ = self.numWaveNow})
        self.Txt_WaveNow.text = strNumWave
        self.Txt_Part_3red.text = strNumWave
        self.Txt_Part_3blue.text = strNumWave
        local numRound = UIBattlingCtrlMgr:GetInstance():GetPlayerTeamRoundsNum()
        self.Txt_NumRount.text = localize("第_num_回合", {_num_ = numRound})
    end)
end

function UIBattlingWaveChangeDialog:OnFinalize()
    xTry(function()
        UIBattlingCtrlMgr:GetInstance():SetBooleanWaveDialogShowState(false)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

function UIBattlingWaveChangeDialog:AnimationSimple()
    if not IsNull(self.DefaultNode) then
        self.DefaultNode:Play("UIBattlingWaveChangeDialog")
    end
end

return UIBattlingWaveChangeDialog
