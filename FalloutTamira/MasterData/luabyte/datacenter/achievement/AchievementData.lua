local AchievementTaskData = require("DataCenter.Achievement.AchievementTaskData")
local M = BaseClass("AchievementData")

function M:Id()
    return self.m_Id
end

function M:Level()
    return self.m_Level
end

function M:IsLoad()
    return self.m_IsLoad
end

function M:Config()
    return self.m_Cfg
end

function M:Tasks()
    return self.m_TaskData
end

function M:Score()
    return self.m_Score
end

function M:DoneNum()
    return self.m_DoneNum
end

function M:RewardNum()
    return self.m_RawardNum
end

function M:ProgressValue()
    return self:Score() / self:AllScore()
end

function M:PreposeComplete(id)
    if id <= 0 then
        return true
    end

    local data = MapUtil.Find(self.m_TaskData, function(v) return id == v:Id() end)
    return data:Complete()
end

function M:AllScore()
    local score = 0

    for k, v in pairs(self.m_TaskData) do
        score = score + v:Score()
    end

    return score
end

function M:Update(data)
    self.m_IsLoad = data ~= nil
    self:RefreshTask(data.achievements)
end


function M:RewardTask(list)
    for i, k in ipairs(list) do
        if k.State == 2 then
            local data = MapUtil.Find(self.m_TaskData, function(v) return k.Id == v:Id() end)
            self.m_Score = self.m_Score + data:Score()
            self.m_RawardNum = self.m_RawardNum - 1
            self.m_DoneNum = self.m_DoneNum + 1
        end

        if k.State == 1 then
            self.m_RawardNum = self.m_RawardNum + 1
        end
    end
    self:RefreshTask(list)
end

function M:RefreshTask(list)
    for i, k in ipairs(list) do
        local index = MapUtil.FindKey(self.m_TaskData, function(v) return k.Id == v:Id() end)
        if index then
            self.m_TaskData[index]:Update(k)
        else
            Logger.LogError("成就Id = " .. tostring(k.Id) .. " 不存在")
        end
    end
    self:_InitLevel()
end

function M:__init(cfg, data, dataMgr)
    self.m_DataMgr = dataMgr
    self.m_Cfg = cfg
    self.m_Id = cfg.id
    self.m_IsLoad = false
    self.m_Level = 0
    self.m_DoneNum = 0
    self.m_Score = data.Score or 0
    self.m_RawardNum = data.AwardNum or 0
    self.m_TaskData = {}
    self:_InitData()
    self:_InitLevel()
end

function M:_InitData()
    for _, v in ipairs(self.m_Cfg.achievement) do
        local cfg = ConfigHelper.GetCfg("achievement", v)
        local item = AchievementTaskData.New(cfg, self)
        local finishData = self.m_DataMgr:FinishDataByTaskId(cfg.id)
        if finishData then
            item:SetFinish(finishData)
            self.m_DoneNum = self.m_DoneNum + 1
        end

        table.insert(self.m_TaskData, item)
    end
end

function M:_InitLevel()
    local upIntegral = self.m_Cfg.upIntegral
    for i, v in ipairs(upIntegral) do
        if self.m_Score >= v then
            self.m_Level = i
        end
    end
end

return M
