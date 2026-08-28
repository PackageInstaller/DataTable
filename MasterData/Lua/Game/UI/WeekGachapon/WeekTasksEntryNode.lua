---
--- Created by Eric.
--- DateTime: 2022/7/21 10:51
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local UIModule = CS.Engine.UI.UIModule
local ActivityDojo = import("Game.Dojo.ActivityDojo")
local ActivityConstants = import("Game.Activity.ActivityConstants")
------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/Activity/DirectionalEntryDialog.prefab
---@class WeekTasksEntryNode
---@field Env                           	WeekTasksEntryNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgTitleNameBg                	UnityEngine.RectTransform
---@field TxtContent                    	UnityEngine.UI.Text
---@field Text                          	UnityEngine.RectTransform
---@field BtnEntry                      	UnityEngine.RectTransform
local WeekTasksEntryNode = Class("WeekTasksEntryNode")
function WeekTasksEntryNode:__init()
    self._data = nil


end

function WeekTasksEntryNode:__delete()
    self._data = nil

end

function WeekTasksEntryNode:Awake()


end

function WeekTasksEntryNode:Refresh(data)
    if not data then
        return
    end
    --GameUtils.Request(Interfaces.ActivityHome, {}, function(request, response)
    --    if checkNumber(response.errCode) ~= 0 then
    --        return
    --    end
    --    local data = checkTable(response.data)
    --    for k, v in pairs(data.activities) do
    --        local dojo = ActivityDojo.New()
    --        dojo:Fill(v)
    --        if checkNumber(dojo.type) == ActivityConstants.ActivityType.Directional then
                self._data = data
                local WeekGachaponComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.WeekGachaponComponent)
                WeekGachaponComponent:InitialActivityDojo({
                    activityUuid = self._data.id,
                    startTime = self._data.startTime,
                    endTime = self._data.endTime,
                    closeTime = self._data.closeTime,
                })
                self:FreshBaseUI()
                SetButtonAction(self.BtnEntry, function()
                    KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._data.id)
                    xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self._data.id)))
                    UIModule.OpenDialog({ id = Constants.UITypeIds.WeekTasksMainDialog },
                            { { id = Constants.UITypeIds.UIActivityMainDialog } }
                    )
                end)
    --            break
    --        end
    --    end
    --end)
end

function WeekTasksEntryNode:FreshBaseUI()
    --local curTime = os.time()
    local startTime =  self._data.startTime
    local closeTime =  self._data.closeTime
    CfUtils.FillText(self.Text, os.date("%m/%d", startTime).."-"..os.date("%m/%d  %H:%M", closeTime))
    self.TxtContent.text = self._data.detail
    local titleImgUrl = checkString(self._data.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitleNameBg, titleImgUrl)
    end
end

function WeekTasksEntryNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return WeekTasksEntryNode