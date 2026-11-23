








local chanceBaseNum = 10000




function BalatroCalMul(balatroData, resultType, resultValue, calSymbol)

    if resultType == BalatroUtil.ResultType.Rate then
        if calSymbol == BalatroUtil.CalSymbolType.Add then

            local res = math.max(resultValue + balatroData:GetAddRate(), 0)
            balatroData:SetAddRate(res)
        elseif calSymbol == BalatroUtil.CalSymbolType.Multiply then
            local res = math.max(resultValue + balatroData:GetMuliRate(), 0)
            balatroData:SetMuliRate(res)
        end
    elseif resultType == BalatroUtil.ResultType.Score then
        if calSymbol == BalatroUtil.CalSymbolType.Add then

            local res = math.max(resultValue + balatroData:GetScore(), 0)
            balatroData:SetScore(res)
        else
            LuaDebug.error("配置符号错误")
        end
    elseif resultType == BalatroUtil.ResultType.DiscardTimes then
        balatroData:SetDiscardTimes(resultValue + balatroData:GetDiscardTimes())
        local curRound = BalatroStepMgr.GetCurRoundData()
        curRound:SetBalatroDiscardTimes(balatroData:GetDiscardTimes())
    elseif resultType == BalatroUtil.ResultType.PlaycardTimes then
        local res = math.max(resultValue + balatroData:GetPlaycardTimes(), 0)
        balatroData:SetPlaycardTimes(res)
        local curRound = BalatroStepMgr.GetCurRoundData()
        curRound:SetBalatroPlaycardTimes(balatroData:GetPlaycardTimes())
    elseif resultType == BalatroUtil.ResultType.HandBrandLimit then
        local res = math.max(resultValue + balatroData:GetHandBrandLimit(), 0)
        balatroData:SetHandBrandLimit(res)
        BalatroDataMgr.SetBalatroBrandCountLimit()
    elseif resultType == BalatroUtil.ResultType.PropbrandIncrease then
    else
        LuaDebug.error(string.format("BalatroCalMul 结算参数错误 小丑牌ID:%d %s", balatroData:GetID(), debug.traceback()))
    end
end



function BalatroCalOnce(balatroData, resultType, resultValue, calSymbol)

    if resultType == BalatroUtil.ResultType.Rate then
        if calSymbol == BalatroUtil.CalSymbolType.Add then
            balatroData:SetAddRate(resultValue)
        elseif calSymbol == BalatroUtil.CalSymbolType.Multiply then
            balatroData:SetMuliRate(resultValue)
        end
    elseif resultType == BalatroUtil.ResultType.Score then
        if calSymbol == BalatroUtil.CalSymbolType.Add then
            balatroData:SetScore(resultValue)
        else
            LuaDebug.error("配置符号错误")
        end
    elseif resultType == BalatroUtil.ResultType.DiscardTimes then
        local curRound = BalatroStepMgr.GetCurRoundData()
        curRound:SetBalatroDiscardTimes(resultValue)
        balatroData:SetDiscardTimes(resultValue)
    elseif resultType == BalatroUtil.ResultType.PlaycardTimes then
        local curRound = BalatroStepMgr.GetCurRoundData()
        curRound:SetBalatroPlaycardTimes(resultValue)
        balatroData:SetPlaycardTimes(resultValue)
    elseif resultType == BalatroUtil.ResultType.HandBrandLimit then
        balatroData:SetHandBrandLimit(resultValue)
        BalatroDataMgr.SetBalatroBrandCountLimit()
    elseif resultType == BalatroUtil.ResultType.PropbrandIncrease then
    else
        LuaDebug.error(string.format("BalatroCalOnce 结算参数错误 小丑牌ID:%d %s", balatroData:GetID(), debug.traceback()))
    end
end




function BrandTypeLevelUp(balatroData, brandDatas, resultValue)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    local brandTypeDataID = BalatroBrandTypeData.GetBrandType(brandDatas)
    local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(brandTypeDataID)
    if config.CalSymbol1 == BalatroUtil.CalSymbolType.Add then
        brandTypeData:Upgrade(resultValue)
    end
end




function StyleCondition(balatroData, brandDatas)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end

    local config = balatroData:GetConfig()
    local brandDataLen = #brandDatas
    local styleCountDic = {}

    for i = 1, brandDataLen do
        local data = brandDatas[i]
        local style = data:GetStyle()
        if config.ConditonSymbol ~= 0 or data:GetIsValid() == true then
            styleCountDic[style] = (styleCountDic[style] or 0) + 1
        end
        local extraStyle = data:GetExtraStyle()
        if extraStyle ~= 0 and (config.ConditonSymbol ~= 0 or data:GetIsValid() == true) then
            styleCountDic[extraStyle] = (styleCountDic[extraStyle] or 0) + 1
        end
    end
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if type(conditionValue) == BalatroUtil.LuaDataType.Number then
        local resValue1 = 0
        local resValue2 = 0
        for key, value in pairs(styleCountDic) do
            if conditionValue == key then

                if config.ResultType1 ~= 0 then
                    resValue1 = resValue1 + config.ResultValue1 * value
                end
                if config.ResultType2 ~= 0 then
                    resValue2 = resValue2 + config.ResultValue2 * value
                end
            end
        end
        if config.ResultType1 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType1, resValue1, config.CalSymbol1)
        end
        if config.ResultType2 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType2, resValue2, config.CalSymbol2)
        end
    elseif conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table then
        if brandDataLen < #conditionValue then

            return
        end
        local isFullCondition = true
        for key, value in pairs(conditionValue) do
            if value ~= 5 and not styleCountDic[value] then
                isFullCondition = false
            elseif styleCountDic[value] then
                isFullCondition = true
            end
            if isFullCondition == false and config.ConditonSymbol == BalatroUtil.ConditonSymbol.And then
                break
            end
        end
        if isFullCondition == true and NumTool.GetLen(styleCountDic) > 1 then
            if config.ResultType1 ~= 0 then
                BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            end
            if config.ResultType2 ~= 0 then
                BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2, config.CalSymbol2)
            end
        end
    end
end



