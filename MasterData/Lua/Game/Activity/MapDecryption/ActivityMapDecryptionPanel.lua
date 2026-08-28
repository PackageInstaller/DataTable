
------------ import ------------
---@type ActivityUtils
local ActivityUtils         = import("Game.Activity.ActivityUtils")
local MapDecryptionOPDriver = import("Game.Activity.MapDecryption.OP.MapDecryptionOPDriver")
------------ import ------------


------------ define ------------

------------ define ------------
--- from: Assets/BundleResources/Prefabs/Activity/ActivitySpringFestivalEntranceDialog121401.prefab > name: ActivitySpringFestivalEntranceDialog121401
---@class ActivityMapDecryptionPanel
---@field Env                           	ActivityMapDecryptionPanel              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnEntrance                   	UnityEngine.RectTransform               	               
---@field StateText                     	UnityEngine.UI.Text                     	                     
---@field ImgTitleName2                 	Engine.UI.WebRawImage                   	                   
---@field ImgTitleName                  	Engine.UI.WebRawImage                   	                   
---@field TxtTime                       	TMPro.TextMeshProUGUI                   	                   
---@field Open                          	UnityEngine.RectTransform               	5    
---@field Close                         	UnityEngine.RectTransform               	6    
local ActivityMapDecryptionPanel = Class('ActivityMapDecryptionPanel')

function ActivityMapDecryptionPanel:__init()

end


function ActivityMapDecryptionPanel:__delete()

end


function ActivityMapDecryptionPanel:Awake()
end


function ActivityMapDecryptionPanel:Start()
    SetButtonAction(self.BtnEntrance, Bind(self, self.OnClickBtnEntranceAction))
end


function ActivityMapDecryptionPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

--- Refresh
---@param activityDojo ActivityDojo
function ActivityMapDecryptionPanel:Refresh(activityDojo)
    self._activityDojo  = activityDojo
    self.TxtTime.text   = ActivityUtils.ConventActivityDurationTime(activityDojo.startTime, activityDojo.endTime)
    self.StateText.text = activityDojo.detail

    local activityContentId = activityDojo.activityContentId
    ---@type MapDecryptionPlanVo
    local planVo   = CfUtils.GetCfVo(AutoIds.IdSetting2801, "MapDecryptionPlanVo", activityContentId)
    local unlockId = planVo.unlockId
    local isUnlock = unlockId == 0 or QuestConfMgr:GetInstance():IsUnlockQuest(unlockId)
    self._isUnlock = isUnlock
    self._unlockId = unlockId
    CfUtils.SetActive(self.Open, isUnlock)
    CfUtils.SetActive(self.Close, not isUnlock)

    local titleImgUrl = checkString(activityDojo.titleImage)
    if not string.isEmpty(titleImgUrl) then
        CfUtils.FillWebRawImage(self.ImgTitleName, titleImgUrl)
        CfUtils.FillWebRawImage(self.ImgTitleName2, titleImgUrl)
    end
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function ActivityMapDecryptionPanel:OnClickBtnEntranceAction()
    ---@type ActivityDojo
    local activityDojo = self._activityDojo
    if not self._isUnlock then
        local questId = self._unlockId
        ---@type QuestMainVo
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if questVo then
            GameUtils.Toast(localize("通关主线关卡_name_后解锁", {_name_ = questVo.label}))
        end
        return
    end

    ---@type MapDecryptionOPDriver
    local opDriver = MapDecryptionOPDriver.New()
    opDriver:Start(activityDojo)
    
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return ActivityMapDecryptionPanel
