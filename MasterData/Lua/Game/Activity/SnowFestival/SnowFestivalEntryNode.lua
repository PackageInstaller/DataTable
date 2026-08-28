---
--- Created by Eric.
--- DateTime: 2022/11/14 11:38
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/Activity/ActivitySnowFestivalDialog121501.prefab
---@class SnowFestivalEntryNode
---@field Env                           	SnowFestivalEntryNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgTitle                      	UnityEngine.RectTransform
---@field TxtTime                       	UnityEngine.RectTransform
---@field BtnHelp                       	UnityEngine.RectTransform
---@field BtnEnter                      	UnityEngine.RectTransform
local SnowFestivalEntryNode = Class("SnowFestivalEntryNode")
function SnowFestivalEntryNode:__init()

    self._data = {}--活动数据
    
end

function SnowFestivalEntryNode:__delete()

    self._data = nil

    self.controller = nil
end



function SnowFestivalEntryNode:Awake()

end

function SnowFestivalEntryNode:Refresh(data)
    if not data then
        return
    end
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    print("00---->>"..table.dump(data, nil, 3))
    comp:InitActivityDojo(data)
    self._data = comp:GetActivityDojo()
    self.activityConfigData = comp:GetActivityConfigData()
    print("11---->>"..table.dump(self.activityConfigData, nil, 3))
    self:FreshBaseUI()
end

function SnowFestivalEntryNode:FreshBaseUI()
    --region 时间
    local startTime =  self._data.startTime
    local closeTime =  self._data.closeTime
    CfUtils.FillText(self.TxtTime, os.date("%Y.%m.%d", startTime).."-"..os.date("%Y.%m.%d  %H:%M", closeTime))
    --endregion

    --region 标题背景图
    local titleImgUrl = checkString(self._data.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitle, titleImgUrl)
    end
    --endregion

    --region btn
    SetButtonAction(self.BtnEnter, function ()
        KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._data.id)
        UIModule.OpenDialog({ id = Constants.UITypeIds.SnowFestivalMainDialog, parameters = {
            --cb = function (status)
            --end
        }},

                {
                    {id = Constants.UITypeIds.UIActivityMainDialog}
                })
    end)
    SetButtonAction(self.BtnHelp, function()
        CfUtils.ShowModuleToast(self.activityConfigData.ruleID)
    end)
    --endregion
end

function SnowFestivalEntryNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return SnowFestivalEntryNode