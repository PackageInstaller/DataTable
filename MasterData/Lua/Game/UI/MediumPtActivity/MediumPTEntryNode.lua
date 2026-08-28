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
---@class MediumPTEntryNode
---@field Env                           	MediumPTEntryNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Text                          	UnityEngine.RectTransform
---@field BtnEntry                      	UnityEngine.RectTransform
local MediumPTEntryNode = Class("MediumPTEntryNode")
function MediumPTEntryNode:__init()
    self._data = nil


end

function MediumPTEntryNode:__delete()
    self._data = nil

end

function MediumPTEntryNode:Awake()
end

function MediumPTEntryNode:Refresh(data)
    if not data then
        return
    end
    CfUtils.SetTopCommonActive(true, false)
    ---直接用活动给的数据，倒计时转换成时间戳了
    self._data = data
    local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)
    MediumPTActivityComponent:InitCheckInData({
        activityUuid = self._data.id,
        startTime = self._data.startTime,
        endTime = self._data.endTime,
        closeTime = self._data.closeTime,
    })
    self:FreshBaseUI()

    SetButtonAction(self.BtnEntry, function()
        local vo = self._data.unlock[1]
        local isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
        if not isUnlock then
            local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
            GameUtils.Toast(err)
            return
        end
        KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._data.id)
        UIModule.OpenDialog({ id = Constants.UITypeIds.MediumPtMainDialog },
                { { id = Constants.UITypeIds.UIActivityMainDialog } }
        )
    end)
end

function MediumPTEntryNode:FreshBaseUI()
    local startTime = self._data.startTime
    local endTime = self._data.endTime
    ---@type ActivityUtils
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.Text, ActivityUtils.ConventActivityDurationTime(startTime, endTime))

    self:RefreshTitle()
end

function MediumPTEntryNode:RefreshTitle()
    local titleImgUrl = checkString(self._data.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitle, titleImgUrl)
    end
end

function MediumPTEntryNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return MediumPTEntryNode