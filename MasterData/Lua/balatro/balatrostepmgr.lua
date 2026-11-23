







require("Balatro/BalatroData/BalatroRoundData")
BalatroStepMgr = {}



local gameSessionData = {
    gameOver = false,
    realStart = false,
    globalSceneEffect = nil,
curPhaseNum = 1,
curRoundNum = 0,

totalScore = 0,
bestPlaycardScore = "",

phaseData = {}
}


function BalatroStepMgr.GameInit()
    gameSessionData.realStart = false
    gameSessionData.gameOver = false
    gameSessionData.curPhaseNum = 1
    gameSessionData.oldPhaseNum = nil
    gameSessionData.curRoundNum = 1
    gameSessionData.totalScore = 0
    gameSessionData.bestPlaycardScore = ""
end

function BalatroStepMgr.GameStart()
    gameSessionData.realStart = true
    BalatroDataMgr.SetGameStartTime(LuaMgr.Timestamp())
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()
    for _, value in pairs(balatroBrands) do
        local params = {}
        params.StepType = BalatroUtil.StepType.GameStart
        value:Execute(nil, params)
    end
end


function BalatroStepMgr.GameEnd()

end


function BalatroStepMgr.CheckNewGame()
    return gameSessionData.oldPhaseNum == nil
end


function BalatroStepMgr.CheckNewPhase()
    if gameSessionData.oldPhaseNum == gameSessionData.curPhaseNum then
        return false
    end
    return true
end

function BalatroStepMgr.CheckGameRealStart()
    return gameSessionData.realStart
end


function BalatroStepMgr.PhaseStart()
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()
    for _, value in pairs(balatroBrands) do
        local params = {}
        params.StepType = BalatroUtil.StepType.PhaseStart
        value:Execute(nil, params)
    end
    gameSessionData.oldPhaseNum = gameSessionData.curPhaseNum
end


function BalatroStepMgr.PhaseEnd()
end


function BalatroStepMgr.RoundStart()
    BalatroDataMgr.Flush_Straight_NeedCount = 5
    BalatroDataMgr.IsUseExtra_Style = false
    BalatroDataMgr.Straight_IsPart = false
    BalatroDataMgr.IsLowBrandTypeLevel = false
    BalatroDataMgr.WeakStyle = 0
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()
    curRoundData:SetUsingForeverData(balatroBrands)
    for _, value in pairs(balatroBrands) do
        if value:GetSelectRoundID() == nil then
            value:SetSelectRoundID(curRoundData:GetRoundID())
        end
    end
    local allBrandTypeData = BalatroDataMgr.GetBrandTypeDatas()
    for _, value in pairs(allBrandTypeData) do
        value:CalBeforeReset()
    end
    local mainBrandPool = BalatroDataMgr.GetMainBrandPool()
    for key, value in pairs(mainBrandPool) do
        value:SetWeaken(false)
        value:SetIsTurnOver(false)
    end
    local curRoundSceneData = curRoundData:GetSceneEffect()
    local globalSceneData = gameSessionData.globalSceneEffect
    if globalSceneData and globalSceneData:GetCalTime() == BalatroUtil.CalFrequency.EveryRoundStart then
        if curRoundData:GetSceneEffectValid() == true then
            globalSceneData:Execute(nil, curRoundData)
        end
    end

    if curRoundSceneData and curRoundSceneData:GetCalTime() == BalatroUtil.CalFrequency.EveryRoundStart then
        if curRoundData:GetSceneEffectValid() == true then
            curRoundSceneData:Execute(nil, curRoundData)
        end
    end

    for _, value in pairs(balatroBrands) do
        value:Execute(nil, curRoundData)
    end
    curRoundData:SetPropsHandBrandCount(BalatroDataMgr.GetPropHandBrandLimit())
end


function BalatroStepMgr.RoundEnd()
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()
    for _, value in pairs(balatroBrands) do
        local params = {}
        params.StepType = BalatroUtil.StepType.RoundEnd
        value:SetInvalid(false)
        value:Execute(nil, params)
    end
end

function BalatroStepMgr.AfterUsePropsBrand()
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()
    for _, value in pairs(balatroBrands) do
        local params = {}
        local config = value:GetConfig()
        if config.ConditionType1 == BalatroUtil.ConditionType.PropsBrand then
            value:Execute(nil, params)
        end
    end
