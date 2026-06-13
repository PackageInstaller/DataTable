-- ui 加载完成之后，会通知LUA层进行ctrl创建
function initUICtrl(go, uiName, ctrlClassName, viewClassName)
    UIManager:GetInstance():CreateUI(uiName, go, ctrlClassName, viewClassName)
end

-- UI被动关闭的时候，在C#层通知LUA层进行关闭逻辑
function CloseUIFromCS(uiName)
    UIContextMgr:GetInstance():_Close(uiName)
end

function DestoryUIFromCS(uiName)
    UIContextMgr:GetInstance():_Destory(uiName)
end

-- 通过CS主动打开的
function OpenUIFromCS(uiName, args)
    local length = args.Length
    local arr = {}
    for i = 0, length - 1 do
        table.insert(arr, args[i])
    end
    --解决参数中有nil的情况
    if length ~= #arr then
        local info = { nil, nil, nil, nil, nil, nil, nil }
        for i = 1, length do
            info[i] = args[i - 1]
        end
        arr = info
    end
    UIContextMgr:GetInstance():Show(uiName, table.unpack(arr, 1, length))
end

function Jump(jumpId)
    return GameHelper.Jump(jumpId);
end

function CheckLockByJumpId(jumpId)
    return GameHelper.CheckLockByJumpId(jumpId);
end

function CheckLockByOpenConditionId(openConditionId)
    return GameHelper.CheckLockByOpenConditionId(openConditionId)
end

function CheckLockByOpenConditionIdWithArgs(openConditionId, args)
    return GameHelper.CheckLockByOpenConditionId(openConditionId, args)
end

function CheckLockByOpenConditionIds(openConditionIds)
    return GameHelper.CheckLockByOpenConditionIds(openConditionIds)
end

function CheckAtLastOneOpenConditionUnLock(openConditionIds)
    return GameHelper.CheckAtLastOneOpenConditionUnLock(openConditionIds)
end

function GetLockConditions(openConditionIds)
    return GameHelper.GetLockConditions(openConditionIds)
end

function GetLockCount(openConditionIds)
    return GameHelper.GetLockCount(openConditionIds)
end

function GetFirstLockReason(openConditionIds)
    return GameHelper.GetFirstLockReason(openConditionIds)
end

function CSCheckLockByOpenConditionIds(openConditionIds)
    return GameHelper.CSCheckLockByOpenConditionIds(openConditionIds)
end

function CSCheckLockByOpenConditionIdsWithArgs(openConditionIds, args)
    return GameHelper.CSCheckLockByOpenConditionIdsWithArgs(openConditionIds, args)
end

function CSGetLockConditions(openConditionIds)
    return GameHelper.CSGetLockConditions(openConditionIds)
end

function CSGetLockCount(openConditionIds)
    return GameHelper.CSGetLockCount(openConditionIds)
end

function CSGetUnLockCount(openConditionIds)
    return GameHelper.CSGetUnLockCount(openConditionIds)
end

function CSGetFirstLockReason(openConditionIds)
    return GameHelper.CSGetFirstLockReason(openConditionIds)
end

function CheckJumpBack()
    return GameHelper.CheckJumpBack()
end

function OpenSkillDesUIComTips(text, hrefName, centerX, centerY)
    local alignDir = Vector2.New(0, 0.5)
    local tipsPivot = Vector2.New(0.5, 0)
    local worldPos = Vector3.New(centerX, centerY, 0)
    if string.isNullOrEmpty(hrefName) then return end
    local arr = string.split(hrefName, "|", 1)
    if not arr or #arr < 2 then return end
    local canvas = text.canvas
    local textSize = text:GetTextSize()
    UIContextMgr:GetInstance():Show(UIDefine.UIComTips, {
        worldPos = worldPos,
        title = tonumber(arr[1]),
        content = tonumber(arr[2]),
        canvasTrans = canvas.transform,
        alignDir = alignDir or Vector2.New(-0.5, 0),
        tipsPivot = tipsPivot or Vector2.New(1, 0.5),
        rectSize = Vector2.New(textSize.x + 20, textSize.y + 20),
    })
end

function ExecuteSkillEffect(effectType, casterRole, targetRole, jSkill, effectValues, attackValue, targetPos)
    return GameHelper.ExecuteSkillEffect(effectType, casterRole, targetRole, jSkill, effectValues, attackValue, targetPos)
end

--执先命令
function ExecuteCommand(commandName, args)
    local arr = {}
    for i = 0, args.Length - 1 do
        table.insert(arr, args[i])
    end
    CommandMgr:GetInstance():Execute(commandName, table.unpack(arr))
end

function CheckUICtrlOnBack(uiName)
    local ctrl = UIContextMgr:GetInstance():GetCtrl(uiName)
    if ctrl and ctrl.OnBack then
        return ctrl:OnBack()
    end
    return true
end

function CheckUICtrlOnHome(uiName)
    local ctrl = UIContextMgr:GetInstance():GetCtrl(uiName)
    if ctrl and ctrl.OnHome then
        return ctrl:OnHome()
    end
    return true
