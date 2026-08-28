--- from: Assets/BundleResources/Prefabs/Cultivate/UIHomeView.prefab > name: BtnBigActivityGroup
---@class UIHomeMainBigActivity
---@field Env                           	UIHomeMainBigActivity                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnIcon                       	UnityEngine.RectTransform               	@ 0    
---@field BtnStage                      	UnityEngine.RectTransform               	@ 1    
---@field TxtTime                       	UnityEngine.UI.Text                     	@ 2    
---@field TitleText                     	UnityEngine.RectTransform               	@ 3    
---@field redPoint                      	UnityEngine.RectTransform               	@ 4    
---@field ImgTime                       	UnityEngine.RectTransform               	@ 5    
local UIHomeMainBigActivity = Class('UIHomeMainBigActivity')
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CDTimerModule = CS.Engine.Modules.CDTimerModule
---@type ThirdDownloadManager
local ThirdDownloadManager = import("Game.Entry.ThirdDownloadManager"):GetInstance()

function UIHomeMainBigActivity:__init()
    self.cb = nil
end


function UIHomeMainBigActivity:__delete()
    self.activityId = nil
    self.activityData = nil
    self.cb = nil
end


function UIHomeMainBigActivity:Awake()
    ---@type Engine.UI.UILuaDialog
    local dialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIHomeView )
    local env = dialog.Env
    env:SetReverseButtonAction(self.BtnStage.gameObject ,function ()
       local func = self["Activity_" .. self.activityData.type]
       local open =  ThirdDownloadManager:IsActivityOpenDownloadThirdPackage(self.activityData.type)
       if open then
            UIModule.OpenDialog({ id = Constants.UITypeIds.ThirdPackageDownloadDialog})
            return
        end
       if isNotNull(func) then
            func(self)
       end
    end) 
end

function UIHomeMainBigActivity:Activity_120008()
    if isNull(self.activityData) then
        return
    end

    local vo = checkTable(self.activityData.unlock)[1]
    local isUnlock = false
    if vo then
        isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
    else
        isUnlock = true
    end

    if not isUnlock then
        local vo = self.activityData.unlock[1]
        local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
        GameUtils.Toast(err)
        return
    end
    local DreamAdvUtils = import('Game.Activity.DreamAdventures.DreamAdventuresUtils')
    xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self.activityData.id)))
    DreamAdvUtils.EnterDreamAdventures({ {id = Constants.UITypeIds.UIHomeView} }, {activityDojo = self.activityData, random = true})
end

function UIHomeMainBigActivity:Activity_120032()
    if isNull(self.activityData) then
        return
    end

    local vo = checkTable(self.activityData.unlock)[1]
    local isUnlock = false
    if vo then
        isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
    else
        isUnlock = true
    end

    if not isUnlock then
        local vo = self.activityData.unlock[1]
        local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
        GameUtils.Toast(err)
        return
    end
    Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })
    Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel, parameters = { activityUuid = self.activityData.id }},
        { { id = Constants.UITypeIds.UIHomeView } }
    )
end

function UIHomeMainBigActivity:Activity_120035()
    CfUtils.DialogOpen(
            Constants.UITypeIds.UIActivityTimeLimitedMainDialog,
            {
            },
            { { id = Constants.UITypeIds.UIHomeView } }
    )
end

function UIHomeMainBigActivity:Activity_120002()
    ---@type ActivityMidFestivalMgr
    local ActivityMidFestivalMgr = import("Game.Activity.MidFestival.ActivityMidFestivalMgr"):GetInstance()
    if isNull(self.activityData) then
        return
    end
    local vo = self.activityData.unlock[1]
    local isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
    if not isUnlock then
        local vo = self.activityData.unlock[1]
        local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
        GameUtils.Toast(err)
        return
    end
    ActivityMidFestivalMgr:EnterActivityDialog(self.activityData)
end