end




function BalatroStepMgr.PlaycardBefore(brandDataLst)
    local globalSceneData = gameSessionData.globalSceneEffect
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    BalatroStepMgr.playcardDataLst = brandDataLst
    if globalSceneData and globalSceneData:GetCalTime() == BalatroUtil.CalFrequency.BeforePlaycard then
        if curRoundData:GetSceneEffectValid() == true then
            return globalSceneData:Execute(brandDataLst, curRoundData)
        end
    end
    local curRoundSceneData = curRoundData:GetSceneEffect()
    if curRoundSceneData and curRoundSceneData:GetCalTime() == BalatroUtil.CalFrequency.BeforePlaycard then
        if curRoundData:GetSceneEffectValid() == true then
            return curRoundSceneData:Execute(brandDataLst, curRoundData)
        end
    end
    return true, "BalatroStepMgr.PlaycardBefore Error"
end


function BalatroStepMgr.PlaycardAfter()
    BalatroDataMgr.Flush_Straight_NeedCount = 5
    BalatroDataMgr.IsUseExtra_Style = false
    BalatroDataMgr.Straight_IsPart = false
    local brandDataLst = BalatroStepMgr.playcardDataLst

    for key, value in pairs(brandDataLst) do
        value:SetJoinCal(false)
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local globalSceneData = gameSessionData.globalSceneEffect
    if globalSceneData and globalSceneData:GetCalTime() == BalatroUtil.CalFrequency.EveryTimePlay then
        globalSceneData:Execute(brandDataLst, BalatroStepMgr.GetCurRoundData())
    end
    local roundSceneEffect = curRound:GetSceneEffect()
    if roundSceneEffect and roundSceneEffect:GetCalTime() == BalatroUtil.CalFrequency.EveryTimePlay then
        roundSceneEffect:Execute(brandDataLst, curRound)
    end

    local brandType = BalatroStepMgr.GetBrandType(brandDataLst)
    curRound:SetCurBrandType(brandType)
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()

    for _, value in pairs(balatroBrands) do
        value:Execute(brandDataLst, curRound)
    end

    brandType = BalatroStepMgr.GetBrandType(brandDataLst)
    curRound:SetCurBrandType(brandType)

    local generalScore = 0
    local generalRate = 0

    local brandTypeScore = 0
    local brandTypeRate = 0

    local brandTypeValid, validBrandType = curRound:CheckBrandTypeValid(brandType)
    if brandTypeValid == true or validBrandType ~= brandType then
        curRound:UpdateBrandType(validBrandType)
        local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(validBrandType)
        brandTypeData:AddValidTimes()

        local validBrandDatas = BalatroStepMgr.GetBrandTypeValidBrand(brandType, brandDataLst)

        generalScore, generalRate = BalatroStepMgr.GetBrandScoreAndRate(validBrandDatas)
        if #validBrandDatas > 0 then
            brandTypeScore = BalatroStepMgr.GetBrandTypeScore(validBrandType)
            brandTypeRate = BalatroStepMgr.GetBrandTypeRate(validBrandType)
        end
        for key, value in pairs(validBrandDatas) do
            value:SetJoinCal(true)
        end
    end

    local balatroScore, balatroAddRate, balatroMuliRate = BalatroStepMgr.GetBalatroInfo(balatroBrands)

    local res1 = BalatroUtil.Add(generalScore, brandTypeScore)
    local res2 = BalatroUtil.Add(res1, balatroScore)


    local part1 = BalatroUtil.Muli(res2, 1)
    local part2 = (brandTypeRate + balatroAddRate + generalRate) * balatroMuliRate

    local totalScore = BalatroUtil.Muli(part1, part2)

    curRound:AddPlaycardData(brandDataLst)
    curRound:SetSubRoundScore(totalScore)
    gameSessionData.totalScore = BalatroUtil.Add(gameSessionData.totalScore, totalScore)
    if BalatroUtil.Compare(gameSessionData.bestPlaycardScore, totalScore) < 0 then
        gameSessionData.bestPlaycardScore = totalScore
    end
end

BalatroStepMgr.GetPlaycardResData = function()
    return BalatroStepMgr.PlaycardResDatas
