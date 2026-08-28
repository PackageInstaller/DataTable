---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()

--- from: Assets/BundleResources/Prefabs/Activity/OverseaParkourEntryDialog12001801.prefab > name: OverseaParkourEntryDialog12001801
---@class ParkourGameEntryDialog
---@field Env                           	ParkourGameEntryDialog                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtTime                       	UnityEngine.RectTransform               	@ 0    
---@field Text                          	UnityEngine.RectTransform               	@ 1    
---@field BtnGo                         	UnityEngine.RectTransform               	@ 2    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 3    
local ParkourGameEntryDialog = Class("ParkourGameEntryDialog")

---@class ParkourGameEntryDialog.InputData

function ParkourGameEntryDialog:__init()
    self.controller = nil
end

function ParkourGameEntryDialog:__delete()
    self.controller = nil
end

function ParkourGameEntryDialog:Awake()
    SetButtonAction(self.BtnGo, function()
        if not self:IsUnLock() then
            GameUtils.Toast(self:GetUnLockDesc())
            return
        end
        CfUtils.DialogOpen(Constants.UITypeIds.ParkourGameOptionDialog, nil,{ { id = Constants.UITypeIds.UIActivityMainDialog } })
    end)
    GameUtils.BindRedPoint(Constants.RedPointConst.MainActivityMinWorldMain, self.BtnGo.transform:Find("ImgBg"), true)

    local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
    CriWareUtils.StopAll()
    CriWareUtils.PlayRandomBGMFromCDList()



end


function ParkourGameEntryDialog:Refresh(data)
    self.activityData = data
    local startTime =  self.activityData.startTime
    local closeTime =  self.activityData.closeTime
    local ActivityUtils         = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(startTime, closeTime))
    CfUtils.SetUISwitchImage(self.ImgBg, self:IsUnLock() and "2" or "1")
    CfUtils.FillText(self.Text, self.activityData.detail)
    if not CfUtils.IsActive(self.controller) then
        CfUtils.SetActive(self.controller, true)
    end
    local titleImgUrl = checkString(self.activityData.titleImage)
    if string.len(titleImgUrl) > 0 then
        local rootTrans = self.BtnGo.transform.parent
        CfUtils.SetActive(rootTrans, true)
        if rootTrans then
            local webImage = rootTrans:Find("TitleItem/ImgTitleName/ImgTitleName")
            if webImage then
                CfUtils.FillWebRawImage(webImage, titleImgUrl)
            end
        end
    end
end

function ParkourGameEntryDialog:IsUnLock()
    local isUnlock = GameUtils.IsUnlockedSingle(self.activityData.unlock[1].targetType, self.activityData.unlock[1].targetNum, self.activityData.unlock[1].targetId)
    return isUnlock
end

function ParkourGameEntryDialog:GetUnLockDesc()
    local unLockDesc = GameUtils.GetUnlockDescr(self.activityData.unlock[1].targetType, self.activityData.unlock[1].targetNum, self.activityData.unlock[1].targetId)
    return unLockDesc
end

function ParkourGameEntryDialog:OnDestroy()
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldMain)
end

return ParkourGameEntryDialog