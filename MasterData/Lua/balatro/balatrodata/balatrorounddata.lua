







require("Balatro/BalatroData/BalatroSceneData")














BalatroRoundData = {}
BalatroRoundData.__index = BalatroRoundData

function BalatroRoundData.New(configData)

    local self = {}
    self._configData = configData
    self._subRoundData = {}
    self._totalSubRound = 0
    self._sceneEffect = nil
    self._totalScore = 0
    self._brandTypeDatas = {}
    self._validBrandTypeDatas = {}
    self._brandTypeCount = 0
self._extraGoalScore = "0"
self._baseMaxHandBrandCount = BalatroConstVal.DefaultHandCardCount
    self._baltroMaxHandBrandCount = 0
    self._sceneHandBrandCount = 0
    self._propsHandBrandCount = 0
self._GetCardCount = 0
    self._sceneCumulativeWeights = {}
    self._dropCumulativeWeights = {}
    self._curPlaycardTimes = 0
    self._balatroDiscardTimes = 0
    self._curDiscardTimes = 0
    self._balatroPlaycardTimes = 0
    self._scenePlaycardTimes = 0
    self._sceneDiscardTimes = 0
    self._curBrandType = 0
    self._totalUsePropsBrand = 0
self._totalChangeForeverBrandTimes = 0
    self._isLastRound = false
    self._isOncePlaycardCount = false
self._mustPlaycardCount = -1
self._SceneEffectValid = true
self._fixGetBrandCount = 0
self._dropTotalWeight = 0
    self._dropWeights = {}
    self._dropWeightDatas = {}

    self._playcardRecord = {}
    self._discardRecord = {}
    self._usePropsRecord = {}
    self._usingBalatroRecord = {}

    setmetatable(self, BalatroRoundData)
    self:SetSceneEffect()
    local tempIndex = #self._configData.DropWeight
    for key, value in pairs(self._configData.DropWeight) do
        local data = {}
        data.Weight = value
        data.Valid = true
        data.Index = tempIndex
        table.insert(self._dropWeightDatas, data)
        tempIndex = tempIndex - 1
    end
    self:SetDropWeight()
    self:SetBasePlaycardTimes()
    self:SetBaseDiscardTimes()
    return self
end

function BalatroRoundData:GetRoundID()
    return self._configData.ID
end

function BalatroRoundData:GetPhaseIndex()
    return self._configData.Phase
end

function BalatroRoundData:GetRound()
    return self._configData.Round
end

function BalatroRoundData:SetExtraGoalScore(score)
    self._extraGoalScore = score
end

function BalatroRoundData:GetConfigGoalScore()
    return self._configData.Score
end

function BalatroRoundData:GetRealGoalScore()
    return BalatroUtil.Add(self._configData.Score, self._extraGoalScore)
end

function BalatroRoundData:SetFixGetBrandCount(num)
    self._fixGetBrandCount = num
end

function BalatroRoundData:GetFixGetBrandCount()
    return self._fixGetBrandCount
end


function BalatroRoundData:SetBalatroPlaycardTimes(times)
    self._balatroPlaycardTimes = times
end


function BalatroRoundData:SetScenePlaycardTimes(times)
    self._scenePlaycardTimes = times
end


function BalatroRoundData:SetBasePlaycardTimes(num)
    if not num then
        self._basePlaycardTimes = self._configData.PlaycardTimes
    else
        self._basePlaycardTimes = num
    end
end


function BalatroRoundData:SetBalatroDiscardTimes(times)
    self._balatroDiscardTimes = times
end


function BalatroRoundData:SetSceneDiscardTimes(times)
    self._sceneDiscardTimes = times
end


function BalatroRoundData:SetBaseDiscardTimes(num)
    if not num then
        self._baseDiscardTimes = self._configData.DiscardTimes
    else
        self._baseDiscardTimes = num
    end
end


function BalatroRoundData:SetBalatroHandBrandCount(count)
    self._baltroMaxHandBrandCount = count
end


function BalatroRoundData:SetSceneHandBrandCount(count)
    self._sceneHandBrandCount = count
end

function BalatroRoundData:SetPropsHandBrandCount(count)
    self._propsHandBrandCount = count
end

function BalatroRoundData:GetPropsHandBrandCount()
    return self._propsHandBrandCount
end

