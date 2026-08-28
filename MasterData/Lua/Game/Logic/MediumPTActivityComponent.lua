---
--- Created by Eric.
--- DateTime: 2022/6/11 14:01
---

------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local ParseUtils = CS.ParseUtils
local KTool = CS.Engine.Lib.KTool

------------ import ------------

------------ define ------------

------------ define ------------


---@class MediumPTActivityComponent
local MediumPTActivityComponent = Class("MediumPTActivityComponent", ECSComponent)
function MediumPTActivityComponent:__init()
    self.activityPlotQuest = {}
    self.starInfo = {}
    self.plotQuestReview = {}
    self.isInReview = false

    self.name = "MediumPTActivityComponent"
end

function MediumPTActivityComponent:__delete()
    self.activityPlotQuest = nil
    self.starInfo = nil
    self.plotQuestReview = nil
    self.isInReview = nil

    self.name = nil

end

function MediumPTActivityComponent:IsEnd()
    local curTime = os.time()
    return self.activityPlotQuest.endTime <= curTime
end

function MediumPTActivityComponent:ResetReviewData()
    self.plotQuestReview = {}

end

function MediumPTActivityComponent:IsInReview()
    return self.isInReview
end

function MediumPTActivityComponent:GetPlotQuest()
    local isReview = self:IsInReview()
    if isReview then
        return self.plotQuestReview
    else
        return self.plotQuest
    end
end

function MediumPTActivityComponent:InitCheckInData(data)
    -- print("PTCheckin------>>"..table.dump(data,nil, 3))
    self.activityPlotQuest = checkTable(data)
end

function MediumPTActivityComponent:InitHomeData(data)
    -- print("PTHome------>>"..table.dump(data,nil, 3))
    self.activityConf = checkTable(data.activityConf)--中型PT活动表
    self.activityConf.sceneId = ParseUtils.ParsePathNameByData(self.activityConf.sceneId)
    self.activityConf.showCardBg = ParseUtils.ParsePathNameByData(self.activityConf.showCardBg)
    self.activityConf.bossIcon = ParseUtils.ParsePathNameByData(self.activityConf.bossIcon)
    --self.activityQuestConf = checkTable(data.activityQuestConf)--中型PT复刷副本类型表
    self.plotQuest = checkTable(data.plotQuest)--key 关卡类型 value 通关的剧情关卡id
    self.isDrawPlotRewards = checkNumber(data.isDrawPlotRewards)--0:未领取 1:可领取 2:已领取
    self.challengeQuestInfo = checkTable(data.challengeQuestInfo)--key 关卡id value 星级
    self.rewardsPoint = checkNumber(data.rewardsPoint)--奖励的累计积分
    
    --list 任务进度 对应中型PT点数累计奖励表
    --{
    --    {
    --        id = 1,
    --        status = 1,状态 0:未领取 1:可领取 2:已领取
    --    }
    --}
    self.rewardsInfo = checkTable(data.rewardsInfo)

    for k, v in pairs(self.challengeQuestInfo) do
        local _, conditions = QuestConfMgr:GetInstance():GetQuestConditions(checkString(k))
        if conditions then
            local _t = {}
            local count = 0
            v = table.values(v)
            for m, cdt in pairs(conditions) do
                count = count + 1
                _t[checkString(cdt.id)] = (table.keyof(v, count) and 1 or 0)
            end
            self.starInfo[checkString(k)] = _t
        end
    end

end

function MediumPTActivityComponent:InitTestFakeData()
    self.activityPlotQuest = {
        activityUuid = 1,
        startTime = 100,
        endTime = 100,
        closeTime = 3600,
    }
    --中型活动表的当期活动数据
    self.activityConf = {
        id = 1,
        name = "活动表1",
        ptItem = 9000045,
        storyItem = 9000046,
        rewardItem = "9000045;300002",
        rewardNum = "90000;1000",
        showCard = 101003,
        sceneId = ParseUtils.ParsePathNameByData("102:a_bg_1003_1_220228"),
        storyEndId = 192,
        bossName = "类型表1",
        bossIcon = ParseUtils.ParsePathNameByData("64:auto_jpg_icon_01"),

    }

    --self.activityQuestConf = {
    --    id = 1,
    --    activetyId = 1,
    --    name = "类型表1",
    --    regionIcon = ParseUtils.ParsePathNameByData("64:auto_jpg_icon_01"),
    --}

    self.plotQuest = {}
    self.isDrawPlotRewards = 0
    self.challengeQuestInfo = {}
    self.rewardsPoint = 1000
    self.rewardsInfo = {
        {
            id = 1,
            status = 0
        },
        {
            id = 2,
            status = 1
        },
        {
            id = 3,
            status = 2
        },
        {
            id = 4,
            status = 0
        },
        {
            id = 5,
            status = 1
        },
    }
