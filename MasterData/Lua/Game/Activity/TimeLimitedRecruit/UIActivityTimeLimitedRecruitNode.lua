---@type TimeLimitedMgr
local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()

---@type TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")

--- from: Assets/BundleResources/Prefabs/Activity/ActivityDKDialog12003501.prefab > name: ActivityDKDialog12003501
---@class UIActivityTimeLimitedRecruitNode
---@field Env                           	UIActivityTimeLimitedRecruitNode        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnGo                         	UnityEngine.RectTransform               	@ 0    
---@field Text                          	UnityEngine.RectTransform               	@ 1    
---@field StateGroup                    	UnityEngine.RectTransform               	@ 2    
---@field TxtTime                       	UnityEngine.RectTransform               	@ 3    
---@field TitleItem                     	UnityEngine.RectTransform               	@ 4    
---@field Root                          	UnityEngine.RectTransform               	@ 5    
---@field ImgTitle                      	UnityEngine.RectTransform               	@ 6    
---@field ImgTitleName                  	UnityEngine.RectTransform               	@ 7    
---@field BtnRoleNameNode               	UnityEngine.RectTransform               	@ 8    
---@field BossDrawingNode               	UnityEngine.RectTransform               	@ 9    皮肤立绘
local UIActivityTimeLimitedRecruitNode = Class("UIActivityTimeLimitedRecruitNode")

---@class UIActivityTimeLimitedRecruitNode.InputData

function UIActivityTimeLimitedRecruitNode:__init()
    self.controller = nil
    self.activityData = nil
end

function UIActivityTimeLimitedRecruitNode:__delete()
    self.controller = nil
    self.activityData = nil
end


function UIActivityTimeLimitedRecruitNode:Awake()

    SetButtonAction(self.BtnGo, function()
        CfUtils.DialogOpen(
            Constants.UITypeIds.UIActivityTimeLimitedMainDialog, 
            { activityData = self.activityData
            },
            { { id = Constants.UITypeIds.UIActivityMainDialog } }
        )
    end)

    GameUtils.BindRedPoint(Constants.RedPointConst.MainActivityMinWorldMain, self.BtnGo.transform:Find("ImgBg"), true)

    local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
    CriWareUtils.StopAll()
    CriWareUtils.PlayRandomBGMFromCDList()
end


function UIActivityTimeLimitedRecruitNode:Refresh(data)
    --Mgr.activityData = data
    --Mgr.activityUuid = Mgr.activityData.id
    local activityData = data
    self.activityData = data
    local startTime =  activityData.startTime
    local closeTime =  activityData.closeTime
    local ActivityUtils         = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(startTime, closeTime))


    CfUtils.FillText(self.Text, activityData.detail)

    if not CfUtils.IsActive(self.controller) then
        CfUtils.SetActive(self.controller, true)
    end
    
    local titleImgUrl = checkString(activityData.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitleName, titleImgUrl)
    end

    -- role btn:
    local cardId = Mgr:GetCardId( activityData )
    ---@type CommonBtnRoleNameNode
    local env = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
    if env then
        env:RefreshSelf(cardId, nil, nil, true, true)
    end

    -- 立绘
    local skinId = TimeLimitedRecruitUtil.GetCardVo(cardId).defaultSkin
    ---@type DrawingNode
    local env = CfUtils.GetLuaScr(self.BossDrawingNode, "Game.Behaviours.DrawingNode")
    if env then
        env:SetParams(skinId)
        env:ShowSkin()
    end
end


function UIActivityTimeLimitedRecruitNode:OnDestroy()
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldMain)
end

return UIActivityTimeLimitedRecruitNode