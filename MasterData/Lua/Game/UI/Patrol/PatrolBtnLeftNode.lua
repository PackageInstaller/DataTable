---
--- Created by Eric.
--- DateTime: 2021/10/12 11:53
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CanvasGroup = CS.UnityEngine.CanvasGroup

------------ import ------------

------------ define ------------
local OpenType = {
    BackPack = 1,
    Team = 2,
    Status = 3,
}
------------ define ------------


---@class PatrolBtnLeftNode
---@field TeamPanel                     	UnityEngine.RectTransform
---@field BackpackPanel                 	UnityEngine.RectTransform
---@field BuffPreviewPanel              	UnityEngine.RectTransform
---@field ImgBlack                      	UnityEngine.RectTransform
---@field BtnLeftPanel                  	UnityEngine.RectTransform
---@field BtnStatus                     	UnityEngine.RectTransform
---@field BtnTeam                       	UnityEngine.RectTransform
---@field BtnBackpack                   	UnityEngine.RectTransform
local PatrolBtnLeftNode = Class("PatrolBtnLeftNode")
function PatrolBtnLeftNode:__init()
    self.teamPanelEnv = nil
    self.buffPreviewPanelEnv = nil
    self.backpackPanelEnv = nil
end

function PatrolBtnLeftNode:__delete()
    self.teamPanelEnv = nil
    self.buffPreviewPanelEnv = nil
    self.backpackPanelEnv = nil

    self.controller = nil
end

function PatrolBtnLeftNode:Awake()
    KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, true)
    self.EventUseItem = Events.AddListener(Constants.EventNames.PatrolEventUseItem, function()
        self:OpenTargetPanel(self.controller.Argument.parameters.type)
    end)

    if isNull(self.teamPanelEnv) then
        self.teamPanelEnv = CfUtils.GetLuaScr(self.TeamPanel, "Game.UI.Patrol.PatrolTeamPanel")
    end
    if isNull(self.buffPreviewPanelEnv) then
        self.buffPreviewPanelEnv = CfUtils.GetLuaScr(self.BuffPreviewPanel, "Game.UI.Patrol.PatrolBuffPreviewPanel")
    end
    if isNull(self.backpackPanelEnv) then
        self.backpackPanelEnv = CfUtils.GetLuaScr(self.BackpackPanel, "Game.UI.Patrol.PatrolBackpackPanel")
    end
    KTool.GetOrAddComponent(self.ImgBlack.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        UIModule.BackDialog()
    end
    SetButtonAction(self.BtnBackpack, function ()
        self.controller.Argument.parameters.type = OpenType.BackPack
        self:OpenTargetPanel(OpenType.BackPack)
    end)
    SetButtonAction(self.BtnStatus, function ()
        self.controller.Argument.parameters.type = OpenType.Status
        self:OpenTargetPanel(OpenType.Status)
    end)
    SetButtonAction(self.BtnTeam, function ()
        self.controller.Argument.parameters.type = OpenType.Team
        self:OpenTargetPanel(OpenType.Team)
    end)
end


function PatrolBtnLeftNode:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            self.type = argument.parameters.type
            self:OpenTargetPanel(self.type)

        end
    end))
    return coWait
end

function PatrolBtnLeftNode:OpenTargetPanel(type)
    type = checkNumber(type)
    local isBackPack = type == OpenType.BackPack
    local isTeam = type == OpenType.Team
    local isStatus = type == OpenType.Status
    --KTool.SetActive(self.BtnLeftPanel, true)
    KTool.SetActive(self.BackpackPanel, isBackPack)
    KTool.SetActive(self.BuffPreviewPanel, isStatus)
    KTool.SetActive(self.TeamPanel, isTeam)
    self.BtnBackpack.gameObject:EnsureComponent(typeof(CanvasGroup)).alpha = isBackPack and 1 or 0.3
    self.BtnStatus.gameObject:EnsureComponent(typeof(CanvasGroup)).alpha = isStatus and 1 or 0.3
    self.BtnTeam.gameObject:EnsureComponent(typeof(CanvasGroup)).alpha = isTeam and 1 or 0.3

    if isBackPack then
        self.backpackPanelEnv:FreshBaseUI()
    elseif isTeam then
        self.teamPanelEnv:FreshBaseUI()
    elseif isStatus then
        self.buffPreviewPanelEnv:FreshBaseUI()
    end

end

function PatrolBtnLeftNode:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.PatrolEventUseItem, self.EventUseItem)
        KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, false)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return PatrolBtnLeftNode