function UIHomeMainBigActivity:Activity_1206()
    local t = checkTable(self.activityData.unlock)
    if table.count(t) > 0 then
        local vo = t[1]
        local isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
        if not isUnlock then
            local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
            GameUtils.Toast(err)
            return
        end
    end
    xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self.activityData.id)))
    UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityNightCatDialog, parameters = {activityId = self.activityData.id}},
            {{id = Constants.UITypeIds.UIHomeView}})
end

function UIHomeMainBigActivity:Activity_120025()
    local isUnlock = GameUtils.IsUnlockedSingle(self.activityData.unlock[1].targetType, self.activityData.unlock[1].targetNum, self.activityData.unlock[1].targetId)
    if not isUnlock then
        local err = GameUtils.GetUnlockDescr(self.activityData.unlock[1].targetType, self.activityData.unlock[1].targetNum, self.activityData.unlock[1].targetId)
        GameUtils.Toast(err)
        return
    end

    xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self.activityData.id)))
    local ActivityMournUtils = import('Game.Activity.Mourn.ActivityMournUtils')
    ---@type ActivityMournUtils
    ActivityMournUtils.GetMournMgr():SaveActivityData(self.activityData)
    UIModule.OpenDialog({ id = Constants.UITypeIds.MournMainDialog, parameters = {activityId = self.activityData.id}},
            {{id = Constants.UITypeIds.UIHomeView}})
end

function UIHomeMainBigActivity:Activity_120018()
    local t = checkTable(self.activityData.unlock)
    if table.count(t) > 0 then
        local vo = t[1]
        local isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
        if not isUnlock then
            local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
            GameUtils.Toast(err)
            return
        end
    end
    xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self.activityData.id)))
    CfUtils.DialogOpen(Constants.UITypeIds.ParkourGameOptionDialog, nil,{ 
        { id = Constants.UITypeIds.UIActivityMainDialog },
        {id = Constants.UITypeIds.UIHomeView}
     })
    -- UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityNightCatDialog, parameters = {activityId = self.activityData.id}},
    --         {{id = Constants.UITypeIds.UIHomeView}})
end

function UIHomeMainBigActivity:Activity_120007()
    ---@type ActivityDojo
    local activityDojo = self.activityData
    ---@type MapDecryptionPlanVo
    local planVo   = CfUtils.GetCfVo(AutoIds.IdSetting2801, "MapDecryptionPlanVo", self.activityData.activityContentId)
    local unlockId = planVo.unlockId
    local isUnlock = unlockId == 0 or QuestConfMgr:GetInstance():IsUnlockQuest(unlockId)
    if not isUnlock then
        local questId = unlockId
        ---@type QuestMainVo
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if questVo then
            GameUtils.Toast(localize("通关主线关卡_name_后解锁", {_name_ = questVo.label}))
        end
        return
    end
    local MapDecryptionOPDriver = import("Game.Activity.MapDecryption.OP.MapDecryptionOPDriver")
    ---@type MapDecryptionOPDriver
    local opDriver = MapDecryptionOPDriver.New()
    opDriver:Start(activityDojo)
end

function UIHomeMainBigActivity:Activity_113003()
    ---@type ActivityDojo
    local activityDojo = self.activityData
    local ActivityCakeUtils = import('Game.UI.ActivityCakeShopDialog.ActivityCakeUtils')
    ActivityCakeUtils.GetActivityCakeMgr():SaveActivityData(activityDojo)
    local isUnlock = GameUtils.IsUnlockedSingle(activityDojo.unlock[1].targetType, activityDojo.unlock[1].targetNum, activityDojo.unlock[1].targetId)
    if not isUnlock then
        local lockDes = GameUtils.GetUnlockDescr(activityDojo.unlock[1].targetType, activityDojo.unlock[1].targetNum, activityDojo.unlock[1].targetId)
        if lockDes then
            GameUtils.Toast(lockDes)
        end
        return
    end
    UIModule.OpenDialog({ id = self.activityData.moduleId, parameters = { activityData = self.activityData}}, { { id = Constants.UITypeIds.UIHomeView } })
end