end



function BalatroStepMgr.DiscardBefore(brandDataLst)
    BalatroStepMgr.discardDataLst = brandDataLst
    local curRound = BalatroStepMgr.GetCurRoundData()
    local globalSceneData = gameSessionData.globalSceneEffect
    if globalSceneData and globalSceneData:GetCalTime() == BalatroUtil.CalFrequency.BeforePlaycard then
        if curRound:GetSceneEffectValid() == true then
            globalSceneData:Execute(nil, curRound)
        end
    end
    local curRoundSceneData = curRound:GetSceneEffect()
    if curRoundSceneData and curRoundSceneData:GetCalTime() == BalatroUtil.CalFrequency.BeforePlaycard then
        if curRound:GetSceneEffectValid() == true then
            curRoundSceneData:Execute(nil, curRound)
        end
    end

    if curRound:RemainDiscardTimes() <= 0 then
        return false
    end
    return true
end


function BalatroStepMgr.DiscardAfter()
    BalatroDataMgr.Flush_Straight_NeedCount = 5
    BalatroDataMgr.IsUseExtra_Style = false
    BalatroDataMgr.Straight_IsPart = false
    local curRound = BalatroStepMgr.GetCurRoundData()
    local globalSceneData = gameSessionData.globalSceneEffect
    if globalSceneData and globalSceneData:GetCalTime() == BalatroUtil.CalFrequency.EveryTimePlay then
        globalSceneData:Execute(nil, BalatroStepMgr.GetCurRoundData())
    end
    local roundSceneEffect = curRound:GetSceneEffect()
    if roundSceneEffect and roundSceneEffect:GetCalTime() == BalatroUtil.CalFrequency.EveryTimePlay then
        roundSceneEffect:Execute(nil, curRound)
    end
    local balatroBrands = BalatroDataMgr.GetUsingBalatroLst()
    for _, value in pairs(balatroBrands) do
        value:Execute(nil, curRound)
    end

    local brandDataLst = BalatroStepMgr.discardDataLst
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:AddDiscardData(brandDataLst)
    coroutine_runner.wait(1)
end

function BalatroStepMgr.OnCheckGameEnd(param, isReset)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local result = curRound:GetResult(isReset)
    if param and param.Length > 0 then
        local data = param[0]
        if data.status == BalatroUtil.RoundStatus.Exit then
            return BalatroUtil.RoundStatus.Defeat
        end

        if result == BalatroUtil.RoundStatus.Victory then
            return BalatroUtil.RoundStatus.Victory
        end
        return data.status
    end
    local mainPool = BalatroDataMgr.GetMainBrandPool()
    local brandDatas = BalatroDataMgr.GetHandBrandDataList()

    if #mainPool + #brandDatas <= 0 then
        return curRound:GetParticularRes(isReset)
    end
    return result
end

function BalatroStepMgr.SetNextRound()
    local tempRoundNum = gameSessionData.curRoundNum + 1
    local roundDatas, phaseIndex = BalatroStepMgr.GetCurPhaseData()
    local tempPhase = phaseIndex
    if tempRoundNum > #roundDatas then
        tempRoundNum = 1
        tempPhase = tempPhase + 1
    end
    if not gameSessionData.phaseData[tempPhase] then
        gameSessionData.gameOver = true
        return
    end
    gameSessionData.curPhaseNum = tempPhase
    gameSessionData.curRoundNum = tempRoundNum
end



function BalatroStepMgr.InitRoundData(configs)
    local configLen = #ConfigMgr.Config.BalatroSceneList
    local configDic = {}
    for i = 1, configLen do
        local configData = ConfigMgr.Config.BalatroSceneList[i]
        if configData.SceneType == 0 then
            configDic[configData.ID] = configData
        end
    end
    local configLen = #configs
    gameSessionData.phaseData = {}
    local tempPhaseTbl = gameSessionData.phaseData
    for i = 1, configLen do
        local configData = configs[i]
        if not tempPhaseTbl[configData.Phase] then
            tempPhaseTbl[configData.Phase] = {}
        end
        local roundData = BalatroRoundData.New(configData)
        if i == configLen then
            roundData:SetIsLastRound(true)
        end
        table.insert(tempPhaseTbl[configData.Phase], roundData)
    end
