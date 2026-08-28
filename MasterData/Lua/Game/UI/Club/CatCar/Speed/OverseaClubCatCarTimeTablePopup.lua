---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

local Week = {
    localize("周一"),
    localize("周二"),
    localize("周三"),
    localize("周四"),
    localize("周五"),
    localize("周六"),
    localize("周日"),
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarTimeTablePopup.prefab > name: OverseaClubCatCarTimeTablePopup
---@class OverseaClubCatCarTimeTablePopup
---@field Env                            OverseaClubCatCarTimeTablePopup
---@field controller                        Engine.Modules.LuaBehaviour
---@field ClickClose                        UnityEngine.RectTransform                @ 0    
---@field Content                        UnityEngine.RectTransform                @ 1    
---@field Arrow                            UnityEngine.RectTransform                @ 2    
local OverseaClubCatCarTimeTablePopup = Class("OverseaClubCatCarTimeTablePopup")

---@class OverseaClubCatCarTimeTablePopup.InputData

function OverseaClubCatCarTimeTablePopup:__init()
    self.controller = nil
end

function OverseaClubCatCarTimeTablePopup:__delete()
    self.controller = nil
end

function OverseaClubCatCarTimeTablePopup:Awake()
    SetButtonAction(self.ClickClose, function() 
        CfUtils.SetActive(self.controller.gameObject, false)
    end)
end

---@param inData OverseaClubCatCarTimeTablePopup.InputData
function OverseaClubCatCarTimeTablePopup:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarTimeTablePopup:RefreshUI()
    local diceData = checkTable(Mgr.Server.dojo.diceRecords)
    local clubHomeDojo  = ClubUtils.GetClubComp():GetHomeDojo()
    local firstDay = OverseaClubCatCarUtils:TimestapToWeekdayStr(clubHomeDojo.carStartTime) --第一天是星期几
    local todayIndex = OverseaClubCatCarUtils:GetTodayIndex()
    for i = 1, 7 do
        ---@type OverseaClubCatCarTimeTableNode.InputData
        local data = {}
        local cell = self.Content:GetChild(i - 1)
        ---@type OverseaClubCatCarTimeTableNode
        local cellLua = CfUtils.GetLuaScr(cell,"Game.UI.Club.CatCar.Speed.OverseaClubCatCarTimeTableNode")
        data.date = Week[(i + firstDay - 2) % 7 + 1]
        data.number = string.format("0%d", i)
        if i < todayIndex then
            data.today = 1
        elseif i == todayIndex then
            data.today = 2
        else
            data.today = 3
        end
        data.point = checkNumber(diceData[tostring(i)])
        data.status = self:GetStatus(i)
        cellLua:RefreshData(data)
    end
    
    for i = 1, 5 do
        local cell = self.Arrow:Find("ImgArrow" .. i)
        if i >= 4 then
            CfUtils.SetUISwitchImage(cell, (i + 1) < todayIndex and 2 or 1)
        else
            CfUtils.SetUISwitchImage(cell, i < todayIndex and 2 or 1)
        end
    end
end

function OverseaClubCatCarTimeTablePopup:GetStatus(i)
    local dice = ClubUtils.GetParamValue(ClubUtils.ParamsId.Speed_Stage_Days)
    local boss = ClubUtils.GetParamValue(ClubUtils.ParamsId.Boss_Stage_Days)
    --local drawPrize = ClubUtils.GetParamValue(ClubUtils.ParamsId.Lottery_Stage_Days)
    if i <= dice then
        return 1
    elseif i <= boss then
        return 2
    else
        return 3
    end
end

return OverseaClubCatCarTimeTablePopup