---
--- Created by Eric.
--- DateTime: 2021/10/16 15:07
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MazeMgr = import('Game.Maze.MazeMgr'):GetInstance()

------------ import ------------

------------ define ------------
local SwitchStatus = {
    Default = 1,
    Selected = 2,
}
------------ define ------------


---@class PatrolPlotDialog
---@field ClickScreenToClose            	UnityEngine.RectTransform
---@field ImgBg                         	Engine.UI.RawImageAlterable
---@field Text2                         	UnityEngine.UI.Text
---@field BtnOption2                    	Game.Native.Common.UISwitchImage
---@field Text1                         	UnityEngine.UI.Text
---@field BtnOption1                    	Game.Native.Common.UISwitchImage
---@field TxtContent                    	ChapterText
local PatrolPlotDialog = Class("PatrolPlotDialog")
function PatrolPlotDialog:__init()
    self.data = {}
    self.plotData = {}
    self.isSelected = false
end

function PatrolPlotDialog:__delete()
    self.data = nil
    self.plotData = nil
    self.isSelected = nil
    self.controller = nil
end

function PatrolPlotDialog:Awake()

end

function PatrolPlotDialog:OnFocus(focus)
end

function PatrolPlotDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            self.data = argument.parameters.data
            self.plotData = CfUtils.GetCfVo(AutoIds.IdSetting356, "MazeStoryVo", self.data.eventId)

            self:FreshBaseUI()
        end

    end))
    return coWait
end

function PatrolPlotDialog:GetBGPath()
    local floor = MazeMgr.currentFloor
    local suffixName
    if floor <= 15 then
        suffixName = 1
    elseif floor <= 30 then
        suffixName = 2
    elseif floor <= 45 then
        suffixName = 3
    end
    local prefabName = string.format("Arts/Textures/UIBg/patrol_main_bg_%s.png", suffixName)
    return prefabName
end

function PatrolPlotDialog:FreshBaseUI()
    self.TxtContent.text = self.plotData.desc2
    --self.BtnOption1.Status = SwitchStatus.Default
    --self.BtnOption2.Status = SwitchStatus.Default
    self.Text1.text = self.plotData.bottonDesc1
    self.Text2.text = self.plotData.bottonDesc2
    self.ImgBg:LoadSprite(self:GetBGPath())
    SetButtonAction(self.BtnOption1.transform, function ()
        if not self.isSelected then
            self.isSelected = true
            MazeMgr:MazeMoveToEvent(1, function (rewards)
                KTool.SetActive(self.BtnOption1.transform, false)
                KTool.SetActive(self.BtnOption2.transform, false)
                KTool.SetActive(self.ClickScreenToClose, true)
                CfUtils.SetTopActive(false)
                SetButtonAction(self.ClickScreenToClose, function ()
                    UIModule.CloseDialog(self.controller)
                    UIModule.OpenDialog(
                            {
                                id = Constants.UITypeIds.UICommonRewardPop,
                                parameters = { rewards = rewards }
                            }
                    )
                end)
                self.TxtContent.text = self.plotData.desc3
                --self.BtnOption1.Status = SwitchStatus.Selected
            end)
        end
    end)

    SetButtonAction(self.BtnOption2.transform, function ()
        if not self.isSelected then
            self.isSelected = true
            MazeMgr:MazeMoveToEvent(2, function (rewards)
                KTool.SetActive(self.BtnOption1.transform, false)
                KTool.SetActive(self.BtnOption2.transform, false)
                KTool.SetActive(self.ClickScreenToClose, true)
                CfUtils.SetTopActive(false)
                SetButtonAction(self.ClickScreenToClose, function ()
                    UIModule.CloseDialog(self.controller)
                    UIModule.OpenDialog(
                            {
                                id = Constants.UITypeIds.UICommonRewardPop,
                                parameters = { rewards = rewards }
                            }
                    )
                end)
                self.TxtContent.text = self.plotData.desc4
                --self.BtnOption2.Status = SwitchStatus.Selected
            end)
        end
    end)
end



function PatrolPlotDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return PatrolPlotDialog