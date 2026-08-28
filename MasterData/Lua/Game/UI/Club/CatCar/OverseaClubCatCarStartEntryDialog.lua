local cs_coroutine = import('XLua.cs_coroutine')
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarStartEntryDialog.prefab > name: OverseaClubCatCarStartEntryDialog
---@class OverseaClubCatCarStartEntryDialog
---@field Env                            OverseaClubCatCarStartEntryDialog
---@field controller                        Engine.UI.UILuaDialog
---@field Layout1                        UnityEngine.RectTransform                @ 0    
---@field Layout2                        UnityEngine.RectTransform                @ 1    
---@field Layout3                        UnityEngine.RectTransform                @ 2    
---@field TextTime                        UnityEngine.RectTransform                @ 3    
local OverseaClubCatCarStartEntryDialog = Class("OverseaClubCatCarStartEntryDialog")

---@class OverseaClubCatCarStartEntryDialog.InputData

function OverseaClubCatCarStartEntryDialog:__init()
    self.controller = nil
end

function OverseaClubCatCarStartEntryDialog:__delete()
    self.controller = nil
end

function OverseaClubCatCarStartEntryDialog:Awake()
    self:RefreshUI()

    CoStart(function()
        CoYield(6.5)
        cs_coroutine.yield_return(CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarBackgroundDialog, nil, { UIArgs(Constants.UITypeIds.UIOverseaClubHallDialog), UIArgs(Constants.UITypeIds.UIOverseaClubActivityDialog) }))
        self.controller:Close()
        UIRaycastBlocker:RemoveCondition(OverseaClubCatCarUtils.StartEntryDialogBlocker)
    end)
end

function OverseaClubCatCarStartEntryDialog:RefreshUI()
    local Layouts = { self.Layout1, self.Layout2, self.Layout3 }
    local textTran = nil
    local text = nil
    local j = 1
    for i = 1, 4 do
        for k, v in pairs(Layouts) do
            textTran = v:Find("TextDesc" .. i)
            text = CfUtils.GetCfData(AutoIds.IdSetting6285, j, "dec", Constants.DataType.LocalString)
            CfUtils.FillText(textTran, text)
            j = j + 1
        end
    end

    CfUtils.FillText(self.TextTime, OverseaClubCatCarUtils:GetActivityDurationTime())
end

return OverseaClubCatCarStartEntryDialog