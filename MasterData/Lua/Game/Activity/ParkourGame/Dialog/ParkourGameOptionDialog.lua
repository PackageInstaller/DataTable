local Parkour_Loader = import('Game.Activity.ParkourGame.Parkour_Loader')

local ID = CS.Game.Native.Common.ID
local ChapterUtils = import('Game.Chapter.ChapterUtils')
---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
local UINavigationBarRoot = CS.UINavigationBarRoot
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local BehaviourAction = CS.Engine.Lib.BehaviourAction


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourOptionDialog12001801.prefab > name: OverseaParkourOptionDialog12001801
---@class ParkourGameOptionDialog
---@field Env                           	ParkourGameOptionDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Spine                         	UnityEngine.RectTransform               	@ 0    
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 1    
---@field TxtTime                       	UnityEngine.RectTransform               	@ 2    
---@field BtnStore                      	UnityEngine.RectTransform               	@ 3    
---@field TxtStoreTime                  	UnityEngine.RectTransform               	@ 4    
---@field BtnTask                       	UnityEngine.RectTransform               	@ 5    
---@field TxtTaskNumber                 	UnityEngine.RectTransform               	@ 6    
---@field TxtName                       	UnityEngine.RectTransform               	@ 7    
---@field TextDesc                      	UnityEngine.RectTransform               	@ 8    
---@field BtnWorldBoss                  	UnityEngine.RectTransform               	@ 9    
---@field ImgBossLock                   	UnityEngine.RectTransform               	@ 10   
---@field BtnStartRun                   	UnityEngine.RectTransform               	@ 11   "探索世界"
---@field BtnParkourLevel               	UnityEngine.RectTransform               	@ 12   跑酷选关
local ParkourGameOptionDialog = Class("ParkourGameOptionDialog")


-- 微缩世界功能入口表 中的类型:
local BossType = 2 ---boss类型
local ParkourType = 6 -- 


--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CountDownTime = 2592000 --30 * 86400 30天的秒数

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')


---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")

---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()

-- =========================================================

---@class ParkourGameOptionDialog.InputData

function ParkourGameOptionDialog:__init()
    self.controller = nil
    ---主界面接口返回数据
    self.data = nil
    self.isParkourBtnUnlock = nil
end

function ParkourGameOptionDialog:__delete()
    self.controller = nil
    self.isParkourBtnUnlock = nil
end

function ParkourGameOptionDialog:_GetOptionButtonText(activityContentId, id)
    local tableFile = CfUtils.GetCfTable(AutoIds.IdSetting6480) -- 微缩世界功能入口表
    local rows = tableFile:GetAll()
    local name = ''
    for k, row in pairs(rows) do
        local nameCfg = parse_localizeText(row, "name")
        local activityId = checkNumber(row:Get("activityId"))
        local refId = checkNumber(row:Get("id"))
        if refId == checkNumber(id) and checkNumber(activityContentId) == activityId then
            name = nameCfg
            break
        end
    end
    return name
end

function ParkourGameOptionDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function()
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
        end)
    end))
    return coWait
end