function BrandTypeCondition(balatroData, brandDatas)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if type(conditionValue) == BalatroUtil.LuaDataType.Number then
        local brandType = BalatroStepMgr.GetBrandType(brandDatas) - 3999
        if conditionValue == brandType then
            if config.ActionType == BalatroUtil.ActionType.Increase then
                BalatroCalMul(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            else
                BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            end
        end
    elseif conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table then
        local fullCondition = false
        local allBrandType = BalatroStepMgr.GetAllBrandType(brandDatas)
        for _, value in pairs(conditionValue) do
            local isExistBrandType = allBrandType[value]
            if config.ConditonSymbol == BalatroUtil.ConditonSymbol.And and isExistBrandType ~= true then
                fullCondition = false
                break
            elseif config.ConditonSymbol == BalatroUtil.ConditonSymbol.Or and isExistBrandType == true then
                fullCondition = true
                break
            end
        end
        if fullCondition == true then
            if config.ActionType == BalatroUtil.ActionType.Increase then
                BalatroCalMul(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            else
                BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            end
        end
    end
end



function PointCondition(balatroData, brandDatas)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local brandType = curRound:GetCurBrandType()
    local validBrandDatas = BalatroStepMgr.GetBrandTypeValidBrand(brandType, brandDatas)
    local brandDataLen = #validBrandDatas
    local pointCountDic = {}
    for i = 1, brandDataLen do
        local data = validBrandDatas[i]
        local point = data:GetShowPoint()

        if data:GetIsValid() == true then
            pointCountDic[point] = (pointCountDic[point] or 0) + 1
        end
    end
    local config = balatroData:GetConfig()
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if type(conditionValue) == BalatroUtil.LuaDataType.Number then
        local resValue1, resValue2 = 0, 0
        for key, value in pairs(pointCountDic) do
            if tonumber(conditionValue) == key then
                if config.ResultType1 ~= 0 then
                    resValue1 = resValue1 + config.ResultValue1 * value
                end
                if config.ResultType2 ~= 0 then
                    resValue2 = resValue2 + config.ResultValue2 * value
                end
            end
        end
        if config.ResultType1 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType1, resValue1, config.CalSymbol1)
        end
        if config.ResultType2 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType2, resValue2, config.CalSymbol2)
        end
    elseif conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table then

        local resValue1, resValue2 = 0, 0
        if config.ConditonSymbol == BalatroUtil.ConditonSymbol.All then
            for key, pointStr in pairs(conditionValue) do
                local point = tonumber(pointStr)
                if pointCountDic[point] ~= nil then
                    local count = pointCountDic[point]
                    if config.ResultType1 ~= 0 then
                        resValue1 = resValue1 + config.ResultValue1 * count
                    end
                    if config.ResultType2 ~= 0 then
                        resValue2 = resValue2 + config.ResultValue2 * count
                    end
                end
            end
            if config.ResultType1 ~= 0 then
                BalatroCalOnce(balatroData, config.ResultType1, resValue1, config.CalSymbol1)
            end
            if config.ResultType2 ~= 0 then
                BalatroCalOnce(balatroData, config.ResultType2, resValue2, config.CalSymbol2)
            end
        end
    end
end



function DiscardTimesCondition(balatroData, brandDatas)
    local config = balatroData:GetConfig()
    local discardTimes = BalatroStepMgr.GetDiscardTimes()
    if config.ActionType == BalatroUtil.ActionType.Increase then
    elseif config.ActionType == 0 then

        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        if conditionValue == 0 and conditionValue == discardTimes then
            BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        elseif conditionValue ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1 * discardTimes, config.CalSymbol1)
        end
    else
        LuaDebug.error("DiscardTimesCondition 暂未实现|ID:" .. balatroData:GetID() .. " " .. debug.traceback())
    end
end




function PlaycardCountCondition(balatroData, brandDatas)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    local playcardCount = #brandDatas
    local fullcondition = false
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if config.ConditonSymbol == BalatroUtil.ConditonSymbol.LessThan and playcardCount < conditionValue then
        fullcondition = true
    elseif config.ConditonSymbol == BalatroUtil.ConditonSymbol.GreaterThan and playcardCount > conditionValue then
        fullcondition = true
    end
    if fullcondition == true then
        BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
    end
end




function ChanceCondition(balatroData, brandDatas)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local brandType = curRound:GetCurBrandType()
    local validBrandDatas = BalatroStepMgr.GetBrandTypeValidBrand(brandType, brandDatas)
    local config = balatroData:GetConfig()
    if config.ActionType == nil or config.ActionType == 0 then
        local needCal = false
        if config.ConditionType2 == BalatroUtil.ConditionType.Stytle then
            local styleCountDic = {}
            for _, data in pairs(validBrandDatas) do
                local style = data:GetStyle()
                if data:GetIsValid() == true then
                    styleCountDic[style] = (styleCountDic[style] or 0) + 1
                end
                local extraStyle = data:GetExtraStyle()
                if extraStyle ~= 0 and data:GetIsValid() == true then
                    styleCountDic[extraStyle] = (styleCountDic[extraStyle] or 0) + 1
                end
            end
            needCal = styleCountDic[config.ConditionValue2] ~= nil
        else
            LuaDebug.error("ChanceCondition 暂未实现|ID:" .. balatroData:GetID() .. " " .. debug.traceback())
            return
        end
        if needCal == false then
            return
        end
        math.randomseed(os.time() + balatroData:GetUID())
        local randomNum = math.random(1, chanceBaseNum)
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        if randomNum < conditionValue then
            BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
        return
    end
end




function PropsCondition(balatroData, brandDatas)
    local config = balatroData:GetConfig()
    if config.ActionType == BalatroUtil.ActionType.Increase then
        local usePropsCount = #BalatroDataMgr.UsedPropsBrandData() - balatroData:GetUsePropsCount()
        BalatroCalOnce(balatroData, config.ResultType1, usePropsCount * config.ResultValue1, config.CalSymbol1)
    end
end



function EffectGameMajor(balatroData, brandDatas, otherParam)
    local config = balatroData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.DiscardTimes then
        if brandDatas ~= nil then
            DiscardTimesCondition(balatroData, brandDatas)
        end
    elseif config.ConditionType1 == BalatroUtil.ConditionType.PropsBrand then
        PropsCondition(balatroData, brandDatas)
    elseif brandDatas ~= nil then
        if config.ResultType1 and config.ResultType1 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
        if config.ResultType2 and config.ResultType2 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2, config.CalSymbol2)
        end
    end
end





function EffectGeneralMajor(balatroData, brandDatas, otherParam)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.Stytle then
        if config.ConditonSymbol == 0 then
            local curRound = BalatroStepMgr.GetCurRoundData()
            local brandType = curRound:GetCurBrandType()
            local validBrandDatas = BalatroStepMgr.GetBrandTypeValidBrand(brandType, brandDatas)
            StyleCondition(balatroData, validBrandDatas)
        else
            StyleCondition(balatroData, brandDatas)
        end
    elseif config.ConditionType1 == BalatroUtil.ConditionType.BrandType then
        BrandTypeCondition(balatroData, brandDatas)
    elseif config.ConditionType1 == BalatroUtil.ConditionType.BrandPoint then
        PointCondition(balatroData, brandDatas)
    elseif config.ConditionType1 == BalatroUtil.ConditionType.PlaycardNum then
        PlaycardCountCondition(balatroData, brandDatas)
    elseif config.ConditionType1 == BalatroUtil.ConditionType.Chance then
        ChanceCondition(balatroData, brandDatas)
    end
end




function EffectHandMajor(balatroData, brandDatas, otherParam)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if config.ConditionType1 == BalatroUtil.ConditionType.BrandPoint then
        local resValue1 = 0
        for _, value in pairs(brandDatas) do
            if value:GetShowPoint() == conditionValue then
                resValue1 = resValue1 + config.ResultValue1
            end
        end
        BalatroCalOnce(balatroData, config.ResultType1, resValue1, config.CalSymbol1)
    elseif config.ConditionType1 == BalatroUtil.ConditionType.PointLimit then
        local baseValue = 0
        for _, value in pairs(brandDatas) do
            local showPoint = value:GetShowPoint()
            if baseValue == 0 then
                baseValue = showPoint
            end
            if conditionValue == BalatroUtil.PointLimit.Max then
                baseValue = math.max(baseValue, showPoint)
            elseif conditionValue == BalatroUtil.PointLimit.Min then
                baseValue = math.min(baseValue, showPoint)
            end
        end
        BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1 * baseValue, config.CalSymbol1)
    else
        LuaDebug.error("BalatroEffect: 条件未实现:" .. balatroData:GetID() .. " " .. debug.traceback())
    end
