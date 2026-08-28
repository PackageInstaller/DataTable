---
--- Created by Eric.
--- DateTime: 2022/10/8 14:21
---

------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")
local UIModule = CS.Engine.UI.UIModule
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local cs_coroutine = require 'XLua.cs_coroutine'
local KTool = CS.Engine.Lib.KTool

------------ import ------------

------------ define ------------
local CONST_ConcertStartId
------------ define ------------

---@class SnowFestivalComponent
local SnowFestivalComponent = Class("SnowFestivalComponent", ECSComponent)
function SnowFestivalComponent:__init()
    self.activityDojo = {}
    self.homeData = {}
    self.activityConfigData = {}--活动表数据
    self.isUnlockNewPlot = false

    self.name = "SnowFestivalComponent"
end

function SnowFestivalComponent:__delete()
    self.activityDojo = nil
    self.homeData = nil
    self.activityConfigData = nil
    self.isUnlockNewPlot = nil

    self.name = nil
end

function SnowFestivalComponent:InitActivityDojo(data)
    self.activityDojo = data

    self.activityConfigData = CfUtils.GetCfVo(AutoIds.IdSetting2840, "SnowFestivalActivityVo", self.activityDojo.activityContentId)
    CONST_ConcertStartId = self.activityConfigData.concertStartId
end

function SnowFestivalComponent:InitHomeData(data)
    --[[
        "unlockedPlotIds": [10101, 10102],
		"point": 10,
		"receivedPlotIds": [10101],
		"taskRedDotHint": -1
    ]]
    self.homeData = data

end

function SnowFestivalComponent:IsEnd()
    local curTime = os.time()
    return self.activityDojo.endTime <= curTime
end

function SnowFestivalComponent:SetTaskPoint(point)
    point = checkNumber(point)
    self.homeData.point = point
end

function SnowFestivalComponent:GetActivityConfigData()
    return self.activityConfigData
end

function SnowFestivalComponent:GetHomeData()
    return self.homeData
end

function SnowFestivalComponent:GetActivityDojo()
    return self.activityDojo
end

function SnowFestivalComponent:GetProgressNumber()
    local numerator, denominator--分子/分母
    numerator = table.count(self.homeData.unlockedPlotIds)
    denominator = self:GetConcertStartIndex()
    return numerator, denominator
end

function SnowFestivalComponent:GetPlotConfigData()
    local plotConfigData = CfUtils.GetWholeVo(AutoIds.IdSetting2841, "SnowFestivalPlotVo")
    return plotConfigData
end

function SnowFestivalComponent:GetConcertStartIndex()
    if isNull(self.concertStartIndex) then
        local plotConfigData = self:GetPlotConfigData()
        for i, v in pairs(plotConfigData) do
            if checkNumber(v.id) == CONST_ConcertStartId then
                self.concertStartIndex = i
            end
        end
    end
    return self.concertStartIndex
end

function SnowFestivalComponent:GetNextPlotIndex()
    local index = 0
    index = table.count(self.homeData.receivedPlotIds)
    if index == table.count(self:GetPlotConfigData()) then
        index = index - 1
    end
    return index
end

function SnowFestivalComponent:GetPlotRewards(plotVo, cb)
    GameUtils.Request(
            Interfaces.ActivityIceSnowFestivalPlotDraw,
            { activityUuid = self.activityDojo.id, plotId = plotVo.id },
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    table.insert(self.homeData.receivedPlotIds, plotVo.id)--维护数据
                    GoodsUtils.DrawRewards(response.data.rewards)
                    UIModule.OpenDialog(
                            {
                                id = Constants.UITypeIds.UICommonRewardPop,
                                parameters = { rewards = response.data.rewards, cb = function()

                                end }
                            }
                    )
                    if cb then
                        cb()
                    end
                end
            end
    )
end

function SnowFestivalComponent:GetSelectedPlotLuaIndex()
    return self.selectedPlotLuaIndex
end

function SnowFestivalComponent:SetSelectedPlotLuaIndex(index)
    self.selectedPlotLuaIndex = index
end

