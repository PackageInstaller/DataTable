





require("Balatro/BalatroData/BalatroGeneralBrandData")


BalatroBrandTypeData = {}
BalatroBrandTypeData.__index = BalatroBrandTypeData

function BalatroBrandTypeData.New(configData)
    if not configData or not configData.ID then
        LuaDebug.error("错误：无效的配置数据")
        return nil
    end

    local self = setmetatable({}, BalatroBrandTypeData)
    self._ConfigData = configData
    self._ID = configData.ID
    self._Level = 0
    self._OtherRate = 0
    self._OtherScore = 0
    self._TotalRate = 0
    self._TotalScore = 0

    self._ValidTimes = 0

    self._LevelLow = false
    self:Reset()
    return self
end

function BalatroBrandTypeData:Reset()
    self._Level = 0
    self._ValidTimes = 0
    self._LevelLow = false
    self._baseRate = self._ConfigData.BaseRate
    self._baseScore = self._ConfigData.BaseScore
    self._TotalRate = self._ConfigData.BaseRate
    self._TotalScore = self._ConfigData.BaseScore
    self:Upgrade(1)
self:SetOtherRate(0)
self:SetOtherScore(0)
end

function BalatroBrandTypeData:CalBeforeReset()
    self._LevelLow = false
    self._baseRate = self._ConfigData.BaseRate
    self._baseScore = self._ConfigData.BaseScore
end

function BalatroBrandTypeData:GetID()
    return self._ID
end

function BalatroBrandTypeData:GetName()
    local name = LuaMgr.GetLangText(self._ConfigData.Namelan)
    if not name or name == "" then
        name = self._ConfigData.Name
    end
    return name
end

function BalatroBrandTypeData:GetDes()
    local des = LuaMgr.GetLangText(self._ConfigData.Deslan)
    if not des or des == "" then
        des = self._ConfigData.Des
    end
    return des
end

function BalatroBrandTypeData:GetModelIDs()
    return self._ConfigData.ModelIDs
end

function BalatroBrandTypeData:GetType()
    return self._ConfigData.Type
end

function BalatroBrandTypeData:AddValidTimes()
    self._ValidTimes = self._ValidTimes + 1
end

function BalatroBrandTypeData:GetValidTimes()
    return self._ValidTimes
end

function BalatroBrandTypeData:Upgrade(level)
    if self._Level >= self._ConfigData.MaxLevel then
        return
    end
    local tempLevel = self._Level + level
    self._Level = math.min(tempLevel, self._ConfigData.MaxLevel)
    self._TotalRate = self._baseRate + (self._Level - 1) * self._ConfigData.GrowRate
    self._TotalScore = self._baseScore + (self._Level - 1) * self._ConfigData.GrowScore
end

function BalatroBrandTypeData:GetLevel(ignoreLevelLow)
    if self._LevelLow and not ignoreLevelLow then
        return math.max(self._Level - 1, 1)
    end
    return self._Level
end

function BalatroBrandTypeData:SetBaseRate(num)
    self._baseRate = num
end

function BalatroBrandTypeData:SetBaseScore(num)
    self._baseScore = num
end

function BalatroBrandTypeData:GetConfigBaseRate()
    return self._ConfigData.BaseRate
end

function BalatroBrandTypeData:GetConfigBaseScore()
    return self._ConfigData.BaseScore
end

function BalatroBrandTypeData:SetOtherRate(rate)
    if type(rate) == BalatroUtil.LuaDataType.Number then
        self._OtherRate = self._OtherRate + rate
    end
end

function BalatroBrandTypeData:SetOtherScore(score)
    if type(score) == BalatroUtil.LuaDataType.Number then
        self._OtherScore = self._OtherScore + score
    end
end

function BalatroBrandTypeData:GetSortID()
    return self._ConfigData.SortID
end


function BalatroBrandTypeData:GetTotalRate(ignoreLevelLow)
    local tempRate = self._TotalRate
    local tempLevel = 0
    if self._LevelLow and not ignoreLevelLow then

        tempLevel = self._Level - 1 - 1
        tempLevel = math.max(0, tempLevel)
    else
        tempLevel = self._Level - 1
    end
    tempRate = self._baseRate + tempLevel * self._ConfigData.GrowRate
    return tempRate + self._OtherRate
end


function BalatroBrandTypeData:GetTotalScore(ignoreLevelLow)
    local tempScore = self._TotalScore
    local tempLevel = 0
    if self._LevelLow and not ignoreLevelLow then
        tempLevel = self._Level - 1 - 1
        tempLevel = math.max(0, tempLevel)
    else
        tempLevel = self._Level - 1
    end
    tempScore = self._baseScore + tempLevel * self._ConfigData.GrowScore
    return tempScore + self._OtherScore
end


function BalatroBrandTypeData:SetIsLowLevel(isLowLevel)
    self._LevelLow = isLowLevel