end





function BalatroEffect_10000(balatroData, brandDatas, otherParam)
    local config = balatroData:GetConfig()
    if not config then
        LuaDebug.error("BalatroEffect_10000 : 表格数据为空")
        return
    end
    local brandCalMajor = config.CalMajor
    if brandCalMajor == BalatroUtil.CalMajor.Game then
        EffectGameMajor(balatroData, brandDatas, otherParam)
    elseif brandCalMajor == BalatroUtil.CalMajor.Playcard then
        EffectGeneralMajor(balatroData, brandDatas, otherParam)
    elseif brandCalMajor == BalatroUtil.CalMajor.HandBrand then
        EffectHandMajor(balatroData, brandDatas, otherParam)
    else
        LuaDebug.error("BalatroEffect_10000 : 主体未实现:" .. balatroData:GetID() .. " " .. debug.traceback())
    end
end




function BalatroEffect_10001(balatroData, brandDatas, otherParam)
    math.randomseed(os.time())
    local config = balatroData:GetConfig()
    if config.ActionType == BalatroUtil.ActionType.RangeRandom then
        local randomCount = math.random(config.ActionParam1, config.ActionParam2)
        BalatroCalOnce(balatroData, config.ResultType1, randomCount, config.CalSymbol1)
    else
        LuaDebug.error("BalatroEffect_10001 : 主体未实现:" .. balatroData:GetID() .. " " .. debug.traceback())
    end
end





function BalatroEffect_10002(balatroData, brandDatas, otherParam)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.BrandPoint then
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        local pointCountDic = {}
        local curRound = BalatroStepMgr.GetCurRoundData()
        local brandType = curRound:GetCurBrandType()
        local validBrandDatas = BalatroStepMgr.GetBrandTypeValidBrand(brandType, brandDatas)
        for _, data in pairs(validBrandDatas) do
            local point = data:GetShowPoint()

            if data:GetIsValid() == true then
                pointCountDic[point] = (pointCountDic[point] or 0) + 1
            end
        end
        if conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table and config.ConditonSymbol == BalatroUtil.ConditonSymbol.Map then
            if #conditionValue ~= 2 then
                return
            end
            local pointCount1 = pointCountDic[conditionValue[1]] or 0
            local pointCount2 = pointCountDic[conditionValue[2]] or 0
            if pointCount1 > 0 then
                BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1 * pointCount1, config.CalSymbol1)
            end
            if pointCount2 > 0 then
                BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2 * pointCount2, config.CalSymbol2)
            end
        elseif config.ActionType == BalatroUtil.ActionType.Rate then
            math.randomseed(BalatroDataMgr.GetGameStartTime() + curRound:GetRoundID())

            local randomIndex = math.random(1, #BalatroUtil.ShowPointStr)
            balatroData:SetCanChangePointIndex(randomIndex)
            local validCount = 0
            for key, value in pairs(validBrandDatas) do
                if value:GetShowPoint() == BalatroUtil.ShowPoint[randomIndex] then
                    validCount = validCount + 1
                end
            end
            if validCount > 0 then
                BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1 * validCount, config.CalSymbol1)
            end
        elseif conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Number then
            LuaDebug.info("BalatroEffect_10002 : " .. balatroData:GetID() .. "|" .. table.tostring(pointCountDic))
            local pointCount = pointCountDic[conditionValue] or 0
            if pointCount > 0 then
                if config.ActionType == BalatroUtil.ActionType.Increase then
                    BalatroCalMul(balatroData, config.ResultType1, config.ResultValue1 * pointCount, config.CalSymbol1)
                    if config.ResultType2 ~= nil and config.ResultType2 ~= 0 then
                        BalatroCalMul(balatroData, config.ResultType2, config.ResultValue2 * pointCount, config.CalSymbol2)
                    end
                else
                    BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1 * pointCount, config.CalSymbol1)
                    if config.ResultType2 ~= nil and config.ResultType2 ~= 0 then
                        BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2 * pointCount, config.CalSymbol2)
                    end
                end
            end
        else
            BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            if config.ResultType2 ~= nil and config.ResultType2 ~= 0 then
                BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2, config.CalSymbol2)
            end
        end
    elseif config.ConditionType1 == BalatroUtil.ConditionType.PlaycardSeq then
        local curRound = BalatroStepMgr.GetCurRoundData()
        if tonumber(config.ConditionValue1) == BalatroUtil.PlaycardSeq.Last and curRound:RemainPlaycardTimes() == 1 then
            BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
    else
        BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        if config.ResultType2 ~= nil and config.ResultType2 ~= 0 then
            BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2, config.CalSymbol2)
        end
    end
end




function BalatroEffect_10003(balatroData, brandDatas, otherParam)
    if brandDatas == nil then
        return
    end
    local config = balatroData:GetConfig()
    if config.ConditonSymbol == BalatroUtil.ConditonSymbol.LessThan and #brandDatas < tonumber(config.ConditionValue1) then
        BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
    end
end




function BalatroEffect_10004(balatroData, brandDatas, otherParam)
    local config = balatroData:GetConfig()
    if config.ActionType ~= BalatroUtil.ActionType.Increase then
        LuaDebug.error("BalatroEffect_10004 配置错误")
        return
    end

    local curRound = BalatroStepMgr.GetCurRoundData()
    local selectRoundID = balatroData:GetSelectRoundID()
    if selectRoundID == nil then
        return
    end
    if config.ActionParam2 ~= 0 then
        local curRoundIndex = curRound:GetRound()
        if curRoundIndex == 1 then
            BalatroCalOnce(balatroData, config.ResultType1, config.ActionParam1, config.CalSymbol1)
        else
            local selectRoundIndex = 0
            for key, configData in pairs(ConfigMgr.Config.BalatroPhaseDataList) do
                if configData.ID == selectRoundID then
                    selectRoundIndex = configData.Round
                    break
                end
            end
            local deltaRound = curRoundIndex - selectRoundIndex
            local res = math.max(0, config.ActionParam1 + deltaRound * config.ResultValue1)
            BalatroCalOnce(balatroData, config.ResultType1, res, config.CalSymbol1)
        end
    else
        local deltaRound = curRound:GetRoundID() - selectRoundID
        local res = math.max(0, config.ActionParam1 + deltaRound * config.ResultValue1)
        BalatroCalOnce(balatroData, config.ResultType1, res, config.CalSymbol1)
    end
end




function BalatroEffect_10005(balatroData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local config = balatroData:GetConfig()
    local func = function(totalScore, goalScore, isReset)
        local needScore = BalatroUtil.Muli(goalScore, config.ConditionValue1 / chanceBaseNum)
        if BalatroUtil.Compare(totalScore, needScore) >= 0 then
            if isReset == true then
                balatroData:SetDestroy()
                local data = {
                    balatroData = balatroData
                }
                LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroBrandDestroy, data)
            end
            return true
        end
        return false
    end
    curRound:SetExtraResultJudge(func)