function SnowFestivalComponent:EnterPlot(plotVo, onStart, onFinish)
    local data = QuestConfMgr:GetInstance():GetQuestVoById(plotVo.regionId)
    if checkNumber(data.type) == Constants.QuestBattleType.Story then
        GameUtils.Request(
                Interfaces.ActivityIceSnowFestivalUnlockPlot,
                { activityUuid = self.activityDojo.id, plotId = plotVo.id },
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        table.insert(self.homeData.unlockedPlotIds, plotVo.id)--维护数据
                        self.isUnlockNewPlot = true
                        self:PlayPlot(data, onStart, onFinish)
                    end
                end
        )

    else
        CS.Engine.UI.UIModule.AddUIPage({ id = Constants.UITypeIds.SnowFestivalScoreTaskDialog })
        FightPreWarMgr:GetInstance():FightEnter(data.id, { activityUuid = self.activityDojo.id })
    end

end

function SnowFestivalComponent:UnlockBattlePlot(questId)
    local plotConfigData = self:GetPlotConfigData()
    for i, v in pairs(plotConfigData) do
        if checkNumber(v.regionId) == checkNumber(questId) then
            if not self:IsUnlockPlot(v.id) then
                table.insert(self.homeData.unlockedPlotIds, v.id)--维护数据
            end
        end
    end
end

function SnowFestivalComponent:EnterPlotNoReq(plotVo, onStart, onFinish)
    print("======>>" .. table.dump(plotVo, nil, 3))
    local data = QuestConfMgr:GetInstance():GetQuestVoById(plotVo.regionId)
    print("quest======>>" .. table.dump(data, nil, 3))
    --if checkNumber(data.type) == Constants.QuestBattleType.Story then
    self:PlayPlot(data, onStart, onFinish)
    --else
    --    FightPreWarMgr:GetInstance():FightEnter(data.id,{activityUuid = self.activityDojo.id})
    --end

end

---播放剧情
function SnowFestivalComponent:PlayPlot(vo, startCb, endCb)
    if not vo then
        return
    end
    if self._isPlayPlot then
        return
    end
    self._isPlayPlot = true
    local plotIds = CfUtils.Split(vo.plotId)
    if not plotIds then
        GameUtils.Toast(localize("该关卡没有剧情参数"))
        self._isPlayPlot = false
        return
    end

    self._curPlotIndex = 1
    self:PlayingPlot(plotIds, startCb, endCb)
end

---剧情播放中
function SnowFestivalComponent:PlayingPlot(plotIds, startCb, endCb)
    local co = cs_coroutine.start(function()
        :: start ::
        local wait = true
        ChapterUtils.ProcessChapter(checkNumber(plotIds[self._curPlotIndex]), function(go)
            self._plotGo = go
            if self._curPlotIndex == 1 then
                Events.Broadcast(Constants.EventNames.IsPlotPlaying, true)
                if startCb then
                    startCb()
                end
            end
        end, function()
            --所有的播完结束
            wait = false
        end)

        while wait do
            coroutine.yield()
        end

        KTool.SafeDelete(self._plotGo)

        --dispose
        coroutine.yield()
        if self._curPlotIndex >= table.count(plotIds) then
            GameUtils.PlayMainBGM()
            if endCb then
                endCb()
            end
            Events.Broadcast(Constants.EventNames.IsPlotPlaying, false)
            self._isPlayPlot = false
        else
            self._curPlotIndex = self._curPlotIndex + 1
            goto start
        end
    end)
end

function SnowFestivalComponent:IsUnlockPlot(plotId)
    plotId = checkNumber(plotId)
    local isUnlockPlot = false
    isUnlockPlot = table.isContain(self.homeData.unlockedPlotIds, plotId)
    return isUnlockPlot

end

--活动时间结束
function SnowFestivalComponent:IsUnlockAllPlot()
    local isUnlockAllPlot = self:IsEnd()
    return isUnlockAllPlot
end

function SnowFestivalComponent:IsGetPlot(plotId)
    plotId = checkNumber(plotId)
    local isGetPlot = false
    isGetPlot = table.isContain(self.homeData.receivedPlotIds, plotId)
    return isGetPlot
end

function SnowFestivalComponent:CanGetPlot(plotId)
    plotId = checkNumber(plotId)
    local canGet
    local isUnlockPlot = self:IsUnlockPlot(plotId)
    local isGetPlot = self:IsGetPlot(plotId)
    canGet = isUnlockPlot and (not isGetPlot)
    return canGet
end

return SnowFestivalComponent