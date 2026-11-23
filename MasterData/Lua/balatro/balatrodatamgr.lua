





require("Balatro/BalatroConstVal")
require("Balatro/BalatroData/BalatroGeneralBrandData")
require("Manager/Player/PlayerBalatroMgr")
require("Balatro/BalatroData/BalatroData")
require("Balatro/BalatroData/BalatroBrandTypeData")
require("Balatro/BalatroData/BalatroSceneData")
require("Balatro/BalatroData/BalatroPropBrandData")
BalatroDataMgr = {}

local this = {
statisticsData = nil,

generalConfig = nil,
propsBrandsConfigDic = nil,
    propsBrandsConfigs = nil,
    propsCumulativeWeights = nil,

generalBrands1 = nil,

    generalBrands2 = nil,

    generalBrandIDCount = {},

    choosedBrandDic = nil,

balatroBrands = nil,

usingBalatroBrandsDic = nil,

    usingBalatroBrandsLst = nil,
sceneEffectConfigDic = nil,
    sceneEffectIDTbl = nil,

ownerPropsBrandsByID = nil,

ownerPropsBrandsByUID = nil,

usedPropsBrands = nil,

brandTypesByID = nil,

allDropBalatroBrand = {},
    brandTypesByType = nil,
levelDatas = nil,
    curPhaseNum = 0,
    curRoundNum = 0,
    timeStamp = 0,
    lastUsePropsID = 0,
    maxLeftBalatro = nil,
    maxRightBalatro = nil,
isSettling = false,
    gameStartTime = 0,
propToHandBrandLimit = 0
}

BalatroDataMgr.Flush_Straight_NeedCount = 5
BalatroDataMgr.Straight_IsPart = false
BalatroDataMgr.IsUseExtra_Style = false
BalatroDataMgr.IsLowBrandTypeLevel = false
BalatroDataMgr.WeakStyle = 0

BalatroDataMgr.Init = function()
    this.timeStamp = LuaMgr.Timestamp()
    this.statisticsData = {}
this.statisticsData.totalScore = 0
this.statisticsData.bestBrandScore = 0
this.statisticsData.frequentBrandtype = 0
this.statisticsData.frequentBrandtypeCount = 0
this.statisticsData.totalPlaybrand = 0
this.statisticsData.totalChangeBrand = 0
this.statisticsData.totalDisbrand = 0
this.statisticsData.totalPropsBrand = 0
this.statisticsData.phaseNum = 0
this.statisticsData.totalRound = 0
    this.statisticsData.evaluateID = 0
    this.statisticsData.gameStartTime = this.timeStamp
    this.generalBrandsConfig = {}
    this.propsBrandsConfigDic = {}
    this.propsBrandsConfigs = {}
    this.propsCumulativeWeights = {}
this.generalBrands1 = {}
    this.generalBrands2 = {}
    this.generalBrandIDCount = {}
    this.choosedBrandDic = {}
this.balatroBrands = {}
this.usingBalatroBrandsDic = {}
    this.usingBalatroBrandsLst = {}
    this.allDropBalatroBrand = {}
this.sceneEffectConfigDic = {}
    this.sceneEffectIDTbl = {}
    this.ownerPropsBrandsByID = {}
    this.ownerPropsBrandsByUID = {}
    this.usedPropsBrands = {}
    this.brandTypesByID = {}
    this.brandTypesByType = {}
    this.levelDatas = {}
    this.curPhaseNum = 0
    this.curRoundNum = 0
    this.lastUsePropsID = 0
    this.isSettling = false
    this.propToHandBrandLimit = 0
    PlayerBalatroMgr.Init()
    BalatroConstVal.SetDefaultHandCardCount(ConfigMgr.Config.constants.DefaultHandCardCount or 5)
    BalatroConstVal.SetPlaycardTimesScore(ConfigMgr.Config.constants.PlaycardTimesScore)
    BalatroConstVal.SetDiscardTimesScore(ConfigMgr.Config.constants.DiscardTimesScore)
    BalatroDataMgr.InitGeneralBrands()
    BalatroDataMgr.InitBalatroBrand()
    BalatroDataMgr.InitPropBrand()
    BalatroDataMgr.InitBrandType()
    BalatroDataMgr.InitLevelData()
    BalatroDataMgr.InitSceneData()