end




function BalatroEffect_10006(balatroData, brandDatas, otherParam)
    local config = balatroData:GetConfig()
    BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
    if config.ResultType2 ~= nil and config.ResultType2 ~= 0 then
        BalatroCalOnce(balatroData, config.ResultType2, config.ResultValue2, config.CalSymbol2)
    end
end




function BalatroEffect_10007(balatroData, brandDatas, otherParam)
    local allBalatroDataLen = NumTool.GetLen(BalatroDataMgr.GetUsingBalatros())
    local config = balatroData:GetConfig()
    BalatroCalOnce(balatroData, config.ResultType1, allBalatroDataLen * config.ResultValue1, config.CalSymbol1)
end




function BalatroEffect_10008(balatroData, brandDatas, otherParam)
    local config = balatroData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.MissingcardNum then
        local num = 52 - #BalatroDataMgr.GetMainBrandPool()
        if num > 0 then
            BalatroCalOnce(balatroData, config.ResultType1, num * config.ResultValue1, config.CalSymbol1)
        end
    elseif config.ActionType == BalatroUtil.ActionType.DestroySelf then
        BalatroCalOnce(balatroData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        local stepType = otherParam.StepType
        if config.ConditionType1 == BalatroUtil.ConditionType.Chance then
            local random = math.random(1, chanceBaseNum)
            local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
            if stepType == BalatroUtil.StepType.RoundEnd and random <= conditionValue then
                balatroData:SetDestroy()
                local data = {
                    balatroData = balatroData
                }
                LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroBrandDestroy, data)
            end
        end
    end
end




function BalatroEffect_10009(balatroData, brandDatas, otherParam)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.Chance then
        local random = math.random(1, chanceBaseNum)
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        if random > conditionValue then
            return
        end
        if config.ResultType1 == BalatroUtil.ResultType.BrandTypeLV then
            BrandTypeLevelUp(balatroData, brandDatas, config.ResultValue1)
        end
    end
end




function BalatroEffect_10010(balatroData, brandDatas, otherParam)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local tempPlayBrandDatas = {}
    for _, value in pairs(brandDatas) do
        tempPlayBrandDatas[value:GetID()] = value
    end
    local handBrand = BalatroDataMgr.GetHandBrandDataList()
    local baseValue = 0
    local config = balatroData:GetConfig()
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if conditionValue == nil then
        LuaDebug.error("BalatroEffect_10010 : 配置错误")
        return
    elseif type(conditionValue) == BalatroUtil.LuaDataType.Table then
        LuaDebug.error("BalatroEffect_10010 : 暂不支持")
        return
    end
    local resValue1 = 0
    for key, value in pairs(handBrand) do
        if config.ConditionType1 == BalatroUtil.ConditionType.PointLimit then

            if tempPlayBrandDatas[value:GetID()] == nil then
                local showPoint = value:GetShowPoint()
                if baseValue == 0 then
                    baseValue = showPoint
                end
                if conditionValue == BalatroUtil.PointLimit.Max then
                    baseValue = math.max(baseValue, showPoint)
                elseif conditionValue == BalatroUtil.PointLimit.Min then
                    baseValue = math.min(baseValue, showPoint)
                end
            end
            resValue1 = 2 * baseValue
        elseif config.ConditionType1 == BalatroUtil.ConditionType.BrandPoint then
            if tempPlayBrandDatas[value:GetID()] == nil and value:GetShowPoint() == conditionValue then
                resValue1 = resValue1 + config.ResultValue1
            end
        end
    end
    BalatroCalOnce(balatroData, config.ResultType1, resValue1, config.CalSymbol1)
end




function BalatroEffect_10011(balatroData, brandDatas, otherParam)
    BalatroDataMgr.Flush_Straight_NeedCount = 4
end




function BalatroEffect_10012(balatroData, brandDatas, otherParam)
    local allBrandTypes = BalatroDataMgr.GetBrandTypeDatas()
    local resValue1 = 0
    local config = balatroData:GetConfig()
    for _, value in pairs(allBrandTypes) do
        resValue1 = resValue1 + value:GetValidTimes()
    end
    BalatroCalOnce(balatroData, config.ResultType1, resValue1, config.CalSymbol1)
end




function BalatroEffect_10013(balatroData, brandDatas, otherParam)
    BalatroDataMgr.Straight_IsPart = true
end




function BalatroEffect_10014(balatroData, brandDatas, otherParam)
    local allBrands1 = BalatroDataMgr.GetMainBrandPool()
    local allBrands2 = BalatroDataMgr.GetSecondBrandPool()
    local setExtraStyle = function(tempDatas)
        for _, value in pairs(tempDatas) do
            if value:GetStyle() == BalatroUtil.Style.Hearts then
                value:SetExtraStyle(BalatroUtil.Style.Diamonds)
            elseif value:GetStyle() == BalatroUtil.Style.Diamonds then
                value:SetExtraStyle(BalatroUtil.Style.Hearts)
            elseif value:GetStyle() == BalatroUtil.Style.Spades then
                value:SetExtraStyle(BalatroUtil.Style.Clubs)
            elseif value:GetStyle() == BalatroUtil.Style.Clubs then
                value:SetExtraStyle(BalatroUtil.Style.Spades)
            end
        end
    end
    setExtraStyle(allBrands1)
    setExtraStyle(allBrands2)
    local handBrand = BalatroDataMgr.GetHandBrandDataList()
    if handBrand ~= nil then
        for _, value in pairs(handBrand) do
            if value:GetStyle() == BalatroUtil.Style.Hearts then
                value:SetExtraStyle(BalatroUtil.Style.Diamonds)
            elseif value:GetStyle() == BalatroUtil.Style.Diamonds then
                value:SetExtraStyle(BalatroUtil.Style.Hearts)
            elseif value:GetStyle() == BalatroUtil.Style.Spades then
                value:SetExtraStyle(BalatroUtil.Style.Clubs)
            elseif value:GetStyle() == BalatroUtil.Style.Clubs then
                value:SetExtraStyle(BalatroUtil.Style.Spades)
            end
        end
    end
    BalatroDataMgr.IsUseExtra_Style = true
end




