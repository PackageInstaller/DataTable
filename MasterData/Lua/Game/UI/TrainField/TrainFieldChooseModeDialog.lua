---
--- Created by Eric.
--- DateTime: 2022/2/16 11:40
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine      = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

------------ import ------------

------------ define ------------

------------ define ------------


---@class TrainFieldChooseModeDialog
---@field Node3                         	UnityEngine.RectTransform
---@field Node2                         	UnityEngine.RectTransform
---@field Node1                         	UnityEngine.RectTransform
---@field BtnRecord                     	UnityEngine.RectTransform
---@field BtnRank                       	UnityEngine.RectTransform
local TrainFieldChooseModeDialog = Class("TrainFieldChooseModeDialog")
function TrainFieldChooseModeDialog:__init()
    self.data = {}
end

function TrainFieldChooseModeDialog:__delete()
    self.data = nil

    self.controller = nil
end

function TrainFieldChooseModeDialog:Awake()
    self:FreshBaseUI()
    self:SetBtnAction()
end

function TrainFieldChooseModeDialog:OnFocus(focus)
    if focus then
        GameUtils.SetUICameraProjection(false, 26)
    end
end

function TrainFieldChooseModeDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function TrainFieldChooseModeDialog:FreshBaseUI()
    local vo = CfUtils.GetWholeVo(AutoIds.IdSetting1200, "TrainFieldLevelVo")
    for i, v in pairs(vo) do
        if isNull(self.data[checkString(v.group)]) then
            self.data[checkString(v.group)] = {}
        end
        table.insert(self.data[checkString(v.group)], v)
    end
    print("----->>"..table.dump(self.data))
    for i, v in pairs(self.data) do
        self:FreshNode(v)
    end
end

function TrainFieldChooseModeDialog:SetBtnAction()
    SetButtonAction(self.BtnRecord, function ()
        UIModule.OpenDialog(
                {
                    id = Constants.UITypeIds.TrainFieldTestRecordDialog,
                    --parameters = { rewards = response.data.rewards }
                }
        )
    end)
    SetButtonAction(self.BtnRank, function ()
        UIModule.OpenDialog(
                {
                    id = Constants.UITypeIds.TrainFieldRankDialog,
                    --parameters = { rewards = response.data.rewards }
                }
        )
    end)
end


---@param data table 关卡表中的数据
function TrainFieldChooseModeDialog:FreshNode(datas)
    local data = datas[1]
    local node = self["Node"..data.group]
    local root = node:Find("AnimRoot")
    CfUtils.FillText(root:Find("TextName"), data.name)
    CfUtils.FillText(root:Find("TextDescribe"), data.desc)
    CfUtils.SetUISwitchImage(root:Find("ModeIcon/ImgBg"), data.group)
    CfUtils.FillImage(root:Find("ModeIcon/ImgIcon"), data.icon)
    SetButtonAction(node, function ()
        self.co = cs_coroutine.start(function()
            UIRaycastBlocker:AddCondition("TrainFieldChooseModeDialog")
            CfUtils.PlayAnimator(root, "Choose")
            local waitTime = CfUtils.GetAnimatorTime(root, "TrainFieldChooseModeDialogNode")
            --local waitTime = 0.3
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(waitTime))
            UIModule.OpenDialog({ id = Constants.UITypeIds.UIFightTeamChoose, parameters = {levelId = data.id, datas = datas}}, {
                {id = Constants.UITypeIds.TrainFieldChooseModeDialog}
            })
            UIRaycastBlocker:RemoveCondition("TrainFieldChooseModeDialog")
        end)
    end)
end

function TrainFieldChooseModeDialog:StopCatCo()
    if not isNull(self.co) then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
end

function TrainFieldChooseModeDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        UIRaycastBlocker:RemoveCondition("TrainFieldChooseModeDialog")
        -- GameUtils.SetUICameraProjection(true)
        self:StopCatCo()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return TrainFieldChooseModeDialog