function UIHomeMainBigActivity:Activity_120022()
    CfUtils.WriteLocalData("ActivityPaySign_" .. self.activityData.id   ,"1")
     ---@type ActivityDojo
     local activityDojo = self.activityData
    local ActivityUtils = import('Game.Activity.ActivityUtils')
    ActivityUtils.OpenActivityView(activityDojo.id, CfUtils.DialogGetAllArgs())
end

function UIHomeMainBigActivity:Activity_113008()
    if isNull(self.activityData) then
        return
    end

    local vo = checkTable(self.activityData.unlock)[1]
    local isUnlock = false
    if vo then
        isUnlock = GameUtils.IsUnlockedSingle(vo.targetType, vo.targetNum, vo.targetId)
    else
        isUnlock = true
    end

    if not isUnlock then
        local vo = self.activityData.unlock[1]
        local err = GameUtils.GetUnlockDescr(vo.targetType, vo.targetNum, vo.targetId)
        GameUtils.Toast(err)
        return
    end
    
    local JapaneseStoryUtils = import('Game.Activity.JapaneseStory.JapaneseStoryUtils')
    xRecord.record('6-005', string.format('enter_activity_page_%d', checkInt(self.activityData.id)))
    JapaneseStoryUtils.Entry({ {id = Constants.UITypeIds.UIActivityMainDialog},{id = Constants.UITypeIds.UIHomeView} }, {activityDojo = self.activityData, random = true})
end

function UIHomeMainBigActivity:Start()

end

---@param activityData ActivityDojo
function UIHomeMainBigActivity:SetActivityData( activityData)    
    self.activityData  = activityData
    
end

function UIHomeMainBigActivity:InitUI()
    local endTime = self.activityData.endTime
    ---@type PlayerComponent
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local currentTime =  playerComponent:GetPlayerDojo():GetServerTime()
    -- self.BtnIcon
    CfUtils.FillImage(self.BtnIcon.gameObject , string.format("UIAtlas/Main/home_btn_%s.png", self.activityData.prefab))
    CfUtils.FillText(self.TxtTime.gameObject ,CfUtils.GetTimeHMS(endTime - currentTime)  )
    CfUtils.FillText(self.TitleText.gameObject,self.activityData.name)
    local ActivityConstants   = import('Game.Activity.ActivityConstants')
    local redPoint = false
    if self.activityData.type == ActivityConstants.ActivityType.ActivityPaySign then
        local  ActivityPaySign =  checkInt(CfUtils.GetLocalData("ActivityPaySign_" .. self.activityData.id ,"0")) 
        if ActivityPaySign == 0 then
            redPoint = true
        end
    elseif self.activityData.redDotHint == 0 then
        redPoint = true
    else 
        redPoint = false
    end
    KTool.SetActive(self.redPoint.gameObject , redPoint)
end

function UIHomeMainBigActivity:AddTimer()
    local endTime = self.activityData.endTime
    if isNotNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end
    local currentTime = os.time()
    ---@type PlayerComponent
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local currentTime =  playerComponent:GetPlayerDojo():GetServerTime()
    local distanceTime = endTime - currentTime
    if distanceTime > 0 then
        KTool.SetActive(self.ImgTime.gameObject , true)
        CfUtils.FillText(self.TxtTime.gameObject ,CfUtils.GetTimeHMS(distanceTime)  )
        self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id)
            distanceTime = endTime - playerComponent:GetPlayerDojo():GetServerTime()
            CfUtils.FillText(self.TxtTime.gameObject ,CfUtils.GetTimeHMS(distanceTime))
            if distanceTime <= 0 then
                if self._timeDown then
                    KTool.SetActive(self.controller.gameObject , false) 
                    CDTimerModule.GetInstance():RemoveCD(self._timeDown)
                    self._timeDown = nil
                end
            end
        end, 259200, true, true)
    end
  
end

function UIHomeMainBigActivity:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    if isNotNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end
    self:Delete()
end


return UIHomeMainBigActivity