function ParkourGameOptionDialog:Awake()
    SetButtonAction(self.BtnExplain, function()
        if self.data then
            CfUtils.ShowModuleToast(checkNumber(self.data.scheduleConf.ruleId))
        end
    end)
    SetButtonAction(self.BtnStore, function()
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaParkourRewardDialog, {
            activityData = self.activityData,
            data = self.data,
            topGoods = clone(self.topGoods)
        }, { { id = Constants.UITypeIds.ParkourGameOptionDialog } })
        --CfUtils.DialogOpen(Constants.UITypeIds.UIActivityCommonShopDialog, {
        --    activityUuid = self.activityData.id,
        --    mallBgImage = string.isEmpty(self.activityData.mallBgImage) and 'Arts/Textures/Activity/OverseaParkour12001801/activity_micro_task_bg_1.png' or CfUtils.GetImageFullPath(self.activityData.mallBgImage),
        --    --activityType = ActivityConstants.ActivityType.PTQuest,
        --    topGoods = self.topGoods
        --}, { { id = Constants.UITypeIds.ParkourGameOptionDialog } }, true)
        --CfUtils.DialogOpen(Constants.UITypeIds.ParkourGameShopDialog, {data = self.activityData})
    end)
    GameUtils.BindRedPoint(Constants.RedPointConst.MainActivityMinWorldAchievementTask, self.BtnStore, true)
    GameUtils.BindRedPoint(Constants.RedPointConst.MainActivityMinWorldTask, self.BtnTask, true)
    SetButtonAction(self.BtnTask, function()
        ---@type PlayerComponent
        local playerComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local curDate = playerComp:GetPlayerDojo():GetServerTimeWithTimeZone()
        local endTime = checkNumber(self.activityData.endTime)
        local leftTime = endTime - curDate
        if leftTime <= 0 then
            return GameUtils.Toast(localize("活动已经结束"))
        end
        CfUtils.DialogOpen(Constants.UITypeIds.ParkourGameTaskDialog, { data = self.activityData, topGoods = self.topGoods })
    end)
    --GameUtils.BindRedPoint(Constants.RedPointConst.MainActivityMinWorldMainEntry, self.BtnWorldBoss, true)
    SetButtonAction(self.BtnWorldBoss, function()
        if not self.data then
            return
        end
        local dojo = self:GetEntryConfig(BossType)
        local isUnlock = false
        if dojo then
            if checkNumber(dojo.unlockLevel) > 0 and checkNumber(dojo.unlockLevel) > checkNumber(self.data.mainQuestId) then
                isUnlock = false
            else
                isUnlock = true
            end
        end
        if not isUnlock then
            local questVo = QuestConfMgr:GetInstance():GetQuestVoById(checkNumber(dojo.unlockLevel))
            if questVo then
                GameUtils.Toast(localize('通关活动关卡_name_后解锁', { _name_ = questVo.name }))
            end
        else
            CfUtils.DialogOpen(Constants.UITypeIds.ParkourBossMain, { data = self.activityData,  topGoods = clone(self.topGoods) }, {UIArgs(Constants.UITypeIds.ParkourGameOptionDialog)})
        end
    end)
    GameUtils.BindRedPoint(Constants.RedPointConst.MainActivityMinWorldParkGame, self.BtnStartRun, true)
    SetButtonAction(self.BtnStartRun, function()        
        --print("进入 跑酷游戏 activityUuid = " .. tostring(self.activityData.id))
        ---@type PlayerComponent
        local playerComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local curDate = playerComp:GetPlayerDojo():GetServerTimeWithTimeZone()
        local endTime = checkNumber(self.activityData.endTime)
        local leftTime = endTime - curDate
        if leftTime <= 0 then
            return GameUtils.Toast(localize("活动已经结束"))
        end

        -- 防止重复点击:
        CfUtils.StartCoroutineWithBlocker(function()
            Parkour_Loader.TryEnter(self.activityData.id)
        end)

    end)
    self.handler = Events.AddListener("PARK_PROGRESS", function(t)
        if t then
            CfUtils.FillText(self.TxtTaskNumber, checkNumber(t.pro) .. "/" .. checkNumber(t.max))
        end
    end)

    -- ===============================================

    SetButtonAction(self.BtnParkourLevel, function()
        if isNull(self.isParkourBtnUnlock) then 
            return
        end
        if self.isParkourBtnUnlock == false then
            -- local questVo = QuestConfMgr:GetInstance():GetQuestVoById(checkNumber(dojo.unlockLevel))
            -- if questVo then
            --     GameUtils.Toast(localize('通关活动关卡_name_后解锁', { _name_ = questVo.name }))
            -- end
            GameUtils.Toast(localize('尚未解锁'))
        else
            -- 防止重复点击:
            CfUtils.StartCoroutineWithBlocker(function()
                Parkour_Loader.TryEnterGamePrepareDialog(self.activityData.id)
            end)
        end        
    end)