end

function BalatroStepMgr.SetGameOver()
    gameSessionData.gameOver = true
end

function BalatroStepMgr.CheckIsGameOver()
    return gameSessionData.gameOver
end


function BalatroStepMgr.SetGlobalSceneEffect(sceneData)
    gameSessionData.globalSceneEffect = sceneData
end


function BalatroStepMgr.GetGlobalSceneEffect()
    return gameSessionData.globalSceneEffect
end

function BalatroStepMgr.GetAllPhaseData()
    return gameSessionData.phaseData
end

function BalatroStepMgr.GetGlobalTotalScore()
    return gameSessionData.totalScore
end


function BalatroStepMgr.AddCalExtraScore(score)
    gameSessionData.totalScore = BalatroUtil.Add(gameSessionData.totalScore, score)
end

function BalatroStepMgr.GetBestPlaycardScore()
    return gameSessionData.bestPlaycardScore
end


function BalatroStepMgr.GetCurPhaseData()
    if not gameSessionData.phaseData then
        LuaDebug.error("BalatroStepMgr.GetCurPhaseData 阶段数据异常 gameSessionData.curPhaseNum:" .. gameSessionData.curPhaseNum)
        return nil
    end
    return gameSessionData.phaseData[gameSessionData.curPhaseNum], gameSessionData.curPhaseNum
end




function BalatroStepMgr.GetCurRoundData()
    local roundDatas = BalatroStepMgr.GetCurPhaseData()
    if roundDatas == nil then
        LuaDebug.error("BalatroStepMgr.GetCurRoundData : 当前回合数据异常" .. debug.traceback())
        return {}
    end
    local curRound = gameSessionData.curRoundNum
    if not roundDatas or not roundDatas[curRound] then
        LuaDebug.error(string.format("BalatroStepMgr.GetCurRoundData : 当前回合数据异常 curRound:%d", curRound))
        return {}
    end
    return roundDatas[curRound]
end


function BalatroStepMgr.GetPlaycardTimes()
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    if not curRoundData then
        LuaDebug.error("BalatroStepMgr.GetPlaycardTimes : 当前回合数据异常")
        return 0
    end
    return curRoundData:RemainPlaycardTimes()
end


function BalatroStepMgr.GetPlaycardTimesScore()
    return BalatroStepMgr.GetPlaycardTimes() * (BalatroConstVal.PlaycardTimesScore or 0)
end


function BalatroStepMgr.GetDiscardTimes()
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    if not curRoundData then
        LuaDebug.error("BalatroStepMgr.GetDiscardTimes : 当前回合数据异常")
        return 0
    end
    return curRoundData:RemainDiscardTimes()
end


function BalatroStepMgr.GetDiscardTimesScore()
    return BalatroStepMgr.GetDiscardTimes() * (BalatroConstVal.DiscardTimesScore or 0)
end



function BalatroStepMgr.GetBrandType(brandDatas)
    return BalatroBrandTypeData.GetBrandType(brandDatas)
end




function BalatroStepMgr.GetAllBrandType(brandDatas)
    return BalatroBrandTypeData.GetAllBrandType(brandDatas)
end





BalatroStepMgr.GetBrandScoreAndRate = function(brandDataLst)
    local dataLen = #brandDataLst
    local totalScore = 0
    local totalRate = 0
    BalatroStepMgr.PlaycardResDatas = {}
    for i = 1, dataLen do
        local data = brandDataLst[i]
        local tempScore = data:GetPoint() + data:GetExtraScore()
        totalScore = totalScore + tempScore
        totalRate = totalRate + data:GetExtraRate()

        local resData = {}
        resData.brandData = data
        resData.score = tempScore
        resData.rate = data:GetExtraRate()
        table.insert(BalatroStepMgr.PlaycardResDatas, resData)
    end
    return totalScore, totalRate
end