end

function MediumPTActivityComponent:IsFinishRolePlot()
    local currentActivityId = checkNumber(self.activityConf.id)
    local vo = CfUtils.GetWholeVo(AutoIds.IdSetting2553, "MediumPTPlotVo")
    local plotMap = {}
    for i, v in pairs(vo) do
        if v.activityId == currentActivityId then
            local pos = checkString(v.pos)
            if not plotMap[pos] then
                plotMap[pos] = {

                }
            end
            table.insert(plotMap[pos], v)
        end
    end
    local plotQuest = self:GetPlotQuest()
    local isEnd = true
    for i = 1, 4 do
        local plotLuaIndex
        local pos = checkString(i)
        local plotId
        local list =  plotMap[pos]
        if not plotQuest[pos] then--当前入口通关数据为空
            --plotData = plotMap[pos][1]
            plotLuaIndex = 1
        else
            plotId = plotQuest[pos] + 1--初值默认到下一关
            for i, v in pairs(list) do
                if checkNumber(v.id) == plotId then
                    --plotData = v
                    plotLuaIndex = i
                end
                if checkNumber(plotQuest[pos]) == checkNumber(v.id) then
                    if v.endFlag == 1 then
                        --plotId = plotQuest[pos]
                        --plotData = v
                        plotLuaIndex = i
                        break
                    end
                end
            end
        end
        local plotData = list[plotLuaIndex]
        --print("----->>"..table.dump(plotData))
        isEnd = checkNumber(plotData.id) == checkNumber(plotQuest[pos]) --plotData.endFlag == 1
        if not isEnd then
            return isEnd
        end
    end
    return isEnd
end


function MediumPTActivityComponent:IsPassLevelById(levelId)
    return self.challengeQuestInfo[tostring(levelId)] ~= nil--与后端约定通关零星的数据为[“60105” ] = {}
end

---IsCompleteCondition 根据星的条件id判断是否已达成
---@param levelId string 关卡id
---@param conditionId string 条件id
function MediumPTActivityComponent:IsCompleteCondition(levelId, conditionId)
    local levelStarInfo = self.starInfo[checkString(levelId)]
    if levelStarInfo then
        if checkNumber(levelStarInfo[conditionId]) == 1 then
            return true
        end
    end
    return false
end

function MediumPTActivityComponent:EnterPlot(pos, id, onStart, onFinish)
    GameUtils.Request(
            Interfaces.ActivityPlotQuestPlot,
            { activityUuid = self.activityPlotQuest.activityUuid, questId = id },
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    self.plotQuest[pos] = id
                    local data = CfUtils.GetCfVo(AutoIds.IdSetting2553, "MediumPTPlotVo", id)
                    local go
                    ChapterUtils.ProcessChapter(data.plotId, function(g)
                        Events.Broadcast(Constants.EventNames.IsPlotPlaying, true)
                        if onStart then
                            onStart()
                        end
                        go = g
                    end, function()
                        if onFinish then
                            onFinish()
                        end
                        KTool.SafeDelete(go)
                        Events.Broadcast(Constants.EventNames.IsPlotPlaying, false)
                    end)
                end
            end
    )
end

function MediumPTActivityComponent:EnterPlotNoReq(pos, id, onStart, onFinish)
    local data = CfUtils.GetCfVo(AutoIds.IdSetting2553, "MediumPTPlotVo", id)
    local go
    if self:IsInReview() then
        self.plotQuestReview[pos] = id
    end
    ChapterUtils.ProcessChapter(data.plotId, function(g)
        Events.Broadcast(Constants.EventNames.IsPlotPlaying, true)
        if onStart then
            onStart()
        end
        go = g
    end, function()
        if onFinish then
            onFinish()
        end
        KTool.SafeDelete(go)
        Events.Broadcast(Constants.EventNames.IsPlotPlaying, false)
    end)
end



return MediumPTActivityComponent