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
---@class DirectionalEntryNode
---@field Env                           	DirectionalEntryNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtContent                    	UnityEngine.UI.Text
---@field Text                          	UnityEngine.RectTransform
---@field BtnEntry                      	UnityEngine.RectTransform
local DirectionalEntryNode = Class("DirectionalEntryNode")
function DirectionalEntryNode:__init()
    self._data = nil


end

function DirectionalEntryNode:__delete()
    self._data = nil

end

function DirectionalEntryNode:Awake()


end

function DirectionalEntryNode:Refresh(data)
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
                self:FreshBaseUI()
                SetButtonAction(self.BtnEntry, function()
                    KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._data.id)
                    UIModule.OpenDialog({ id = Constants.UITypeIds.DirectionalDialog , parameters = { activityUuid = self._data.id } },
                            { { id = Constants.UITypeIds.UIActivityMainDialog } }
                    )
                end)
    --            break
    --        end
    --    end
    --end)
end

function DirectionalEntryNode:FreshBaseUI()
    --local curTime = os.time()
    local startTime =  self._data.startTime
    local closeTime =  self._data.closeTime
    local ActivityUtils         = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.Text, ActivityUtils.ConventActivityDurationTime(startTime, closeTime))
    self.TxtContent.text = self._data.detail
end

function DirectionalEntryNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return DirectionalEntryNode