function BalatroEffect_10015(balatroData, brandDatas, otherParam)
    if brandDatas == nil or #brandDatas == 0 then
        return
    end
    local config = balatroData:GetConfig()
    local isFullCondition = true
    if config.ConditionType1 == BalatroUtil.ConditionType.BrandType then
        local allBrandType = BalatroBrandTypeData.GetAllBrandType(brandDatas)
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        local isFullSubCondition = false
        if conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table then
            for _, value in pairs(conditionValue) do
                local isExistBrandType = allBrandType[value]
                if isExistBrandType == true then
                    isFullSubCondition = true
                    break
                end
            end
            if isFullSubCondition == false then
                isFullCondition = false
            end
        end
    end
    if config.ConditionType2 == BalatroUtil.ConditionType.BrandPoint then
        local isFullSubCondition = false
        for _, value in pairs(brandDatas) do
            if value:GetShowPoint() == config.ConditionValue2 then
                isFullSubCondition = true
                break
            end
        end
        if isFullSubCondition == false then
            isFullCondition = false
        end
    end
    if isFullCondition == true then
        local propsCount = NumTool.GetLen(BalatroDataMgr.GetPropsBrandDatas())
        if propsCount == BalatroConstVal.MaxPropsBrandCount then
            return
        end
        local curRoundData = BalatroStepMgr.GetCurRoundData()
        local randomPropsConfig = BalatroDataMgr.GetRandomProps(os.time() + curRoundData:GetRoundID())
        local propsBrand = BalatroDataMgr.AddPropsBrandData(randomPropsConfig.ID)
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroGetPropsBrand, {propsBrandData = propsBrand})
        LuaDebug.error("BalatroEffect_10014 获得道具牌")
    end
end