end

function ParkourGameOptionDialog:_FillButtonText(button, findName, activityContentId)
    ---@type Game.Native.Common.ID
    local idComp = CfUtils.GetOrAddComponent(button, typeof(ID))
    CfUtils.FillCfText(button.transform:Find(findName), self:_GetOptionButtonText(activityContentId, idComp.id))
end

function ParkourGameOptionDialog:FreshButtonText()
    local activityContentId = checkNumber(self.activityData.activityContentId)
    self:_FillButtonText(self.BtnStore, "TextDesc", activityContentId)
    self:_FillButtonText(self.BtnTask, "TextDesc", activityContentId)
    self:_FillButtonText(self.BtnWorldBoss, "Layout/Layout/TextDesc", activityContentId)
    self:_FillButtonText(self.BtnStartRun, "Layout/Layout/TextDesc", activityContentId)
    self:_FillButtonText(self.BtnParkourLevel, "Layout/Layout/TextDesc", activityContentId)
end

function ParkourGameOptionDialog:OnFocus(focus)
    if focus then
        if self.topGoods then
            CfUtils.RefreshTopGoods(self.topGoods)
        end
    end
end

---剧情播放中
function ParkourGameOptionDialog:PlayingPlot(storyId, endCb)


    local co = cs_coroutine.start(function()
        local wait = true
        local lastDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.ParkourGameOptionDialog)
        ChapterUtils.ProcessChapter(checkNumber(storyId), function(go)
            self._plotGo = go
            if isNotNull(lastDialog) then
                lastDialog.transform.localPosition = Vector3(9999, 9999, 9999)
            end
            ---
            UINavigationBarRoot.Instance:SetActive(false)
            
        end, function()
            --所有的播完结束
            if isNotNull(lastDialog) then
                lastDialog.transform.localPosition = Vector3(0, 0, 0)
            end
            wait = false
            UINavigationBarRoot.Instance:SetActive(true)

        end)

        while wait do
            coroutine.yield()
        end

        CfUtils.SafeDelete(self._plotGo)

        --dispose
        coroutine.yield()
        if endCb then
            endCb()
        end
    end)
end

function ParkourGameOptionDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        -- !! 不走页面参数, 以便允许外部跳转入本页面;
        -- self.activityData = self.controller.Argument.parameters or {}


        ---@type ActivityConstants
        local ActivityConstants = import("Game.Activity.ActivityConstants")

        local activityId = ActivityMgr:GetActivityIdByActivityType(ActivityConstants.ActivityType.ParkourGame)
        if activityId then
            local activityDojo = ActivityMgr:GetActivityComponent():GetDojoByActivityId(activityId)
            if isNull(activityDojo) then
                printError("没找到 activityDojo, activityId="..tostring(activityId))
                return
            end
            self.activityData = activityDojo
        end

        local success = false
        CfUtils.SetActive(self.BtnTask.transform.parent, false)
        CfUtils.SetActive(self.BtnTask.transform.parent:Find("NpcDialogFrame"), false)
        self:FreshButtonText()
        CriWareUtils.StopAll()
        CriWareUtils.PlayMusic("Audio/bgm_instance_tinyworld", "bgm_story_activity_120001801" )

        GameUtils.Request("activityTinyWorld/home", { activityUuid = self.activityData.id }, function(request, response)
            success = true
            if checkNumber(response.errCode) == 0 then
                self.data = checkTable(response.data)
                Mgr:Clear( true )
                Mgr:SetHomeDojoData(self.data)
                Mgr:SetActivityId(self.activityData.activityContentId)
                Mgr:SetActivityUID(self.activityData.id)
                ---
                self:_RefreshParkourBtn()
                ---@type BackpackComponent
                local component = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.BackpackComponent)
                if component then
                    component.backpack[tostring(self.data.scheduleConf.energyId)] = checkNumber(self.data.hpData.hp)
                end
                local storyId = checkNumber(self.data.scheduleConf.storyId)
                if storyId > 0 then
                    local isFirst = CfUtils.GetLocalData("ParkourGameOptionDialogFirst")
                    if checkNumber(isFirst) == 0 then
                        CfUtils.WriteLocalData("ParkourGameOptionDialogFirst", 1)
                        self:PlayingPlot(storyId)
                    end
                end

                CfUtils.SetActive(self.BtnTask.transform.parent, true)
                self:RefreshUI()
            end
        end)

        while not success do
            coroutine.yield()
        end
        self.topGoods = { Constants.Currency.MiniWorldConsume}
    end))
    return coWait