end

function CheckUICtrlOnTips(uiName)
    local ctrl = UIContextMgr:GetInstance():GetCtrl(uiName)
    if ctrl and ctrl.OnTips then
        return ctrl:OnTips()
    end
    return true
end

function AddChecker(type, checkPath)
    return RedPointMgr:AddChecker(type, checkPath)
end

function GetOtakuBridgeMaxLevel(callback)
    local roomsData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuType.OtakuRoomType.EST_Bridge)
    if not table.isNullOrEmpty(roomsData) then
        local bridgeLevel = roomsData[1]:Level()
        if callback then
            callback(bridgeLevel)
        end
    end
end

function ShowRolesStarSuccessByCS(csIlistCitems, callback)
    GameHelper.ShowRolesStarSuccessByCS(csIlistCitems, callback)
end

function CtrlOnVisible(uiName, isVisible)
    UIManager:GetInstance():_OnVisible(uiName, isVisible)
end

function CtrlOnDeviceBack(uiName, isVisible)
    return UIManager:GetInstance():_CtrlOnDeviceBack(uiName, isVisible)
end

--获得proto版本文件
function GetProtoMessageVersion()
    return Proto.MessageId.MessageVersion
end

--连接状态改变  1 - 开始连接， 2 - 连接成功 , 3 - 由网络错误导致的断开
function OnConnectStateChange(state)

end

---- missionDataMgr start
---

function GetPassCountById(missionId)
    return MissionDataMgr:GetInstance():GetPassCountById(missionId)
end

function IsMissionPassById(missionId)
    return MissionDataMgr:GetInstance():IsMissionPassById(missionId)
end

function IsPassedChapter(chapterId)
    return MissionDataMgr:GetInstance():IsPassedChapter(chapterId)
end

function GetLastHardMissionId()
    return MissionDataMgr:GetInstance():GetLastHardMissionId()
end

function GetChapterTotalStars(chapterId)
    return MissionDataMgr:GetInstance():GetChapterTotalStars(chapterId)
end

function GetMissionStar(missionId)
    return MissionDataMgr:GetInstance():GetMissionStar(missionId)
end

function GetNextMissionId()
    return MissionDataMgr:GetInstance():GetNextMissionId()
end

function IsRoleChapterReward(chapterId)
    return MissionDataMgr:GetInstance():IsRoleChapterReward(chapterId)
end

---- missionDatamGr end

---- StoryDataMgr start

function TriggerStoryByStoryId(storyId, onCompleteCallback)
    return StoryDataMgr:GetInstance():TriggerStoryByStoryId(storyId, onCompleteCallback)
end

function TriggerStoryByGroupIds(groupIds, missionId, triggerType, onCompleteCallback)
    return StoryDataMgr:GetInstance():TriggerStoryByGroupIds(groupIds, missionId, triggerType, onCompleteCallback)
end

function GetStoryId()
    return StoryDataMgr:GetInstance():GetStoryId()
end

function IsCreateRoleMission(missionId)
    return StoryDataMgr:GetInstance():IsCreateRoleMission(missionId)
end

function FinishStory()
    StoryDataMgr:GetInstance():FinishStory()
end

function StoryNextEvent(index)
    StoryDataMgr:GetInstance():NextStoryByIndex(index)
end

---- StoryDataMgr end

---- ComRoomDataMgr start

function GetComCurrentId()
    return ComRoomDataMgr:GetInstance():GetCurrentId()
end

---- ComRoomDataMgr end

----  HeroDataMgr start
function GetActiveTeamHeroIds()
    local teamData = TeamConfMgr:GetInstance():GetAcitveTeamHeroDatas()
    if IsNull(teamData) then
        return nil
    end
    return teamData.Heroes
end

--获得遭遇战编队英雄
function GetEnTeamHeroIds(index)
    local teamType
    local team = EncounterConfMgr:GetInstance():GetTeamById(index)
    if team then
        return team.Heroes
    end
    return {}
    -- if index == 0 then
    --     teamType = EnTeamConfMgr:GetInstance():GetPlandAId()
    -- elseif index == 1 then
    --     teamType = EnTeamConfMgr:GetInstance():GetPlandBId()
    -- end
    -- local heroIds = EnTeamConfMgr:GetInstance():GetHeroIdsByType(teamType)
    -- return heroIds
end

--获得遭遇战当前关卡编队英雄
function GetBossWarHeroIds()
    local team = BossWarTeamMgr:GetInstance():GetTeamById()
    if team then return team.Heroes end
    return {}
end

--获得遭遇战词条
function GetEnEntrysByTeamIdx(emissionId)
    local enData = EncounterConfMgr:GetInstance():GetEncounterData()
    return enData:GetEntrys(emissionId)
end

--通用助战
function GetHelpHero(teamIndex)
    local hero = TeamConfMgr:GetInstance():GetFriendHeroData(teamIndex)
    return hero.HeroData
end