function BalatroRoundData:GetMaxHandBrandCount()
    local count = self._baseMaxHandBrandCount + self._baltroMaxHandBrandCount + self._sceneHandBrandCount + self._propsHandBrandCount
    return math.max(1, count)
end

function BalatroRoundData:RemainPlaycardTimes()
    local remainTimes = self._basePlaycardTimes + self._balatroPlaycardTimes + self._scenePlaycardTimes - self._curPlaycardTimes
    if remainTimes <= 0 then
        return 0
    end
    return remainTimes
end

function BalatroRoundData:RemainDiscardTimes()
    local remainTimes = self._baseDiscardTimes + self._balatroDiscardTimes + self._sceneDiscardTimes - self._curDiscardTimes
    if remainTimes <= 0 then
        return 0
    end
    return remainTimes
end

function BalatroRoundData:GetTotalScore()
    return self._totalScore
end

function BalatroRoundData:GetResult(isReset)
    local compareRes = BalatroUtil.Compare(self._totalScore, self:GetRealGoalScore())
    if compareRes >= 0 then
        if self._isLastRound == true then
            return BalatroUtil.RoundStatus.GameOverVictory
        end
        return BalatroUtil.RoundStatus.Victory
    end

    if (self:GetIsOncePlaycardCount() == true and self:GetPlaycardTimes() > 0) or self:RemainPlaycardTimes() == 0 then
        return self:GetParticularRes(isReset)
    end
    return BalatroUtil.RoundStatus.Other
end

function BalatroRoundData:GetParticularRes(isReset)
    local compareRes = BalatroUtil.Compare(self._totalScore, self:GetRealGoalScore())
    if compareRes >= 0 then
        if self._isLastRound == true then
            return BalatroUtil.RoundStatus.GameOverVictory
        end
        return BalatroUtil.RoundStatus.Victory
    end
    if self.particularResCondition and self.particularResCondition(self._totalScore, self:GetRealGoalScore(), isReset) then
        if isReset == true then
            self.particularResCondition = nil
        end
        if self._isLastRound == true then
            return BalatroUtil.RoundStatus.GameOverVictory
        end
        return BalatroUtil.RoundStatus.Victory
    end
    if self._isLastRound == true then
        return BalatroUtil.RoundStatus.GameOverDefeat
    end
    return BalatroUtil.RoundStatus.Defeat
end



function BalatroRoundData:SetExtraResultJudge(func)
    self.particularResCondition = func
end



function BalatroRoundData:SetGetBrandJudge(func)
    self.getBrandJudge = func
end

function BalatroRoundData:CallGetBrandJudge(brandDatas, stepType)
    if self.getBrandJudge then
        self.getBrandJudge(brandDatas, stepType)
    end
end



function BalatroRoundData:SetPlaycardCallback(func)
    self.playcardCallback = func
end

function BalatroRoundData:CallPlaycardAfter(brandDatas, stepType)
    if self.playcardCallback then
        return self.playcardCallback(brandDatas, stepType)
    end
    return true, brandDatas
end

function BalatroRoundData:SetSceneEffect()
    local tempTbl = self._configData.SceneEffect
    if not tempTbl or #tempTbl == 0 then
        return
    end
    self.totalSceneWeight = 0
    for i = 1, #tempTbl do
        local data = tempTbl[i]
        self.totalSceneWeight = self.totalSceneWeight + (data[2] or 0)
        table.insert(self._sceneCumulativeWeights, self.totalSceneWeight)
    end
end

function BalatroRoundData:SetDropWeight()
    self.totalDropWeight = 0
    self._dropCumulativeWeights = {}
    for key, data in pairs(self._dropWeightDatas) do
        if data.Valid == true then
            self.totalDropWeight = self.totalDropWeight + data.Weight
            table.insert(self._dropCumulativeWeights, self.totalDropWeight)
        else
            table.insert(self._dropCumulativeWeights, 0)
        end
    end
end

function BalatroRoundData:SetSceneEffectByID(sceneID)
    local configData = BalatroDataMgr.GetSceneConfigByID(sceneID)
    if configData == nil then
        return
    end
    self._sceneEffect = BalatroSceneData.New(configData)
end

function BalatroRoundData:SetSceneEffectValid(valid)
    self._SceneEffectValid = valid
end

function BalatroRoundData:GetSceneEffectValid()
    return self._SceneEffectValid
end


