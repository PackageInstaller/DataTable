---
--- Created by Eric.
--- DateTime: 2022/11/16 15:14
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders

local cs_coroutine = require 'XLua.cs_coroutine'
------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/SnowFestival/SnowFestivalPlotReviewDialog121501.prefab
---@class SnowFestivalPlotReviewNode
---@field Env                           	SnowFestivalPlotReviewNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Cell                          	UnityEngine.RectTransform
---@field Btn                           	UnityEngine.RectTransform
---@field SelectGroup                   	UnityEngine.RectTransform
---@field TextName                      	UnityEngine.RectTransform
---@field UnLockGroup                   	UnityEngine.RectTransform
---@field LockGroup                     	UnityEngine.RectTransform
---@field TxtNumber                     	UnityEngine.RectTransform
---@field TxtChapter                    	UnityEngine.RectTransform
---@field ImgBg                         	UnityEngine.RectTransform
local SnowFestivalPlotReviewNode = Class("SnowFestivalPlotReviewNode")
function SnowFestivalPlotReviewNode:__init()
    self.btnAction = nil

end

function SnowFestivalPlotReviewNode:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function SnowFestivalPlotReviewNode:SetBtnCallBack(cb)
    self.btnAction = cb
end

function SnowFestivalPlotReviewNode:Awake()
    SetButtonAction(self.Btn.gameObject, function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

function SnowFestivalPlotReviewNode:FreshBaseUI(data, index)
    CfUtils.FillText(self.TxtNumber, format_tens_place(index))
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    local isUnlockAllPlot = comp:IsUnlockAllPlot()
    local isUnlockPlot = comp:IsUnlockPlot(data.id)
    local isUnlock = isUnlockPlot or isUnlockAllPlot 
    KTool.SetActive(self.UnLockGroup, isUnlock)
    KTool.SetActive(self.LockGroup, not isUnlock)
    CfUtils.SetUISwitchImage(self.ImgBg, isUnlock and 1 or 3)
    CfUtils.SetUISwitchText(self.TxtChapter, isUnlock and 1 or 3)
    CfUtils.SetUISwitchText(self.TxtNumber, isUnlock and 1 or 3)
    if isUnlock then
        CfUtils.FillText(self.TextName, data.name)
    end
    self:SetBtnCallBack(function()
        if isUnlock then
            comp:EnterPlotNoReq(data)
        else
            GameUtils.Toast(localize("未解锁"))
        end
    end)
end


function SnowFestivalPlotReviewNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return SnowFestivalPlotReviewNode