BalatroStepMgr.GetBrandTypeValidBrand = function(brandTypeID, brandDataLst)
    local tempValidBrands = {}
    local pointDic = {}
    local stylesDic = {}
    local isUseExtraStyle = BalatroDataMgr.IsUseExtra_Style
    table.sort(brandDataLst, BalatroUtil.SortBrandByPointDescend)
    for key, value in pairs(brandDataLst) do
        local showPoint = value:GetShowPoint()
        local style = value:GetStyle()
        local extraSytle = value:GetExtraStyle()
        if pointDic[showPoint] == nil then
            pointDic[showPoint] = {}
        end
        table.insert(pointDic[showPoint], value)
        if stylesDic[style] == nil then
            stylesDic[style] = {}
        end
        table.insert(stylesDic[style], value)
        if isUseExtraStyle == true then
            if stylesDic[extraSytle] == nil then
                stylesDic[extraSytle] = {}
            end
            table.insert(stylesDic[extraSytle], value)
        end
    end
    for key, value in pairs(stylesDic) do
        table.sort(value, BalatroUtil.SortBrandByPointDescend)
    end

    if BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.FlushStraight) == true then
        for key, value in pairs(stylesDic) do
            if #value >= 4 then
                if #value == BalatroDataMgr.Flush_Straight_NeedCount then
                    tempValidBrands = value
                elseif BalatroDataMgr.Flush_Straight_NeedCount == 4 then
                    local firstData = value[1]
                    local secondData = value[2]
                    local lastData = value[#value]
                    local deltaShowPoint = firstData:GetShowPoint() - secondData:GetShowPoint()
                    local deltaStyle = firstData:GetStyle() - secondData:GetStyle()
                    if isUseExtraStyle == true and deltaStyle ~= 0 then
                        deltaStyle = firstData:GetStyle() - secondData:GetExtraStyle()
                    end

                    local deltaShowPointMax = firstData:GetShowPoint() - lastData:GetShowPoint()
                    local deltaStyleMax = firstData:GetStyle() - lastData:GetStyle()
                    if isUseExtraStyle == true and deltaStyle ~= 0 then
                        deltaStyleMax = firstData:GetStyle() - lastData:GetExtraStyle()
                    end

                    if deltaShowPointMax == 4 and deltaStyleMax == 0 then
                        tempValidBrands = value
                    else
                        if deltaShowPoint == 1 and deltaStyle == 0 then
                            table.move(value, 1, 4, 1, tempValidBrands)
                        else
                            table.move(value, 2, 5, 1, tempValidBrands)
                        end
                    end
                end
                break
            end
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.Flush) == true then
        for key, value in pairs(stylesDic) do
            if #value >= 4 then
                if #value == BalatroDataMgr.Flush_Straight_NeedCount then
                    tempValidBrands = value
                elseif BalatroDataMgr.Flush_Straight_NeedCount == 4 then
                    local firstData = value[1]
                    local secondData = value[2]
                    local lastData = value[#value]

                    local deltaStyle = firstData:GetStyle() - secondData:GetStyle()
                    if isUseExtraStyle == true and deltaStyle ~= 0 then
                        deltaStyle = firstData:GetStyle() - secondData:GetExtraStyle()
                    end

                    local deltaStyleMax = firstData:GetStyle() - lastData:GetStyle()
                    if isUseExtraStyle == true and deltaStyle ~= 0 then
                        deltaStyleMax = firstData:GetStyle() - lastData:GetExtraStyle()
                    end


                    if deltaStyleMax == 0 then
                        tempValidBrands = value
                    else
                        if deltaStyle == 0 then
                            table.move(value, 1, 4, 1, tempValidBrands)
                        else
                            table.move(value, 2, 5, 1, tempValidBrands)
                        end
                    end
                end
                break
            end
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.Straight) == true then
        if #brandDataLst >= 4 then
            if #brandDataLst == BalatroDataMgr.Flush_Straight_NeedCount then
                tempValidBrands = brandDataLst
            elseif BalatroDataMgr.Flush_Straight_NeedCount == 4 then
                local firstData = brandDataLst[1]
                local secondData = brandDataLst[2]
                local lastData = brandDataLst[#brandDataLst]

                local deltaShowPoint = firstData:GetShowPoint() - secondData:GetShowPoint()
                local deltaShowPointMax = firstData:GetShowPoint() - lastData:GetShowPoint()

                if deltaShowPointMax == 4 then
                    tempValidBrands = brandDataLst
                else
                    if deltaShowPoint == 1 then
                        table.move(brandDataLst, 1, 4, 1, tempValidBrands)
                    else
                        table.move(brandDataLst, 2, 5, 1, tempValidBrands)
                    end
                end
            end
        else
            LuaDebug.error("BalatroStepMgr.GetBrandTypeValidBrand: brandDataLst count valid" .. debug.traceback())
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.TwoDouble) == true then
        for _, tempBrands1 in pairs(pointDic) do
            if #tempBrands1 >= 2 then
                for key, value in pairs(tempBrands1) do
                    table.insert(tempValidBrands, value)
                end
            end
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.Quadra) == true then
        for _, tempBrands1 in pairs(pointDic) do
            if #tempBrands1 >= 4 then
                tempValidBrands = tempBrands1
            end
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.Triple) == true then
        for _, tempBrands1 in pairs(pointDic) do
            if #tempBrands1 >= 3 then
                tempValidBrands = tempBrands1
            end
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.Double) == true then
        for _, tempBrands1 in pairs(pointDic) do
            if #tempBrands1 >= 2 then
                tempValidBrands = tempBrands1
            end
        end
    elseif BalatroStepMgr.CompareBrandTypeAndID(brandTypeID, BalatroUtil.BrandType.Normal) == true then
        local maxShowPoint = 0
        for key, value in pairs(brandDataLst) do
            maxShowPoint = math.max(value:GetShowPoint(), maxShowPoint)
        end
        tempValidBrands = pointDic[maxShowPoint]
    else
        tempValidBrands = brandDataLst
    end


    local curRoundData = BalatroStepMgr.GetCurRoundData()
    if curRoundData:CheckBrandTypeValid(brandTypeID) == false then
        local tempBrandType = 0
        tempValidBrands = {}
        for key, value in pairs(BalatroUtil.BrandType) do
            local tempValue = value + 3999
            if curRoundData:CheckBrandTypeValid(tempValue) == true then
                tempBrandType = tempValue
                break
            end
        end
        tempValidBrands = BalatroStepMgr.GetValidBrandByType(brandTypeID, brandDataLst, tempBrandType)

    end

    return tempValidBrands
