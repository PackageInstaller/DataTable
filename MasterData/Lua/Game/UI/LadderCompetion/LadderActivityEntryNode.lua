-------------------------------------------------------------------------------
-- 天梯竞技 - 活动入口
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-07-28 16:58:00
-------------------------------------------------------------------------------

local UIModule          = CS.Engine.UI.UIModule
---@type Engine.Modules.CDTimerModule
local CDTimerModule     = CS.Engine.Modules.CDTimerModule:GetInstance()
local ActivityDojo      = import("Game.Dojo.ActivityDojo")
local ActivityConstants = import("Game.Activity.ActivityConstants")
---@type ActivityUtils
local ActivityUtils     = import("Game.Activity.ActivityUtils")

--- from: Assets/BundleResources/Prefabs/Activity/LadderCompetionEntryDialog.prefab
---@class LadderActivityEntryNode
---@field Env                           	LadderActivityEntryNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextLeftTime                  	UnityEngine.RectTransform               
---@field TextActivityTime              	UnityEngine.RectTransform               
---@field TextActivityDesc              	UnityEngine.RectTransform               
---@field BtnEntry                      	UnityEngine.RectTransform               
local LadderActivityEntryNode = Class('LadderActivityEntryNode')


function LadderActivityEntryNode:__init()
    ---@type ActivityDojo
    self.activityDojo_ = nil
end


function LadderActivityEntryNode:__delete()
    self.activityDojo_ = nil
end


function LadderActivityEntryNode:Awake()
    SetButtonAction(self.BtnEntry, Bind(self, self.OnClickEntryButtonHandler_))
end


function LadderActivityEntryNode:OnDestroy()
    self:ClearCountdown_()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---@param actDojo ActivityDojo
function LadderActivityEntryNode:Refresh(actDojo)
    if not actDojo then return end
    self.activityDojo_ = actDojo
    self:UpdateView_()
end


function LadderActivityEntryNode:UpdateView_()
    -- update time
    CfUtils.FillText(self.TextActivityTime, ActivityUtils.ConventActivityDurationTime(self.activityDojo_.startTime, self.activityDojo_.endTime))

    -- update descr
    CfUtils.FillText(self.TextActivityDesc, self.activityDojo_.detail)

    -- update TextLeftTime
    self:StateCountdown_()

    -- update redPoint
    ActivityUtils.UpdateActivityMainRedPointState(self.activityDojo_.id, self.activityDojo_.redDotHint)
end


function LadderActivityEntryNode:StateCountdown_()
    self:ClearCountdown_()
    local closeTime = math.max(self.activityDojo_.closeTime - os.time(), 0)
    self.countdownHandler_ = CDTimerModule:AddCD(1, function(countTimes, timerId)
        CfUtils.FillText(self.TextLeftTime, CfUtils.GetTimeHMS3(countTimes, 24))
    end, closeTime, true, true)
end


function LadderActivityEntryNode:ClearCountdown_()
    if not isNull(self.countdownHandler_) then
        CDTimerModule:RemoveCD(self.countdownHandler_)
        self.countdownHandler_ = nil
    end
end


function LadderActivityEntryNode:OnClickEntryButtonHandler_()
    if self.activityDojo_ then
        xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self.activityDojo_.id)))
        UIModule.OpenDialog(
            { id = Constants.UITypeIds.LadderCompetionMainDialog, parameters = { activityDojo = self.activityDojo_ } },
            { { id = Constants.UITypeIds.UIActivityMainDialog } }
        )
    else
        GameUtils.Toast(localize("活动不存在"))
    end
end


return LadderActivityEntryNode