end




BalatroBrandTypeData.AllBrandTypes = {}


BalatroBrandTypeData.Init = function(configDatas)
    local brandTypeLen = #BalatroBrandTypeData.AllBrandTypes
    if brandTypeLen ~= 0 then
        for i = 1, brandTypeLen do
            if BalatroBrandTypeData.AllBrandTypes[i] then
                BalatroBrandTypeData.AllBrandTypes[i]:Clear()
            end
        end
        return
    end
    if configDatas == nil then
        LuaDebug.error("BalatroBrandTypeData.Init：参数错误")
        return
    end
    local configLen = #configDatas
    for i = 1, configLen do
        local brandTypeData = BalatroBrandTypeData.New(configDatas[i])
        table.insert(BalatroBrandTypeData.AllBrandTypes, brandTypeData)
    end
end



BalatroBrandTypeData.GetBrandType = function(brandDataLst)
    local styleStr = ""
    for key, value in pairs(brandDataLst) do
        styleStr = styleStr .. " " .. value:GetName()
    end
    if brandDataLst == nil or #brandDataLst == 0 then
        return 0
    end

    local pointDic = {}
    local styles = {}
    local isFlush = false
    local isStraight = false
    local flushBrandCount = 0

    local baseBrandCount = BalatroDataMgr.Flush_Straight_NeedCount
    local isUseExtraStyle = BalatroDataMgr.IsUseExtra_Style

    local brandDataLen = #brandDataLst
    for i = 1, brandDataLen do
        local brand = brandDataLst[i]
        local brandID = brand:GetShowPoint()
        local style = brand:GetStyle()
        local extraSytle = brand:GetExtraStyle()
        pointDic[brandID] = (pointDic[brandID] or 0) + 1
        if styles[style] == nil then
            styles[style] = {}
        end
        table.insert(styles[style], brand)
        if isUseExtraStyle == true and extraSytle ~= 0 then
            if styles[extraSytle] == nil then
                styles[extraSytle] = {}
            end
            table.insert(styles[extraSytle], brand)
        end
    end

    for _, sameStyleBrands in pairs(styles) do
        if #sameStyleBrands >= baseBrandCount then
            isFlush = true
            flushBrandCount = math.max(flushBrandCount, #sameStyleBrands)
        end
    end

    isStraight = BalatroBrandTypeData.IsStraight(pointDic, baseBrandCount)

    if isFlush == true and isStraight == true then
        for _, sameStyleBrands in pairs(styles) do
            local temmPointDic = {}
            local tempIsStraight = false
            if #sameStyleBrands >= baseBrandCount then
                for i = 1, #sameStyleBrands do
                    local brand = sameStyleBrands[i]
                    local brandID = brand:GetShowPoint()
                    temmPointDic[brandID] = (temmPointDic[brandID] or 0) + 1
                end
                tempIsStraight = BalatroBrandTypeData.IsStraight(temmPointDic, baseBrandCount)
                if tempIsStraight == true then

                    return BalatroUtil.BrandType.FlushStraight + 3999
                end
            end
        end
    end
    local frequencies = {}
    for _, v in pairs(pointDic) do
        frequencies[v] = (frequencies[v] or 0) + 1
    end

    local brandType = 0
    if frequencies[5] then
        if isFlush and flushBrandCount == 5 then
            brandType = BalatroUtil.BrandType.FlushPenta
        else
            brandType = BalatroUtil.BrandType.Penta
        end
    elseif frequencies[4] then
        brandType = BalatroUtil.BrandType.Quadra
    elseif frequencies[3] and frequencies[2] then

        if isFlush and flushBrandCount == 5 then
            brandType = BalatroUtil.BrandType.FlushGourd
        else
            brandType = BalatroUtil.BrandType.Gourd
        end
    elseif isFlush then
        brandType = BalatroUtil.BrandType.Flush
    elseif isStraight then
        brandType = BalatroUtil.BrandType.Straight
    elseif frequencies[3] then
        brandType = BalatroUtil.BrandType.Triple
    elseif frequencies[2] == 2 then
        brandType = BalatroUtil.BrandType.TwoDouble
    elseif frequencies[2] == 1 then
        brandType = BalatroUtil.BrandType.Double
    else
        brandType = BalatroUtil.BrandType.Normal
    end
    if brandType > 0 then
        brandType = brandType + 3999
    else
        LuaDebug.error("BalatroBrandTypeData.GetBrandType 牌型ID错误")
    end
    return brandType
end




BalatroBrandTypeData.GetAllBrandType = function(brandDataLst)
    if brandDataLst == nil or #brandDataLst == 0 then
        return {}
    end

    local pointDic = {}
    local styles = {}
    local isFlush = false
    local flushBrandCount = 0
    local isStraight = false
    local allBrandTypes = {}

    local baseBrandCount = BalatroDataMgr.Flush_Straight_NeedCount
    local isUseExtraStyle = BalatroDataMgr.IsUseExtra_Style

    local brandDataLen = #brandDataLst
    for i = 1, brandDataLen do
        local brand = brandDataLst[i]
        local brandID = brand:GetShowPoint()
        local style = brand:GetStyle()
        local extraSytle = brand:GetExtraStyle()
        pointDic[brandID] = (pointDic[brandID] or 0) + 1
        if styles[style] == nil then
            styles[style] = {}
        end
        table.insert(styles[style], brand)
        if isUseExtraStyle == true and extraSytle ~= 0 then
            if styles[extraSytle] == nil then
                styles[extraSytle] = {}
            end
            table.insert(styles[extraSytle], brand)
        end
    end

    for _, sameStyleBrands in pairs(styles) do
        if #sameStyleBrands >= baseBrandCount then
            isFlush = true
            flushBrandCount = math.max(flushBrandCount, #sameStyleBrands)
        end
    end

    isStraight = BalatroBrandTypeData.IsStraight(pointDic, baseBrandCount)

    if isFlush == true and isStraight == true then
        for _, sameStyleBrands in pairs(styles) do
            local temmPointDic = {}
            local tempIsStraight = false
            if #sameStyleBrands >= baseBrandCount then
                for i = 1, #sameStyleBrands do
                    local brand = sameStyleBrands[i]
                    local brandID = brand:GetShowPoint()
                    temmPointDic[brandID] = (temmPointDic[brandID] or 0) + 1
                end
                tempIsStraight = BalatroBrandTypeData.IsStraight(temmPointDic, baseBrandCount)
                if tempIsStraight == true then

                    allBrandTypes[BalatroUtil.BrandType.FlushStraight] = true
                    return allBrandTypes
                end
            end
        end
    end
    local frequencies = {}
    for _, v in pairs(pointDic) do
        frequencies[v] = (frequencies[v] or 0) + 1
    end

    if frequencies[5] then
        if isFlush and flushBrandCount == 5 then
            allBrandTypes[BalatroUtil.BrandType.FlushPenta] = true
        else
            allBrandTypes[BalatroUtil.BrandType.Penta] = true
        end
    end
    if frequencies[4] then
        allBrandTypes[BalatroUtil.BrandType.Quadra] = true
    end
    if frequencies[3] and frequencies[2] then
        if isFlush and flushBrandCount == 5 then
            allBrandTypes[BalatroUtil.BrandType.FlushGourd] = true
        else
            allBrandTypes[BalatroUtil.BrandType.Gourd] = true
        end
    end
    if isFlush then
        allBrandTypes[BalatroUtil.BrandType.Flush] = true
    end
    if isStraight then
        allBrandTypes[BalatroUtil.BrandType.Straight] = true
    end
    if frequencies[3] then
        allBrandTypes[BalatroUtil.BrandType.Triple] = true
    end
    if frequencies[2] == 2 then
        allBrandTypes[BalatroUtil.BrandType.TwoDouble] = true
    end
    if frequencies[2] == 1 then
        allBrandTypes[BalatroUtil.BrandType.Double] = true
    else
        allBrandTypes[BalatroUtil.BrandType.Normal] = true
    end
    return allBrandTypes
end

BalatroBrandTypeData.IsStraight = function(pointDic, needBrandCount)
    local isApart = BalatroDataMgr.Straight_IsPart

    local showPointLst = {}
    for pointIndex, _value in pairs(pointDic) do
        table.insert(showPointLst, BalatroUtil.ShowPoint[pointIndex - 1])
    end
    table.sort(showPointLst)
    local isStraight = false
    if #showPointLst < needBrandCount then
        return isStraight
    end

    if showPointLst[needBrandCount] == BalatroUtil.ShowPoint[#BalatroUtil.ShowPoint] then

        if showPointLst[1] == BalatroUtil.ShowPoint[1] then

            local apartPoint = showPointLst[#showPointLst - 1] - showPointLst[1]
            if isApart == true then
                if apartPoint > 0 and apartPoint <= (needBrandCount - 1) then
                    isStraight = true
                end
            else
                if apartPoint == (needBrandCount - 2) then
                    isStraight = true
                end
            end
        end
    end

    if isStraight == false then
        for i = 1, #showPointLst - (needBrandCount - 1) do
            local apartPoint = showPointLst[i + (needBrandCount - 1)] - showPointLst[i]
            if isApart == true then
                if apartPoint > 0 and apartPoint <= needBrandCount then
                    isStraight = true
                    break
                end
            else
                if apartPoint == (needBrandCount - 1) then
                    isStraight = true
                    break
                end
            end
        end
    end
    return isStraight
end

BalatroBrandTypeData.ToString = function(brandDataLst)
    return json.encode(brandDataLst)
end