end



BalatroStepMgr.GetValidBrandByType = function(orginBrandType, brandDataLst, brandType)
    local pointDic = {}
    local stylesDic = {}
    local brandDataLen = #brandDataLst
    local isUseExtraStyle = BalatroDataMgr.IsUseExtra_Style
    for i = 1, brandDataLen do
        local brand = brandDataLst[i]
        local showPoint = brand:GetShowPoint()
        local style = brand:GetStyle()
        local extraSytle = brand:GetExtraStyle()
        if pointDic[showPoint] == nil then
            pointDic[showPoint] = {}
        end
        table.insert(pointDic[showPoint], brand)
        if stylesDic[style] == nil then
            stylesDic[style] = {}
        end
        table.insert(stylesDic[style], brand)
        if isUseExtraStyle == true then
            if stylesDic[extraSytle] == nil then
                stylesDic[extraSytle] = {}
            end
            table.insert(stylesDic[extraSytle], brand)
        end
    end
    for key, value in pairs(stylesDic) do
        table.sort(value, BalatroUtil.SortBrandByPointDescend)
    end
    local tempBrands = {}
    local brandTypeType = brandType - 3999
    local orginBrandTypeType = orginBrandType - 3999

    if brandTypeType == BalatroUtil.BrandType.Quadra and (orginBrandTypeType == BalatroUtil.BrandType.FlushPenta or orginBrandTypeType == BalatroUtil.BrandType.Penta) then
        for key, value in pairs(pointDic) do
            if #value >= 4 then
                table.move(value, 1, 4, 1, tempBrands)
                break
            end
        end
    elseif brandTypeType == BalatroUtil.BrandType.Flush and (orginBrandTypeType == BalatroUtil.BrandType.FlushStraight or orginBrandTypeType == BalatroUtil.BrandType.FlushPenta or orginBrandTypeType == BalatroUtil.BrandType.FlushGourd) then
        for key, value in pairs(stylesDic) do
            if #value >= 4 then
                if #value == BalatroDataMgr.Flush_Straight_NeedCount then
                    tempBrands = value
                else
                    table.move(value, 1, 4, 1, tempBrands)
                end
                break
            end
        end
    elseif brandTypeType == BalatroUtil.BrandType.Straight and orginBrandTypeType == BalatroUtil.BrandType.FlushStraight then
        for key, value in pairs(stylesDic) do
            if #value >= 4 then
                if #value == BalatroDataMgr.Flush_Straight_NeedCount then
                    tempBrands = value
                elseif BalatroDataMgr.Flush_Straight_NeedCount == 4 then
                    local firstData = value[1]
                    local secondData = value[2]
                    if firstData:GetShowPoint() - secondData:GetShowPoint() == 1 then
                        table.move(value, 1, 4, 1, tempBrands)
                    else
                        table.move(value, 2, 5, 1, tempBrands)
                    end
                end
                break
            end
        end
    elseif brandTypeType == BalatroUtil.BrandType.Triple and (orginBrandTypeType == BalatroUtil.BrandType.Quadra or orginBrandTypeType == BalatroUtil.BrandType.Penta or orginBrandTypeType == BalatroUtil.BrandType.FlushPenta) then
        for key, value in pairs(pointDic) do
            if #value == 3 then
                tempBrands = value
                break
            end
        end
    elseif brandTypeType == BalatroUtil.BrandType.TwoDouble and (orginBrandTypeType == BalatroUtil.BrandType.Quadra or orginBrandTypeType == BalatroUtil.BrandType.Penta or orginBrandTypeType == BalatroUtil.BrandType.FlushPenta or orginBrandTypeType == BalatroUtil.BrandType.FlushGourd or orginBrandTypeType == BalatroUtil.BrandType.Gourd) then
        if orginBrandTypeType ~= BalatroUtil.BrandType.FlushGourd and orginBrandTypeType ~= BalatroUtil.BrandType.Gourd then
            for key, value in pairs(pointDic) do
                if #value >= 4 then
                    table.move(value, 1, 4, 1, tempBrands)
                    break
                end
            end
        else
            for key, value in pairs(pointDic) do
                if #value == 2 then
                    table.move(value, 1, #value, #tempBrands + 1, tempBrands)
                else
                    table.move(value, 1, 2, #tempBrands + 1, tempBrands)
                end
            end
        end
    elseif brandTypeType == BalatroUtil.BrandType.Double then
        local maxPoint = 0
        for key, value in pairs(pointDic) do
            if #value >= 2 then
                maxPoint = math.max(key, maxPoint)
            end
        end
        if maxPoint > 0 then
            local selectPointDatas = pointDic[maxPoint]
            table.move(selectPointDatas, 1, 2, 1, tempBrands)
        end
    elseif brandTypeType == BalatroUtil.BrandType.Normal then
        local maxPoint = 0
        for key, value in pairs(brandDataLst) do
            maxPoint = math.max(maxPoint, value:GetShowPoint())
        end
        if pointDic[maxPoint] ~= nil and pointDic[maxPoint][1] ~= nil then
            table.insert(tempBrands, pointDic[maxPoint][1])
        end
    else
        tempBrands = brandDataLst
    end
    return tempBrands
end

BalatroStepMgr.CompareBrandTypeAndID = function(id, type)
    return id == type + 3999
end



BalatroStepMgr.GetBrandTypeScore = function(brandType)
    local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(brandType)
    brandTypeData:SetIsLowLevel(BalatroDataMgr.IsLowBrandTypeLevel)
    local score = brandTypeData:GetTotalScore()
    return score
end



BalatroStepMgr.GetBrandTypeRate = function(brandType)
    local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(brandType)
    brandTypeData:SetIsLowLevel(BalatroDataMgr.IsLowBrandTypeLevel)
    local rate = brandTypeData:GetTotalRate()
    return rate
end


BalatroStepMgr.GetBalatroInfo = function(brandDataLst)

    local totalScore = 0

    local totalAddRate = 0

    local totalMuliRate = 1
    for _, data in pairs(brandDataLst) do
        totalScore = totalScore + data:GetScore()
        totalAddRate = totalAddRate + data:GetAddRate()
        local muliRate = data:GetMuliRate()
        if muliRate ~= 0 then
            totalMuliRate = totalMuliRate * muliRate
        end
    end
    return totalScore, totalAddRate, totalMuliRate
end



BalatroStepMgr.GetBalatroScoreRate = function(brandDataLst)

    return 1
end

