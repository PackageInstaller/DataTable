local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("GuideStateData", baseClass)

function M:__init()
    self.m_guideFlag1 = 0
    self.m_saveFinish = nil
    self.m_maxValue = 4294967295
    self.m_cycleType = protocol.ECycleEvent.ECET_Novice_Guide
end

function M:UpdateData(eventData)
    M.super.UpdateData(self, eventData)
    self.m_guideFlag1 = self.m_cycleData.Field0
    if self.m_saveFinish then self.m_saveFinish() end
    self.m_saveFinish = nil
end

function M:GetSaveState()
    -- body
    return GameHelper.ConvertByHex(self.m_guideFlag1, 2)
end

function M:GetAddFlag(guideId)
    -- body
    return self.m_guideFlag1 | (1 << (guideId - 1))
end

function M:SaveAllGuide()
    -- body
    self:_SendRequest(self.m_maxValue)
end

function M:ClearAllGuide()
    -- body
    self:_SendRequest(0)
end

function M:ResetSave(guideId)
    local value = self.m_maxValue ^ (1 << (guideId - 1))
    self.m_guideFlag1 = self.m_guideFlag1 & value
    self:_SendRequest(self.m_guideFlag1)
end

function M:SaveGuide(guideId, finish)
    local newGuideFlag = self:GetAddFlag(guideId)
    Logger.Log("save: guideId =  " .. guideId .. " , flag = " .. newGuideFlag)
    self:_SendRequest(newGuideFlag)
    self.m_saveFinish = finish
    self.m_guideFlag1 = self.m_guideFlag1 | newGuideFlag
end

function M:IsGuideDone(guideId)
    if guideId > 32 or guideId <= 0 then return false end
    return (self.m_guideFlag1 & (1 << (guideId - 1))) ~= 0
end

function M:_SendRequest(arg0, arg1, arg2)
    local request = {}
    request.Value0 = arg0 or 0
    request.Value1 = arg1 or 0
    request.Value2 = arg2 or 0
    NetPack:SendMessage(Proto.MessageId.RequestUpdateGuide, request)
end

return M