function BalatroEffect_10016(balatroData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:SetSceneEffectValid(false)
    curRound:SetFixGetBrandCount(0)
    curRound:SetScenePlaycardTimes(0)
    curRound:SetSceneDiscardTimes(0)
    curRound:SetGetBrandJudge()
    curRound:SetPlaycardCallback()
    curRound:SetBaseDiscardTimes()
    curRound:SetSceneHandBrandCount(0)
    curRound:SetBrandTypeCountCondition(0)
    curRound:SetIsOncePlaycardCount(false)
    curRound:SetMustPlaycardCount(-1)
    local allBalatro = BalatroDataMgr.GetUsingBalatroLst()
    for key, value in pairs(allBalatro) do
        value:SetInvalid(false)
    end
    local allBrandTypeData = BalatroDataMgr.GetBrandTypeDatas()
    for _, value in pairs(allBrandTypeData) do
        value:CalBeforeReset()
    end
    local allGeneralBrand = brandDatas
    if allGeneralBrand ~= nil then
        for _, value in pairs(allGeneralBrand) do
            value:SetScenePoint(0)
            value:SetIsTurnOver(false)
            value:SetWeaken(false)
        end
    end
end




function BalatroEffect_10017(balatroData, brandDatas, otherParam)
    local config = balatroData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.BrandDeskIndex then
        local conditionValue = tonumber(config.ConditionValue1)
        if conditionValue == BalatroUtil.DeskIndexType.First then
            local maxLeftBalatro = BalatroDataMgr.GetMaxLeftBalatro()
            if maxLeftBalatro ~= nil then
                balatroData:SetFallbackConfig(maxLeftBalatro:GetConfig())
                balatroData:Execute(brandDatas, otherParam)
            end
        elseif conditionValue == BalatroUtil.DeskIndexType.Last then
            local maxRightBalatro = BalatroDataMgr.GetMaxRightBalatro()
            if maxRightBalatro ~= nil then
                balatroData:SetFallbackConfig(maxRightBalatro:GetConfig())
                balatroData:Execute(brandDatas, otherParam)
            end
        end
    end
end







function SceneCalBrandType(brandTypeData, resultType, resultValue, calSymbol)
    if calSymbol == BalatroUtil.CalSymbolType.Division then
        if resultType == BalatroUtil.ResultType.BaseScore then
            brandTypeData:SetBaseScore(brandTypeData:GetConfigBaseScore() / resultValue)
        elseif resultType == BalatroUtil.ResultType.BaseRate then
            brandTypeData:SetBaseRate(brandTypeData:GetConfigBaseRate() / resultValue)
        end
    elseif calSymbol == BalatroUtil.CalSymbolType.Multiply then
        if resultType == BalatroUtil.ResultType.BaseScore then
            brandTypeData:SetBaseScore(brandTypeData:GetConfigBaseScore() * resultValue)
        elseif resultType == BalatroUtil.ResultType.BaseRate then
            brandTypeData:SetBaseRate(brandTypeData:GetConfigBaseRate() * resultValue)
        end
    else
        LuaDebug.error(string.format("SceneCalBrandType: " .. debug.traceback()))
    end
end



function SceneEffect_10000(sceneData, brandDatas, otherParam)
    local config = sceneData:GetConfig()
    if config.ConditionType1 ~= BalatroUtil.ConditionType.BrandType then
        return
    end
    if tostring(config.ConditionValue1) == "" then
        local allBrandTypes = BalatroDataMgr.GetBrandTypeDatas()
        for _, value in pairs(allBrandTypes) do
            if config.ResultType1 ~= 0 then
                SceneCalBrandType(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            end
            if config.ResultType2 ~= 0 then
                SceneCalBrandType(value, config.ResultType2, config.ResultValue2, config.CalSymbol2)
            end
        end
    else
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        if type(conditionValue) ~= "number" then
            return
        end
        local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(conditionValue)
        if config.ResultType1 ~= 0 then
            SceneCalBrandType(brandTypeData, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
        if config.ResultType2 ~= 0 then
            SceneCalBrandType(brandTypeData, config.ResultType2, config.ResultValue2, config.CalSymbol2)
        end
    end
    return true
end



function SceneEffect_10001(sceneData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()



    local func = function(brandDatas1, stepType)
        local config = sceneData:GetConfig()
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        if (not config.ConditionType1 or config.ConditionType1 == 0) and config.CalFrequency == BalatroUtil.CalFrequency.EveryRoundStart and stepType == BalatroUtil.StepType.RoundStart then
            for _, value in pairs(brandDatas1) do
                value:SetIsTurnOver(true)
            end
        elseif config.ConditionType1 == BalatroUtil.ConditionType.Chance then
            for key, value in pairs(brandDatas1) do
                math.randomseed(os.time() + key)
                local randomNum = math.random(1, chanceBaseNum)
                if randomNum < conditionValue then
                    value:SetIsTurnOver(true)
                end
            end
        elseif config.ConditionType1 == BalatroUtil.ConditionType.BrandPoint then
            local tempTbl = {}
            for _, value in pairs(brandDatas1) do
                local tempShowPoint = value:GetShowPoint()
                if tempTbl[tempShowPoint] == nil then
                    tempTbl[tempShowPoint] = {}
                end
                table.insert(tempTbl[tempShowPoint], value)
            end
            if conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table then
                for i = 1, #conditionValue do
                    local brandDatas = tempTbl[conditionValue[i]]
                    if brandDatas then
                        for _, brandData in pairs(brandDatas) do
                            brandData:SetIsTurnOver(true)
                        end
                    end
                end
            elseif type(conditionValue) == BalatroUtil.LuaDataType.Number then
                if tempTbl[conditionValue] then
                    tempTbl[conditionValue]:SetIsTurnOver(true)
                end
            end
        elseif config.ConditionType1 == BalatroUtil.ConditionType.FirstDealBrand then
            for _, value in pairs(brandDatas1) do
                value:SetIsTurnOver(true)
            end
            local tempCurRound = BalatroStepMgr.GetCurRoundData()
            tempCurRound:SetGetBrandJudge()
        else
            for _, value in pairs(brandDatas1) do
                value:SetIsTurnOver(true)
            end
        end
    end
    curRound:SetGetBrandJudge(func)
    return true
end



function SceneEffect_10002(sceneData, brandDatas, otherParam)
    local allHandBrands = BalatroDataMgr.GetMainBrandPool()
    local config = sceneData:GetConfig()
    local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
    if config.ConditionType1 == BalatroUtil.ConditionType.Stytle then
        if type(conditionValue) == BalatroUtil.LuaDataType.Number then
            for _, value in pairs(allHandBrands) do
                value:SetWeaken(value:CheckStyle(conditionValue))
            end
            BalatroDataMgr.WeakStyle = conditionValue
        end
    elseif config.ConditionType1 == BalatroUtil.ConditionType.BrandPoint then
        local tempTbl = {}
        for _, value in pairs(allHandBrands) do
            if conditionValue and type(conditionValue) == BalatroUtil.LuaDataType.Table then
                for i = 1, #conditionValue do
                    if value:GetShowPoint() == conditionValue[i] then
                        value:SetWeaken(true)
                    end
                end
            end
        end
    else
        for _, value in pairs(allHandBrands) do
            value:SetWeaken(true)
        end
    end
    return true
end



function SceneEffect_10003(sceneData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:SetIsOncePlaycardCount(true)
    return true
end



function SceneEffect_10004(sceneData, brandDatas, otherParam)
    local config = sceneData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.Operate then
        local curRound = BalatroStepMgr.GetCurRoundData()
        if config.ResultType1 == BalatroUtil.ResultType.GetBrandCount then
            curRound:SetFixGetBrandCount(config.ResultValue1)
        end
    else
        LuaDebug.error("SceneEffect_10004 : " .. sceneData:GetID())
    end
end



function SceneEffect_10005(sceneData, brandDatas, otherParam)
    local config = sceneData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.BrandTypeCount then
        local curRound = BalatroStepMgr.GetCurRoundData()
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        curRound:SetBrandTypeCountCondition(conditionValue)
    else
        LuaDebug.error("SceneEffect_10005 : " .. sceneData:GetID())
    end
end



function SceneEffect_10006(sceneData, brandDatas, otherParam)
    local config = sceneData:GetConfig()
    local curRound = BalatroStepMgr.GetCurRoundData()
    if config.ResultType1 == BalatroUtil.ResultType.HandBrandLimit then
        curRound:SetSceneHandBrandCount(config.ResultValue1)
    elseif config.ResultType1 == BalatroUtil.ResultType.BaseDiscardTimes then
        curRound:SetBaseDiscardTimes(0)
    end
end



function SceneEffect_10007(sceneData, brandDatas, otherParam)
    BalatroDataMgr.IsLowBrandTypeLevel = true
end



function SceneEffect_10008(sceneData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local config = sceneData:GetConfig()
    if config.ConditionType1 == BalatroUtil.ConditionType.GoalScore then
        curRound:SetExtraGoalScore(curRound:GetConfigGoalScore())
    end
end



function SceneEffect_10009(sceneData, brandDatas, otherParam)
    local stepType = otherParam.stepType


    local callback = function(brandDatas, stepType)
        local config = sceneData:GetConfig()
        if config.ResultType1 ~= BalatroUtil.ResultType.DestroyHandBrand then
            return false, nil
        end
        local handBrands = BalatroDataMgr.GetHandBrandDataList()
        local shuffleIndexes = Shuffle(#handBrands)
        local playBrandDataDic = {}
        local resBrandDatas = {}
        for _, value in pairs(brandDatas) do
            playBrandDataDic[value:GetID()] = value
        end
        local counter = 0
        for i = 1, #shuffleIndexes do
            if counter >= config.ResultValue1 then
                break
            end
            local handBrand = handBrands[i]
            if handBrand ~= nil then
                local indexBrandDataID = handBrand:GetID()
                if not playBrandDataDic[indexBrandDataID] then
                    table.insert(resBrandDatas, handBrand)
                    counter = counter + 1
                end
            end
        end
        return true, resBrandDatas
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:SetPlaycardCallback(callback)
end



function SceneEffect_10010(sceneData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()
    if curRound:GetSceneEffectValid() == false then
        return
    end
    local allBalatro = BalatroDataMgr.GetUsingBalatroLst()

    local allValidBalatro = {}
    for key, value in pairs(allBalatro) do
        if value:GetInvalid() == false then
            table.insert(allValidBalatro, value)
        end
    end
    if #allValidBalatro == 0 then
        return true
    end
    local randomIndex = 1
    if #allValidBalatro > 1 then
        randomIndex = math.random(1, #allValidBalatro)
    end
    allValidBalatro[randomIndex]:SetInvalid(true)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroBrandRefresh)
end



function SceneEffect_10011(sceneData, brandDatas, otherParam)
    local config = sceneData:GetConfig()
    if config == nil then
        return false
    end
    local conditionValue = 0
    if config.ConditionType1 == BalatroUtil.ConditionType.PlaycardNum then
        conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)

        local curRound = BalatroStepMgr.GetCurRoundData()
        curRound:SetMustPlaycardCount(conditionValue)

        if config.ConditonSymbol == BalatroUtil.ConditonSymbol.Equal and brandDatas ~= nil and #brandDatas == conditionValue then
            return true
        end
    end
    return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20031"), conditionValue)
end



function SceneEffect_10012(sceneData, brandDatas, otherParam)
    local config = sceneData:GetConfig()
    if config.ConditionType1 ~= BalatroUtil.ConditionType.Stytle or brandDatas == nil then
        return
    end
    if config.CalSymbol1 == BalatroUtil.CalSymbolType.Multiply then
        local conditionValue = BalatroUtil.SplitNumbers(config.ConditionValue1)
        for _, value in pairs(brandDatas) do
            if value:CheckStyle(conditionValue) == true then
                value:SetScenePoint(value:GetBasePoint() * (config.ResultValue1 - 1))
            end
        end
    end
end



function SceneEffect_10013(sceneData, brandDatas, otherParam)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local config = sceneData:GetConfig()
    if config.ResultType1 == BalatroUtil.ResultType.PlaycardTimes then
        curRound:SetScenePlaycardTimes(config.ResultValue1)
    elseif config.ResultType1 == BalatroUtil.ResultType.DiscardTimes then
        curRound:SetSceneDiscardTimes(config.ResultValue1)
    end
end







function PropsBrandTypeCal(brandTypeData, resultType, resultValue, calSymbol)
    if calSymbol == BalatroUtil.CalSymbolType.Add then
        if resultType == BalatroUtil.ResultType.Score then
            brandTypeData:SetOtherScore(resultValue)
        elseif resultType == BalatroUtil.ResultType.Rate then
            brandTypeData:SetOtherRate(resultValue)
        elseif resultType == BalatroUtil.ResultType.BrandTypeLV then
            brandTypeData:Upgrade(resultValue)
        end
    else
    end
end



function PropsBrandGeneralCal(generalBrand, resultType, resultValue, calSymbol)
    generalBrand:ResetExtraData()
    if calSymbol == BalatroUtil.CalSymbolType.Add then
        if resultType == BalatroUtil.ResultType.Score then
            generalBrand:SetExtraScore(resultValue)
        elseif resultType == BalatroUtil.ResultType.Rate then
            generalBrand:SetExtraRate(resultValue)
        end
    else
        if resultType == BalatroUtil.ResultType.Rate then
            generalBrand:SetExtraMuliRate(resultValue)
        end
    end
end


function PropsEffect_10000(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if config.ValidateType ~= BalatroUtil.ConditionType.BrandType then
        return false, "PropsEffect_10000 error" .. config.ValidateType
    end
    local allBrandTypeDatas = BalatroDataMgr.GetBrandTypeDatas()
    for _, value in pairs(allBrandTypeDatas) do
        if tostring(value:GetType()) == config.ValidateParam then
            if config.ResultType1 ~= 0 then
                PropsBrandTypeCal(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            end
            if config.ResultType2 ~= 0 then
                PropsBrandTypeCal(value, config.ResultType2, config.ResultValue2, config.CalSymbol2)
            end
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroUpLevelBrandType)
    return true, ""
end


function PropsEffect_10001(propsData, brandDatas, otherParam)
    local balatroDatas = BalatroDataMgr.GetUsingBalatros()
    if NumTool.GetLen(balatroDatas) == BalatroConstVal.MaxBalatroBrandCount then
        return false, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20000")
    end
    local balatroDatas = BalatroDataMgr.GetOwnerBaltatroBrand()
    local tempTbl = {}
    for _, value in pairs(balatroDatas) do
        if not balatroDatas[value:GetID()] then
            table.insert(tempTbl, value)
        end
    end
    local randomIndex = math.random(1, #tempTbl)
    local data = {
        selected = true,
        balatroData = tempTbl[randomIndex],
        callback = nil
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, data)
    return true, ""
end


function PropsEffect_10002(propsData, brandDatas, otherParam)
    local balatroDatas = BalatroDataMgr.GetPropsBrandDatas()
    if NumTool.GetLen(balatroDatas) >= BalatroConstVal.MaxPropsBrandCount then
        return false, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20001")
    end
    local lastUsePropsID = BalatroDataMgr.GetLastUsePropsID()
    if lastUsePropsID == nil or lastUsePropsID == 0 then
        return false, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20035")
    end
    local propsBrand = BalatroDataMgr.AddPropsBrandData(lastUsePropsID)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroGetPropsBrand, {propsBrandData = propsBrand})
    return true, ""
end



function PropsEffect_10003(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if config.ValidateType ~= BalatroUtil.ConditionType.BrandPoint then
        return false, LuaMgr.GetLangText("BalatroEffect_20") .. propsData:GetID()
    end
    if config.ValidateObjCount == 100 then
        local curRound = BalatroStepMgr.GetCurRoundData()
        if curRound:GetMaxHandBrandCount() < 1 then
            return false, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20001")
        end

        local allHandBrand = BalatroDataMgr.GetHandBrandDataList()
        local randomIndex = math.random(1, #BalatroUtil.ShowPoint)
        local randomPoint = BalatroUtil.ShowPoint[randomIndex]
        for _, value in pairs(allHandBrand) do
            value:SetTempShowPoint(randomPoint)
        end
        if config.ResultType1 == BalatroUtil.ResultType.HandBrandLimit then
            local tempRes = BalatroDataMgr.GetPropHandBrandLimit() + config.ResultValue1
            if curRound:GetMaxHandBrandCount() <= 1 then
                tempRes = BalatroDataMgr.GetPropHandBrandLimit()
            end
            BalatroDataMgr.SetPropHandBrandLimit(tempRes)
        end
    else
        if not brandDatas or NumTool.GetLen(brandDatas) == 0 then
            return false, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20003")
        end
        if config.ConditionSymbol == BalatroUtil.ConditonSymbol.LessThan then
            if #brandDatas >= config.ValidateObjCount then
                return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20004"), config.ValidateObjCount - 1)
            end
            for _, brandData in pairs(brandDatas) do
                local showPoint = brandData:GetShowPoint() + config.ResultValue1
                if config.ResultValue1 > 0 then
                    showPoint = math.min(showPoint, BalatroUtil.ShowPoint[#BalatroUtil.ShowPoint])
                elseif config.ResultValue1 < 0 then
                    showPoint = math.max(showPoint, BalatroUtil.ShowPoint[1])
                end
                brandData:SetTempShowPoint(showPoint)
            end
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true, ""
end



function PropsEffect_10004(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if not brandDatas or NumTool.GetLen(brandDatas) == 0 then
        return false, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20003")
    elseif NumTool.GetLen(brandDatas) ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    local data1 = brandDatas[1]
    local data2 = brandDatas[2]
    if data1:GetIndex() > data2:GetIndex() then
        data2:Copy(data1)
    else
        data1:Copy(data2)
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true, ""
end



function PropsEffect_10005(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if config.ValidateType ~= BalatroUtil.ConditionType.Stytle then
        return false, LuaMgr.GetLangText("BalatroEffect_20") .. propsData:GetID()
    end
    if not brandDatas or #brandDatas ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    for _, value in pairs(brandDatas) do
        value:SetTempStyle(config.ResultValue1)
        if BalatroDataMgr.IsUseExtra_Style == true then
            if value:GetStyle() == BalatroUtil.Style.Hearts then
                value:SetExtraStyle(BalatroUtil.Style.Diamonds)
            elseif value:GetStyle() == BalatroUtil.Style.Diamonds then
                value:SetExtraStyle(BalatroUtil.Style.Hearts)
            elseif value:GetStyle() == BalatroUtil.Style.Spades then
                value:SetExtraStyle(BalatroUtil.Style.Clubs)
            elseif value:GetStyle() == BalatroUtil.Style.Clubs then
                value:SetExtraStyle(BalatroUtil.Style.Spades)
            end
        end

        value:SetWeaken(value:CheckStyle(BalatroDataMgr.WeakStyle))
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true, ""
end



function PropsEffect_10006(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if config.ValidateType ~= BalatroUtil.ConditionType.BrandPoint then
        return false, LuaMgr.GetLangText("BalatroEffect_20") .. propsData:GetID()
    end
    local generalConfig = ConfigMgr.Config.GeneralBrandList
    local tempConfigTbl = {}
    for key, configData in pairs(generalConfig) do
        local uid = configData.Style * 100 + configData.ShowPoint
        tempConfigTbl[uid] = configData
    end
    local allHandBrandLst = BalatroDataMgr.GetHandBrandDataList()
    local randomIndex = math.random(1, NumTool.GetLen(allHandBrandLst))
    local destroyBrand = allHandBrandLst[randomIndex]
    local tempHandBrands = {}

    if config.ValidateParam == "" or config.ValidateParam == 0 then
        local tempDealCount = config.ValidateObjCount
        for i = 1, tempDealCount do
            math.randomseed(os.time() + i * 10)
            local randomPointIndex = math.random(1, #BalatroUtil.ShowPoint)
            local configUid = destroyBrand:GetConfigStyle() * 100 + BalatroUtil.ShowPoint[randomPointIndex]
            if tempConfigTbl[configUid] ~= nil then
                local tempHandBrand = BalatroDataMgr.NewGeneralBrand(tempConfigTbl[configUid])
                BalatroDataMgr.AddGeneralBrand(tempHandBrand)
                table.insert(tempHandBrands, tempHandBrand)
            end
        end
    else
        local params = BalatroUtil.SplitNumbers(config.ValidateParam)
        if params and type(params) == BalatroUtil.LuaDataType.Table then
            local tempDealCount = #params
            for i = 1, tempDealCount do
                local showPoint = params[i]
                local configUid = destroyBrand:GetConfigStyle() * 100 + showPoint
                if tempConfigTbl[configUid] ~= nil then
                    local tempHandBrand = BalatroDataMgr.NewGeneralBrand(tempConfigTbl[configUid])
                    BalatroDataMgr.AddGeneralBrand(tempHandBrand)
                    table.insert(tempHandBrands, tempHandBrand)
                end
            end
        end
    end
    local data = {
        destroyBrands = {destroyBrand},
        dealBrands = tempHandBrands
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroDestroyHandBrand, data)
    return true, ""
end



function PropsEffect_10007(propsData, brandDatas, otherParam)
    if propsData == nil then
        return false, ""
    end
    local randomStyle = math.random(1, 4)
    local allHandBrandLst = BalatroDataMgr.GetHandBrandDataList()
    for _, value in pairs(allHandBrandLst) do
        value:SetTempStyle(randomStyle)
        if BalatroDataMgr.IsUseExtra_Style == true then
            if value:GetStyle() == BalatroUtil.Style.Hearts then
                value:SetExtraStyle(BalatroUtil.Style.Diamonds)
            elseif value:GetStyle() == BalatroUtil.Style.Diamonds then
                value:SetExtraStyle(BalatroUtil.Style.Hearts)
            elseif value:GetStyle() == BalatroUtil.Style.Spades then
                value:SetExtraStyle(BalatroUtil.Style.Clubs)
            elseif value:GetStyle() == BalatroUtil.Style.Clubs then
                value:SetExtraStyle(BalatroUtil.Style.Spades)
            end
        end

        value:SetWeaken(value:CheckStyle(BalatroDataMgr.WeakStyle))
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true, ""
end



function PropsEffect_10008(propsData, brandDatas, otherParam)
    local allBalatroData = BalatroDataMgr.GetUsingBalatroLst()

    local tempTbl = {}
    for _, value in pairs(allBalatroData) do
        if value:CanCopyAbility() then
            table.insert(tempTbl, value)
        end
    end
    if #tempTbl == 0 then

        return false, ""
    end
    local randomIndex = math.random(1, #tempTbl)
    local targetBrand = tempTbl[randomIndex]
    for key, data in pairs(allBalatroData) do
        if data:GetUID() ~= targetBrand:GetUID() then
            local paramsData = {
                selected = false,
                balatroData = data,
                callback = nil
            }
            data:SetDestroy()
            LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, paramsData)
            BalatroDataMgr.SelectBrandGroup(data, false)
        end
    end
    local destBrand = table.Copy(targetBrand)
    destBrand:SetIsTemp(true)
    destBrand:SetUID(BalatroDataMgr.GenBalatroBrandUID(targetBrand:GetID()))
    local paramsData = {
        selected = true,
        balatroData = destBrand,
        callback = nil
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, paramsData)
    BalatroDataMgr.SelectBrandGroup(destBrand, true)

    return true, ""
end



function PropsEffect_10009(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if #brandDatas ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    local generalConfig = ConfigMgr.Config.GeneralBrandList
    local generalConfigLen = #generalConfig
    local tempConfigTbl = {}
    for i = 1, generalConfigLen do
        local configData = generalConfig[i]
        local uid = configData.Style * 100 + configData.ShowPoint
        tempConfigTbl[uid] = configData
    end
    local tempHandBrands = {}
    local brandData = brandDatas[1]
    for i = 1, config.ResultValue1 do
        local configUid = brandData:GetConfigStyle() * 100 + brandData:GetShowPoint()
        if tempConfigTbl[configUid] ~= nil then
            local tempHandBrand = BalatroDataMgr.NewGeneralBrand(tempConfigTbl[configUid])
            tempHandBrand:Copy(brandData)
            table.insert(tempHandBrands, tempHandBrand)
            BalatroDataMgr.AddGeneralBrand(tempHandBrand)
        end
    end
    local data = {
        dealBrands = tempHandBrands
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroDestroyHandBrand, data)
    return true, ""
end



function PropsEffect_10010(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if config.ValidateType ~= BalatroUtil.ConditionType.BrandType then
        return false, LuaMgr.GetLangText("BalatroEffect_20") .. propsData:GetID()
    end
    local allBrandTypes = BalatroDataMgr.GetBrandTypeDatas()
    for _, value in pairs(allBrandTypes) do
        if config.ResultType1 ~= 0 then
            PropsBrandTypeCal(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroUpLevelBrandType)
    return true, ""
end



function PropsEffect_10011(propsData, brandDatas, otherParam)
    local usingBalatro = BalatroDataMgr.GetUsingBalatroLst()
    local randomIndex = math.random(1, #usingBalatro)
    local paramsData = {
        selected = false,
        balatroData = usingBalatro[randomIndex],
        callback = nil
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, paramsData)
    BalatroDataMgr.SelectBrandGroup(usingBalatro[randomIndex], false)
end




function PropsEffect_10012(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if #brandDatas ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    for _, value in pairs(brandDatas) do
        value:SetSuperShowType(BalatroUtil.ShowType.Super)
        if config.ResultType1 ~= 0 then
            PropsBrandGeneralCal(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
        if config.ResultType2 ~= 0 then
            PropsBrandGeneralCal(value, config.ResultType2, config.ResultValue2, config.CalSymbol2)
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true
end




function PropsEffect_10013(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if #brandDatas ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    for _, value in pairs(brandDatas) do
        value:SetSuperShowType(BalatroUtil.ShowType.Rate)
        if config.ResultType1 ~= 0 then
            PropsBrandGeneralCal(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true
end




function PropsEffect_10014(propsData, brandDatas, otherParam)
    local config = propsData:GetConfig()
    if #brandDatas ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    for _, value in pairs(brandDatas) do
        value:SetSuperShowType(BalatroUtil.ShowType.Score)
        if config.ResultType1 ~= 0 then
            PropsBrandGeneralCal(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true
end




function PropsEffect_10015(propsData, brandDatas, otherParam)
    local rateChance = 1 / 5
    local scoreChance = 1 / 5
    local config = propsData:GetConfig()
    if #brandDatas ~= config.ValidateObjCount then
        return false, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20005"), config.ValidateObjCount)
    end
    math.randomseed(os.time())
    for _, value in pairs(brandDatas) do
        value:SetSuperShowType(BalatroUtil.ShowType.Lucky)
        local random1 = math.random()
        if random1 < rateChance then
            if config.ResultType1 ~= 0 then
                PropsBrandGeneralCal(value, config.ResultType1, config.ResultValue1, config.CalSymbol1)
            end
        end
        local random2 = math.random()
        if random2 < scoreChance then
            if config.ResultType2 ~= 0 then
                PropsBrandGeneralCal(value, config.ResultType2, config.ResultValue2, config.CalSymbol2)
            end
        end
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshHandBrand)
    return true
end