function BalatroRoundData:GetSceneEffect()
    if self._sceneEffect == nil then
        local tempTbl = self._configData.SceneEffect
        if not tempTbl or #tempTbl == 0 then
            return nil
        end
        local randomIndex = BalatroRoundData.GetRandomIDByWeight(self._configData.Round, self.totalSceneWeight, self._sceneCumulativeWeights)
        local sceneID = tempTbl[randomIndex][1]
        LuaDebug.info(string.format("BalatroRoundData:GetSceneEffect 当前阶段:%d 当前回合:%d 随机索引:%d", self._configData.Phase, self._configData.Round, randomIndex) .. debug.traceback())
        local configData = BalatroDataMgr.GetSceneConfigByID(sceneID)
        self._sceneEffect = BalatroSceneData.New(configData)
    end
    return self._sceneEffect
end

function BalatroRoundData:GetDropType(exludeList)
    self:ReduceDropWeight(exludeList)
    if self.totalDropWeight == 0 or #self._dropCumulativeWeights == 0 then
        return BalatroUtil.BalatroOwnStatus.None
    end
    if #self._dropCumulativeWeights == 1 then
        return self._dropWeightDatas[1].Index
    end
    local randomIndex = BalatroRoundData.GetRandomIDByWeight(self._configData.Round, self.totalDropWeight, self._dropCumulativeWeights)
    return self._dropWeightDatas[randomIndex].Index
end

function BalatroRoundData:ReduceDropWeight(exludeList)
    for _, index in ipairs(exludeList) do
        for key, value in pairs(self._dropWeightDatas) do
            if value.Index == index then
                value.Valid = false
                break
            end
        end
    end

    self._dropCumulativeWeights = {}
    self.totalDropWeight = 0
    self:SetDropWeight()
end



function BalatroRoundData:AddPlaycardData(playercardDatas)
    local tempSubRoundIndex = self._totalSubRound + 1
    local subRoundData = self._subRoundData[tempSubRoundIndex]
    if not subRoundData then
        self._subRoundData[tempSubRoundIndex] = {}
        self._subRoundData[tempSubRoundIndex].playerbrandData = {}
    elseif not self._subRoundData[tempSubRoundIndex].playerbrandData then
        self._subRoundData[tempSubRoundIndex].playerbrandData = {}
    end
    table.insert(self._subRoundData[tempSubRoundIndex].playerbrandData, playercardDatas)
    self._totalSubRound = tempSubRoundIndex
    self._curPlaycardTimes = self._curPlaycardTimes + 1
    local recordStr = ""
    for key, value in pairs(playercardDatas) do
        recordStr = string.format("%s|%s", recordStr, value:GetName())
    end
    table.insert(self._playcardRecord, recordStr)
end

function BalatroRoundData:GetPlaycardTimes()
    return self._curPlaycardTimes
end



function BalatroRoundData:AddDiscardData(discardDatas)
    local tempSubRoundIndex = self._totalSubRound + 1
    local subRoundData = self._subRoundData[tempSubRoundIndex]
    if not subRoundData then
        self._subRoundData[tempSubRoundIndex] = {}
        self._subRoundData[tempSubRoundIndex].disbrandData = {}
    elseif not self._subRoundData[tempSubRoundIndex].disbrandData then
        self._subRoundData[tempSubRoundIndex].disbrandData = {}
    end
    table.insert(self._subRoundData[tempSubRoundIndex].disbrandData, discardDatas)
    self._curDiscardTimes = self._curDiscardTimes + 1
    local recordStr = ""
    for key, value in pairs(discardDatas) do
        recordStr = string.format("%s|%s", recordStr, value:GetName())
    end
    table.insert(self._discardRecord, recordStr)
end

function BalatroRoundData:GetDiscardTimes()
    return self._curDiscardTimes
end



function BalatroRoundData:AddUsePropscardData(propsBrandData)
    local tempSubRoundIndex = self._totalSubRound + 1
    local subRoundData = self._subRoundData[tempSubRoundIndex]
    if not subRoundData then
        self._subRoundData[tempSubRoundIndex] = {}
    end
    if self._subRoundData[tempSubRoundIndex].propBrandData == nil then
        self._subRoundData[tempSubRoundIndex].propBrandData = {}
    end
    table.insert(self._subRoundData[tempSubRoundIndex].propBrandData, propsBrandData)
    self._totalUsePropsBrand = self._totalUsePropsBrand + 1
    table.insert(self._usePropsRecord, propsBrandData:GetName())
end