--遭遇战助战
function GetEnHelpHero(teamIndex)
    local teamData = EncounterConfMgr:GetInstance():GetFriendHeroData(teamIndex)
    if teamData and teamData.FriendId then
        local csHeroData = teamData.HeroData
        return csHeroData --:GetHeroId()
    end
    return 0
end

---   HeroDataMgr end
---
----- Friend

function AddFriend(uid)
    FriendDataMgr:GetInstance():SendRequestAddFriendShip(uid)
end

----  FriendEnd
----

---   GameKeyNodeMgr

function KeyNodeRecord(egameKeyNode, args)
    local arr = {}
    if not IsNull(args) then
        for i = 0, args.Length - 1 do
            table.insert(arr, args[i])
        end
    end
    GameKeyNodeMgr:GetInstance():Record(egameKeyNode, arr)
end

function PrintEventDebug()
    EventMgr:Debug()
end

---   GameKeyNodeMgr END

---   TimeNotifier BEGIN


--定时触发
function ClockUp(hour, minute)
    if hour == 0 then
        -- EventMgr:Broadcast(UIMessageNames.ZERO_CLOCK_NOTIFY,hour,minute)
    elseif hour == 5 then
        -- EventMgr:Broadcast(UIMessageNames.FIVE_CLOCK_NOTIFY,hour,minute)
        -- 跨天
        INetPack.connector:ClockUp()
    end
end

---   TimeNotifier END

function GetTeamNum()
    return TeamConfMgr:GetInstance():GetTeamNum()
end

function GetRandomName()
    return StoryHelper.GetCnRandomName()
end

function GetAwakeDoingTaskId(heroId)
    return TaskDataMgr:GetAwakeDoingTaskId(heroId)
end

--任务是否完成
function IsTaskFinish(taskId)
    local type = TaskDataMgr:_GetTaskType(taskId)
    local state = TaskDataMgr:GetState(type, taskId)
    local bFinish = state == (TaskConst.TaskState.MissionComplete or TaskConst.TaskState.TaskComplete)
    return bFinish
end

--通过事件ID获得英雄ID
function GetHeroIdByEventId(eventId)
    local heroStoryCfg = ConfigHelper.GetCfgs("heroStory")
    if heroStoryCfg then
        for _, cfg in pairs(heroStoryCfg) do
            if cfg.story == eventId then
                return cfg.hero
            end
        end
    end
    return 0
end

function OnModuleChangeComplete(moduleId, hasError)
    ModuleMgr:GetInstance():OnModuleChangeComplete(moduleId, hasError)
end

-- 是否存在指定远征任务
function IsExistExpMission(expMissionId)
    return OtakuHelper.IsExistExpMission(expMissionId)
end

-- 是否解锁扫荡
function IsUnlockMopup(missionId)
    return MissionDataMgr:GetInstance():IsUnlockMopup(missionId)
end

function SetOtakuMainUIHorizontal(value)
    EventMgr:Broadcast(UIMessageNames.SET_OTAKU_MAIN_UI_HONRIZONTAL, value)
end

function IsOtakuAnimatorOnPlay()
    return OtakuHelper.IsOtakuAnimatorOnPlay()
end

function CloseBattleRelatedUI()
    UIContextMgr:GetInstance():Close(UIDefine.ActorHurt)
    UIContextMgr:GetInstance():Close(UIDefine.BattleScreenEffectUI)
end

--通过missionId获得活动副本ID
function GetActivityIdByMissionId(missionId)
    local missionCfg = ConfigHelper.GetCfg("mission", missionId)
    if not IsNull(missionCfg) then
        local chapterId = missionCfg.chapterID
        local allActivityCopys = ConfigHelper.GetCfgs("activityCopy")
        for key, acCfg in pairs(allActivityCopys) do
            if acCfg.chapterId == chapterId or acCfg.specialChapterId == chapterId then
                return acCfg.activityId
            end
        end
    end
    return 0
end

--new一个taskChecker
function GetTaskChecker(_heroId, taskId)
    local checkerClass = require("Battle.Task.TaskChecker")
    local checker = checkerClass.New()
    checker:Init(_heroId, taskId)
    return checker
end

function GetValueByLuaCfg(name, id, key)
    local cfg = ConfigHelper.GetCfg(name, id)
    local value = ""
    if cfg ~= nil then
        if type(cfg[key]) == "table" then
            for key, v in pairs(cfg[key]) do
                value = value .. v .. ','
            end
        else
            value = cfg[key]
        end
    end
    return value
end

function AddAllEncountMissionIdToContainer(zonecontainer, missioncontainer)
    local allzone, allMissionId = EncounterConfMgr:GetInstance():GetAllMissionId()
    for k1, v1 in pairs(allMissionId) do
        missioncontainer:Add(v1)
    end
    for k2, v2 in pairs(allzone) do
        zonecontainer:Add(v2)
    end
end

-- 悬赏关卡战中返回
function RewardMissionBack()
    UIContextMgr:GetInstance():GetContext("MissionOfferRewards"):BattleBack()
    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.MainSceneModule.id)
end