end

BalatroDataMgr.FunctionIsOpen = function()
    return ConfigMgr.Config.GeneralBrandList ~= nil and ConfigMgr.Config.BalatroList ~= nil and ConfigMgr.Config.BalatroSceneList ~= nil and ConfigMgr.Config.BalatroPropsList ~= nil and ConfigMgr.Config.BrandTypeList ~= nil and ConfigMgr.Config.BalatroPhaseDataList ~= nil and ConfigMgr.Config.BalatroCharges ~= nil
end

BalatroDataMgr.Clear = function()
    BalatroDataMgr.ClearCouncil()
    BalatroDataMgr.ClearOutSide()
end

BalatroDataMgr.Destroy = function()
    BalatroDataMgr.Clear()
end



BalatroDataMgr.GetOwnerBaltatroBrand = function(isAll)
    if not this.balatroBrands then
        return {}
    end
    local tbl = {}
    local allBrandDataLen = #this.balatroBrands
    for i = 1, allBrandDataLen do
        local brandData = this.balatroBrands[i]
        if isAll == true then
            table.insert(tbl, brandData)
        elseif brandData:GetOwnStatus() == BalatroUtil.BalatroOwnStatus.Old then
            table.insert(tbl, brandData)
        end
    end
    return tbl
end



BalatroDataMgr.SelectBrandGroup = function(brandData, isSelect)
    local uid = brandData:GetUID()
    if brandData:GetIsTemp() ~= true then
        PlayerBalatroMgr.SetBalatroBrand(string.format("General_%d", brandData:GetUID()), brandData:GetID(), isSelect)
    end
    brandData:SetSelected(isSelect)
    if isSelect then
        this.usingBalatroBrandsDic[uid] = brandData

        brandData:SetUsePropsCount(#BalatroDataMgr.UsedPropsBrandData())
    else
        brandData:Reset()
        this.usingBalatroBrandsDic[uid] = nil
    end
    this.usingBalatroBrandsLst = {}
    for key, value in pairs(this.usingBalatroBrandsDic) do
        table.insert(this.usingBalatroBrandsLst, value)
    end
    table.sort(this.usingBalatroBrandsLst, BalatroUtil.SortBalatroBrand)
end

BalatroDataMgr.GenBalatroBrandUID = function(brandID)
    local maxUID = 0
    for key, value in pairs(this.usingBalatroBrandsDic) do
        if brandID == value:GetID() then
            maxUID = math.max(maxUID, value:GetUID())
        end
    end
    return maxUID + 1
end



BalatroDataMgr.GetUsingBalatros = function()
    return this.usingBalatroBrandsDic
end



BalatroDataMgr.GetUsingBalatroLst = function()
    return this.usingBalatroBrandsLst
end



BalatroDataMgr.SetMaxLeftBalatro = function(data)
    this.maxLeftBalatro = data
end


BalatroDataMgr.GetMaxLeftBalatro = function()
    return this.maxLeftBalatro
end



BalatroDataMgr.SetMaxRightBalatro = function(data)
    this.maxRightBalatro = data
end


BalatroDataMgr.GetMaxRightBalatro = function()
    return this.maxRightBalatro
end


BalatroDataMgr.SetBalatroBrandCountLimit = function()
    local usingBalatroDatas = BalatroDataMgr.GetUsingBalatroLst()
    local totalCount = 0
    for key, value in pairs(usingBalatroDatas) do
        totalCount = totalCount + value:GetHandBrandLimit()
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:SetBalatroHandBrandCount(totalCount)
end



BalatroDataMgr.AddGeneralBrand = function(brandData)
    table.insert(this.generalBrands2, brandData)
    brandData:SetUsed(true)
end


BalatroDataMgr.ResetBrandPool = function()
    for i = 1, #this.generalBrands2 do

        local data = table.remove(this.generalBrands2)
        if data:IsDestroy() == false then
            table.insert(this.generalBrands1, data)
            data:SetUsed(false)
        end
    end
    BalatroDataMgr.ShuffleBrand(this.generalBrands1)
end

BalatroDataMgr.GetBrandPoolTotalCount = function()
    return #this.generalBrands1 + #this.generalBrands2
end

BalatroDataMgr.GetMainBrandPool = function()
    return this.generalBrands1
end

BalatroDataMgr.GetSecondBrandPool = function()
    return this.generalBrands2
end



BalatroDataMgr.GetGeneralBrand = function(count, stepType)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local fixGetBrandCount = curRound:GetFixGetBrandCount()
    if not count then
        count = curRound:GetMaxHandBrandCount()
    elseif fixGetBrandCount > 0 then
        count = math.min(count, fixGetBrandCount)
    end
    local tempTbl = {}
    for i = 1, count do
        if #this.generalBrands1 == 0 then
            break
        end

        local orginBrand = table.remove(this.generalBrands1)
        if orginBrand then
            table.insert(tempTbl, orginBrand)
            table.insert(this.generalBrands2, orginBrand)
            orginBrand:SetUsed(true)
            if BalatroDataMgr.IsUseExtra_Style == true then
                if orginBrand:GetStyle() == BalatroUtil.Style.Hearts then
                    orginBrand:SetExtraStyle(BalatroUtil.Style.Diamonds)
                elseif orginBrand:GetStyle() == BalatroUtil.Style.Diamonds then
                    orginBrand:SetExtraStyle(BalatroUtil.Style.Hearts)
                elseif orginBrand:GetStyle() == BalatroUtil.Style.Spades then
                    orginBrand:SetExtraStyle(BalatroUtil.Style.Clubs)
                elseif orginBrand:GetStyle() == BalatroUtil.Style.Clubs then
                    orginBrand:SetExtraStyle(BalatroUtil.Style.Spades)
                end
            else
                orginBrand:SetExtraStyle(0)
            end
        end
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:CallGetBrandJudge(tempTbl, stepType)
    return tempTbl
end




BalatroDataMgr.AddOrRemoveHandBrand = function(isAdd, data)
    if not data then
        return
    end

    if not this.handBrandDatas then
        this.handBrandDatas = {}
    end
    local dataID = data:GetID()
    if isAdd then
        if not this.handBrandDatas[dataID] then
            this.handBrandDatas[dataID] = {}
        end
        table.insert(this.handBrandDatas[dataID], data)
    else
        if this.handBrandDatas[dataID] and #this.handBrandDatas[dataID] > 0 then
            table.remove(this.handBrandDatas[dataID])
        end
    end
end

BalatroDataMgr.ClearHandBrand = function()
    this.handBrandDatas = {}
end

BalatroDataMgr.GetHandBrandDataDic = function()
    return this.handBrandDatas
end



BalatroDataMgr.GetHandBrandDataList = function()
    local tempTbl = {}
    for _, value in pairs(this.handBrandDatas) do
        if value ~= nil then
            for key1, value2 in pairs(value) do
                table.insert(tempTbl, value2)
            end
        end
    end
    return tempTbl
end


BalatroDataMgr.OnChooseGeneralBrand = function(data, isChoose)
    if not data then
        LuaDebug.error("BalatroDataMgr.OnChooseGeneralBrand 数据错误")
        return
    end
    local id = data:GetID()

    if this.choosedBrandDic[id] == nil then
        this.choosedBrandDic[id] = {}
    end
    if isChoose == true then
        table.insert(this.choosedBrandDic[id], data)
    else
        if #this.choosedBrandDic[id] > 0 then
            table.remove(this.choosedBrandDic[id])
        else
            this.choosedBrandDic[id] = {}
        end
    end
end

BalatroDataMgr.GetChooseBrandList = function()
    local tbl = {}
    if not this.choosedBrandDic then
        return tbl
    end
    for _, value in pairs(this.choosedBrandDic) do
        for i = 1, #value do
            table.insert(tbl, value[i])
        end
    end
    return tbl
end

BalatroDataMgr.ResetChooseBrand = function()
    this.choosedBrandDic = {}
end



BalatroDataMgr.GetDropBrand = function()
    return this.allDropBalatroBrand
end

BalatroDataMgr.SetSettlingStatus = function(isSettling)
    this.isSettling = isSettling
end

BalatroDataMgr.GetSettlingStatus = function()
    return this.isSettling
end


BalatroDataMgr.GetPropsBrandDatas = function()
    return this.ownerPropsBrandsByUID
end




BalatroDataMgr.AddPropsBrandData = function(id)
    local config = this.propsBrandsConfigDic[id]
    if not config then
        LuaDebug.error("BalatroDataMgr.AddPropsBrandData 配置异常 ID:" .. id)
        return nil
    end
    local propsBrand = BalatroPropBrandData.New(config)
    if not this.ownerPropsBrandsByID[id] then
        this.ownerPropsBrandsByID[id] = {}
    end
    table.insert(this.ownerPropsBrandsByID[id], propsBrand)

    local _, phaseIndex = BalatroStepMgr.GetCurPhaseData()
    local curRound = BalatroStepMgr.GetCurRoundData()
    local uid = id * 10000 + phaseIndex * 1000 + curRound:GetRound() * 100 + #this.ownerPropsBrandsByID[id]
    propsBrand:SetUID(uid)
    this.ownerPropsBrandsByUID[uid] = propsBrand
    BalatroUtil.PlaySound(4)
    return propsBrand
end

BalatroDataMgr.GetPropsBrandData = function(uid)
    return this.ownerPropsBrandsByUID[uid]
end

BalatroDataMgr.UsePropsBrandData = function(uid)
    if not this.ownerPropsBrandsByUID[uid] or NumTool.GetLen(this.ownerPropsBrandsByUID) == 0 then
        LuaDebug.error("BalatroDataMgr.AddPropsBrandData 试图删除不存在的道具卡:" .. uid)
        return false, "Error nil"
    end
    local propsBrand = table.Copy(this.ownerPropsBrandsByUID[uid])
    local selectGeneralBrand = BalatroDataMgr.GetChooseBrandList()
    local useRes, useResStr = propsBrand:Use(selectGeneralBrand, nil)
    if useRes == false then
        return useRes, useResStr
    end
    if this.ownerPropsBrandsByID[uid] and #this.ownerPropsBrandsByID[uid] > 0 then
        local pos = 0
        for key, value in pairs(this.ownerPropsBrandsByID[uid]) do
            if value:GetUID() == uid then
                pos = key
                break
            end
        end
        table.remove(this.ownerPropsBrandsByID[uid], pos)
        if #this.ownerPropsBrandsByID[uid] == 0 then
            this.ownerPropsBrandsByID[uid] = nil
        end
    end
    this.ownerPropsBrandsByUID[uid] = nil
    local roundData = BalatroStepMgr.GetCurRoundData()
    roundData:AddUsePropscardData(propsBrand)
    table.insert(this.usedPropsBrands, propsBrand)

    if propsBrand:GetConfig().ValidateType ~= BalatroUtil.ConditionType.PropsBrand then
        this.lastUsePropsID = propsBrand:GetID()
    end
    BalatroStepMgr.AfterUsePropsBrand()
    return useRes, useResStr
end

BalatroDataMgr.UsedPropsBrandData = function()
    return this.usedPropsBrands
end

BalatroDataMgr.GetLastUsePropsID = function()
    return this.lastUsePropsID
end

BalatroDataMgr.SetPropHandBrandLimit = function(num)
    this.propToHandBrandLimit = num
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:SetPropsHandBrandCount(this.propToHandBrandLimit)
end

BalatroDataMgr.GetPropHandBrandLimit = function()
    return this.propToHandBrandLimit
end

BalatroDataMgr.GetRandomProps = function(seedValue)
    math.randomseed(this.timeStamp + seedValue)
    local randomValue = math.random(0, this.propsTotalWeight - 1)
    local low, high = 1, #this.propsCumulativeWeights
    while low < high do
        local mid = math.floor((low + high) / 2)
        if randomValue < this.propsCumulativeWeights[mid] then
            high = mid
        else
            low = mid + 1
        end
    end
    return this.propsBrandsConfigs[low]
end


BalatroDataMgr.GetBrandTypeDatas = function()
    return this.brandTypesByID
end


BalatroDataMgr.BrandTypeUpgrade = function(id, level)
    if not level then
        level = 1
    end
    if this.brandTypesByID and this.brandTypesByID[id] then
        this.brandTypesByID[id]:Upgrade(level)
    end
end



BalatroDataMgr.GetBrandTypeDataByID = function(id)
    return this.brandTypesByID[id]
end



BalatroDataMgr.GetBrandTypeDataByType = function(type)
    return this.brandTypesByType[type]
end

BalatroDataMgr.RefreshStatisticsData = function()
    this.statisticsData.totalScore = BalatroStepMgr.GetGlobalTotalScore()
    this.statisticsData.bestBrandScore = BalatroStepMgr.GetBestPlaycardScore()
    local totalPlaybrand = 0
    local totalChangeBrand = 0
    local totalDisbrand = 0
    local totalPropsBrand = 0
    local frequentBrandtype = 0
    local frequentBrandtypeCount = 0
    for key, value in pairs(this.brandTypesByID) do
        local validTimes = value:GetValidTimes()
        if frequentBrandtypeCount < validTimes then
            frequentBrandtypeCount = validTimes
            frequentBrandtype = key
        end
    end
    local allRound = BalatroStepMgr.GetAllPhaseData()
    for _, roundDatas in pairs(allRound) do
        for _, roundData in pairs(roundDatas) do
            totalPlaybrand = totalPlaybrand + roundData:GetPlaycardTimes()
            totalChangeBrand = totalChangeBrand + roundData:GetChangeForeverTimes()
            totalDisbrand = totalDisbrand + roundData:GetDiscardTimes()
            totalPropsBrand = totalPropsBrand + roundData:GetUsePropsBrandTimes()
        end
    end
    this.statisticsData.totalPlaybrand = totalPlaybrand
    this.statisticsData.totalChangeBrand = totalChangeBrand
    this.statisticsData.totalDisbrand = totalDisbrand
    this.statisticsData.totalPropsBrand = totalPropsBrand
    local _, phaseNum = BalatroStepMgr.GetCurPhaseData()
    local curRound = BalatroStepMgr.GetCurRoundData()
    this.statisticsData.phaseNum = phaseNum
    this.statisticsData.totalRound = curRound:GetRound()
    this.statisticsData.frequentBrandtype = frequentBrandtype
    this.statisticsData.frequentBrandtypeCount = frequentBrandtypeCount
end

BalatroDataMgr.GetAllPhaseRecord = function()
    local tbl = {}
    local allRound = BalatroStepMgr.GetAllPhaseData()
    for _, roundDatas in pairs(allRound) do
        for _, roundData in pairs(roundDatas) do
            table.insert(tbl, roundData:GetAllRecord())
        end
    end
    local globalSceneData = BalatroStepMgr.GetGlobalSceneEffect()
    table.insert(tbl, string.format("GlobalScene %s(%d)", globalSceneData:GetName(), globalSceneData:GetID()))
    return json.encode(tbl)
end

BalatroDataMgr.GetStatisticsData = function()
    return this.statisticsData
end





BalatroDataMgr.GetGeneralBrandConfig = function(id)
    return this.generalBrandsConfig[id]
end

BalatroDataMgr.GetPropsBrandConfig = function(id)
    return this.propsBrandsConfigDic[id]
end






BalatroDataMgr.InitGeneralBrands = function()
    for key, configData in pairs(ConfigMgr.Config.GeneralBrandList) do
        if configData then
            local brandData = BalatroGeneralBrandData.New(configData)
            table.insert(this.generalBrands1, brandData)
            this.generalBrandsConfig[configData.ID] = configData
            this.generalBrandIDCount[configData.ID] = 1
        end
    end
    BalatroDataMgr.ShuffleBrand(this.generalBrands1)
end




BalatroDataMgr.NewGeneralBrand = function(configData)
    if this.generalBrandIDCount[configData.ID] == nil then
        LuaDebug.error("BalatroDataMgr.NewGeneralBrand ： configData ID is Invalid")
    end
    this.generalBrandIDCount[configData.ID] = this.generalBrandIDCount[configData.ID] + 1
    local brandData = BalatroGeneralBrandData.New(configData, this.generalBrandIDCount[configData.ID])
    return brandData
end


BalatroDataMgr.InitBalatroBrand = function()
    local archivesData = PlayerBalatroMgr.GetArchivesData()
    local selectBrandDatas = archivesData and archivesData.SelectBrands
    this.usingBalatroBrandsLst = {}
    this.usingBalatroBrandsDic = {}

    local tempBalatroBrandDic = {}
    for key, configData in pairs(ConfigMgr.Config.BalatroList) do
        if configData then
            local brandData = BalatroData.New(configData)
            local uid = configData.ID * 10000
            brandData:SetUID(uid)
            if configData.CanDrop == 1 then
                brandData:SetOwnStatus(BalatroUtil.BalatroOwnStatus.Old)
            else
                brandData:SetOwnStatus(BalatroUtil.BalatroOwnStatus.None)
            end
            table.insert(this.balatroBrands, brandData)
            local idStr = string.format("General_%d", uid)
            if selectBrandDatas and selectBrandDatas[idStr] then
                brandData:SetSelected(selectBrandDatas[idStr].IsSelect)
                if selectBrandDatas[idStr].IsSelect == true then
                    this.usingBalatroBrandsDic[uid] = brandData
                end
            end
            tempBalatroBrandDic[uid] = brandData
        end
    end
    local ownerBrandIds = DataMgr.Player.Balatro.DropRecords
    if ownerBrandIds ~= nil and type(ownerBrandIds) == "table" then
        for key, value in pairs(ownerBrandIds) do
            local uid = key * 10000
            local brandData = tempBalatroBrandDic[uid]
            if brandData ~= nil then
                brandData:SetOwnStatus(BalatroUtil.BalatroOwnStatus.Old)
            else
                LuaDebug.error("BalatroDataMgr.InitBalatroBrand 数据异常：" .. key .. "|" .. value)
            end
        end
    end
    this.usingBalatroBrandsLst = {}
    for key, value in pairs(this.usingBalatroBrandsDic) do
        table.insert(this.usingBalatroBrandsLst, value)
    end
    table.sort(this.usingBalatroBrandsLst, BalatroUtil.SortBalatroBrand)
end


BalatroDataMgr.InitPropBrand = function()
    this.propsTotalWeight = 0
    for key, configData in pairs(ConfigMgr.Config.BalatroPropsList) do
        if configData then
            this.propsBrandsConfigDic[configData.ID] = configData
            this.propsTotalWeight = this.propsTotalWeight + (configData.Weight or 0)
            table.insert(this.propsCumulativeWeights, this.propsTotalWeight)
            table.insert(this.propsBrandsConfigs, configData)
        end
    end
end


BalatroDataMgr.InitBrandType = function()
    for key, configData in pairs(ConfigMgr.Config.BrandTypeList) do
        local brandTypeData = BalatroBrandTypeData.New(configData)
        this.brandTypesByID[configData.ID] = brandTypeData
        this.brandTypesByType[configData.Type] = brandTypeData
    end
end


BalatroDataMgr.InitLevelData = function()
    for key, configData in pairs(ConfigMgr.Config.BalatroPhaseDataList) do
        if not this.levelDatas[configData.Group] then
            this.levelDatas[configData.Group] = {}
        end
        table.insert(this.levelDatas[configData.Group], configData)
    end
    BalatroStepMgr.InitRoundData(this.levelDatas[1])
end


BalatroDataMgr.InitSceneData = function()
    for key, configData in pairs(ConfigMgr.Config.BalatroSceneList) do
        this.sceneEffectConfigDic[configData.ID] = configData
        if configData.SceneType == 1 then
            table.insert(this.sceneEffectIDTbl, configData.ID)
        end
    end
    local globalSceneData = BalatroStepMgr.GetGlobalSceneEffect()
    if globalSceneData == nil or globalSceneData:IsDirty() == true then
        BalatroDataMgr.SetGlobalSceneEffect()
    end
end

BalatroDataMgr.SetGlobalSceneEffect = function()
    local globalEffectCount = NumTool.GetLen(this.sceneEffectIDTbl)
    local randomIndex = math.random(1, globalEffectCount)
    local sceneID = this.sceneEffectIDTbl[randomIndex]
    if not this.sceneEffectConfigDic[sceneID] then
        LuaDebug.error(string.format("BalatroDataMgr.SetGlobalSceneEffect 随机索引：%d 场景ID: %s", randomIndex, tostring(sceneID)))
    end
    local sceneData = BalatroSceneData.New(this.sceneEffectConfigDic[sceneID])
    BalatroStepMgr.SetGlobalSceneEffect(sceneData)
end

BalatroDataMgr.GetSceneConfigByID = function(id)
    return this.sceneEffectConfigDic[id]
end

BalatroDataMgr.ShuffleBrand = function(brandLst)
    for i = #brandLst, 2, -1 do
        local j = math.random(1, i)
        brandLst[i], brandLst[j] = brandLst[j], brandLst[i]
    end
end

BalatroDataMgr.SetGameStartTime = function(time)
    this.gameStartTime = time
end

BalatroDataMgr.GetGameStartTime = function()
    return this.gameStartTime
end


BalatroDataMgr.ClearCouncil = function()
    this.statisticsData = {
totalScore = 0,
bestBrandScore = 0,
frequentBrandtype = 0,
frequentBrandtypeCount = 0,
totalPlaybrand = 0,
totalChangeBrand = 0,
totalDisbrand = 0,
totalPropsBrand = 0,
phaseNum = 0,
totalRound = 0,
        evaluateID = 0
    }
    for _, value in pairs(this.brandTypesByID) do
        value:Reset()
    end

    for key, value in pairs(this.balatroBrands) do
        value:Reset()
    end
    this.usedPropsBrands = {}
    BalatroDataMgr.ResetChooseBrand()
end


BalatroDataMgr.ClearOutSide = function()
end




BalatroDataMgr.ReportStatus = function()
end


BalatroDataMgr.RoundEnd = function()
    BalatroStepMgr.RoundEnd()
    BalatroDataMgr.AddDropBalatro()
end

BalatroDataMgr.AddDropBalatro = function()
    if #this.allDropBalatroBrand >= #ConfigMgr.Config.BalatroPhaseDataList then
        return
    end

    local tempDatas = {}
    for key, value in pairs(this.balatroBrands) do
        local rare = value:GetRare()
        if tempDatas[rare] == nil then
            tempDatas[rare] = {}
        end
        if value:GetOwnStatus() == BalatroUtil.BalatroOwnStatus.None then
            table.insert(tempDatas[rare], value)
        end
    end
    local exludeTbl = {}
    for key, value in pairs(tempDatas) do
        if #value == 0 then
            table.insert(exludeTbl, key)
        end
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local dropType = curRound:GetDropType(exludeTbl)
    if tempDatas[dropType] == nil or #tempDatas[dropType] == 0 then
        for key, value in pairs(tempDatas) do
            if #value > 0 then
                dropType = key
            end
        end
    end
    if #tempDatas[dropType] > 0 then
        local randomIndex = Shuffle(#tempDatas[dropType])[1]
        local randomData = tempDatas[dropType][randomIndex]
        if randomData == nil then

            return
        end
        randomData:SetOwnStatus(BalatroUtil.BalatroOwnStatus.New)
        local data = {
            DropIds = {tostring(randomData:GetID())}
        }
        local callback = function(result)
            local re = json.decode(result)
            if re.code == 0 then
                table.insert(this.allDropBalatroBrand, randomData)
            else
                LuaDebug.error("BalatroDataMgr.AddDropBalatro " .. tostring(table.tostring(data)))
            end
        end
        ApiMgr.Request("balatro/drop", data, true, callback, nil, true)
    end
end


BalatroDataMgr.CheckRedDot = function()
    if ActivityMgr.ActivityRuning(ActivityKey.BalatroBrand) == false then
        return
    end
    local rewardConfigs = ConfigMgr.Config.BalatroCharges
    local redCount = 0
    for key, configData in pairs(rewardConfigs) do
        if configData then
            local tempData = {}
            tempData.id = configData.Id
            tempData.condition = configData.Condition
            if DataMgr.Player.Balatro ~= nil and DataMgr.Player.Balatro.RewardRecords ~= nil and type(DataMgr.Player.Balatro.RewardRecords) ~= BalatroUtil.LuaDataType.Function and DataMgr.Player.Balatro.RewardRecords[tempData.id] ~= nil then
            elseif DataMgr.Player.Balatro ~= nil and DataMgr.Player.Balatro.TotalScore >= tempData.condition then
                redCount = redCount + 1
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("15053", redCount)
end