function BalatroRoundData:GetUsePropsBrandTimes()
    return self._totalUsePropsBrand
end


function BalatroRoundData:AddChangeForeverTimes()
    self._totalChangeForeverBrandTimes = self._totalChangeForeverBrandTimes + 1
end

function BalatroRoundData:GetChangeForeverTimes()
    return self._totalChangeForeverBrandTimes
end

function BalatroRoundData:SetUsingForeverData(datas)
    local recordStr = ""
    for key, value in pairs(datas) do
        recordStr = string.format("%s|%s", recordStr, value:GetName())
    end
    table.insert(self._usingBalatroRecord, recordStr)
end


function BalatroRoundData:SetSubRoundScore(score)
    local tempSubRoundIndex = self._totalSubRound + 1
    local subRoundData = self._subRoundData[tempSubRoundIndex]
    if not subRoundData then
        self._subRoundData[tempSubRoundIndex] = {}
    end
    self._subRoundData[tempSubRoundIndex].roundScore = score
    self._totalScore = BalatroUtil.Add(self._totalScore, score)
end

function BalatroRoundData:UpdateBrandType(brandType)
    self._brandTypeDatas[brandType] = (self._brandTypeDatas[brandType] or 0) + 1
    if self:CheckBrandTypeValid(brandType) == true then
        self._validBrandTypeDatas[brandType] = (self._validBrandTypeDatas[brandType] or 0) + 1
    end
end

function BalatroRoundData:GetBrandTypeDatas()
    return self._brandTypeDatas
end

function BalatroRoundData:SetCurBrandType(brandType)
    self._curBrandType = brandType
end

function BalatroRoundData:GetCurBrandType()
    return self._curBrandType
end


function BalatroRoundData:SetIsLastRound(isLast)
    self._isLastRound = isLast
end



function BalatroRoundData:SetIsOncePlaycardCount(isOnce)
    self._isOncePlaycardCount = isOnce
end

function BalatroRoundData:GetIsOncePlaycardCount()
    return self._isOncePlaycardCount
end


function BalatroRoundData:SetMustPlaycardCount(count)
    self._mustPlaycardCount = count
end

function BalatroRoundData:GetMustPlaycardCount()
    return self._mustPlaycardCount
end




function BalatroRoundData:SetBrandTypeCountCondition(conditon)
    self._brandTypeCount = conditon
end

function BalatroRoundData:CheckBrandTypeValid(brandType)

    if self._brandTypeCount == 20 then
        local brandTypeCount = self._validBrandTypeDatas[brandType]
        if not brandTypeCount then
            return true, brandType
        end
        if brandTypeCount > 0 then
            return false, brandType
        end
    elseif self._brandTypeCount > 0 then
        if NumTool.GetLen(self._validBrandTypeDatas) < self._brandTypeCount or self._validBrandTypeDatas[brandType] ~= nil then
            return true, brandType
        end
        local tempBrandType = 0
        for key, value in pairs(self._validBrandTypeDatas) do
            if key ~= brandType then
                tempBrandType = key
            end
        end
        return false, tempBrandType
    end
    return true, brandType
end

function BalatroRoundData:GetAllRecord()
    local tbl = {}
    if self._playcardRecord ~= nil and #self._playcardRecord > 0 then
        tbl["PlaycardData"] = self._playcardRecord
    end
    if self._discardRecord ~= nil and #self._discardRecord > 0 then
        tbl["DiscardData"] = self._discardRecord
    end
    if self._usePropsRecord ~= nil and #self._usePropsRecord > 0 then
        tbl["UsePropsData"] = self._usePropsRecord
    end
    if self._usingBalatroRecord ~= nil and #self._usingBalatroRecord > 0 then
        tbl["UseBalatroData"] = self._usingBalatroRecord
    end
    if self._sceneEffect ~= nil then
        tbl["RoundSceneData"] = string.format("%s(%d)", self._sceneEffect:GetName(), self._sceneEffect:GetID())
    end
    return json.encode(tbl)
end



BalatroRoundData.GetRandomIDByWeight = function(seed, totalWeight, cumulativeWeights)
    math.randomseed(os.time() + seed)
    local randomValue = math.random(0, totalWeight - 1)
    local low, high = 1, #cumulativeWeights
    while low < high do
        local mid = math.floor((low + high) / 2)
        if randomValue < cumulativeWeights[mid] then
            high = mid
        else
            low = mid + 1
        end
    end
    return low
end