end

function ParkourGameOptionDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:StopTimer()
        if self.handler then
            Events.RemoveListener("PARK_PROGRESS", self.handler)
        end
        --GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldMainEntry)
        GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldTask)
        GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldAchievementTask)
        GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldParkGame)
        self.handler = nil
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end



function ParkourGameOptionDialog:_RefreshParkourBtn()
    if not self.data then
        printError("调用位置异常, data 为 nil")
        return
    end
    local dojo = self:GetEntryConfig(ParkourType)
    self.isParkourBtnUnlock = false
    if dojo then
        if checkNumber(dojo.unlockLevel) > 0 then -- !!! 解锁条件 具体是什么, 有待确认
            self.isParkourBtnUnlock = false
        else
            self.isParkourBtnUnlock = true
        end
    end
    --- draw:
    local BtnParkourLevelLockSymbol = self.BtnParkourLevel:Find("ImgSymbol")
    CfUtils.SetUISwitchImage( BtnParkourLevelLockSymbol, self.isParkourBtnUnlock and 2 or 1 )
end


function ParkourGameOptionDialog:GetEntryConfig(typeId)
    local dojo
    for i, v in pairs(self.data.entranceConf) do
        if checkNumber(v.type) == typeId then
            dojo = v
            break
        end
    end
    return dojo
end

function ParkourGameOptionDialog:RefreshUI()
    self:RefreshActivityTime()
    CfUtils.FillText(self.TxtStoreTime, CfUtils.GetTimeHMS(checkNumber(self.data.closeTime)))
    CfUtils.FillText(self.TxtTaskNumber, self.data.receivedTaskNum .. "/" .. self.data.taskNum)

    --NPC
    CfUtils.FillText(self.TxtName, "TODO NPC name")
    CfUtils.FillText(self.TextDesc, "TODO NPC talk")

    self:StartTimeDown()
    local dojo = self:GetEntryConfig(BossType)
    local isUnlock = false
    if dojo then
        if checkNumber(dojo.unlockLevel) > 0 and checkNumber(dojo.unlockLevel) > checkNumber(self.data.mainQuestId) then
            isUnlock = true
        end
    end
    CfUtils.SetUISwitchImage(self.ImgBossLock, isUnlock and "1" or "2")
end

function ParkourGameOptionDialog:StopTimer()
    if not isNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end
end

function ParkourGameOptionDialog:StartTimeDown()
    self:StopTimer()
    self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id, countElapsed)
        CfUtils.FillText(self.TxtStoreTime, CfUtils.GetTimeHMS(checkNumber(self.data.closeTime)))
        self.data.closeTime = checkNumber(self.data.closeTime) - countElapsed
        local time = checkNumber(self.data.closeTime)
        if time < 0 then
            self:StopTimer()
            CfUtils.SetActive(self.BtnStore, false)
        end
    end, CountDownTime, false, true)
end

function ParkourGameOptionDialog:RefreshActivityTime()
    local startTime = self.activityData.startTime
    local closeTime = self.activityData.closeTime
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(startTime, closeTime))
end

return ParkourGameOptionDialog